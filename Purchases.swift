import StoreKit
import Magister
import Combine

final class Purchases: NSObject, ObservableObject, SKRequestDelegate, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    @Published private(set) var products = [SKProduct]()
    @Published private(set) var loading = true
    @Published private(set) var error: String?
    let beads = PassthroughSubject<[Session.Bead], Never>()
    private weak var request: SKProductsRequest?
    
    deinit {
        request?.cancel()
        SKPaymentQueue.default().remove(self)
    }
    
    func load() {
        SKPaymentQueue.default().add(self)

        let request = SKProductsRequest(productIdentifiers: .init(Item.allCases.map(\.rawValue)))
        request.delegate = self
        self.request = request
        request.start()
    }
    
    func productsRequest(_: SKProductsRequest, didReceive: SKProductsResponse) {
        DispatchQueue.main.async { [weak self] in
            self?.products = didReceive.products.sorted { $0.price.doubleValue < $1.price.doubleValue }
            self?.loading = false
        }
    }
    
    func paymentQueue(_: SKPaymentQueue, updatedTransactions: [SKPaymentTransaction]) {
        update(updatedTransactions)
    }
    
    func paymentQueue(_: SKPaymentQueue, removedTransactions: [SKPaymentTransaction]) {
        update(removedTransactions)
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_: SKPaymentQueue) {
        DispatchQueue.main.async { [weak self] in
            self?.loading = false
        }
    }
    
    func request(_: SKRequest, didFailWithError: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.error = didFailWithError.localizedDescription
        }
    }
    
    func paymentQueue(_: SKPaymentQueue, restoreCompletedTransactionsFailedWithError: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.error = restoreCompletedTransactionsFailedWithError.localizedDescription
        }
    }
    
    private func update(_ transactions: [SKPaymentTransaction]) {
        guard !transactions.contains(where: { $0.transactionState == .purchasing }) else { return }
        transactions.forEach { transation in
            switch transation.transactionState {
            case .failed:
                DispatchQueue.main.async { [weak self] in
                    self?.error = NSLocalizedString("Purchase failed", comment: "")
                }
            case .restored, .purchased:
                DispatchQueue.main.async { [weak self] in
                    self?.beads.send(Magister.Bead.make(tier: Item(rawValue: transation.payment.productIdentifier)!.tier)
                        .map { .init(selected: false, item: $0) })
                }
            default: break
            }
            SKPaymentQueue.default().finishTransaction(transation)
        }
        DispatchQueue.main.async { [weak self] in
            self?.loading = false
        }
    }
    
    func purchase(_ product: SKProduct) {
        DispatchQueue.main.async { [weak self] in
            self?.loading = true
            SKPaymentQueue.default().add(.init(product: product))
        }
    }
}

import StoreKit
import Magister
import Combine

final class Purchases: NSObject, SKRequestDelegate, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    let products = CurrentValueSubject<[(SKProduct, String)], Never>([])
    let loading = CurrentValueSubject<Bool, Never>(true)
    let error = CurrentValueSubject<String?, Never>(nil)
    let beads = PassthroughSubject<[Session.Bead], Never>()
    private weak var request: SKProductsRequest?
    
    
    override init() {
        super.init()
        SKPaymentQueue.default().add(self)
    }
    
    func load() {
        request?.cancel()

        guard products.value.isEmpty else { return }
        loading.value = true
        error.value = nil

        let request = SKProductsRequest(productIdentifiers: .init(Item.allCases.map(\.rawValue)))
        request.delegate = self
        self.request = request
        request.start()
    }
    
    func purchase(_ product: SKProduct) {
        DispatchQueue.main.async {
            self.loading.value = true
            SKPaymentQueue.default().add(.init(product: product))
        }
    }
    
    func paymentQueue(_: SKPaymentQueue, updatedTransactions: [SKPaymentTransaction]) {
        update(updatedTransactions)
    }
    
    func paymentQueue(_: SKPaymentQueue, removedTransactions: [SKPaymentTransaction]) {
        update(removedTransactions)
    }
    
    func paymentQueue(_: SKPaymentQueue, restoreCompletedTransactionsFailedWithError: Error) {
        DispatchQueue.main.async {
            self.error.value = restoreCompletedTransactionsFailedWithError.localizedDescription
        }
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_: SKPaymentQueue) {
        DispatchQueue.main.async {
            self.loading.value = false
        }
    }
    
    func productsRequest(_: SKProductsRequest, didReceive: SKProductsResponse) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyISOCode
        
        DispatchQueue.main.async {
            self.products.value = didReceive.products
                .sorted { $0.price.doubleValue < $1.price.doubleValue }
                .map {
                    formatter.locale = $0.priceLocale
                    return ($0, formatter.string(from: $0.price)!)
                }
            self.loading.value = false
            self.error.value = nil
        }
    }
    
    func request(_: SKRequest, didFailWithError: Error) {
        DispatchQueue.main.async {
            self.error.value = didFailWithError.localizedDescription
        }
    }
    
    private func update(_ transactions: [SKPaymentTransaction]) {
        guard !transactions.contains(where: { $0.transactionState == .purchasing }) else { return }
        transactions.forEach { transation in
            switch transation.transactionState {
            case .failed:
                DispatchQueue.main.async {
                    self.error.value = NSLocalizedString("Purchase failed", comment: "")
                }
            case .restored, .purchased:
                DispatchQueue.main.async {
                    self.beads.send(Magister.Bead.make(tier: Item(rawValue: transation.payment.productIdentifier)!.tier)
                        .map { .init(selected: false, item: $0) })
                }
            default: break
            }
            SKPaymentQueue.default().finishTransaction(transation)
        }
        DispatchQueue.main.async {
            self.loading.value = false
        }
    }
}

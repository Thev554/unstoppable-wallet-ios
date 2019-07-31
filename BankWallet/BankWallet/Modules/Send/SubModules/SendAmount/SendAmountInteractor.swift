class SendAmountInteractor {
    private let localStorage: ILocalStorage
    private let rateStorage: IRateStorage
    private let appConfigProvider: IAppConfigProvider

    init(appConfigProvider: IAppConfigProvider, localStorage: ILocalStorage, rateStorage: IRateStorage) {
        self.appConfigProvider = appConfigProvider
        self.localStorage = localStorage
        self.rateStorage = rateStorage
    }

}

extension SendAmountInteractor: ISendAmountInteractor {

    var defaultInputType: SendInputType {
        return localStorage.sendInputType ?? .coin
    }

    func set(inputType: SendInputType) {
        localStorage.sendInputType = inputType
    }

    func rate(coinCode: CoinCode, currencyCode: String) -> Rate? {
        return rateStorage.latestRate(coinCode: coinCode, currencyCode: currencyCode)
    }

    func decimal(coinDecimal: Int, inputType: SendInputType) -> Int {
        return inputType == .coin ? min(coinDecimal, appConfigProvider.maxDecimal) : appConfigProvider.fiatDecimal
    }

}

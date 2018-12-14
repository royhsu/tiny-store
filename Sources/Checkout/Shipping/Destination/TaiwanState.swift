//
//  TaiwanState.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/6.
//

// MARK: - TaiwanState

public enum TaiwanState: String, AddressState {

    case taipeiCity

    case tainanCity

    case yunlinCounty

    public var name: String {

        switch self {

        case .taipeiCity:

            return NSLocalizedString(
                "Taipei City",
                comment: ""
            )

        case .tainanCity:

            return NSLocalizedString(
                "Tainan City",
                comment: ""
            )

        case .yunlinCounty:

            return NSLocalizedString(
                "Yunlin County",
                comment: ""
            )

        }

    }

}

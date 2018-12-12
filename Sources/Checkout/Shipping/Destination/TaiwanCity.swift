//
//  TaiwanCity.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/6.
//

// MARK: - TaiwanCity

public enum TaiwanCity: String, AddressState {

    case taipei

    case tainan

    case yunlin

    public var name: String {

        switch self {

        case .taipei:

            return NSLocalizedString(
                "Taipei",
                comment: ""
            )

        case .tainan:

            return NSLocalizedString(
                "Tainan",
                comment: ""
            )

        case .yunlin:

            return NSLocalizedString(
                "Yunlin",
                comment: ""
            )

        }

    }

}

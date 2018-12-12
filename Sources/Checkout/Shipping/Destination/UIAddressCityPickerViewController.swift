//
//  UIAddressCityPickerViewController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/26.
//

// MARK: - UIAddressCityPickerViewController

public final class UIAddressCityPickerViewController: UIViewController {

    private final lazy var pickerView: UIPickerView = {

        let view = UIPickerView()

        view.backgroundColor = .white

        view.dataSource = self

        return view

    }()

    public final override func loadView() { view = pickerView }

    public final override func viewDidLoad() {

        super.viewDidLoad()

    }

}

// MARK: - UIPickerViewDataSource

extension UIAddressCityPickerViewController: UIPickerViewDataSource {

    public final func numberOfComponents(in pickerView: UIPickerView) -> Int { return 1 }

    public final func pickerView(
        _ pickerView: UIPickerView,
        numberOfRowsInComponent component: Int
    )
    -> Int { return 5 }

}

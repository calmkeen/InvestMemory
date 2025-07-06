//
//  bottomsheetTest.swift
//  InvestMemory
//
//  Created by calmkeen on 7/5/25.
//

import UIKit
import SnapKit

class BottomSheetViewController: UIViewController {
    
    private var bottomSheetViewTopConstraint: NSLayoutConstraint!
    private let bottomSheetHeight: CGFloat = 500
    
    // 상태 변수들
    private var selectedVideoMode: VideoMode = .normal
    private var alwaysOnEnabled: Bool = false
    private var startTime: String = "18H"
    private var endTime: String = "9H"
    
    enum VideoMode: Int, CaseIterable {
        case normal = 0
        case hdrInfinite = 1
        case hdr = 2
        
        var title: String {
            switch self {
            case .normal: return "Normal"
            case .hdrInfinite: return "HDR + Infinite Plate Capture"
            case .hdr: return "HDR"
            }
        }
        
        var isHDRMode: Bool {
            return self == .hdrInfinite || self == .hdr
        }
    }
     
    private let dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.7)
        view.alpha = 0.0
        return view
    }()
    
    private let bottomSheetView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        return view
    }()
    
    // UI 컴포넌트들
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Video Enhancing"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    private let hdrTimerLabel: UILabel = {
        let label = UILabel()
        label.text = "HDR Timer"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .systemGray
        return label
    }()
    
    private let alwaysOnContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let alwaysOnLabel: UILabel = {
        let label = UILabel()
        label.text = "Always On"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let alwaysOnSwitch: UISwitch = {
        let switchControl = UISwitch()
        switchControl.isOn = false
        return switchControl
    }()
    
    private let nightTimeContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let nightTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Night Time"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let startTimeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("18H", for: .normal)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let timeRangeLabel: UILabel = {
        let label = UILabel()
        label.text = "~"
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    private let endTimeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("9H", for: .normal)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "HDR is automatically turned on at night."
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemGray
        label.textAlignment = .center
        return label
    }()
    

       
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupGesture()
        setupTableView()
        setupActions()
        updateHDRTimerState()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showBottomSheet()
    }

    private func setupGesture() {
        let dimmedTap = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped(_:)))
        dimmedView.addGestureRecognizer(dimmedTap)
        dimmedView.isUserInteractionEnabled = true
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "VideoModeCell")
    }
    
    private func setupActions() {
        alwaysOnSwitch.addTarget(self, action: #selector(alwaysOnSwitchChanged), for: .valueChanged)
        startTimeButton.addTarget(self, action: #selector(startTimeButtonTapped), for: .touchUpInside)
        endTimeButton.addTarget(self, action: #selector(endTimeButtonTapped), for: .touchUpInside)
    }

    private func showBottomSheet() {
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom
        
        bottomSheetViewTopConstraint.constant = safeAreaHeight - bottomSheetHeight
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
            self.dimmedView.alpha = 1.0
            self.view.layoutIfNeeded()
        })
    }

    private func hideBottomSheetAndGoBack() {
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom
        
        bottomSheetViewTopConstraint.constant = safeAreaHeight + bottomPadding
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.dimmedView.alpha = 0.0
            self.view.layoutIfNeeded()
        }) { _ in
            if self.presentingViewController != nil {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
       
    private func setupUI() {
        view.addSubview(dimmedView)
        view.addSubview(bottomSheetView)
        
        // 바텀시트 내부 컴포넌트들 추가
        bottomSheetView.addSubview(titleLabel)
        bottomSheetView.addSubview(tableView)
        bottomSheetView.addSubview(hdrTimerLabel)
        bottomSheetView.addSubview(alwaysOnContainerView)
        bottomSheetView.addSubview(nightTimeContainerView)
        bottomSheetView.addSubview(descriptionLabel)
        
        // Always On 컨테이너 내부
        alwaysOnContainerView.addSubview(alwaysOnLabel)
        alwaysOnContainerView.addSubview(alwaysOnSwitch)
        
        // Night Time 컨테이너 내부
        nightTimeContainerView.addSubview(nightTimeLabel)
        nightTimeContainerView.addSubview(startTimeButton)
        nightTimeContainerView.addSubview(timeRangeLabel)
        nightTimeContainerView.addSubview(endTimeButton)
        
        setupLayout()
    }
       
    private func setupLayout() {
        // Dimmed View
        dimmedView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // Bottom Sheet View (초기 위치 설정)
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom
        let initialTopConstant = safeAreaHeight + bottomPadding
        
        bottomSheetViewTopConstraint = bottomSheetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: initialTopConstant)
        
        bottomSheetView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
        bottomSheetViewTopConstraint.isActive = true
        
        // 타이틀
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        // 테이블뷰
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(180)
        }
        
        // HDR Timer 라벨
        hdrTimerLabel.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        // Always On 컨테이너
        alwaysOnContainerView.snp.makeConstraints { make in
            make.top.equalTo(hdrTimerLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        alwaysOnLabel.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
        }
        
        alwaysOnSwitch.snp.makeConstraints { make in
            make.trailing.centerY.equalToSuperview()
        }
        
        // Night Time 컨테이너
        nightTimeContainerView.snp.makeConstraints { make in
            make.top.equalTo(alwaysOnContainerView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        nightTimeLabel.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
        }
        
        endTimeButton.snp.makeConstraints { make in
            make.trailing.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 60, height: 32))
        }
        
        timeRangeLabel.snp.makeConstraints { make in
            make.trailing.equalTo(endTimeButton.snp.leading).offset(-8)
            make.centerY.equalToSuperview()
            make.width.equalTo(20)
        }
        
        startTimeButton.snp.makeConstraints { make in
            make.trailing.equalTo(timeRangeLabel.snp.leading).offset(-8)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 60, height: 32))
        }
        
        // 설명 라벨
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nightTimeContainerView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    // MARK: - Actions
    @objc private func alwaysOnSwitchChanged() {
        alwaysOnEnabled = alwaysOnSwitch.isOn
        updateNightTimeState()
    }
    
    @objc private func startTimeButtonTapped() {
        showTimePicker(for: startTimeButton, currentTime: startTime) { [weak self] selectedTime in
            self?.startTime = selectedTime
            self?.startTimeButton.setTitle(selectedTime, for: .normal)
        }
    }
    
    @objc private func endTimeButtonTapped() {
        showTimePicker(for: endTimeButton, currentTime: endTime) { [weak self] selectedTime in
            self?.endTime = selectedTime
            self?.endTimeButton.setTitle(selectedTime, for: .normal)
        }
    }
    
    @objc private func dimmedViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        hideBottomSheetAndGoBack()
    }
    
    // MARK: - Helper Methods
    private func updateHDRTimerState() {
        let isEnabled = selectedVideoMode.isHDRMode
        
        hdrTimerLabel.textColor = isEnabled ? .label : .systemGray3
        alwaysOnLabel.textColor = isEnabled ? .label : .systemGray3
        alwaysOnSwitch.isEnabled = isEnabled
        
        updateNightTimeState()
    }
    
    private func updateNightTimeState() {
        let isHDREnabled = selectedVideoMode.isHDRMode
        let isAlwaysOff = !alwaysOnEnabled
        let isEnabled = isHDREnabled && isAlwaysOff
        
        nightTimeLabel.textColor = isEnabled ? .label : .systemGray3
        timeRangeLabel.textColor = isEnabled ? .label : .systemGray3
        startTimeButton.isEnabled = isEnabled
        endTimeButton.isEnabled = isEnabled
        startTimeButton.setTitleColor(isEnabled ? .label : .systemGray3, for: .normal)
        endTimeButton.setTitleColor(isEnabled ? .label : .systemGray3, for: .normal)
        descriptionLabel.textColor = isEnabled ? .systemGray : .systemGray3
    }
    
    private func showTimePicker(for button: UIButton, currentTime: String, completion: @escaping (String) -> Void) {
        // 커스텀 모달 뷰 컨트롤러 생성
        let timePickerVC = UIViewController()
        timePickerVC.modalPresentationStyle = .pageSheet
        timePickerVC.view.backgroundColor = .systemBackground
        
        // 시트 사이즈 조정
        if let sheet = timePickerVC.sheetPresentationController {
            sheet.detents = [.custom { _ in
                return self.bottomSheetHeight
            }]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 10
        }
        
        // 타이틀 라벨
        let titleLabel = UILabel()
        titleLabel.text = "시간 선택"
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textAlignment = .center
        
        // 타임피커
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.locale = Locale.current
        
        // 현재 시간 설정
        let hour = Int(currentTime.replacingOccurrences(of: "H", with: "")) ?? 18
        let calendar = Calendar.current
        let date = calendar.date(bySettingHour: hour, minute: 0, second: 0, of: Date()) ?? Date()
        timePicker.date = date
        
        // 버튼 컨테이너
        let buttonContainer = UIView()
        
        // 취소 버튼
        let cancelButton = UIButton(type: .system)
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.titleLabel?.font = .systemFont(ofSize: 16)
        cancelButton.setTitleColor(.systemRed, for: .normal)
        
        // 확인 버튼
        let confirmButton = UIButton(type: .system)
        confirmButton.setTitle("확인", for: .normal)
        confirmButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        confirmButton.setTitleColor(.systemBlue, for: .normal)
        
        // 버튼 액션 (클로저로 간단하게)
        cancelButton.addAction(UIAction { _ in
            timePickerVC.dismiss(animated: true)
        }, for: .touchUpInside)
        
        confirmButton.addAction(UIAction { _ in
            let formatter = DateFormatter()
            formatter.dateFormat = "H"
            let hourString = formatter.string(from: timePicker.date)
            completion("\(hourString)H")
            timePickerVC.dismiss(animated: true)
        }, for: .touchUpInside)
        
        // 뷰에 추가
        timePickerVC.view.addSubview(titleLabel)
        timePickerVC.view.addSubview(timePicker)
        timePickerVC.view.addSubview(buttonContainer)
        buttonContainer.addSubview(cancelButton)
        buttonContainer.addSubview(confirmButton)
        
        // SnapKit으로 레이아웃 설정
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(timePickerVC.view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalTo(timePickerVC.view).inset(20)
        }
        
        timePicker.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalTo(timePickerVC.view).inset(20)
            make.height.equalTo(200) // 고정 높이로 설정
        }
        
        buttonContainer.snp.makeConstraints { make in
            make.top.equalTo(timePicker.snp.bottom).offset(20)
            make.leading.trailing.equalTo(timePickerVC.view).inset(20)
            make.height.equalTo(50)
            make.bottom.lessThanOrEqualTo(timePickerVC.view.safeAreaLayoutGuide).offset(-20)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.leading.centerY.equalTo(buttonContainer)
            make.width.equalTo(80)
            make.height.equalTo(44)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.trailing.centerY.equalTo(buttonContainer)
            make.width.equalTo(80)
            make.height.equalTo(44)
        }
        
        present(timePickerVC, animated: true)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension BottomSheetViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return VideoMode.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoModeCell", for: indexPath)
        let mode = VideoMode.allCases[indexPath.row]
        
        cell.textLabel?.text = mode.title
        cell.selectionStyle = .none
        
        if mode == selectedVideoMode {
            cell.accessoryType = .checkmark
            cell.tintColor = .systemBlue
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedVideoMode = VideoMode.allCases[indexPath.row]
        tableView.reloadData()
        updateHDRTimerState()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

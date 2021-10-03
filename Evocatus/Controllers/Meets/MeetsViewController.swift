//
//  MeetViewController.swift
//  Evocatus
//
//  Created by Boris Sobolev on 02.10.2021.
//

import UIKit

class MeetViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    private var myEvents: [Event] = []
    private var events: [Event] = []

    private var categoryFilter: FilterItem.Kind?
    private var dateFilter: DateSelectorItem.Kind?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor(hex: "F5F5FA")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorColor = .clear
        tableView.register(MeetsTableViewCell.self, forCellReuseIdentifier: MeetsTableViewCell.identifier)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        refreshData()
    }

    func refreshData() {
        APIService.requestEvents { [weak self] result in
            guard let self = self else { return }
            if case let .success(message) = result {
                self.events = message.other
                self.myEvents = message.employee
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    @IBAction func filtersButtonAction(_ sender: Any) {
        let vc = FiltersViewController(
            preselectedFilterItem: categoryFilter,
            preselectedDateItem: dateFilter,
            saveHandler: { [weak self] categoryFilter, dateFilter in
            if let self = self {
                self.categoryFilter = categoryFilter
                self.dateFilter = dateFilter
                self.tableView.reloadData()
            }
        })
        present(vc, animated: true, completion: nil)
    }

    @IBAction func newEventsButtonAction(_ sender: Any) {
        let vc = NewEvents()
        vc.callback = { [weak self] in
            self?.refreshData()
        }
        present(vc, animated: true, completion: nil)
    }

    lazy var filter: (Event) -> Bool = { event in
        var isIncluded = true
        if let categoryFilter = self.categoryFilter {
            isIncluded = categoryFilter == event.category
        }
        if let dateFilter = self.dateFilter {
            let calendar = Calendar.current
            switch dateFilter {
            case .today:
                isIncluded = calendar.isDateInToday(event.dttm.iso8601Date)
            case .tomorrow:
                isIncluded = calendar.isDateInTomorrow(event.dttm.iso8601Date)
            case .thisWeek:
                let week = calendar.dateComponents([.weekOfMonth], from: Date()).weekOfMonth!
                let eventWeek = calendar.dateComponents([.weekOfMonth], from: event.dttm.iso8601Date).weekOfMonth!
                isIncluded = week == eventWeek
            }
        }
        return isIncluded
    }
}

extension MeetViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int { 2 }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Мои заявки"
        } else if section == 1 {
            return "Сегодня"
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return myEvents.count
        } else if section == 1 {
            return events
                .filter(filter)
                .count
        } else {
            return 0
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(
            withIdentifier: MeetsTableViewCell.identifier,
            for: indexPath
        ) as! MeetsTableViewCell

        if indexPath.section == 0 {
            let event = myEvents[indexPath.row]
            cell.configure(
                event: event,
                isChecked: false,
                buttonHandler: { [weak self] in
                    APIService.deleteMyEvent(
                        employee: String(APIService.authenticatedEmployeeId),
                        activityId: String(event.id)
                    ) { [weak self] error in
                        if let error = error {
                            print(error)
//                            assertionFailure()
                        } else {
                            self?.refreshData()
                        }
                    }
                }
            )
        } else if indexPath.section == 1 {
            let event = events[indexPath.row]
            cell.configure(
                event: event,
                isChecked: true,
                buttonHandler: { [weak self] in
                    APIService.likeEvent(
                        employee: APIService.authenticatedEmployeeId,
                        activityId: event.id) { [weak self] error in
                            if let error = error {
                                print(error)
//                                assertionFailure()
                            } else {
                                self?.refreshData()
                            }
                        }
                }
            )
        }

        return cell
    }
}

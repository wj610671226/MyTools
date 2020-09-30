//
//  WJRefreshTool.swift
//  PrecisionPoverty
//
//  Created by jhtwl on 16/4/18.
//  Copyright © 2016年 jhtwl. All rights reserved.
//

import UIKit
import MJRefresh

protocol WJRefresh {
    func addRefreshing(tableView: UITableView, target: AnyObject, refreshingAction: Selector)
    func endRefreshing(tableView: UITableView)
}

extension WJRefresh {
    func addRefreshing(tableView: UITableView, target: AnyObject, refreshingAction: Selector) {
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: target, refreshingAction: refreshingAction)
        tableView.mj_footer = MJRefreshBackFooter(refreshingTarget: target, refreshingAction: refreshingAction)
        tableView.mj_header?.beginRefreshing()
    }
    
    func endRefreshing(tableView: UITableView) {
        tableView.mj_footer?.endRefreshing()
        tableView.mj_header?.endRefreshing()
    }
}

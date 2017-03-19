//
//  ViewController.swift
//  DropdownListCell
//
//  Created by Noriko TANAKA on 19/03/2017.
//  Copyright © 2017 apps0309. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	var tableView = UITableView()
	let statusBarHeight = UIApplication.shared.statusBarFrame.height
	let sectionArray = ["Section1", "Section2", "Section3"]
	let cellArray = [
		["S1C1", "S1C2", "S1C3"],
		["S2C1", "S2C2", "S2C3", "S2C4"],
		["S3C1", "S3C2", "S3C3", "S3C4", "S3C5"]
	]
	var isShowing = [false, false, false]
	var selectedIndex = [0, 0, 0]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.view.backgroundColor = UIColor.white
		
		// create table view
		self.tableView.frame = CGRect(
			x: 0,
			y: self.statusBarHeight,
			width: self.view.frame.width,
			height: self.view.frame.height - self.statusBarHeight
		)
		
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.tableFooterView = UIView()
		self.view.addSubview(self.tableView)
	}
	
	override func viewWillAppear(_ animated: Bool) {
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	// MARK: - UITableViewDataSource
	func numberOfSections(in tableView: UITableView) -> Int {
		return self.sectionArray.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if !self.isShowing[section] {
			return 1;
		} else {
			return self.cellArray[section].count
		}
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return self.sectionArray[section]
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let id = "cell"
		var cell = tableView.dequeueReusableCell(withIdentifier: id)
		if cell == nil {
			cell = UITableViewCell(style: .default, reuseIdentifier: id)
		}
		
		if !self.isShowing[indexPath.section] {
			cell?.textLabel?.text = self.cellArray[indexPath.section][self.selectedIndex[indexPath.section]]
			cell?.accessoryType = .disclosureIndicator
		} else {
			cell?.textLabel?.text = self.cellArray[indexPath.section][indexPath.row]
			if indexPath.row == self.selectedIndex[indexPath.section] {
				cell?.accessoryType = .checkmark
			} else {
				cell?.accessoryType = .none
			}
		}
		
		return cell!
	}
	
	
	// MARK: - UITableViewDelegate
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		//tableView.deselectRow(at: indexPath, animated: true)
		if self.isShowing[indexPath.section] {
			self.selectedIndex[indexPath.section] = indexPath.row
		}
		self.isShowing[indexPath.section] = !self.isShowing[indexPath.section]
		tableView.reloadSections(IndexSet(integer: indexPath.section), with: .fade)
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 48
	}
	
	func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
	}
}


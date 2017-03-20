//
//  DropDownView.swift
//  DropDownViewDemo
//
//  Created by zhuxuhong on 2017/3/17.
//  Copyright © 2017年 zhuxuhong. All rights reserved.
//

import UIKit


class ActionSheetView: UIView {
// MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewBottomCons: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeightCons: NSLayoutConstraint!

    
// MARK: - properties
    var callbackForCellDidSelect: ((_ index: Int) -> Void)?
    
    private var maxHeight: CGFloat = 240{
        didSet{
            tableViewHeightCons.constant = maxHeight
            animate(isShow: true)
        }
    }
    
    var items = [String](){
        didSet{
            // 适应高度
            maxHeight = min(maxHeight, CGFloat(items.count * 44))
            tableView.reloadData()
        }
    }
    
// MARK: - initial method
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
// MARK: - lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }

// MARK: - action & IBOutletAction
    @IBAction func actionOfGestureDidTrigger(_ sender: UIGestureRecognizer){
        cancel()
    }
    
    
// MARK: - private method
    private static func viewFromXib() -> ActionSheetView{
        let v = Bundle.main.loadNibNamed("ActionSheetView", owner: nil, options: nil)?.first as! ActionSheetView
        
        return v
    }
    
    private func animate(isShow: Bool){
        tableViewBottomCons.constant = isShow ? 0 : -maxHeight
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
            self.layoutIfNeeded()
            
        }) { (finished) in
            if !isShow {
                self.removeFromSuperview()
            }
        }
    }
    
    func cancel(){
        animate(isShow: false)
    }
    
// MARK: - getters
    
// MARK: - setters
    
// MARK: - delegate method
    
// MARK: - public method
    public static func show(items: [String],
                       completion: ((_ index: Int) -> Void)?){
        
        let v = ActionSheetView.viewFromXib()
        let window = UIApplication.shared.keyWindow!
        window.addSubview(v)
        v.frame = window.bounds
        v.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        v.items = items
        v.callbackForCellDidSelect = completion
    }
}

extension ActionSheetView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00000001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00000001
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let callback = callbackForCellDidSelect else {
            return
        }
        
        callback(indexPath.row)
        cancel()
    }
}

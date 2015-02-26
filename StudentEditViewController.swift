import UIKit

class StudentEditViewController: UITableViewController {
    
    let Cell = "Cell"
    
    var dataSource = SectionsArray()
    var student: Students!
    
    var nameTextField: UITextField!
    var placeTextField: UITextField!
    
    var saveBlock: ((student: Students) -> Void)?
    var cancelBlock: (() -> Void)?
    
    init(student: Students?) {
        super.init(nibName:nil, bundle:nil)
        self.title = "Students"
        
        if let _student = student {
            self.student = _student
            self.title = "Edit Student"
            
        }
        else {
            self.student = Students()
            self.title = "Add Student"
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder : aDecoder)
    }
    
    override func loadView() {
        self.tableView = UITableView( frame: UIScreen.mainScreen().bounds, style:.Grouped)
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let block = cancelBlock {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(
                barButtonSystemItem: .Cancel,
                target: self,
                action: "dismissAction:"
            )
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .Save,
            target: self,
            action: "saveAction:"
        )
        
        nameTextField = UITextField(frame: CGRectZero)
        nameTextField.textAlignment = .Left
        nameTextField.clearButtonMode = .WhileEditing
        nameTextField.clearButtonMode = .WhileEditing
        nameTextField.keyboardType = UIKeyboardType.Default
        nameTextField.returnKeyType = .Done
        nameTextField.backgroundColor = UIColor.whiteColor()
        nameTextField.textColor = UIColor.darkGrayColor()
        nameTextField.contentVerticalAlignment = .Center
        nameTextField.adjustsFontSizeToFitWidth = true
        nameTextField.minimumFontSize = 14.0
        nameTextField.autocapitalizationType = .None
        nameTextField.autocorrectionType = .No
        nameTextField.placeholder = "enter name"
        
        placeTextField = UITextField(frame: CGRectZero)
        placeTextField.textAlignment = .Left
        placeTextField.clearButtonMode = .WhileEditing
        placeTextField.clearButtonMode = .WhileEditing
        placeTextField.keyboardType = UIKeyboardType.Default
        placeTextField.returnKeyType = .Done
        placeTextField.backgroundColor = UIColor.whiteColor()
        placeTextField.textColor = UIColor.darkGrayColor()
        placeTextField.contentVerticalAlignment = .Center
        placeTextField.adjustsFontSizeToFitWidth = true
        placeTextField.minimumFontSize = 14.0
        placeTextField.autocapitalizationType = .None
        placeTextField.autocorrectionType = .No
        placeTextField.placeholder = "enter name"
        
        nameTextField.text = student.name
        placeTextField.text = student.college
        
        updateDataSource()
        
        
    }
    
    func updateDataSource() {
        
        var dictionary = Content()
        var sections = SectionsArray()
        var rows = RowsArray()
        
        dictionary = ["type" : "view", "text" : "Name", "view" : nameTextField]
        rows.append(Rows(content: dictionary))
        
        dictionary = ["type" : "view", "text" : "Place", "view" : placeTextField]
        rows.append(Rows(content: dictionary))
        
        sections.append(Sections(title: nil, rows: rows))
        dataSource = sections
        
    }
    
    // MARK: Selector Methods
    
    func saveAction(sender: AnyObject?) {
        self.view.endEditing(true)
        
        let nameStr  = self.nameTextField.text ?? String()
        let placeStr = self.placeTextField.text ?? String()
        
        if nameStr.isEmpty {
            let alertController = UIAlertController(title: "Barbero", message: "missing data", preferredStyle: .Alert)
            let alertAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            alertController.addAction(alertAction)
            self.navigationController!.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        
        self.student.name = nameStr
        self.student.college = placeStr
        
        if let block = saveBlock {
            block(student:self.student)
        }
        
    }
    
    func dismissAction(sender: AnyObject?) {
        if let block = cancelBlock {
            block()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].rows.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let row = dataSource[indexPath.section].rows[indexPath.row]
        let cellType = row.content["type"] as? String ?? String()
        
        if cellType == "view" {
            var cell = UITableViewCell(style:  .Value1, reuseIdentifier: Cell) as UITableViewCell!
            if cell == nil {
                cell = UITableViewCell(style: .Default, reuseIdentifier: Cell)
                cell.textLabel!.font = UIFont.systemFontOfSize(15.0)
                cell.detailTextLabel!.font = UIFont.systemFontOfSize(15.0)
            }
            
            let contentSize = tableView.frame.size
            let contentWidth = contentSize.width - 30.0
            let accessoryWidth = contentWidth - 120.0
            
            let accessoryView = row.content["view"] as UIView!
            accessoryView.frame = CGRectMake(0.0, 0.0, accessoryWidth, 34.0)
            
            cell.textLabel!.text = row.content["text"] as String!
            cell.accessoryView = accessoryView
            
            cell.selectionStyle = .None
            
            return cell
        }
        
        return UITableViewCell(style: .Default, reuseIdentifier: nil)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}


import UIKit

class StudentsViewController: UITableViewController {
    
    let Cell = "Cell"
    
    var dataSource = SectionsArray()
    var students = studentArray()
    
    override init() {
        super.init(nibName:nil, bundle:nil)
        
        self.title = "Students"
        
        for i in 0..<10 {
            let student = Students()
            student.name = "Xio"
            student.lastname = "Figueroa"
            student.college = "La IUPI"
            student.mayor = "CS"
            
            students.append(student)
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
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .Add,
            target: self,
            action: "addAction:"
        )
        
        updateDataSource()
    }
    
    func updateDataSource() {
        
        var dictionary = Content()
        var sections = SectionsArray()
        var rows = RowsArray()
        
        for student in students {
            dictionary = [ "type": "detail", "text":student.name, "detail": student.college]
            rows.append(Rows(content: dictionary))
            
        }
        
        sections.append(Sections(title: nil, rows: rows))
        dataSource = sections
        
    }
    
    // MARK: Selector Methods
    
    func addAction(sender: AnyObject?) {
        let editController = StudentEditViewController(student: nil)
        
        editController.saveBlock = { [unowned self] (student) in
            self.students.append(student)
            self.updateDataSource()
            self.navigationController!.dismissViewControllerAnimated(true, completion: nil)
        }
        
        
        editController.cancelBlock = { [unowned self] () in
            self.navigationController!.dismissViewControllerAnimated(true, completion: nil)
        }
        
        let navController = UINavigationController(rootViewController: editController)
        self.navigationController!.presentViewController(navController, animated: true, completion: nil)
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
        
        if cellType == "detail" {
            var cell = UITableViewCell(style:  .Value1, reuseIdentifier: Cell) as UITableViewCell!
            if cell == nil {
                cell = UITableViewCell(style: .Value1, reuseIdentifier: Cell)
                cell.textLabel!.font = UIFont.systemFontOfSize(15.0)
                cell.detailTextLabel!.font = UIFont.systemFontOfSize(15.0)
            }
            
            cell.textLabel!.text = row.content["text"] as String!
            cell.detailTextLabel!.text = row.content["detail"] as String!
            
            cell.selectionStyle = .Default
            cell.accessoryType = .DisclosureIndicator
            
            return cell
        }
        
        return UITableViewCell(style: .Default, reuseIdentifier: nil)
    }
}
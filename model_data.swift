import Foundation

typealias studentArray = [Students]

class Students {
    
    var name  : String!
    var lastname : String!
    var college : String!
    var mayor : String!
    
    init() {
        
    }
}

// MARK: - Table Structure

typealias Content = [String: Any]
typealias SectionsArray = [Sections]
typealias RowsArray = [Rows]

struct Sections {
    var identifier: String?
    var title: String?
    var footer: String?
    var rows = RowsArray()
    
    init(title: String?, rows: RowsArray) {
        self.title = title
        self.rows = rows
    }
}

struct Rows {
    var identifier: String?
    var content = Content()
    var allowNavigation = false
    
    init(content: Content) {
        self.content = content
    }
    
    init(content: Content, allowNavigation: Bool) {
        self.content = content
        self.allowNavigation = allowNavigation
    }
}



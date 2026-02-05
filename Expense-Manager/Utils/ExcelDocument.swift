//
//  ExcelDocument.swift
//  Expense-Manager
//
//  Created by Harshit on 2/4/26.
//

import Foundation
import UniformTypeIdentifiers
import SwiftUI

struct ExcelDocument: FileDocument {
    static var readableContentTypes: [UTType] { [.json] } // Use .xlsx or .csv as appropriate
    static var writableContentTypes: [UTType] { [.spreadsheet] }

    var data: Data?
    
    init(configuration: ReadConfiguration) throws {
        let data = configuration.file.regularFileContents
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        guard let data else { return .init() }
        return FileWrapper(regularFileWithContents: data)
    }
}

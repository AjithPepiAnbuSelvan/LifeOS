import Foundation
import SwiftData

@Model
final class DocumentItem {
    @Attribute(.unique) var id: UUID
    var createdAt: Date

    var title: String
    var type: String          // e.g. "Passport", "Contract", "Warranty"

    var tags: [String]
    var notes: String?

    var fileName: String?
    var fileSizeInBytes: Int?
    var fileExtension: String?

    var isSensitive: Bool
    var expiresAt: Date?

    init(
        id: UUID = UUID(),
        createdAt: Date = Date(),
        title: String,
        type: String,
        tags: [String] = [],
        notes: String? = nil,
        fileName: String? = nil,
        fileSizeInBytes: Int? = nil,
        fileExtension: String? = nil,
        isSensitive: Bool = false,
        expiresAt: Date? = nil
    ) {
        self.id = id
        self.createdAt = createdAt
        self.title = title
        self.type = type
        self.tags = tags
        self.notes = notes
        self.fileName = fileName
        self.fileSizeInBytes = fileSizeInBytes
        self.fileExtension = fileExtension
        self.isSensitive = isSensitive
        self.expiresAt = expiresAt
    }
}

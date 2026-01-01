-- ============================================
-- Complaint & Issue Management Tables
-- ============================================

-- Table 28: complaint_categories (Master data for complaint categories)
CREATE TABLE complaint_categories (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    category_code VARCHAR(50) NOT NULL UNIQUE COMMENT 'Category code',
    category_name VARCHAR(255) NOT NULL COMMENT 'Category name',
    description TEXT NULL COMMENT 'Category description',
    
    -- Audit fields
    status VARCHAR(50) DEFAULT 'active' COMMENT 'Record status',
    is_enable TINYINT(1) DEFAULT 1 COMMENT 'Enable/disable flag',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation timestamp',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update timestamp',
    created_by BIGINT UNSIGNED NULL COMMENT 'User who created the record',
    updated_by BIGINT UNSIGNED NULL COMMENT 'User who last updated the record',
    deleted_by BIGINT UNSIGNED NULL COMMENT 'User who soft-deleted the record',
    deleted_at TIMESTAMP NULL COMMENT 'Soft delete timestamp',
    
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL,
    
    INDEX idx_category_code (category_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert default complaint categories
INSERT INTO complaint_categories (category_code, category_name, description) VALUES
('tampering', 'Tampering', 'Vote tampering or ballot manipulation'),
('corruption', 'Corruption', 'Corruption or bribery allegations'),
('misconduct', 'Misconduct', 'Misconduct by officials or candidates'),
('other', 'Other', 'Other complaints');

-- Table 29: complaint_against_types (Master data for entity types complaints can be against)
CREATE TABLE complaint_against_types (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    type_code VARCHAR(50) NOT NULL UNIQUE COMMENT 'Type code',
    type_name VARCHAR(255) NOT NULL COMMENT 'Type name',
    description TEXT NULL COMMENT 'Type description',
    
    -- Audit fields
    status VARCHAR(50) DEFAULT 'active' COMMENT 'Record status',
    is_enable TINYINT(1) DEFAULT 1 COMMENT 'Enable/disable flag',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation timestamp',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update timestamp',
    created_by BIGINT UNSIGNED NULL COMMENT 'User who created the record',
    updated_by BIGINT UNSIGNED NULL COMMENT 'User who last updated the record',
    deleted_by BIGINT UNSIGNED NULL COMMENT 'User who soft-deleted the record',
    deleted_at TIMESTAMP NULL COMMENT 'Soft delete timestamp',
    
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL,
    
    INDEX idx_type_code (type_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert default complaint against types
INSERT INTO complaint_against_types (type_code, type_name, description) VALUES
('polling-officer', 'Polling Officer', 'Complaint against a polling officer'),
('candidate', 'Candidate', 'Complaint against a candidate'),
('election-commission', 'Election Commission', 'Complaint against election commission'),
('election-agent', 'Election Agent', 'Complaint against an election agent'),
('system', 'System', 'Complaint about system/process'),
('other', 'Other', 'Other types of complaints');

-- Table 30: complaints (Complaint registrations)
CREATE TABLE complaints (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    complaint_title VARCHAR(100) NOT NULL COMMENT 'Complaint title',
    description TEXT NOT NULL COMMENT 'Detailed complaint description',
    filed_by_user_id BIGINT UNSIGNED NULL COMMENT 'User who filed the complaint',
    filed_by_role VARCHAR(50) NULL COMMENT 'Role of the person who filed (User, PollingOfficer, etc.)',
    against_type_id BIGINT UNSIGNED NOT NULL COMMENT 'Reference to complaint_against_types table',
    against_name VARCHAR(100) NULL COMMENT 'Name of person/entity complaint is against',
    election_id BIGINT UNSIGNED NOT NULL COMMENT 'Reference to elections table',
    category_id BIGINT UNSIGNED NOT NULL COMMENT 'Reference to complaint_categories table',
    complaint_status ENUM('pending', 'under-investigation', 'resolved', 'rejected') DEFAULT 'pending' COMMENT 'Complaint status',
    priority ENUM('low', 'medium', 'high', 'urgent') DEFAULT 'medium' COMMENT 'Complaint priority',
    
    -- Audit fields
    status VARCHAR(50) DEFAULT 'active' COMMENT 'Record status',
    is_enable TINYINT(1) DEFAULT 1 COMMENT 'Enable/disable flag',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation timestamp',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update timestamp',
    created_by BIGINT UNSIGNED NULL COMMENT 'User who created the record',
    updated_by BIGINT UNSIGNED NULL COMMENT 'User who last updated the record',
    deleted_by BIGINT UNSIGNED NULL COMMENT 'User who soft-deleted the record',
    deleted_at TIMESTAMP NULL COMMENT 'Soft delete timestamp',
    
    FOREIGN KEY (filed_by_user_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (against_type_id) REFERENCES complaint_against_types(id) ON DELETE RESTRICT,
    FOREIGN KEY (election_id) REFERENCES elections(id) ON DELETE RESTRICT,
    FOREIGN KEY (category_id) REFERENCES complaint_categories(id) ON DELETE RESTRICT,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL,
    
    INDEX idx_filed_by_user (filed_by_user_id),
    INDEX idx_election_id (election_id),
    INDEX idx_category_id (category_id),
    INDEX idx_against_type (against_type_id),
    INDEX idx_complaint_status (complaint_status),
    INDEX idx_priority (priority),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 31: complaint_status_history (Audit trail for complaint status changes)
CREATE TABLE complaint_status_history (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    complaint_id BIGINT UNSIGNED NOT NULL COMMENT 'Reference to complaints table',
    old_status ENUM('pending', 'under-investigation', 'resolved', 'rejected') NULL COMMENT 'Previous status',
    new_status ENUM('pending', 'under-investigation', 'resolved', 'rejected') NOT NULL COMMENT 'New status',
    changed_by_user_id BIGINT UNSIGNED NULL COMMENT 'User who changed the status',
    change_notes TEXT NULL COMMENT 'Notes about status change',
    change_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'When status was changed',
    
    -- Audit fields
    status VARCHAR(50) DEFAULT 'active' COMMENT 'Record status',
    is_enable TINYINT(1) DEFAULT 1 COMMENT 'Enable/disable flag',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation timestamp',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update timestamp',
    created_by BIGINT UNSIGNED NULL COMMENT 'User who created the record',
    updated_by BIGINT UNSIGNED NULL COMMENT 'User who last updated the record',
    deleted_by BIGINT UNSIGNED NULL COMMENT 'User who soft-deleted the record',
    deleted_at TIMESTAMP NULL COMMENT 'Soft delete timestamp',
    
    FOREIGN KEY (complaint_id) REFERENCES complaints(id) ON DELETE CASCADE,
    FOREIGN KEY (changed_by_user_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL,
    
    INDEX idx_complaint_id (complaint_id),
    INDEX idx_change_timestamp (change_timestamp)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 32: complaint_resolutions (Resolution details for complaints)
CREATE TABLE complaint_resolutions (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    complaint_id BIGINT UNSIGNED NOT NULL UNIQUE COMMENT 'Reference to complaints table',
    resolution_details TEXT NOT NULL COMMENT 'Detailed resolution information',
    resolved_by_user_id BIGINT UNSIGNED NULL COMMENT 'User who resolved the complaint',
    resolution_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'When complaint was resolved',
    action_taken TEXT NULL COMMENT 'Actions taken to resolve',
    satisfaction_rating TINYINT UNSIGNED NULL COMMENT 'Satisfaction rating (1-5)',
    
    -- Audit fields
    status VARCHAR(50) DEFAULT 'active' COMMENT 'Record status',
    is_enable TINYINT(1) DEFAULT 1 COMMENT 'Enable/disable flag',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation timestamp',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update timestamp',
    created_by BIGINT UNSIGNED NULL COMMENT 'User who created the record',
    updated_by BIGINT UNSIGNED NULL COMMENT 'User who last updated the record',
    deleted_by BIGINT UNSIGNED NULL COMMENT 'User who soft-deleted the record',
    deleted_at TIMESTAMP NULL COMMENT 'Soft delete timestamp',
    
    FOREIGN KEY (complaint_id) REFERENCES complaints(id) ON DELETE CASCADE,
    FOREIGN KEY (resolved_by_user_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL,
    
    INDEX idx_complaint_id (complaint_id),
    INDEX idx_resolution_date (resolution_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 33: complaint_assignments (Assignment of complaints to investigators)
CREATE TABLE complaint_assignments (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    complaint_id BIGINT UNSIGNED NOT NULL COMMENT 'Reference to complaints table',
    assigned_to_user_id BIGINT UNSIGNED NOT NULL COMMENT 'User assigned to investigate',
    assigned_by_user_id BIGINT UNSIGNED NULL COMMENT 'User who made the assignment',
    assignment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'When complaint was assigned',
    is_current TINYINT(1) DEFAULT 1 COMMENT 'Is this the current assignment',
    assignment_notes TEXT NULL COMMENT 'Notes about the assignment',
    
    -- Audit fields
    status VARCHAR(50) DEFAULT 'active' COMMENT 'Record status',
    is_enable TINYINT(1) DEFAULT 1 COMMENT 'Enable/disable flag',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation timestamp',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update timestamp',
    created_by BIGINT UNSIGNED NULL COMMENT 'User who created the record',
    updated_by BIGINT UNSIGNED NULL COMMENT 'User who last updated the record',
    deleted_by BIGINT UNSIGNED NULL COMMENT 'User who soft-deleted the record',
    deleted_at TIMESTAMP NULL COMMENT 'Soft delete timestamp',
    
    FOREIGN KEY (complaint_id) REFERENCES complaints(id) ON DELETE CASCADE,
    FOREIGN KEY (assigned_to_user_id) REFERENCES users(id) ON DELETE RESTRICT,
    FOREIGN KEY (assigned_by_user_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL,
    
    INDEX idx_complaint_id (complaint_id),
    INDEX idx_assigned_to (assigned_to_user_id),
    INDEX idx_is_current (is_current),
    INDEX idx_assignment_date (assignment_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 34: complaint_evidence (Evidence/attachments for complaints)
CREATE TABLE complaint_evidence (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    complaint_id BIGINT UNSIGNED NOT NULL COMMENT 'Reference to complaints table',
    evidence_type ENUM('document', 'image', 'video', 'audio', 'other') NOT NULL COMMENT 'Type of evidence',
    evidence_url VARCHAR(500) NOT NULL COMMENT 'URL/path to evidence file',
    evidence_description TEXT NULL COMMENT 'Description of evidence',
    uploaded_by_user_id BIGINT UNSIGNED NULL COMMENT 'User who uploaded evidence',
    upload_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'When evidence was uploaded',
    
    -- Audit fields
    status VARCHAR(50) DEFAULT 'active' COMMENT 'Record status',
    is_enable TINYINT(1) DEFAULT 1 COMMENT 'Enable/disable flag',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation timestamp',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update timestamp',
    created_by BIGINT UNSIGNED NULL COMMENT 'User who created the record',
    updated_by BIGINT UNSIGNED NULL COMMENT 'User who last updated the record',
    deleted_by BIGINT UNSIGNED NULL COMMENT 'User who soft-deleted the record',
    deleted_at TIMESTAMP NULL COMMENT 'Soft delete timestamp',
    
    FOREIGN KEY (complaint_id) REFERENCES complaints(id) ON DELETE CASCADE,
    FOREIGN KEY (uploaded_by_user_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL,
    
    INDEX idx_complaint_id (complaint_id),
    INDEX idx_evidence_type (evidence_type),
    INDEX idx_upload_date (upload_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 35: polling_officer_incidents (Incidents reported by polling officers - normalized)
CREATE TABLE polling_officer_incidents (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    polling_officer_id BIGINT UNSIGNED NOT NULL COMMENT 'Reference to polling_officers table',
    complaint_id BIGINT UNSIGNED NOT NULL COMMENT 'Reference to complaints table',
    incident_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'When incident was recorded',
    
    -- Audit fields
    status VARCHAR(50) DEFAULT 'active' COMMENT 'Record status',
    is_enable TINYINT(1) DEFAULT 1 COMMENT 'Enable/disable flag',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation timestamp',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update timestamp',
    created_by BIGINT UNSIGNED NULL COMMENT 'User who created the record',
    updated_by BIGINT UNSIGNED NULL COMMENT 'User who last updated the record',
    deleted_by BIGINT UNSIGNED NULL COMMENT 'User who soft-deleted the record',
    deleted_at TIMESTAMP NULL COMMENT 'Soft delete timestamp',
    
    FOREIGN KEY (polling_officer_id) REFERENCES polling_officers(id) ON DELETE CASCADE,
    FOREIGN KEY (complaint_id) REFERENCES complaints(id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL,
    
    UNIQUE KEY unique_officer_complaint (polling_officer_id, complaint_id),
    INDEX idx_polling_officer_id (polling_officer_id),
    INDEX idx_complaint_id (complaint_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 36: election_agent_observations (Observations made by election agents - normalized)
CREATE TABLE election_agent_observations (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    election_agent_id BIGINT UNSIGNED NOT NULL COMMENT 'Reference to election_agents table',
    complaint_id BIGINT UNSIGNED NOT NULL COMMENT 'Reference to complaints table',
    observation_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'When observation was recorded',
    
    -- Audit fields
    status VARCHAR(50) DEFAULT 'active' COMMENT 'Record status',
    is_enable TINYINT(1) DEFAULT 1 COMMENT 'Enable/disable flag',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation timestamp',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update timestamp',
    created_by BIGINT UNSIGNED NULL COMMENT 'User who created the record',
    updated_by BIGINT UNSIGNED NULL COMMENT 'User who last updated the record',
    deleted_by BIGINT UNSIGNED NULL COMMENT 'User who soft-deleted the record',
    deleted_at TIMESTAMP NULL COMMENT 'Soft delete timestamp',
    
    FOREIGN KEY (election_agent_id) REFERENCES election_agents(id) ON DELETE CASCADE,
    FOREIGN KEY (complaint_id) REFERENCES complaints(id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL,
    
    UNIQUE KEY unique_agent_complaint (election_agent_id, complaint_id),
    INDEX idx_election_agent_id (election_agent_id),
    INDEX idx_complaint_id (complaint_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

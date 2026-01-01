-- ============================================
-- Candidate & Party Tables
-- ============================================

-- Table 14: parties (Political parties)
CREATE TABLE parties (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE COMMENT 'Party name (uppercase)',
    symbol VARCHAR(500) NOT NULL COMMENT 'Party symbol/logo URL',
    founder VARCHAR(255) NOT NULL UNIQUE COMMENT 'Party founder name',
    created_by_user_id BIGINT UNSIGNED NOT NULL COMMENT 'User who created the party',
    approved_by_commission_id BIGINT UNSIGNED NULL COMMENT 'Election commission member who approved',
    approval_status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending' COMMENT 'Party approval status',
    
    -- Audit fields
    status VARCHAR(50) DEFAULT 'active' COMMENT 'Record status',
    is_enable TINYINT(1) DEFAULT 1 COMMENT 'Enable/disable flag',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation timestamp',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update timestamp',
    created_by BIGINT UNSIGNED NULL COMMENT 'User who created the record',
    updated_by BIGINT UNSIGNED NULL COMMENT 'User who last updated the record',
    deleted_by BIGINT UNSIGNED NULL COMMENT 'User who soft-deleted the record',
    deleted_at TIMESTAMP NULL COMMENT 'Soft delete timestamp',
    
    FOREIGN KEY (created_by_user_id) REFERENCES users(id) ON DELETE RESTRICT,
    FOREIGN KEY (approved_by_commission_id) REFERENCES election_commission_members(id) ON DELETE SET NULL,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL,
    
    UNIQUE KEY unique_party_founder (name, founder),
    INDEX idx_name (name),
    INDEX idx_approval_status (approval_status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 15: positions (Master data for electoral positions)
CREATE TABLE positions (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    position_code VARCHAR(10) NOT NULL UNIQUE COMMENT 'Position code (NA, PP, PS, PB, PK)',
    position_name VARCHAR(100) NOT NULL COMMENT 'Full position name',
    position_type ENUM('national', 'provincial') NOT NULL COMMENT 'Position type',
    province VARCHAR(100) NULL COMMENT 'Province (Punjab=PP, Sindh=PS, Balochistan=PB, KPK=PK)',
    
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
    
    INDEX idx_position_code (position_code),
    INDEX idx_position_type (position_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert default positions
INSERT INTO positions (position_code, position_name, position_type, province) VALUES
('NA', 'National Assembly', 'national', NULL),
('PP', 'Provincial Assembly Punjab', 'provincial', 'Punjab'),
('PS', 'Provincial Assembly Sindh', 'provincial', 'Sindh'),
('PB', 'Provincial Assembly Balochistan', 'provincial', 'Balochistan'),
('PK', 'Provincial Assembly Khyber Pakhtunkhwa', 'provincial', 'Khyber Pakhtunkhwa');

-- Table 16: party_positions (Positions that parties contest - many to many)
CREATE TABLE party_positions (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    party_id BIGINT UNSIGNED NOT NULL COMMENT 'Reference to parties table',
    position_id BIGINT UNSIGNED NOT NULL COMMENT 'Reference to positions table',
    
    -- Audit fields
    status VARCHAR(50) DEFAULT 'active' COMMENT 'Record status',
    is_enable TINYINT(1) DEFAULT 1 COMMENT 'Enable/disable flag',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation timestamp',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update timestamp',
    created_by BIGINT UNSIGNED NULL COMMENT 'User who created the record',
    updated_by BIGINT UNSIGNED NULL COMMENT 'User who last updated the record',
    deleted_by BIGINT UNSIGNED NULL COMMENT 'User who soft-deleted the record',
    deleted_at TIMESTAMP NULL COMMENT 'Soft delete timestamp',
    
    FOREIGN KEY (party_id) REFERENCES parties(id) ON DELETE CASCADE,
    FOREIGN KEY (position_id) REFERENCES positions(id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL,
    
    UNIQUE KEY unique_party_position (party_id, position_id),
    INDEX idx_party_id (party_id),
    INDEX idx_position_id (position_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 17: candidates (Candidate registrations)
CREATE TABLE candidates (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL UNIQUE COMMENT 'Reference to users table',
    election_id BIGINT UNSIGNED NOT NULL COMMENT 'Reference to elections table',
    party_id BIGINT UNSIGNED NOT NULL COMMENT 'Reference to parties table',
    position_id BIGINT UNSIGNED NOT NULL COMMENT 'Reference to positions table',
    approved_by_commission_id BIGINT UNSIGNED NULL COMMENT 'Election commission member who approved',
    rejection_reason TEXT NULL COMMENT 'Reason for rejection if rejected',
    candidate_status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending' COMMENT 'Candidate approval status',
    
    -- Audit fields
    status VARCHAR(50) DEFAULT 'active' COMMENT 'Record status',
    is_enable TINYINT(1) DEFAULT 1 COMMENT 'Enable/disable flag',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation timestamp',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update timestamp',
    created_by BIGINT UNSIGNED NULL COMMENT 'User who created the record',
    updated_by BIGINT UNSIGNED NULL COMMENT 'User who last updated the record',
    deleted_by BIGINT UNSIGNED NULL COMMENT 'User who soft-deleted the record',
    deleted_at TIMESTAMP NULL COMMENT 'Soft delete timestamp',
    
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE RESTRICT,
    FOREIGN KEY (election_id) REFERENCES elections(id) ON DELETE RESTRICT,
    FOREIGN KEY (party_id) REFERENCES parties(id) ON DELETE RESTRICT,
    FOREIGN KEY (position_id) REFERENCES positions(id) ON DELETE RESTRICT,
    FOREIGN KEY (approved_by_commission_id) REFERENCES election_commission_members(id) ON DELETE SET NULL,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL,
    
    INDEX idx_user_id (user_id),
    INDEX idx_election_id (election_id),
    INDEX idx_party_id (party_id),
    INDEX idx_position_id (position_id),
    INDEX idx_candidate_status (candidate_status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 18: candidate_districts (Districts a candidate is contesting - many to many)
CREATE TABLE candidate_districts (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    candidate_id BIGINT UNSIGNED NOT NULL COMMENT 'Reference to candidates table',
    district_id BIGINT UNSIGNED NOT NULL COMMENT 'Reference to districts table',
    
    -- Audit fields
    status VARCHAR(50) DEFAULT 'active' COMMENT 'Record status',
    is_enable TINYINT(1) DEFAULT 1 COMMENT 'Enable/disable flag',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation timestamp',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update timestamp',
    created_by BIGINT UNSIGNED NULL COMMENT 'User who created the record',
    updated_by BIGINT UNSIGNED NULL COMMENT 'User who last updated the record',
    deleted_by BIGINT UNSIGNED NULL COMMENT 'User who soft-deleted the record',
    deleted_at TIMESTAMP NULL COMMENT 'Soft delete timestamp',
    
    FOREIGN KEY (candidate_id) REFERENCES candidates(id) ON DELETE CASCADE,
    FOREIGN KEY (district_id) REFERENCES districts(id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL,
    
    UNIQUE KEY unique_candidate_district (candidate_id, district_id),
    INDEX idx_candidate_id (candidate_id),
    INDEX idx_district_id (district_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 19: document_types (Master data for required documents)
CREATE TABLE document_types (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    document_code VARCHAR(50) NOT NULL UNIQUE COMMENT 'Document type code',
    document_name VARCHAR(255) NOT NULL COMMENT 'Document type name',
    description TEXT NULL COMMENT 'Document description',
    is_required TINYINT(1) DEFAULT 1 COMMENT 'Is this document mandatory',
    
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
    
    INDEX idx_document_code (document_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert default document types
INSERT INTO document_types (document_code, document_name, description, is_required) VALUES
('nomination_form', 'Nomination Form', 'Official nomination form', 1),
('tax_return', 'Tax Return', 'Recent tax return documents', 1),
('affidavit', 'Affidavit', 'Sworn affidavit', 1),
('criminal_record', 'Criminal Record', 'Criminal record certificate', 1),
('party_letter', 'Party Letter', 'Party endorsement letter', 1);

-- Table 20: candidate_documents (Candidate submitted documents)
CREATE TABLE candidate_documents (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    candidate_id BIGINT UNSIGNED NOT NULL COMMENT 'Reference to candidates table',
    document_type_id BIGINT UNSIGNED NOT NULL COMMENT 'Reference to document_types table',
    document_url VARCHAR(500) NOT NULL COMMENT 'URL/path to the document',
    verification_status ENUM('pending', 'verified', 'rejected') DEFAULT 'pending' COMMENT 'Document verification status',
    verified_by_commission_id BIGINT UNSIGNED NULL COMMENT 'Commission member who verified',
    verification_notes TEXT NULL COMMENT 'Notes from verification',
    
    -- Audit fields
    status VARCHAR(50) DEFAULT 'active' COMMENT 'Record status',
    is_enable TINYINT(1) DEFAULT 1 COMMENT 'Enable/disable flag',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation timestamp',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update timestamp',
    created_by BIGINT UNSIGNED NULL COMMENT 'User who created the record',
    updated_by BIGINT UNSIGNED NULL COMMENT 'User who last updated the record',
    deleted_by BIGINT UNSIGNED NULL COMMENT 'User who soft-deleted the record',
    deleted_at TIMESTAMP NULL COMMENT 'Soft delete timestamp',
    
    FOREIGN KEY (candidate_id) REFERENCES candidates(id) ON DELETE CASCADE,
    FOREIGN KEY (document_type_id) REFERENCES document_types(id) ON DELETE RESTRICT,
    FOREIGN KEY (verified_by_commission_id) REFERENCES election_commission_members(id) ON DELETE SET NULL,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL,
    
    UNIQUE KEY unique_candidate_document (candidate_id, document_type_id),
    INDEX idx_candidate_id (candidate_id),
    INDEX idx_document_type_id (document_type_id),
    INDEX idx_verification_status (verification_status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 21: candidate_approvals (Candidate approval workflow history)
CREATE TABLE candidate_approvals (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    candidate_id BIGINT UNSIGNED NOT NULL COMMENT 'Reference to candidates table',
    old_status ENUM('pending', 'approved', 'rejected') NULL COMMENT 'Previous approval status',
    new_status ENUM('pending', 'approved', 'rejected') NOT NULL COMMENT 'New approval status',
    approved_by_commission_id BIGINT UNSIGNED NULL COMMENT 'Commission member who approved/rejected',
    decision_notes TEXT NULL COMMENT 'Notes for approval/rejection decision',
    decision_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'When decision was made',
    
    -- Audit fields
    status VARCHAR(50) DEFAULT 'active' COMMENT 'Record status',
    is_enable TINYINT(1) DEFAULT 1 COMMENT 'Enable/disable flag',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation timestamp',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update timestamp',
    created_by BIGINT UNSIGNED NULL COMMENT 'User who created the record',
    updated_by BIGINT UNSIGNED NULL COMMENT 'User who last updated the record',
    deleted_by BIGINT UNSIGNED NULL COMMENT 'User who soft-deleted the record',
    deleted_at TIMESTAMP NULL COMMENT 'Soft delete timestamp',
    
    FOREIGN KEY (candidate_id) REFERENCES candidates(id) ON DELETE CASCADE,
    FOREIGN KEY (approved_by_commission_id) REFERENCES election_commission_members(id) ON DELETE SET NULL,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL,
    
    INDEX idx_candidate_id (candidate_id),
    INDEX idx_decision_timestamp (decision_timestamp)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

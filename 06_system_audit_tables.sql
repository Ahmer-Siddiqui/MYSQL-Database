-- ============================================
-- System Audit & Utility Tables
-- ============================================

-- Table 37: audit_logs (System-wide audit trail for all significant actions)
CREATE TABLE audit_logs (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    table_name VARCHAR(100) NOT NULL COMMENT 'Table that was affected',
    record_id BIGINT UNSIGNED NOT NULL COMMENT 'ID of the affected record',
    action_type ENUM('CREATE', 'UPDATE', 'DELETE', 'SOFT_DELETE', 'RESTORE', 'LOGIN', 'LOGOUT', 'VOTE', 'APPROVAL', 'REJECTION', 'OTHER') NOT NULL COMMENT 'Type of action performed',
    action_description TEXT NULL COMMENT 'Detailed description of the action',
    old_values JSON NULL COMMENT 'Previous values before change (for UPDATE)',
    new_values JSON NULL COMMENT 'New values after change',
    performed_by_user_id BIGINT UNSIGNED NULL COMMENT 'User who performed the action',
    user_role VARCHAR(50) NULL COMMENT 'Role of user who performed action',
    ip_address VARCHAR(45) NULL COMMENT 'IP address of user',
    user_agent TEXT NULL COMMENT 'Browser/client user agent',
    action_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'When action occurred',
    
    -- Audit fields (minimal - this is the audit table itself)
    status VARCHAR(50) DEFAULT 'active' COMMENT 'Record status',
    is_enable TINYINT(1) DEFAULT 1 COMMENT 'Enable/disable flag',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation timestamp',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update timestamp',
    created_by BIGINT UNSIGNED NULL COMMENT 'User who created the record',
    updated_by BIGINT UNSIGNED NULL COMMENT 'User who last updated the record',
    deleted_by BIGINT UNSIGNED NULL COMMENT 'User who soft-deleted the record',
    deleted_at TIMESTAMP NULL COMMENT 'Soft delete timestamp',
    
    FOREIGN KEY (performed_by_user_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL,
    
    INDEX idx_table_name (table_name),
    INDEX idx_record_id (record_id),
    INDEX idx_action_type (action_type),
    INDEX idx_performed_by (performed_by_user_id),
    INDEX idx_action_timestamp (action_timestamp),
    INDEX idx_table_record (table_name, record_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 38: system_configurations (Application configuration and settings)
CREATE TABLE system_configurations (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    config_key VARCHAR(255) NOT NULL UNIQUE COMMENT 'Configuration key',
    config_value TEXT NOT NULL COMMENT 'Configuration value',
    config_type ENUM('string', 'number', 'boolean', 'json') DEFAULT 'string' COMMENT 'Value data type',
    description TEXT NULL COMMENT 'Configuration description',
    is_public TINYINT(1) DEFAULT 0 COMMENT 'Can this config be accessed publicly',
    modified_by_user_id BIGINT UNSIGNED NULL COMMENT 'Last user who modified this config',
    
    -- Audit fields
    status VARCHAR(50) DEFAULT 'active' COMMENT 'Record status',
    is_enable TINYINT(1) DEFAULT 1 COMMENT 'Enable/disable flag',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation timestamp',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update timestamp',
    created_by BIGINT UNSIGNED NULL COMMENT 'User who created the record',
    updated_by BIGINT UNSIGNED NULL COMMENT 'User who last updated the record',
    deleted_by BIGINT UNSIGNED NULL COMMENT 'User who soft-deleted the record',
    deleted_at TIMESTAMP NULL COMMENT 'Soft delete timestamp',
    
    FOREIGN KEY (modified_by_user_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL,
    
    INDEX idx_config_key (config_key),
    INDEX idx_is_public (is_public)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert default system configurations
INSERT INTO system_configurations (config_key, config_value, config_type, description, is_public) VALUES
('election_system_name', 'Pakistan Electronic Voting System', 'string', 'Name of the election system', 1),
('allow_registration', 'true', 'boolean', 'Allow new voter registrations', 1),
('voting_enabled', 'false', 'boolean', 'Global voting enable/disable flag', 1),
('max_candidates_per_position', '50', 'number', 'Maximum candidates allowed per position', 0),
('require_fingerprint_verification', 'true', 'boolean', 'Require fingerprint verification for voting', 0);

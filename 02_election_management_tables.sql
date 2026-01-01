-- ============================================
-- Election Management Tables
-- ============================================

-- Table 8: elections (Core election events)
CREATE TABLE elections (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL COMMENT 'Election title',
    description TEXT NULL COMMENT 'Election description',
    start_date DATETIME NOT NULL COMMENT 'Election start date and time',
    end_date DATETIME NOT NULL COMMENT 'Election end date and time',
    election_status ENUM('running', 'paused', 'completed', 'suspended') DEFAULT 'paused' COMMENT 'Current election status',
    created_by_admin_id BIGINT UNSIGNED NOT NULL COMMENT 'Admin who created the election',
    approved_by_commission_id BIGINT UNSIGNED NULL COMMENT 'Election commission member who approved',
    
    -- Audit fields
    status VARCHAR(50) DEFAULT 'active' COMMENT 'Record status',
    is_enable TINYINT(1) DEFAULT 1 COMMENT 'Enable/disable flag',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation timestamp',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update timestamp',
    created_by BIGINT UNSIGNED NULL COMMENT 'User who created the record',
    updated_by BIGINT UNSIGNED NULL COMMENT 'User who last updated the record',
    deleted_by BIGINT UNSIGNED NULL COMMENT 'User who soft-deleted the record',
    deleted_at TIMESTAMP NULL COMMENT 'Soft delete timestamp',
    
    FOREIGN KEY (created_by_admin_id) REFERENCES admins(id) ON DELETE RESTRICT,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL,
    
    UNIQUE KEY unique_election (title, description(100)),
    INDEX idx_election_status (election_status),
    INDEX idx_start_date (start_date),
    INDEX idx_end_date (end_date),
    INDEX idx_created_by_admin (created_by_admin_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 9: election_status_history (Audit trail for election status changes)
CREATE TABLE election_status_history (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    election_id BIGINT UNSIGNED NOT NULL COMMENT 'Reference to elections table',
    old_status ENUM('running', 'paused', 'completed', 'suspended') NULL COMMENT 'Previous status',
    new_status ENUM('running', 'paused', 'completed', 'suspended') NOT NULL COMMENT 'New status',
    reason TEXT NULL COMMENT 'Reason for status change',
    changed_by_user_id BIGINT UNSIGNED NULL COMMENT 'User who changed the status',
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
    
    FOREIGN KEY (election_id) REFERENCES elections(id) ON DELETE CASCADE,
    FOREIGN KEY (changed_by_user_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL,
    
    INDEX idx_election_id (election_id),
    INDEX idx_change_timestamp (change_timestamp)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 10: election_commission_members (Election commission staff)
CREATE TABLE election_commission_members (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL UNIQUE COMMENT 'Reference to users table',
    created_by_admin_id BIGINT UNSIGNED NOT NULL COMMENT 'Admin who created this commission member',
    commission_role VARCHAR(100) NULL COMMENT 'Role within election commission',
    
    -- Audit fields
    status VARCHAR(50) DEFAULT 'active' COMMENT 'Record status',
    is_enable TINYINT(1) DEFAULT 1 COMMENT 'Enable/disable flag',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation timestamp',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update timestamp',
    created_by BIGINT UNSIGNED NULL COMMENT 'User who created the record',
    updated_by BIGINT UNSIGNED NULL COMMENT 'User who last updated the record',
    deleted_by BIGINT UNSIGNED NULL COMMENT 'User who soft-deleted the record',
    deleted_at TIMESTAMP NULL COMMENT 'Soft delete timestamp',
    
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (created_by_admin_id) REFERENCES admins(id) ON DELETE RESTRICT,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL,
    
    INDEX idx_user_id (user_id),
    INDEX idx_created_by_admin (created_by_admin_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Alter elections table to add foreign key for election commission approval
ALTER TABLE elections
ADD FOREIGN KEY (approved_by_commission_id) REFERENCES election_commission_members(id) ON DELETE SET NULL;

-- Table 11: districts (Geographic administrative districts)
CREATE TABLE districts (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL COMMENT 'District name',
    city VARCHAR(255) NOT NULL COMMENT 'City name',
    province VARCHAR(100) NULL COMMENT 'Province (Sindh, Punjab, KPK, Balochistan)',
    created_by_commission_id BIGINT UNSIGNED NOT NULL COMMENT 'Election commission member who created',
    
    -- Audit fields
    status VARCHAR(50) DEFAULT 'active' COMMENT 'Record status',
    is_enable TINYINT(1) DEFAULT 1 COMMENT 'Enable/disable flag',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation timestamp',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update timestamp',
    created_by BIGINT UNSIGNED NULL COMMENT 'User who created the record',
    updated_by BIGINT UNSIGNED NULL COMMENT 'User who last updated the record',
    deleted_by BIGINT UNSIGNED NULL COMMENT 'User who soft-deleted the record',
    deleted_at TIMESTAMP NULL COMMENT 'Soft delete timestamp',
    
    FOREIGN KEY (created_by_commission_id) REFERENCES election_commission_members(id) ON DELETE RESTRICT,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL,
    
    UNIQUE KEY unique_district (name, city),
    INDEX idx_city (city),
    INDEX idx_province (province),
    INDEX idx_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 12: polling_stations (Polling locations)
CREATE TABLE polling_stations (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL COMMENT 'Polling station name',
    district_id BIGINT UNSIGNED NOT NULL COMMENT 'Reference to districts table',
    election_id BIGINT UNSIGNED NOT NULL COMMENT 'Reference to elections table',
    created_by_commission_id BIGINT UNSIGNED NOT NULL COMMENT 'Election commission member who created',
    station_status ENUM('active', 'inactive', 'suspended') DEFAULT 'inactive' COMMENT 'Station operational status',
    
    -- Audit fields
    status VARCHAR(50) DEFAULT 'active' COMMENT 'Record status',
    is_enable TINYINT(1) DEFAULT 1 COMMENT 'Enable/disable flag',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation timestamp',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update timestamp',
    created_by BIGINT UNSIGNED NULL COMMENT 'User who created the record',
    updated_by BIGINT UNSIGNED NULL COMMENT 'User who last updated the record',
    deleted_by BIGINT UNSIGNED NULL COMMENT 'User who soft-deleted the record',
    deleted_at TIMESTAMP NULL COMMENT 'Soft delete timestamp',
    
    FOREIGN KEY (district_id) REFERENCES districts(id) ON DELETE RESTRICT,
    FOREIGN KEY (election_id) REFERENCES elections(id) ON DELETE RESTRICT,
    FOREIGN KEY (created_by_commission_id) REFERENCES election_commission_members(id) ON DELETE RESTRICT,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL,
    
    INDEX idx_district_id (district_id),
    INDEX idx_election_id (election_id),
    INDEX idx_station_status (station_status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 13: polling_station_addresses (Normalized address data for polling stations)
CREATE TABLE polling_station_addresses (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    polling_station_id BIGINT UNSIGNED NOT NULL UNIQUE COMMENT 'Reference to polling_stations table',
    location VARCHAR(500) NOT NULL COMMENT 'Specific location/landmark',
    area VARCHAR(255) NOT NULL COMMENT 'Area/neighborhood',
    full_address TEXT NULL COMMENT 'Complete formatted address',
    latitude DECIMAL(10, 8) NULL COMMENT 'GPS latitude',
    longitude DECIMAL(11, 8) NULL COMMENT 'GPS longitude',
    
    -- Audit fields
    status VARCHAR(50) DEFAULT 'active' COMMENT 'Record status',
    is_enable TINYINT(1) DEFAULT 1 COMMENT 'Enable/disable flag',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation timestamp',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update timestamp',
    created_by BIGINT UNSIGNED NULL COMMENT 'User who created the record',
    updated_by BIGINT UNSIGNED NULL COMMENT 'User who last updated the record',
    deleted_by BIGINT UNSIGNED NULL COMMENT 'User who soft-deleted the record',
    deleted_at TIMESTAMP NULL COMMENT 'Soft delete timestamp',
    
    FOREIGN KEY (polling_station_id) REFERENCES polling_stations(id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL,
    
    INDEX idx_area (area),
    INDEX idx_location (location(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

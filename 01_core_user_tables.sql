-- ============================================
-- Core User & Authentication Tables
-- ============================================

-- Table 1: roles (Master data for user roles)
CREATE TABLE roles (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE COMMENT 'Role name (Voter, ElectionCommission, etc.)',
    role_description VARCHAR(255) NULL COMMENT 'Role description',
    
    -- Audit fields
    status VARCHAR(50) DEFAULT 'active' COMMENT 'Record status',
    is_enable TINYINT(1) DEFAULT 1 COMMENT 'Enable/disable flag',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation timestamp',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update timestamp',
    created_by BIGINT UNSIGNED NULL COMMENT 'User who created the record',
    updated_by BIGINT UNSIGNED NULL COMMENT 'User who last updated the record',
    deleted_by BIGINT UNSIGNED NULL COMMENT 'User who soft-deleted the record',
    deleted_at TIMESTAMP NULL COMMENT 'Soft delete timestamp',
    
    INDEX idx_role_name (role_name),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert default roles
INSERT INTO roles (role_name, role_description) VALUES
('Voter', 'Regular voter'),
('ElectionCommission', 'Election commission member'),
('ElectionAgent', 'Election agent/monitor'),
('Candidate', 'Election candidate'),
('PollingOfficer', 'Polling station officer');

-- Table 2: users (Base table for all users)
CREATE TABLE users (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    profile_pic VARCHAR(500) NULL COMMENT 'Profile picture URL',
    first_name VARCHAR(100) NOT NULL COMMENT 'First name',
    last_name VARCHAR(100) NOT NULL COMMENT 'Last name',
    age INT UNSIGNED NOT NULL COMMENT 'User age',
    date_of_birth DATE NOT NULL COMMENT 'Date of birth',
    cnic_number VARCHAR(20) NOT NULL UNIQUE COMMENT 'National ID card number',
    address TEXT NOT NULL COMMENT 'Residential address',
    email VARCHAR(255) NULL UNIQUE COMMENT 'Email address',
    password_hash VARCHAR(255) NULL COMMENT 'Hashed password',
    gender ENUM('male', 'female', 'other') DEFAULT 'male' COMMENT 'Gender',
    can_vote TINYINT(1) DEFAULT 1 COMMENT 'Voting eligibility flag',
    
    -- Audit fields
    status VARCHAR(50) DEFAULT 'active' COMMENT 'Record status',
    is_enable TINYINT(1) DEFAULT 1 COMMENT 'Enable/disable flag',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation timestamp',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update timestamp',
    created_by BIGINT UNSIGNED NULL COMMENT 'User who created the record',
    updated_by BIGINT UNSIGNED NULL COMMENT 'User who last updated the record',
    deleted_by BIGINT UNSIGNED NULL COMMENT 'User who soft-deleted the record',
    deleted_at TIMESTAMP NULL COMMENT 'Soft delete timestamp',
    
    INDEX idx_cnic (cnic_number),
    INDEX idx_email (email),
    INDEX idx_status (status),
    INDEX idx_can_vote (can_vote)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 3: user_contact_numbers (Normalized phone numbers)
CREATE TABLE user_contact_numbers (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL COMMENT 'Reference to users table',
    contact_number VARCHAR(20) NOT NULL COMMENT 'Phone number',
    contact_type ENUM('mobile', 'landline', 'emergency') DEFAULT 'mobile' COMMENT 'Contact type',
    is_primary TINYINT(1) DEFAULT 0 COMMENT 'Primary contact flag',
    
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
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL,
    
    INDEX idx_user_id (user_id),
    INDEX idx_contact_number (contact_number)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 4: user_roles (User role assignments - many to many)
CREATE TABLE user_roles (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL COMMENT 'Reference to users table',
    role_id BIGINT UNSIGNED NOT NULL COMMENT 'Reference to roles table',
    
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
    FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL,
    
    UNIQUE KEY unique_user_role (user_id, role_id),
    INDEX idx_user_id (user_id),
    INDEX idx_role_id (role_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 5: admins (Admin specific data)
CREATE TABLE admins (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NULL COMMENT 'Reference to users table (if admin is also a user)',
    profile VARCHAR(500) NULL COMMENT 'Admin profile picture',
    name VARCHAR(255) NOT NULL COMMENT 'Admin name',
    email VARCHAR(255) NOT NULL UNIQUE COMMENT 'Admin email',
    password_hash VARCHAR(255) NOT NULL COMMENT 'Hashed password',
    
    -- Audit fields
    status VARCHAR(50) DEFAULT 'active' COMMENT 'Record status',
    is_enable TINYINT(1) DEFAULT 1 COMMENT 'Enable/disable flag',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation timestamp',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update timestamp',
    created_by BIGINT UNSIGNED NULL COMMENT 'Admin who created the record',
    updated_by BIGINT UNSIGNED NULL COMMENT 'Admin who last updated the record',
    deleted_by BIGINT UNSIGNED NULL COMMENT 'Admin who soft-deleted the record',
    deleted_at TIMESTAMP NULL COMMENT 'Soft delete timestamp',
    
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
    
    INDEX idx_email (email),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 6: voter_verification (Voter biometric and device verification)
CREATE TABLE voter_verification (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL UNIQUE COMMENT 'Reference to users table',
    device_id VARCHAR(255) NULL UNIQUE COMMENT 'Device identifier',
    cnic_picture VARCHAR(500) NULL COMMENT 'CNIC photo URL',
    wallet_address VARCHAR(255) NULL UNIQUE COMMENT 'Blockchain wallet address',
    fingerprint_verified TINYINT(1) DEFAULT 0 COMMENT 'Fingerprint verification status',
    has_voted TINYINT(1) DEFAULT 0 COMMENT 'Voting status flag',
    is_voted TINYINT(1) DEFAULT 0 COMMENT 'Alternative voting status flag',
    
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
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL,
    
    INDEX idx_device_id (device_id),
    INDEX idx_wallet_address (wallet_address),
    INDEX idx_has_voted (has_voted)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 7: password_reset_tokens (Password reset management)
CREATE TABLE password_reset_tokens (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NULL COMMENT 'Reference to users table',
    admin_id BIGINT UNSIGNED NULL COMMENT 'Reference to admins table',
    token VARCHAR(500) NOT NULL COMMENT 'Reset token',
    expires_at TIMESTAMP NOT NULL COMMENT 'Token expiration time',
    used_at TIMESTAMP NULL COMMENT 'When token was used',
    is_valid TINYINT(1) DEFAULT 1 COMMENT 'Token validity flag',
    
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
    FOREIGN KEY (admin_id) REFERENCES admins(id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL,
    
    INDEX idx_token (token(255)),
    INDEX idx_expires_at (expires_at),
    INDEX idx_user_id (user_id),
    INDEX idx_admin_id (admin_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

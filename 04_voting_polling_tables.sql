-- ============================================
-- Voting & Polling Tables
-- ============================================

-- Table 22: voters (Voter registrations)
CREATE TABLE voters (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL UNIQUE COMMENT 'Reference to users table',
    election_id BIGINT UNSIGNED NULL COMMENT 'Reference to elections table',
    voter_registration_number VARCHAR(50) NULL UNIQUE COMMENT 'Unique voter registration number',
    
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
    FOREIGN KEY (election_id) REFERENCES elections(id) ON DELETE SET NULL,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL,
    
    INDEX idx_user_id (user_id),
    INDEX idx_election_id (election_id),
    INDEX idx_registration_number (voter_registration_number)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 23: voter_stations (Voter polling station assignments)
CREATE TABLE voter_stations (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    voter_id BIGINT UNSIGNED NOT NULL COMMENT 'Reference to voters table',
    polling_station_id BIGINT UNSIGNED NOT NULL COMMENT 'Reference to polling_stations table',
    election_id BIGINT UNSIGNED NOT NULL COMMENT 'Reference to elections table',
    assignment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'When voter was assigned to station',
    is_current TINYINT(1) DEFAULT 1 COMMENT 'Is this the current assignment',
    
    -- Audit fields
    status VARCHAR(50) DEFAULT 'active' COMMENT 'Record status',
    is_enable TINYINT(1) DEFAULT 1 COMMENT 'Enable/disable flag',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation timestamp',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update timestamp',
    created_by BIGINT UNSIGNED NULL COMMENT 'User who created the record',
    updated_by BIGINT UNSIGNED NULL COMMENT 'User who last updated the record',
    deleted_by BIGINT UNSIGNED NULL COMMENT 'User who soft-deleted the record',
    deleted_at TIMESTAMP NULL COMMENT 'Soft delete timestamp',
    
    FOREIGN KEY (voter_id) REFERENCES voters(id) ON DELETE CASCADE,
    FOREIGN KEY (polling_station_id) REFERENCES polling_stations(id) ON DELETE CASCADE,
    FOREIGN KEY (election_id) REFERENCES elections(id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL,
    
    INDEX idx_voter_id (voter_id),
    INDEX idx_polling_station_id (polling_station_id),
    INDEX idx_election_id (election_id),
    INDEX idx_is_current (is_current)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 24: polling_officers (Polling officer assignments)
CREATE TABLE polling_officers (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL UNIQUE COMMENT 'Reference to users table',
    election_id BIGINT UNSIGNED NOT NULL COMMENT 'Reference to elections table',
    polling_station_id BIGINT UNSIGNED NULL COMMENT 'Reference to polling_stations table',
    created_by_commission_id BIGINT UNSIGNED NOT NULL COMMENT 'Election commission member who created',
    officer_status ENUM('active', 'inactive', 'suspended') DEFAULT 'inactive' COMMENT 'Officer status',
    
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
    FOREIGN KEY (election_id) REFERENCES elections(id) ON DELETE RESTRICT,
    FOREIGN KEY (polling_station_id) REFERENCES polling_stations(id) ON DELETE SET NULL,
    FOREIGN KEY (created_by_commission_id) REFERENCES election_commission_members(id) ON DELETE RESTRICT,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL,
    
    INDEX idx_user_id (user_id),
    INDEX idx_election_id (election_id),
    INDEX idx_polling_station_id (polling_station_id),
    INDEX idx_officer_status (officer_status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 25: election_agents (Election agents/monitors)
CREATE TABLE election_agents (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL UNIQUE COMMENT 'Reference to users table',
    election_id BIGINT UNSIGNED NOT NULL COMMENT 'Reference to elections table',
    polling_station_id BIGINT UNSIGNED NULL COMMENT 'Reference to polling_stations table',
    assigned_by_candidate_id BIGINT UNSIGNED NOT NULL COMMENT 'Candidate who assigned this agent',
    agent_status ENUM('active', 'inactive', 'suspended') DEFAULT 'inactive' COMMENT 'Agent status',
    
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
    FOREIGN KEY (election_id) REFERENCES elections(id) ON DELETE RESTRICT,
    FOREIGN KEY (polling_station_id) REFERENCES polling_stations(id) ON DELETE SET NULL,
    FOREIGN KEY (assigned_by_candidate_id) REFERENCES candidates(id) ON DELETE RESTRICT,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL,
    
    UNIQUE KEY unique_agent_station_election (user_id, polling_station_id, election_id),
    INDEX idx_user_id (user_id),
    INDEX idx_election_id (election_id),
    INDEX idx_polling_station_id (polling_station_id),
    INDEX idx_assigned_by_candidate (assigned_by_candidate_id),
    INDEX idx_agent_status (agent_status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 26: votes (Individual vote records for audit/blockchain)
CREATE TABLE votes (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    voter_id BIGINT UNSIGNED NOT NULL COMMENT 'Reference to voters table',
    candidate_id BIGINT UNSIGNED NOT NULL COMMENT 'Reference to candidates table',
    election_id BIGINT UNSIGNED NOT NULL COMMENT 'Reference to elections table',
    polling_station_id BIGINT UNSIGNED NOT NULL COMMENT 'Reference to polling_stations table',
    position_id BIGINT UNSIGNED NOT NULL COMMENT 'Reference to positions table (NA or Provincial)',
    vote_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'When vote was cast',
    blockchain_tx_hash VARCHAR(255) NULL COMMENT 'Blockchain transaction hash',
    verification_hash VARCHAR(255) NULL COMMENT 'Vote verification hash',
    
    -- Audit fields
    status VARCHAR(50) DEFAULT 'active' COMMENT 'Record status',
    is_enable TINYINT(1) DEFAULT 1 COMMENT 'Enable/disable flag',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation timestamp',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update timestamp',
    created_by BIGINT UNSIGNED NULL COMMENT 'User who created the record',
    updated_by BIGINT UNSIGNED NULL COMMENT 'User who last updated the record',
    deleted_by BIGINT UNSIGNED NULL COMMENT 'User who soft-deleted the record',
    deleted_at TIMESTAMP NULL COMMENT 'Soft delete timestamp',
    
    FOREIGN KEY (voter_id) REFERENCES voters(id) ON DELETE RESTRICT,
    FOREIGN KEY (candidate_id) REFERENCES candidates(id) ON DELETE RESTRICT,
    FOREIGN KEY (election_id) REFERENCES elections(id) ON DELETE RESTRICT,
    FOREIGN KEY (polling_station_id) REFERENCES polling_stations(id) ON DELETE RESTRICT,
    FOREIGN KEY (position_id) REFERENCES positions(id) ON DELETE RESTRICT,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL,
    
    INDEX idx_voter_id (voter_id),
    INDEX idx_candidate_id (candidate_id),
    INDEX idx_election_id (election_id),
    INDEX idx_polling_station_id (polling_station_id),
    INDEX idx_position_id (position_id),
    INDEX idx_vote_timestamp (vote_timestamp),
    INDEX idx_blockchain_tx (blockchain_tx_hash)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 27: candidate_vote_counts (Aggregated vote counts - performance optimization)
CREATE TABLE candidate_vote_counts (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    candidate_id BIGINT UNSIGNED NOT NULL COMMENT 'Reference to candidates table',
    election_id BIGINT UNSIGNED NOT NULL COMMENT 'Reference to elections table',
    district_id BIGINT UNSIGNED NULL COMMENT 'Reference to districts table (for district-level counts)',
    polling_station_id BIGINT UNSIGNED NULL COMMENT 'Reference to polling_stations table (for station-level counts)',
    position_id BIGINT UNSIGNED NOT NULL COMMENT 'Reference to positions table',
    total_votes BIGINT UNSIGNED DEFAULT 0 COMMENT 'Total vote count',
    last_updated_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last count update',
    
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
    FOREIGN KEY (election_id) REFERENCES elections(id) ON DELETE CASCADE,
    FOREIGN KEY (district_id) REFERENCES districts(id) ON DELETE CASCADE,
    FOREIGN KEY (polling_station_id) REFERENCES polling_stations(id) ON DELETE CASCADE,
    FOREIGN KEY (position_id) REFERENCES positions(id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL,
    
    UNIQUE KEY unique_count_scope (candidate_id, election_id, district_id, polling_station_id, position_id),
    INDEX idx_candidate_id (candidate_id),
    INDEX idx_election_id (election_id),
    INDEX idx_district_id (district_id),
    INDEX idx_total_votes (total_votes)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

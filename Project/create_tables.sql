                -- =====================================================
                --      ELECTION MANAGEMENT SYSTEM - MySQL Database
                -- =====================================================

DROP DATABASE IF EXISTS election_management_system;
CREATE DATABASE election_management_system;
USE election_management_system;

-- =====================================================
-- TABLE CREATION (35 Tables)
-- =====================================================

-- 1. ADMINS
CREATE TABLE admins (
    id INT PRIMARY KEY AUTO_INCREMENT,
    profile VARCHAR(255),
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    status ENUM('active','inactive','suspended') DEFAULT 'active',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT, updated_by INT, deleted_by INT
);

-- 2. USERS
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    cnic_number VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE,
    status ENUM('active','inactive','suspended') DEFAULT 'active',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT, updated_by INT, deleted_by INT
);

-- 3. ROLES
CREATE TABLE roles (
    id INT PRIMARY KEY AUTO_INCREMENT,
    role_name VARCHAR(50) UNIQUE NOT NULL,
    description TEXT,
    status ENUM('active','inactive') DEFAULT 'active',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT, updated_by INT, deleted_by INT
);

-- 4. USER_ROLES
CREATE TABLE user_roles (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    role_id INT NOT NULL,
    status ENUM('active','inactive') DEFAULT 'active',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT, updated_by INT, deleted_by INT,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (role_id) REFERENCES roles(id)
);

-- 5. ELECTIONS
CREATE TABLE elections (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    election_code VARCHAR(20) UNIQUE,
    status ENUM('running','paused','completed','suspended') DEFAULT 'paused',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT, updated_by INT, deleted_by INT
);

-- 6. ELECTION_COMMISSION
CREATE TABLE election_commission (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT UNIQUE NOT NULL,
    commission_code VARCHAR(20),
    status ENUM('active','inactive') DEFAULT 'active',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT, updated_by INT, deleted_by INT,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- 7. CITIES
CREATE TABLE cities (
    id INT PRIMARY KEY AUTO_INCREMENT,
    city_name VARCHAR(100) UNIQUE NOT NULL,
    province VARCHAR(50),
    country VARCHAR(50) DEFAULT 'Pakistan',
    status ENUM('active','inactive') DEFAULT 'active',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT, updated_by INT, deleted_by INT
);

-- 8. DISTRICTS
CREATE TABLE districts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    district_name VARCHAR(100) NOT NULL,
    city_id INT NOT NULL,
    district_code VARCHAR(20),
    status ENUM('active','inactive') DEFAULT 'active',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT, updated_by INT, deleted_by INT,
    FOREIGN KEY (city_id) REFERENCES cities(id)
);

-- 9. POLLING_STATIONS
CREATE TABLE polling_stations (
    id INT PRIMARY KEY AUTO_INCREMENT,
    station_name VARCHAR(150) NOT NULL,
    location VARCHAR(200) NOT NULL,
    district_id INT NOT NULL,
    station_code VARCHAR(30),
    status ENUM('active','inactive','suspended') DEFAULT 'inactive',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT, updated_by INT, deleted_by INT,
    FOREIGN KEY (district_id) REFERENCES districts(id)
);

-- 10. POLITICAL_PARTIES
CREATE TABLE political_parties (
    id INT PRIMARY KEY AUTO_INCREMENT,
    party_name VARCHAR(100) UNIQUE NOT NULL,
    party_symbol VARCHAR(255),
    founder VARCHAR(100),
    party_code VARCHAR(20),
    status ENUM('active','inactive','banned') DEFAULT 'active',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT, updated_by INT, deleted_by INT
);

-- 11. POSITIONS
CREATE TABLE positions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    position_code VARCHAR(10) UNIQUE NOT NULL,
    position_name VARCHAR(100) NOT NULL,
    description TEXT,
    status ENUM('active','inactive') DEFAULT 'active',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT, updated_by INT, deleted_by INT
);

-- 12. CANDIDATES
CREATE TABLE candidates (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT UNIQUE NOT NULL,
    election_id INT NOT NULL,
    party_id INT NOT NULL,
    candidate_number VARCHAR(20),
    status ENUM('pending','approved','rejected') DEFAULT 'pending',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT, updated_by INT, deleted_by INT,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (election_id) REFERENCES elections(id),
    FOREIGN KEY (party_id) REFERENCES political_parties(id)
);

-- 13. DOCUMENT_TYPES
CREATE TABLE document_types (
    id INT PRIMARY KEY AUTO_INCREMENT,
    type_name VARCHAR(50) UNIQUE NOT NULL,
    description TEXT,
    type_code VARCHAR(20),
    status ENUM('active','inactive') DEFAULT 'active',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT, updated_by INT, deleted_by INT
);

-- 14. CANDIDATE_DOCUMENTS
CREATE TABLE candidate_documents (
    id INT PRIMARY KEY AUTO_INCREMENT,
    candidate_id INT NOT NULL,
    document_type_id INT NOT NULL,
    document_path VARCHAR(255) NOT NULL,
    document_number VARCHAR(50),
    status ENUM('verified','pending','rejected') DEFAULT 'pending',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT, updated_by INT, deleted_by INT,
    FOREIGN KEY (candidate_id) REFERENCES candidates(id),
    FOREIGN KEY (document_type_id) REFERENCES document_types(id)
);

-- 15. ELECTION_AGENTS
CREATE TABLE election_agents (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT UNIQUE NOT NULL,
    candidate_id INT NOT NULL,
    agent_code VARCHAR(30),
    status ENUM('active','inactive','suspended') DEFAULT 'inactive',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT, updated_by INT, deleted_by INT,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (candidate_id) REFERENCES candidates(id)
);

-- 16. POLLING_OFFICERS
CREATE TABLE polling_officers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT UNIQUE NOT NULL,
    station_id INT,
    officer_code VARCHAR(30),
    status ENUM('active','inactive','suspended') DEFAULT 'inactive',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT, updated_by INT, deleted_by INT,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (station_id) REFERENCES polling_stations(id)
);

-- 17. COMPLAINT_CATEGORIES
CREATE TABLE complaint_categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) UNIQUE NOT NULL,
    category_code VARCHAR(20),
    description TEXT,
    status ENUM('active','inactive') DEFAULT 'active',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT, updated_by INT, deleted_by INT
);

-- 18. COMPLAINTS
CREATE TABLE complaints (
    id INT PRIMARY KEY AUTO_INCREMENT,
    complaint_title VARCHAR(100) NOT NULL,
    complaint_number VARCHAR(30),
    election_id INT NOT NULL,
    category_id INT NOT NULL,
    status ENUM('pending','under-investigation','resolved','rejected') DEFAULT 'pending',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT, updated_by INT, deleted_by INT,
    FOREIGN KEY (election_id) REFERENCES elections(id),
    FOREIGN KEY (category_id) REFERENCES complaint_categories(id)
);

-- 19. VOTER_VERIFICATION
CREATE TABLE voter_verification (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT UNIQUE NOT NULL,
    device_id VARCHAR(100),
    verification_code VARCHAR(30),
    is_verified BOOLEAN DEFAULT FALSE,
    status ENUM('verified','pending','rejected') DEFAULT 'pending',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT, updated_by INT, deleted_by INT,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- 20. VOTES
CREATE TABLE votes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    voter_id INT NOT NULL,
    candidate_id INT NOT NULL,
    election_id INT NOT NULL,
    vote_hash VARCHAR(255),
    status ENUM('valid','invalid','disputed') DEFAULT 'valid',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT, updated_by INT, deleted_by INT,
    FOREIGN KEY (voter_id) REFERENCES users(id),
    FOREIGN KEY (candidate_id) REFERENCES candidates(id),
    FOREIGN KEY (election_id) REFERENCES elections(id)
);

-- 21. ELECTION_RESULTS
CREATE TABLE election_results (
    id INT PRIMARY KEY AUTO_INCREMENT,
    election_id INT NOT NULL,
    candidate_id INT NOT NULL,
    total_votes INT DEFAULT 0,
    result_code VARCHAR(30),
    status ENUM('provisional','final','contested') DEFAULT 'provisional',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT, updated_by INT, deleted_by INT,
    FOREIGN KEY (election_id) REFERENCES elections(id),
    FOREIGN KEY (candidate_id) REFERENCES candidates(id)
);

-- 22. AUDIT_LOGS
CREATE TABLE audit_logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    table_name VARCHAR(50) NOT NULL,
    action_type VARCHAR(20) NOT NULL,
    record_id INT NOT NULL,
    log_reference VARCHAR(50),
    status ENUM('success','failed') DEFAULT 'success',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT, updated_by INT, deleted_by INT
);

-- 23. NOTIFICATIONS
CREATE TABLE notifications (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    notification_type VARCHAR(50) NOT NULL,
    notification_code VARCHAR(30),
    title VARCHAR(150) NOT NULL,
    status ENUM('sent','pending','failed') DEFAULT 'pending',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT, updated_by INT, deleted_by INT,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- 24. SYSTEM_SETTINGS
CREATE TABLE system_settings (
    id INT PRIMARY KEY AUTO_INCREMENT,
    setting_key VARCHAR(100) UNIQUE NOT NULL,
    setting_value TEXT NOT NULL,
    setting_code VARCHAR(30),
    status ENUM('active','inactive') DEFAULT 'active',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT, updated_by INT, deleted_by INT
);

-- 25. ELECTION_PHASES
CREATE TABLE election_phases (
    id INT PRIMARY KEY AUTO_INCREMENT,
    election_id INT NOT NULL,
    phase_name VARCHAR(100) NOT NULL,
    phase_code VARCHAR(30),
    phase_order INT NOT NULL,
    status ENUM('upcoming','active','completed','cancelled') DEFAULT 'upcoming',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT, updated_by INT, deleted_by INT,
    FOREIGN KEY (election_id) REFERENCES elections(id)
);

-- 26. STATION_RESOURCES
CREATE TABLE station_resources (
    id INT PRIMARY KEY AUTO_INCREMENT,
    station_id INT NOT NULL,
    resource_name VARCHAR(100) NOT NULL,
    resource_code VARCHAR(30),
    quantity INT DEFAULT 1,
    status ENUM('available','in-use','damaged','missing') DEFAULT 'available',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT, updated_by INT, deleted_by INT,
    FOREIGN KEY (station_id) REFERENCES polling_stations(id)
);

-- 27. CAMPAIGN_EXPENSES
CREATE TABLE campaign_expenses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    candidate_id INT NOT NULL,
    expense_type VARCHAR(50) NOT NULL,
    receipt_number VARCHAR(50),
    amount DECIMAL(15,2) NOT NULL,
    status ENUM('verified','pending','rejected') DEFAULT 'pending',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT, updated_by INT, deleted_by INT,
    FOREIGN KEY (candidate_id) REFERENCES candidates(id)
);

-- 28. MEDIA_COVERAGE
CREATE TABLE media_coverage (
    id INT PRIMARY KEY AUTO_INCREMENT,
    election_id INT NOT NULL,
    media_outlet VARCHAR(100) NOT NULL,
    headline VARCHAR(255),
    coverage_ref VARCHAR(30),
    status ENUM('published','draft','archived') DEFAULT 'published',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT, updated_by INT, deleted_by INT,
    FOREIGN KEY (election_id) REFERENCES elections(id)
);

-- 29. SECURITY_INCIDENTS
CREATE TABLE security_incidents (
    id INT PRIMARY KEY AUTO_INCREMENT,
    station_id INT NOT NULL,
    incident_type VARCHAR(50) NOT NULL,
    incident_ref VARCHAR(30),
    severity VARCHAR(20),
    status ENUM('reported','investigating','resolved','closed') DEFAULT 'reported',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT, updated_by INT, deleted_by INT,
    FOREIGN KEY (station_id) REFERENCES polling_stations(id)
);

-- 30. BALLOT_PAPERS
CREATE TABLE ballot_papers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    election_id INT NOT NULL,
    ballot_number VARCHAR(30) UNIQUE NOT NULL,
    serial_number VARCHAR(50),
    station_id INT,
    status ENUM('issued','used','spoiled','unused') DEFAULT 'unused',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT, updated_by INT, deleted_by INT,
    FOREIGN KEY (election_id) REFERENCES elections(id),
    FOREIGN KEY (station_id) REFERENCES polling_stations(id)
);

-- 31. VOTER_TURNOUT
CREATE TABLE voter_turnout (
    id INT PRIMARY KEY AUTO_INCREMENT,
    election_id INT NOT NULL,
    station_id INT NOT NULL,
    turnout_ref VARCHAR(30),
    total_registered INT DEFAULT 0,
    total_voted INT DEFAULT 0,
    status ENUM('active','completed') DEFAULT 'active',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT, updated_by INT, deleted_by INT,
    FOREIGN KEY (election_id) REFERENCES elections(id),
    FOREIGN KEY (station_id) REFERENCES polling_stations(id)
);

-- 32. OBSERVER_REPORTS
CREATE TABLE observer_reports (
    id INT PRIMARY KEY AUTO_INCREMENT,
    agent_id INT NOT NULL,
    station_id INT NOT NULL,
    report_number VARCHAR(30),
    report_summary TEXT,
    status ENUM('submitted','reviewed','archived') DEFAULT 'submitted',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT, updated_by INT, deleted_by INT,
    FOREIGN KEY (agent_id) REFERENCES election_agents(id),
    FOREIGN KEY (station_id) REFERENCES polling_stations(id)
);

-- 33. CANDIDATE_MANIFESTO
CREATE TABLE candidate_manifesto (
    id INT PRIMARY KEY AUTO_INCREMENT,
    candidate_id INT NOT NULL,
    manifesto_title VARCHAR(200) NOT NULL,
    manifesto_ref VARCHAR(30),
    content TEXT,
    status ENUM('draft','published','archived') DEFAULT 'draft',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT, updated_by INT, deleted_by INT,
    FOREIGN KEY (candidate_id) REFERENCES candidates(id)
);

-- 34. PARTY_ALLIANCES
CREATE TABLE party_alliances (
    id INT PRIMARY KEY AUTO_INCREMENT,
    party_id INT NOT NULL,
    allied_party_id INT NOT NULL,
    alliance_name VARCHAR(100),
    alliance_code VARCHAR(30),
    status ENUM('active','dissolved','suspended') DEFAULT 'active',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT, updated_by INT, deleted_by INT,
    FOREIGN KEY (party_id) REFERENCES political_parties(id),
    FOREIGN KEY (allied_party_id) REFERENCES political_parties(id)
);

-- 35. ELECTION_BUDGETS
CREATE TABLE election_budgets (
    id INT PRIMARY KEY AUTO_INCREMENT,
    election_id INT NOT NULL,
    budget_category VARCHAR(50) NOT NULL,
    budget_ref VARCHAR(30),
    allocated_amount DECIMAL(15,2) NOT NULL,
    status ENUM('approved','pending','rejected') DEFAULT 'pending',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT, updated_by INT, deleted_by INT,
    FOREIGN KEY (election_id) REFERENCES elections(id)
);


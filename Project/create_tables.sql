-- =====================================================
--      ELECTION MANAGEMENT SYSTEM - MySQL Database
--      Enhanced Version with CASCADE Operations
-- =====================================================

-- SET FOREIGN_KEY_CHECKS = 0;

-- DROP DATABASE IF EXISTS election_management_system;
-- CREATE DATABASE election_management_system;
-- USE election_management_system;

-- =====================================================
-- TABLE CREATION (35 Tables)
-- =====================================================

-- 1. ADMINS *
CREATE TABLE admins (
    id INT PRIMARY KEY AUTO_INCREMENT,
    profile VARCHAR(255),
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    date_of_birth DATE,
    status ENUM('active','inactive','suspended') DEFAULT 'active',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

-- 2. USERS *
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    profile VARCHAR(255),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    cnic_number VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    date_of_birth DATE,
    gender ENUM('male','female','other'),
    address TEXT,
    city VARCHAR(100),
    status ENUM('active','inactive','suspended') DEFAULT 'active',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

-- 3. ROLES *
CREATE TABLE roles (
    id INT PRIMARY KEY AUTO_INCREMENT,
    role_name VARCHAR(50) UNIQUE NOT NULL,
    description TEXT,
    role_code VARCHAR(20) UNIQUE,
    priority_level INT DEFAULT 0,
    permissions TEXT,
    status ENUM('active','inactive') DEFAULT 'active',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

-- 4. USER_ROLES *
CREATE TABLE user_roles (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    role_id INT NOT NULL,
    assigned_date DATE,
    expiry_date DATE,
    status ENUM('active','inactive','expired') DEFAULT 'active',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT,
    CONSTRAINT fk_user_roles_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_user_roles_role FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 5. ELECTIONS *
CREATE TABLE elections (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    election_code VARCHAR(20) UNIQUE,
    election_type ENUM('general','local','by-election','special') DEFAULT 'general',
    start_date DATE,
    end_date DATE,
    status ENUM('running','paused','completed','suspended') DEFAULT 'paused',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

-- 6. ELECTION_COMMISSION
CREATE TABLE election_commission (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT UNIQUE NOT NULL,
    commission_code VARCHAR(20),
    designation VARCHAR(100),
    appointment_date DATE,
    authority_level ENUM('chief','senior','junior') DEFAULT 'junior',
    status ENUM('active','inactive','retired') DEFAULT 'active',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT,
    CONSTRAINT fk_election_commission_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 7. CITIES
CREATE TABLE cities (
    id INT PRIMARY KEY AUTO_INCREMENT,
    city_name VARCHAR(100) UNIQUE NOT NULL,
    province VARCHAR(50),
    country VARCHAR(50) DEFAULT 'Pakistan',
    population INT DEFAULT 0,
    status ENUM('active','inactive') DEFAULT 'active',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

-- 8. DISTRICTS
CREATE TABLE districts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    district_name VARCHAR(100) NOT NULL,
    city_id INT NOT NULL,
    district_code VARCHAR(20),
    district_type ENUM('urban','rural','semi-urban') DEFAULT 'urban',
    population INT DEFAULT 0,
    total_stations INT DEFAULT 0,
    status ENUM('active','inactive') DEFAULT 'active',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT,
    CONSTRAINT fk_districts_city FOREIGN KEY (city_id) REFERENCES cities(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 9. POLLING_STATIONS
CREATE TABLE polling_stations (
    id INT PRIMARY KEY AUTO_INCREMENT,
    station_name VARCHAR(150) NOT NULL,
    location VARCHAR(200) NOT NULL,
    district_id INT NOT NULL,
    registered_voters INT DEFAULT 0,
    status ENUM('active','inactive','suspended','under_maintenance') DEFAULT 'inactive',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT,
    CONSTRAINT fk_polling_stations_district FOREIGN KEY (district_id) REFERENCES districts(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 10. POLITICAL_PARTIES
CREATE TABLE political_parties (
    id INT PRIMARY KEY AUTO_INCREMENT,
    party_name VARCHAR(100) UNIQUE NOT NULL,
    party_symbol VARCHAR(255),
    founder VARCHAR(100),
    party_code VARCHAR(20),
    status ENUM('active','inactive','banned','suspended') DEFAULT 'active',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

-- 11. POSITIONS
CREATE TABLE positions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    position_code VARCHAR(10) UNIQUE NOT NULL,
    position_name VARCHAR(100) NOT NULL,
    description TEXT,
    position_level ENUM('national','provincial'),
    responsibilities TEXT,
    status ENUM('active','inactive') DEFAULT 'active',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

-- 12. CANDIDATES
CREATE TABLE candidates (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT UNIQUE NOT NULL,
    election_id INT NOT NULL,
    party_id INT NOT NULL,
    position_id INT,
    education_level VARCHAR(50),
    approval_date DATE,
    rejection_reason TEXT,
    status ENUM('pending','approved','rejected','withdrawn') DEFAULT 'pending',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT,
    CONSTRAINT fk_candidates_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_candidates_election FOREIGN KEY (election_id) REFERENCES elections(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_candidates_party FOREIGN KEY (party_id) REFERENCES political_parties(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_candidates_position FOREIGN KEY (position_id) REFERENCES positions(id) ON DELETE SET NULL ON UPDATE CASCADE
);

-- 13. DOCUMENT_TYPES
CREATE TABLE document_types (
    id INT PRIMARY KEY AUTO_INCREMENT,
    type_name VARCHAR(50) UNIQUE NOT NULL,
    description TEXT,
    type_code VARCHAR(20),
    required_for VARCHAR(50),
    validity_period INT DEFAULT 365,
    file_format VARCHAR(50),
    max_file_size INT DEFAULT 5,
    status ENUM('active','inactive') DEFAULT 'active',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

-- 14. CANDIDATE_DOCUMENTS
CREATE TABLE candidate_documents (
    id INT PRIMARY KEY AUTO_INCREMENT,
    candidate_id INT NOT NULL,
    document_type_id INT NOT NULL,
    document_path VARCHAR(255) NOT NULL,
    document_number VARCHAR(50),
    issue_date DATE,
    expiry_date DATE,
    verification_date DATE,
    verified_by INT,
    rejection_reason TEXT,
    status ENUM('verified','pending','rejected','expired') DEFAULT 'pending',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT,
    CONSTRAINT fk_candidate_documents_candidate FOREIGN KEY (candidate_id) REFERENCES candidates(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_candidate_documents_doctype FOREIGN KEY (document_type_id) REFERENCES document_types(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_candidate_documents_verifier FOREIGN KEY (verified_by) REFERENCES users(id) ON DELETE SET NULL ON UPDATE CASCADE
);

-- 15. ELECTION_AGENTS
CREATE TABLE election_agents (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT UNIQUE NOT NULL,
    candidate_id INT NOT NULL,
    agent_code VARCHAR(30),
    agent_type ENUM('polling','counting','general') DEFAULT 'general',
    assignment_date DATE,
    training_completed BOOLEAN DEFAULT FALSE,
    authorized_stations TEXT,
    contact_phone VARCHAR(20),
    status ENUM('active','inactive','suspended','revoked') DEFAULT 'inactive',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT,
    CONSTRAINT fk_election_agents_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_election_agents_candidate FOREIGN KEY (candidate_id) REFERENCES candidates(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 16. POLLING_OFFICERS
CREATE TABLE polling_officers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT UNIQUE NOT NULL,
    station_id INT,
    officer_code VARCHAR(30),
    designation ENUM('presiding_officer','assistant_officer','polling_clerk') DEFAULT 'polling_clerk',
    duty_date DATE,
    shift_time VARCHAR(50),
    training_status ENUM('trained','pending','exempted') DEFAULT 'pending',
    contact_phone VARCHAR(20),
    status ENUM('active','inactive','suspended','relieved') DEFAULT 'inactive',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT,
    CONSTRAINT fk_polling_officers_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_polling_officers_station FOREIGN KEY (station_id) REFERENCES polling_stations(id) ON DELETE SET NULL ON UPDATE CASCADE
);

-- 17. COMPLAINT_CATEGORIES
CREATE TABLE complaint_categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) UNIQUE NOT NULL,
    category_code VARCHAR(20),
    description TEXT,
    priority_level ENUM('high','medium','low') DEFAULT 'medium',
    resolution_time INT DEFAULT 72,
    parent_category_id INT,
    handling_department VARCHAR(100),
    status ENUM('active','inactive') DEFAULT 'active',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

-- 18. COMPLAINTS
CREATE TABLE complaints (
    id INT PRIMARY KEY AUTO_INCREMENT,
    complaint_title VARCHAR(100) NOT NULL,
    complaint_number VARCHAR(30),
    election_id INT NOT NULL,
    category_id INT NOT NULL,
    complainant_id INT,
    description TEXT,
    evidence_path VARCHAR(255),
    priority ENUM('urgent','high','medium','low') DEFAULT 'medium',
    assigned_to INT,
    resolution_notes TEXT,
    resolved_date DATE,
    status ENUM('pending','under-investigation','resolved','rejected','closed') DEFAULT 'pending',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT,
    CONSTRAINT fk_complaints_election FOREIGN KEY (election_id) REFERENCES elections(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_complaints_category FOREIGN KEY (category_id) REFERENCES complaint_categories(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_complaints_complainant FOREIGN KEY (complainant_id) REFERENCES users(id) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_complaints_assigned FOREIGN KEY (assigned_to) REFERENCES users(id) ON DELETE SET NULL ON UPDATE CASCADE
);

-- 19. VOTER_VERIFICATION
CREATE TABLE voter_verification (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT UNIQUE NOT NULL,
    device_id VARCHAR(100),
    verification_code VARCHAR(30),
    verification_method ENUM('biometric','otp','manual','document') DEFAULT 'otp',
    verification_date DATE,
    verified_by INT,
    ip_address VARCHAR(50),
    location_coordinates VARCHAR(100),
    attempt_count INT DEFAULT 0,
    is_verified BOOLEAN DEFAULT FALSE,
    status ENUM('verified','pending','rejected','blocked') DEFAULT 'pending',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT,
    CONSTRAINT fk_voter_verification_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_voter_verification_verifier FOREIGN KEY (verified_by) REFERENCES users(id) ON DELETE SET NULL ON UPDATE CASCADE
);

-- 20. VOTES
CREATE TABLE votes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    voter_id INT NOT NULL,
    candidate_id INT NOT NULL,
    election_id INT NOT NULL,
    station_id INT,
    vote_hash VARCHAR(255),
    vote_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    verification_method VARCHAR(50),
    device_info VARCHAR(255),
    ip_address VARCHAR(50),
    status ENUM('valid','invalid','disputed','cancelled') DEFAULT 'valid',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT,
    CONSTRAINT fk_votes_voter FOREIGN KEY (voter_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_votes_candidate FOREIGN KEY (candidate_id) REFERENCES candidates(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_votes_election FOREIGN KEY (election_id) REFERENCES elections(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_votes_station FOREIGN KEY (station_id) REFERENCES polling_stations(id) ON DELETE SET NULL ON UPDATE CASCADE
);

-- 21. ELECTION_RESULTS
CREATE TABLE election_results (
    id INT PRIMARY KEY AUTO_INCREMENT,
    election_id INT NOT NULL,
    candidate_id INT NOT NULL,
    station_id INT,
    total_votes INT DEFAULT 0,
    vote_percentage DECIMAL(5,2) DEFAULT 0.00,
    result_code VARCHAR(30),
    rank_position INT,
    is_winner BOOLEAN DEFAULT FALSE,
    declaration_date DATE,
    verified_by INT,
    status ENUM('provisional','final','contested','cancelled') DEFAULT 'provisional',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT,
    CONSTRAINT fk_election_results_election FOREIGN KEY (election_id) REFERENCES elections(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_election_results_candidate FOREIGN KEY (candidate_id) REFERENCES candidates(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_election_results_station FOREIGN KEY (station_id) REFERENCES polling_stations(id) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_election_results_verifier FOREIGN KEY (verified_by) REFERENCES users(id) ON DELETE SET NULL ON UPDATE CASCADE
);

-- 22. AUDIT_LOGS
CREATE TABLE audit_logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    table_name VARCHAR(50) NOT NULL,
    action_type VARCHAR(20) NOT NULL,
    record_id INT NOT NULL,
    log_reference VARCHAR(50),
    old_value TEXT,
    new_value TEXT,
    user_id INT,
    ip_address VARCHAR(50),
    user_agent TEXT,
    status ENUM('success','failed','rolled_back') DEFAULT 'success',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT,
    CONSTRAINT fk_audit_logs_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL ON UPDATE CASCADE
);

-- 23. NOTIFICATIONS
CREATE TABLE notifications (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    notification_type VARCHAR(50) NOT NULL,
    title VARCHAR(150) NOT NULL,
    message TEXT,
    channel ENUM('email','sms','push','in-app') DEFAULT 'in-app',
    priority ENUM('urgent','high','normal','low') DEFAULT 'normal',
    sent_date TIMESTAMP NULL,
    status ENUM('sent','pending','failed','cancelled') DEFAULT 'pending',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT,
    CONSTRAINT fk_notifications_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 24. SYSTEM_SETTINGS
CREATE TABLE system_settings (
    id INT PRIMARY KEY AUTO_INCREMENT,
    setting_key VARCHAR(100) UNIQUE NOT NULL,
    setting_value TEXT NOT NULL,
    setting_code VARCHAR(30),
    category VARCHAR(50),
    data_type ENUM('string','number','boolean','json') DEFAULT 'string',
    description TEXT,
    is_editable BOOLEAN DEFAULT TRUE,
    status ENUM('active','inactive') DEFAULT 'active',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

-- 25. ELECTION_PHASES
CREATE TABLE election_phases (
    id INT PRIMARY KEY AUTO_INCREMENT,
    election_id INT NOT NULL,
    phase_name VARCHAR(100) NOT NULL,
    phase_code VARCHAR(30),
    phase_order INT NOT NULL,
    start_date DATE,
    end_date DATE,
    description TEXT,
    completion_percentage INT DEFAULT 0,
    responsible_person VARCHAR(100),
    status ENUM('upcoming','active','completed','cancelled','delayed') DEFAULT 'upcoming',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT,
    CONSTRAINT fk_election_phases_election FOREIGN KEY (election_id) REFERENCES elections(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 26. STATION_RESOURCES
CREATE TABLE station_resources (
    id INT PRIMARY KEY AUTO_INCREMENT,
    station_id INT NOT NULL,
    resource_name VARCHAR(100) NOT NULL,
    resource_code VARCHAR(30),
    resource_type VARCHAR(50),
    quantity INT DEFAULT 1,
    unit_of_measure VARCHAR(20),
    allocation_date DATE,
    condition_notes TEXT,
    last_maintenance DATE,
    status ENUM('available','in-use','damaged','missing','under-maintenance') DEFAULT 'available',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT,
    CONSTRAINT fk_station_resources_station FOREIGN KEY (station_id) REFERENCES polling_stations(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 27. CAMPAIGN_EXPENSES
CREATE TABLE campaign_expenses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    candidate_id INT NOT NULL,
    expense_type VARCHAR(50) NOT NULL,
    receipt_number VARCHAR(50),
    amount DECIMAL(15,2) NOT NULL,
    expense_date DATE,
    description TEXT,
    vendor_name VARCHAR(100),
    payment_method VARCHAR(50),
    verification_notes TEXT,
    verified_by INT,
    status ENUM('verified','pending','rejected','flagged') DEFAULT 'pending',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT,
    CONSTRAINT fk_campaign_expenses_candidate FOREIGN KEY (candidate_id) REFERENCES candidates(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_campaign_expenses_verifier FOREIGN KEY (verified_by) REFERENCES users(id) ON DELETE SET NULL ON UPDATE CASCADE
);

-- 28. MEDIA_COVERAGE
CREATE TABLE media_coverage (
    id INT PRIMARY KEY AUTO_INCREMENT,
    election_id INT NOT NULL,
    media_outlet VARCHAR(100) NOT NULL,
    headline VARCHAR(255),
    coverage_ref VARCHAR(30),
    coverage_type ENUM('news','interview','debate','analysis') DEFAULT 'news',
    publication_date DATE,
    reporter_name VARCHAR(100),
    media_url VARCHAR(255),
    sentiment ENUM('positive','neutral','negative') DEFAULT 'neutral',
    reach_estimate INT DEFAULT 0,
    status ENUM('published','draft','archived','removed') DEFAULT 'published',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT,
    CONSTRAINT fk_media_coverage_election FOREIGN KEY (election_id) REFERENCES elections(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 29. SECURITY_INCIDENTS
CREATE TABLE security_incidents (
    id INT PRIMARY KEY AUTO_INCREMENT,
    station_id INT NOT NULL,
    reported_by INT,
    incident_type VARCHAR(50) NOT NULL,
    severity VARCHAR(20),
    description TEXT,
    resolution_notes TEXT,
    resolved_date DATE,
    status ENUM('reported','investigating','resolved','closed','escalated') DEFAULT 'reported',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT,
    CONSTRAINT fk_security_incidents_station FOREIGN KEY (station_id) REFERENCES polling_stations(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_security_incidents_reporter FOREIGN KEY (reported_by) REFERENCES users(id) ON DELETE SET NULL ON UPDATE CASCADE
);

-- 30. BALLOT_PAPERS
CREATE TABLE ballot_papers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    election_id INT NOT NULL,
    station_id INT NOT NULL,
    ballot_number VARCHAR(30) UNIQUE NOT NULL,
    serial_number VARCHAR(50),
    batch_number VARCHAR(30),
    print_date DATE,
    distribution_date DATE,
    status ENUM('issued','used','spoiled','unused','returned') DEFAULT 'unused',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT,
    CONSTRAINT fk_ballot_papers_election FOREIGN KEY (election_id) REFERENCES elections(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_ballot_papers_station FOREIGN KEY (station_id) REFERENCES polling_stations(id) ON DELETE SET NULL ON UPDATE CASCADE
);

-- 31. VOTER_TURNOUT
CREATE TABLE voter_turnout (
    id INT PRIMARY KEY AUTO_INCREMENT,
    election_id INT NOT NULL,
    station_id INT NOT NULL,
    total_registered INT DEFAULT 0,
    total_voted INT DEFAULT 0,
    male_voters INT DEFAULT 0,
    female_voters INT DEFAULT 0,
    turnout_percentage DECIMAL(5,2) DEFAULT 0.00,
    recorded_by INT,
    status ENUM('active','completed','verified','disputed') DEFAULT 'active',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT,
    CONSTRAINT fk_voter_turnout_election FOREIGN KEY (election_id) REFERENCES elections(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_voter_turnout_station FOREIGN KEY (station_id) REFERENCES polling_stations(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_voter_turnout_recorder FOREIGN KEY (recorded_by) REFERENCES users(id) ON DELETE SET NULL ON UPDATE CASCADE
);

-- 32. OBSERVER_REPORTS
CREATE TABLE observer_reports (
    id INT PRIMARY KEY AUTO_INCREMENT,
    agent_id INT NOT NULL,
    station_id INT NOT NULL,
    report_summary TEXT,
    observation_date DATE,
    issues_found TEXT,
    recommendations TEXT,
    status ENUM('pending','reviewed','archived','reject') DEFAULT 'pending',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT,
    CONSTRAINT fk_observer_reports_agent FOREIGN KEY (agent_id) REFERENCES election_agents(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_observer_reports_station FOREIGN KEY (station_id) REFERENCES polling_stations(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 33. CANDIDATE_MANIFESTO
CREATE TABLE candidate_manifesto (
    id INT PRIMARY KEY AUTO_INCREMENT,
    candidate_id INT NOT NULL,
    manifesto_title VARCHAR(200) NOT NULL,
    content TEXT,
    key_points TEXT,
    views_count INT DEFAULT 0,
    status ENUM('draft','published','archived','withdrawn') DEFAULT 'draft',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT,
    CONSTRAINT fk_candidate_manifesto_candidate FOREIGN KEY (candidate_id) REFERENCES candidates(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 34. PARTY_ALLIANCES
CREATE TABLE party_alliances (
    id INT PRIMARY KEY AUTO_INCREMENT,
    party_id INT NOT NULL,
    allied_party_id INT NOT NULL,
    alliance_name VARCHAR(100),
    alliance_code VARCHAR(30),
    formation_date DATE,
    agreement_terms TEXT,
    contact_email VARCHAR(100),
    status ENUM('active','dissolved','suspended','negotiating') DEFAULT 'active',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT,
    CONSTRAINT fk_party_alliances_party FOREIGN KEY (party_id) REFERENCES political_parties(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_party_alliances_allied FOREIGN KEY (allied_party_id) REFERENCES political_parties(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 35. ELECTION_BUDGETS
CREATE TABLE election_budgets (
    id INT PRIMARY KEY AUTO_INCREMENT,
    election_id INT NOT NULL,
    budget_category VARCHAR(50) NOT NULL,
    budget_ref VARCHAR(30),
    allocated_amount DECIMAL(15,2) NOT NULL,
    spent_amount DECIMAL(15,2) DEFAULT 0.00,
    status ENUM('approved','pending','rejected','exhausted') DEFAULT 'pending',
    is_enable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT,
    CONSTRAINT fk_election_budgets_election FOREIGN KEY (election_id) REFERENCES elections(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Re-enable foreign key checks
-- SET FOREIGN_KEY_CHECKS = 1;
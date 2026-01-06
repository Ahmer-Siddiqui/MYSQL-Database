-- =====================================================
--      ELECTION MANAGEMENT SYSTEM - Log Tables & Triggers
-- =====================================================

USE election_management_system;

-- 1. ADMINS LOG
CREATE TABLE log_admins (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    log_action VARCHAR(20) DEFAULT 'INSERT',
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id INT,
    profile VARCHAR(255),
    name VARCHAR(100),
    email VARCHAR(100),
    password VARCHAR(255),
    date_of_birth DATE,
    status ENUM('active','inactive','suspended'),
    is_enable BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

DELIMITER //
CREATE TRIGGER trg_admins_insert AFTER INSERT ON admins
FOR EACH ROW
BEGIN
    INSERT INTO log_admins (id, profile, name, email, password, date_of_birth, status, is_enable, created_at, updated_at, created_by, updated_by, deleted_by)
    VALUES (NEW.id, NEW.profile, NEW.name, NEW.email, NEW.password, NEW.date_of_birth, NEW.status, NEW.is_enable, NEW.created_at, NEW.updated_at, NEW.created_by, NEW.updated_by, NEW.deleted_by);
END //
DELIMITER ;

-- 2. USERS LOG
CREATE TABLE log_users (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    log_action VARCHAR(20) DEFAULT 'INSERT',
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id INT,
    profile VARCHAR(255),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    cnic_number VARCHAR(15),
    email VARCHAR(100),
    phone VARCHAR(20),
    date_of_birth DATE,
    gender ENUM('male','female','other'),
    address TEXT,
    city VARCHAR(100),
    status ENUM('active','inactive','suspended'),
    is_enable BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

DELIMITER //
CREATE TRIGGER trg_users_insert AFTER INSERT ON users
FOR EACH ROW
BEGIN
    INSERT INTO log_users (id, profile, first_name, last_name, cnic_number, email, phone, date_of_birth, gender, address, city, status, is_enable, created_at, updated_at, created_by, updated_by, deleted_by)
    VALUES (NEW.id, NEW.profile, NEW.first_name, NEW.last_name, NEW.cnic_number, NEW.email, NEW.phone, NEW.date_of_birth, NEW.gender, NEW.address, NEW.city, NEW.status, NEW.is_enable, NEW.created_at, NEW.updated_at, NEW.created_by, NEW.updated_by, NEW.deleted_by);
END //
DELIMITER ;

-- 3. ROLES LOG
CREATE TABLE log_roles (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    log_action VARCHAR(20) DEFAULT 'INSERT',
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id INT,
    role_name VARCHAR(50),
    description TEXT,
    role_code VARCHAR(20),
    priority_level INT,
    permissions TEXT,
    status ENUM('active','inactive'),
    is_enable BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

DELIMITER //
CREATE TRIGGER trg_roles_insert AFTER INSERT ON roles
FOR EACH ROW
BEGIN
    INSERT INTO log_roles (id, role_name, description, role_code, priority_level, permissions, status, is_enable, created_at, updated_at, created_by, updated_by, deleted_by)
    VALUES (NEW.id, NEW.role_name, NEW.description, NEW.role_code, NEW.priority_level, NEW.permissions, NEW.status, NEW.is_enable, NEW.created_at, NEW.updated_at, NEW.created_by, NEW.updated_by, NEW.deleted_by);
END //
DELIMITER ;

-- 4. USER_ROLES LOG
CREATE TABLE log_user_roles (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    log_action VARCHAR(20) DEFAULT 'INSERT',
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id INT,
    user_id INT,
    role_id INT,
    assigned_date DATE,
    expiry_date DATE,
    status ENUM('active','inactive','expired'),
    is_enable BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

DELIMITER //
CREATE TRIGGER trg_user_roles_insert AFTER INSERT ON user_roles
FOR EACH ROW
BEGIN
    INSERT INTO log_user_roles (id, user_id, role_id, assigned_date, expiry_date, status, is_enable, created_at, updated_at, created_by, updated_by, deleted_by)
    VALUES (NEW.id, NEW.user_id, NEW.role_id, NEW.assigned_date, NEW.expiry_date, NEW.status, NEW.is_enable, NEW.created_at, NEW.updated_at, NEW.created_by, NEW.updated_by, NEW.deleted_by);
END //
DELIMITER ;

-- 5. ELECTIONS LOG
CREATE TABLE log_elections (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    log_action VARCHAR(20) DEFAULT 'INSERT',
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id INT,
    title VARCHAR(200),
    description TEXT,
    election_code VARCHAR(20),
    election_type ENUM('general','local','by-election','special'),
    start_date DATE,
    end_date DATE,
    status ENUM('running','paused','completed','suspended'),
    is_enable BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

DELIMITER //
CREATE TRIGGER trg_elections_insert AFTER INSERT ON elections
FOR EACH ROW
BEGIN
    INSERT INTO log_elections (id, title, description, election_code, election_type, start_date, end_date, status, is_enable, created_at, updated_at, created_by, updated_by, deleted_by)
    VALUES (NEW.id, NEW.title, NEW.description, NEW.election_code, NEW.election_type, NEW.start_date, NEW.end_date, NEW.status, NEW.is_enable, NEW.created_at, NEW.updated_at, NEW.created_by, NEW.updated_by, NEW.deleted_by);
END //
DELIMITER ;

-- 6. ELECTION_COMMISSION LOG
CREATE TABLE log_election_commission (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    log_action VARCHAR(20) DEFAULT 'INSERT',
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id INT,
    user_id INT,
    commission_code VARCHAR(20),
    designation VARCHAR(100),
    appointment_date DATE,
    authority_level ENUM('chief','senior','junior'),
    status ENUM('active','inactive','retired'),
    is_enable BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

DELIMITER //
CREATE TRIGGER trg_election_commission_insert AFTER INSERT ON election_commission
FOR EACH ROW
BEGIN
    INSERT INTO log_election_commission (id, user_id, commission_code, designation, appointment_date, authority_level, status, is_enable, created_at, updated_at, created_by, updated_by, deleted_by)
    VALUES (NEW.id, NEW.user_id, NEW.commission_code, NEW.designation, NEW.appointment_date, NEW.authority_level, NEW.status, NEW.is_enable, NEW.created_at, NEW.updated_at, NEW.created_by, NEW.updated_by, NEW.deleted_by);
END //
DELIMITER ;

-- 7. CITIES LOG
CREATE TABLE log_cities (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    log_action VARCHAR(20) DEFAULT 'INSERT',
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id INT,
    city_name VARCHAR(100),
    province VARCHAR(50),
    country VARCHAR(50),
    population INT,
    status ENUM('active','inactive'),
    is_enable BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

DELIMITER //
CREATE TRIGGER trg_cities_insert AFTER INSERT ON cities
FOR EACH ROW
BEGIN
    INSERT INTO log_cities (id, city_name, province, country, population, status, is_enable, created_at, updated_at, created_by, updated_by, deleted_by)
    VALUES (NEW.id, NEW.city_name, NEW.province, NEW.country, NEW.population, NEW.status, NEW.is_enable, NEW.created_at, NEW.updated_at, NEW.created_by, NEW.updated_by, NEW.deleted_by);
END //
DELIMITER ;

-- 8. DISTRICTS LOG
CREATE TABLE log_districts (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    log_action VARCHAR(20) DEFAULT 'INSERT',
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id INT,
    district_name VARCHAR(100),
    city_id INT,
    district_code VARCHAR(20),
    district_type ENUM('urban','rural','semi-urban'),
    population INT,
    total_stations INT,
    status ENUM('active','inactive'),
    is_enable BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

DELIMITER //
CREATE TRIGGER trg_districts_insert AFTER INSERT ON districts
FOR EACH ROW
BEGIN
    INSERT INTO log_districts (id, district_name, city_id, district_code, district_type, population, total_stations, status, is_enable, created_at, updated_at, created_by, updated_by, deleted_by)
    VALUES (NEW.id, NEW.district_name, NEW.city_id, NEW.district_code, NEW.district_type, NEW.population, NEW.total_stations, NEW.status, NEW.is_enable, NEW.created_at, NEW.updated_at, NEW.created_by, NEW.updated_by, NEW.deleted_by);
END //
DELIMITER ;

-- 9. POLLING_STATIONS LOG
CREATE TABLE log_polling_stations (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    log_action VARCHAR(20) DEFAULT 'INSERT',
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id INT,
    station_name VARCHAR(150),
    location VARCHAR(200),
    district_id INT,
    registered_voters INT,
    status ENUM('active','inactive','suspended','under_maintenance'),
    is_enabled BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

DELIMITER //
CREATE TRIGGER trg_polling_stations_insert AFTER INSERT ON polling_stations
FOR EACH ROW
BEGIN
    INSERT INTO log_polling_stations (id, station_name, location, district_id, registered_voters, status, is_enabled, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by)
    VALUES (NEW.id, NEW.station_name, NEW.location, NEW.district_id, NEW.registered_voters, NEW.status, NEW.is_enabled, NEW.created_at, NEW.updated_at, NEW.deleted_at, NEW.created_by, NEW.updated_by, NEW.deleted_by);
END //
DELIMITER ;

-- 10. POLITICAL_PARTIES LOG
CREATE TABLE log_political_parties (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    log_action VARCHAR(20) DEFAULT 'INSERT',
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id INT,
    party_name VARCHAR(100),
    party_symbol VARCHAR(255),
    founder VARCHAR(100),
    party_code VARCHAR(20),
    status ENUM('active','inactive','banned','suspended'),
    is_enable BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

DELIMITER //
CREATE TRIGGER trg_political_parties_insert AFTER INSERT ON political_parties
FOR EACH ROW
BEGIN
    INSERT INTO log_political_parties (id, party_name, party_symbol, founder, party_code, status, is_enable, created_at, updated_at, created_by, updated_by, deleted_by)
    VALUES (NEW.id, NEW.party_name, NEW.party_symbol, NEW.founder, NEW.party_code, NEW.status, NEW.is_enable, NEW.created_at, NEW.updated_at, NEW.created_by, NEW.updated_by, NEW.deleted_by);
END //
DELIMITER ;

-- 11. POSITIONS LOG
CREATE TABLE log_positions (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    log_action VARCHAR(20) DEFAULT 'INSERT',
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id INT,
    position_code VARCHAR(10),
    position_name VARCHAR(100),
    description TEXT,
    position_level ENUM('national','provincial'),
    responsibilities TEXT,
    status ENUM('active','inactive'),
    is_enable BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

DELIMITER //
CREATE TRIGGER trg_positions_insert AFTER INSERT ON positions
FOR EACH ROW
BEGIN
    INSERT INTO log_positions (id, position_code, position_name, description, position_level, responsibilities, status, is_enable, created_at, updated_at, created_by, updated_by, deleted_by)
    VALUES (NEW.id, NEW.position_code, NEW.position_name, NEW.description, NEW.position_level, NEW.responsibilities, NEW.status, NEW.is_enable, NEW.created_at, NEW.updated_at, NEW.created_by, NEW.updated_by, NEW.deleted_by);
END //
DELIMITER ;

-- 12. CANDIDATES LOG
CREATE TABLE log_candidates (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    log_action VARCHAR(20) DEFAULT 'INSERT',
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id INT,
    user_id INT,
    election_id INT,
    party_id INT,
    position_id INT,
    education_level VARCHAR(50),
    approval_date DATE,
    rejection_reason TEXT,
    status ENUM('pending','approved','rejected','withdrawn'),
    is_enable BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

DELIMITER //
CREATE TRIGGER trg_candidates_insert AFTER INSERT ON candidates
FOR EACH ROW
BEGIN
    INSERT INTO log_candidates (id, user_id, election_id, party_id, position_id, education_level, approval_date, rejection_reason, status, is_enable, created_at, updated_at, created_by, updated_by, deleted_by)
    VALUES (NEW.id, NEW.user_id, NEW.election_id, NEW.party_id, NEW.position_id, NEW.education_level, NEW.approval_date, NEW.rejection_reason, NEW.status, NEW.is_enable, NEW.created_at, NEW.updated_at, NEW.created_by, NEW.updated_by, NEW.deleted_by);
END //
DELIMITER ;

-- 13. DOCUMENT_TYPES LOG
CREATE TABLE log_document_types (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    log_action VARCHAR(20) DEFAULT 'INSERT',
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id INT,
    type_name VARCHAR(50),
    description TEXT,
    type_code VARCHAR(20),
    required_for VARCHAR(50),
    file_format VARCHAR(50),
    max_file_size INT,
    status ENUM('active','inactive'),
    is_enable BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

DELIMITER //
CREATE TRIGGER trg_document_types_insert AFTER INSERT ON document_types
FOR EACH ROW
BEGIN
    INSERT INTO log_document_types (id, type_name, description, type_code, required_for, file_format, max_file_size, status, is_enable, created_at, updated_at, created_by, updated_by, deleted_by)
    VALUES (NEW.id, NEW.type_name, NEW.description, NEW.type_code, NEW.required_for, NEW.file_format, NEW.max_file_size, NEW.status, NEW.is_enable, NEW.created_at, NEW.updated_at, NEW.created_by, NEW.updated_by, NEW.deleted_by);
END //
DELIMITER ;

-- 14. CANDIDATE_DOCUMENTS LOG
CREATE TABLE log_candidate_documents (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    log_action VARCHAR(20) DEFAULT 'INSERT',
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id INT,
    candidate_id INT,
    document_type_id INT,
    document_path VARCHAR(255),
    document_number VARCHAR(50),
    issue_date DATE,
    expiry_date DATE,
    verification_date DATE,
    verified_by INT,
    rejection_reason TEXT,
    status ENUM('verified','pending','rejected','expired'),
    is_enable BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

DELIMITER //
CREATE TRIGGER trg_candidate_documents_insert AFTER INSERT ON candidate_documents
FOR EACH ROW
BEGIN
    INSERT INTO log_candidate_documents (id, candidate_id, document_type_id, document_path, document_number, issue_date, expiry_date, verification_date, verified_by, rejection_reason, status, is_enable, created_at, updated_at, created_by, updated_by, deleted_by)
    VALUES (NEW.id, NEW.candidate_id, NEW.document_type_id, NEW.document_path, NEW.document_number, NEW.issue_date, NEW.expiry_date, NEW.verification_date, NEW.verified_by, NEW.rejection_reason, NEW.status, NEW.is_enable, NEW.created_at, NEW.updated_at, NEW.created_by, NEW.updated_by, NEW.deleted_by);
END //
DELIMITER ;

-- 15. ELECTION_AGENTS LOG
CREATE TABLE log_election_agents (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    log_action VARCHAR(20) DEFAULT 'INSERT',
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id INT,
    user_id INT,
    candidate_id INT,
    agent_code VARCHAR(30),
    agent_type ENUM('polling','counting','general'),
    assignment_date DATE,
    training_completed BOOLEAN,
    authorized_stations TEXT,
    contact_phone VARCHAR(20),
    status ENUM('active','inactive','suspended','revoked'),
    is_enable BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

DELIMITER //
CREATE TRIGGER trg_election_agents_insert AFTER INSERT ON election_agents
FOR EACH ROW
BEGIN
    INSERT INTO log_election_agents (id, user_id, candidate_id, agent_code, agent_type, assignment_date, training_completed, authorized_stations, contact_phone, status, is_enable, created_at, updated_at, created_by, updated_by, deleted_by)
    VALUES (NEW.id, NEW.user_id, NEW.candidate_id, NEW.agent_code, NEW.agent_type, NEW.assignment_date, NEW.training_completed, NEW.authorized_stations, NEW.contact_phone, NEW.status, NEW.is_enable, NEW.created_at, NEW.updated_at, NEW.created_by, NEW.updated_by, NEW.deleted_by);
END //
DELIMITER ;

-- 16. POLLING_OFFICERS LOG
CREATE TABLE log_polling_officers (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    log_action VARCHAR(20) DEFAULT 'INSERT',
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id INT,
    user_id INT,
    station_id INT,
    officer_code VARCHAR(30),
    designation ENUM('presiding_officer','assistant_officer','polling_clerk'),
    duty_date DATE,
    shift_time VARCHAR(50),
    training_status ENUM('trained','pending','exempted'),
    contact_phone VARCHAR(20),
    status ENUM('active','inactive','suspended','relieved'),
    is_enable BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

DELIMITER //
CREATE TRIGGER trg_polling_officers_insert AFTER INSERT ON polling_officers
FOR EACH ROW
BEGIN
    INSERT INTO log_polling_officers (id, user_id, station_id, officer_code, designation, duty_date, shift_time, training_status, contact_phone, status, is_enable, created_at, updated_at, created_by, updated_by, deleted_by)
    VALUES (NEW.id, NEW.user_id, NEW.station_id, NEW.officer_code, NEW.designation, NEW.duty_date, NEW.shift_time, NEW.training_status, NEW.contact_phone, NEW.status, NEW.is_enable, NEW.created_at, NEW.updated_at, NEW.created_by, NEW.updated_by, NEW.deleted_by);
END //
DELIMITER ;

-- 17. COMPLAINT_CATEGORIES LOG
CREATE TABLE log_complaint_categories (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    log_action VARCHAR(20) DEFAULT 'INSERT',
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id INT,
    category_name VARCHAR(50),
    category_code VARCHAR(20),
    description TEXT,
    priority_level ENUM('high','medium','low'),
    resolution_time INT,
    parent_category_id INT,
    handling_department VARCHAR(100),
    status ENUM('active','inactive'),
    is_enable BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

DELIMITER //
CREATE TRIGGER trg_complaint_categories_insert AFTER INSERT ON complaint_categories
FOR EACH ROW
BEGIN
    INSERT INTO log_complaint_categories (id, category_name, category_code, description, priority_level, resolution_time, parent_category_id, handling_department, status, is_enable, created_at, updated_at, created_by, updated_by, deleted_by)
    VALUES (NEW.id, NEW.category_name, NEW.category_code, NEW.description, NEW.priority_level, NEW.resolution_time, NEW.parent_category_id, NEW.handling_department, NEW.status, NEW.is_enable, NEW.created_at, NEW.updated_at, NEW.created_by, NEW.updated_by, NEW.deleted_by);
END //
DELIMITER ;

-- 18. COMPLAINTS LOG
CREATE TABLE log_complaints (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    log_action VARCHAR(20) DEFAULT 'INSERT',
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id INT,
    complaint_title VARCHAR(100),
    complaint_number VARCHAR(30),
    election_id INT,
    category_id INT,
    complainant_id INT,
    description TEXT,
    evidence_path VARCHAR(255),
    priority ENUM('critical','high','medium','low'),
    assigned_to INT,
    resolution_notes TEXT,
    resolved_date DATE,
    status ENUM('pending','under-investigation','resolved','rejected','closed'),
    is_enable BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

DELIMITER //
CREATE TRIGGER trg_complaints_insert AFTER INSERT ON complaints
FOR EACH ROW
BEGIN
    INSERT INTO log_complaints (id, complaint_title, complaint_number, election_id, category_id, complainant_id, description, evidence_path, priority, assigned_to, resolution_notes, resolved_date, status, is_enable, created_at, updated_at, created_by, updated_by, deleted_by)
    VALUES (NEW.id, NEW.complaint_title, NEW.complaint_number, NEW.election_id, NEW.category_id, NEW.complainant_id, NEW.description, NEW.evidence_path, NEW.priority, NEW.assigned_to, NEW.resolution_notes, NEW.resolved_date, NEW.status, NEW.is_enable, NEW.created_at, NEW.updated_at, NEW.created_by, NEW.updated_by, NEW.deleted_by);
END //
DELIMITER ;

-- 19. VOTER_VERIFICATION LOG
CREATE TABLE log_voter_verification (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    log_action VARCHAR(20) DEFAULT 'INSERT',
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id INT,
    user_id INT,
    device_id VARCHAR(100),
    verification_code VARCHAR(30),
    verification_method ENUM('biometric','otp','manual','document'),
    verification_date DATE,
    verified_by INT,
    ip_address VARCHAR(50),
    location_coordinates VARCHAR(100),
    attempt_count INT,
    is_verified BOOLEAN,
    status ENUM('verified','pending','rejected','blocked'),
    is_enable BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

DELIMITER //
CREATE TRIGGER trg_voter_verification_insert AFTER INSERT ON voter_verification
FOR EACH ROW
BEGIN
    INSERT INTO log_voter_verification (id, user_id, device_id, verification_code, verification_method, verification_date, verified_by, ip_address, location_coordinates, attempt_count, is_verified, status, is_enable, created_at, updated_at, created_by, updated_by, deleted_by)
    VALUES (NEW.id, NEW.user_id, NEW.device_id, NEW.verification_code, NEW.verification_method, NEW.verification_date, NEW.verified_by, NEW.ip_address, NEW.location_coordinates, NEW.attempt_count, NEW.is_verified, NEW.status, NEW.is_enable, NEW.created_at, NEW.updated_at, NEW.created_by, NEW.updated_by, NEW.deleted_by);
END //
DELIMITER ;

-- 20. VOTES LOG
CREATE TABLE log_votes (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    log_action VARCHAR(20) DEFAULT 'INSERT',
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id INT,
    voter_id INT,
    candidate_id INT,
    election_id INT,
    station_id INT,
    vote_hash VARCHAR(255),
    vote_timestamp TIMESTAMP,
    verification_method VARCHAR(50),
    device_info VARCHAR(255),
    ip_address VARCHAR(50),
    status ENUM('valid','invalid','disputed','cancelled'),
    is_enable BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

DELIMITER //
CREATE TRIGGER trg_votes_insert AFTER INSERT ON votes
FOR EACH ROW
BEGIN
    INSERT INTO log_votes (id, voter_id, candidate_id, election_id, station_id, vote_hash, vote_timestamp, verification_method, device_info, ip_address, status, is_enable, created_at, updated_at, created_by, updated_by, deleted_by)
    VALUES (NEW.id, NEW.voter_id, NEW.candidate_id, NEW.election_id, NEW.station_id, NEW.vote_hash, NEW.vote_timestamp, NEW.verification_method, NEW.device_info, NEW.ip_address, NEW.status, NEW.is_enable, NEW.created_at, NEW.updated_at, NEW.created_by, NEW.updated_by, NEW.deleted_by);
END //
DELIMITER ;

-- 21. ELECTION_RESULTS LOG
CREATE TABLE log_election_results (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    log_action VARCHAR(20) DEFAULT 'INSERT',
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id INT,
    election_id INT,
    candidate_id INT,
    total_votes INT,
    vote_percentage DECIMAL(5,2),
    is_winner BOOLEAN,
    verified_by INT,
    status ENUM('provisional','final','contested','cancelled'),
    is_enable BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

DELIMITER //
CREATE TRIGGER trg_election_results_insert AFTER INSERT ON election_results
FOR EACH ROW
BEGIN
    INSERT INTO log_election_results (id, election_id, candidate_id, total_votes, vote_percentage, is_winner, verified_by, status, is_enable, created_at, updated_at, created_by, updated_by, deleted_by)
    VALUES (NEW.id, NEW.election_id, NEW.candidate_id, NEW.total_votes, NEW.vote_percentage, NEW.is_winner, NEW.verified_by, NEW.status, NEW.is_enable, NEW.created_at, NEW.updated_at, NEW.created_by, NEW.updated_by, NEW.deleted_by);
END //
DELIMITER ;

-- 22. AUDIT_LOGS LOG
CREATE TABLE log_audit_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    log_action VARCHAR(20) DEFAULT 'INSERT',
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id INT,
    table_name VARCHAR(50),
    action_type VARCHAR(20),
    record_id INT,
    log_reference VARCHAR(50),
    old_value TEXT,
    new_value TEXT,
    user_id INT,
    ip_address VARCHAR(50),
    user_agent TEXT,
    status ENUM('success','failed','rolled_back'),
    is_enable BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

DELIMITER //
CREATE TRIGGER trg_audit_logs_insert AFTER INSERT ON audit_logs
FOR EACH ROW
BEGIN
    INSERT INTO log_audit_logs (id, table_name, action_type, record_id, log_reference, old_value, new_value, user_id, ip_address, user_agent, status, is_enable, created_at, updated_at, created_by, updated_by, deleted_by)
    VALUES (NEW.id, NEW.table_name, NEW.action_type, NEW.record_id, NEW.log_reference, NEW.old_value, NEW.new_value, NEW.user_id, NEW.ip_address, NEW.user_agent, NEW.status, NEW.is_enable, NEW.created_at, NEW.updated_at, NEW.created_by, NEW.updated_by, NEW.deleted_by);
END //
DELIMITER ;

-- 23. NOTIFICATIONS LOG
CREATE TABLE log_notifications (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    log_action VARCHAR(20) DEFAULT 'INSERT',
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id INT,
    user_id INT,
    notification_type VARCHAR(50),
    title VARCHAR(150),
    message TEXT,
    channel ENUM('email','sms','push','in-app'),
    priority ENUM('critical','high','normal','low'),
    sent_date TIMESTAMP,
    status ENUM('sent','pending','failed','cancelled'),
    is_enable BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

DELIMITER //
CREATE TRIGGER trg_notifications_insert AFTER INSERT ON notifications
FOR EACH ROW
BEGIN
    INSERT INTO log_notifications (id, user_id, notification_type, title, message, channel, priority, sent_date, status, is_enable, created_at, updated_at, created_by, updated_by, deleted_by)
    VALUES (NEW.id, NEW.user_id, NEW.notification_type, NEW.title, NEW.message, NEW.channel, NEW.priority, NEW.sent_date, NEW.status, NEW.is_enable, NEW.created_at, NEW.updated_at, NEW.created_by, NEW.updated_by, NEW.deleted_by);
END //
DELIMITER ;

-- 24. SYSTEM_SETTINGS LOG
CREATE TABLE log_system_settings (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    log_action VARCHAR(20) DEFAULT 'INSERT',
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id INT,
    setting_key VARCHAR(100),
    setting_value TEXT,
    setting_code VARCHAR(30),
    category VARCHAR(50),
    data_type ENUM('string','number','boolean','json'),
    description TEXT,
    is_editable BOOLEAN,
    status ENUM('active','inactive'),
    is_enable BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

DELIMITER //
CREATE TRIGGER trg_system_settings_insert AFTER INSERT ON system_settings
FOR EACH ROW
BEGIN
    INSERT INTO log_system_settings (id, setting_key, setting_value, setting_code, category, data_type, description, is_editable, status, is_enable, created_at, updated_at, created_by, updated_by, deleted_by)
    VALUES (NEW.id, NEW.setting_key, NEW.setting_value, NEW.setting_code, NEW.category, NEW.data_type, NEW.description, NEW.is_editable, NEW.status, NEW.is_enable, NEW.created_at, NEW.updated_at, NEW.created_by, NEW.updated_by, NEW.deleted_by);
END //
DELIMITER ;

-- 25. ELECTION_PHASES LOG
CREATE TABLE log_election_phases (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    log_action VARCHAR(20) DEFAULT 'INSERT',
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id INT,
    election_id INT,
    phase_name VARCHAR(100),
    phase_code VARCHAR(30),
    phase_order INT,
    start_date DATE,
    end_date DATE,
    description TEXT,
    completion_percentage INT,
    responsible_person VARCHAR(100),
    status ENUM('upcoming','active','completed','cancelled','delayed'),
    is_enable BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

DELIMITER //
CREATE TRIGGER trg_election_phases_insert AFTER INSERT ON election_phases
FOR EACH ROW
BEGIN
    INSERT INTO log_election_phases (id, election_id, phase_name, phase_code, phase_order, start_date, end_date, description, completion_percentage, responsible_person, status, is_enable, created_at, updated_at, created_by, updated_by, deleted_by)
    VALUES (NEW.id, NEW.election_id, NEW.phase_name, NEW.phase_code, NEW.phase_order, NEW.start_date, NEW.end_date, NEW.description, NEW.completion_percentage, NEW.responsible_person, NEW.status, NEW.is_enable, NEW.created_at, NEW.updated_at, NEW.created_by, NEW.updated_by, NEW.deleted_by);
END //
DELIMITER ;

-- 26. STATION_RESOURCES LOG
CREATE TABLE log_station_resources (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    log_action VARCHAR(20) DEFAULT 'INSERT',
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id INT,
    station_id INT,
    resource_name VARCHAR(100),
    resource_code VARCHAR(30),
    resource_type VARCHAR(50),
    quantity INT,
    unit_of_measure VARCHAR(20),
    allocation_date DATE,
    condition_notes TEXT,
    last_maintenance DATE,
    status ENUM('available','in-use','damaged','missing','under-maintenance'),
    is_enable BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

DELIMITER //
CREATE TRIGGER trg_station_resources_insert AFTER INSERT ON station_resources
FOR EACH ROW
BEGIN
    INSERT INTO log_station_resources (id, station_id, resource_name, resource_code, resource_type, quantity, unit_of_measure, allocation_date, condition_notes, last_maintenance, status, is_enable, created_at, updated_at, created_by, updated_by, deleted_by)
    VALUES (NEW.id, NEW.station_id, NEW.resource_name, NEW.resource_code, NEW.resource_type, NEW.quantity, NEW.unit_of_measure, NEW.allocation_date, NEW.condition_notes, NEW.last_maintenance, NEW.status, NEW.is_enable, NEW.created_at, NEW.updated_at, NEW.created_by, NEW.updated_by, NEW.deleted_by);
END //
DELIMITER ;

-- 27. CAMPAIGN_EXPENSES LOG
CREATE TABLE log_campaign_expenses (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    log_action VARCHAR(20) DEFAULT 'INSERT',
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id INT,
    candidate_id INT,
    expense_type VARCHAR(50),
    receipt_number VARCHAR(50),
    amount DECIMAL(15,2),
    expense_date DATE,
    description TEXT,
    vendor_name VARCHAR(100),
    payment_method VARCHAR(50),
    verification_notes TEXT,
    verified_by INT,
    status ENUM('verified','pending','rejected','flagged'),
    is_enable BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

DELIMITER //
CREATE TRIGGER trg_campaign_expenses_insert AFTER INSERT ON campaign_expenses
FOR EACH ROW
BEGIN
    INSERT INTO log_campaign_expenses (id, candidate_id, expense_type, receipt_number, amount, expense_date, description, vendor_name, payment_method, verification_notes, verified_by, status, is_enable, created_at, updated_at, created_by, updated_by, deleted_by)
    VALUES (NEW.id, NEW.candidate_id, NEW.expense_type, NEW.receipt_number, NEW.amount, NEW.expense_date, NEW.description, NEW.vendor_name, NEW.payment_method, NEW.verification_notes, NEW.verified_by, NEW.status, NEW.is_enable, NEW.created_at, NEW.updated_at, NEW.created_by, NEW.updated_by, NEW.deleted_by);
END //
DELIMITER ;

-- 28. MEDIA_COVERAGE LOG
CREATE TABLE log_media_coverage (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    log_action VARCHAR(20) DEFAULT 'INSERT',
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id INT,
    election_id INT,
    media_outlet VARCHAR(100),
    headline VARCHAR(255),
    coverage_ref VARCHAR(30),
    coverage_type ENUM('news','interview','debate','analysis'),
    publication_date DATE,
    reporter_name VARCHAR(100),
    media_url VARCHAR(255),
    sentiment ENUM('positive','neutral','negative'),
    reach_estimate INT,
    status ENUM('published','draft','archived','removed'),
    is_enable BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

DELIMITER //
CREATE TRIGGER trg_media_coverage_insert AFTER INSERT ON media_coverage
FOR EACH ROW
BEGIN
    INSERT INTO log_media_coverage (id, election_id, media_outlet, headline, coverage_ref, coverage_type, publication_date, reporter_name, media_url, sentiment, reach_estimate, status, is_enable, created_at, updated_at, created_by, updated_by, deleted_by)
    VALUES (NEW.id, NEW.election_id, NEW.media_outlet, NEW.headline, NEW.coverage_ref, NEW.coverage_type, NEW.publication_date, NEW.reporter_name, NEW.media_url, NEW.sentiment, NEW.reach_estimate, NEW.status, NEW.is_enable, NEW.created_at, NEW.updated_at, NEW.created_by, NEW.updated_by, NEW.deleted_by);
END //
DELIMITER ;

-- 29. SECURITY_INCIDENTS LOG
CREATE TABLE log_security_incidents (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    log_action VARCHAR(20) DEFAULT 'INSERT',
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id INT,
    station_id INT,
    reported_by INT,
    incident_type VARCHAR(50),
    severity VARCHAR(20),
    description TEXT,
    resolution_notes TEXT,
    resolved_date DATE,
    status ENUM('reported','investigating','resolved','closed','escalated'),
    is_enable BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

DELIMITER //
CREATE TRIGGER trg_security_incidents_insert AFTER INSERT ON security_incidents
FOR EACH ROW
BEGIN
    INSERT INTO log_security_incidents (id, station_id, reported_by, incident_type, severity, description, resolution_notes, resolved_date, status, is_enable, created_at, updated_at, created_by, updated_by, deleted_by)
    VALUES (NEW.id, NEW.station_id, NEW.reported_by, NEW.incident_type, NEW.severity, NEW.description, NEW.resolution_notes, NEW.resolved_date, NEW.status, NEW.is_enable, NEW.created_at, NEW.updated_at, NEW.created_by, NEW.updated_by, NEW.deleted_by);
END //
DELIMITER ;

-- 30. BALLOT_PAPERS LOG
CREATE TABLE log_ballot_papers (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    log_action VARCHAR(20) DEFAULT 'INSERT',
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id INT,
    election_id INT,
    station_id INT,
    ballot_number VARCHAR(30),
    serial_number VARCHAR(50),
    batch_number VARCHAR(30),
    print_date DATE,
    distribution_date DATE,
    status ENUM('issued','used','spoiled','unused','returned'),
    is_enable BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

DELIMITER //
CREATE TRIGGER trg_ballot_papers_insert AFTER INSERT ON ballot_papers
FOR EACH ROW
BEGIN
    INSERT INTO log_ballot_papers (id, election_id, station_id, ballot_number, serial_number, batch_number, print_date, distribution_date, status, is_enable, created_at, updated_at, created_by, updated_by, deleted_by)
    VALUES (NEW.id, NEW.election_id, NEW.station_id, NEW.ballot_number, NEW.serial_number, NEW.batch_number, NEW.print_date, NEW.distribution_date, NEW.status, NEW.is_enable, NEW.created_at, NEW.updated_at, NEW.created_by, NEW.updated_by, NEW.deleted_by);
END //
DELIMITER ;

-- 31. VOTER_TURNOUT LOG
CREATE TABLE log_voter_turnout (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    log_action VARCHAR(20) DEFAULT 'INSERT',
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id INT,
    election_id INT,
    station_id INT,
    total_registered INT,
    total_voted INT,
    male_voters INT,
    female_voters INT,
    turnout_percentage DECIMAL(5,2),
    recorded_by INT,
    status ENUM('active','completed','verified','disputed'),
    is_enable BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

DELIMITER //
CREATE TRIGGER trg_voter_turnout_insert AFTER INSERT ON voter_turnout
FOR EACH ROW
BEGIN
    INSERT INTO log_voter_turnout (id, election_id, station_id, total_registered, total_voted, male_voters, female_voters, turnout_percentage, recorded_by, status, is_enable, created_at, updated_at, created_by, updated_by, deleted_by)
    VALUES (NEW.id, NEW.election_id, NEW.station_id, NEW.total_registered, NEW.total_voted, NEW.male_voters, NEW.female_voters, NEW.turnout_percentage, NEW.recorded_by, NEW.status, NEW.is_enable, NEW.created_at, NEW.updated_at, NEW.created_by, NEW.updated_by, NEW.deleted_by);
END //
DELIMITER ;

-- 32. OBSERVER_REPORTS LOG
CREATE TABLE log_observer_reports (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    log_action VARCHAR(20) DEFAULT 'INSERT',
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id INT,
    agent_id INT,
    station_id INT,
    report_summary TEXT,
    observation_date DATE,
    issues_found TEXT,
    recommendations TEXT,
    status ENUM('pending','reviewed','archived','reject'),
    is_enable BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

DELIMITER //
CREATE TRIGGER trg_observer_reports_insert AFTER INSERT ON observer_reports
FOR EACH ROW
BEGIN
    INSERT INTO log_observer_reports (id, agent_id, station_id, report_summary, observation_date, issues_found, recommendations, status, is_enable, created_at, updated_at, created_by, updated_by, deleted_by)
    VALUES (NEW.id, NEW.agent_id, NEW.station_id, NEW.report_summary, NEW.observation_date, NEW.issues_found, NEW.recommendations, NEW.status, NEW.is_enable, NEW.created_at, NEW.updated_at, NEW.created_by, NEW.updated_by, NEW.deleted_by);
END //
DELIMITER ;

-- 33. CANDIDATE_MANIFESTO LOG
CREATE TABLE log_candidate_manifesto (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    log_action VARCHAR(20) DEFAULT 'INSERT',
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id INT,
    candidate_id INT,
    manifesto_title VARCHAR(200),
    content TEXT,
    key_points TEXT,
    views_count INT,
    status ENUM('draft','published','archived','withdrawn'),
    is_enable BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

DELIMITER //
CREATE TRIGGER trg_candidate_manifesto_insert AFTER INSERT ON candidate_manifesto
FOR EACH ROW
BEGIN
    INSERT INTO log_candidate_manifesto (id, candidate_id, manifesto_title, content, key_points, views_count, status, is_enable, created_at, updated_at, created_by, updated_by, deleted_by)
    VALUES (NEW.id, NEW.candidate_id, NEW.manifesto_title, NEW.content, NEW.key_points, NEW.views_count, NEW.status, NEW.is_enable, NEW.created_at, NEW.updated_at, NEW.created_by, NEW.updated_by, NEW.deleted_by);
END //
DELIMITER ;

-- 34. PARTY_ALLIANCES LOG
CREATE TABLE log_party_alliances (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    log_action VARCHAR(20) DEFAULT 'INSERT',
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id INT,
    party_id INT,
    allied_party_id INT,
    alliance_name VARCHAR(100),
    alliance_code VARCHAR(30),
    formation_date DATE,
    agreement_terms TEXT,
    contact_email VARCHAR(100),
    status ENUM('active','dissolved','suspended','negotiating'),
    is_enable BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

DELIMITER //
CREATE TRIGGER trg_party_alliances_insert AFTER INSERT ON party_alliances
FOR EACH ROW
BEGIN
    INSERT INTO log_party_alliances (id, party_id, allied_party_id, alliance_name, alliance_code, formation_date, agreement_terms, contact_email, status, is_enable, created_at, updated_at, created_by, updated_by, deleted_by)
    VALUES (NEW.id, NEW.party_id, NEW.allied_party_id, NEW.alliance_name, NEW.alliance_code, NEW.formation_date, NEW.agreement_terms, NEW.contact_email, NEW.status, NEW.is_enable, NEW.created_at, NEW.updated_at, NEW.created_by, NEW.updated_by, NEW.deleted_by);
END //
DELIMITER ;

-- 35. ELECTION_BUDGETS LOG
CREATE TABLE log_election_budgets (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    log_action VARCHAR(20) DEFAULT 'INSERT',
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id INT,
    election_id INT,
    budget_category VARCHAR(50),
    budget_ref VARCHAR(30),
    allocated_amount DECIMAL(15,2),
    spent_amount DECIMAL(15,2),
    status ENUM('approved','pending','rejected','exhausted'),
    is_enable BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted_by INT
);

DELIMITER //
CREATE TRIGGER trg_election_budgets_insert AFTER INSERT ON election_budgets
FOR EACH ROW
BEGIN
    INSERT INTO log_election_budgets (id, election_id, budget_category, budget_ref, allocated_amount, spent_amount, status, is_enable, created_at, updated_at, created_by, updated_by, deleted_by)
    VALUES (NEW.id, NEW.election_id, NEW.budget_category, NEW.budget_ref, NEW.allocated_amount, NEW.spent_amount, NEW.status, NEW.is_enable, NEW.created_at, NEW.updated_at, NEW.created_by, NEW.updated_by, NEW.deleted_by);
END //
DELIMITER ;

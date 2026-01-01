-- ============================================
-- DATABASE SCHEMA SUMMARY
-- Quick Reference Guide
-- ============================================

/*
╔══════════════════════════════════════════════════════════════════════════════╗
║                    ELECTION MANAGEMENT SYSTEM DATABASE                        ║
║                         38 Normalized MySQL Tables                            ║
╚══════════════════════════════════════════════════════════════════════════════╝

DATABASE: election_system
CHARSET: utf8mb4
COLLATION: utf8mb4_unicode_ci
ENGINE: InnoDB
TOTAL TABLES: 38

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📋 TABLE CATEGORIES

1. Core User & Authentication (7 tables)
   ├── roles
   ├── users
   ├── user_contact_numbers
   ├── user_roles
   ├── admins
   ├── voter_verification
   └── password_reset_tokens

2. Election Management (6 tables)
   ├── elections
   ├── election_status_history
   ├── election_commission_members
   ├── districts
   ├── polling_stations
   └── polling_station_addresses

3. Candidate & Party (8 tables)
   ├── parties
   ├── positions
   ├── party_positions
   ├── candidates
   ├── candidate_districts
   ├── document_types
   ├── candidate_documents
   └── candidate_approvals

4. Voting & Polling (6 tables)
   ├── voters
   ├── voter_stations
   ├── polling_officers
   ├── election_agents
   ├── votes
   └── candidate_vote_counts

5. Complaint Management (9 tables)
   ├── complaint_categories
   ├── complaint_against_types
   ├── complaints
   ├── complaint_status_history
   ├── complaint_resolutions
   ├── complaint_assignments
   ├── complaint_evidence
   ├── polling_officer_incidents
   └── election_agent_observations

6. System & Audit (2 tables)
   ├── audit_logs
   └── system_configurations

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔐 STANDARDIZED AUDIT FIELDS (All 38 Tables)

1. status          VARCHAR(50)      DEFAULT 'active'
2. is_enable       TINYINT(1)       DEFAULT 1
3. created_at      TIMESTAMP        DEFAULT CURRENT_TIMESTAMP
4. updated_at      TIMESTAMP        ON UPDATE CURRENT_TIMESTAMP
5. created_by      BIGINT UNSIGNED  NULL → FK to users(id)
6. updated_by      BIGINT UNSIGNED  NULL → FK to users(id)
7. deleted_by      BIGINT UNSIGNED  NULL → FK to users(id)
8. deleted_at      TIMESTAMP        NULL (bonus field)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 TABLE RELATIONSHIPS

users (Central Hub)
  ├── user_contact_numbers (1:M)
  ├── user_roles (M:M via roles)
  ├── admins (1:1)
  ├── voter_verification (1:1)
  ├── voters (1:1)
  ├── candidates (1:1)
  ├── polling_officers (1:1)
  ├── election_agents (1:1)
  ├── election_commission_members (1:1)
  └── complaints (1:M as filer)

elections
  ├── candidates (1:M)
  ├── voters (1:M)
  ├── polling_stations (1:M)
  ├── votes (1:M)
  └── complaints (1:M)

candidates
  ├── candidate_districts (M:M with districts)
  ├── candidate_documents (1:M)
  ├── candidate_approvals (1:M)
  ├── candidate_vote_counts (1:M)
  ├── votes (1:M)
  └── election_agents (1:M)

parties
  ├── party_positions (M:M with positions)
  └── candidates (1:M)

polling_stations
  ├── polling_station_addresses (1:1)
  ├── voter_stations (1:M)
  ├── polling_officers (1:M)
  ├── election_agents (1:M)
  └── votes (1:M)

complaints
  ├── complaint_status_history (1:M)
  ├── complaint_resolutions (1:1)
  ├── complaint_assignments (1:M)
  ├── complaint_evidence (1:M)
  ├── polling_officer_incidents (M:M)
  └── election_agent_observations (M:M)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🚀 QUICK START COMMANDS

-- Create Database
CREATE DATABASE election_system CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Execute Schema (from MySQL command line or workbench)
USE election_system;
SOURCE 01_core_user_tables.sql;
SOURCE 02_election_management_tables.sql;
SOURCE 03_candidate_party_tables.sql;
SOURCE 04_voting_polling_tables.sql;
SOURCE 05_complaint_tables.sql;
SOURCE 06_system_audit_tables.sql;

-- Or execute master file
SOURCE 00_MASTER_SCHEMA.sql;

-- Verify Installation
SELECT COUNT(*) as total_tables FROM information_schema.tables 
WHERE table_schema = 'election_system';
-- Expected result: 38

SHOW TABLES;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📈 KEY METRICS

┌─────────────────────────────┬──────────┐
│ Metric                      │ Value    │
├─────────────────────────────┼──────────┤
│ Total Tables                │ 38       │
│ Master Data Tables          │ 6        │
│ Junction Tables (M:M)       │ 8        │
│ History/Audit Tables        │ 4        │
│ Foreign Key Constraints     │ 100+     │
│ Indexes                     │ 150+     │
│ Unique Constraints          │ 30+      │
│ Audit Fields per Table      │ 8        │
│ Average Fields per Table    │ 15-20    │
└─────────────────────────────┴──────────┘

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔍 COMMON QUERIES

-- Get all active elections
SELECT * FROM elections WHERE status = 'active' AND election_status = 'running';

-- Count voters per district
SELECT d.name, COUNT(vs.voter_id) as voter_count
FROM districts d
LEFT JOIN polling_stations ps ON d.id = ps.district_id
LEFT JOIN voter_stations vs ON ps.id = vs.polling_station_id
GROUP BY d.id;

-- Get election results
SELECT 
    c.id,
    CONCAT(u.first_name, ' ', u.last_name) as candidate_name,
    p.name as party,
    pos.position_name,
    COALESCE(cvc.total_votes, 0) as votes
FROM candidates c
JOIN users u ON c.user_id = u.id
JOIN parties p ON c.party_id = p.id
JOIN positions pos ON c.position_id = pos.id
LEFT JOIN candidate_vote_counts cvc ON c.id = cvc.candidate_id
WHERE c.election_id = ? AND c.candidate_status = 'approved'
ORDER BY cvc.total_votes DESC;

-- Get pending complaints
SELECT 
    c.id,
    c.complaint_title,
    c.created_at,
    c.priority,
    CONCAT(u.first_name, ' ', u.last_name) as filed_by
FROM complaints c
LEFT JOIN users u ON c.filed_by_user_id = u.id
WHERE c.complaint_status = 'pending'
ORDER BY c.priority DESC, c.created_at ASC;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ VALIDATION CHECKLIST

[✓] All 38 tables created
[✓] All tables have 8 audit fields
[✓] All foreign keys properly defined
[✓] All indexes created
[✓] All unique constraints in place
[✓] Master data pre-populated
[✓] Proper character encoding (utf8mb4)
[✓] InnoDB engine for all tables
[✓] Cascading rules defined
[✓] Soft delete support implemented

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📚 FILES REFERENCE

00_MASTER_SCHEMA.sql             Master orchestration file
01_core_user_tables.sql          User & authentication (7 tables)
02_election_management_tables.sql Election system (6 tables)
03_candidate_party_tables.sql    Candidates & parties (8 tables)
04_voting_polling_tables.sql     Voting system (6 tables)
05_complaint_tables.sql          Complaints (9 tables)
06_system_audit_tables.sql       Audit & config (2 tables)
README.md                        Complete documentation
SCHEMA_SUMMARY.sql               This file

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Generated: 2026-01-02
Version: 1.0
Schema Status: ✅ PRODUCTION READY

╚══════════════════════════════════════════════════════════════════════════════╝
*/

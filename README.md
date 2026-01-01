# MySQL Database Schema - Election Management System

## Overview

This directory contains the complete MySQL database schema for the Election Management System, converted from 13 Mongoose (MongoDB) models into **38 fully normalized MySQL tables**.

## 📊 Schema Statistics

- **Total Tables**: 38
- **Source Mongoose Models**: 13
- **Normalization Level**: 3NF (Third Normal Form)
- **All tables include**: 8 standardized audit fields

## 🗂️ File Structure

```
database/
├── 00_MASTER_SCHEMA.sql          # Master orchestration file
├── 01_core_user_tables.sql       # 7 tables - User & Auth
├── 02_election_management_tables.sql  # 6 tables - Elections
├── 03_candidate_party_tables.sql # 8 tables - Candidates & Parties
├── 04_voting_polling_tables.sql  # 6 tables - Voting & Polling
├── 05_complaint_tables.sql       # 9 tables - Complaints
├── 06_system_audit_tables.sql    # 2 tables - Audit & Config
└── README.md                     # This file
```

## 📋 Table Breakdown

### Core User & Authentication Tables (7)

1. **roles** - Master data for user roles
2. **users** - Base table for all users
3. **user_contact_numbers** - Normalized phone numbers
4. **user_roles** - User-to-role assignments (many-to-many)
5. **admins** - Admin-specific data
6. **voter_verification** - Voter biometric/device verification
7. **password_reset_tokens** - Password reset management

### Election Management Tables (6)

8. **elections** - Election events
9. **election_status_history** - Election status audit trail
10. **election_commission_members** - Election commission staff
11. **districts** - Geographic districts
12. **polling_stations** - Polling locations
13. **polling_station_addresses** - Normalized address data

### Candidate & Party Tables (8)

14. **parties** - Political parties
15. **positions** - Electoral positions (NA, PP, PS, PB, PK)
16. **party_positions** - Positions parties contest (many-to-many)
17. **candidates** - Candidate registrations
18. **candidate_districts** - Candidate-district assignments (many-to-many)
19. **document_types** - Master data for required documents
20. **candidate_documents** - Candidate submitted documents
21. **candidate_approvals** - Approval workflow history

### Voting & Polling Tables (6)

22. **voters** - Voter registrations
23. **voter_stations** - Voter-station assignments with history
24. **polling_officers** - Polling officer assignments
25. **election_agents** - Election agent/monitor assignments
26. **votes** - Individual vote records (blockchain integration)
27. **candidate_vote_counts** - Aggregated vote counts (performance)

### Complaint & Issue Management Tables (9)

28. **complaint_categories** - Complaint category master data
29. **complaint_against_types** - Entity types for complaints
30. **complaints** - Complaint registrations
31. **complaint_status_history** - Complaint status audit trail
32. **complaint_resolutions** - Resolution details
33. **complaint_assignments** - Complaint-to-investigator assignments
34. **complaint_evidence** - Evidence/attachments
35. **polling_officer_incidents** - Officer-reported incidents
36. **election_agent_observations** - Agent observations

### System Audit & Utility Tables (2)

37. **audit_logs** - System-wide comprehensive audit trail
38. **system_configurations** - Application settings

## 🔑 Standardized Audit Fields

Every table includes these 8 audit fields:

```sql
status VARCHAR(50) DEFAULT 'active' COMMENT 'Record status'
is_enable TINYINT(1) DEFAULT 1 COMMENT 'Enable/disable flag'
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation timestamp'
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update timestamp'
created_by BIGINT UNSIGNED NULL COMMENT 'User who created the record'
updated_by BIGINT UNSIGNED NULL COMMENT 'User who last updated the record'
deleted_by BIGINT UNSIGNED NULL COMMENT 'User who soft-deleted the record'
deleted_at TIMESTAMP NULL COMMENT 'Soft delete timestamp'
```

## 🚀 Installation & Usage

### Option 1: Execute Master Script (Recommended)

```bash
# Login to MySQL
mysql -u root -p

# Execute master schema
source 00_MASTER_SCHEMA.sql
```

### Option 2: Execute Individual Files

```bash
mysql -u root -p < 01_core_user_tables.sql
mysql -u root -p < 02_election_management_tables.sql
mysql -u root -p < 03_candidate_party_tables.sql
mysql -u root -p < 04_voting_polling_tables.sql
mysql -u root -p < 05_complaint_tables.sql
mysql -u root -p < 06_system_audit_tables.sql
```

### Option 3: Using MySQL Workbench

1. Open MySQL Workbench
2. Connect to your database server
3. Go to File → Run SQL Script
4. Select `00_MASTER_SCHEMA.sql`
5. Click Run

## 📝 Mongoose to MySQL Mapping

| Mongoose Model            | MySQL Tables                                                                                                                                          | Count |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- | ----- |
| AdminModel                | admins, password_reset_tokens                                                                                                                         | 2     |
| UserModel                 | users, user_contact_numbers, user_roles, voter_verification                                                                                           | 4     |
| VoterModel/voter.model.js | voters, voter_stations, voter_verification                                                                                                            | 3     |
| ElectionCommissionModel   | election_commission_members                                                                                                                           | 1     |
| ElectionModel             | elections, election_status_history                                                                                                                    | 2     |
| CandidateModel            | candidates, candidate_districts, candidate_documents, candidate_approvals, candidate_vote_counts                                                      | 5     |
| PartyModel                | parties, party_positions                                                                                                                              | 2     |
| DistrictModel             | districts                                                                                                                                             | 1     |
| PollingStationModel       | polling_stations, polling_station_addresses                                                                                                           | 2     |
| PollingOfficerModel       | polling_officers, polling_officer_incidents                                                                                                           | 2     |
| ElectionAgentModel        | election_agents, election_agent_observations                                                                                                          | 2     |
| ComplaintModel            | complaints, complaint_categories, complaint_against_types, complaint_status_history, complaint_resolutions, complaint_assignments, complaint_evidence | 7     |
| (New)                     | roles, positions, document_types, votes, audit_logs, system_configurations                                                                            | 6     |

## ✨ Key Improvements

### 1. **Proper Normalization**

- Array fields converted to separate tables
- Nested objects decomposed
- Eliminated data redundancy

### 2. **Data Integrity**

- Foreign key constraints
- Referential integrity
- Cascading deletes/updates

### 3. **Master Data Tables**

- roles
- positions
- document_types
- complaint_categories
- complaint_against_types

### 4. **Audit Trail**

- Comprehensive tracking across all tables
- Status history tables for workflows
- System-wide audit_logs table

### 5. **Performance Optimization**

- Proper indexes on foreign keys
- Indexes on frequently queried fields
- Denormalized vote counts table

### 6. **Soft Deletes**

- deleted_by and deleted_at fields
- Data retention for compliance
- Easy recovery of deleted records

## 🔄 Migration Considerations

### Breaking Changes

- API responses will need restructuring
- Queries require JOINs instead of nested access
- ObjectId → BIGINT conversion needed

### Data Migration Steps

1. Export MongoDB data
2. Transform array fields to multiple rows
3. Extract nested objects
4. Convert ObjectIds to BIGINT
5. Import to MySQL tables

## 📊 Example Queries

### Get all voters with their contact info

```sql
SELECT
    u.id, u.first_name, u.last_name, u.cnic_number,
    GROUP_CONCAT(ucn.contact_number) as phone_numbers
FROM users u
LEFT JOIN user_contact_numbers ucn ON u.id = ucn.user_id
INNER JOIN user_roles ur ON u.id = ur.user_id
INNER JOIN roles r ON ur.role_id = r.id
WHERE r.role_name = 'Voter'
GROUP BY u.id;
```

### Get election results for a district

```sql
SELECT
    u.first_name, u.last_name,
    p.name as party_name, p.symbol,
    pos.position_name,
    cvc.total_votes,
    d.name as district_name
FROM candidates c
INNER JOIN users u ON c.user_id = u.id
INNER JOIN parties p ON c.party_id = p.id
INNER JOIN positions pos ON c.position_id = pos.id
INNER JOIN candidate_vote_counts cvc ON c.id = cvc.candidate_id
INNER JOIN districts d ON cvc.district_id = d.id
WHERE d.id = 1 AND c.election_id = 1
ORDER BY cvc.total_votes DESC;
```

### Get complaint history with status changes

```sql
SELECT
    c.id, c.complaint_title, c.description,
    cs.old_status, cs.new_status, cs.change_timestamp,
    u.first_name as changed_by
FROM complaints c
LEFT JOIN complaint_status_history cs ON c.id = cs.complaint_id
LEFT JOIN users u ON cs.changed_by_user_id = u.id
WHERE c.id = 1
ORDER BY cs.change_timestamp DESC;
```

## 🛠️ Database Configuration

Recommended MySQL configuration for this schema:

```ini
[mysqld]
# InnoDB settings
innodb_buffer_pool_size = 1G
innodb_log_file_size = 256M
innodb_flush_log_at_trx_commit = 2

# Character set
character-set-server = utf8mb4
collation-server = utf8mb4_unicode_ci

# Max connections
max_connections = 200

# Query cache (MySQL 5.7)
query_cache_type = 1
query_cache_size = 64M
```

## 📚 Additional Resources

- [Implementation Plan](../brain/implementation_plan.md) - Detailed conversion strategy
- [Task Checklist](../brain/task.md) - Migration task tracking

## 🤝 Support

For issues or questions regarding the schema:

1. Review the implementation plan
2. Check the Mongoose model comments
3. Verify foreign key relationships
4. Ensure proper execution order

## 📄 License

This schema is part of the Election Management System project.

---

**Generated**: 2026-01-02  
**Version**: 1.0  
**Total Tables**: 38  
**Normalization**: 3NF

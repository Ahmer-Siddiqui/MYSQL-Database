-- ============================================
-- COMPLETE MYSQL DATABASE SCHEMA
-- Election Management System
-- Total Tables: 38 (Normalized from 13 Mongoose Models)
-- ============================================
-- 
-- IMPORTANT: Execute this script in order as foreign keys depend on tables being created first
-- Database: election_system
-- Version: 1.0
-- Created: 2026-01-02
--
-- ============================================

-- Create database
CREATE DATABASE IF NOT EXISTS election_system
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE election_system;

-- ============================================
-- SECTION 1: Core User & Authentication Tables (7 tables)
-- ============================================

-- SOURCE: 01_core_user_tables.sql
-- Run tables 1-7: roles, users, user_contact_numbers, user_roles, admins, voter_verification, password_reset_tokens

\. 01_core_user_tables.sql

-- ============================================
-- SECTION 2: Election Management Tables (6 tables)
-- ============================================

-- SOURCE: 02_election_management_tables.sql
-- Run tables 8-13: elections, election_status_history, election_commission_members, districts, polling_stations, polling_station_addresses

\. 02_election_management_tables.sql

-- ============================================
-- SECTION 3: Candidate & Party Tables (8 tables)
-- ============================================

-- SOURCE: 03_candidate_party_tables.sql
-- Run tables 14-21: parties, positions, party_positions, candidates, candidate_districts, document_types, candidate_documents, candidate_approvals

\. 03_candidate_party_tables.sql

-- ============================================
-- SECTION 4: Voting & Polling Tables (6 tables)
-- ============================================

-- SOURCE: 04_voting_polling_tables.sql
-- Run tables 22-27: voters, voter_stations, polling_officers, election_agents, votes, candidate_vote_counts

\. 04_voting_polling_tables.sql

-- ============================================
-- SECTION 5: Complaint & Issue Management Tables (9 tables)
-- ============================================

-- SOURCE: 05_complaint_tables.sql
-- Run tables 28-36: complaint_categories, complaint_against_types, complaints, complaint_status_history, complaint_resolutions, complaint_assignments, complaint_evidence, polling_officer_incidents, election_agent_observations

\. 05_complaint_tables.sql

-- ============================================
-- SECTION 6: System Audit & Utility Tables (2 tables)
-- ============================================

-- SOURCE: 06_system_audit_tables.sql
-- Run tables 37-38: audit_logs, system_configurations

\. 06_system_audit_tables.sql

-- ============================================
-- SCHEMA STATISTICS
-- ============================================
-- Total Tables: 38
-- Total Normalized from: 13 Mongoose Models
-- 
-- Breakdown by Category:
-- - User & Authentication: 7 tables
-- - Election Management: 6 tables
-- - Candidate & Party: 8 tables
-- - Voting & Polling: 6 tables
-- - Complaint Management: 9 tables
-- - System & Audit: 2 tables
--
-- All tables include 7 standardized audit fields:
-- 1. status
-- 2. is_enable
-- 3. created_at
-- 4. updated_at
-- 5. created_by
-- 6. updated_by
-- 7. deleted_by
-- 8. deleted_at (bonus field for soft deletes)
-- ============================================

-- Verify table count
SELECT 
    COUNT(*) as total_tables,
    'Election System Database' as database_name
FROM information_schema.tables 
WHERE table_schema = 'election_system';

-- Show all tables
SHOW TABLES;

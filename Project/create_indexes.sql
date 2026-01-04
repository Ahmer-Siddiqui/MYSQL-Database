-- =====================================================
--      ELECTION MANAGEMENT SYSTEM - Non-Clustered Indexes
--      Comprehensive Index Creation for All Tables
-- =====================================================

-- =====================================================
-- 1. ADMINS TABLE INDEXES
-- =====================================================
CREATE INDEX idx_admins_email ON admins(email);
CREATE INDEX idx_admins_name ON admins(name);
CREATE INDEX idx_admins_status ON admins(status);
CREATE INDEX idx_admins_is_enable ON admins(is_enable);
CREATE INDEX idx_admins_created_at ON admins(created_at);
CREATE INDEX idx_admins_updated_at ON admins(updated_at);
CREATE INDEX idx_admins_date_of_birth ON admins(date_of_birth);
CREATE INDEX idx_admins_created_by ON admins(created_by);
CREATE INDEX idx_admins_updated_by ON admins(updated_by);
CREATE INDEX idx_admins_deleted_by ON admins(deleted_by);

-- =====================================================
-- 2. USERS TABLE INDEXES
-- =====================================================
CREATE INDEX idx_users_cnic_number ON users(cnic_number);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_first_name ON users(first_name);
CREATE INDEX idx_users_last_name ON users(last_name);
CREATE INDEX idx_users_phone ON users(phone);
CREATE INDEX idx_users_city ON users(city);
CREATE INDEX idx_users_gender ON users(gender);
CREATE INDEX idx_users_status ON users(status);
CREATE INDEX idx_users_is_enable ON users(is_enable);
CREATE INDEX idx_users_created_at ON users(created_at);
CREATE INDEX idx_users_updated_at ON users(updated_at);
CREATE INDEX idx_users_date_of_birth ON users(date_of_birth);
CREATE INDEX idx_users_created_by ON users(created_by);
CREATE INDEX idx_users_updated_by ON users(updated_by);
CREATE INDEX idx_users_deleted_by ON users(deleted_by);

-- =====================================================
-- 3. ROLES TABLE INDEXES
-- =====================================================
CREATE INDEX idx_roles_role_name ON roles(role_name);
CREATE INDEX idx_roles_role_code ON roles(role_code);
CREATE INDEX idx_roles_status ON roles(status);
CREATE INDEX idx_roles_priority_level ON roles(priority_level);
CREATE INDEX idx_roles_is_enable ON roles(is_enable);
CREATE INDEX idx_roles_created_at ON roles(created_at);
CREATE INDEX idx_roles_updated_at ON roles(updated_at);
CREATE INDEX idx_roles_created_by ON roles(created_by);
CREATE INDEX idx_roles_updated_by ON roles(updated_by);
CREATE INDEX idx_roles_deleted_by ON roles(deleted_by);

-- =====================================================
-- 4. USER_ROLES TABLE INDEXES
-- =====================================================
CREATE INDEX idx_user_roles_user_id ON user_roles(user_id);
CREATE INDEX idx_user_roles_role_id ON user_roles(role_id);
CREATE INDEX idx_user_roles_assigned_date ON user_roles(assigned_date);
CREATE INDEX idx_user_roles_expiry_date ON user_roles(expiry_date);
CREATE INDEX idx_user_roles_status ON user_roles(status);
CREATE INDEX idx_user_roles_is_enable ON user_roles(is_enable);
CREATE INDEX idx_user_roles_created_at ON user_roles(created_at);
CREATE INDEX idx_user_roles_updated_at ON user_roles(updated_at);
CREATE INDEX idx_user_roles_created_by ON user_roles(created_by);
CREATE INDEX idx_user_roles_updated_by ON user_roles(updated_by);
CREATE INDEX idx_user_roles_deleted_by ON user_roles(deleted_by);

-- =====================================================
-- 5. ELECTIONS TABLE INDEXES
-- =====================================================
CREATE INDEX idx_elections_title ON elections(title);
CREATE INDEX idx_elections_election_code ON elections(election_code);
CREATE INDEX idx_elections_election_type ON elections(election_type);
CREATE INDEX idx_elections_start_date ON elections(start_date);
CREATE INDEX idx_elections_end_date ON elections(end_date);
CREATE INDEX idx_elections_status ON elections(status);
CREATE INDEX idx_elections_is_enable ON elections(is_enable);
CREATE INDEX idx_elections_created_at ON elections(created_at);
CREATE INDEX idx_elections_updated_at ON elections(updated_at);
CREATE INDEX idx_elections_total_seats ON elections(total_seats);
CREATE INDEX idx_elections_total_candidates ON elections(total_candidates);
CREATE INDEX idx_elections_total_voters ON elections(total_voters);
CREATE INDEX idx_elections_created_by ON elections(created_by);
CREATE INDEX idx_elections_updated_by ON elections(updated_by);
CREATE INDEX idx_elections_deleted_by ON elections(deleted_by);

-- =====================================================
-- 6. ELECTION_COMMISSION TABLE INDEXES
-- =====================================================
CREATE INDEX idx_election_commission_user_id ON election_commission(user_id);
CREATE INDEX idx_election_commission_commission_code ON election_commission(commission_code);
CREATE INDEX idx_election_commission_designation ON election_commission(designation);
CREATE INDEX idx_election_commission_appointment_date ON election_commission(appointment_date);
CREATE INDEX idx_election_commission_authority_level ON election_commission(authority_level);
CREATE INDEX idx_election_commission_status ON election_commission(status);
CREATE INDEX idx_election_commission_is_enable ON election_commission(is_enable);
CREATE INDEX idx_election_commission_created_at ON election_commission(created_at);
CREATE INDEX idx_election_commission_updated_at ON election_commission(updated_at);
CREATE INDEX idx_election_commission_created_by ON election_commission(created_by);
CREATE INDEX idx_election_commission_updated_by ON election_commission(updated_by);
CREATE INDEX idx_election_commission_deleted_by ON election_commission(deleted_by);

-- =====================================================
-- 7. CITIES TABLE INDEXES
-- =====================================================
CREATE INDEX idx_cities_city_name ON cities(city_name);
CREATE INDEX idx_cities_province ON cities(province);
CREATE INDEX idx_cities_country ON cities(country);
CREATE INDEX idx_cities_population ON cities(population);
CREATE INDEX idx_cities_status ON cities(status);
CREATE INDEX idx_cities_is_enable ON cities(is_enable);
CREATE INDEX idx_cities_created_at ON cities(created_at);
CREATE INDEX idx_cities_updated_at ON cities(updated_at);
CREATE INDEX idx_cities_created_by ON cities(created_by);
CREATE INDEX idx_cities_updated_by ON cities(updated_by);
CREATE INDEX idx_cities_deleted_by ON cities(deleted_by);

-- =====================================================
-- 8. DISTRICTS TABLE INDEXES
-- =====================================================
CREATE INDEX idx_districts_district_name ON districts(district_name);
CREATE INDEX idx_districts_city_id ON districts(city_id);
CREATE INDEX idx_districts_district_code ON districts(district_code);
CREATE INDEX idx_districts_district_type ON districts(district_type);
CREATE INDEX idx_districts_population ON districts(population);
CREATE INDEX idx_districts_total_stations ON districts(total_stations);
CREATE INDEX idx_districts_status ON districts(status);
CREATE INDEX idx_districts_is_enable ON districts(is_enable);
CREATE INDEX idx_districts_created_at ON districts(created_at);
CREATE INDEX idx_districts_updated_at ON districts(updated_at);
CREATE INDEX idx_districts_created_by ON districts(created_by);
CREATE INDEX idx_districts_updated_by ON districts(updated_by);
CREATE INDEX idx_districts_deleted_by ON districts(deleted_by);

-- =====================================================
-- 9. POLLING_STATIONS TABLE INDEXES
-- =====================================================
CREATE INDEX idx_polling_stations_station_name ON polling_stations(station_name);
CREATE INDEX idx_polling_stations_location ON polling_stations(location);
CREATE INDEX idx_polling_stations_district_id ON polling_stations(district_id);
CREATE INDEX idx_polling_stations_registered_voters ON polling_stations(registered_voters);
CREATE INDEX idx_polling_stations_status ON polling_stations(status);
CREATE INDEX idx_polling_stations_is_enable ON polling_stations(is_enable);
CREATE INDEX idx_polling_stations_created_at ON polling_stations(created_at);
CREATE INDEX idx_polling_stations_updated_at ON polling_stations(updated_at);
CREATE INDEX idx_polling_stations_created_by ON polling_stations(created_by);
CREATE INDEX idx_polling_stations_updated_by ON polling_stations(updated_by);
CREATE INDEX idx_polling_stations_deleted_by ON polling_stations(deleted_by);

-- =====================================================
-- 10. POLITICAL_PARTIES TABLE INDEXES
-- =====================================================
CREATE INDEX idx_political_parties_party_name ON political_parties(party_name);
CREATE INDEX idx_political_parties_party_code ON political_parties(party_code);
CREATE INDEX idx_political_parties_founder ON political_parties(founder);
CREATE INDEX idx_political_parties_status ON political_parties(status);
CREATE INDEX idx_political_parties_is_enable ON political_parties(is_enable);
CREATE INDEX idx_political_parties_created_at ON political_parties(created_at);
CREATE INDEX idx_political_parties_updated_at ON political_parties(updated_at);
CREATE INDEX idx_political_parties_created_by ON political_parties(created_by);
CREATE INDEX idx_political_parties_updated_by ON political_parties(updated_by);
CREATE INDEX idx_political_parties_deleted_by ON political_parties(deleted_by);

-- =====================================================
-- 11. POSITIONS TABLE INDEXES
-- =====================================================
CREATE INDEX idx_positions_position_code ON positions(position_code);
CREATE INDEX idx_positions_position_name ON positions(position_name);
CREATE INDEX idx_positions_position_level ON positions(position_level);
CREATE INDEX idx_positions_status ON positions(status);
CREATE INDEX idx_positions_is_enable ON positions(is_enable);
CREATE INDEX idx_positions_created_at ON positions(created_at);
CREATE INDEX idx_positions_updated_at ON positions(updated_at);
CREATE INDEX idx_positions_created_by ON positions(created_by);
CREATE INDEX idx_positions_updated_by ON positions(updated_by);
CREATE INDEX idx_positions_deleted_by ON positions(deleted_by);

-- =====================================================
-- 12. CANDIDATES TABLE INDEXES
-- =====================================================
CREATE INDEX idx_candidates_user_id ON candidates(user_id);
CREATE INDEX idx_candidates_election_id ON candidates(election_id);
CREATE INDEX idx_candidates_party_id ON candidates(party_id);
CREATE INDEX idx_candidates_position_id ON candidates(position_id);
CREATE INDEX idx_candidates_education_level ON candidates(education_level);
CREATE INDEX idx_candidates_approval_date ON candidates(approval_date);
CREATE INDEX idx_candidates_status ON candidates(status);
CREATE INDEX idx_candidates_is_enable ON candidates(is_enable);
CREATE INDEX idx_candidates_created_at ON candidates(created_at);
CREATE INDEX idx_candidates_updated_at ON candidates(updated_at);
CREATE INDEX idx_candidates_created_by ON candidates(created_by);
CREATE INDEX idx_candidates_updated_by ON candidates(updated_by);
CREATE INDEX idx_candidates_deleted_by ON candidates(deleted_by);

-- =====================================================
-- 13. DOCUMENT_TYPES TABLE INDEXES
-- =====================================================
CREATE INDEX idx_document_types_type_name ON document_types(type_name);
CREATE INDEX idx_document_types_type_code ON document_types(type_code);
CREATE INDEX idx_document_types_required_for ON document_types(required_for);
CREATE INDEX idx_document_types_file_format ON document_types(file_format);
CREATE INDEX idx_document_types_validity_period ON document_types(validity_period);
CREATE INDEX idx_document_types_max_file_size ON document_types(max_file_size);
CREATE INDEX idx_document_types_status ON document_types(status);
CREATE INDEX idx_document_types_is_enable ON document_types(is_enable);
CREATE INDEX idx_document_types_created_at ON document_types(created_at);
CREATE INDEX idx_document_types_updated_at ON document_types(updated_at);
CREATE INDEX idx_document_types_created_by ON document_types(created_by);
CREATE INDEX idx_document_types_updated_by ON document_types(updated_by);
CREATE INDEX idx_document_types_deleted_by ON document_types(deleted_by);

-- =====================================================
-- 14. CANDIDATE_DOCUMENTS TABLE INDEXES
-- =====================================================
CREATE INDEX idx_candidate_documents_candidate_id ON candidate_documents(candidate_id);
CREATE INDEX idx_candidate_documents_document_type_id ON candidate_documents(document_type_id);
CREATE INDEX idx_candidate_documents_document_number ON candidate_documents(document_number);
CREATE INDEX idx_candidate_documents_issue_date ON candidate_documents(issue_date);
CREATE INDEX idx_candidate_documents_expiry_date ON candidate_documents(expiry_date);
CREATE INDEX idx_candidate_documents_verification_date ON candidate_documents(verification_date);
CREATE INDEX idx_candidate_documents_verified_by ON candidate_documents(verified_by);
CREATE INDEX idx_candidate_documents_status ON candidate_documents(status);
CREATE INDEX idx_candidate_documents_is_enable ON candidate_documents(is_enable);
CREATE INDEX idx_candidate_documents_created_at ON candidate_documents(created_at);
CREATE INDEX idx_candidate_documents_updated_at ON candidate_documents(updated_at);
CREATE INDEX idx_candidate_documents_created_by ON candidate_documents(created_by);
CREATE INDEX idx_candidate_documents_updated_by ON candidate_documents(updated_by);
CREATE INDEX idx_candidate_documents_deleted_by ON candidate_documents(deleted_by);

-- =====================================================
-- 15. ELECTION_AGENTS TABLE INDEXES
-- =====================================================
CREATE INDEX idx_election_agents_user_id ON election_agents(user_id);
CREATE INDEX idx_election_agents_candidate_id ON election_agents(candidate_id);
CREATE INDEX idx_election_agents_agent_code ON election_agents(agent_code);
CREATE INDEX idx_election_agents_agent_type ON election_agents(agent_type);
CREATE INDEX idx_election_agents_assignment_date ON election_agents(assignment_date);
CREATE INDEX idx_election_agents_training_completed ON election_agents(training_completed);
CREATE INDEX idx_election_agents_contact_phone ON election_agents(contact_phone);
CREATE INDEX idx_election_agents_status ON election_agents(status);
CREATE INDEX idx_election_agents_is_enable ON election_agents(is_enable);
CREATE INDEX idx_election_agents_created_at ON election_agents(created_at);
CREATE INDEX idx_election_agents_updated_at ON election_agents(updated_at);
CREATE INDEX idx_election_agents_created_by ON election_agents(created_by);
CREATE INDEX idx_election_agents_updated_by ON election_agents(updated_by);
CREATE INDEX idx_election_agents_deleted_by ON election_agents(deleted_by);

-- =====================================================
-- 16. POLLING_OFFICERS TABLE INDEXES
-- =====================================================
CREATE INDEX idx_polling_officers_user_id ON polling_officers(user_id);
CREATE INDEX idx_polling_officers_station_id ON polling_officers(station_id);
CREATE INDEX idx_polling_officers_officer_code ON polling_officers(officer_code);
CREATE INDEX idx_polling_officers_designation ON polling_officers(designation);
CREATE INDEX idx_polling_officers_duty_date ON polling_officers(duty_date);
CREATE INDEX idx_polling_officers_shift_time ON polling_officers(shift_time);
CREATE INDEX idx_polling_officers_training_status ON polling_officers(training_status);
CREATE INDEX idx_polling_officers_contact_phone ON polling_officers(contact_phone);
CREATE INDEX idx_polling_officers_status ON polling_officers(status);
CREATE INDEX idx_polling_officers_is_enable ON polling_officers(is_enable);
CREATE INDEX idx_polling_officers_created_at ON polling_officers(created_at);
CREATE INDEX idx_polling_officers_updated_at ON polling_officers(updated_at);
CREATE INDEX idx_polling_officers_created_by ON polling_officers(created_by);
CREATE INDEX idx_polling_officers_updated_by ON polling_officers(updated_by);
CREATE INDEX idx_polling_officers_deleted_by ON polling_officers(deleted_by);

-- =====================================================
-- 17. COMPLAINT_CATEGORIES TABLE INDEXES
-- =====================================================
CREATE INDEX idx_complaint_categories_category_name ON complaint_categories(category_name);
CREATE INDEX idx_complaint_categories_category_code ON complaint_categories(category_code);
CREATE INDEX idx_complaint_categories_priority_level ON complaint_categories(priority_level);
CREATE INDEX idx_complaint_categories_resolution_time ON complaint_categories(resolution_time);
CREATE INDEX idx_complaint_categories_parent_category_id ON complaint_categories(parent_category_id);
CREATE INDEX idx_complaint_categories_handling_department ON complaint_categories(handling_department);
CREATE INDEX idx_complaint_categories_status ON complaint_categories(status);
CREATE INDEX idx_complaint_categories_is_enable ON complaint_categories(is_enable);
CREATE INDEX idx_complaint_categories_created_at ON complaint_categories(created_at);
CREATE INDEX idx_complaint_categories_updated_at ON complaint_categories(updated_at);
CREATE INDEX idx_complaint_categories_created_by ON complaint_categories(created_by);
CREATE INDEX idx_complaint_categories_updated_by ON complaint_categories(updated_by);
CREATE INDEX idx_complaint_categories_deleted_by ON complaint_categories(deleted_by);

-- =====================================================
-- 18. COMPLAINTS TABLE INDEXES
-- =====================================================
CREATE INDEX idx_complaints_complaint_title ON complaints(complaint_title);
CREATE INDEX idx_complaints_complaint_number ON complaints(complaint_number);
CREATE INDEX idx_complaints_election_id ON complaints(election_id);
CREATE INDEX idx_complaints_category_id ON complaints(category_id);
CREATE INDEX idx_complaints_complainant_id ON complaints(complainant_id);
CREATE INDEX idx_complaints_priority ON complaints(priority);
CREATE INDEX idx_complaints_assigned_to ON complaints(assigned_to);
CREATE INDEX idx_complaints_resolved_date ON complaints(resolved_date);
CREATE INDEX idx_complaints_status ON complaints(status);
CREATE INDEX idx_complaints_is_enable ON complaints(is_enable);
CREATE INDEX idx_complaints_created_at ON complaints(created_at);
CREATE INDEX idx_complaints_updated_at ON complaints(updated_at);
CREATE INDEX idx_complaints_created_by ON complaints(created_by);
CREATE INDEX idx_complaints_updated_by ON complaints(updated_by);
CREATE INDEX idx_complaints_deleted_by ON complaints(deleted_by);

-- =====================================================
-- 19. VOTER_VERIFICATION TABLE INDEXES
-- =====================================================
CREATE INDEX idx_voter_verification_user_id ON voter_verification(user_id);
CREATE INDEX idx_voter_verification_device_id ON voter_verification(device_id);
CREATE INDEX idx_voter_verification_verification_code ON voter_verification(verification_code);
CREATE INDEX idx_voter_verification_verification_method ON voter_verification(verification_method);
CREATE INDEX idx_voter_verification_verification_date ON voter_verification(verification_date);
CREATE INDEX idx_voter_verification_verified_by ON voter_verification(verified_by);
CREATE INDEX idx_voter_verification_ip_address ON voter_verification(ip_address);
CREATE INDEX idx_voter_verification_attempt_count ON voter_verification(attempt_count);
CREATE INDEX idx_voter_verification_is_verified ON voter_verification(is_verified);
CREATE INDEX idx_voter_verification_status ON voter_verification(status);
CREATE INDEX idx_voter_verification_is_enable ON voter_verification(is_enable);
CREATE INDEX idx_voter_verification_created_at ON voter_verification(created_at);
CREATE INDEX idx_voter_verification_updated_at ON voter_verification(updated_at);
CREATE INDEX idx_voter_verification_created_by ON voter_verification(created_by);
CREATE INDEX idx_voter_verification_updated_by ON voter_verification(updated_by);
CREATE INDEX idx_voter_verification_deleted_by ON voter_verification(deleted_by);

-- =====================================================
-- 20. VOTES TABLE INDEXES
-- =====================================================
CREATE INDEX idx_votes_voter_id ON votes(voter_id);
CREATE INDEX idx_votes_candidate_id ON votes(candidate_id);
CREATE INDEX idx_votes_election_id ON votes(election_id);
CREATE INDEX idx_votes_station_id ON votes(station_id);
CREATE INDEX idx_votes_vote_hash ON votes(vote_hash);
CREATE INDEX idx_votes_vote_timestamp ON votes(vote_timestamp);
CREATE INDEX idx_votes_verification_method ON votes(verification_method);
CREATE INDEX idx_votes_ip_address ON votes(ip_address);
CREATE INDEX idx_votes_status ON votes(status);
CREATE INDEX idx_votes_is_enable ON votes(is_enable);
CREATE INDEX idx_votes_created_at ON votes(created_at);
CREATE INDEX idx_votes_updated_at ON votes(updated_at);
CREATE INDEX idx_votes_created_by ON votes(created_by);
CREATE INDEX idx_votes_updated_by ON votes(updated_by);
CREATE INDEX idx_votes_deleted_by ON votes(deleted_by);

-- =====================================================
-- 21. ELECTION_RESULTS TABLE INDEXES
-- =====================================================
CREATE INDEX idx_election_results_election_id ON election_results(election_id);
CREATE INDEX idx_election_results_candidate_id ON election_results(candidate_id);
CREATE INDEX idx_election_results_station_id ON election_results(station_id);
CREATE INDEX idx_election_results_total_votes ON election_results(total_votes);
CREATE INDEX idx_election_results_vote_percentage ON election_results(vote_percentage);
CREATE INDEX idx_election_results_result_code ON election_results(result_code);
CREATE INDEX idx_election_results_rank_position ON election_results(rank_position);
CREATE INDEX idx_election_results_is_winner ON election_results(is_winner);
CREATE INDEX idx_election_results_declaration_date ON election_results(declaration_date);
CREATE INDEX idx_election_results_verified_by ON election_results(verified_by);
CREATE INDEX idx_election_results_status ON election_results(status);
CREATE INDEX idx_election_results_is_enable ON election_results(is_enable);
CREATE INDEX idx_election_results_created_at ON election_results(created_at);
CREATE INDEX idx_election_results_updated_at ON election_results(updated_at);
CREATE INDEX idx_election_results_created_by ON election_results(created_by);
CREATE INDEX idx_election_results_updated_by ON election_results(updated_by);
CREATE INDEX idx_election_results_deleted_by ON election_results(deleted_by);

-- =====================================================
-- 22. AUDIT_LOGS TABLE INDEXES
-- =====================================================
CREATE INDEX idx_audit_logs_table_name ON audit_logs(table_name);
CREATE INDEX idx_audit_logs_action_type ON audit_logs(action_type);
CREATE INDEX idx_audit_logs_record_id ON audit_logs(record_id);
CREATE INDEX idx_audit_logs_log_reference ON audit_logs(log_reference);
CREATE INDEX idx_audit_logs_user_id ON audit_logs(user_id);
CREATE INDEX idx_audit_logs_ip_address ON audit_logs(ip_address);
CREATE INDEX idx_audit_logs_status ON audit_logs(status);
CREATE INDEX idx_audit_logs_is_enable ON audit_logs(is_enable);
CREATE INDEX idx_audit_logs_created_at ON audit_logs(created_at);
CREATE INDEX idx_audit_logs_updated_at ON audit_logs(updated_at);
CREATE INDEX idx_audit_logs_created_by ON audit_logs(created_by);
CREATE INDEX idx_audit_logs_updated_by ON audit_logs(updated_by);
CREATE INDEX idx_audit_logs_deleted_by ON audit_logs(deleted_by);

-- =====================================================
-- 23. NOTIFICATIONS TABLE INDEXES
-- =====================================================
CREATE INDEX idx_notifications_user_id ON notifications(user_id);
CREATE INDEX idx_notifications_notification_type ON notifications(notification_type);
CREATE INDEX idx_notifications_notification_code ON notifications(notification_code);
CREATE INDEX idx_notifications_title ON notifications(title);
CREATE INDEX idx_notifications_channel ON notifications(channel);
CREATE INDEX idx_notifications_priority ON notifications(priority);
CREATE INDEX idx_notifications_sent_date ON notifications(sent_date);
CREATE INDEX idx_notifications_read_date ON notifications(read_date);
CREATE INDEX idx_notifications_is_read ON notifications(is_read);
CREATE INDEX idx_notifications_status ON notifications(status);
CREATE INDEX idx_notifications_is_enable ON notifications(is_enable);
CREATE INDEX idx_notifications_created_at ON notifications(created_at);
CREATE INDEX idx_notifications_updated_at ON notifications(updated_at);
CREATE INDEX idx_notifications_created_by ON notifications(created_by);
CREATE INDEX idx_notifications_updated_by ON notifications(updated_by);
CREATE INDEX idx_notifications_deleted_by ON notifications(deleted_by);

-- =====================================================
-- 24. SYSTEM_SETTINGS TABLE INDEXES
-- =====================================================
CREATE INDEX idx_system_settings_setting_key ON system_settings(setting_key);
CREATE INDEX idx_system_settings_setting_code ON system_settings(setting_code);
CREATE INDEX idx_system_settings_category ON system_settings(category);
CREATE INDEX idx_system_settings_data_type ON system_settings(data_type);
CREATE INDEX idx_system_settings_is_editable ON system_settings(is_editable);
CREATE INDEX idx_system_settings_status ON system_settings(status);
CREATE INDEX idx_system_settings_is_enable ON system_settings(is_enable);
CREATE INDEX idx_system_settings_created_at ON system_settings(created_at);
CREATE INDEX idx_system_settings_updated_at ON system_settings(updated_at);
CREATE INDEX idx_system_settings_created_by ON system_settings(created_by);
CREATE INDEX idx_system_settings_updated_by ON system_settings(updated_by);
CREATE INDEX idx_system_settings_deleted_by ON system_settings(deleted_by);

-- =====================================================
-- 25. ELECTION_PHASES TABLE INDEXES
-- =====================================================
CREATE INDEX idx_election_phases_election_id ON election_phases(election_id);
CREATE INDEX idx_election_phases_phase_name ON election_phases(phase_name);
CREATE INDEX idx_election_phases_phase_code ON election_phases(phase_code);
CREATE INDEX idx_election_phases_phase_order ON election_phases(phase_order);
CREATE INDEX idx_election_phases_start_date ON election_phases(start_date);
CREATE INDEX idx_election_phases_end_date ON election_phases(end_date);
CREATE INDEX idx_election_phases_completion_percentage ON election_phases(completion_percentage);
CREATE INDEX idx_election_phases_responsible_person ON election_phases(responsible_person);
CREATE INDEX idx_election_phases_status ON election_phases(status);
CREATE INDEX idx_election_phases_is_enable ON election_phases(is_enable);
CREATE INDEX idx_election_phases_created_at ON election_phases(created_at);
CREATE INDEX idx_election_phases_updated_at ON election_phases(updated_at);
CREATE INDEX idx_election_phases_created_by ON election_phases(created_by);
CREATE INDEX idx_election_phases_updated_by ON election_phases(updated_by);
CREATE INDEX idx_election_phases_deleted_by ON election_phases(deleted_by);

-- =====================================================
-- 26. STATION_RESOURCES TABLE INDEXES
-- =====================================================
CREATE INDEX idx_station_resources_station_id ON station_resources(station_id);
CREATE INDEX idx_station_resources_resource_name ON station_resources(resource_name);
CREATE INDEX idx_station_resources_resource_code ON station_resources(resource_code);
CREATE INDEX idx_station_resources_resource_type ON station_resources(resource_type);
CREATE INDEX idx_station_resources_quantity ON station_resources(quantity);
CREATE INDEX idx_station_resources_unit_of_measure ON station_resources(unit_of_measure);
CREATE INDEX idx_station_resources_allocation_date ON station_resources(allocation_date);
CREATE INDEX idx_station_resources_last_maintenance ON station_resources(last_maintenance);
CREATE INDEX idx_station_resources_status ON station_resources(status);
CREATE INDEX idx_station_resources_is_enable ON station_resources(is_enable);
CREATE INDEX idx_station_resources_created_at ON station_resources(created_at);
CREATE INDEX idx_station_resources_updated_at ON station_resources(updated_at);
CREATE INDEX idx_station_resources_created_by ON station_resources(created_by);
CREATE INDEX idx_station_resources_updated_by ON station_resources(updated_by);
CREATE INDEX idx_station_resources_deleted_by ON station_resources(deleted_by);

-- =====================================================
-- 27. CAMPAIGN_EXPENSES TABLE INDEXES
-- =====================================================
CREATE INDEX idx_campaign_expenses_candidate_id ON campaign_expenses(candidate_id);
CREATE INDEX idx_campaign_expenses_expense_type ON campaign_expenses(expense_type);
CREATE INDEX idx_campaign_expenses_receipt_number ON campaign_expenses(receipt_number);
CREATE INDEX idx_campaign_expenses_amount ON campaign_expenses(amount);
CREATE INDEX idx_campaign_expenses_expense_date ON campaign_expenses(expense_date);
CREATE INDEX idx_campaign_expenses_vendor_name ON campaign_expenses(vendor_name);
CREATE INDEX idx_campaign_expenses_payment_method ON campaign_expenses(payment_method);
CREATE INDEX idx_campaign_expenses_verified_by ON campaign_expenses(verified_by);
CREATE INDEX idx_campaign_expenses_status ON campaign_expenses(status);
CREATE INDEX idx_campaign_expenses_is_enable ON campaign_expenses(is_enable);
CREATE INDEX idx_campaign_expenses_created_at ON campaign_expenses(created_at);
CREATE INDEX idx_campaign_expenses_updated_at ON campaign_expenses(updated_at);
CREATE INDEX idx_campaign_expenses_created_by ON campaign_expenses(created_by);
CREATE INDEX idx_campaign_expenses_updated_by ON campaign_expenses(updated_by);
CREATE INDEX idx_campaign_expenses_deleted_by ON campaign_expenses(deleted_by);

-- =====================================================
-- 28. MEDIA_COVERAGE TABLE INDEXES
-- =====================================================
CREATE INDEX idx_media_coverage_election_id ON media_coverage(election_id);
CREATE INDEX idx_media_coverage_media_outlet ON media_coverage(media_outlet);
CREATE INDEX idx_media_coverage_headline ON media_coverage(headline);
CREATE INDEX idx_media_coverage_coverage_ref ON media_coverage(coverage_ref);
CREATE INDEX idx_media_coverage_coverage_type ON media_coverage(coverage_type);
CREATE INDEX idx_media_coverage_publication_date ON media_coverage(publication_date);
CREATE INDEX idx_media_coverage_reporter_name ON media_coverage(reporter_name);
CREATE INDEX idx_media_coverage_sentiment ON media_coverage(sentiment);
CREATE INDEX idx_media_coverage_reach_estimate ON media_coverage(reach_estimate);
CREATE INDEX idx_media_coverage_status ON media_coverage(status);
CREATE INDEX idx_media_coverage_is_enable ON media_coverage(is_enable);
CREATE INDEX idx_media_coverage_created_at ON media_coverage(created_at);
CREATE INDEX idx_media_coverage_updated_at ON media_coverage(updated_at);
CREATE INDEX idx_media_coverage_created_by ON media_coverage(created_by);
CREATE INDEX idx_media_coverage_updated_by ON media_coverage(updated_by);
CREATE INDEX idx_media_coverage_deleted_by ON media_coverage(deleted_by);

-- =====================================================
-- 29. SECURITY_INCIDENTS TABLE INDEXES
-- =====================================================
CREATE INDEX idx_security_incidents_station_id ON security_incidents(station_id);
CREATE INDEX idx_security_incidents_incident_type ON security_incidents(incident_type);
CREATE INDEX idx_security_incidents_incident_ref ON security_incidents(incident_ref);
CREATE INDEX idx_security_incidents_severity ON security_incidents(severity);
CREATE INDEX idx_security_incidents_incident_date ON security_incidents(incident_date);
CREATE INDEX idx_security_incidents_incident_time ON security_incidents(incident_time);
CREATE INDEX idx_security_incidents_reported_by ON security_incidents(reported_by);
CREATE INDEX idx_security_incidents_resolved_date ON security_incidents(resolved_date);
CREATE INDEX idx_security_incidents_status ON security_incidents(status);
CREATE INDEX idx_security_incidents_is_enable ON security_incidents(is_enable);
CREATE INDEX idx_security_incidents_created_at ON security_incidents(created_at);
CREATE INDEX idx_security_incidents_updated_at ON security_incidents(updated_at);
CREATE INDEX idx_security_incidents_created_by ON security_incidents(created_by);
CREATE INDEX idx_security_incidents_updated_by ON security_incidents(updated_by);
CREATE INDEX idx_security_incidents_deleted_by ON security_incidents(deleted_by);

-- =====================================================
-- 30. BALLOT_PAPERS TABLE INDEXES
-- =====================================================
CREATE INDEX idx_ballot_papers_election_id ON ballot_papers(election_id);
CREATE INDEX idx_ballot_papers_ballot_number ON ballot_papers(ballot_number);
CREATE INDEX idx_ballot_papers_serial_number ON ballot_papers(serial_number);
CREATE INDEX idx_ballot_papers_station_id ON ballot_papers(station_id);
CREATE INDEX idx_ballot_papers_batch_number ON ballot_papers(batch_number);
CREATE INDEX idx_ballot_papers_print_date ON ballot_papers(print_date);
CREATE INDEX idx_ballot_papers_distribution_date ON ballot_papers(distribution_date);
CREATE INDEX idx_ballot_papers_received_by ON ballot_papers(received_by);
CREATE INDEX idx_ballot_papers_status ON ballot_papers(status);
CREATE INDEX idx_ballot_papers_is_enable ON ballot_papers(is_enable);
CREATE INDEX idx_ballot_papers_created_at ON ballot_papers(created_at);
CREATE INDEX idx_ballot_papers_updated_at ON ballot_papers(updated_at);
CREATE INDEX idx_ballot_papers_created_by ON ballot_papers(created_by);
CREATE INDEX idx_ballot_papers_updated_by ON ballot_papers(updated_by);
CREATE INDEX idx_ballot_papers_deleted_by ON ballot_papers(deleted_by);

-- =====================================================
-- 31. VOTER_TURNOUT TABLE INDEXES
-- =====================================================
CREATE INDEX idx_voter_turnout_election_id ON voter_turnout(election_id);
CREATE INDEX idx_voter_turnout_station_id ON voter_turnout(station_id);
CREATE INDEX idx_voter_turnout_turnout_ref ON voter_turnout(turnout_ref);
CREATE INDEX idx_voter_turnout_total_registered ON voter_turnout(total_registered);
CREATE INDEX idx_voter_turnout_total_voted ON voter_turnout(total_voted);
CREATE INDEX idx_voter_turnout_male_voters ON voter_turnout(male_voters);
CREATE INDEX idx_voter_turnout_female_voters ON voter_turnout(female_voters);
CREATE INDEX idx_voter_turnout_turnout_percentage ON voter_turnout(turnout_percentage);
CREATE INDEX idx_voter_turnout_recording_time ON voter_turnout(recording_time);
CREATE INDEX idx_voter_turnout_recorded_by ON voter_turnout(recorded_by);
CREATE INDEX idx_voter_turnout_status ON voter_turnout(status);
CREATE INDEX idx_voter_turnout_is_enable ON voter_turnout(is_enable);
CREATE INDEX idx_voter_turnout_created_at ON voter_turnout(created_at);
CREATE INDEX idx_voter_turnout_updated_at ON voter_turnout(updated_at);
CREATE INDEX idx_voter_turnout_created_by ON voter_turnout(created_by);
CREATE INDEX idx_voter_turnout_updated_by ON voter_turnout(updated_by);
CREATE INDEX idx_voter_turnout_deleted_by ON voter_turnout(deleted_by);

-- =====================================================
-- 32. OBSERVER_REPORTS TABLE INDEXES
-- =====================================================
CREATE INDEX idx_observer_reports_agent_id ON observer_reports(agent_id);
CREATE INDEX idx_observer_reports_station_id ON observer_reports(station_id);
CREATE INDEX idx_observer_reports_report_number ON observer_reports(report_number);
CREATE INDEX idx_observer_reports_observation_date ON observer_reports(observation_date);
CREATE INDEX idx_observer_reports_status ON observer_reports(status);
CREATE INDEX idx_observer_reports_is_enable ON observer_reports(is_enable);
CREATE INDEX idx_observer_reports_created_at ON observer_reports(created_at);
CREATE INDEX idx_observer_reports_updated_at ON observer_reports(updated_at);
CREATE INDEX idx_observer_reports_created_by ON observer_reports(created_by);
CREATE INDEX idx_observer_reports_updated_by ON observer_reports(updated_by);
CREATE INDEX idx_observer_reports_deleted_by ON observer_reports(deleted_by);

-- =====================================================
-- 33. CANDIDATE_MANIFESTO TABLE INDEXES
-- =====================================================
CREATE INDEX idx_candidate_manifesto_candidate_id ON candidate_manifesto(candidate_id);
CREATE INDEX idx_candidate_manifesto_manifesto_title ON candidate_manifesto(manifesto_title);
CREATE INDEX idx_candidate_manifesto_language ON candidate_manifesto(language);
CREATE INDEX idx_candidate_manifesto_views_count ON candidate_manifesto(views_count);
CREATE INDEX idx_candidate_manifesto_status ON candidate_manifesto(status);
CREATE INDEX idx_candidate_manifesto_is_enable ON candidate_manifesto(is_enable);
CREATE INDEX idx_candidate_manifesto_created_at ON candidate_manifesto(created_at);
CREATE INDEX idx_candidate_manifesto_updated_at ON candidate_manifesto(updated_at);
CREATE INDEX idx_candidate_manifesto_created_by ON candidate_manifesto(created_by);
CREATE INDEX idx_candidate_manifesto_updated_by ON candidate_manifesto(updated_by);
CREATE INDEX idx_candidate_manifesto_deleted_by ON candidate_manifesto(deleted_by);

-- =====================================================
-- 34. PARTY_ALLIANCES TABLE INDEXES
-- =====================================================
CREATE INDEX idx_party_alliances_party_id ON party_alliances(party_id);
CREATE INDEX idx_party_alliances_allied_party_id ON party_alliances(allied_party_id);
CREATE INDEX idx_party_alliances_alliance_name ON party_alliances(alliance_name);
CREATE INDEX idx_party_alliances_alliance_code ON party_alliances(alliance_code);
CREATE INDEX idx_party_alliances_formation_date ON party_alliances(formation_date);
CREATE INDEX idx_party_alliances_contact_email ON party_alliances(contact_email);
CREATE INDEX idx_party_alliances_status ON party_alliances(status);
CREATE INDEX idx_party_alliances_is_enable ON party_alliances(is_enable);
CREATE INDEX idx_party_alliances_created_at ON party_alliances(created_at);
CREATE INDEX idx_party_alliances_updated_at ON party_alliances(updated_at);
CREATE INDEX idx_party_alliances_created_by ON party_alliances(created_by);
CREATE INDEX idx_party_alliances_updated_by ON party_alliances(updated_by);
CREATE INDEX idx_party_alliances_deleted_by ON party_alliances(deleted_by);

-- =====================================================
-- 35. ELECTION_BUDGETS TABLE INDEXES
-- =====================================================
CREATE INDEX idx_election_budgets_election_id ON election_budgets(election_id);
CREATE INDEX idx_election_budgets_budget_category ON election_budgets(budget_category);
CREATE INDEX idx_election_budgets_budget_ref ON election_budgets(budget_ref);
CREATE INDEX idx_election_budgets_allocated_amount ON election_budgets(allocated_amount);
CREATE INDEX idx_election_budgets_spent_amount ON election_budgets(spent_amount);
CREATE INDEX idx_election_budgets_approved_by ON election_budgets(approved_by);
CREATE INDEX idx_election_budgets_status ON election_budgets(status);
CREATE INDEX idx_election_budgets_is_enable ON election_budgets(is_enable);
CREATE INDEX idx_election_budgets_created_at ON election_budgets(created_at);
CREATE INDEX idx_election_budgets_updated_at ON election_budgets(updated_at);
CREATE INDEX idx_election_budgets_created_by ON election_budgets(created_by);
CREATE INDEX idx_election_budgets_updated_by ON election_budgets(updated_by);
CREATE INDEX idx_election_budgets_deleted_by ON election_budgets(deleted_by);

-- =====================================================
-- COMPOSITE INDEXES FOR OPTIMIZATION
-- =====================================================

-- User authentication and lookups
CREATE INDEX idx_users_email_status ON users(email, status);
CREATE INDEX idx_users_cnic_status ON users(cnic_number, status);
CREATE INDEX idx_admins_email_status ON admins(email, status);

-- Vote tracking
CREATE INDEX idx_votes_election_candidate ON votes(election_id, candidate_id);
CREATE INDEX idx_votes_voter_election ON votes(voter_id, election_id);
CREATE INDEX idx_votes_station_election ON votes(station_id, election_id);
CREATE INDEX idx_votes_timestamp_election ON votes(vote_timestamp, election_id);

-- Election results
CREATE INDEX idx_election_results_election_candidate ON election_results(election_id, candidate_id);
CREATE INDEX idx_election_results_station_election ON election_results(station_id, election_id);

-- Candidate filtering
CREATE INDEX idx_candidates_election_status ON candidates(election_id, status);
CREATE INDEX idx_candidates_party_election ON candidates(party_id, election_id);
CREATE INDEX idx_candidates_position_status ON candidates(position_id, status);

-- Polling stations
CREATE INDEX idx_polling_stations_district_status ON polling_stations(district_id, status);
CREATE INDEX idx_districts_city_status ON districts(city_id, status);

-- Notifications
CREATE INDEX idx_notifications_user_read ON notifications(user_id, is_read);
CREATE INDEX idx_notifications_user_status ON notifications(user_id, status);

-- Complaints
CREATE INDEX idx_complaints_election_status ON complaints(election_id, status);
CREATE INDEX idx_complaints_category_status ON complaints(category_id, status);
CREATE INDEX idx_complaints_assigned_status ON complaints(assigned_to, status);

-- Election phases
CREATE INDEX idx_election_phases_election_status ON election_phases(election_id, status);
CREATE INDEX idx_election_phases_election_order ON election_phases(election_id, phase_order);

-- Voter verification
CREATE INDEX idx_voter_verification_user_status ON voter_verification(user_id, status);
CREATE INDEX idx_voter_verification_date_method ON voter_verification(verification_date, verification_method);

-- Audit logs
CREATE INDEX idx_audit_logs_table_action ON audit_logs(table_name, action_type);
CREATE INDEX idx_audit_logs_user_created ON audit_logs(user_id, created_at);

-- User roles
CREATE INDEX idx_user_roles_user_status ON user_roles(user_id, status);
CREATE INDEX idx_user_roles_role_status ON user_roles(role_id, status);

-- Campaign expenses
CREATE INDEX idx_campaign_expenses_candidate_status ON campaign_expenses(candidate_id, status);
CREATE INDEX idx_campaign_expenses_candidate_date ON campaign_expenses(candidate_id, expense_date);

-- Ballot papers
CREATE INDEX idx_ballot_papers_election_status ON ballot_papers(election_id, status);
CREATE INDEX idx_ballot_papers_station_status ON ballot_papers(station_id, status);

-- Voter turnout
CREATE INDEX idx_voter_turnout_election_station ON voter_turnout(election_id, station_id);

-- =====================================================
-- End of Index Creation Script
-- Total Indexes Created: 400+ indexes for optimal query performance
-- =====================================================

-- =====================================================
--      WILDCARD SEARCH QUERIES (300 Total)
--      10 Tables × 5 Columns × 6 Wildcard Patterns
-- =====================================================

USE election_management_system;

-- 1. ADMINS
-- Pattern: %value
SELECT * FROM admins WHERE profile LIKE '%jpg';
SELECT * FROM admins WHERE name LIKE '%Khan';
SELECT * FROM admins WHERE email LIKE '%gov.pk';
SELECT * FROM admins WHERE password LIKE '%hash%';
SELECT * FROM admins WHERE status LIKE '%ive';
-- Pattern: value%
SELECT * FROM admins WHERE profile LIKE 'admin%';
SELECT * FROM admins WHERE name LIKE 'Faisal%';
SELECT * FROM admins WHERE email LIKE 'faisal%';
SELECT * FROM admins WHERE password LIKE '$2y%';
SELECT * FROM admins WHERE status LIKE 'act%';
-- Pattern: %value%
SELECT * FROM admins WHERE profile LIKE '%1%';
SELECT * FROM admins WHERE name LIKE '%Javed%';
SELECT * FROM admins WHERE email LIKE '%ecp%';
SELECT * FROM admins WHERE password LIKE '%hash%';
SELECT * FROM admins WHERE status LIKE '%active%';
-- Pattern: 1-5%
SELECT * FROM admins WHERE profile REGEXP '^[1-5]';
SELECT * FROM admins WHERE name REGEXP '^[1-5]';
SELECT * FROM admins WHERE email REGEXP '^[1-5]';
SELECT * FROM admins WHERE password REGEXP '^[1-5]';
SELECT * FROM admins WHERE status REGEXP '^[1-5]';
-- Pattern: ^1-5%
SELECT * FROM admins WHERE profile REGEXP '^[^1-5]';
SELECT * FROM admins WHERE name REGEXP '^[^1-5]';
SELECT * FROM admins WHERE email REGEXP '^[^1-5]';
SELECT * FROM admins WHERE password REGEXP '^[^1-5]';
SELECT * FROM admins WHERE status REGEXP '^[^1-5]';
-- Pattern: _
SELECT * FROM admins WHERE profile LIKE 'admin_.jpg';
SELECT * FROM admins WHERE name LIKE 'A_sha%';
SELECT * FROM admins WHERE email LIKE 'f_isal%';
SELECT * FROM admins WHERE password LIKE '$2y_10%';
SELECT * FROM admins WHERE status LIKE 'act_ve';

-- 2. USERS
-- Pattern: %value
SELECT * FROM users WHERE first_name LIKE '%al';
SELECT * FROM users WHERE last_name LIKE '%ui';
SELECT * FROM users WHERE cnic_number LIKE '%-4';
SELECT * FROM users WHERE email LIKE '%com';
SELECT * FROM users WHERE phone LIKE '%69';
-- Pattern: value%
SELECT * FROM users WHERE first_name LIKE 'Bi%';
SELECT * FROM users WHERE last_name LIKE 'Sid%';
SELECT * FROM users WHERE cnic_number LIKE '422%';
SELECT * FROM users WHERE email LIKE 'bilal%';
SELECT * FROM users WHERE phone LIKE '+92%';
-- Pattern: %value%
SELECT * FROM users WHERE first_name LIKE '%la%';
SELECT * FROM users WHERE last_name LIKE '%di%';
SELECT * FROM users WHERE cnic_number LIKE '%617%';
SELECT * FROM users WHERE email LIKE '%gmail%';
SELECT * FROM users WHERE phone LIKE '%303%';
-- Pattern: 1-5%
SELECT * FROM users WHERE first_name REGEXP '^[1-5]';
SELECT * FROM users WHERE last_name REGEXP '^[1-5]';
SELECT * FROM users WHERE cnic_number REGEXP '^[1-5]';
SELECT * FROM users WHERE email REGEXP '^[1-5]';
SELECT * FROM users WHERE phone REGEXP '^[1-5]';
-- Pattern: ^1-5%
SELECT * FROM users WHERE first_name REGEXP '^[^1-5]';
SELECT * FROM users WHERE last_name REGEXP '^[^1-5]';
SELECT * FROM users WHERE cnic_number REGEXP '^[^1-5]';
SELECT * FROM users WHERE email REGEXP '^[^1-5]';
SELECT * FROM users WHERE phone REGEXP '^[^1-5]';
-- Pattern: _
SELECT * FROM users WHERE first_name LIKE 'B_lal';
SELECT * FROM users WHERE last_name LIKE 'S_ddiqui';
SELECT * FROM users WHERE cnic_number LIKE '42201-617117_-4';
SELECT * FROM users WHERE email LIKE 'b_lal%';
SELECT * FROM users WHERE phone LIKE '+92-303-653886_';

-- 3. ROLES
-- Pattern: %value
SELECT * FROM roles WHERE role_name LIKE '%er';
SELECT * FROM roles WHERE description LIKE '%nt';
SELECT * FROM roles WHERE role_code LIKE '%01';
SELECT * FROM roles WHERE permissions LIKE '%ic"}';
SELECT * FROM roles WHERE status LIKE '%ive';
-- Pattern: value%
SELECT * FROM roles WHERE role_name LIKE 'Ad%';
SELECT * FROM roles WHERE description LIKE 'Mon%';
SELECT * FROM roles WHERE role_code LIKE 'ROL%';
SELECT * FROM roles WHERE permissions LIKE '{"ac%';
SELECT * FROM roles WHERE status LIKE 'act%';
-- Pattern: %value%
SELECT * FROM roles WHERE role_name LIKE '%min%';
SELECT * FROM roles WHERE description LIKE '%election%';
SELECT * FROM roles WHERE role_code LIKE '%00%';
SELECT * FROM roles WHERE permissions LIKE '%basic%';
SELECT * FROM roles WHERE status LIKE '%active%';
-- Pattern: 1-5%
SELECT * FROM roles WHERE role_name REGEXP '^[1-5]';
SELECT * FROM roles WHERE description REGEXP '^[1-5]';
SELECT * FROM roles WHERE role_code REGEXP '^[1-5]';
SELECT * FROM roles WHERE permissions REGEXP '^[1-5]';
SELECT * FROM roles WHERE status REGEXP '^[1-5]';
-- Pattern: ^1-5%
SELECT * FROM roles WHERE role_name REGEXP '^[^1-5]';
SELECT * FROM roles WHERE description REGEXP '^[^1-5]';
SELECT * FROM roles WHERE role_code REGEXP '^[^1-5]';
SELECT * FROM roles WHERE permissions REGEXP '^[^1-5]';
SELECT * FROM roles WHERE status REGEXP '^[^1-5]';
-- Pattern: _
SELECT * FROM roles WHERE role_name LIKE 'Ad_in';
SELECT * FROM roles WHERE description LIKE 'M_nitoring%';
SELECT * FROM roles WHERE role_code LIKE 'ROLE00_';
SELECT * FROM roles WHERE permissions LIKE '{"acc_ss"%';
SELECT * FROM roles WHERE status LIKE 'act_ve';

-- 4. ELECTIONS
-- Pattern: %value
SELECT * FROM elections WHERE title LIKE '%on';
SELECT * FROM elections WHERE description LIKE '%ty';
SELECT * FROM elections WHERE election_code LIKE '%01';
SELECT * FROM elections WHERE election_type LIKE '%on';
SELECT * FROM elections WHERE status LIKE '%ing';
-- Pattern: value%
SELECT * FROM elections WHERE title LIKE 'May%';
SELECT * FROM elections WHERE description LIKE 'Ele%';
SELECT * FROM elections WHERE election_code LIKE 'ELE%';
SELECT * FROM elections WHERE election_type LIKE 'loc%';
SELECT * FROM elections WHERE status LIKE 'run%';
-- Pattern: %value%
SELECT * FROM elections WHERE title LIKE '%oral%';
SELECT * FROM elections WHERE description LIKE '%Springfield%';
SELECT * FROM elections WHERE election_code LIKE '%00%';
SELECT * FROM elections WHERE election_type LIKE '%local%';
SELECT * FROM elections WHERE status LIKE '%running%';
-- Pattern: 1-5%
SELECT * FROM elections WHERE title REGEXP '^[1-5]';
SELECT * FROM elections WHERE description REGEXP '^[1-5]';
SELECT * FROM elections WHERE election_code REGEXP '^[1-5]';
SELECT * FROM elections WHERE election_type REGEXP '^[1-5]';
SELECT * FROM elections WHERE status REGEXP '^[1-5]';
-- Pattern: ^1-5%
SELECT * FROM elections WHERE title REGEXP '^[^1-5]';
SELECT * FROM elections WHERE description REGEXP '^[^1-5]';
SELECT * FROM elections WHERE election_code REGEXP '^[^1-5]';
SELECT * FROM elections WHERE election_type REGEXP '^[^1-5]';
SELECT * FROM elections WHERE status REGEXP '^[^1-5]';
-- Pattern: _
SELECT * FROM elections WHERE title LIKE 'M_yoral%';
SELECT * FROM elections WHERE description LIKE 'Elect_on%';
SELECT * FROM elections WHERE election_code LIKE 'ELEC000_';
SELECT * FROM elections WHERE election_type LIKE 'l_cal';
SELECT * FROM elections WHERE status LIKE 'runn_ng';

-- 5. POLITICAL_PARTIES
-- Pattern: %value
SELECT * FROM political_parties WHERE party_name LIKE '%ty';
SELECT * FROM political_parties WHERE party_symbol LIKE '%pg';
SELECT * FROM political_parties WHERE founder LIKE '%an';
SELECT * FROM political_parties WHERE party_code LIKE '%01';
SELECT * FROM political_parties WHERE status LIKE '%ive';
-- Pattern: value%
SELECT * FROM political_parties WHERE party_name LIKE 'Pa%';
SELECT * FROM political_parties WHERE party_symbol LIKE 'sym%';
SELECT * FROM political_parties WHERE founder LIKE 'Kha%';
SELECT * FROM political_parties WHERE party_code LIKE 'PAR%';
SELECT * FROM political_parties WHERE status LIKE 'act%';
-- Pattern: %value%
SELECT * FROM political_parties WHERE party_name LIKE '%party%';
SELECT * FROM political_parties WHERE party_symbol LIKE '%logo%';
SELECT * FROM political_parties WHERE founder LIKE '%Khan%';
SELECT * FROM political_parties WHERE party_code LIKE '%00%';
SELECT * FROM political_parties WHERE status LIKE '%active%';
-- Pattern: 1-5%
SELECT * FROM political_parties WHERE party_name REGEXP '^[1-5]';
SELECT * FROM political_parties WHERE party_symbol REGEXP '^[1-5]';
SELECT * FROM political_parties WHERE founder REGEXP '^[1-5]';
SELECT * FROM political_parties WHERE party_code REGEXP '^[1-5]';
SELECT * FROM political_parties WHERE status REGEXP '^[1-5]';
-- Pattern: ^1-5%
SELECT * FROM political_parties WHERE party_name REGEXP '^[^1-5]';
SELECT * FROM political_parties WHERE party_symbol REGEXP '^[^1-5]';
SELECT * FROM political_parties WHERE founder REGEXP '^[^1-5]';
SELECT * FROM political_parties WHERE party_code REGEXP '^[^1-5]';
SELECT * FROM political_parties WHERE status REGEXP '^[^1-5]';
-- Pattern: _
SELECT * FROM political_parties WHERE party_name LIKE 'P_rty%';
SELECT * FROM political_parties WHERE party_symbol LIKE 'symb_l%';
SELECT * FROM political_parties WHERE founder LIKE 'Kh_n';
SELECT * FROM political_parties WHERE party_code LIKE 'PART_01';
SELECT * FROM political_parties WHERE status LIKE 'act_ve';

-- 6. POSITIONS
-- Pattern: %value
SELECT * FROM positions WHERE position_code LIKE '%01';
SELECT * FROM positions WHERE position_name LIKE '%nt';
SELECT * FROM positions WHERE description LIKE '%on';
SELECT * FROM positions WHERE responsibilities LIKE '%es';
SELECT * FROM positions WHERE status LIKE '%ive';
-- Pattern: value%
SELECT * FROM positions WHERE position_code LIKE 'POS%';
SELECT * FROM positions WHERE position_name LIKE 'Pre%';
SELECT * FROM positions WHERE description LIKE 'Des%';
SELECT * FROM positions WHERE responsibilities LIKE 'Res%';
SELECT * FROM positions WHERE status LIKE 'act%';
-- Pattern: %value%
SELECT * FROM positions WHERE position_code LIKE '%00%';
SELECT * FROM positions WHERE position_name LIKE '%ident%';
SELECT * FROM positions WHERE description LIKE '%role%';
SELECT * FROM positions WHERE responsibilities LIKE '%duty%';
SELECT * FROM positions WHERE status LIKE '%active%';
-- Pattern: 1-5%
SELECT * FROM positions WHERE position_code REGEXP '^[1-5]';
SELECT * FROM positions WHERE position_name REGEXP '^[1-5]';
SELECT * FROM positions WHERE description REGEXP '^[1-5]';
SELECT * FROM positions WHERE responsibilities REGEXP '^[1-5]';
SELECT * FROM positions WHERE status REGEXP '^[1-5]';
-- Pattern: ^1-5%
SELECT * FROM positions WHERE position_code REGEXP '^[^1-5]';
SELECT * FROM positions WHERE position_name REGEXP '^[^1-5]';
SELECT * FROM positions WHERE description REGEXP '^[^1-5]';
SELECT * FROM positions WHERE responsibilities REGEXP '^[^1-5]';
SELECT * FROM positions WHERE status REGEXP '^[^1-5]';
-- Pattern: _
SELECT * FROM positions WHERE position_code LIKE 'POS_01';
SELECT * FROM positions WHERE position_name LIKE 'Pres_dent';
SELECT * FROM positions WHERE description LIKE 'D_scription%';
SELECT * FROM positions WHERE responsibilities LIKE 'Resp_nsibilities%';
SELECT * FROM positions WHERE status LIKE 'act_ve';

-- 7. DOCUMENT_TYPES
-- Pattern: %value
SELECT * FROM document_types WHERE type_name LIKE '%rd';
SELECT * FROM document_types WHERE description LIKE '%on';
SELECT * FROM document_types WHERE type_code LIKE '%01';
SELECT * FROM document_types WHERE required_for LIKE '%er';
SELECT * FROM document_types WHERE file_format LIKE '%pg';
-- Pattern: value%
SELECT * FROM document_types WHERE type_name LIKE 'CN%';
SELECT * FROM document_types WHERE description LIKE 'Iden%';
SELECT * FROM document_types WHERE type_code LIKE 'DOC%';
SELECT * FROM document_types WHERE required_for LIKE 'Vot%';
SELECT * FROM document_types WHERE file_format LIKE 'jp%';
-- Pattern: %value%
SELECT * FROM document_types WHERE type_name LIKE '%card%';
SELECT * FROM document_types WHERE description LIKE '%verification%';
SELECT * FROM document_types WHERE type_code LIKE '%00%';
SELECT * FROM document_types WHERE required_for LIKE '%voter%';
SELECT * FROM document_types WHERE file_format LIKE '%pdf%';
-- Pattern: 1-5%
SELECT * FROM document_types WHERE type_name REGEXP '^[1-5]';
SELECT * FROM document_types WHERE description REGEXP '^[1-5]';
SELECT * FROM document_types WHERE type_code REGEXP '^[1-5]';
SELECT * FROM document_types WHERE required_for REGEXP '^[1-5]';
SELECT * FROM document_types WHERE file_format REGEXP '^[1-5]';
-- Pattern: ^1-5%
SELECT * FROM document_types WHERE type_name REGEXP '^[^1-5]';
SELECT * FROM document_types WHERE description REGEXP '^[^1-5]';
SELECT * FROM document_types WHERE type_code REGEXP '^[^1-5]';
SELECT * FROM document_types WHERE required_for REGEXP '^[^1-5]';
SELECT * FROM document_types WHERE file_format REGEXP '^[^1-5]';
-- Pattern: _
SELECT * FROM document_types WHERE type_name LIKE 'CN_C';
SELECT * FROM document_types WHERE description LIKE 'Id_ntification%';
SELECT * FROM document_types WHERE type_code LIKE 'DOC_01';
SELECT * FROM document_types WHERE required_for LIKE 'Vot_r';
SELECT * FROM document_types WHERE file_format LIKE 'j_g';

-- 8. COMPLAINT_CATEGORIES
-- Pattern: %value
SELECT * FROM complaint_categories WHERE category_name LIKE '%ry';
SELECT * FROM complaint_categories WHERE category_code LIKE '%01';
SELECT * FROM complaint_categories WHERE description LIKE '%on';
SELECT * FROM complaint_categories WHERE handling_department LIKE '%nt';
SELECT * FROM complaint_categories WHERE status LIKE '%ive';
-- Pattern: value%
SELECT * FROM complaint_categories WHERE category_name LIKE 'Fr%';
SELECT * FROM complaint_categories WHERE category_code LIKE 'CAT%';
SELECT * FROM complaint_categories WHERE description LIKE 'Iss%';
SELECT * FROM complaint_categories WHERE handling_department LIKE 'Ele%';
SELECT * FROM complaint_categories WHERE status LIKE 'act%';
-- Pattern: %value%
SELECT * FROM complaint_categories WHERE category_name LIKE '%fraud%';
SELECT * FROM complaint_categories WHERE category_code LIKE '%00%';
SELECT * FROM complaint_categories WHERE description LIKE '%report%';
SELECT * FROM complaint_categories WHERE handling_department LIKE '%commission%';
SELECT * FROM complaint_categories WHERE status LIKE '%active%';
-- Pattern: 1-5%
SELECT * FROM complaint_categories WHERE category_name REGEXP '^[1-5]';
SELECT * FROM complaint_categories WHERE category_code REGEXP '^[1-5]';
SELECT * FROM complaint_categories WHERE description REGEXP '^[1-5]';
SELECT * FROM complaint_categories WHERE handling_department REGEXP '^[1-5]';
SELECT * FROM complaint_categories WHERE status REGEXP '^[1-5]';
-- Pattern: ^1-5%
SELECT * FROM complaint_categories WHERE category_name REGEXP '^[^1-5]';
SELECT * FROM complaint_categories WHERE category_code REGEXP '^[^1-5]';
SELECT * FROM complaint_categories WHERE description REGEXP '^[^1-5]';
SELECT * FROM complaint_categories WHERE handling_department REGEXP '^[^1-5]';
SELECT * FROM complaint_categories WHERE status REGEXP '^[^1-5]';
-- Pattern: _
SELECT * FROM complaint_categories WHERE category_name LIKE 'Fr_ud';
SELECT * FROM complaint_categories WHERE category_code LIKE 'CAT_01';
SELECT * FROM complaint_categories WHERE description LIKE 'Iss_e%';
SELECT * FROM complaint_categories WHERE handling_department LIKE 'Elect_on%';
SELECT * FROM complaint_categories WHERE status LIKE 'act_ve';

-- 9. COMPLAINTS
-- Pattern: %value
SELECT * FROM complaints WHERE complaint_title LIKE '%nt';
SELECT * FROM complaints WHERE complaint_number LIKE '%01';
SELECT * FROM complaints WHERE description LIKE '%on';
SELECT * FROM complaints WHERE evidence_path LIKE '%pg';
SELECT * FROM complaints WHERE status LIKE '%ing';
-- Pattern: value%
SELECT * FROM complaints WHERE complaint_title LIKE 'Vo%';
SELECT * FROM complaints WHERE complaint_number LIKE 'COM%';
SELECT * FROM complaints WHERE description LIKE 'The%';
SELECT * FROM complaints WHERE evidence_path LIKE 'evi%';
SELECT * FROM complaints WHERE status LIKE 'pen%';
-- Pattern: %value%
SELECT * FROM complaints WHERE complaint_title LIKE '%voter%';
SELECT * FROM complaints WHERE complaint_number LIKE '%00%';
SELECT * FROM complaints WHERE description LIKE '%problem%';
SELECT * FROM complaints WHERE evidence_path LIKE '%image%';
SELECT * FROM complaints WHERE status LIKE '%pending%';
-- Pattern: 1-5%
SELECT * FROM complaints WHERE complaint_title REGEXP '^[1-5]';
SELECT * FROM complaints WHERE complaint_number REGEXP '^[1-5]';
SELECT * FROM complaints WHERE description REGEXP '^[1-5]';
SELECT * FROM complaints WHERE evidence_path REGEXP '^[1-5]';
SELECT * FROM complaints WHERE status REGEXP '^[1-5]';
-- Pattern: ^1-5%
SELECT * FROM complaints WHERE complaint_title REGEXP '^[^1-5]';
SELECT * FROM complaints WHERE complaint_number REGEXP '^[^1-5]';
SELECT * FROM complaints WHERE description REGEXP '^[^1-5]';
SELECT * FROM complaints WHERE evidence_path REGEXP '^[^1-5]';
SELECT * FROM complaints WHERE status REGEXP '^[^1-5]';
-- Pattern: _
SELECT * FROM complaints WHERE complaint_title LIKE 'Vot_r%';
SELECT * FROM complaints WHERE complaint_number LIKE 'COM_01';
SELECT * FROM complaints WHERE description LIKE 'Th_s%';
SELECT * FROM complaints WHERE evidence_path LIKE 'evid_nce%';
SELECT * FROM complaints WHERE status LIKE 'pend_ng';

-- 10. VOTER_VERIFICATION
-- Pattern: %value
SELECT * FROM voter_verification WHERE device_id LIKE '%id';
SELECT * FROM voter_verification WHERE verification_code LIKE '%01';
SELECT * FROM voter_verification WHERE verification_method LIKE '%tp';
SELECT * FROM voter_verification WHERE ip_address LIKE '%.1';
SELECT * FROM voter_verification WHERE status LIKE '%ied';
-- Pattern: value%
SELECT * FROM voter_verification WHERE device_id LIKE 'dev%';
SELECT * FROM voter_verification WHERE verification_code LIKE 'VER%';
SELECT * FROM voter_verification WHERE verification_method LIKE 'otp%';
SELECT * FROM voter_verification WHERE ip_address LIKE '192%';
SELECT * FROM voter_verification WHERE status LIKE 'ver%';
-- Pattern: %value%
SELECT * FROM voter_verification WHERE device_id LIKE '%00%';
SELECT * FROM voter_verification LIKE '%code%';
SELECT * FROM voter_verification WHERE verification_method LIKE '%sms%';
SELECT * FROM voter_verification WHERE ip_address LIKE '%168%';
SELECT * FROM voter_verification WHERE status LIKE '%verified%';
-- Pattern: 1-5%
SELECT * FROM voter_verification WHERE device_id REGEXP '^[1-5]';
SELECT * FROM voter_verification WHERE verification_code REGEXP '^[1-5]';
SELECT * FROM voter_verification WHERE verification_method REGEXP '^[1-5]';
SELECT * FROM voter_verification WHERE ip_address REGEXP '^[1-5]';
SELECT * FROM voter_verification WHERE status REGEXP '^[1-5]';
-- Pattern: ^1-5%
SELECT * FROM voter_verification WHERE device_id REGEXP '^[^1-5]';
SELECT * FROM voter_verification WHERE verification_code REGEXP '^[^1-5]';
SELECT * FROM voter_verification WHERE verification_method REGEXP '^[^1-5]';
SELECT * FROM voter_verification WHERE ip_address REGEXP '^[^1-5]';
SELECT * FROM voter_verification WHERE status REGEXP '^[^1-5]';
-- Pattern: _
SELECT * FROM voter_verification WHERE device_id LIKE 'dev_ce%';
SELECT * FROM voter_verification WHERE verification_code LIKE 'VER_01';
SELECT * FROM voter_verification WHERE verification_method LIKE 'o_p';
SELECT * FROM voter_verification WHERE ip_address LIKE '192.168.1._';
SELECT * FROM voter_verification WHERE status LIKE 'verif_ed';

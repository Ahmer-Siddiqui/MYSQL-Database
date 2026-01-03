# 1. Admins

Purpose: Stores system administrators.

Why needed:

1. Admins manage the whole system (create elections, approve candidates, monitor results).
2. Keeps admin accounts separate from normal users for security.
3. Real-life analogy: Election Commission IT officers.

# 2. users

Purpose: Stores all people in the system.

Why needed:

1. Every person (voter, candidate, officer, agent) is a user.
2. Central table avoids duplication.
3. Real-life analogy: National voter registry.

# 3. roles

Purpose: Defines system roles (voter, candidate, officer, admin, observer).

Why needed:

1. One user can have different permissions.
2. Makes the system flexible and secure.

# 4. user_roles

Purpose: Connects users to roles.

Why needed:

1. A user can have multiple roles (e.g., voter + polling officer).
2. Keeps roles reusable and normalized.

# 5. elections

Purpose: Stores election events.

Why needed:

1. Supports multiple elections (national, provincial, local).
2. Tracks election status (running, paused, completed).

# 6. election_commission

Purpose: Stores official election commission members.

Why needed:

1. Only authorized commission members can control elections.
2. Keeps legal authority clearly defined.

# 7. cities

Purpose: Stores cities.

Why needed:

1. Elections are geographically organized.
2. Helps group districts and stations.

# 8. districts

Purpose: Stores districts within cities.

Why needed:

1. Elections are usually district-based.
2. Allows reporting and management per district.

# 9. polling_stations

Purpose: Stores polling station details.

Why needed:

1. Voting happens at stations.
2. Used for turnout, incidents, officers, and resources.

# 10. political_parties

Purpose: Stores political parties.

Why needed:

1. Candidates belong to parties.
2. Needed for results, alliances, and symbols.

# 11. positions

Purpose: Stores elected positions (e.g., President, MNA).

Why needed:

1. Different elections may be for different offices.
2. Makes elections reusable and scalable.

# 12. candidates

Purpose: Stores candidate participation in an election.

Why needed:

1. A user becomes a candidate for a specific election.
2. Connects user + party + election.

# 13. document_types

Purpose: Defines required document categories.

Why needed:

1. Candidates must submit documents (CNIC, nomination papers).
2. Keeps document handling standardized.

# 14. candidate_documents

Purpose: Stores candidate document submissions.

Why needed:

1. Verifies candidate eligibility.
2. Tracks approval or rejection.

# 15. election_agents

Purpose: Stores agents representing candidates.

Why needed:

1. Agents observe polling on behalf of candidates.
2. Prevents fraud and increases transparency.

# 16. polling_officers

Purpose: Stores officials working at polling stations.

Why needed:

1. Each station needs authorized officers.
2. Tracks assignment and accountability.

# 17. complaint_categories

Purpose: Defines complaint types.

Why needed:

1. Standardizes complaint handling.
2. Makes complaint analysis easier.

# 18. complaints

Purpose: Stores election-related complaints.

Why needed:

1. Allows voters, agents, or candidates to report issues.
2. Critical for fairness and transparency.

# 19. voter_verification

Purpose: Verifies voter identity.

Why needed:

1. Prevents fake or duplicate voting.
2. Links voter to device and verification status.

# 20. votes

Purpose: Stores votes cast.

Why needed:

1. Core table of the system.
2. Tracks who voted, for whom, and in which election.

# 21. election_results

Purpose: Stores calculated election results.

Why needed:

1. Separates voting from result declaration.
2. Supports provisional and final results.

# 22. audit_logs

Purpose: Tracks system actions.

Why needed:

1. Security and accountability.
2. Detects tampering or misuse.

# 23. notifications

Purpose: Stores messages sent to users.

Why needed:

1. Inform users about voting, approvals, results.
2. Keeps communication traceable.

# 24. system_settings

Purpose: Stores configurable system values.

Why needed:

1. Change system behavior without code changes.
2. Example: voting time limits.

# 25. election_phases

Purpose: Tracks election stages.

Why needed:

1. Elections happen in phases (registration, voting, counting).
2. Controls what actions are allowed.

# 26. station_resources

Purpose: Stores polling station equipment.

Why needed:

1. Tracks ballots, machines, seals.
2. Prevents shortages or misuse.

# 27. campaign_expenses

Purpose: Tracks candidate spending.

Why needed:

1. Enforces spending limits.
2. Prevents illegal funding.

# 28. media_coverage

Purpose: Stores media reports about elections.

Why needed:

1. Monitors public information.
2. Useful for transparency and history.

# 29. security_incidents

Purpose: Stores security-related events.

Why needed:

1. Elections can face threats or violence.
2. Helps investigations and reporting.

# 30. ballot_papers

Purpose: Tracks ballot papers.

Why needed:

1. Prevents duplicate or fake ballots.
2. Critical for physical voting security.

# 31. voter_turnout

Purpose: Stores turnout statistics.

Why needed:

1. Measures participation.
2. Important for analysis and reporting.

# 32. observer_reports

Purpose: Stores reports from observers.

Why needed:

1. Independent monitoring improves trust.
2. Provides evidence in disputes.

# 33. candidate_manifesto

Purpose: Stores candidate promises.

Why needed:

1. Helps voters make informed choices.
2. Preserves political commitments.

# 34. party_alliances

Purpose: Stores alliances between parties.

Why needed:

1. Political coalitions affect results.
2. Important for analysis and reporting.

# 35. election_budgets

Purpose: Tracks election spending.

Why needed:

1. Ensures transparency in public funds.
2. Prevents misuse of election budgets.
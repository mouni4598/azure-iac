-- ╔══════════════════════════════════════╗
-- ║ * DO NOT RUN IN CLOUD ENVIRONMENTS * ║
-- ╚══════════════════════════════════════╝
-- This script is only for OnPremise deployments.
-- It will absolutely wreck Cloud deployments.
-- It should be ran after the database migration is complete.

-- Enables the following features:
--  - API (api)
--  - Domain Monitoring (web-monitoring)
--  - Web User Flow (web-userflow)
-- Removes all Identity Providers.

-- Remove all feature toggles
DELETE FROM Platform_Features.FeatureToggle

DECLARE @Now DATETIME = GETUTCDATE()
DECLARE @EditorUserId UNIQUEIDENTIFIER = '10000000-0000-0000-0000-000000000000'
DECLARE @EditorUserProfileId UNIQUEIDENTIFIER = '11000000-0000-0000-0000-000000000000'

DECLARE @DefaultAccountId UNIQUEIDENTIFIER
SELECT @DefaultAccountId = ID FROM Platform_Accounts.Account WHERE IsRootAccount = 1

-- Insert OnPremise feature toggles for platform and default account
INSERT INTO Platform_Features.FeatureToggle
	(ID, Feature, AccountID, [Enabled], [Type], Created, Updated, EditorUserId, EditorUserProfileId)
VALUES
	-- platform
	(NEWID(), 'helpdesk', null, 0, 'platform', @Now, @Now, @EditorUserId, @EditorUserProfileId), 
	(NEWID(), 'web-crawl', null, 0, 'platform', @Now, @Now, @EditorUserId, @EditorUserProfileId), 
	(NEWID(), 'web-userflow', null, 1, 'platform', @Now, @Now, @EditorUserId, @EditorUserProfileId), 
	(NEWID(), 'api', null, 1, 'platform', @Now, @Now, @EditorUserId, @EditorUserProfileId), 
	(NEWID(), 'engagement', null, 0, 'platform', @Now, @Now, @EditorUserId, @EditorUserProfileId), 
	(NEWID(), 'web-monitoring', null, 1, 'platform', @Now, @Now, @EditorUserId, @EditorUserProfileId), 
	(NEWID(), 'jaws-inspect', null, 0, 'platform', @Now, @Now, @EditorUserId, @EditorUserProfileId),
	-- account
	(NEWID(), 'helpdesk', @DefaultAccountId, 0, 'account', @Now, @Now, @EditorUserId, @EditorUserProfileId), 
	(NEWID(), 'web-crawl', @DefaultAccountId, 0, 'account', @Now, @Now, @EditorUserId, @EditorUserProfileId), 
	(NEWID(), 'web-userflow', @DefaultAccountId, 1, 'account', @Now, @Now, @EditorUserId, @EditorUserProfileId), 
	(NEWID(), 'api', @DefaultAccountId, 1, 'account', @Now, @Now, @EditorUserId, @EditorUserProfileId), 
	(NEWID(), 'engagement', @DefaultAccountId, 0, 'account', @Now, @Now, @EditorUserId, @EditorUserProfileId), 
	(NEWID(), 'web-monitoring', @DefaultAccountId, 1, 'account', @Now, @Now, @EditorUserId, @EditorUserProfileId), 
	(NEWID(), 'jaws-inspect', @DefaultAccountId, 0, 'account', @Now, @Now, @EditorUserId, @EditorUserProfileId)

-- Remove Identity Providers but keep table
DELETE FROM Platform_Users.IdentityProvider
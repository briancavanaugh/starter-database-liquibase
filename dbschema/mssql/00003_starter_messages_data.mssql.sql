-- liquibase formatted sql

-- changeset Brian:00003_starter_messages_data
SET IDENTITY_INSERT dbo.StarterMessages ON;

INSERT INTO dbo.StarterMessages (StarterMessageId, Message)
VALUES
(1, 'Hello World!'),
(2, 'I am a robot.');

SET IDENTITY_INSERT dbo.StarterMessages OFF;

INSERT INTO audit.StarterMessages (TransactionType, UpdatedBy, UpdatedDate, StarterMessageId, Message)
SELECT 'I', 'Initial Data', GETDATE(), StarterMessageId, Message
FROM dbo.StarterMessages
WHERE StarterMessageId IN (1, 2)

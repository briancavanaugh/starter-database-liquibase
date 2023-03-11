-- liquibase formatted sql

-- changeset Brian:00003_starter_messages_data
INSERT INTO public.StarterMessages (StarterMessageId, Message)
VALUES
(1, 'Hello World!'),
(2, 'I am a robot.');

INSERT INTO audit.StarterMessages (TransactionType, UpdatedBy, UpdatedDate, StarterMessageId, Message)
SELECT 'I', 'Initial Data', NOW(), StarterMessageId, Message
FROM public.StarterMessages
WHERE StarterMessageId IN (1, 2)

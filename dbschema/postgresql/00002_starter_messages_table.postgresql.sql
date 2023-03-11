-- liquibase formatted sql

-- changeset Brian:00002_starter_messages_table
CREATE TABLE public.StarterMessages (
    StarterMessageId SERIAL NOT NULL
    , Message varchar(50) NOT NULL
    , CONSTRAINT PK_StarterMessages PRIMARY KEY (StarterMessageId)
);

CREATE TABLE audit.StarterMessages (
    AuditId BIGSERIAL NOT NULL
    , TransactionType char(1) NOT NULL
    , UpdatedBy varchar(50) NOT NULL
    , UpdatedDate timestamp NOT NULL
    , StarterMessageId int NOT NULL
    , Message varchar(50) NOT NULL
    , CONSTRAINT PK_StarterMessages PRIMARY KEY (AuditId)
);

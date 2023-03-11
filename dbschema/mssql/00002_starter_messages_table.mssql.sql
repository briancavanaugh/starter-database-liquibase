-- liquibase formatted sql

-- changeset Brian:00002_starter_messages_table
CREATE TABLE dbo.StarterMessages (
    StarterMessageId int IDENTITY (1, 1) NOT NULL
    , Message varchar(50) NOT NULL
    , CONSTRAINT PK_StarterMessages PRIMARY KEY (StarterMessageId)
);

CREATE TABLE audit.StarterMessages (
    AuditId bigint IDENTITY (1, 1) NOT NULL
    , TransactionType char(1) NOT NULL
    , UpdatedBy varchar(50) NOT NULL
    , UpdatedDate datetime2 NOT NULL
    , StarterMessageId int NOT NULL
    , Message varchar(50) NOT NULL
    , CONSTRAINT PK_StarterMessages PRIMARY KEY (AuditId)
);

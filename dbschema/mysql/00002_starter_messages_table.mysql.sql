-- liquibase formatted sql

-- changeset Brian:00002_starter_messages_table
CREATE TABLE StarterMessages (
    StarterMessageId int AUTO_INCREMENT NOT NULL
    , Message varchar(50) NOT NULL
    , PRIMARY KEY (StarterMessageId)
);

CREATE TABLE AuditStarterMessages (
    AuditId bigint AUTO_INCREMENT NOT NULL
    , TransactionType char(1) NOT NULL
    , UpdatedBy varchar(50) NOT NULL
    , UpdatedDate datetime NOT NULL
    , StarterMessageId int NOT NULL
    , Message varchar(50) NOT NULL
    , PRIMARY KEY (AuditId)
);

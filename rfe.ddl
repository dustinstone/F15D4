-- Generated by Oracle SQL Developer Data Modeler 4.1.1.888
--   at:        2015-11-18 18:29:14 CST
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g




DROP TABLE Approvers_RFEs CASCADE CONSTRAINTS ;

DROP TABLE Contacts_RFEs CASCADE CONSTRAINTS ;

DROP TABLE F15D4_Auth CASCADE CONSTRAINTS ;

DROP TABLE F15D4_Comment CASCADE CONSTRAINTS ;

DROP TABLE F15D4_Document CASCADE CONSTRAINTS ;

DROP TABLE F15D4_Employee CASCADE CONSTRAINTS ;

DROP TABLE F15D4_Lab CASCADE CONSTRAINTS ;

DROP TABLE F15D4_RFE CASCADE CONSTRAINTS ;

DROP TABLE F15D4_RFE_Approval CASCADE CONSTRAINTS ;

DROP TABLE F15D4_RFE_Task CASCADE CONSTRAINTS ;

DROP TABLE F15D4_StatusHistory CASCADE CONSTRAINTS ;

DROP TABLE RFEs_Tasks CASCADE CONSTRAINTS ;

DROP TABLE F15D4_Status CASCADE CONSTRAINTS;

CREATE TABLE Approvers_RFEs
  (
    employee_id     INTEGER NOT NULL ,
    rfe_id          INTEGER NOT NULL ,
    approver_rfe_id INTEGER NOT NULL
  ) ;
ALTER TABLE Approvers_RFEs ADD CONSTRAINT Approvers_RFEs_PK PRIMARY KEY ( approver_rfe_id ) ;


CREATE TABLE Contacts_RFEs
  (
    employee_id INTEGER NOT NULL ,
    rfe_id      INTEGER NOT NULL ,
    contact_id  INTEGER NOT NULL
  ) ;
ALTER TABLE Contacts_RFEs ADD CONSTRAINT Contacts_RFEs_PK PRIMARY KEY ( contact_id ) ;


CREATE TABLE F15D4_Auth
  ( auth_id INTEGER NOT NULL , RIGHT VARCHAR2 (255)
  ) ;
ALTER TABLE F15D4_Auth ADD CONSTRAINT F15D4_Auth_PK PRIMARY KEY ( auth_id ) ;


CREATE TABLE F15D4_Comment
  (
    comment_id     INTEGER NOT NULL ,
    rfe_id         INTEGER ,
    employee_id    INTEGER ,
    effective_date DATE ,
    comment_body      VARCHAR2 (4000)
  ) ;
ALTER TABLE F15D4_Comment ADD CONSTRAINT F15D4_Comment_PK PRIMARY KEY ( comment_id ) ;


CREATE TABLE F15D4_Document
  (
    document_id INTEGER NOT NULL ,
    rfe_id      INTEGER ,
    mimetype    VARCHAR2 (50) ,
    content BLOB ,
    charset  VARCHAR2 (255) ,
    filename VARCHAR2 (255)
  ) ;
ALTER TABLE F15D4_Document ADD CONSTRAINT F15D4_Document_PK PRIMARY KEY ( document_id ) ;


CREATE TABLE F15D4_Employee
  (
    employee_id           INTEGER NOT NULL ,
    active                CHAR (1) ,
    name                  VARCHAR2 (255) ,
    email                 VARCHAR2 (255) ,
    office_num            VARCHAR2 (255) ,
    phone_number          VARCHAR2 (255) ,
    status                VARCHAR2 (255) ,
    status_effective_date DATE ,
    type                  VARCHAR2 (255) ,
    lab_id                INTEGER ,
    auth_id               INTEGER NOT NULL
  ) ;
ALTER TABLE F15D4_Employee ADD CONSTRAINT F15D4_Employee_PK PRIMARY KEY ( employee_id ) ;


CREATE TABLE F15D4_Lab
  ( lab_id INTEGER NOT NULL , name VARCHAR2 (255)
  ) ;
ALTER TABLE F15D4_Lab ADD CONSTRAINT F15D4_Lab_PK PRIMARY KEY ( lab_id ) ;


CREATE TABLE F15D4_RFE
  (
    rfe_id               INTEGER NOT NULL ,
    lab_id               INTEGER ,
    explanation          VARCHAR2 (255) ,
    alt_protection       VARCHAR2 (255) ,
    approval_review_date DATE ,
    status_code          INTEGER ,
    status_history_id    INTEGER ,
    employee_id          INTEGER NOT NULL
  ) ;
CREATE INDEX F15D4_RFE__IDX ON F15D4_RFE
  (
    status_history_id ASC
  )
  ;
ALTER TABLE F15D4_RFE ADD CONSTRAINT F15D4_RFE_PK PRIMARY KEY ( rfe_id ) ;


CREATE TABLE F15D4_RFE_Approval
  (
    approval_id   INTEGER NOT NULL ,
    employee_type VARCHAR2 (255) ,
    rfe_id        INTEGER ,
    lab_id        INTEGER NOT NULL ,
    approved       CHAR (1) ,
    rejected        CHAR (1)
  ) ;
ALTER TABLE F15D4_RFE_Approval ADD CONSTRAINT F15D4_RFE_Approval_PK PRIMARY KEY ( approval_id ) ;


CREATE TABLE F15D4_RFE_Task
  (
    task_id        INTEGER NOT NULL ,
    effective_date DATE ,
    abbv           VARCHAR2 (255) ,
    description    VARCHAR2 (255)
  ) ;
ALTER TABLE F15D4_RFE_Task ADD CONSTRAINT F15D4_RFE_Task_PK PRIMARY KEY ( task_id ) ;


CREATE TABLE F15D4_StatusHistory
  (
    status_history_id INTEGER NOT NULL ,
                      TIMESTAMP DATE ,
    status_code       INTEGER ,
    rfe_id            INTEGER ,
    employee_id       INTEGER
  ) ;
CREATE INDEX F15D4_StatusHistory__IDX ON F15D4_StatusHistory
  (
    rfe_id ASC
  )
  ;
ALTER TABLE F15D4_StatusHistory ADD CONSTRAINT F15D4_StatusHistory_PK PRIMARY KEY ( status_history_id ) ;


CREATE TABLE RFEs_Tasks
  (
    rfe_id      INTEGER NOT NULL ,
    task_id     INTEGER NOT NULL ,
    rfe_task_id INTEGER NOT NULL
  ) ;
ALTER TABLE RFEs_Tasks ADD CONSTRAINT RFEs_Tasks_PK PRIMARY KEY ( rfe_task_id ) ;

CREATE TABLE F15D4_Status (
  status_id         NUMBER         PRIMARY KEY,
  description       VARCHAR2(255)  NOT NULL,
  status_code         INTEGER   NOT NULL
);

ALTER TABLE F15D4_Employee ADD CONSTRAINT F15D4_Auth_FK FOREIGN KEY ( auth_id ) REFERENCES F15D4_Auth ( auth_id ) ;

ALTER TABLE F15D4_Comment ADD CONSTRAINT F15D4_Employee_FK FOREIGN KEY ( employee_id ) REFERENCES F15D4_Employee ( employee_id ) ;

ALTER TABLE F15D4_StatusHistory ADD CONSTRAINT F15D4_Employee_FKv2 FOREIGN KEY ( employee_id ) REFERENCES F15D4_Employee ( employee_id ) ;

ALTER TABLE F15D4_RFE ADD CONSTRAINT F15D4_Employee_FKv3 FOREIGN KEY ( employee_id ) REFERENCES F15D4_Employee ( employee_id ) ;

ALTER TABLE F15D4_Employee ADD CONSTRAINT F15D4_Lab_FK FOREIGN KEY ( lab_id ) REFERENCES F15D4_Lab ( lab_id ) ;

ALTER TABLE F15D4_RFE ADD CONSTRAINT F15D4_Lab_FKv2 FOREIGN KEY ( lab_id ) REFERENCES F15D4_Lab ( lab_id ) ;

ALTER TABLE F15D4_RFE_Approval ADD CONSTRAINT F15D4_Lab_FKv3 FOREIGN KEY ( lab_id ) REFERENCES F15D4_Lab ( lab_id ) ;

ALTER TABLE F15D4_Comment ADD CONSTRAINT F15D4_RFE_FK FOREIGN KEY ( rfe_id ) REFERENCES F15D4_RFE ( rfe_id ) ;

ALTER TABLE F15D4_StatusHistory ADD CONSTRAINT F15D4_RFE_FKv2 FOREIGN KEY ( rfe_id ) REFERENCES F15D4_RFE ( rfe_id ) ;

ALTER TABLE F15D4_Document ADD CONSTRAINT F15D4_RFE_FKv3 FOREIGN KEY ( rfe_id ) REFERENCES F15D4_RFE ( rfe_id ) ;

ALTER TABLE F15D4_RFE_Approval ADD CONSTRAINT F15D4_RFE_FKv4 FOREIGN KEY ( rfe_id ) REFERENCES F15D4_RFE ( rfe_id ) ;

ALTER TABLE F15D4_RFE ADD CONSTRAINT F15D4_StatusHistory_FK FOREIGN KEY ( status_history_id ) REFERENCES F15D4_StatusHistory ( status_history_id ) ;

ALTER TABLE Approvers_RFEs ADD CONSTRAINT FK_ASS_1 FOREIGN KEY ( employee_id ) REFERENCES F15D4_Employee ( employee_id ) ;

ALTER TABLE RFEs_Tasks ADD CONSTRAINT FK_ASS_16 FOREIGN KEY ( rfe_id ) REFERENCES F15D4_RFE ( rfe_id ) ;

ALTER TABLE RFEs_Tasks ADD CONSTRAINT FK_ASS_17 FOREIGN KEY ( task_id ) REFERENCES F15D4_RFE_Task ( task_id ) ;

ALTER TABLE Approvers_RFEs ADD CONSTRAINT FK_ASS_2 FOREIGN KEY ( rfe_id ) REFERENCES F15D4_RFE ( rfe_id ) ;

ALTER TABLE Contacts_RFEs ADD CONSTRAINT FK_ASS_4 FOREIGN KEY ( employee_id ) REFERENCES F15D4_Employee ( employee_id ) ;

ALTER TABLE Contacts_RFEs ADD CONSTRAINT FK_ASS_5 FOREIGN KEY ( rfe_id ) REFERENCES F15D4_RFE ( rfe_id ) ;


-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            12
-- CREATE INDEX                             2
-- ALTER TABLE                             30
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0

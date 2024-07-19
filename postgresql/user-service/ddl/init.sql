DO $$
BEGIN
CREATE ROLE manager WITH
    LOGIN
    SUPERUSER
    INHERIT
    CREATEDB
    CREATEROLE
    REPLICATION;
EXCEPTION WHEN duplicate_object THEN RAISE NOTICE '%, skipping', SQLERRM USING ERRCODE = SQLSTATE;
END
$$;

CREATE DATABASE users;
GRANT ALL PRIVILEGES ON DATABASE users TO manager;

\c users;

CREATE SCHEMA users;

CREATE TABLE users.users
(
    user_uuid uuid,
    nickname character varying(255) NOT NULL,
    mobile_number character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    role character varying(35) NOT NULL,
    PRIMARY KEY (user_uuid),
    UNIQUE (mobile_number)
);

ALTER TABLE IF EXISTS users.users
    OWNER to manager;
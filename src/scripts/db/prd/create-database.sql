-- ###############################################################################################
-- ###############################################################################################
-- DROP SCRIPTS
-- ###############################################################################################
-- ###############################################################################################
drop user IF EXISTS SV_PMS_APP;
DROP DATABASE SV_PMS;

-- ###############################################################################################
-- ###############################################################################################
-- CREATE SCRIPTS
-- ###############################################################################################
-- ###############################################################################################

CREATE USER SV_PMS_APP WITH PASSWORD 'jRQJdKZCnmc697CY' LOGIN NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
CREATE DATABASE SV_PMS WITH OWNER = SV_PMS_APP ENCODING = 'UTF8' TABLESPACE = pg_default CONNECTION LIMIT = -1;

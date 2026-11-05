CREATE ROLE grp_lectura_analitica NOLOGIN;

GRANT CONNECT ON DATABASE finanzas_db TO grp_lectura_analitica;

GRANT USAGE ON SCHEMA public TO grp_lectura_analitica;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO grp_lectura_analitica;

CREATE ROLE analista_datos LOGIN PASSWORD 'analista!' INHERIT;
GRANT grp_lectura_analitica TO analista_datos;

ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO grp_lectura_analitica;

CREATE ROLE auditor_temporal_pg LOGIN PASSWORD 'auditor' VALID UNTIL '2026-12-31 23:59:59';
GRANT grp_lectura_analitica TO auditor_temporal_pg;

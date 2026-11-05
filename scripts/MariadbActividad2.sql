CREATE USER 'dba_core'@'172.18.0.1' IDENTIFIED VIA ed25519 USING PASSWORD('dba');

CREATE USER 'auditor_externo'@'172.18.0.%' IDENTIFIED BY 'auditor';

CREATE OR REPLACE VIEW v_tarjetas_seguras AS
SELECT c.dni, c.nombre_completo, c.nivel_riesgo, 
    CONCAT('**** **** **** ', RIGHT(t.pan_tarjeta, 4))
FROM tb_clientes c
INNER JOIN tb_tarjetas t ON c.id_cliente = t.id_cliente;

CREATE ROLE rol_gestor_fraude;
CREATE ROLE rol_atencion_cliente;

GRANT SELECT, INSERT, UPDATE, DELETE ON tb_clientes TO rol_gestor_fraude;
GRANT SELECT, INSERT, UPDATE, DELETE ON tb_tarjetas TO rol_gestor_fraude;

CREATE USER 'jefe_seguridad'@'%' IDENTIFIED BY 'jefe';
CREATE USER 'agente_sara'@'%' IDENTIFIED BY 'sara';

GRANT rol_gestor_fraude TO 'jefe_seguridad'@'%';
GRANT rol_atencion_cliente TO 'agente_sara'@'%';

SET DEFAULT ROLE rol_gestor_fraude FOR 'jefe_seguridad'@'%';
SET DEFAULT ROLE rol_atencion_cliente FOR 'agente_sara'@'%';

CREATE USER 'bot_extraccion'@'%' IDENTIFIED BY 'bot' WITH MAX_USER_CONNECTIONS 3;
GRANT rol_atencion_cliente TO 'bot_extraccion'@'%';
SET DEFAULT ROLE rol_atencion_cliente FOR 'bot_extraccion'@'%';
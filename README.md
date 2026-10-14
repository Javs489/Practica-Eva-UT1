# Practica-Eva-UT1
Practica Postgres

Repositorio de la práctica.


Video: https://www.youtube.com/watch?v=Ndf5z4aUqsQ
---

Estructura de la Práctica

Reto 1: Orquestación, Persistencia y Contraseñas
Contenedor desplegado con la imagen oficial de PostgreSQL
Docker secrets se implementó la variable `POSTGRES_PASSWORD_FILE` apuntando a `/run/secrets/db_password_secret` para evitar contraseñas en texto plano
El archivo db_contrasena.txt está protegido en Debian con permisos restrictivos chmod 600
Configurado mediante un volumen nombrado pg_data montado en la ruta interna del motor por defecto /var/lib/postgresql/data con puerto 5432

Reto 2: Configuración Core
Se ha realizado la configuracion de rendimiento tal cual el documento
max_connections = 150  Limitar el número máximo de conexiones concurrentes a 150.
shared_buffers = 128MB Asignar la memoria de los buffers compartidos (caché transaccional) a 128MB.
work_mem = 16MB 3. Asignar la memoria de trabajo por operación (usada para ordenaciones y hashes) a 16MB

Reto 3: Auditoría y Mapeo de Logs
Recolector interno mediante logging_collector=on
Slow Queries configurado con log_min_duration_statement=2000 para registrar consultas que superen los 2 segundos
Los registros se almacenan y persisten en el volumen nombrado pg_logs mapeado a /var/log/postgresql

Reto 4: Aislamiento Perimetral 
escucha Local configurado con listen_addresses=127.0.0.1 para restringir el acceso únicamente a conexiones locales del propio entorno
Verificada la denegación de acceso desde herramientas externas dbeber frente la conexión interna mediante la terminal del contenedor docker exec

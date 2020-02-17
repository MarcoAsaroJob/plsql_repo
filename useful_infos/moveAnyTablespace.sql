--1) Ottieni il nome del file del TableSpace
SELECT FILE_NAME, BYTES FROM DBA_DATA_FILES WHERE TABLESPACE_NAME = 'RETIM_SPACE';
--2) Disconnetti il tablespace
ALTER TABLESPACE RETIM_SPACE OFFLINE NORMAL;
--2.2) Assicurarsi, da sistema operativo, che la nuova cartella abbia i permessi ovviamente
--| chown -R oracle:dba /volu1
--3) muovi i files da sistema operativo (copiare i files sul nuovo path, quindi rimuoverli dal vecchio), OPPURE da qui...
    --3.1) cartella di origina
    CREATE DIRECTORY TS_OLD_DIR AS '/u01/app/oracle/oradata/xe';
    --3.2) cartella di destinazione
    CREATE DIRECTORY TS_NEW_DIR AS '/volu1';
    --3.3) trasferimento files
    BEGIN
        --3.3.1) copia
        DBMS_FILE_TRANSFER.COPY_FILE(
            source_directory_object       =>  'TS_OLD_DIR',
            source_file_name              =>  'RETIM_SPACE.dbf',
            destination_directory_object  =>  'TS_NEW_DIR',
            destination_file_name         =>  'RETIM_SPACE.dbf');
        --3.3.2) elimina il vecchio
        UTL_FILE.FREMOVE (
            location                    =>  'TS_OLD_DIR',
            filename                    =>  'RETIM_SPACE.dbf');
    END;
    /
--4) cambia il puntamento del tablespace
ALTER TABLESPACE RETIM_SPACE
    RENAME DATAFILE '/u01/app/oracle/oradata/xe/RETIM_SPACE.dbf'
                 TO '/volu1/RETIM_SPACE.dbf';
--5) Riconnetti il tablespace
ALTER TABLESPACE RETIM_SPACE ONLINE;
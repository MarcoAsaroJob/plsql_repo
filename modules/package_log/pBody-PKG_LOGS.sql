create or replace PACKAGE BODY PKG_LOGS AS
--Privates------------------------------------------------------------------------
FUNCTION DATAFY(FILE_NAME IN VARCHAR2) RETURN VARCHAR2 IS
BEGIN
    RETURN TO_CHAR(SYSDATE,'YYYY-MM-DD_')||FILE_NAME;
END DATAFY;
--------------------------------------------------------------------------------
PROCEDURE GET_CONFIGURATION IS
BEGIN
    --REPLACE THOSE QUERIES WITH YOUR CONFIG TABLE QUERIES
    SELECT 'TRUE'   INTO INFO_ENABLED   FROM DUAL;
    SELECT 'TRUE'   INTO ERROR_ENABLED  FROM DUAL;
    SELECT 'TRUE'   INTO WARN_ENABLED   FROM DUAL;
    SELECT 'FALSE'  INTO DEBUG_ENABLED  FROM DUAL;
END;
--------------------------------------------------------------------------------
PROCEDURE LOG_LINE(MESSAGE IN VARCHAR2) IS
  PTR_FILE_IN UTL_FILE.FILE_TYPE;
BEGIN
  PTR_FILE_IN := UTL_FILE.FOPEN(CARTELLA_LOG, FILE_LOG, 'a');
  UTL_FILE.PUT_LINE(PTR_FILE_IN, TO_CHAR(systimestamp,'dd/mm/yyyy HH24:MI:SS') || ' ' || GUID || ' ' || MESSAGE);
  UTL_FILE.FFLUSH(PTR_FILE_IN);
  UTL_FILE.FCLOSE(PTR_FILE_IN);
END LOG_LINE;
--Public------------------------------------------------------------------------
PROCEDURE LOG_INIT(CARTELLA_IN IN VARCHAR2, FILE_IN IN VARCHAR2, GUID_IN IN VARCHAR2) IS
BEGIN
	--Inizializzo le variabili non-nulle
  IF GUID_IN IS NOT NULL THEN
		GUID := GUID_IN;
  ELSE
    GUID := SYS_GUID();
	END IF;
  
  IF FILE_IN IS NOT NULL THEN
    FILE_LOG := DATAFY(FILE_IN);
  END IF;
  
  IF CARTELLA_IN IS NOT NULL THEN
    CARTELLA_LOG := CARTELLA_IN;
  END IF;
  
  GET_CONFIGURATION;
EXCEPTION
  WHEN OTHERS THEN
  LOG_LINE('[LOG_ERROR][LOG_INIT] '||SQLERRM||' - '||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END LOG_INIT;
--------------------------------------------------------------------------------
PROCEDURE LOG_WARN(MESSAGE IN VARCHAR2) IS
BEGIN
  IF WARN_ENABLED = 'TRUE' THEN
    LOG_LINE('[WARN] '||MESSAGE);
  END IF;
END LOG_WARN;
--------------------------------------------------------------------------------
PROCEDURE LOG_INFO(MESSAGE IN VARCHAR2) IS
BEGIN
  IF INFO_ENABLED = 'TRUE' THEN
    LOG_LINE('[INFO] '||MESSAGE);
  END IF;
END LOG_INFO;
--------------------------------------------------------------------------------
PROCEDURE LOG_DEBUG(MESSAGE IN VARCHAR2) IS
BEGIN
  IF DEBUG_ENABLED = 'TRUE' THEN
    LOG_LINE('[DEBUG] '||MESSAGE);
  END IF;
END LOG_DEBUG;
--------------------------------------------------------------------------------
PROCEDURE LOG_ERROR(MESSAGE IN VARCHAR2) IS
BEGIN
  IF ERROR_ENABLED = 'TRUE' THEN
    LOG_LINE('[ERROR] '||MESSAGE);
  END IF;
END LOG_ERROR;
--------------------------------------------------------------------------------
END PKG_LOGS;
/

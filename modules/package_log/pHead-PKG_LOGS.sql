create or replace PACKAGE PKG_LOGS AS
  --Settings--------------------------------------------------------------------
  CARTELLA_LOG      VARCHAR2(200)   := 'LOG_FOLDER';
  FILE_LOG          VARCHAR2(200)   := 'default_log_file.log';
  GUID              VARCHAR2(200)   := SYS_GUID();
  INFO_ENABLED      VARCHAR2(10)    := 'TRUE';
  ERROR_ENABLED     VARCHAR2(10)    := 'TRUE';
  WARN_ENABLED      VARCHAR2(10)    := 'TRUE';
  DEBUG_ENABLED     VARCHAR2(10)    := 'FALSE';
  --Procedures------------------------------------------------------------------
  ----Initialization
  PROCEDURE LOG_INIT(CARTELLA_IN IN VARCHAR2, FILE_IN IN VARCHAR2, GUID_IN IN VARCHAR2);
  ----Specialized
  PROCEDURE LOG_WARN(MESSAGE IN VARCHAR2);
  PROCEDURE LOG_INFO(MESSAGE IN VARCHAR2);
  PROCEDURE LOG_ERROR(MESSAGE IN VARCHAR2);
  PROCEDURE LOG_DEBUG(MESSAGE IN VARCHAR2);
----Utils
  FUNCTION DATAFY(FILE_NAME IN VARCHAR2) RETURN VARCHAR2;
END PKG_LOGS;
/
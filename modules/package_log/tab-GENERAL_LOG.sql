CREATE TABLE GENERAL_LOG (
    TS_LOG      TIMESTAMP       DEFAULT SYSTIMESTAMP,
    LOG_SESSION VARCHAR2(32)    DEFAULT SYS_GUID(),
    ORIGIN      VARCHAR2(30)    DEFAULT 'UNKNOWN',
    MODULE      VARCHAR2(30)    DEFAULT 'NONE',
    MESSAGE     VARCHAR2(4000),
    STACKTRACE  VARCHAR2(4000),
    LOG_TYPE    VARCHAR2(10)    DEFAULT 'INFO',
    LOG_FILE    VARCHAR2(200)   DEFAULT 'default_log_file.log',
    CONSTRAINT PL_GENERAL_LOG PRIMARY KEY (TS_LOG, LOG_SESSION, ORIGIN, MODULE)
);
COMMENT ON COLUMN GENERAL_LOG.LOG_SESSION   IS 'A SYS_GUID() or another serial to use to identify a stream of logs';
COMMENT ON COLUMN GENERAL_LOG.ORIGIN        IS 'Main program where the log is originated, example: Oracle, Package, Java-class, etc';
COMMENT ON COLUMN GENERAL_LOG.MODULE        IS 'The specific procedure where the log is originated, example: Procedure, Function, class.method, etc';
COMMENT ON COLUMN GENERAL_LOG.MESSAGE       IS 'The log message';
COMMENT ON COLUMN GENERAL_LOG.STACKTRACE    IS 'In case of errors, separate the message from the stacktrace by using this field';
COMMENT ON COLUMN GENERAL_LOG.LOG_TYPE      IS 'Enum: INFO, WARN, DEBUG, ERROR';
COMMENT ON COLUMN GENERAL_LOG.LOG_TYPE      IS 'Matches the log_file field in PKG_LOGS to keep compatibility in case of live switching between file and db';

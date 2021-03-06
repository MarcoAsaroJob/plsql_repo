create or replace PROCEDURE UTL_SEQ_NEXTVAL_CLEAN (NOME_TAB IN VARCHAR2, NOME_FIELD IN VARCHAR2) IS
  NOME_SEQ VARCHAR2(30);
  MAX_CAMPO NUMBER;
  NEXT_SEQ NUMBER;
  DIFF NUMBER;
  
  EX_SEQ_ALIGN EXCEPTION;
  PRAGMA EXCEPTION_INIT(EX_SEQ_ALIGN, -20999);
BEGIN
  SELECT NOME_SEQUENZA INTO NOME_SEQ FROM UTL_SEQUENCE_FACILITY WHERE NOME_TABELLA = NOME_TAB AND NOME_CAMPO = NOME_FIELD;
  EXECUTE IMMEDIATE '(SELECT MAX('||NOME_FIELD||') FROM '||NOME_TAB||')' INTO MAX_CAMPO;
  IF NOME_SEQ <> '-' THEN
    EXECUTE IMMEDIATE 'SELECT '||NOME_SEQ||'.NEXTVAL FROM DUAL' INTO NEXT_SEQ;
    IF MAX_CAMPO > NEXT_SEQ THEN
      DIFF := MAX_CAMPO - NEXT_SEQ;
      EXECUTE IMMEDIATE 'ALTER SEQUENCE '||NOME_SEQ||' INCREMENT BY '||DIFF;
      EXECUTE IMMEDIATE 'SELECT '||NOME_SEQ||'.NEXTVAL FROM DUAL';
      EXECUTE IMMEDIATE 'ALTER SEQUENCE '||NOME_SEQ||' INCREMENT BY 1';
    END IF;
    IF MAX_CAMPO < NEXT_SEQ THEN
      DIFF := NEXT_SEQ - MAX_CAMPO;
      EXECUTE IMMEDIATE 'ALTER SEQUENCE '||NOME_SEQ||' INCREMENT BY -'||DIFF;
      EXECUTE IMMEDIATE 'SELECT '||NOME_SEQ||'.NEXTVAL FROM DUAL';
      EXECUTE IMMEDIATE 'ALTER SEQUENCE '||NOME_SEQ||' INCREMENT BY 1';
    END IF;
  END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR( -20999, 'UTL_SEQ_NEXTVAL_CLEAN - ERRORE:'||SQLERRM);
END;
/
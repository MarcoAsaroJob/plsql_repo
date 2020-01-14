# SEQUENCE FACILITY

From the need to have under control each sequence, expecially while you're operating into a schema created by third persons where you have almost zero documentation and you have to investigate to discover how thing works.
It's also helpful in envirorment from Oracle12 and above to keep a relation between identity sequences and their tables without create synonyms.

    CREATE TABLE UTL_SEQUENCE_FACILITY (
      NOME_TABELLA  VARCHAR2(30),
      NOME_CAMPO    VARCHAR2(30),
      NOME_SEQUENZA VARCHAR2(30) --values: sequence_name; '-' if NO sequence is used (aka: max+1)
    );

CREATE UNIQUE INDEX IX_UTL_SEQFAL ON UTL_SEQUENCE_FACILITY(NOME_TABELLA, NOME_CAMPO, NOME_SEQUENZA);

Wich this table you may connect each field who have a sequences of each table to its own sequence.
This way with a simple query you can instant retrieve all informations you need.
Related to your needs, you could add optional fields like FLG_PK or DESCRIPTION, but for now keep it simple.

The main purpose is to instant get the value we need without knowing the sequence name or even if doesn't exists a sequence related.

How? Thanks to those functions:
-     FUNCTION UTL_SEQ_NEXTVAL(NOME_TAB IN VARCHAR2) RETURN NUMBER
-     FUNCTION UTL_SEQ_NEXTVAL_FIELD(NOME_TAB IN VARCHAR2, NOME_FIELD IN VARCHAR2) RETURN NUMBER

## UTL_SEQ_NEXTVAL
Use this only if your usage is flat: each table have only one field with a sequence

## UTL_SEQ_NEXTVAL_FIELD
The best one, you must add the field specification in order to retrieve the info

Both those functions having the same workflow:
a) Retrieve sequence name from the UTL_SEQUENCE_FACILITY
b1) SEQUENCE case, it will return the sequence.nextval()
b2) NO sequence case, it will dynamically perform the select max(NOME_CAMPO)+1 from NOME_TABELLA and return it
In each other case it will fire exception.
TODO: Add NULL management

## Keep everything up to date!
Sometimes happens to see non-aligned sequences for many reasons (we won't discuss here why).
In order to quick-fix those circumstances, exists this procedure:

    PROCEDURE UTL_SEQ_NEXTVAL_CLEAN (NOME_TAB IN VARCHAR2, NOME_FIELD IN VARCHAR2)

It's designed to auto-align a sequence to the current max(NOME_FIELD) of the NOME_TABELLA.

## Pratice usage

A typical example of usage is this:

- Flat usage example
-    INSERT INTO departments (dep_id, dep_name) VALUES (UTL_SEQ_NEXTVAL('departments'), 'San Francisco Facility');
- non flat usage example
-    INSERT INTO departments (dep_id, dep_name) VALUES (UTL_SEQ_NEXTVAL_FIELD('departments','dep_id'), 'San Francisco Facility');

To re-align the sequence, it's enough a snippet like this:

    EXEC UTL_SEQ_NEXTVAL_CLEAN('departments','dep_id');

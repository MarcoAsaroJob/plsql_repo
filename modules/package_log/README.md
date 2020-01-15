# Simple PKG_LOGS

A simple snippet for a default package to manage logs into a file, specialized by type (INFO, WARN, ERROR, DEBUG).
It works in three modes: FILE, DB, COMBO (file+db).
In this version the configuration must be set manually via LOG_INIT procedure.
Soon the support for a configuration table sample.

This is a sample, of course you can customize it for your needings (by changing GENERAL_LOG table name or by compressing in 1 method only the specialized logs (LOG_INFO, LOG_WARN, etc).

LOG_ON_DB and LOG_ON_FILE are private on purpose: this way you can support all the parameters stored in the package and because this way you will standardize log usage.

TODO:
- Add configuration table DDL snippet
- Add examples of usage into the README.md

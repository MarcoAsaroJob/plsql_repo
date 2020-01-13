select 
pt.id, pt.object_name, pt.object_type, pt.options, pt.operation, pt.time, pt.io_cost
from plan_table pt where statement_id = 'query1' order by id;
explain plan set STATEMENT_ID = 'query1' for
select 1 from dual;
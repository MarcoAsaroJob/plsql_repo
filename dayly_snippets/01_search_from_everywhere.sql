SELECT * FROM ALL_source WHERE UPPER(text) LIKE upper('%search_thing%') order by owner, type, name;
SELECT * FROM all_tab_columns WHERE UPPER(COLUMN_NAME) LIKE upper('%search_thing%') order by TABLE_NAME;
select * from all_cons_columns where upper(column_name) like upper('%search_thing%');

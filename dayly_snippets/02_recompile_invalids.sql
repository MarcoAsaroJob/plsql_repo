begin FOR cur IN (SELECT OBJECT_NAME, OBJECT_TYPE, owner FROM all_objects WHERE owner = :OBJECT_OWNER AND status = 'INVALID' ) LOOP 
BEGIN
  if cur.OBJECT_TYPE = 'PACKAGE BODY' then 
    EXECUTE IMMEDIATE 'alter package "' || cur.owner || '"."' || cur.OBJECT_NAME || '" compile body'; 
  else 
    EXECUTE IMMEDIATE 'alter ' || cur.OBJECT_TYPE || ' "' || cur.owner || '"."' || cur.OBJECT_NAME || '" compile'; 
  end if; 
EXCEPTION
  WHEN OTHERS THEN NULL; 
END;
end loop; end;
/
select * from all_objects where status = 'INVALID' order by owner, object_type;
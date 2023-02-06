create or replace trigger tr_constructors_cti
  for insert or update or delete on constructors
  compound trigger
  -- declarative section (optional)
  type constructors_tt is table of constructors_jn%rowtype
    index by pls_integer;
  -- variables declared here have firing-statement duration.
  g_constructors_jn constructors_tt;
  --executed before dml statement
  before statement is
  begin
    null;
  end before statement;

  --executed before each row change- :new, :old are available
  before each row is
  begin
    null;
  end before each row;

  --executed aftereach row change- :new, :old are available
  after each row is
    l_constructor constructors_jn%rowtype;
  begin
    if inserting
  or updating
    then
      l_constructor.constructorid  := :new.constructorid;
      l_constructor.constructorref := :new.constructorref;
      l_constructor.name           := :new.name;
      l_constructor.nationality    := :new.nationality;
      l_constructor.url            := :new.url;
    else
      l_constructor.constructorid  := :old.constructorid;
      l_constructor.constructorref := :old.constructorref;
      l_constructor.name           := :old.name;
      l_constructor.nationality    := :old.nationality;
      l_constructor.url            := :old.url;
    end if;
    if inserting
    then
      l_constructor.jn_action := 'I';
    elsif updating
    then
      l_constructor.jn_action := 'U';
    else
      l_constructor.jn_action := 'D';
    end if;
    l_constructor.jn_date := systimestamp;
    g_constructors_jn(g_constructors_jn.count + 1) :=
      l_constructor;
  end after each row;

  --executed after dml statement
  after statement is
  begin
    forall indx in g_constructors_jn.first ..
    g_constructors_jn.last
    insert
      into   constructors_jn
      values g_constructors_jn( indx );
  end after statement;

end tr_constructors_cti;
/

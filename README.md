## Execution code for Lab

**Run sql:**

```
docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=YourStrong@Passw0rd" -e "MSSQL_PID=Developer" -p 14330:1433 --name mssql -d mcr.microsoft.com/mssql/server:2022-latest
```

**View Database:**

```
docker exec -i mssql /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "YourStrong@Passw0rd" -C -Q "SELECT name FROM sys.databases"
```

**Database name: KirtanADTLab3**

**View Tables of database:**

```
docker exec -i mssql /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "YourStrong@Passw0rd" -C -Q "SELECT name FROM sys.tables WHERE schema_id = SCHEMA_ID('dbo') AND type = 'U' ORDER BY name" -d KirtanADTLab3
```

**View Columns of All tables:**

```
docker exec -i mssql /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "YourStrong@Passw0rd" -C -Q "SELECT t.name AS TableName, c.name AS ColumnName, ty.name AS DataType, c.max_length, c.precision, c.scale, c.is_nullable FROM sys.tables t JOIN sys.columns c ON t.object_id = c.object_id JOIN sys.types ty ON c.system_type_id = ty.system_type_id WHERE t.name IN ('KirtanCourses', 'KirtanStudentRegistration', 'KirtanStudents') ORDER BY t.name, c.column_id" -d KirtanADTLab3
```

**View data of any table:**

> KirtanStudents Table

```
docker exec -i mssql /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "YourStrong@Passw0rd" -C -Q "SELECT \* FROM KirtanStudents" -d KirtanADTLab3
```

> KirtanADTLab3 Table

```
docker exec -i mssql /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "YourStrong@Passw0rd" -C -Q "SELECT \* FROM KirtanStudentRegistration" -d KirtanADTLab3
```

> Kirtan Course Table

```
docker exec -i mssql /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "YourStrong@Passw0rd" -C -Q "SELECT \* FROM KirtanCourses" -d KirtanADTLab3
```

**Git Push Command:**

```
git add .
git commit -m "My Commit message"
git push -u origin main
```

## EOF

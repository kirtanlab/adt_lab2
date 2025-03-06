View Database:
docker exec -i mssql /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "YourStrong@Passw0rd" -C -Q "SELECT name FROM sys.databases"

Run Database:
docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=YourStrong@Passw0rd" -e "MSSQL_PID=Developer" -p 14330:1433 --name mssql -d mcr.microsoft.com/mssql/server:2022-latest

Git Push Command:
git push -u origin main

# ORACLEDB-EX-02
Oracle 21c XE container setup and basic SQL testing for cloud and local environments.
## Requirements
### Local Machine (Windows)
- Docker Desktop installed and running.
- PowerShell or Command Prompt access.
- Git (optional, for cloning repository).

### Cloud Environment (GCP)
- Ubuntu 22.04 LTS virtual machine.
- Docker installed: `sudo apt install docker.io git`.
- Minimum 4GB RAM and 50GB disk space.
- Firewall rules allowing access to ports 1521 (Oracle listener) and 5500.
- SSH access to the VM.

## Steps
### 1.Verify Docker Installation
docker --version
sudo docker --version (GCP Ubuntu VM)

### 2.Clone Oracle Docker Repository
git clone https://github.com/oracle/docker-images.git
cd docker-images/OracleDatabase/SingleInstance/dockerfiles

### 3.Build Oracle Database Image
# Windows
./buildContainerImage.sh -v 21.3.0 -x

# GCP (requires sudo)
sudo ./buildContainerImage.sh -v 21.3.0 -x

### 4.Run Oracle Database Container
# Windows
docker run --name oraclexe -d --restart unless-stopped \
  -p 1521:1521 -p 5500:5500 \
  -e ORACLE_PWD=ORACLE oracle/database:21.3.0-xe

# GCP
sudo docker run --name oraclexe -d --restart unless-stopped \
  -p 1521:1521 -p 5500:5500 \
  -e ORACLE_PWD=ORACLE oracle/database:21.3.0-xe

-Verify container logs
# Windows
docker logs -f oraclexe

# GCP
sudo docker logs -f oraclexe
Expected output: DATABASE IS READY TO USE!

### 5.Connect Using SQLPlus
# Windows
docker exec -it oraclexe bash
sqlplus sys/ORACLE@//localhost:1521/XE as sysdba
SELECT name FROM v$database;

# GCP
sudo docker exec -it oraclexe bash
sqlplus sys/ORACLE@//localhost:1521/XE as sysdba
SELECT name FROM v$database;

Expected output: XE

### 6.Optional Test: Create User and Table

***NOTES***
-Docker Permissions: On GCP, use sudo for Docker commands.
-Firewall and Ports: Ensure ports 1521 and 5500 are open.
-Build Time: Building the Oracle image may take several minutes.
-SQLPlus: Use SYSDBA privileges for administrative commands.

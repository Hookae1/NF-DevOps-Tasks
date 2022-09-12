# NF-DevOps-Tasks

<details><summary><h3>1. LINUX</h3></summary>
<p>   
   
   ### Tasks

   1. Get context from URL.
   2. Check CPU, memory, network, disks.
   3. Add user and add to sudo group.
   4. Create file and change permissions for only sudo user access (read | write). 
   5. Writing an installation program bash script.
      - Atom or other IDE.
      - Checking program availability. 
      - Use logical operators. 

   ### Solution

   :one: Tasks 1-4 - [:computer_mouse: CLICK HERE](Linux/tasks1_4.sh) 

   :two: Task 5 - [:computer_mouse: CLICK HERE](Linux/configuration.sh)
   
</p>  
</details>

<details><summary><h3>2. GIT</h3></summary>
<p>
   
Solution for task #2 (Git) available via link - [:computer_mouse: GIT](https://github.com/Hookae1/test.git)
   
</p>
</details>
   
<details><summary><h3>3. Docker</h3></summary>

### Tasks 

1. Start web on container from registry.
2. Writing your Dockerfile and building a docker image.
   - Run a docker container with limits. 
3. Attach volume to container and come to container.
4. Run docker compose file from github.
5. Start a SQL database.

### Solution

:one: Pulling docker images (NGINX web server) from Docker Hub and checking it on web:
```ruby
docker run --name mynginx1 -p 80:80 -d nginx
curl http://localhost
```
:two: Writing your Dockerfile and building a docker image. Run a docker container with limits.
Dockerfile available [:computer_mouse: Dockerfile](Docker/Dockerfile)
```ruby
docker build . -t apache2:v.1
docker run -d -p 80:80 --cpus=".5" -m "256m" apache2:v.1
```
:three: Attaching volume to a docker container (two options: using mount or volume):
```ruby
docker run -d -p 80:80 \
--cpus=".5" -m "256m" \
--name apache_v1 \
--mount source=apache-vol,target=/usr/share/apache2/html \
apache2:v.1
```
:four:

:five: Docker compose for MySQL server - [:computer_mouse: docker-compose](Docker/docker-compose.yml)
To run docker-compose use next command:
```ruby
docker-compose --env-file .mysql_env up -d
```
> --env-file .mysql_env - mean, fetch ENV data from separate file in docker-compose

> -d - run docker-compose in deattached mode (on background)

Connection to MySQL server:

- Enter into docker container:
```ruby
docker exec -it docker_db_1 bash
```
> docker_db_1 - name of docker-container

> bash - to allocate terminal

- Connect to DB and check present DB:

```ruby
mysql --utoohes -ptoohes
```

> -utoohes - username of MySQL, defined in .mysql_env file

> -ptoohes - password for MySQL, defined in .mysql_env file

Retrieve list of available databases in our MySQL:
```ruby
SHOW DATABASES;
```

</p>
</details>
   
<details><summary><h3>4. SQL</h3></summary>
<p>
   
1. Create a database
   - Add 2 tables and fill with some values
2. Use the SELECTS for getting data.
3. Make backup.
4. Remove one table.
5. Restore the backup.
6. Remove the one database.

:one: Create database and adding 2 tables:
```ruby
CREATE DATABASE world;
USE world;
CREATE TABLE countries (
   Name varchar(255),
   Capital varchar(255),
   Location varchar(255),
   Population int
);

INSERT INTO countries VALUES ('Ukraine', 'Kyiv', 'Europe', '44000000');
INSERT INTO countries VALUES ('Great Britain', 'London', 'Europe', '62000000');
INSERT INTO countries VALUES ('USA', 'Washington', 'North America', '330000000');

CREATE TABLE currency (
   Name varchar(255),
   ExchangeRateUSD int default 5
);
```

:two: Select data from TABLES:
```ruby
SELECT * FROM countries;
SELECT * FROM countries
WHERE Location = 'Europe';
```

:three: Make backup
```ruby
mysqldump -uroot -pmysqltoohes world > backup.sql
```

:four: Remove one table
```ruby
DROP TABLE currencies;
```

:five: Restore backup
```ruby
mysql -uroot -pmysqltoohes world < backup.sql
```

:six: Remove one database
```ruby
DROP DATABASE world;
```
</p>
</details>

<details><summary><h3>5. Azure</h3></summary>
<p>

### Tasks

1. Create VPC and accessable VM.
2. Use a JSON template from your VM to create the same.
3. Add a user to AD as a viewer.

### Solutions

:one: For creating VPC and VM I used Azure CLI. 

All commands write down bash script - [:computer_mouse: CLICK HERE](Azure/azure_test.sh)

:two: For creating template from already deployed VM, follow next:

> 1. Directly from VM:
>    - On a section "Automation" leftward choose "Export template".
> 2. From Resoruce Group:
>    - On a section "Essentials" press on "Deployments".
>    - Choose latest successfull deployment of VM.
>    - On the left side select "Template" and press "Deploy".
>    - Configure your VM according to own needs and create it.
  

:three: For creating new user with rules for viewing only, perform next:

> - Open Azure Active Directory.
> - Click add user on the top.
> - Provide all necessary information regarding new user.
> - After that move to the start page of AD and click "User" in a section "Manage".
> - Select required user;
> - Click on "Assigner roles" - "Add assignments".
> - Finally, choose rules which you want to provide ('Global reader') and press "Add".
> - Rules successfully assigned.


</p>
</details>

<details><summary><h3>6. Terraform</h3></summary>
<p>

All information about Terraform - [:computer_mouse: CLICK_HERE](Terraform/README.md)

</p>
</details>

<details><summary><h3>7. Ansible</h3></summary>
<p>

Provision Infrustructe by Ansible (recently created using Terrafom).

There are present roles structure [:computer_mouse: CLICK_HERE](Ansible/roles/moon_test).

Purpuse of this code - configure Apache2 web-server on a client-machine.

Anisle inventory was generated using Terraform - [inventory](Ansible/inventory).

To run ansible playbook, do next:
> switch to Ansible directory from a root and run ansible-playbook
```
cd Ansible
ansible-playbook playbook.yml
```
> To check if Apache2 adjusted properly, type:
> curl http://public_ip_address which was displayed in Outputs

</p>
</details>

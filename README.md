# Cara ini dilakukan ketika ingin melakukan migrasi service ke production

1. Source Update
    - Pastikan pom.xml sudah terupdate dengan distributionManagement, seperti dibawah ini:
 
    ```	
    <distributionManagement>
		<repository>
			<id>nexus</id>
			<name>maven-releases</name>
			<url>http://172.18.25.68:8081/repository/maven-releases/</url>
		</repository>
		<snapshotRepository>
			<id>nexus</id>
			<name>maven-snapshots</name>
			<url>http://172.18.25.68:8081/repository/maven-snapshots/</url>
		</snapshotRepository>
	</distributionManagement>
    ```
    letakan dependencies diatas tepat diatas ```</project>``` .
    - Pastikan Source sudah di merge/release ke branch master
    ```
    git br 
    git status
    ```
    - Pastikan settings.xml sudah mengarah ke repo/nexus bankmantap, berikut nexus isi file nexus
    
    ```
    <settings>
    <mirrors>
        <mirror>
        <!--This sends everything else to /public -->
        <id>nexus</id>
        <mirrorOf>*</mirrorOf>
        <url>http://172.18.25.68:8081/repository/maven-all/</url>
        </mirror>
    </mirrors>
    <profiles>
        <profile>
        <id>nexus</id>
        <!--Enable snapshots for the built in central repo to direct -->
        <!--all requests to nexus via the mirror -->
        <repositories>
            <repository>
            <id>central</id>
            <url>http://central</url>
            <releases><enabled>true</enabled></releases>
            <snapshots><enabled>true</enabled></snapshots>
            </repository>
        </repositories>
        <pluginRepositories>
            <pluginRepository>
            <id>central</id>
            <url>http://central</url>
            <releases><enabled>true</enabled></releases>
            <snapshots><enabled>true</enabled></snapshots>
            </pluginRepository>
        </pluginRepositories>
        </profile>
    </profiles>
    <activeProfiles>
        <!--make the profile active all the time -->
        <activeProfile>nexus</activeProfile>
    </activeProfiles>
    <servers>
    <server>
        <id>nexus</id>
        <username>admin</username>
        <password>YEs37anOjenbXc</password>
        </server>
    </servers>
    </settings>
    ```
2. Push source local to repo
    - compile source dilocal masing-masing project
    > mvn clean install -Dmavenskiptest
    - deploy source from local to nexus repository
    > mvn clean deploy

3. Deploy To PRD Enviroment
    proses ini dilakukan dengan menggunakan jaringan bankmantap atau menggunakan VPN bankmantap
    - cd ~/bin/tools-deploy/soa/deploy-prd-soa-_namaservice_.sh
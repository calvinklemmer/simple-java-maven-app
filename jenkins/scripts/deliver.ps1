Write-Output "The following Maven command installs your Maven-built Java application into the local Maven repository, which will ultimately be stored in Jenkins's local Maven repository (and the 'maven-repository' Docker data volume)."
Invoke-Expression "mvn jar:jar install:install help:evaluate -Dexpression=project.name"

Write-Output "The following command extracts the value of the <name/> element within <project/> of your Java/Maven project's 'pom.xml' file."
$NAME = & mvn -q -DforceStdout help:evaluate -Dexpression=project.name

Write-Output "The following command behaves similarly to the previous one but extracts the value of the <version/> element within <project/> instead."
$VERSION = & mvn -q -DforceStdout help:evaluate -Dexpression=project.version

Write-Output "The following command runs and outputs the execution of your Java application (which Jenkins built using Maven) to the Jenkins UI."
Invoke-Expression "java -jar target/${NAME}-${VERSION}.jar"

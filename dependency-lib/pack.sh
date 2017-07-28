mvn package -Ppack
java -jar /usr/share/java/jarjar.jar process jarjar.rule target/*-with-dependencies.jar repacked.jar
zip -d repacked.jar "hbase-default.xml"
mvn org.apache.maven.plugins:maven-install-plugin:2.3.1:install-file -Dfile=repacked.jar \
-DgroupId=hadoop-hbase-repacked -DartifactId=hadoop-hbase-repacked -Dversion=0.98.8-2.6.0 -Dpackaging=jar
rm repacked.jar

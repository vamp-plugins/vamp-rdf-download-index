set CP="jar\commons-lang-2.3.jar;jar\javax.servlet-3.0.0.v201112011016.jar;jar\jetty-http-9.0.2.v20130417.jar;jar\jetty-io-9.0.2.v20130417.jar;jar\jetty-security-9.0.2.v20130417.jar;jar\jetty-server-9.0.2.v20130417.jar;jar\jetty-servlet-9.0.2.v20130417.jar;jar\jetty-util-9.0.2.v20130417.jar;jar\jetty-webapp-9.0.2.v20130417.jar;jar\jetty-xml-9.0.2.v20130417.jar;jar\jvamp.jar;jar\may.jar;jar\slf4j-api-1.7.2.jar;jar\slf4j-simple-1.7.2.jar;jar\spark-git-f1f0676.jar;jar\yertle.jar;jar\yeti.jar;target\classes;."

java -classpath %CP% -Djava.library.path="..\may\ext\native\win64" yeti.lang.compiler.yeti -d target\classes pluginlist.yeti

set VAMP_PATH=.\public\rdf\plugins

java -classpath %CP% -Djava.library.path="..\may\ext\native\win64" pluginlist


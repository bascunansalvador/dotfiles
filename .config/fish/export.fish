# Exports

export WORKSPACE="/Users/salvadorbascunan/workspace"

# Java
export JAVA_8_HOME=(/usr/libexec/java_home -v1.8.0_362)
export JAVA_11_HOME=(/usr/libexec/java_home -v11)
export JAVA_17_HOME=(/usr/libexec/java_home -v17)

export JAVA={$JAVA_11_HOME}/jre/bin/java

# Oracle EXA
export oracleDbUrl='' 
export oracleDbUser='' 
export oracleDbPassword='' 
export oracleProperties='oracleDbUrl=$oracleDbUrl oracleDbUser=$oracleDbUser oracleDbPassword=$oracleDbPassword'

# Logstash
export LOGSTASH_DESTINATION=alt-aot-g-fou01.fe.cosng.net:4560

dataSource {
  pooled = true
  driverClassName = "org.postgresql.Driver"
  username = "postgres"
  password = "postgres"
}
hibernate {
  cache.use_second_level_cache = true
  cache.use_query_cache = true
  cache.provider_class = 'net.sf.ehcache.hibernate.EhCacheProvider'
}
// environment specific settings
environments {
  development {
    dataSource {
//			dbCreate = "create-drop" // one of 'create', 'create-drop','update'
      dbCreate = "update"
      url = "jdbc:postgresql://localhost:5432/mercury"
      username = "postgres"
      password = "postgres"
    }
  }
  test {
    dataSource {
      dbCreate = "update"
      url = "jdbc:hsqldb:mem:testDb"
    }
  }
  production {
    dataSource {
      driverClassName = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
      dbCreate = "update"
      url = "jdbc:sqlserver://192.168.1.8;databaseName=mercury"
      username = "mercury"
      password = "Chiapas21"
    }
  }
}
dataSource {
  pooled = true
  driverClassName = "org.postgresql.Driver"
  username = "nopal"
  password = "lapon"
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
      url = "jdbc:postgresql://localhost:5432/mercury2"
      username = "nopal"
      password = "lapon"
       loggingSql = true
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
      dbCreate = "update"
      url = "jdbc:hsqldb:file:prodDb;shutdown=true"
    }
  }
}
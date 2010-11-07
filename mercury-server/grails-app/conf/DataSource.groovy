dataSource {
  pooled = true
  driverClassName = "org.postgresql.Driver"
  username = "sa"
  password = ""
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
      username = "nopal"
      password = "lapon"
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
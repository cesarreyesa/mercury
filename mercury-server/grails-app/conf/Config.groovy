import grails.plugins.springsecurity.SecurityConfigType

// locations to search for config files that get merged into the main config
// config files can either be Java properties files or ConfigSlurper scripts

 grails.config.locations = [ "file:/opt/nopalsoft/mercury/config/config.groovy"]
//                             "classpath:${appName}-config.groovy",
//                             "file:${userHome}/.grails/${appName}-config.properties",
//                             "file:${userHome}/.grails/${appName}-config.groovy"]

// if(System.properties["${appName}.config.location"]) {
//    grails.config.locations << "file:" + System.properties["${appName}.config.location"]
// }

grails.project.groupId = appName // change this to alter the default package name and Maven publishing destination
grails.mime.file.extensions = true // enables the parsing of file extensions from URLs into the request format
grails.mime.use.accept.header = false
grails.mime.types = [ html: ['text/html','application/xhtml+xml'],
                      xml: ['text/xml', 'application/xml'],
                      text: 'text/plain',
                      js: 'text/javascript',
                      rss: 'application/rss+xml',
                      atom: 'application/atom+xml',
                      css: 'text/css',
                      csv: 'text/csv',
                      all: '*/*',
                      json: ['application/json','text/json'],
                      form: 'application/x-www-form-urlencoded',
                      multipartForm: 'multipart/form-data'
                    ]

// URL Mapping Cache Max Size, defaults to 5000
//grails.urlmapping.cache.maxsize = 1000

// The default codec used to encode data with ${}
grails.views.default.codec = "none" // none, html, base64
grails.views.gsp.encoding = "UTF-8"
grails.converters.encoding = "UTF-8"
// enable Sitemesh preprocessing of GSP pages
grails.views.gsp.sitemesh.preprocess = true
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = ''

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// whether to install the java.util.logging bridge for sl4j. Disable for AppEngine!
grails.logging.jul.usebridge = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []

// set per-environment serverURL stem for creating absolute links
environments {
  production {
    grails.serverURL = "http://www.changeme.com"
    attachmentsPath = "/opt/nopalsoft/mercury/attachments/"
  }
  development {
    grails.serverURL = "http://localhost:8080/mercury-server"
    attachmentsPath = "/opt/nopalsoft/mercury/attachments/"
  }
  test {
    grails.serverURL = "http://localhost:8080/${appName}"
    attachmentsPath = "/opt/nopalsoft/mercury/attachments/"
  }

}

// log4j configuration
log4j = {
    // Example of changing the log pattern for the default console
    // appender:
    //
    //appenders {
    //    console name:'stdout', layout:pattern(conversionPattern: '%c{2} %m%n')
    //}

    error  'org.codehaus.groovy.grails.web.servlet',  //  controllers
           'org.codehaus.groovy.grails.web.pages', //  GSP
           'org.codehaus.groovy.grails.web.sitemesh', //  layouts
           'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
           'org.codehaus.groovy.grails.web.mapping', // URL mapping
           'org.codehaus.groovy.grails.commons', // core / classloading
           'org.codehaus.groovy.grails.plugins', // plugins
           'org.codehaus.groovy.grails.orm.hibernate', // hibernate integration
           'org.springframework.security', // hibernate integration
           'org.springframework',
           'org.hibernate',
           'net.sf.ehcache.hibernate'

    warn   'org.mortbay.log'
//    debug 'org.springframework.security'
}

grails.plugins.springsecurity.securityConfigType = SecurityConfigType.Annotation
//

grails.plugins.springsecurity.controllerAnnotations.staticRules = [
   '/js/**':        ['IS_AUTHENTICATED_ANONYMOUSLY', 'ROLE_ANONYMOUS', 'role_admin', 'user'],
   '/css/**':       ['IS_AUTHENTICATED_ANONYMOUSLY', 'ROLE_ANONYMOUS', 'role_admin', 'user'],
   '/images/**':    ['IS_AUTHENTICATED_ANONYMOUSLY', 'ROLE_ANONYMOUS', 'role_admin', 'user'],
   '/login/**':     ['IS_AUTHENTICATED_ANONYMOUSLY', 'ROLE_ANONYMOUS', 'role_admin', 'user'],
   '/logout/**':    ['IS_AUTHENTICATED_ANONYMOUSLY', 'ROLE_ANONYMOUS', 'role_admin', 'user'],
]

// Added by the Spring Security Core plugin:
grails.plugins.springsecurity.password.algorithm='SHA-1'
grails.plugins.springsecurity.userLookup.userDomainClassName = 'org.nopalsoft.mercury.domain.User'
grails.plugins.springsecurity.userLookup.authorityDomainClass = "org.nopalsoft.mercury.domain.Role"
grails.plugins.springsecurity.userLookup.passwordPropertyName = "password"
//grails.plugins.springsecurity.userLookup.authorityJoinClassName = 'org.nopalsoft.mercury.domain.UserRole'
//grails.plugins.springsecurity.authority.className = 'org.nopalsoft.mercury.domain.Role'

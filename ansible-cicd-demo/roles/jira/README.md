# Jira role

## Changelog

### v3.5.0
- Add logrotation tool to install during the Jira deployment to rotate properly Jira insight logs

### v3.4.2
- BREAKING CHANGE
  * Implemented database pool configuration so it is inline how Confluence role behaves. Verify the current connection pool size from /data/atlassian/jira/home/dbconfig.xml, "<pool-max-size>XX</pool-max-size>", apply it to group_vars/<environment>/configuration_jira as "jira_hibernate_max_size" before running this role version.

### v3.4.1
- Updated defaults in setenv.sh and server.xml templates to match those in Atlassian 9.17.x upstream

### v3.4.0
- Added support for VMR autojava

### v3.3.4
- Made tomcat header configurable with jira_server.max_http_header_size

### v3.3.3
- Added a logic which deletes the plugin cache directories
  * Will be run when upgrading the application or when a new "jira_clear_caches" variable is set to true

### v3.3.2
- Enabled UPM plugin upload by default, with the option to disable the feature using JIRA_UPM_DISABLE_UPLOAD flag (ROOTQC-267).
  Upload feature is required by "atlassian_plugin" role.

### v3.3.1
- Improvements:
  * Added implementation of cookie timeout for session and remember-me cookies
    * jira_session_cookie_timeout
      * by default it is not defined. It means it won't be changed from what is bundled by default
    * jira_rememberme_cookie_timeout
      * by default it is not defined. It means it won't be applied (by default it's not applied)
- confluence_session_cookie_timeout
  * Timeout definition of Session Cookie. Required in string format for xml module
  * Type: string (number)
  * Optional
  * Default: `{}`
- confluence_rememberme_cookie_timeout
  * Timeout definition of Remember-me Cookie. Required in string format for xml module
  * Type: string (number)
  * Optional
  * Default: `{}`

### v3.3.0
- Guess if Jira Service Management is present on target system when doing an upgrade
  * Present a prompt for operator advising them to update JSM manually before proceeding to other plugin updates
- Selects "vmr_application_name" value based on the value of jira_license_server variable to support different versions for Server and DC
- Added run_once to plugin preparation task
- Set jira_install_plugins to *true* in defaults

### v3.2.1
- Added run_once: true to select tasks to allow neat cluster updates in one go.
- Added missing default value for jira_upgrade_sql_backup (default: true)
- Remove the downloaded distribution package as soon as it is not needed anymore.

### v3.2.0
- Breaking changes
  * Role now defaults to a Data Center deployment.
  * Deprecated "jira_datacenter" variable.
  * Introduced a new variable "jira_license_server" to enforce use of Server version.

- Improvements
  * Updated MySQL connector version to 8.0.33.
  * Fixed the hard fail in "Wait until application is available" test.
  * Changed the "Wait until available" step to run on the target server instead of running on Ansible controller.
  * Added an application version check to prevent installation of 9.13.x and later on a Server license.

### v3.1.3
- AccessLogValve enabled by default
- Tweaked access log format

### v3.1.2
- Added support for defining `JIRA_HTTP_NON_PROXY_HOSTS`
- Added support for defining `JIRA_ENABLE_GLOBAL_IMAP_PROXY`

### v3.1.1
- Correcly handle situations where jira_plugins is empty but jira_include_atlassian_plugins is true

### v3.1.0
- Added handling for deprecated plugins.
- Added graceful handling for possible oauth token creation failures.
- Revised backup logic: setting jira_datacenter will no longer disable automated backups.
- Improved autobackup warning/notification logic.

### v3.0.0
- Added ansible 8 support
- Ansible 2.9 no longer supported

### v2.0.1
- Added support for extracting IP from XFF header and limit that with regular expression

### v2.0.0
- Added support for VMR based application and plugin version management.
- Use of VMR requires Ansible configuration migration. See the documentation at https://eficodems.atlassian.net/wiki/spaces/EFIPLATS/pages/3362095131/Jira+migration+to+VMR

### v1.8.3
- Add *jira_loggers* - variable to support:
    - Customize existing log levels.
    - Adding new custom loggers to log4j2.xml  
  See [example](./examples/jira_loggers_example.yml)
### v1.8.2
- Switch to use proxy/cache repository from artifactory.dev.eficode.io as the software download source (ROOTQC-6).
- BREAKING: Uses JFrog Identity Token for authentication. Token needs to be defined in {{ eficode_artifactory.token }}.

### v1.8.1
- Fixed regression in setting URL context in server.xml

### v1.8.0
For Jira 9.5 and later.

- Deprecated log4j configuration, Jira has been updated to log4j2.
- Updated Java startup parameters to recommended ones, optional Java 17 support.
- Updated Tomcat configuration with defaults from Jira 9.5+ distribution.
- Added automated Java memory management configuration based on configured maximum heap size.

### v1.7.17
- Added support for oauth tokens

### v1.7.16

- Fixed Jira log path handling & restart check

### v1.7.15

- Add variable for adding MySQL connector
- Add README.md with changelog

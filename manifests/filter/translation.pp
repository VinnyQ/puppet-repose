# [*app_name*]
#
# [*request_translations*]
# List containing http_methods, content_type, accept,
# translated_content_type, and a list of styles
#
# [*response_translations*]
# List containing content_type, accept, translated_content_type,
# and a list of styles
#
class repose::filter::translation (
  $ensure     = present,
  $app_name   = 'repose',
  $request_translations = undef,
  $response_translations = undef,
) inherits repose::params {

### Validate parameters

## ensure
  if ! ($ensure in [ present, absent ]) {
    fail("\"${ensure}\" is not a valid ensure parameter value")
  } else {
    $file_ensure = $ensure ? {
      present => file,
      absent  => absent,
    }
  }
  if $::debug {
    debug("\$ensure = '${ensure}'")
  }

## Manage actions

  file { "${repose::params::configdir}/translation.cfg.xml":
    ensure  => file,
    owner   => $repose::params::owner,
    group   => $repose::params::group,
    mode    => $repose::params::mode,
    require => Package['repose-filters'],
    content => template('repose/translation.cfg.xml.erb'),
  }

}
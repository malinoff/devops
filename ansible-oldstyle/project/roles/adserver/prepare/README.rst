adserver/build
==============

This role has everything needed to build adserver component.

**This role is parametrized**

All parameters are defined in 'adserver' namespace. For example,
'environment' variable should be used as 'adserver.environment'.

**Required startup parameters**:

**TODO**: descriptions

- environment
- host_domain
- region
- queue_uri
- memcached_cluster
- s3_entity_bucket
- redis_cluster

**Optional parameters**:

- port: which port should be used
- home_dir: where the app should be deployed, defaults to
  /opt/company/project/adserver
- log_dir: where log files are written, defaults to
  /var/log/company/project/adserver

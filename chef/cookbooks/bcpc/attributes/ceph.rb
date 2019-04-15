###############################################################################
# ceph
###############################################################################

default['bcpc']['ceph']['repo']['enabled'] = false
default['bcpc']['ceph']['repo']['url'] = ''

default['bcpc']['ceph']['pg_num'] = 64
default['bcpc']['ceph']['pgp_num'] = 64
default['bcpc']['ceph']['osds'] = %w(sdb sdc sdd sde)
default['bcpc']['ceph']['choose_leaf_type'] = 0
default['bcpc']['ceph']['osd_scrub_load_threshold'] = 0.5

# Help minimize scrub influence on cluster performance
default['bcpc']['ceph']['osd_scrub_begin_hour'] = 21
default['bcpc']['ceph']['osd_scrub_end_hour'] = 10
default['bcpc']['ceph']['osd_scrub_sleep'] = 0.1
default['bcpc']['ceph']['osd_scrub_chunk_min'] = 1
default['bcpc']['ceph']['osd_scrub_chunk_max'] = 5

# Set to 0 to disable. See http://tracker.ceph.com/issues/8103
default['bcpc']['ceph']['pg_warn_max_obj_skew'] = 10

# Set the default niceness of Ceph OSD and monitor processes
default['bcpc']['ceph']['osd_niceness'] = -10
default['bcpc']['ceph']['mon_niceness'] = -10

# set tcmalloc max total thread cache
default['bcpc']['ceph']['tcmalloc_max_total_thread_cache_bytes'] = '128MB'

# sets the max open fds at the OS level
default['bcpc']['ceph']['max_open_files'] = 2048

# set tunables for ceph osd reovery
default['bcpc']['ceph']['paxos_propose_interval'] = 1
default['bcpc']['ceph']['osd_recovery_max_active'] = 1
default['bcpc']['ceph']['osd_recovery_threads'] = 1
default['bcpc']['ceph']['osd_recovery_op_priority'] = 1
default['bcpc']['ceph']['osd_max_backfills'] = 1
default['bcpc']['ceph']['osd_op_threads'] = 2
default['bcpc']['ceph']['osd_mon_report_interval_min'] = 5

# Set RBD default feature set to only include layering and
# deep-flatten. Other values (in particular, exclusive-lock) may prevent
# instances from being able to access their root file system after a crash.
default['bcpc']['ceph']['rbd_default_features'] = 33

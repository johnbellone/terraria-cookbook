name 'terraria'
default_source :community
cookbook 'terraria', path: '.'
run_list 'os-hardening::default', 'ssh-hardening::default', 'terraria::default'

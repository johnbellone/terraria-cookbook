name 'terraria'
default_source :community
cookbook 'os-hardeninig'
cookbook 'ssh-hardeninig'
cookbook 'selinux::disabled'
cookbook 'terraria', path: '.'
run_list 'os-hardening::default', 'ssh-hardening::default', 'selinux::disabled', 'terraria::default'

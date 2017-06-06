class people::jabley::ssh_known_hosts {
    
    # Define: ssh_known_host
    # Parameters:
    # title - an FQDN that should have the host key accepted
    #
    define ssh_known_host () {
        # puppet code
        exec { "ssh_known_host_${title}":
            command => "ssh-keyscan ${title} >> ${people::jabley::home}/.ssh/known_hosts",
            unless  => "grep ${title} ${people::jabley::home}/.ssh/known_hosts",
        }
    }

    ssh_known_host { 'github.com': }
    ssh_known_host { 'gitlab.com': }
    ssh_known_host { 'gitlab.office.moo.com': }
}

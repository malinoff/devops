Example of an old-style ansible layout
--------------------------------------

This layout expects deployments on bare EC2 instances
using deb/rpm packages and systemd.

The intended usage is like::

    $ cd project
    $ ansible-playbook -i environments/beta actions/provision.yml
    $ ansible-playbook -i environments/beta actions/prepare.yml
    # On Jenkins
    $ ansible-playbook -i environments/infrastructure actions/build.yml
    $ ansible-playbook -i environments/beta actions/install.yml
    $ ansible-playbook -i environments/beta actions/configure.yml

Overall layout is too complicated and bloated with copy-paste,
you may want to look at ``ansible-docker`` directory containing more recent
layout I'm using.

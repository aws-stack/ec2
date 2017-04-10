Role Name
=========

Use this role to manage EC2 instances and auto scaling groups.

Requirements
------------

Role Variables
--------------

Dependencies
------------

Example Playbook
----------------

    - hosts: localhost
      roles:
         - { role: ec2, ec2_conf: "{{ some_variable }}" }

License
-------

BSD

Author Information
------------------

Filipe Niero Felisbino <filipenf@gmail.com>

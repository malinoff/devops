DevOps showcase
---------------

The purpose of this repository is to show what I can do with various
DevOps-related tools (like ansible, docker and terraform).
This is my DevOps automation portfolio, and should be observed as such.

``ansible-oldstyle`` directory contains ansible layout I was using in 2015;
don't expect anything sane (although at that time it was pretty useful).

During 2016 I've been working on a project whose deployment scripts were so
bloated that I can't even santinize them (I wasn't the one who wrote them),
but in a nutshell: 5 megabytes, 55715 lines of ansible scripts
(plain .yml files).

``ansible-docker`` directory contains an example of how would I automate
build & deployment of a single project in 2017 on existing infrastructure,
preserving backwards compatibility with an old deployment scripts
and Jenkins jobs (this is the answer to questions similar to
"why not kubernetes?" - moving to kubernetes/rancher/docker-swarm is a big
problem when you have something that have been working for 3+ years without
an issue).

``terraform`` directory contains an example of how would I automate
AWS infrastructure of a project consisting of multiple services in 2017.

Please, read READMEs in the corresponding directories in order to get
more detailed information about each showcase.

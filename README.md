# urbanmap-buildout
We assume the installation in the folder /srv/urbanmap/mapfish2.2 
 (that can be changed) and on an ubuntu distribution.
Your real username must replace in our commands the string "username".

First we become root
> sudo -s

We install the necessary libraries
> apt-get install build-essential
> apt-get install libreadline6-dev
> apt-get install zlib1g-dev (support zlib)
> apt-get install libbz2-dev
> apt-get install libjpeg62-dev
> apt-get install subversion
> apt-get install libpq-dev
> apt-get install libxml2-dev libxslt-dev
> apt-get install libsqlite3-dev

We work in the folder /srv
> cd /srv

We change the owner of the folder to avoid continue working as root
> chown -R username:username .

We leave the user root.
> exit

We create some directories
> mkdir install
> mkdir urbanmap
> cd install

We install python2.7 that will be used to run the buildout and zope instance
> wget http://python.org/ftp/python/2.7.3/Python-2.7.3.tgz
> tar xvzf Python-2.7.3.tgz
> cd Python-2.7.3
> ./configure --prefix=/srv/python273
> make
> make install

We install the python utility easy_install
> cd /srv/install
> wget http://peak.telecommunity.com/dist/ez_setup.py
> /srv/python273/bin/python ez_setup.py

We install the python utility virtualenv
> /srv/python273/bin/easy_install virtualenv

We can define a cache for buildout
See http://www.imio.be/support/documentation/tutoriels/utilisation-dun-buildout/definition-dun-cache-pour-buildout

We download the buildout files in our folder
> cd /srv/urbanmap
> svn co http://svn.communesplone.org/svn/communesplone/buildout/mapfish/tags/mapfish2.2 mapfish2.2
> cd mapfish2.2

We modify the Makefile file to indicate the real path of the virtualenv utility. 
To do that, you can edit the file in a simple text editor. 
It's necessary to replace the line "virtualenv-2.7 --no-site-packages ." by
    "/srv/python273/bin/virtualenv --no-site-packages ."
OR (my preference)
You can create a link to our virtualenv without modifying Makefile
    "ln -s /srv/python273/bin/virtualenv /usr/local/bin/virtualenv-2.7"

we initialize the buildout
> make bootstrap

We execute the buildout after each modification in the buildout.cfg file
> make buildout
OR
> bin/buildout -Nv

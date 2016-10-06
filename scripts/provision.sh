# Set up a database backed Flask application running
# through nginx/gunicorn and started/stopped with systemd.

# Install python, pip, virtualenv, postgres and nginx.
apt-get install -y python python-pip nginx postgresql postgresql-contrib postgresql-server-dev-9.5
pip install --upgrade pip
pip install virtualenv

# Create a postgres user and database.
cat << EOF | su - postgres -c psql
CREATE USER myproject WITH PASSWORD 'mypassword';
CREATE DATABASE myprojectdb WITH OWNER=myproject ENCODING='UTF8' TEMPLATE=template1;
EOF

# Change to the directory with our application source.
cd /vagrant/myproject

# Setup a virtualenv with flask, gunicorn, psycopg2 and
# other dependencies in requirements.txt.
virtualenv myprojectenv
source myprojectenv/bin/activate
pip install -r requirements.txt
# Migrate the database.
python scripts/migrate.py
# Leave the virtualenv
deactivate

# Change ownership of the project directory so the ubuntu
# user and nginx group can access it.
chown -R ubuntu:www-data /vagrant/myproject/

# Copy the pre-configured systemd script to /lib/systemd/system/.
cp /vagrant/scripts/resources/myproject.service /lib/systemd/system/
systemctl enable myproject
systemctl start myproject

# Disable the default nginx confin and copy the pre-configured
# myproject config and enable it.
rm /etc/nginx/sites-enabled/default
cp /vagrant/scripts/resources/myproject /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/myproject /etc/nginx/sites-enabled
service nginx restart

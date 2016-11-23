exec 2>&1

sudo /usr/bin/apt-key adv --keyserver pool.sks-keyservers.net --recv 1078ECD7
echo "deb http://apt.arvados.org/ trusty main" | sudo tee /etc/apt/sources.list.d/arvados.list

sudo apt-get install \
    gawk g++ gcc make libc6-dev libreadline6-dev zlib1g-dev libssl-dev \
    libyaml-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev \
    libncurses5-dev automake libtool bison pkg-config libffi-dev curl

mkdir -p ~/src

cd ~/src
curl http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.7.tar.gz | tar xz
cd ruby-2.1.7
./configure --disable-install-rdoc
make
sudo make install

sudo -i gem install bundler
	
# Install our PGP key and add HTTPS support for APT
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
sudo apt-get install -y apt-transport-https ca-certificates

# Add our APT repository
sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main > /etc/apt/sources.list.d/passenger.list'
sudo apt-get update

# Install Passenger + Nginx
sudo apt-get install -y nginx-extras passenger

sed -i '63 s/#//' /etc/nginx/nginx.conf

sudo service nginx restart
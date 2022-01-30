# Setup and Installation
Codebase is compatible with MacOS and Ubuntu(>= 18.04). Windows Installer or WSL are not supported.

### Windows
- Codebase is not compatible on Windows OS.
- You can follow this [YouTube Guide](https://www.youtube.com/watch?v=-iSAyiicyQY) to perform Dual Boot Ubuntu on your Windows PC/Laptop.
- If you're new, Dual Boot is safe and it's like 2 OS (Windows and Ubuntu) in one PC. Whenever you power on/restart PC it will ask to load up Windows or Ubuntu.

### Ubuntu
1. Update your system:
    ```bash
    sudo apt update
    sudo apt upgrade
    sudo apt dist-upgrade

    # Restart PC/Laptop If required
    ```

2. Install Node, Yarn, Ruby (2.4.0 with rbenv) and it's dev dependancies:
    ```bash
    sudo apt install curl
    curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

    sudo apt-get update
    sudo apt-get install git-core zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev nodejs yarn

    # Ruby with rbenv
    cd
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc
    exec $SHELL

    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
    echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
    exec $SHELL

    rbenv install 2.4.0
    rbenv global 2.4.0
    ruby -v
    # 2.4.0
    ```

3. Installing Other Dependencies:
    - Postgres 10:
      ```bash
      sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
      wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
      sudo apt update
      sudo apt install postgresql-10

      # Replace ubuntu below with your username
      sudo -u postgres createuser ubuntu -s
      ```
    - Redis Server:
      ```bash
      sudo apt install redis-server

      # check if it's running
      sudo service redis-server status

      # If it's not running, start manually
      sudo service redis-server start      
      ```
    - Imagemagick:
      ```bash
      sudo apt install libpq-dev libmagickwand-dev imagemagick
      ```

4. Code setup:
    - Initial:
      ```bash
      # Clone Project
      git clone https://gitlab.com/planetspark-backend/galaxy
      cd galaxy

      gem install bundler -v 1.17.3
      gem install rails -v 5.1.4

      bundle i
      ```
    - Import and Setup Codebase Database: Take the DB Dump file `galaxy_dump` from the team and import:
      ```bash
      rails db:create

      psql galaxy_development < path/to/galaxy_dump
      # Ignore errors messages

      rails db:migrate
      ```
    - Create Vapid Keys: Open `rails console` and run this command and set the keys in Point 5 Environment variables - `VAPID_PUBLIC_KEY` and `VAPID_PRIVATE_KEY`
      ```bash
      vapid_key = Webpush.generate_key

      # {
      #  :public_key => "XYZ",
      #  :private_key => "ABC"
      # }
      ```
    - Versions setup: In `rails console` run the following commands (2 times as below):
      ```bash
      require Rails.root + "db/migrate/20170402131412_create_versions.rb"
      CreateVersions.new.change

      require Rails.root + "db/migrate/20170402131412_create_versions.rb"
      CreateVersions.new.change
      ```

5. Environment Variables: Set the environment variables in your `~/.bashrc` file
    - After adding, then next step is to run `source ~/.bashrc` for the above Env Vars to take effect:
      ```bash
      source ~/.bashrc
      ```

6. Running Rails Server:
    ```bash
    # Start server - http://localhost:3000
    rails s
    ```


### MacOS
1. Install Node, Yarn and Ruby (2.4.0 using rbenv):
    ```bash
    # Install Homebrew if not installed already

    # Install Nodejs
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
    nvm --version
    nvm list
    # Pick up Node 12 version and install using:
    nvm install node_version_here
    nvm use node_version_here
    node -v
    # Your node version here

    npm install -g yarn

    # Install Ruby
    brew install rbenv ruby-build
    echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.zshrc
    source ~/.zshrc

    rbenv install 2.4.0
    rbenv global 2.4.0
    ruby -v
    # 2.4.0
    ```

2. Installing Other Dependencies:
    - Postgres 10:
      ```bash
      brew install postgresql@10
      createdb
      ```
    - Redis Server:
      ```bash
      brew install redis
      ```
    - Imagemagick:
      ```bash
      brew install imagemagick
      ```

3. Code setup:
    - Initial:
      ```bash
      # Clone Project
      git clone https://gitlab.com/planetspark-backend/galaxy
      cd galaxy

      gem install bundler -v 1.17.3
      gem install rails -v 5.1.4

      bundle i
      # Check Point 6 if your facing issues with bundle install
      ```
    - Import and Setup Codebase Database: Take the DB Dump file `galaxy_dump` from the team and import:
      ```bash
      rails db:create

      psql galaxy_development < path/to/galaxy_dump
      # Ignore errors messages

      rails db:migrate
      ```
    - Create Vapid Keys: Open `rails console` and run this command and set the keys in Point 4 Environment variables - `VAPID_PUBLIC_KEY` and `VAPID_PRIVATE_KEY`
      ```bash
      vapid_key = Webpush.generate_key

      # {
      #  :public_key => "XYZ",
      #  :private_key => "ABC"
      # }
      ```
    - Versions setup: In `rails console` run the following commands (2 times as below):
      ```bash
      require Rails.root + "db/migrate/20170402131412_create_versions.rb"
      CreateVersions.new.change

      require Rails.root + "db/migrate/20170402131412_create_versions.rb"
      CreateVersions.new.change
      ```

4. Environment Variables: Set the environment variables in your `~/.bashrc` file
    - After adding, then next step is to run `source ~/.bashrc` for the above Env Vars to take effect:
      ```bash
      source ~/.bashrc
      ```

5. Running Rails Server:
    ```bash
    # Start server - http://localhost:3000
    rails s
    ```

6. Possible Errors and Solutions:
    - `pg` gem error: On MacOS, path to postgres may not be added by default. Find the bin path of your Postgres install and export the path in your `~/.zshrc` file:
      - Example:
      ```bash
      export PATH=/Applications/Postgres.app/Contents/MacOS/bin:${PATH}
      ```

    - `rubyracer` gem issue: Dependancy to have V8 using brew:
      ```bash
      brew install v8@3.15
      bundle config build.libv8 --with-system-v8
      bundle config build.therubyracer --with-v8-dir=$(brew --prefix v8@3.15)
      bundle i
      ```

    - Some Imagemagick error: Possible solution is to reinstall and force link deps:
      ```bash
      brew unlink imagemagick
      brew install imagemagick@6 && brew link imagemagick@6 --force
      ```

      
### MacOS (Apple chip - M1)
1. Install iTerm
    - Download [iTerm](https://iterm2.com)
    - Open finder and find iTerm in applications, then right click on iTerm and click ‘Get Info’
    - Check the ‘open using Rosetta’ option then close it.

2. Install Homebrew, Node, Yarn and Ruby (2.5.1 using rbenv):
    ```bash
    # Install Homebrew 
    arch -x86_64 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

    # Install Nodejs
    arch -x86_64 curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash 
    nvm --version
    nvm list
    # Pick up Node 12 version and install using:
    nvm install node_version_here
    nvm use node_version_here
    export NVM_DIR="$HOME/.nvm"
    source ~/.nvm/nvm.sh
    node -v
    # Your node version here

    #Install Yarn
    npm install --global yarn

    # Install Ruby
    arch -x86_64 brew install rbenv ruby-build
    echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.zshrc
    source ~/.zshrc

    arch -x86_64 rbenv install 2.5.1
    arch -x86_64 rbenv global 2.5.1
    ruby -v
    # ruby 2.5.1p57 (2018-03-29 revision 63029) [x86_64-darwin21]
    ```

3. Git configurations:
    - Configuration
      ```bash
      git config --global color.ui true
      git config --global user.name "YOUR NAME"
      git config --global user.email "YOUR@EMAIL.com"
      ssh-keygen -t rsa -C "YOUR@EMAIL.com"
      cat ~/.ssh/id_rsa.pub
      ```
    - Lets add the code you see in the terminal to [YOUR_GITHUB](https://github.com/settings/keys).

      ```bash
      ssh -T git@github.com
      ```

    - You should get a message like this:
      ```bash
      Hi excid3! You've successfully authenticated, but GitHub does not provide shell access
      ```

4. Installing Other Dependencies:
    - Postgres 10:
      ```bash
      arch -x86_64 brew install postgresql@10
      echo 'export PATH="/usr/local/opt/postgresql@10/bin:$PATH"' >> ~/.zshrc
      source ~/.zshrc
      ```
    - Download [Postgres Application](https://postgresapp.com)
      ```bash
      export PATH=/Applications/Postgres.app/Contents/MacOS/bin:${PATH}
      createdb
      ```
    - Redis Server:
      ```bash
      arch -x86_64 brew install redis
      ```
    - Imagemagick:
      ```bash
      arch -x86_64 brew install imagemagick@6 && brew link imagemagick@6 --force
      echo 'export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"' >> ~/.zshrc
      source ~/.zshrc
      ```

5. Code setup:
    - Initial:
      ```bash
      # Clone Project
      git clone https://gitlab.com/planetspark-backend/galaxy
      cd galaxy

      gem install bundler -v 1.17.3
      arch -x86_64 gem install rails -v 5.1.5
      arch -x86_64 rbenv rehash
      rails -v
      # Your rails version here

      bundle i
      ```
    - Import and Setup Codebase Database: Take the DB Dump file `galaxy_dump` from the team and import:
      ```bash
      rails db:create

      psql galaxy_development < path/to/galaxy_dump
      # Ignore errors messages

      rails db:migrate
      ```
    - Create Vapid Keys: Open `rails console` and run this command and set the keys in Point 4 Environment variables - `VAPID_PUBLIC_KEY` and `VAPID_PRIVATE_KEY`
      ```bash
      vapid_key = Webpush.generate_key

      # {
      #  :public_key => "XYZ",
      #  :private_key => "ABC"
      # }
      ```
    - Versions setup: In `rails console` run the following commands (2 times as below):
      ```bash
      require Rails.root + "db/migrate/20170402131412_create_versions.rb"
      CreateVersions.new.change

      require Rails.root + "db/migrate/20170402131412_create_versions.rb"
      CreateVersions.new.change
      ```

6. Environment Variables: Set the environment variables in your `~/.bashrc` file
    - After adding, then next step is to run `source ~/.bashrc` for the above Env Vars to take effect:
      ```bash
      source ~/.bashrc
      ```

7. Running Rails Server:
    ```bash
    # Start server - http://localhost:3000
    rails s
    ```

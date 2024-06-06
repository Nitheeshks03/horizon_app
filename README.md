# horizon_app

##### Prerequisites

The setups steps expect following tools installed on the system.

- Github
- Ruby [3.2.2]
- Rails [7.1.3]

##### 1. Check out the repository

```bash
git clone https://github.com/Nitheeshks03/horizon_app.git
```

##### 2. Update .env

Copy the sample .env file and edit the database configuration and secrets as required.

```bash
cp .env.example .env
```

##### 3. Create and setup the database

Run the following commands to create and setup the database.

```ruby
rails db:create
rails db:migrate
rails db:seed
```

##### 4. Start the Rails server

You can start the rails server using the command given below.

```ruby
bundle exec rails s
```



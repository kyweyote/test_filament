
# Patient Management System

patient management system using Docker and Laravel's filament


## Features
- owner view, create, update, delete 
- patient view, create, update, delete
- which treatment gives to which patient
- overview of patient count group by disease 
- graph of treatment


## Installation

- docker-compose build
- docker-compose up -d
- docker exec -it test_filament bash
- composer install
- copy .env.example to .env
- php artisan key:generate
- create database (accessed by http://localhost:31000 name(root) password(12345))
- php artisan migrate
- php artisan db:seed
- login http://localhost:11000 
  email => test@example.com
  password => 12345


## License

The Laravel framework is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).

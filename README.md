Appointments API
=========
Api for creating appointments. Version is currently v1.

Appointment
-------

An appoint consists of 5 attributes 4 of which are user defined

 - first_name
 - last_name
 - start_time
 - end_time

All values are required.  Start time must be a value before end time.  Time should be expressed as a string in the format of "month/day/year hour:minute" where hour is in 24H format.

The API
-------

POST to v1/appointments to create a new appointment

`curl -X POST -H "Content-Type: application/json" -d "{\"appointment\":{\"first_name\": \"aname\", \"last_name\" : \"anothername\", \"start_time\" : \"01/31/14 11:00\", \"end_time\" : \"01/31/14 11:30\"}}" http://localhost:3000/v1/appointments`

GET to v1/appointments/:id to retrieve an appointment

`curl http://localhost:3000/v1/appointments/1`

PUT to v1/appointments/:id to update an appointment

`curl -X PUT -H "Content-Type: application/json" -d "{\"appointment\":{\"first_name\": \"anewname\"}}" http://localhost:3000/v1/appointments/1`

DELETE to v1/appointments/:id to delete an appointment

`curl -X DELETE http://localhost:3000/v1/appointments/1`

GET to v1/appointments to retrieve all appointments

`curl http://localhost:3000/v1/appointments`

The Code
-------

This software is intentionally lightweight and was built using the following

- sqlite for persistence
- rspec and factory_girl for testing
- rails 4
- jbuilder was included for rendering and easy api versioning but is not implemented.

Running Locally
--------

`git clone git@github.com:thegboat/appointments_test.git`

`cd appointments_test`

`bundle install`

`rake db:migrate`

`rake db:seed`

`rails s`

To run tests

`rake db:test:prepare`

`bundle exec rspec spec`



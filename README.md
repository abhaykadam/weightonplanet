Weight on Planet
================

This is a utility web-service which helps to convert weight (in kg) between
planets.

Running the web-service on local system
-----------------------------------

Run following command in terminal:

        $ rackup config
		
Then, open this [address](http://localhost:9292/?weight=25&from=Mars&to=The%20Sun) in a browser.

As a output, you should see something like:

        {
          "The Sun": "1795.2254641909815"
        }
		
Deploying the web-service to Heroku
-----------------------------------

Fire the commands from the terminal:

        $ heroku login
        $ heroku create
        $ heroku addons:add heroku-postgresql:dev
		$ heroku pg:promote HEROKU_POSTGRESQL_ORANGE_URL
		
The last command sets the `DATABASE_URL` environment variable to point to 
the added posgres instance; the name depends on the added instance type.
Use `heroku config` to get the correct one.

#####Transferring the local database to Heroku
        $ heroku db:push sqlite://weightonplanet.db
		
Using Weight on Planet
----------------------

After deploying the service to Heroku or after racking-up locally,
one can go to `http://localhost:9292/planets` to see the current list of
supported planets of the service.
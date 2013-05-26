Weight on Planet
================

This is a Sinatra based utility web-service which helps to convert weight (in kg) between
planets. The service uses JSON as a data exchange format.

Running the web-service on local system
-----------------------------------

Run following command in terminal:

        $ rackup config
		
Then, open this [address](http://localhost:9292/weight/25/from/Earth/to/Jupiter.json) in a browser.

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
one can go to `http://localhost:9292/planets.json` to see the current list of
supported planets.

The route for getting the conversion done is:

        GET '/weight/:weight/from/:from/to/:to.json'
        
So, for instance, the `GET` request for converting 25 kg from Jupiter to Mars would be,

        GET '/weight/25/from/Jupiter/to/Mars.json'
        
#####Dealing with Database

The Sqlite is used as a database to store the information about planets and the conversion rate between them.

Just single table, called `planet` is needed to store this information. The table contains a tuple of planet's name and the ratio of its weight to that of the Earth's 1 kg. So, adding a new planet to the table is real simple.
Just add the planet's name and the converted value of weight of 1 kg on Earth to that planet.

# Football

## Docker/docker-compose
**Step 1**: Add the `.env` file
It should have these variables:
```
POSTGRES_PASSWORD=1234
POSTGRES_USER=football
POSTGRES_DB=football
POSTGRES_HOST=db
```

**Step 2**: Build docker the image
```
docker build -t football .
```

**Step 3**: Build the docker-compose
```
docker-compose build
```

**Step 4**: Install the dependencies
```
docker-compose run web mix deps.get
```

**Step 5**: Run the migration
(it might take a few seconds because it'll compile the app)
```
docker-compose run web mix ecto.migrate
```

**Step 6**: Populating the database
The file `data.csv` was added to this project, and it's
available to populate the database using the `seeds`.
To populate the database you need to run this command:
```
docker-compose run web mix run priv/repo/seeds.exs
```

**Step 7**: Run the server
```
docker-compose up
```
You can access the `http://localhost/api/leagues` to see the data.

**Step 8**: Scaling the app
Right now we have only one server up. To scale it up to 3 we need
to run this command (open a new tab):
```
docker-compose scale web=3
```
Wait a few minutes and you will have 3 servers up and running on
your console.

The requests are being distributed by the three configured servers.
You can see the servers running by accessing: `http://localhost:1936/`
(login: admin / password: admin) under the section `http-backend`.


Accessing the interactive console:
```
docker-compose run web iex -S mix
```

## API
### JSON
  * http://localhost/api/leagues
    - will return a pair with keys `division` and `season`
    showing the available leagues/seasons that you can
    fetch more details.
    - The result will be something like:
    ```
      {
        results: [
          { "season": "201617", "division": "SP1" },
          { "season": "201617", "division": "SP2" },
          ...
        ]
      }
    ```
  * http://localhost/api/leagues/:division/:season
    - will return all the information available for the
    specific league and season requested.
    - Example request: `http://localhost/api/leagues/SP1/201617`
    - The result will be something like:
    ```
      {
        results: [
          {
            "season": "201617",
            "htr": "D",
            "hthg": 0,
            "htag": 0,
            "home_team": "La Coruna",
            "game_date": "2016-08-19",
            "ftr": "H",
            "fthg": 2,
            "ftag": 1,
            "division": "SP1",
            "away_team": "Eibar"
          },
          ...
        ]
      }
    ```

### Protocol Buffers
(The protocol buffer is working only without the docker.
So you need to follow the steps in the section below
"starting the phoenix server locally", following the
"Populating the database without docker" so you can
have data to fetch).
To make a request using protocol buffers you should
have your server running, open a new tab, and open
the interactive console:
```
iex -S mix
```
Inside the console you can send a request like this example:
```
Football.Client.get("SP1", "201617")
```
The `client` will trigger a request to
http://localhost:4000/api/protobuff/#{division}/#{season}
  * "division" is the first parameter ("SP1");
  * and "season" is the second parameter ("201617");

Once the request is triggered, the `ProtobuffsController` will handle it,
enconding and decoding the data.

#### Caveats
Right now it's working only with one object. I'm having issues to encode
a list of items.

## Starting the phoenix server locally
To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Populating the database without docker
```
mix run priv/repo/seeds.exs
```
So now you can start the server again and check the
[`localhost:4000/api/leagues`](http://localhost:4000/api/leagues)
to see the available divisions and seasons.

## Tests

To run the tests:
```
mix test
```

## References
  * https://medium.com/appunite-edu-collection/phoenix-framework-and-protobufs-faaf7482a23e
  * https://chase.pursu.es/protobuf-in-elixir-with-exprotobuf.html
  * https://github.com/bitwalker/exprotobuf
  * https://developers.google.com/protocol-buffers/docs/overview
  * https://docs.docker.com/compose/compose-file/#build
  * https://hub.docker.com/_/haproxy/
  * https://medium.com/@nirgn/load-balancing-applications-with-haproxy-and-docker-d719b7c5b231
  * https://medium.com/@cristiano.codelab/dockerizing-a-phoenix-application-4e62e7888ae8


### Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

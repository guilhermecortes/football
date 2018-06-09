# Football
To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Populate the database
The given file `data.csv` was added to this project, and it's
available to populate the database using the `seeds`.
To populate the database you need to run this command:
```
mix run priv/repo/seeds.exs
```
So now you can start the server again and check the
[`localhost:4000/api/leagues`](http://localhost:4000/api/leagues)
to see the available divisions and seasons.

## API
### JSON
  * http://localhost:4000/api/leagues - will return a pair with keys
  `division` and `season` showing the available leagues/seasons that
  you can fetch more details.
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
  * http://localhost:4000/api/leagues/:division/:season - will return
  all the information available for the specific league and season requested.
    - Example request: `http://localhost:4000/api/leagues/SP1/201617`
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
To make a request to the protocol buffers you should open your terminal
`iex -S mix` and send this request as example:
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

## Docker
Step 1: Build the image
```
docker build -t football .
```

Step 2: Access the interactive console
```
docker run football
```

Step 3: Build the docker-compose
```
docker-compose build
```

Step 4: Run the migration
```
docker-compose run web mix ecto.migrate
```

Step 5: Run the server
```
docker-compose up
```
You can access the `localhost` and see the server up and running.
The requests are being distributed by the three configured servers.
You can see the servers running by accessing: `http://localhost:1936/`
(login: admin / password: admin) under the section `http-backend`.

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


## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

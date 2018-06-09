defmodule Football.Client do
  require Logger
  HTTPoison.start

  def get(division, season) do
    Logger.info fn -> "Encoded message" end
    # Not sure why the request didn't work with the docker setup.
    res = HTTPoison.get!("http://localhost:4000/api/protobuff/#{division}/#{season}")
    IO.puts "*********************************************"
    IO.inspect(res.body)
    IO.puts "*********************************************"
    Logger.info fn -> "Result response code: #{res.status_code}" end
    Football.Protobufs.Result.decode(res.body)
  end
end

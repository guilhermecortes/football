defmodule Football.Factory do
  use ExMachina.Ecto, repo: Football.Repo

  def result_factory do
    %Football.Result{
      division: "SP1",
      season: "201617",
      game_date: ~D[2016-08-08],
      home_team: "Real Madrid",
      away_team: "Barcelona",
      fthg: 3,
      ftag: 1,
      ftr: "H",
      hthg: 1,
      htag: 1,
      htr: "D"
    }
  end
end

# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Football.Repo.insert!(%Football.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Football.Transaction
alias Football.Repo

defmodule Football.Seeds do
  def build_result(row) do
    %Football.Result{
      division: row.division,
      season: row.season,
      game_date: parse_date(row.game_date),
      home_team: row.home_team,
      away_team: row.away_team,
      fthg: parse_integer(row.fthg),
      ftag: parse_integer(row.ftag),
      ftr: row.ftr,
      hthg: parse_integer(row.hthg),
      htag: parse_integer(row.htag),
      htr: row.htr
    }
  end

  def parse_integer(value) do
    {result, _} = Integer.parse(value)
    result
  end

  def parse_date(value) do
    splitted_date = String.split(value, "/")
    converted_date = "20#{Enum.at(splitted_date, 2)}-#{Enum.at(splitted_date, 1)}-#{Enum.at(splitted_date, 0)}"

    Date.from_iso8601!(converted_date)
  end
end

File.stream!("priv/repo/data.csv")
  |> Stream.drop(1)
  |> CSV.decode(headers: [:division, :season, :game_date, :home_team, :away_team, :fthg, :ftag, :ftr, :hthg, :htag, :htr])
  |> Enum.map(fn (row) -> Football.Seeds.build_result(row) end)
  |> Enum.each(&Repo.insert!/1)

defmodule FootballWeb.LeaguesView do
  use FootballWeb, :view

  def render("index.json", %{results: results}) do
    %{
      results: Enum.map(results, &result_json/1)
    }
  end

  def render("show.json", %{results: results}) do
    %{
      results: Enum.map(results, &division_season_json/1)
    }
  end

  def result_json(result) do
    %{
      division: result.division,
      season: result.season
    }
  end

  def division_season_json(result) do
    %{
      division: result.division,
      season: result.season,
      game_date: result.game_date,
      home_team: result.home_team,
      away_team: result.away_team,
      fthg: result.fthg,
      ftag: result.ftag,
      ftr: result.ftr,
      hthg: result.hthg,
      htag: result.htag,
      htr: result.htr
    }
  end
end


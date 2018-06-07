defmodule FootballWeb.LeaguesController do
  use FootballWeb, :controller

  def index(conn, _params) do
    render conn, "index.json", results: Football.Result.available_leagues
  end

  def show(conn, %{"division" => division, "season" => season}) do
    results = Football.Result.result_by(division, season)
    render conn, "show.json", division: division, season: season, results: results
  end
end

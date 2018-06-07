defmodule Football.LeaguesViewTest do
  use FootballWeb.ConnCase
  import Football.Factory
  alias FootballWeb.LeaguesView

  test "result_json" do
    result = insert(:result)

    rendered_result = LeaguesView.result_json(result)

    assert rendered_result == %{
      division: result.division,
      season: result.season
    }
  end

  test "division_season_json" do
    result = insert(:result)

    rendered_result = LeaguesView.division_season_json(result)

    assert rendered_result == %{
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

  test "index.json" do
    result = insert(:result)

    rendered_results = LeaguesView.render("index.json", %{results: [result]})

    assert rendered_results == %{
      results: [LeaguesView.result_json(result)]
    }
  end

  test "show.json" do
    result = insert(:result)

    rendered_result = LeaguesView.render("show.json", %{results: [result], division: result.division, season: result.season})

    assert rendered_result == %{
      results: [LeaguesView.division_season_json(result)]
    }
  end
end

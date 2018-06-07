defmodule Football.FootballControllerTest do
  use FootballWeb.ConnCase
  import Football.Factory

  test "#index renders a list of available leagues/seasons" do
    conn = build_conn()
    result = insert(:result)

    conn = get conn, leagues_path(conn, :index)

    assert json_response(conn, 200) == %{
      "results" => [%{
        "division" => result.division,
        "season" => result.season
      }]
    }
  end

  test "#show renders the results for selected league/season" do
    conn = build_conn()
    result = insert(:result)

    conn = get conn, leagues_path(conn, :show, result.division, result.season)

    assert json_response(conn, 200) == %{
      "results" => [%{
        "division" => result.division,
        "season" => result.season,
        "game_date" => Date.to_string(result.game_date),
        "home_team" => result.home_team,
        "away_team" => result.away_team,
        "fthg" => result.fthg,
        "ftag" => result.ftag,
        "ftr" => result.ftr,
        "hthg" => result.hthg,
        "htag" => result.htag,
        "htr" => result.htr
      }]
    }
  end
end



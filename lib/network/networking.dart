// Networking, fetching data from API, GET requests
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nba_fan_app/models/latest_games.dart';
import '../models/game_info.dart';
import '../models/standings_model.dart';
import '../models/team.dart';
import '../models/team_roster.dart';

const kApiKey = "c61402d5f4msh12a9698ea8a037ap1cceafjsn23a7d02cb033";

class NetworkHelper {
  // ignore: missing_return
  Future<List<LatestGames>> getLatestGames(String date) async {
    http.Response response = await http.get(Uri.parse(
        "https://api-nba-v1.p.rapidapi.com/games/date/$date?rapidapi-key=$kApiKey"));
    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      List<LatestGames> latestGames = [];
      var gameDetails = data['api']['games'];
      int latestGamesLength = gameDetails.length;

      for (int u = 0; u < latestGamesLength; u++) {
        if (gameDetails[u]['statusGame'] == "Finished") {
          LatestGames latestGame = LatestGames(
            vTeamFullName: gameDetails[u]['vTeam']['fullName'],
            vTeamScore: gameDetails[u]['vTeam']['score']['points'],
            vTeamLogo: gameDetails[u]['vTeam']['logo'],
            hTeamFullName: gameDetails[u]['hTeam']['fullName'],
            hTeamScore: gameDetails[u]['hTeam']['score']['points'],
            hTeamLogo: gameDetails[u]['hTeam']['logo'],
            startTimeUTC: gameDetails[u]['startTimeUTC'],
            city: gameDetails[u]['city'],
            arena: gameDetails[u]['arena'],
            vNickname: gameDetails[u]['vTeam']['nickName'],
            hNickname: gameDetails[u]['hTeam']['nickName'],
            gameId: gameDetails[u]['gameId'],
          );
          latestGames.add(latestGame);
        }
      }
      return (latestGames);
    } else {
      print(response.statusCode);
    }
  }

  // ignore: missing_return
  Future<List<StandingsModel>> getStandings() async {
    DateTime now = new DateTime.now();
    DateTime year =
        new DateTime(now.year - 1); // - 1 beacause of the correct API call
    http.Response response = await http.get(Uri.parse(
        "https://api-nba-v1.p.rapidapi.com/standings/standard/$year?rapidapi-key=$kApiKey"));

    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      var standingsDetails = data['api']['standings'];
      int standingsDetailsLength = standingsDetails.length;
      List<StandingsModel> standingsModel = [];
      for (int i = 0; i < standingsDetailsLength; i++) {
        StandingsModel standingModel = StandingsModel(
            win: standingsDetails[i]['win'],
            loss: standingsDetails[i]['loss'],
            rank: standingsDetails[i]['conference']['rank'],
            winPercentage: standingsDetails[i]['winPercentage'],
            homeLoss: standingsDetails[i]['home']['loss'],
            homeWin: standingsDetails[i]['home']['win'],
            awayLoss: standingsDetails[i]['away']['loss'],
            awayWin: standingsDetails[i]['away']['win'],
            teamId: standingsDetails[i]['teamId'],
            teamName: getTeamName(standingsDetails[i]['teamId']));
        standingsModel.add(standingModel);
      }
      standingsModel.sort((a, b) => b.winPercentage.compareTo(a.winPercentage));
      return (standingsModel);
    } else {
      print(response.statusCode);
    }
  }

  // ignore: missing_return
  Future<List<Team>> getOnlyNBATeams() async {
    http.Response response = await http.get(Uri.parse(
        "https://api-nba-v1.p.rapidapi.com/teams/league/standard?rapidapi-key=$kApiKey"));
    if (response.statusCode == 200) {
      var teamsData = jsonDecode(response.body);
      List<Team> teams = [];
      for (int i = 0; i < 54; i++) {
        if (teamsData['api']['teams'][i]['nbaFranchise'] == '1' && i != 36) {
          Team team = Team(
              fullName: teamsData['api']['teams'][i]['fullName'],
              teamLogo: teamsData['api']['teams'][i]['logo'],
              teamId: teamsData['api']['teams'][i]['teamId']);
          teams.add(team);
        }
      }
      return (teams);
    } else {
      print(response.statusCode);
    }
  }

  Future<List<GameInfo>> getGameInfo(String gameId) async {
    http.Response response = await http.get(Uri.parse(
        "https://api-nba-v1.p.rapidapi.com/statistics/games/gameId/$gameId?rapidapi-key=$kApiKey"));
    var data = jsonDecode(response.body);
    var gameDetails = data['api']['statistics'];
    List<GameInfo> gameInfos = [];
    if (response.statusCode == 200) {
      for (int i = 0; i < data['api']['results']; i++) {
        GameInfo gameInfo = GameInfo(
            fastBreakPoints: gameDetails[i]['fastBreakPoints'],
            pointsinPaint: gameDetails[i]['pointsInPaint'],
            pointsOffTurnovers: gameDetails[i]['pointsOffTurnovers'],
            fgp: gameDetails[i]['fgp'],
            totReb: gameDetails[i]['totReb'],
            offReb: gameDetails[i]['offReb'],
            defReb: gameDetails[i]['defReb'],
            assists: gameDetails[i]['assists'],
            pFouls: gameDetails[i]['pFouls'],
            steals: gameDetails[i]['steals'],
            blocks: gameDetails[i]['blocks'],
            turnovers: gameDetails[i]['turnovers'],
            points: gameDetails[i]['points']);
        gameInfos.add(gameInfo);
      }
    }
    return (gameInfos);
  }

  Future<List<TeamRoster>> getTeamRoster(String teamId) async {
    http.Response response = await http.get(Uri.parse(
        "https://api-nba-v1.p.rapidapi.com/players/teamId/$teamId?rapidapi-key=$kApiKey"));
    var data = jsonDecode(response.body);
    var rosterDetails = data['api']['players'];
    List<TeamRoster> teamsRoster = [];

    if (response.statusCode == 200) {
      for (int i = 0; i < data['api']['results']; i++) {
        if (rosterDetails[i]['yearsPro'] != '0') {
          TeamRoster teamRoster = TeamRoster(
            firstName: rosterDetails[i]['firstName'],
            lastName: rosterDetails[i]['lastName'],
            yearsPro: rosterDetails[i]['yearsPro'],
            country: rosterDetails[i]['country'],
            dateOfBirth: rosterDetails[i]['dateOfBirth'],
            heightInMeters: rosterDetails[i]['heightInMeters'],
            weightinKilograms: rosterDetails[i]['weightInKilograms'],
          );
          //
          teamsRoster.add(teamRoster);
        }
      }
    }
    return (teamsRoster);
  }
}

// returns teamName by teamId
String getTeamName(String teamId) {
  switch (teamId) {
    case "1":
      {
        return "Atlanta Hawks";
      }
    case "2":
      {
        return "Boston Celtics";
      }
    case "4":
      {
        return "Brooklyn Nets";
      }
    case "5":
      {
        return "Charlotte Hornets";
      }
    case "6":
      {
        return "Chicago Bulls";
      }
    case "7":
      {
        return "Cleveland Cavaliers";
      }
    case "8":
      {
        return "Dallas Mavericks";
      }
    case "9":
      {
        return "Denver Nuggets";
      }
    case "10":
      {
        return "Detroit Pistons";
      }
    case "11":
      {
        return "Golden State Warriors";
      }
    case "14":
      {
        return "Houston Rockets";
      }
    case "15":
      {
        return "Indiana Pacers";
      }
    case "16":
      {
        return "Los Angeles Clippers";
      }
    case "17":
      {
        return "Los Angeles Lakers";
      }
    case "19":
      {
        return "Memphis Grizzlies";
      }
    case "20":
      {
        return "Miami Heat";
      }
    case "21":
      {
        return "Milwaukee Bucks";
      }
    case "22":
      {
        return "Minnesota Timberwolves";
      }
    case "23":
      {
        return "New Orleans Pelicans";
      }
    case "24":
      {
        return "New York Knicks";
      }
    case "25":
      {
        return "Oklahoma City Thunder";
      }
    case "26":
      {
        return "Orlando Magic";
      }
    case "27":
      {
        return "Philadelphia 76ers";
      }
    case "28":
      {
        return "Phoenix Suns";
      }
    case "30":
      {
        return "Sacramento Kings";
      }
    case "31":
      {
        return "San Antonio Spurs";
      }
    case "38":
      {
        return "Toronto Raptors";
      }
    case "40":
      {
        return "Utah Jazz";
      }
    case "41":
      {
        return "Washington Wizards";
      }
    case "29":
      {
        return "Portland Trail Blazers";
      }
    default:
      {
        return "Other team";
      }
  }
}

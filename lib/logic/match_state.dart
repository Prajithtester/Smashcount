import 'package:flutter_riverpod/flutter_riverpod.dart';

enum MatchType { singles, doubles }

class TeamState {
  final String name1;
  final String? name2; // For doubles
  final String teamLabel; // Default 'Team A' or 'Team B'
  final int score;
  
  // For Doubles positioning logic:
  // We strictly track who is in which court box (Right/Left).
  // In Doubles, players swap boxes ONLY when they win a point while serving.
  // When receiving, they stay in their box.
  final String playerInRightBox;
  final String playerInLeftBox;

  TeamState({
    required this.name1,
    this.name2,
    required this.teamLabel,
    this.score = 0,
    required this.playerInRightBox,
    required this.playerInLeftBox,
  });

  TeamState copyWith({
    String? name1,
    String? name2,
    String? teamLabel,
    int? score,
    String? playerInRightBox,
    String? playerInLeftBox,
  }) {
    return TeamState(
      name1: name1 ?? this.name1,
      name2: name2 ?? this.name2,
      teamLabel: teamLabel ?? this.teamLabel,
      score: score ?? this.score,
      playerInRightBox: playerInRightBox ?? this.playerInRightBox,
      playerInLeftBox: playerInLeftBox ?? this.playerInLeftBox,
    );
  }
}

class MatchSnapshot {
  final MatchType type;
  final TeamState teamA;
  final TeamState teamB;
  final bool isTeamAServing;
  final bool isContextFinished;
  final String? winner;

  MatchSnapshot({
    required this.type,
    required this.teamA,
    required this.teamB,
    required this.isTeamAServing,
    this.isContextFinished = false,
    this.winner,
  });

  String get currentServer {
    if (type == MatchType.singles) {
      return isTeamAServing ? teamA.name1 : teamB.name1;
    } else {
      // In Doubles:
      // If score is Even, serve from Right box.
      // If score is Odd, serve from Left box.
      final servingTeam = isTeamAServing ? teamA : teamB;
      final isEven = servingTeam.score % 2 == 0;
      return isEven ? servingTeam.playerInRightBox : servingTeam.playerInLeftBox;
    }
  }
  
  String get currentReceiver {
    if (type == MatchType.singles) {
      return isTeamAServing ? teamB.name1 : teamA.name1;
    } else {
       // In Doubles, receiver is determined by their position diagonally from server?
       // Actually no, BWF rules: "The player in the diagonally opposite service court shall be the receiver."
       // Server is at Right (Even) -> Receiver is at Right (Even) of other team (Diagonally opposite means Cross Court).
       // Wait. 
       // Right service court serves to Right service court (diagonally).
       // Left serves to Left.
       
       // So if Server is at Right (Even), Receiver is at Right (Even) of opponent.
       final receivingTeam = isTeamAServing ? teamB : teamA;
       final servingTeam = isTeamAServing ? teamA : teamB;
       
       final isServerEven = servingTeam.score % 2 == 0;
       return isServerEven ? receivingTeam.playerInRightBox : receivingTeam.playerInLeftBox;
    }
  }


  String get matchStatus {
    if (isContextFinished) return 'Finished';
    
    final sA = teamA.score;
    final sB = teamB.score;
    
    if (sA >= 20 && sB >= 20) {
      if (sA == sB) return 'Deuce';
      final diff = sA - sB;
      if (diff == 1) return 'Advantage ${teamA.teamLabel}';
      if (diff == -1) return 'Advantage ${teamB.teamLabel}';
    }
    return '';
  }
}

class MatchNotifier extends Notifier<MatchSnapshot> {
  @override
  MatchSnapshot build() {
    // Initial dummy state, should be initialized via setup
    return MatchSnapshot(
        type: MatchType.singles,
        teamA: TeamState(name1: 'A', teamLabel: 'Team A', playerInRightBox: 'A', playerInLeftBox: 'A'),
        teamB: TeamState(name1: 'B', teamLabel: 'Team B', playerInRightBox: 'B', playerInLeftBox: 'B'),
        isTeamAServing: true);
  }

  void startMatch({
    required MatchType type,
    required String pA1,
    String? pA2,
    required String pB1,
    String? pB2,
    String teamALabel = 'Team A',
    String teamBLabel = 'Team B',
  }) {
    state = MatchSnapshot(
      type: type,
      teamA: TeamState(
        name1: pA1, 
        name2: pA2,
        teamLabel: teamALabel, 
        playerInRightBox: pA1, 
        playerInLeftBox: pA2 ?? pA1 
      ),
      teamB: TeamState(
        name1: pB1, 
        name2: pB2,
        teamLabel: teamBLabel, 
        playerInRightBox: pB1, 
        playerInLeftBox: pB2 ?? pB1
      ),
      isTeamAServing: true,
    );
  }

  void scorePointFor(bool teamAWin) {
    if (state.isContextFinished) return;

    final currentServingIsA = state.isTeamAServing;
    
    // Logic:
    // 1. If Serving Team wins rally -> Add Point. 
    //    In Doubles -> Switch their positions. Continue serving.
    // 2. If Receiving Team wins rally -> Add Point.
    //    Become Server.
    //    NO position switch.

    if (teamAWin) {
      // Team A wins point
      if (currentServingIsA) {
        // A was serving and won -> Point for A, Swap A positions (if doubles), A continues serving
        final newScore = state.teamA.score + 1;
        
        TeamState newTeamA = state.teamA.copyWith(score: newScore);
        if (state.type == MatchType.doubles) {
           newTeamA = newTeamA.copyWith(
             playerInRightBox: state.teamA.playerInLeftBox,
             playerInLeftBox: state.teamA.playerInRightBox,
           );
        }
        
        state = MatchSnapshot(
          type: state.type,
          teamA: newTeamA,
          teamB: state.teamB,
          isTeamAServing: true, // Remains A
        );
      } else {
        // B was serving and lost -> Point for A, Service over to A.
        final newScore = state.teamA.score + 1;
        state = MatchSnapshot(
           type: state.type,
           teamA: state.teamA.copyWith(score: newScore),
           teamB: state.teamB,
           isTeamAServing: true, // Change to A
        );
      }
    } else {
      // Team B wins point
      if (!currentServingIsA) {
        // B was serving and won -> Point for B, Swap B positions (if doubles), B continues serving
        final newScore = state.teamB.score + 1;
        
        TeamState newTeamB = state.teamB.copyWith(score: newScore);
        if (state.type == MatchType.doubles) {
           newTeamB = newTeamB.copyWith(
             playerInRightBox: state.teamB.playerInLeftBox,
             playerInLeftBox: state.teamB.playerInRightBox,
           );
        }
        
        state = MatchSnapshot(
          type: state.type,
          teamA: state.teamA,
          teamB: newTeamB,
          isTeamAServing: false, // Remains B
        );
      } else {
        // A was serving and lost -> Point for B, Service over to B.
        final newScore = state.teamB.score + 1;
        state = MatchSnapshot(
           type: state.type,
           teamA: state.teamA,
           teamB: state.teamB.copyWith(score: newScore),
           isTeamAServing: false, // Change to B
        );
      }
    }
    
    _checkWinner();
  }
  
  void _checkWinner() {
    // Simple 21 point rule
    // Deuce logic: If 20-20, must win by 2. Max 30.
    final sA = state.teamA.score;
    final sB = state.teamB.score;
    
    // Check match point
    bool finished = false;
    String? winner;
    
    if (sA >= 21 || sB >= 21) {
       final diff = (sA - sB).abs();
       if (sA >= 30 || sB >= 30) {
         finished = true;
         winner = sA > sB ? state.teamA.teamLabel : state.teamB.teamLabel;
       } else if (diff >= 2 && (sA >= 21 || sB >= 21)) {
         finished = true;
         winner = sA > sB ? state.teamA.teamLabel : state.teamB.teamLabel;
       }
    }
    
    if (finished) {
      state = MatchSnapshot(
        type: state.type, 
        teamA: state.teamA, 
        teamB: state.teamB, 
        isTeamAServing: state.isTeamAServing,
        isContextFinished: true,
        winner: winner,
      );
    }
  }


  void updateTeamNames({
    required String teamAP1,
    String? teamAP2,
    required String teamBP1,
    String? teamBP2,
    String? teamALabel,
    String? teamBLabel,
  }) {
    // We also need to check if the current server/receiver names need updates in position referencing logic?
    // Actually, position logic relies on strings "playerInRightBox". 
    // If we change names logic, we must map old names to new names in box positions.
    // Simplifying assumption: Editing names updates the display names but keeps the 'slot' integrity.
    // WARN: If names are completely changed, the position strings might be stale.
    // Strategy: Map current Name1 -> New Name1.
    
    final oldA1 = state.teamA.name1;
    final oldA2 = state.teamA.name2;
    final oldB1 = state.teamB.name1;
    final oldB2 = state.teamB.name2;
    
    // Helper to safely replace name
    String updateName(String target, String oldName, String newName) {
      return target == oldName ? newName : target;
    }
    
    // Update A
    var newA = state.teamA.copyWith(name1: teamAP1, name2: teamAP2, teamLabel: teamALabel);
    // Update positions
    newA = newA.copyWith(
       playerInRightBox: updateName(newA.playerInRightBox, oldA1, teamAP1),
       playerInLeftBox: updateName(newA.playerInLeftBox, oldA1, teamAP1),
    );
    if (oldA2 != null && teamAP2 != null) {
        newA = newA.copyWith(
           playerInRightBox: updateName(newA.playerInRightBox, oldA2, teamAP2),
           playerInLeftBox: updateName(newA.playerInLeftBox, oldA2, teamAP2),
        );
    }

    // Update B
    var newB = state.teamB.copyWith(name1: teamBP1, name2: teamBP2, teamLabel: teamBLabel);
    // Update positions
    newB = newB.copyWith(
       playerInRightBox: updateName(newB.playerInRightBox, oldB1, teamBP1),
       playerInLeftBox: updateName(newB.playerInLeftBox, oldB1, teamBP1),
    );
    if (oldB2 != null && teamBP2 != null) {
        newB = newB.copyWith(
           playerInRightBox: updateName(newB.playerInRightBox, oldB2, teamBP2),
           playerInLeftBox: updateName(newB.playerInLeftBox, oldB2, teamBP2),
        );
    }
    
    // Re-emit state
    state = MatchSnapshot(
       type: state.type,
       teamA: newA,
       teamB: newB,
       isTeamAServing: state.isTeamAServing,
       isContextFinished: state.isContextFinished,
       winner: state.winner,
    );
  }
}

final matchProvider = NotifierProvider<MatchNotifier, MatchSnapshot>(MatchNotifier.new);

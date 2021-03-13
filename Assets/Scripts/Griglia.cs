using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
public class Griglia : MonoBehaviour {
  public List<Cella> mappa = new List<Cella> ();
  public Cella player = new Cella ();

  public int direzione = -1;

  public void muoviPlayer (Vector2 dir) {
    player.x += (int) dir.x;
    player.y += (int) dir.y;
  }
  public void muoviPlayer (int x, int y) {
    player.x = (int) x;
    player.y = (int) y;
  }

  public void aggiornaDir (int x, int y) {
    if (player.x == x && player.y == y - 1) { direzione = 1; } // sopra
    else if (player.x == x && player.y == y + 1) { direzione = 2; } // sotto
    else if (player.x == x + 1 && player.y == y) { direzione = 3; } // destra
    else if (player.x == x - 1 && player.y == y) { direzione = 4; } // sinistra
    else { direzione = 0; }
  }

  public void azzeraGriglia () {
    mappa.Clear ();
  }

  public Cella getPlayerPosition () {
    return player;
  }

  public int getCelleOccupate () {
    int r = 0;
    foreach (Cella c in mappa) {
      if (c != null) {
        r += 1;
      }
    }
    return r;
  }

  public void setPlayerInitialPosition (int x, int y) {
    player.x = x;
    player.y = y;
  }

  public void setPlayerInitialPosition (Cella c) {
    player.x = c.x;
    player.y = c.y;
  }

  public Cella findPlayerInitialPosition () {
    Cella res = new Cella ();
    foreach (Cella c in mappa) {
      if (c.ch == '@') {
        res.x = c.x;
        res.y = c.y;
        break;
      }
    }
    return res;
  }

  Dictionary<char, int> allCharacters = new Dictionary<char, int> () { { ' ', 0 }, { ';', 1 }, { '#', 2 }, { '_', 3 }, { '$', 4 }, { '@', 5 }, { '.', 6 },
  };
  public void buildCell (int x, int y, char ch) {
    int v;
    allCharacters.TryGetValue (ch, out v);
    mappa.Add (new Cella (x, y, v, ch));
  }

  public void printGriglia () {
    foreach (Cella c in mappa) {
      Debug.Log ("<" + c.x + "," + c.y + "," + c.ch + ">");
    }
  }

}
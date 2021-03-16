using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
public class Griglia : MonoBehaviour {
  public List<Cella> mappa = new List<Cella> ();
  public Cella player = new Cella ();

  public int direzionePrecedente = 0;
  public int direzione = 0;

  public void muoviPlayer (Vector2 dir) {
    player.x += (int) dir.x;
    player.y += (int) dir.y;
  }
  public void muoviPlayer (int x, int y) {
    aggiornaGriglia (x, y);
    player.x = (int) x;
    player.y = (int) y;

  }

  public void aggiornaGriglia (int x, int y) {
    int deltaX = x - player.x;
    int deltaY = y - player.y;
    direzionePrecedente = direzione;
    Cella nextCellaPlayer = getCella (x, y);
    if (nextCellaPlayer.ch == '$') {
      setCella (x, y, ' ', 0);
      Cella quellaAncoraDopo = getCella (x + deltaX, y + deltaY);
      if (quellaAncoraDopo.ch == '.') {
        setCella (x + deltaX, y + deltaY, '#', 2);
      } else {
        setCella (x + deltaX, y + deltaY, '$', 4);
      }
    }
  }

  public void setCella (int x, int y, char ch, int val) {
    foreach (Cella c in mappa) {
      if (c.x == x && c.y == y) {
        c.ch = ch;
        c.val = val;
        return;
      }
    }
  }

  public Cella getCella (int x, int y) {
    foreach (Cella c in mappa) {
      if (c.x == x && c.y == y) {
        return c;
      }
    }
    return null;
  }
  public void aggiornaDir (Vector2 dir) {
    direzionePrecedente = direzione;
    if (dir.x == 1 && dir.y == 0) { direzione = 1; } // sopra
    else if (dir.x == -1 && dir.y == 0) { direzione = 2; } // sotto
    else if (dir.x == 0 && dir.y == 1) { direzione = 3; } // destra
    else if (dir.x == 0 && dir.y == -1) { direzione = 4; } // sinistra
    else { direzione = 0; }
    Debug.Log ("Aggiorno direzione D " + direzione + " DP " + direzionePrecedente);
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
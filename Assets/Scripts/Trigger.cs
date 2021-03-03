using System;
using UnityEngine;

// every method of this class returning a bool value can be used to trigger the sensors update.
public class Trigger : ScriptableObject {
  public int playerX = -100;
  public int playerY = 100;
  public Griglia griglia;
  public Player player;
  public GameManager gameManager;

  public int direzione = -1;

  public void Awake () {
    griglia = FindObjectOfType<Griglia> ();
    player = FindObjectOfType<Player> ();
    gameManager = FindObjectOfType<GameManager> ();
    direzione = griglia.direzione;
  }

  public Boolean prontoAMuovere () {
    if (gameManager.m_ReadyForInput == false) {
      Debug.Log ("[TRIGGER] NON Pronto a muovere");
      gameManager.X = 10;
      gameManager.Y = 10;
      return false;
    } else if (gameManager.m_ReadyForInput == true) {
      Debug.Log ("[TRIGGER] Pronto a muovere");
      return true;
    }
    return false;
  }
}
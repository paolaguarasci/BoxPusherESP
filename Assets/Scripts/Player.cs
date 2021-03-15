using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Player : MonoBehaviour {

    public Griglia g;
    public int x;
    public int y;

    public int xPrec = -1;
    public int yPrec = -1;
    private int _dp = -1;
    public int DP { get { return _dp; } set { _dp = value; } }

    private int _d = -1;
    public int D { get { return _d; } set { _d = value; } }
    public void Start () {
        x = (int) transform.position.x;
        y = (int) transform.position.y;
        g = FindObjectOfType<Griglia> ();
    }

    public bool Move (Vector2 direction) {

        // Impedisce al player di andare in diagonale
        // settando a 0 un valore di direzione inferiore a 0.5
        if (Mathf.Abs (direction.x) < 0.5) {
            direction.x = 0;
        } else {
            direction.y = 0;
        }

        // Setta x o y = 1;
        direction.Normalize ();

        if (Blocked (transform.position, direction)) {
            return false;
        } else {
            xPrec = (int) transform.position.x;
            yPrec = (int) transform.position.y;
            DP = D;
            transform.Translate (direction);
            x = (int) transform.position.x;
            y = (int) transform.position.y;
            g.muoviPlayer (x, y);
            g.aggiornaDir (direction);
            D = getDirection (direction);
            return true;
        }

    }
    public int getDirection (Vector2 dir) {
        if (dir.x == 0 && dir.y == 0) return 0;
        if (dir.x == 1 && dir.y == 0) return 1;
        if (dir.x == -1 && dir.y == 0) return 2;
        if (dir.x == 0 && dir.y == -1) return 3;
        if (dir.x == 0 && dir.y == 1) return 4;
        return -1;
    }
    bool Blocked (Vector3 position, Vector2 direction) {
        Vector2 newPos = new Vector2 (position.x, position.y) + direction;
        GameObject[] walls = GameObject.FindGameObjectsWithTag ("Wall");
        foreach (var wall in walls) {
            if (wall.transform.position.x == newPos.x && wall.transform.position.y == newPos.y) {
                return true;
            }
        }

        GameObject[] boxes = GameObject.FindGameObjectsWithTag ("Box");
        foreach (var box in boxes) {
            if (box.transform.position.x == newPos.x && box.transform.position.y == newPos.y) {

                Box bx = box.GetComponent<Box> ();
                if (bx && bx.Move (direction)) {
                    return false;
                } else {
                    return true;
                }

            }
        }
        return false;
    }
}
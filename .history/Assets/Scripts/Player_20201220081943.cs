using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Player : MonoBehaviour {
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
            transform.Translate (direction);
            return true;
        }

    }

    bool Blocked (Vector3 position, Vector2 direction) {
        return false;
    }
}
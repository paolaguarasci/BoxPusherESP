using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Box : MonoBehaviour {

    public bool m_OnCross;

    public bool Move (Vector2 direction) {
        if (BoxBlocked (transform.position, direction)) {
            return false;
        } else {
            transform.Translate (direction);
            // Test for on cross 
            TestForOnCross ();
            return true;
        }

    }

    void TestForOnCross () {
        GameObject[] crosses = GameObject.FindGameObjectsWithTag ("Cross");
        foreach (var cross in crosses) {
            if (transform.position.x == cross.transform.position.x && transform.position.y == cross.transform.position.y) {
                GetComponent<SpriteRenderer> ().color = Color.red;
                m_OnCross = true;
                return;
            }
        }
    }

    bool BoxBlocked (Vector3 position, Vector2 direction) {

        if (m_OnCross) return true;

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
                return true;
            }
        }
        return false;
    }
}
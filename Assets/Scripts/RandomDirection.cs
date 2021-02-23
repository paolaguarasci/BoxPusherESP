using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RandomDirection : MonoBehaviour {
    private int dir = 0;
    System.Random rnd;
    public int direction { get { return dir; } set { } }

    void Start () {
        rnd = new System.Random ();
    }

    void Update () {
        dir = getRandomDirection ();
    }

    public int fakeBrain(Griglia g) {
        return getRandomDirection();
    }

    public int getRandomDirection () {
        return rnd.Next (0, 4);
    }
}
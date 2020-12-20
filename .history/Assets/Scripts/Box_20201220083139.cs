using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Box : MonoBehaviour
{
    public bool Move(Vector2 direction) {
        if (BoxBlocked(transform.position, direction)) {
            return false;
        } else {
            transform.Translate(direction);
        }

    }
}

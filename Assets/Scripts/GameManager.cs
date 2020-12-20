using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameManager : MonoBehaviour {
    private bool m_ReadyForInput;
    public Player m_Player;

    public LevelBuilder m_LevelBuilder;

    void Update () {
        Vector2 moveInput = new Vector2 (Input.GetAxisRaw ("Horizontal"), Input.GetAxisRaw ("Vertical"));
        moveInput.Normalize ();
        if (moveInput.sqrMagnitude > 0.5) {
            if (m_ReadyForInput) {
                m_ReadyForInput = false;
                m_Player.Move (moveInput);
                // m_NextButton.SetActive (IsLevelComplete ());
            }
        } else {
            m_ReadyForInput = true;
        }
    }

    private void Start () {
        m_LevelBuilder.Build ();
        m_Player = FindObjectOfType<Player>();
    }
}
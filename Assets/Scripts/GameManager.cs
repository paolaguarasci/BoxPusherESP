using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class GameManager : MonoBehaviour {
    public bool m_ReadyForInput;
    public Player m_Player;
    public Griglia g;
    public RandomDirection randomDirection;
    public GameObject m_NextButton;
    public Vector2 moveInput;

    public LevelBuilder m_LevelBuilder;
    private int _x = 0;
    public int X { get { return _x; } set { _x = value; } }

    private int _y = 0;
    public int Y { get { return _y; } set { _y = value; } }

    void Start () {
        // m_NextButton.SetActive (false);
        ResetScene ();
        RandomDirection rd = FindObjectOfType<RandomDirection> ();
        g = FindObjectOfType<Griglia> ();
    }
    void Update () {
        // Vector2 moveInput = new Vector2 (Input.GetAxisRaw ("Horizontal"), Input.GetAxisRaw ("Vertical"));
        float xf = (X - 10) / 1.0f;
        float yf = (Y - 10) / 1.0f;
        Vector2 moveInput = new Vector2 (xf, yf);
        moveInput.Normalize ();
        Debug.Log ("[GAMEMANAGER] MOVE INPUT " + moveInput + " X " + X + " Y " + Y);
        if (moveInput.sqrMagnitude > 0.5) {
            Debug.Log ("[GAMEMANAGER] SQR MAG > 0.5");
            if (m_ReadyForInput) {
                m_ReadyForInput = false;
                m_Player.Move (moveInput);
                Cella player = g.getPlayerPosition ();
                Debug.Log ("[GAMEMANAGER] player x " + player.x + " y " + player.y);
                m_NextButton.SetActive (IsLevelComplete ());
            }
        } else {
            Debug.Log ("[GAMEMANAGER] SQR MAG < 0.5");
            m_ReadyForInput = true;
        }
    }

    public void NextLevel () {
        m_NextButton.SetActive (false);
        m_LevelBuilder.NextLevel ();
        StartCoroutine (ResetSceneASync ());
    }

    public void ResetScene () {
        StartCoroutine (ResetSceneASync ());
    }

    IEnumerator ResetSceneASync () {
        Debug.Log ("ResetScene");
        if (SceneManager.sceneCount > 1) {
            AsyncOperation asyncUnload = SceneManager.UnloadSceneAsync ("Level");
            while (!asyncUnload.isDone) {
                yield return null;
                Debug.Log ("Unloading...");
            }
            Debug.Log ("Unload ok");
            Resources.UnloadUnusedAssets ();

        }
        AsyncOperation asyncLoad = SceneManager.LoadSceneAsync ("Level", LoadSceneMode.Additive);
        while (!asyncLoad.isDone) {
            yield return null;
            Debug.Log ("Loading...");
        }
        Debug.Log ("Scena caricata");
        SceneManager.SetActiveScene (SceneManager.GetSceneByName ("Level"));
        m_LevelBuilder.Build ();
        m_Player = FindObjectOfType<Player> ();
        Debug.Log ("Livello caricato");
    }
    bool IsLevelComplete () {
        Box[] boxes = FindObjectsOfType<Box> ();
        foreach (var box in boxes) {
            if (!box.m_OnCross) return false;
        }

        return true;
    }
}
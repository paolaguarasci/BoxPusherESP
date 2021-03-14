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
    private int _x = -1;
    public int X { get { return _x; } set { _x = value; } }

    private int _y = -1;
    public int Y { get { return _y; } set { _y = value; } }

    private int _x2 = -1;
    public int X2 { get { return _x2; } set { _x2 = value; } }

    private int _y2 = -1;
    public int Y2 { get { return _y2; } set { _y2 = value; } }

    private void Awake () {
        _x = -1;
        _y = -1;
    }

    void Start () {
        // m_NextButton.SetActive (false);
        ResetScene ();
        RandomDirection rd = FindObjectOfType<RandomDirection> ();
        g = FindObjectOfType<Griglia> ();
    }

    public string dirTxt (int a, int b) {
        if (a == 0 && b == 0) return "fermo";
        if (a == 1 && b == 0) return "destra";
        if (a == -1 && b == 0) return "sinistra";
        if (a == 0 && b == -1) return "sotto";
        if (a == 0 && b == 1) return "sopra";
        return "";
    }

    void Update () {
        // Vector2 moveInput = new Vector2 (Input.GetAxisRaw ("Horizontal"), Input.GetAxisRaw ("Vertical"));
        float xf = (X - 10) / 10.0f;
        float yf = (Y - 10) / 10.0f;
        Vector2 moveInput = new Vector2 (xf, yf);
        float xf2 = (X2 - 10) / 10.0f;
        float yf2 = (Y2 - 10) / 10.0f;
        Vector2 moveInput2 = new Vector2 (xf2, yf2);
        moveInput.Normalize ();
        moveInput2.Normalize ();
        if (moveInput.sqrMagnitude > 0.5 && (X != -1 && Y != -1)) {
            if (m_ReadyForInput) {
                Debug.Log ("[GAMEMANAGER] MOVE INPUT xf,xy [" + xf + "," + yf + "] " + " dir " + dirTxt ((int) xf, (int) yf));
                m_ReadyForInput = false;
                m_Player.Move (moveInput);
                if (X2 != -1 && Y2 != -1) {
                    m_Player.Move (moveInput2);
                    Debug.Log ("[GAMEMANAGER] MOVE INPUT xf2,xy2 [" + xf2 + "," + yf2 + "]");
                    X2 = -1;
                    Y2 = -1;
                }
                Cella player = g.getPlayerPosition ();
                Debug.Log ("[GAMEMANAGER] player x " + player.x + " y " + player.y);
                m_NextButton.SetActive (IsLevelComplete ());
                X = -1;
                Y = -1;
            }
        } else {
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
        if (SceneManager.sceneCount > 1) {
            AsyncOperation asyncUnload = SceneManager.UnloadSceneAsync ("Level");
            while (!asyncUnload.isDone) {
                yield return null;
            }
            Resources.UnloadUnusedAssets ();
        }
        AsyncOperation asyncLoad = SceneManager.LoadSceneAsync ("Level", LoadSceneMode.Additive);
        while (!asyncLoad.isDone) {
            yield return null;
        }
        SceneManager.SetActiveScene (SceneManager.GetSceneByName ("Level"));
        m_LevelBuilder.Build ();
        m_Player = FindObjectOfType<Player> ();
    }
    bool IsLevelComplete () {
        Box[] boxes = FindObjectsOfType<Box> ();
        foreach (var box in boxes) {
            if (!box.m_OnCross) return false;
        }

        return true;
    }
}
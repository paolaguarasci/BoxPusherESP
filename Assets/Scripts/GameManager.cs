using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class GameManager : MonoBehaviour {
    private bool m_ReadyForInput;
    public Player m_Player;

    public GameObject m_NextButton;

    public LevelBuilder m_LevelBuilder;

    private void Start () {
        m_NextButton.SetActive (false);
        ResetScene ();
    }
    void Update () {
        Vector2 moveInput = new Vector2 (Input.GetAxisRaw ("Horizontal"), Input.GetAxisRaw ("Vertical"));
        moveInput.Normalize ();
        if (moveInput.sqrMagnitude > 0.5) {
            if (m_ReadyForInput) {
                m_ReadyForInput = false;
                m_Player.Move (moveInput);
                m_NextButton.SetActive (IsLevelComplete ());
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
        Debug.Log ("ResetScene");
        if (SceneManager.sceneCount > 1) {
            AsyncOperation asyncUnload = SceneManager.UnloadSceneAsync ("Level");
            while (!asyncUnload.isDone) {
                yield return null;
                Debug.Log ("Unloading...");
            }
            Debug.Log ("Unload ok");
            Resources.UnloadUnusedAssets ();

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
    }
    bool IsLevelComplete () {
        Box[] boxes = FindObjectsOfType<Box> ();
        foreach (var box in boxes) {
            if (!box.m_OnCross) return false;
        }

        return true;
    }
}
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[System.Serializable]
public class LevelElement {
    public string m_Character;
    public GameObject m_Prefab;
}

public class LevelBuilder : MonoBehaviour {
    public int m_CurrentLevel;
    public List<LevelElement> m_LevelElements;
    public Level m_Level;
    public Griglia g;

    Dictionary<char, int> allCharacters = new Dictionary<char, int> () { { ' ', 0 }, { ';', 1 }, { '#', 2 }, { '_', 3 }, { '$', 4 }, { '@', 5 }, { '.', 3 },
    };

    public void Start () {
        g = FindObjectOfType<Griglia> ();

    }

    GameObject GetPrefab (char c) {
        LevelElement levelElement = m_LevelElements.Find (le => le.m_Character == c.ToString ());
        if (levelElement != null) {
            return levelElement.m_Prefab;
        } else {
            return null;
        }
    }

    public void NextLevel () {
        m_CurrentLevel++;
        if (m_CurrentLevel >= GetComponent<Levels> ().m_Levels.Count) {
            m_CurrentLevel = 0;
        }
    }

    public void Build () {
        m_Level = GetComponent<Levels> ().m_Levels[m_CurrentLevel];
        int startx = -m_Level.Width / 2;
        int x = startx;
        int y = -m_Level.Height / 2;
        g.azzeraGriglia ();
        foreach (var row in m_Level.m_Rows) {
            foreach (var ch in row) {
                GameObject prefab = GetPrefab (ch);
                if (prefab) {
                    Instantiate (prefab, new Vector3 (x, y, 0), Quaternion.identity);
                    BuildCell (x, y, ch);
                    Debug.Log ("[LEVELBUILDER] prefab x " + x + " y " + y);
                }
                x++;
            }
            y++;
            x = startx;
        }
        g.printGriglia ();
        g.setPlayerInitialPosition (g.findPlayerInitialPosition ());
    }

    private void BuildCell (int x, int y, char ch) {
        g.buildCell (x, y, ch);
    }
}
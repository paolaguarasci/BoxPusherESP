using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[System.Serializable]
public class Level {
    public List<string> m_Rows = new List<string> ();

    // L'altezza del livello e' il numero di righe
    public int Height { get { return m_Rows.Count; } }
    public int Width {
        // La larghezza del livello e' data dalla sua riga piu' lunga
        get {
            int maxLength = 0;
            foreach (var r in m_Rows) {
                if (r.Length > maxLength) maxLength = r.Length;
            }
            return maxLength;
        }
    }
}

public class Levels : MonoBehaviour {
    public string filename;
    public List<Level> m_Levels;

    private void Awake () {
        TextAsset textAsset = Resources.Load<TextAsset>(filename) as TextAsset;
        if (!textAsset) {
            Debug.Log (filename + ".txt non esiste!");
            return;
        } else {
            Debug.Log ("Livelli caricati");
        }
        string completeText = textAsset.text;
        string[] lines;
        lines = completeText.Split (new string[] { "\n" }, System.StringSplitOptions.None);
        m_Levels.Add (new Level ());
        for (long i = 0; i < lines.LongLength; i++) {
            string line = lines[i];
            if (line.StartsWith (";")) {
                Debug.Log ("Aggiunto nuovo livello");
                m_Levels.Add (new Level ());
                continue;
            }
            m_Levels[m_Levels.Count - 1].m_Rows.Add (line);
        }
    }
}
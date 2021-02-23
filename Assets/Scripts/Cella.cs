public class Cella {
  public int x;
  public int y;
  public int val;
  public char ch;

  public Cella (int _x, int _y, int _c, char _cc) {
    x = _x;
    y = _y;
    val = _c;
    ch = _cc;
  }

  public Cella () {
    x = 0;
    y = 0;
    val = 0;
    ch = ' ';
  }
}
/**
* the board position indices are in the range[0..8]
* and can be considered to be in the following
* order:
*
* 0 1 2
* 3 4 5
* 6 7 8
*
* this class allocates an array of 9 integers tp represent
* the board, defines constant values for blank, human and
* computer sqaures. And defines a toString method
* to print out the representation to a string
* 
*/
public class TicTacToePosition extends Position{
	final static public int BLANK    = 0;
	final static public int HUMAN    = 1;
	final static public int PROGRAM  = -1;
	int[] board                      = new int[9];
	public String toString(){
		StringBuffer sb = new StringBuffer("[");
		for(int i = 0; i < 9; i++){
			sb.append(""+board[i]+", ");
		}
		sb.append("]");
		return sb.toString();
	}
}
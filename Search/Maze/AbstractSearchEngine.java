/**
* date: Tue 28 Jul 2015
* this code is made from the book:
*	Artificial Intelegence a practical approach
*	thanks to the author: Mark Watson
*
* 2D Maze Search 
*/
public class AbstractSearchEngine{
	protected Maze maze;
	/*
	using java type location(fields width and height
	will encode the coordinates in x and y direction) 
	for the search path:
	*/
	protected Location[] searchPath = null;
	protected int pathCount;
	protected int maxDepth;
	protected Location startLoc, goalLoc, currentLoc;
	protected boolean isSearching   = true;

	public AbstractSearchEngine(int width, int height){
		maze = new Maze(width, height);
		initSearch();
	}
	public Maze getMaze(){
		return maze;
	}
	protected void initSearch(){
		if(searchPath == null){
			searchPath = new Location[1000];
			for(int i = 0; i < 1000; i++){
				searchPath[i] = new Location();

			}
		}
		pathCount               = 0;
		startLoc                = maze.startLoc;
		currentLoc              = startLoc;
		goalLoc                 = maze.goalLoc;
		searchPath[pathCount++] = currentLoc;
	}
	protected boolean equals(Location d1, Location d2){
		return d1.x == d2.x && d1.y == d2.y;
	}
	public Location [] getPath() {
      Location [] ret = new Location[maxDepth];
      for (int i=0; i<maxDepth; i++) {
        ret[i] = searchPath[i];
      }
      return ret;
    }
    /*
	* Returns an array of Dimension
	* objects that can be moved to from the specified location. This implements the
	* movement operator.
    */
    protected Location [] getPossibleMoves(Location loc) {
        Location tempMoves [] = new Location[4];
        tempMoves[0]          = tempMoves[1] = tempMoves[2] = tempMoves[3] = null;
        int x                 = loc.x;
        int y                 = loc.y;
        int num               = 0;
        if (maze.getValue(x - 1, y) == 0 || maze.getValue(x - 1, y) == Maze.GOAL_LOC_VALUE) {
        	//tempMoves[0]
            tempMoves[num++] = new Location(x - 1, y);
        }
        if (maze.getValue(x + 1, y) == 0 || maze.getValue(x + 1, y) == Maze.GOAL_LOC_VALUE) {
        	//tempMoves[1]
            tempMoves[num++] = new Location(x + 1, y);
        }
        if (maze.getValue(x, y - 1) == 0 || maze.getValue(x, y - 1) == Maze.GOAL_LOC_VALUE) {
        	//tempMoves[2]
            tempMoves[num++] = new Location(x, y - 1);
        }
        if (maze.getValue(x, y + 1) == 0 || maze.getValue(x, y + 1) == Maze.GOAL_LOC_VALUE) {
        	//tempMoves[3]
            tempMoves[num++] = new Location(x, y + 1);
        }
        return tempMoves;
    }
}
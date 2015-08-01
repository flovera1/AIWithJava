/*
* this code was made by Mark Watson
* @author: markw@markwatson.com
* http://markwatson.com
* amaxing book of artificial intelligence 
* with java programming
*/
public class BreathFirstSearchEngine extends AbstractSearchEngine{
	public BreathFirstSearchEngine(int width, int height){
		super(width, height);
		doSearchOn2DGrid();
	}
	private void doSearchOn2DGrid(){
		int width                        = maze.getWidth();
		int height                       = maze.getHeight();
		boolean alReadyVisitedFlag[][]   = new boolean[width][height];
		Location predecessor[][]         = new Location[width][height];
		// queue: to search new positions and to remove and test new locations
		LocationQueue queue              = new LocationQueue();
		for(int i = 0; i < width; i++){
			for(int j = 0; j < height; j++){
				alReadyVisitedFlag[i][j] = false;
				//predecessor: to calculate the 
				//shortest path after the goal is
				//found.
				predecessor[i][j]        = null;
			}
		}
		alReadyVisitedFlag[startLoc.x][startLoc.y] = true;
		queue.addToBackOfQueue(startLoc);
		boolean success = false;
		outer:
			while(queue.isEmpty() == false){
				Location head = queue.peekAtFrontOfQueue();
				if(head == null) break;
				Location[] connected = getPossibleMoves(head);
				for(int i = 0; i < 4; i++){
					if(connected[i] == null) break;
					int w = connected[i].x;
					int h = connected[i].y;
					if(alReadyVisitedFlag[w][h] == false){
						alReadyVisitedFlag[w][h] = true;
						predecessor[w][h] = head;
						queue.addToBackOfQueue(connected[i]);
						if(equals(connected[i], goalLoc)){
							success = true;
							break outer;
						}
					}
				}
				queue.removeFromFrontOfQueue();
			}
			/*
			* Now we need to use the predecessor array
			* to get the shortest path. 
			* Note that we will fill in the searchPath array
			* in reverse order, starting with the goal location
			*/
			maxDepth = 0;
			if(success) {
				searchPath[maxDepth++] = goalLoc;
				for(int i = 0; i < 100; i++){
					searchPath[maxDepth] = predecessor[searchPath[maxDepth - 1].x][searchPath[maxDepth - 1].y];
					maxDepth++;
					if(equals(searchPath[maxDepth - 1], startLoc)) break;
				}
			}
	}
	protected class LocationQueue{
		private Location[] queue; // queue of locations
		private int tail, head, len;
		public LocationQueue(int num){
			queue = new Location[num];
			head  = tail = 0;
			len   = num;
		}
		public LocationQueue(){
			this(400);
		}
		public void addToBackOfQueue(Location n){
			queue[tail] = n;
			if(tail >= (len - 1)){
				tail = 0;
			}else{
				tail++;
			}
		}
		public Location removeFromFrontOfQueue(){
			Location ret = queue[head];
			if(head >= (len - 1)){
				head = 0;
			}else{
				head++;
			}
			return ret;
		}
		public boolean isEmpty(){
			return head == (tail + 1);
		}
		public Location peekAtFrontOfQueue(){
			return queue[head];
		}
	}
}
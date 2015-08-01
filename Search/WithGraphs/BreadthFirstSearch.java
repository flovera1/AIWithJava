/*
* this code was made by Mark Watson
* @author: markw@markwatson.com
* http://markwatson.com
* amaxing book of artificial intelligence 
* with java programming
*/
public class BreadthFirstSearch extends AbstractGraphSearch{
	protected class IntQueue{
		public IntQueue(int num){
			queue = new int[num];
			head  = tail = 0;
			len   = num;
		}
		public IntQueue(){
			this(400);
		}
		private int[] queue;
		int tail, head, len;
		public void addToBackOfQueue(int n){
			queue[tail] = n;
			if(tail >= (len -1)){
				tail = 0;
			}else{
				tail++;
			}
		}
		public int removeFromQueue(){
			int ret = queue[head];
			if(head >= (len - 1)){
				head = 0;
			}else{
				head++;
			}
			return ret;
		}
		public boolean isEmpty(){
			return head == tail;
		}
		public int peekAtFrontOfQueue(){
			return queue[head];
		}
	}	
	/*
	* findpath - abstract method in super class
	*/
	public int [] findPath(int start_node, int goal_node){//return an array of indices
		System.out.println("Entered BreadthFirstSearch.findPath("+
							start_node + ", " + goal_node + ")");
		//data structures:
		//alreadyVisitedFlag array to prevent 
		//visiting the same node twice
		//
		boolean [] alreadyVisitedFlag = new boolean[numNodes];
		int[] predecessor = new int[numNodes + 2];
		IntQueue queue    = new IntQueue(numNodes + 2);
		for(int i = 0; i < numNodes; i++){
			alreadyVisitedFlag[i] = false;
			predecessor[i]        = -1;
		}
		alreadyVisitedFlag[start_node] = true;
		queue.addToBackOfQueue(start_node);
		outer:
			while(!queue.isEmpty()){
				int head = queue.peekAtFrontOfQueue();
				int [] connected = connected_nodes(head);
				if(connected != null){
					//if each node connected to the list
					//by the current node has not already
					//been visited, set the predecessor array
					//and add the new node index
					for(int i = 0; i < connected.length; i++){
						if(alreadyVisitedFlag[connected[i]] == false){
							predecessor[connected[i]] = head;
							queue.addToBackOfQueue(connected[i]);
							if(connected[i] == goal_node) break outer;
						}
					}
					alreadyVisitedFlag[head] = true;
					queue.removeFromQueue();
				}
			}
			//build an array of returned node indices
			//for the calculated path.
			//shortest path
			int[] ret = new int[numNodes + 1];
			int count = 0;
			ret[count++] = goal_node;
			for(int i = 0; i < count; i++){
				ret[count] = predecessor[ret[count - 1]];
				count++;
				if(ret[count - 1] == start_node) break; // backtracking! :o :)
			}
			int [] ret2 = new int[count];
			for(int i = 0; i < count; i++){
				ret2[i] = ret[count - 1 - i];
			}
			return ret2;	
	}
	protected int [] connected_nodes(int node){
		int [] ret = new int[AbstractGraphSearch.MAX];
		int num = 0;
		for(int n = 0; n < numNodes; n++){
			boolean connected = false;
			// see if there is a link between node 'node' and 'n'
			for(int i = 0; i < numLinks; i++){
				if(link_1[i] == node){
					if(link_2[i] == n){
						connected = true;
						break;
					}
				}
				if(link_2[i] == node){
					if(link_1[i] == n){
						connected = true;
						break;
					}
				}
			}
			if(connected){
				ret[num++] = n;
			}
		}
		if(num == 0) return null;
		int [] ret2 = new int[num];
		for(int i = 0; i < num; i++){
			ret2[i] = ret[i];
		}
		return ret2;
	}
}
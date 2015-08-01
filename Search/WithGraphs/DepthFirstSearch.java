/*
* this code was made by Mark Watson
* @author: markw@markwatson.com
* http://markwatson.com
* amaxing book of artificial intelligence 
* with java programming
*/
public class DepthFirstSearch extends AbstractGraphSearch{
	//find path - abstract method
	// path is an array of ints referring to the path we are going to make
	// in the AbstractGraphSearch.
	//returns an array of node indices
	//indicating the calculated path
	public int [] findPath(int start_node, int goal_node){
		System.out.println("Entered DepthFirstSearch.findPathHelper(...,"+num_path+", "+goal_node+")");
		path[0] = start_node;
		return findPathHelper(path, 1, goal_node);
	}
	//path array is used as a stack
	//to keep track of which nodes are being visited
	//num_path is the number of locations in the path == search depth
	public int [] findPathHelper(int[] path, int num_path, int goal_node){
		System.out.println("Entered DepthFirstSearch.findPathHelper(..., "+
							num_path + ", " + goal_node + ")");
		if(goal_node == path[num_path -1]){
			int[] ret = new int[num_path];
			for (int i=0; i<num_path; i++) ret[i] = path[i];
            return ret;  
        }
        int [] new_nodes = connected_nodes(path, num_path);
        if (new_nodes != null) {
            for (int j=0; j < new_nodes.length; j++) {
                path[num_path] = new_nodes[j];
                int [] test    = findPathHelper(path, num_path + 1, goal_node);
                if (test != null) {
                    if (test[test.length - 1] == goal_node) {
                        return test;
                    }
                }
            }
        }
        return null;
    }

    protected int [] connected_nodes(int [] path, int num_path) {
        // find all nodes connected to the last node on 'path'
        // that are not already on 'path'
        int [] ret    = new int[AbstractGraphSearch.MAX];
        int num       = 0;
        int last_node = path[num_path - 1];
        for (int n=0; n<numNodes; n++) {
            // see if node 'n' is already on 'path':
            boolean keep = true;
            for (int i=0; i<num_path; i++) {
                if (n == path[i]) {
                    keep = false;
                    break;
                }
            }
            boolean connected = false;
            if (keep) {
                // now see if there is a link between node 'last_node' and 'n':
                for (int i=0; i<numLinks; i++) {
                    if (link_1[i] == last_node) {
                        if (link_2[i] == n) {
                            connected = true;
                            break;
                        }
                    }
                    if (link_2[i] == last_node) {
                        if (link_1[i] == n) {
                            connected = true;
                            break;
                        }
                    }
                }
                if (connected) {
                    ret[num++] = n;
                }
            }
        }
        if (num == 0)  return null;
        int [] ret2 = new int[num];
        for (int i=0; i<num; i++) {
            ret2[i] = ret[i];
        }
        return ret2;
    }
		
	}
}

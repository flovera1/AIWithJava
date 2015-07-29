the abstract class AbstractSearchEngine contains common code and data
that is required by both the depthFirstSearch and BreadthFirstSearch
The class Maze is used to record the data for a two-dimensional maze,
including which grid locations contain walls or obstacles.
The class Maze defines three static short integers values to indicate
obstacles, the starting location and the ending location.


		0 1 2 3 4 5 6			x
		|------------| 0		x
		|            | 1		x
		|            | 2 		x
		|            | 3		x
		|            | 4		x
		|            | 5		x
		|			 | 6		x
		|------------| 7		x
								x
								x

height = 8
width  = 7

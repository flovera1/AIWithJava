import java.util.*;
/*
*	Hopfield neural network
*	Copyright 1998-2012 by Mark Watson. All rights reserved
*
*EXPLAINNED
Every neuron is connected to every other neuron
Neurons i, j, there is a weight Wij between these neurons
that corresponds in code to the element: weight[i][j]
We define energy between these neurons as:

energy[i, j] = -weight[i][j]*activation[i]*activation[j]

In Hopfield simulator, we store activations(input values)
as floating point numbers that get clamped in value to -1
(for off) or +1 (for on). In the energy equation, we 
consider an activation that is not clamped to a value
of one to be zero.
When shown a network attemps to settle in a local
minimum energy point as defined by a previously seen
training example.
When training a network with a new input we are looking for a
low energy point near the new input vector. 
The total energy is a sum of the above equation over all 
(i, j).


*/
public class Hopfield{
	int numInputs;
	Vector trainingData = new Vector();
	float[][] weights;
	float[] tempStorage; //variable setted during training to be the sum of a row of trained weights
	float[] inputCells;
	/*
	* The class constructor allocates storage for
	* input values, temporary storage, and a 
	* two-dimensional array to store weights
	*/
	public Hopfield(int numInputs){
		this.numInputs = numInputs;
		weights        = new float[numInputs][numInputs];
		inputCells     = new float[numInputs];
		tempStorage    = new float[numInputs];
	}
	/*
	* Method used to store an input data array
	* for later training. 
	*/
	public void addTrainingData(float[] data){
		trainingData.addElement(data);
	}
	/*
	* Method used to set the two-dimensional weight
	* array and the one dimensional tempStorage
	* array in which each element is the sum of the 
	* corresponding row in the two-dimensional weight
	* array.
	*/
	public void train(){
		for(int j = 1; j < numInputs; j++){
			for(int i = 0; i < j; i++){
				for(int n = 0; n < trainingData.size(); n++){
					float[] data  = (float[])trainingData.elementAt(n);
					float temp1   = adjustInput(data[i])*adjustInput(data[j]);
					float temp    = truncate(temp1 + weights[j][i]);
					weights[i][j] = weights[j][i] = temp; //symmetry
				}
			}
		}
		for(int i = 0; i < numInputs; i++){
			tempStorage[i] = 0.0f;
			for(int j = 0; j < i; j++){
				tempStorage[i] += weights[i][j];
			}
		}
	}
	public float[] recall(float[] pattern, int numIterations){
		for(int i = 0; i < numInputs; i++){inputCells[i] = pattern[i];}
		for(int ii = 0; ii < numIterations; ii++){
			for(int i = 0; i < numInputs; i++){
				if(deltaEnergy(i) > 0.0f){
					inputCells[i] = 1.0f;
				}else{
					inputCells[i] = -1.0f;
				}
			}
		}
		return inputCells;
	}	
	/*
	* All input values get clamped to an
	* "off" or "on"
	*/
	private float adjustInput(float x){
		if(x < 0.0f) return -1.0f;
		return 1.0f;
	}
	/*
	* Just truncates floating-point values to an 
	* integer value.
	*/
	private float truncate(float x){
		//return Math.round(x);
		int i = (int)x;
		return (float)i;
	}
	/*
	* Returns a mesuare of the energy difference between
	* the input vector in the current input cells and the
	* training input examples.
	*/
	private float deltaEnergy(int index){
		float temp = 0.0f;
		for(int j = 0; j < numInputs; j++){
			temp += (float)(weights[index][j] * inputCells[j]);
		}
		return 2.0f * temp - tempStorage[index];
	}
}
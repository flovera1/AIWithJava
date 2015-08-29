/*
*
* This example loads the training ARFF data file
* seen at the beginning of this chapter and loads
* a similar ARFF file for testing that is equivalent to the
* original training file except that small random
* changes have been made to the numeric attribute 
* values in all samples.
*/
import weka.classifiers.meta.FilteredClassifier;
import weka.classifiers.trees.J48;
import weka.core.Instances;
import weka.filters.unsupervised.attribute.Remove;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

public class WekaStocks{
	public static void main(String[] args) throws Exception{
		/*
		* we start by creating a new instance by supplying a
		* reader for the stock training ARFF file and setting
		* the number of attributes to use
		*/
		Instances training_data = new Instances(
			new BufferedReader(
				new FileReader(
					"test_data/stock_training_data.arff")));
		training_data.setClassIndex(
			training_data.numAttributes() - 1);
		/*
		* We want to train with separate data so, we
		* pen a separate examples ARFF file to test againgst
		*/
		Instances testing_data = new Instances(
			new BufferedReader(
				new FileReader(
					"test_data/stock_training_data.arff")));
		testing_data.setClassIndex(training_data.numAttributes() - 1);
		/*
		* The method toSummaryString prints a summary of a set
		* of training or testing instances.
		*/
		String summary                   = training_data.toSummaryString();
		int number_samples               = training_data.numInstances();
		int number_attributes_per_sample = training_data.numAttributes();
		System.out.println("Number of attributes in moder = "+
			number_attributes_per_sample);
		System.out.println("Number of samples = "+number_samples);
		System.out.println("Summary: "+summary);
		System.out.println();
		/*
		*
		* Now we create a new classifier (a J48 classifier in this case)
		* and we see how to optionally filter(remove) samples.
		* We build a classifier using the training data
		* and then test it using the separate test data set.
		*
		*/
		// a classifier for decision trees
		J48 j48               = new J48();
		//filter for removing samples:
		Remove rm             = new Remove();
		// remove the first attribute
		rm.setAttributeIndices("1");
		//filtered classifier
		FilteredClassifier fc = new FilteredClassifier();
		fc.setFilter(rm);
		fc.setClassifier(j48);
		//train using stock_training_data.arff
		fc.buildClassifier(training_data);
		//test using stock_testing_data.arff:
		for(int i = 0; i < testing_data.numInstances(); i++){
			double pred = fc.classifyInstance(testing_data.instance(i));
			System.out.println("given value: "+
				testing_data.classAttribute().value((int)testing_data.instance(i).classValue()));
			System.out.println(" . predicted value: "+testing_data.classAttribute().value((int)pred));
		}
	}
}
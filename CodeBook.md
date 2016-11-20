# CodeBook
This code book describes the  data and transformations used by `run_analysis.R` and the variables to produce the output of Tidy.txt
## The Data Source

[Original Data Source](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

[Original Description of the Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Data Set Information

### Input Data Set

- `X_train.txt` contains variable features that are intended for training.
- `y_train.txt` contains the activities corresponding to `X_train.txt`.
- `subject_train.txt` contains information on the subjects from whom data is collected.
- `X_test.txt` contains variable features that are intended for testing.
- `y_test.txt` contains the activities corresponding to `X_test.txt`.
- `subject_test.txt` contains information on the subjects from whom data is collected.
- `activity_labels.txt` contains metadata on the different types of activities.
- `features.txt` contains the name of the features in the data sets.

## Transformations
The following are the transformations:

- `X_train.txt` is read into table `trainData`
- `y_train.txt` is read into table `trainActivity`
- `subject_train.txt` is read into table `trainSubject`
- `X_test.txt` is read into table `testData`
- `y_test.txt` is read into table `testActivity`
- `subject_test.txt` is read into table `testSubject`
- `features.txt` is read into table `dataFeaturesNames`
- The respective files for Train and Test are Subject, Features and Activity are merged into the corresponding `subject`, `activity` and `feature`
- The `Subject`, `Activity` and `Features` are merged to create ‘datos’
-  Indices of columns that contain std or mean, activity and subject are taken into subdataFeatures .
- datos is subseted with data from columns in `subdataFeatures`
- Acronyms in variable names in extractedData, like ‘Acc’, ‘Gyro’, ‘Mag’, ’t’ and ‘f’ are replaced with descriptive labels such as ‘Accelerometer’, ‘Gyroscpoe’, ‘Magnitude’, ‘Time’ and ‘Frequency’.
- `Data2` is created as a set with average for each activity and subject of extractedData. Entries in `tidyData` are ordered based on activity and subject.
- Finally, the data in tidyData is written into `Tidy.txt`

## Output Data Set
The output data `tidy.txt` is a space delimited value file. The header line contains the names of the variables. It contains the mean and standard deviation values of the data contained in the input files

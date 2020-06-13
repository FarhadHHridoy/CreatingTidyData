# CreatingTidyData
* **Step 1:** Collecting data from given address 
* **Step 2:** Reading the data 
* **Step 3:** Concataning using column bind to get train and test data
* **Step 4:** Merging the Train and Test data using Row Bind (rbind())
* **Step 5:** Assigning each variable descriptive name.
  * For this, 1st the names from feature table are extracted 
  * Then these extracted names are imported into the merging data
* **Step 6:** Getting the indexes where mean() and std() are present in the variable name
  * Then subset the merging dataset using index

* **Step 7:** Give the activity variable to their descriptive name using factor where the factor         labels are the level of activity               table
* **Step 8:** Finally creating the summary data.
  * First, data is grouped using SubjectID and Activity, 
  * then mean function is applied to all the grouped data
  * And we get our Tidy Data Set
           

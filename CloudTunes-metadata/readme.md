This folder contains all the stuff to get the cloudtunes app running on any DE org. Here are the steps:
# Setup #

1. Deploy the metadata (CloudTunes-force.zip) to the org using Workbench or Ant tool or Eclipse IDE. This contains all the code and schema files to get the app setup. 
2. Execute the apex script contained in the file "CloudTunes-data.txt", using say “System Log” in salesforce UI as an admin user. 

**Note:** If you'd like to make changes to any of the files in the package and re-deploy, you can edit the individual files in
the expanded folders, then automatically re-create the package by running:

```
./make_package.sh CloudTunes-force | CloudTunes-database
```

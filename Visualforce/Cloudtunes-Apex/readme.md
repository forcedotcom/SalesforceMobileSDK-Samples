This folder contains all the stuff to get the cloudtunes app running on any DE org. Here are the steps:
# Setup #

1. Deploy the metadata (metadata-src.zip) to the org using Workbench or Ant tool or Eclipse IDE. This contains all the code and schema files to get the app setup.
1. Execute the apex script, contained in file apex-dataloader.txt, using say “System Log” in salesforce UI as an admin user.
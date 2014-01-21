## To create an application for android, follow the steps below.
- $appname is whatever you want
- $template should be vfconnector, contactexplorer, smartstoreexplorer, accounteditor, usersearch, userandgroupsearch or fileexplorer

<pre>
cordova create $appname com.salesforce.$template $appname
cd $appname
cordova platform add android
cordova plugin add org.apache.cordova.contacts
cordova plugin add https://github.com/wmathurin/SalesforceMobileSDK-CordovaPlugin#cordova33ns
node plugins/com.salesforce/postinstall.js 19 true
cp -r <path to SalesforceMobileSDK-Samples>/hybrid/$template/* www/
cordova build
</pre>

## To run the application from the command line, simply do:
<pre>
cd $appname
cordova emulate android
</pre>

## To load the project in eclipse:
- start eclipse and pick the $appname folder as root for your workspace
- go to menu file -> import ..., choose "Existing Android  Code into Workspace" (in Android folder)
- choose $appname as the root directory
- pick the following projects: platforms/android, platforms/android/CordovaLib, plugins/com.salesforce/android/hybrid/SmartStore and plugins/com.salesforce/android/native/SalesforceSDK
- for platforms/android, click on the project name, and change it to $appname
- once everything is built, right-click on the $appname project and choose run as Android application

## To create an application for ios or android
<pre>
cordova create $appname com.salesforce.$template $appname
cd $appname
cordova plugin add org.apache.cordova.contacts                                          (contactexplorer only)
cordova plugin add https://github.com/wmathurin/SalesforceMobileSDK-CordovaPlugin
cordova platform add android                                                            (for android)
node plugins/com.salesforce/postinstall-android.js 19 true                              (for android)
cordova platform add ios                                                                (for ios)
node plugin/com.salesforce/postinstall-ios.js                                           (for ios)
cp -r (path to SalesforceMobileSDK-Samples)/hybrid/$template/* www/
cordova build
</pre>
Where:
- $appname is whatever you want
- $template should be vfconnector, contactexplorer, smartstoreexplorer, accounteditor, usersearch, userandgroupsearch or fileexplorer

## To run the android application:
- start eclipse and pick the $appname folder as root for your workspace
- go to menu file -> import ..., choose "Existing Android  Code into Workspace" (in Android folder)
- choose $appname as the root directory
- pick the following projects: platforms/android, platforms/android/CordovaLib, plugins/com.salesforce/android/hybrid/SmartStore and plugins/com.salesforce/android/native/SalesforceSDK
- for platforms/android, click on the project name, and change it to $appname
- once everything is built, right-click on the $appname project and choose run as Android application

## To run the ios application:
- start xcode and pick $appname/platforms/ios/$appname.xcodeproj
- build and run

## To run the application from the command line:
<pre>
cordova emulate ios                                                                    (for ios)
cordova emulate android                                                                (for android) 
</pre>


# Salesforce Mobile SDK Samples

Looking for sample applications for the Salesforce Mobile SDK?  You can find a variety of sample apps, covering many different use cases, in the source repositories for the iOS and Android SDKs, respectively:

- The repository for the Salesforce Mobile SDK for iOS can be found [here](https://github.com/forcedotcom/SalesforceMobileSDK-iOS).
- The repository for the Salesforce Mobile SDK for Android can be found [here](https://github.com/forcedotcom/SalesforceMobileSDK-Android).

Check out the README files in the repos for more information about getting your environment set up.  It takes virtually no time to get up and running.

## iOS Native Sample Applications

You can access all of the iOS sample applications from the `SalesforceMobileSDK.xcworkspace` Xcode workspace at the root of the iOS repo.

The native iOS sample apps have a lot of functionality you can examine and work into your own apps.

- The RestAPIExplorer sample app exercises all of the native REST API wrappers. It is under native/SampleApps/RestAPIExplorer.
- The NativeSqlAggregator sample app shows SQL aggregation examples as well as a native SmartStore implementation.  It resides in the Mobile SDK for iOS under native/SampleApps/NativeSqlAggregator.


## Android Native Sample Applications

All of the Android sample applications live under the Android SDK repo, and are most easily accessed by importing the root directory of the repo in your Eclipse workspace.

- RestExplorer is a sample app that demonstrates how to use the OAuth and REST API functions of the SalesforceSDK. It’s also useful to investigate the various REST API actions from a Honeycomb tablet.
    1. To run the application from your Eclipse workspace, right-click the RestExplorer project and choose Run As > Android Application.
    2. To run the tests, right-click the RestExplorerTest project and choose Run As > Android JUnit Test.
- NativeSqlAggregator is a sample app that demonstrates SQL aggregation with SmartSQL. As such, it also demonstrates a native implementation of SmartStore. To run the application from your Eclipse workspace, right-click the NativeSqlAggregator project and choose Run As > Android Application.

## Android Hybrid Sample Applications

As mentioned above, all of the Android sample applications live under the Android SDK repo, and are most easily accessed by importing the root directory of the repo in your Eclipse workspace.

Inside the ./hybrid folder, you can find sample projects and related test applications:

- **AccountEditor**: Demonstrates how to use the SmartSync Data Framework to access Salesforce data.
- **ContactExplorer**: The ContactExplorer sample app uses PhoneGap (also known as Cordova) to retrieve local device contacts. It also uses the forcetk.mobilesdk.js toolkit to implement REST transactions with the Salesforce REST API. The app uses the OAuth2 support in Salesforce SDK to obtain OAuth credentials, then propagates those credentials to forcetk.mobilesdk.js by sending a javascript event.
- **ContactExplorerTest**: Tests for the ContactExplorer sample app.
- **VFConnector**: The VFConnector sample app demonstrates how to wrap a Visualforce page in a native container. This example assumes that your org has a Visualforce page called BasicVFTest. The app first obtains OAuth login credentials using the Salesforce SDK OAuth2 support, then uses those credentials to set appropriate webview cookies for accessing Visualforce pages.
- **VFConnectorTest**: Test for the VFConnector sample app.
- **SmartStoreExplorer**: Lets you explore SmartStore APIs.
- **SmartStoreExplorerTest**: Tests for the SmartStoreExplorer sample app.

## iOS Hybrid Sample Applications

As mentioned above, you can access all of the iOS sample applications from the `SalesforceMobileSDK.xcworkspace` Xcode workspace at the root of the iOS repo.

The sample applications contained under the hybrid/SampleApps folder are designed around the PhoneGap SDK.  PhoneGap is also known as Cordova. Salesforce Mobile SDK v. 1.4 and later include the Cordova libraries, so no separate installation is required. You can find documentation for the Cordova SDK in their [Getting Started Guide](http://docs.phonegap.com/en/2.3.0/guide_getting-started_ios_index.md.html#Getting%20Started%20with%20iOS).

Inside the hybrid/SampleApps folder, you can find sample projects:

- **AccountEditor**: Demonstrates how to use the SmartSync Data Framework to access Salesforce data.
- **ContactExplorer**: The ContactExplorer sample app uses PhoneGap (also known as Cordova) to retrieve local device contacts. It also uses the forcetk.mobilesdk.js toolkit to implement REST transactions with the Salesforce REST API. The app uses the OAuth2 support in Salesforce SDK to obtain OAuth credentials, then propagates those credentials to forcetk.mobilesdk.js by sending a JavaScript event.
- **VFConnector**: The VFConnector sample app demonstrates how to wrap a Visualforce page in a native container. This example assumes that your org has a Visualforce page called BasicVFTest. The app first obtains OAuth login credentials using the Salesforce SDK OAuth2 support, then uses those credentials to set appropriate webview cookies for accessing Visualforce pages.
- **SmartStoreExplorer**: Lets you explore SmartStore APIs.

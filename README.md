# BackGround

## Overview
* This implementation covers all requirements of the doc plus some bonus features (see below).
* Estimated time spent before submission: 10 hrs, largely due to researching some new technologies.
* Files are organized into groups, such as Helpers and Resources.
* Backup zip file of XCode project (public access): https://drive.google.com/file/d/1wI-jJi4zb1KHwNeJZx3PhfsU4nSl9SJe/view?usp=sharing

## Data
* URLSession's are used to reach the endpoint for weather reports.
* FetchRequest is used to call Core Data and CloudKit.

## User Interface
* List of favorite locations is shown with defaults populated via UserDefaults.
* A text input box allows entry of an identifier, which is added to the recent and favorites lists. The details are immediately shown for this location.
* METAR, TAF, and MOS can be found in the details view, with METAR and TAF functioning. The METAR view includes some of the additional features described above.
* Locations can be marked as favorites, which are immediately reflected in the rest of the app and kept in sync via @Binding.
* A history of requested locations is stored via caching in Core Data and CloudKit.

## Additional features:
* Implementation using SwiftUI.
* Integration with CoreData and CloudKit.
* Button to reset all cached data.
* Improved UI, including a slide-up sheet, app icon, splash screen, segmented pickers, navigation, maps, and colors.
* A taste at pilot insight: prediction of cloud formation based on temps and dewpoint. I would have added more features like this with extra time (and may still for fun).
* Regular clearing of cached data to save space.
* Removal of airports from both lists via swipe (clearing history).

# Caveats / Bugs
* Removing airports from the list via swipe is a custom drag gesture. It can be performed laterally in either direction.
* The list remains highlighted after selection. This can be fixed by removing the segmented picker from above the list. However, it is unchanged due to favored layout.
* --> Tapping into location details requires tap on whitespace outside of the row text.

<div align="justify">

# RSS-Viewer Application (UIKit + SwiftUI + MVVM)

RSS-Viewer is a mobile app for IOS 16.2 and above. In this application you can view the latest news, in real time, which are constantly updated. There is an option to view each news item in detail.
There is a possibility of "offline-mode", the application works without connecting to the Internet (if the data has been uploaded to the database). 
The application provides for handling errors received during the program operation (example: server errors, no Internet connection, and data decoding errors). Application is fully adapted to the light and dark device theme.

<img src="https://github.com/antonaliokhna/DataRepository/blob/74b1acf6bd310cba80125c4d1c83117bcefea349/RSSReader/gifs/NewsListDark.gif" width="235" height="515" align="right">
<img src="https://github.com/antonaliokhna/DataRepository/blob/74b1acf6bd310cba80125c4d1c83117bcefea349/RSSReader/images/NewsListDark.jpg" width="235" height="515" align="right">

 ## Stack of technologies

- Swift(UIKit, SwiftUI)
- MVVM
- SpapKit
- Alamofire
- SkeletonView
- XMLCoder
- UserDefaults (Data storage)
- Async / Await
- SOLID
  
## Application screens

1. News list - displays a preview of the received news.
2. Detailed news - displays all the detailed information about the news, with the ability to "scroll" through the news.

# Application Features

<img src="https://github.com/antonaliokhna/DataRepository/blob/74b1acf6bd310cba80125c4d1c83117bcefea349/RSSReader/gifs/NewsLightList.gif" width="235" height="515" align="left">
<img src="https://github.com/antonaliokhna/DataRepository/blob/74b1acf6bd310cba80125c4d1c83117bcefea349/RSSReader/images/LoadingLight.jpg" width="235" height="515" align="left">

## The app includes custom loading animation, and custom features

<dl>
  <li>
     Fully self-contained interface with support for error handling, and with their interaction.
  </li>
  <li>
     Provides for saving news, and their viewing status in the database (offline-mode).
  </li>
  <li>
    Custom animations for loading data while updating and scrolling news.
  </li>
  <li>
    Ability to view all the details of the news, as well as the option to go to the article site.
  </li>
  <li>
      !The color scheme of the application depends on the color scheme on the device (dark of light).
  </li>
  <li>
    The possibility to request new news in real time (Pull to request).
  </li>
  <li>
    Server layer with handling any errors (example: server errors, no Internet connection, and data decoding errors).
  </li>
</dl>

# Getting Started

<img src="https://github.com/antonaliokhna/DataRepository/blob/74b1acf6bd310cba80125c4d1c83117bcefea349/RSSReader/gifs/ErrorListDark.gif" width="235" height="515" align="right">
<img src="https://github.com/antonaliokhna/DataRepository/blob/74b1acf6bd310cba80125c4d1c83117bcefea349/RSSReader/images/ErrorDark.jpg" width="235" height="515" align="right">

## Conditions for running the application 

- Device with MacOS Ventura, or later operating system.
- XCode Version 14.1, with a device or simulator running IOS 16.2.

## Installation

1. Clone this repository to your local MacOS machine.
2. Open applications using the file RSSReader.xcodeproj.
3. Build the application on your local device or simulator.
4. Open the application, be pleasantly surprised that everything works, and enjoy life! 😀
</div>

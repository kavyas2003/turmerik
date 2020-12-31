# turmeric
Turmerik is an application that store's a user's medication schedule and consumption history. Users recieve notifcations based on their schedules and can revisit when they have taken or missed their medications. It also provides services such as reminding users when a medicine's count is approaching zero, where and when it was purchased, and its expiry date. 

Clone the repository using XCode and build the project. 

Directory Structure

Settings  -->  Contains the view code for the settings tab
CommonUtils --> Contains the code for common utilities that can be used across different projects
    Keyboard --> Contains the code for managing the keyboard functionality when inputting information
    Notifications --> Contains the code for managing notifications
    Calendar --> Contains the code for the calendar structure
    Image --> Contains the code for managing images
    User --> Contains the code for managaing users
Medicine --> Contains all the code specific to the Turmerik app
    Medicine --> Contains the code for the medicine class
    * Helper --> Contains all the code for managing the database
    * List --> Contains the code for the a collection of objects 
    * View --> Contains all the code for the Swift user interface
TabbedAppView --> Framework provided file to set the multi-tabbed view for the app
AppDelegate --> Framework provided file for the app
SceneDelegate --> Framework provided file for the app

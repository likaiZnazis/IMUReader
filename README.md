This repository is designed to collect motion data using your iPhone for squat classification.
Setup Instructions

To run the app on your iPhone, you'll need the following:

    A MacBook with Xcode installed

    An Apple Developer Account (free or paid)

    A USB cable to connect your iPhone to the Mac

    Setting up iOS development involves several steps (such as provisioning profiles and signing certificates). Please refer to Apple's official documentation or online tutorials to get your app running on your iPhone.

Cloning & Running the App

Once your development environment is ready:

    Clone this repository to your Mac.

    Open the project in Xcode and build it on the iPhone you will use for data collection.

    Securely attach the iPhone to your right thigh, ensuring it doesn't move while performing squats.

    Start the app to begin collecting motion data.

Data Collected

The app records the following sensor data:

    Accelerometer (X, Y, Z axes)

    Gyroscope (X, Y, Z axes)

    Orientation angles: Roll, Pitch, and Yaw

Exporting Data

After recording your sessions:

    Export the collected .csv files to your computer.

    Use this data for analysis or posture classification.

To preprocess and train a model using this data, refer to the companion repository:
https://github.com/likaiZnazis/squat-Posture/

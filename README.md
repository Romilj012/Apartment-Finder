# Apartment Finder iOS Firebase Application

This repository contains the code for the Apartment Finder iOS Firebase Application, a powerful and user-friendly tool for finding apartments. The application offers various features and functionalities that enhance the apartment search experience. Below are the key highlights of the application:

## Features
1. **Access Camera / Photo Library**: Users can easily add new posts by accessing the device's camera or photo library, allowing them to upload images of apartments they want to list.

2. **No Broker System**: The application eliminates the need for brokers, connecting directly with owners and providing a hassle-free experience for both students and property owners.

3. **Enhanced Search Functionality**: The search functionality is a standout feature of the application. Users can search for apartments based on location, price range, number of bedrooms, and other criteria. The search results are visually appealing, showcasing high-quality images and relevant information. Users can also save their favorite apartments for future reference.

4. **Real-Time Updates**: The application leverages Firebase as the backend, enabling real-time updates. Users receive immediate notifications when new apartments become available or existing listings are updated. This ensures users stay up-to-date with the latest apartment listings without the need for manual refresh or checking multiple websites.

5. **User-Friendly Design**: The application boasts a clean and modern interface, designed with user convenience in mind. The intuitive navigation and user-friendly design make it easy for users to find the information they need. Additionally, the app includes helpful features such as filters and sorting options, enabling users to quickly narrow down their search results and find their perfect apartment.

6. **User Profiles**: Users can create profiles within the application, allowing them to save their favorite apartments and search criteria. This feature enables users to seamlessly continue their apartment search from where they left off. User profiles also provide valuable insights into user preferences, allowing the application to suggest apartments that match their tastes and needs.

## How It Works
Here is a step-by-step guide on how the application works:
1. Property owners create an account on SU Apartment Finder and upload their property details.
2. All verified properties uploaded by owners become visible to students.
3. When a new property becomes available, a push notification is sent to all students.

## Screenshots
The repository includes screenshots of the application to give you a visual representation of its features and interface.

## Default Username and Password
1. Student:
   - Email: romil11@gmail.com
   - Password: 123456

2. Owner:
   - Email: hasnain@gmail.com
   - Password: 123456

## Model
The application's model includes the following entities:
- Owner:
  - Email
  - Name
  - Uid
  - apartments [Apartment]

- Apartment:
  - Description
  - Image
  - Location
  - OwnerId
  - Price

## View Controllers (MVC)
The application follows the Model-View-Controller (MVC) architectural pattern. The key view controllers in the application are:
- Owner / Student (Entity/Model)
- SignInView
- SignUpView
- Owner (Entity-specific View)
- DisplayApartment
- ApartmentDetailView
- ApartmentEditView

## Comparative Analysis
The application sets itself apart from other apartment search platforms through its unique features and functionalities. While platforms like Zumper and Zillow offer their own advantages, the Apartment Finder iOS Firebase Application stands out with its real-time updates, user-friendly design, and direct interaction between students and property owners.

## Conclusion
SU Apartment Finder aims to revolutionize the apartment rental experience, making it easier, faster, and more personalized. The Swift iOS Firebase Apartment Finder Application is a testament to this vision, providing innovative features that enhance the apartment search process. Whether you're a

 first-time renter or an experienced apartment hunter, this application is designed to streamline your search and deliver better results.

Feel free to explore the repository and dive into the code to gain a deeper understanding of the application's implementation. Should you have any questions or feedback, please don't hesitate to reach out.

[![Video Preview](https://example.com/video_preview_thumbnail.jpg)](https://github.com/Romilj012/Apartment-Finder-iOS-Firebase-Application/blob/main/Final_Project_Jain_Romil_video.mp4)

<video width="640" height="480" controls>
  <source src="https://github.com/Romilj012/Apartment-Finder-iOS-Firebase-Application/raw/main/Final_Project_Jain_Romil_video.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>

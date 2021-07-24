
# Winch_App

The app is being developed for all winch driver’s in Egypt, to join us to provide winch service in the customer app in the right way. The registration process is made to be as less exhaustive and lengthy as possible.

## Table of Contents
<img src="https://user-images.githubusercontent.com/43541909/126844087-32d78841-ba2e-48c0-82f5-8b3114c0eab5.jpg" width="150" height="300" align = "right" />

1. [Installation.](#Installation)
2. [Techanologies Used.](#Techanologies_Used)
3. [Learning OutComes.](#Learning_OutComes)
4. [Documentaion For Project.](#Documentaion_For_Project)

   4.1 [Registration[LogIn / SignUp]](#Registration)  
   
   4.2 [Requesting Winch Service](#Requesting_Winch_Service) 
   
   	* [Getting Ready For Receiving Requests](#Getting_Ready_For_Receiving_Requests)
	* [Receiving Customer Request](#Receiving_Customer_Request)
	* [Acceptance Of the Request](#Acceptance_Of_the_Request)
	* [Starting Winch service](#Starting_Winch_service)
	* [Arrival To dropOff location](#Arrival_To_dropOff_location)
	
   	
5. [Projet Status.](#Project_Status)


.
<a name="Installation"/>
## Installation

1. Install Android Studio / Visual Studio.

2. Add Dart & Flutter Exstensions.

3. Download Flutter SDK.

4. Clone The Project.

5. Open Emulator,Run The Project & Enjoy..

#### Note : You may can't proceed in using app normally, this is due to server in off state.
.
<a name="Techanologies_Used"/>
## Techanologies Used :

* Dart / Flutter.
* Firbase Phone Authuntication [Baas].
* Working with Networking [HTTP Requests] 
* Working with Google cloud services [GMaps - GeoCoding API - Directions API - Places API -Distance Matrix API]
* Hive [No Sql] Local DB. 

.
<a name="Learning_OutComes"/>
## Learning Out-Comes :

* Designing somehow beautiful UI screens.
* Using provider as state a mangmnet solution.
* Working with google maps services.
* Impleminting local BB to save user info & app data.
* Supporting Localization [AR - EN]


.
<a name="Documentaion_For_Project"/>
## Documentaion For Project.

.
<a name="Registration"/>
### Registration[LogIn / SignUp]
* Part I:

	[Just like customer registration process, winch drivers register by their mobile number, to do a verification step on this mobile number and to check whether there is an account associated with this mobile number, to let him login to this account or if there is no account associated with this number, to let this winch driver complete his registration process by entering his first and last name or continue with his social accounts.](https://github.com/sherif17/customer_app#Registration)
  
* Part II :

  If it is the first time winch driver register in the app, winch driver is required to enter winch plates information and upload important files, to be reviewed by admin to decide whether to accept this winch driver or not.

<img src="https://user-images.githubusercontent.com/43541909/126847783-a17c2ab7-68c9-4fba-b6a3-ed9b41354f4a.jpg" width="150" height="300" align = "center"  />  <img src="https://user-images.githubusercontent.com/43541909/126847834-205acc4f-8de8-4761-9ad9-2b1cb8b917ce.jpg" width="150" height="300" align = "center" />
<img src="https://user-images.githubusercontent.com/43541909/126860881-a0bd74d2-4993-415b-95da-c4eeecca9c28.jpg" width="150" height="300" align = "center"  />  <img src="https://user-images.githubusercontent.com/43541909/126860943-cafe7573-f233-4cd1-b166-f9ace312d57b.jpg" width="150" height="300" align = "center" /> <img src="https://user-images.githubusercontent.com/43541909/126860987-90f06c76-a2b0-4c37-8158-3bc12c45af6a.jpg" width="150" height="300" align = "center" /> 
<img src="https://user-images.githubusercontent.com/43541909/126860998-6e70ca82-b0b4-4044-a862-ed86880d8a61.jpg" width="150" height="300" align = "center" />

#### Note: Currently for testing,we skip the part of reviewing of the admins for uploaded information, Winch driver will be approved directly if he uploaded all the required information. 
    
* Home & Profile page.

  After registration, Winch driver will be able to use our app normally,recieving incoming requests and viewing associated information to this account.
 
  <img src="https://user-images.githubusercontent.com/43541909/126863169-102a5841-07fd-4b59-918d-cefeea75a90f.jpg" width="150" height="300" align = "center"  />  <img src="https://user-images.githubusercontent.com/43541909/126862958-27f7176c-f054-4d60-b311-026f3c4d4566.jpg" width="150" height="300" align = "center" />
    

### Records



https://user-images.githubusercontent.com/43541909/126863236-4a00ea8e-ac8b-49a8-8d37-85342ab04db6.mp4



https://user-images.githubusercontent.com/43541909/126863345-d27a5d1a-e9c0-44aa-8c07-4aa05b050b44.mp4





.
<a name="Requesting_Winch_Service"/>
### Requesting Winch Service 

.
<a name="Getting_Ready_For_Receiving_Requests"/>
* Getting Ready For Receiving Requests

	* By being online  

	* Winch driver location sent periodically  to backend for matching process. 

	* Waiting for nearest client.
	
	  <img src="https://user-images.githubusercontent.com/43541909/126863560-568a0f50-20e5-45fc-a151-d0cea00fcf71.png" width="150" height="300" align = "center" />  
  	  <img src="https://user-images.githubusercontent.com/43541909/126863592-83519254-077c-4781-981e-c99383b88cff.png" width="150" height="300" align = "center" /> 
 
 
.
<a name="Receiving_Customer_Request"/>  
* Receiving Customer Request

   Request information:
    * PolyLine Between Customer PickUp Location & Winch Driver Current Location. 
    * Estimated Distance Between 2 Points 
    * Estimated Duration Between 2 Points.
    * Customer Rating.  
  
  
  	<img src="https://user-images.githubusercontent.com/43541909/126865384-8f09cbe3-b4c6-4a29-949e-17e57f1e4fc3.png" width="150" height="300" align = "center" />  
  	<img src="https://user-images.githubusercontent.com/43541909/126865385-1e704ce8-bc2d-4a17-90f5-e91a707a6445.png" width="150" height="300" align = "center" />  
  
  
.
<a name="Acceptance_Of_the_Request"/>  
* Acceptance Of the Request 

   Acceptted Request Information:
    * PolyLine Between Customer PickUp Location & Winch Driver Current Location. 
    * Place Name Of The customer Pick-Up Location. 
    * Customer FName, LName, Owned Car Info and Phone Number.
    
      <img src="https://user-images.githubusercontent.com/43541909/126865678-4aa63ae5-7f19-438a-b089-cea5efa6e5be.png" width="150" height="300" align = "center" />
      <img src="https://user-images.githubusercontent.com/43541909/126865605-f7ccfca6-d17c-4e12-bf3a-b901db7fc339.png" width="150" height="300" align = "center" />
      <img src="https://user-images.githubusercontent.com/43541909/126865608-aa074b7c-5a86-417d-8393-29046f64a807.png" width="150" height="300" align = "center" />

.
<a name="Starting_Winch_service"/>
* Starting Winch service.
    
* Customer Start Tracking For arrival of Winch Driver

	* Now,winch driver picked up customer car,heading to drop off location.  

	* When winch driver arrive to drop off location, That Trip will be ended. 
   <img src="https://user-images.githubusercontent.com/43541909/126866045-282a1a69-8fac-49aa-9f98-38cc853e79db.png" width="150" height="300" align = "center" />
   <img src="https://user-images.githubusercontent.com/43541909/126866047-c280cf39-96a5-48fe-a65f-e1d355bc0bb0.png" width="150" height="300" align = "center" />


.
<a name="Arrival_To_dropOff_location"/>
* Arrival To dropOff location.

	When, winch driver ends that trip ,final fare will be shown with an option for rating customer
  
 	 <img src="https://user-images.githubusercontent.com/43541909/126866146-3feafd16-6eae-4f37-8da7-3e68b4850768.png" width="150" height="300" align = "center" />
  
  
### Records  


https://user-images.githubusercontent.com/43541909/126866193-b9d85fb8-47b0-4bea-bbff-accda25a0220.mp4



https://user-images.githubusercontent.com/43541909/126866208-9ba5593e-9654-4f51-ad5d-101e14367df5.mp4



.
<a name="Project_Status"/>
## Project Status.

#### Project Has Been closed For Now, Wait For Further notice 

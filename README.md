# Car Rental Application

This repository contains a Flutter-based Car Rental Application that allows users to browse available vehicles, make reservations, and manage their bookings efficiently.

## Features

1. **Vehicle Selection**
    - Browse and filter available vehicles by type.
    - Detailed information about each vehicle.

2. **Reservation**
    - Make reservations with specified pickup and drop-off dates/times.
    - Choose additional preferences like insurance and tax options.

3. **Additional Charges**
    - Select additional charges such as Collision Damage Waiver, Liability Insurance, and Rental Tax.

4. **Reservation Details**
    - Review detailed reservation information, including customer and vehicle details.

5. **Discounts**
    - Apply discount codes to get special offers.

6. **User Interface**
    - Intuitive and user-friendly interface using Flutter's rich UI components.

## Screenshots

### Reservation Details Page
<img src="https://github.com/Fuad-X/AbdullahAlFuad_car_rental-Flutter-Application-Using-Car-Information-API/assets/77972137/197350db-4d27-436e-bdd4-922cbd7d0365" alt="Reservation Details" width="400">

### Customer Information Page
<img src="https://github.com/Fuad-X/AbdullahAlFuad_car_rental-Flutter-Application-Using-Car-Information-API/assets/77972137/9335abab-6318-4b33-a85f-0db97d5e5fd1" alt="Customer Information" width="400">

### Vehicle Information Page
<img src="https://github.com/Fuad-X/AbdullahAlFuad_car_rental-Flutter-Application-Using-Car-Information-API/assets/77972137/1791544f-35b7-4924-859f-0a93c09f9ecf" alt="Vehicle Information 2" width="400">
<img src="https://github.com/Fuad-X/AbdullahAlFuad_car_rental-Flutter-Application-Using-Car-Information-API/assets/77972137/9031d97d-68a8-4f70-acb1-89ea2eff12f2" alt="Vehicle Information 3" width="400">
<img src="https://github.com/Fuad-X/AbdullahAlFuad_car_rental-Flutter-Application-Using-Car-Information-API/assets/77972137/6975e281-1490-4490-88a9-159c3696e1ad" alt="Vehicle Information 1" width="400">

### Additional Charges Page
<img src="https://github.com/Fuad-X/AbdullahAlFuad_car_rental-Flutter-Application-Using-Car-Information-API/assets/77972137/3138ac7d-0afb-4db0-9979-4e14686bc43c" alt="Additional Charges" width="400">

### Reservation Summary Page
<img src="https://github.com/Fuad-X/AbdullahAlFuad_car_rental-Flutter-Application-Using-Car-Information-API/assets/77972137/cfd2df52-9797-4fb8-a30d-7cd1525eef00" alt="Reservation Summary 2" width="400">
<img src="https://github.com/Fuad-X/AbdullahAlFuad_car_rental-Flutter-Application-Using-Car-Information-API/assets/77972137/78bc2683-09e3-4ca1-9b89-eb008679f4a0" alt="Reservation Summary 1" width="400">

## Usage

1. Clone the repository to your local machine.
2. Open the project in an IDE like Android Studio or Visual Studio Code. Android Studio is preferred.
3. Ensure Flutter and Dart SDK are properly configured.
4. Use in terminal ```flutter pub get```.
5. Run the application on an emulator or physical device using ```flutter run``` or play button.

## Special
1. Using FUAD2024 in Discount gives 15% Discount.
2. Advanced OOP was used in the project.
3. Coding standards were properly followed.
4. The calculations and details were properly viewed.

## Bonus
Let's say you have a Tesla in your system that charges $10 per hour and $50 per day. What occurs now if the car is rented for six hours? Is the customer willing to pay more than the daily rate for one-fourth of the period? Regarding the hourly, daily, and weekly rate systems, how do you handle this issue? Describe your solution in the readme file of your project.

## Answer
I think the lowest amount to rent a car for an hour should be fixed. After that, the rate will go up relative to the daily rent.
Where the pricing should go from $10 to $50 for 1-24 hours.
I would use $10 + (((6hours - 1)*40)/23) this formula to handle this situation.

I could have implemented this. If I would have thought of it earlier. :-)

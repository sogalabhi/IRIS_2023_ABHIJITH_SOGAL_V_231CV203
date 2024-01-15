a. List of implemented features:

1. Implement User/Admin login/logout and User Registration using Firebase.
2. Implement a User Dashboard displaying name, email, roll number, mess balance and current mess information(displayed after initial mess registration).
3. Implement role-based access control for Admin and User roles.
4. Allow users to register for a mess and apply for a mess change.
5. The users should be able to see all mess details(number of available seats, menu etc) while applying for a mess change.

Admin Role:
1. Admins have the authority to create and delete messes.
2. They can approve/reject mess change requests from users.
3. Setting the total number of seats in each mess is also within their control.

User Role:
1. Users can register for a mess after login and also request for mess changes.
2. During initial mess registration, users must add an amount to their balance.
3. Users have a dashboard displaying basic information like name, email, roll number, mess balance, and current mess details.
4. Mess Change Request Flow:

Users initiate a mess change request.
1. Users are shown approval states such as "In Progress" or "Approved" to track their request status.
2. Upon approval, the user's mess information in the application is updated accordingly.

b. List of non-implemented/planned features
1. Show number of requests for mess change
2. Use BLoC for State Management.
3. Utilize Firebase Cloud Messaging (FCM) for notifications when a user’s mess balance is insufficient.
4. Subtracting mess balance
5. Following Clean Architecture principles and TDD
6. Hive for local storage
7. Good looking UI
8. Clean Code

c. List of known bugs
Had some bugs related to requests count. So I have commeneted it out

d. Operating System used. (eg Windows, Linux, Mac OS) Used Android to test

e. Screenshots

 <img src="https://github.com/sogalabhi/IRIS_2023_ABHIJITH_SOGAL_V_231CV203/assets/86911149/c2116fe1-5a62-4902-86ee-f5aad39385e1" width="200" >
 <img src="https://github.com/sogalabhi/IRIS_2023_ABHIJITH_SOGAL_V_231CV203/assets/86911149/535df152-3517-49e8-989d-c44879d8d4bf" width="200" >
 <img src="https://github.com/sogalabhi/IRIS_2023_ABHIJITH_SOGAL_V_231CV203/assets/86911149/339a6fed-2754-4688-8055-60df57e6d0a0" width="200" >
 <img src="https://github.com/sogalabhi/IRIS_2023_ABHIJITH_SOGAL_V_231CV203/assets/86911149/4ab315e1-a2e8-4cb4-97ee-ac56bc06eb52" width="200" >
 <img src="https://github.com/sogalabhi/IRIS_2023_ABHIJITH_SOGAL_V_231CV203/assets/86911149/c9042937-863c-40e9-a490-948859c29d87" width="200" >
 <img src="https://github.com/sogalabhi/IRIS_2023_ABHIJITH_SOGAL_V_231CV203/assets/86911149/f6ae1c65-929a-47d1-9c60-5bb5a20f0678" width="200" >
 


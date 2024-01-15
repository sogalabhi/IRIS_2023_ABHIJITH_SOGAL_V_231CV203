a. List of implemented features:

Implement User/Admin login/logout and User Registration using Firebase.
Implement a User Dashboard displaying name, email, roll number, mess balance and current mess information(displayed after initial mess registration).
Implement role-based access control for Admin and User roles.
Allow users to register for a mess and apply for a mess change.
The users should be able to see all mess details(number of available seats, menu etc) while applying for a mess change.
Admin Role:

Admins have the authority to create and delete messes.
They can approve/reject mess change requests from users.
Setting the total number of seats in each mess is also within their control.
User Role:

Users can register for a mess after login and also request for mess changes.
During initial mess registration, users must add an amount to their balance.
Users have a dashboard displaying basic information like name, email, roll number, mess balance, and current mess details.
Mess Change Request Flow:

Users initiate a mess change request.
Users are shown approval states such as "In Progress" or "Approved" to track their request status.
Upon approval, the user's mess information in the application is updated accordingly.
b. List of non-implemented/planned features

Show number of requests for mess change
Use BLoC for State Management.
Utilize Firebase Cloud Messaging (FCM) for notifications when a user’s mess balance is insufficient.
Subtracting mess balance
Following Clean Architecture principles and TDD
Hive for local storage
Good looking UI
Clean Code
c. List of known bugs

Had some bugs related to requests count. So I have commeneted it out
d. Operating System used. (eg Windows, Linux, Mac OS) Used Android to test

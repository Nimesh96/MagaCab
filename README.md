# 🚖 MagaCab - Online Cab Booking System

**MagaCab** is a simple online cab booking system built with **Java EE, JSP, Servlets, and MySQL**. It allows users to **book rides, manage bookings, and process payments**.

---

## 📌 Features

- ✅ **User Dashboard** – Book a ride, view booking history, and make payments.
- ✅ **Admin Panel** – Manage customers, drivers, vehicles, and bookings.
- ✅ **Authentication System** – Secure login for users and admins.
- ✅ **Vehicle Management** – Add, edit, and delete vehicles.
- ✅ **Ride Fare Calculation** – Calculate total cost based on distance and vehicle type.
- ✅ **PDF Invoice Generation** – Download invoices for completed rides.

---

## 🛠️ Tech Stack

- **Frontend** – HTML, CSS, Bootstrap, JavaScript
- **Backend** – Java EE (JSP, Servlets)
- **Database** – MySQL
- **ORM** – JDBC
- **PDF Generation** – iText Library

---

## 📂 Project Structure

```
📚 MagaCab
┣ 📂 src
┃ ┣ 📂 com.magacab.dao          # Data Access Objects (DAO)
┃ ┣ 📂 com.magacab.model        # Java Models (User, Ride, Vehicle)
┃ ┣ 📂 com.magacab.servlets     # Servlets (Controllers)
┃ ┗ 📂 com.magacab.utils        # Utility Classes (Database Connection)
┣ 📂 web
┃ ┣ 📂 css                     # Stylesheets
┃ ┣ 📂 images                  # Static Assets
┃ ┣ 📄 index.jsp               # Home Page
┃ ┣ 📄 login.jsp               # User Login
┃ ┣ 📄 register.jsp            # User Registration
┃ ┣ 📄 userDashboard.jsp       # User Dashboard
┃ ┣ 📄 adminDashboard.jsp      # Admin Dashboard
┃ ┗ 📄 help.jsp                # Help Page
┣ 📄 README.md                 # Project Documentation
┣ 📄 pom.xml                    # Maven Dependencies
┗ 📄 db.sql                     # Database Schema
```

---

## ⚙️ Setup Instructions

### 1️⃣ Clone the Repository
```bash
git clone https://github.com/yourusername/MagaCab.git
cd MagaCab
```

### 2️⃣ Configure the Database
1. Create a database in **MySQL**:
   ```sql
   CREATE DATABASE magacab;
   ```
2. Import the provided **db.sql** file.

### 3️⃣ Configure Database Connection
Modify `DBConnection.java` to match your **MySQL credentials**:
```java
private static final String URL = "jdbc:mysql://localhost:3306/magacab";
private static final String USER = "root";
private static final String PASSWORD = "yourpassword";
```

### 4️⃣ Run the Project
- Open **NetBeans / Eclipse**.
- Deploy the project to **Apache Tomcat**.
- Access in **browser**:  
  ```
  http://localhost:8080/MagaCab/
  ```

---

## 📚 Design Patterns Used

| **Pattern**            | **Usage in MagaCab**                                      |
|-----------------------|----------------------------------------------------------|
| **MVC Pattern**       | Separation of Model (Ride, User), View (JSP), and Controller (Servlets) |
| **DAO Pattern**       | `RideDAO`, `UserDAO` handle database queries.             |
| **Singleton Pattern** | `DBConnection.java` ensures only one DB connection.       |
| **Factory Pattern**   | `VehicleFactory.java` creates different vehicle objects.  |
| **Observer Pattern**  | `RideNotifier.java` sends notifications for ride updates. |

---

## 🔹 Author

**👤 Nimesh Buddika**  
📧 Email: nimesh.buddika96@gmail.com  

---

## 📚 License

This project is licensed under the **MIT License**.

---

**🚀 Enjoy using MagaCab! Let me know if you need any improvements!** 🎉


# 🏀 Sports Team Management System

A comprehensive MySQL-based database project to efficiently manage sports teams, players, coaches, matches, training, performance, and more.

---

## 📌 Project Overview

The **Sports Team Management System** is designed to handle all the core data operations for managing a sports organization.
This includes player and coach records, match tracking, training sessions, performance analytics, leave management,
and more — all backed by robust SQL operations and relational integrity.

---

## 🛠️ Technologies Used

- **MySQL** – Core database engine
- **SQL** – Table creation, queries, triggers, procedures, and views
- **ER Diagrams** – Designed using MySQL Workbench / Draw.io
- **Stored Procedures** – For modular, reusable query logic
- **Triggers** – For enforcing data rules and auto-updates
- **Transactions** – For maintaining atomic data operations

---

## 🧩 Features Implemented

- ✅ Relational Table Structure with Foreign Key Constraints
- ✅ Inserted Sample Data for Teams, Players, Coaches, Matches, etc.
- ✅ Complex SQL Queries and Reports
- ✅ Views for Player Performance Summaries
- ✅ Stored Procedures to Retrieve Players by Team
- ✅ Triggers to Prevent Invalid Performance Data
- ✅ Transactions for Multi-step Insertions
- ✅ ER Diagram for Full Database Design

---

## 🗂️ List of Entities

- `Team`
- `Coach`
- `Player`
- `Venue`
- `Matches`
- `Performance`
- `Training_Session`
- `Player_Training`
- `Leave_Record`

---

## 📊 Sample Queries

```sql
-- Get players with average rating above 8
SELECT p.First_Name, p.Last_Name, AVG(per.Rating) as Avg_Rating
FROM Player p
JOIN Performance per ON p.Player_Id = per.Player_Id
GROUP BY p.Player_Id
HAVING AVG(per.Rating) > 8;

-- List all training sessions attended by a player
SELECT ts.Training_Name, ts.Training_Date
FROM Player_Training pt
JOIN Training_Session ts ON pt.Training_Id = ts.Training_Id
WHERE pt.Player_Id = 201;

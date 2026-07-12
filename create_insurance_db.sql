-- חברת ביטוחים - מסד נתונים לאקטואריה
-- ==================================================

-- טבלת לקוחות
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    id_number VARCHAR(20) UNIQUE NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20),
    address VARCHAR(200),
    registration_date DATE NOT NULL
);

-- טבלת סוגי ביטוח
CREATE TABLE insurance_types (
    type_id INT PRIMARY KEY AUTO_INCREMENT,
    type_name VARCHAR(100) NOT NULL,
    description VARCHAR(500),
    min_premium DECIMAL(10, 2),
    max_premium DECIMAL(10, 2)
);

-- טבלת פוליסות
CREATE TABLE policies (
    policy_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    type_id INT NOT NULL,
    policy_number VARCHAR(50) UNIQUE NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    annual_premium DECIMAL(10, 2) NOT NULL,
    monthly_premium DECIMAL(10, 2),
    status VARCHAR(20), -- Active, Expired, Cancelled
    created_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (type_id) REFERENCES insurance_types(type_id)
);

-- טבלת תביעות (Claims)
CREATE TABLE claims (
    claim_id INT PRIMARY KEY AUTO_INCREMENT,
    policy_id INT NOT NULL,
    claim_number VARCHAR(50) UNIQUE NOT NULL,
    claim_date DATE NOT NULL,
    claim_amount DECIMAL(12, 2) NOT NULL,
    description VARCHAR(500),
    status VARCHAR(20), -- Open, Approved, Rejected, Paid
    approval_date DATE,
    payment_date DATE,
    payment_amount DECIMAL(12, 2),
    FOREIGN KEY (policy_id) REFERENCES policies(policy_id)
);

-- טבלת נתונים סטטיסטיים (משכנתא, הכנסה, וכו')
CREATE TABLE customer_demographics (
    demographic_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL UNIQUE,
    income_level VARCHAR(50),
    employment_status VARCHAR(50),
    number_of_dependents INT,
    smoking_status VARCHAR(20),
    health_status VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- טבלת תשלומים
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    policy_id INT NOT NULL,
    payment_date DATE NOT NULL,
    payment_amount DECIMAL(10, 2) NOT NULL,
    payment_method VARCHAR(50), -- Cash, Card, Bank Transfer
    status VARCHAR(20), -- Completed, Pending, Failed
    FOREIGN KEY (policy_id) REFERENCES policies(policy_id)
);

-- ==================================================
-- הכנסת נתונים לדוגמה
-- ==================================================

-- לקוחות
INSERT INTO customers VALUES
(1, 'דוד', 'כהן', '1975-03-15', '12345678901', 'david.cohen@email.com', '0502222222', 'רחוב הרצל 10, תל אביב', '2020-01-10'),
(2, 'אירית', 'לוי', '1982-07-22', '98765432101', 'irit.levi@email.com', '0503333333', 'רחוב דיזנגוף 5, תל אביב', '2021-05-15'),
(3, 'משה', 'שמעוני', '1968-11-08', '11111111111', 'moshe.shimoni@email.com', '0504444444', 'רחוב בן גוריון 20, ירושלים', '2019-03-20'),
(4, 'רות', 'מור', '1990-01-30', '22222222222', 'ruth.mor@email.com', '0505555555', 'רחוב כרמל 15, חיפה', '2022-08-01'),
(5, 'יוסי', 'גבריאל', '1955-09-12', '33333333333', 'yossi.gabriel@email.com', '0506666666', 'רחוב בר כוכבא 8, בית שמש', '2018-11-25');

-- סוגי ביטוח
INSERT INTO insurance_types VALUES
(1, 'ביטוח בריאות', 'כיסוי רפואי בסיסי', 200, 800),
(2, 'ביטוח רכב', 'ביטוח חובה וביטוח כספי', 500, 2000),
(3, 'ביטוח ביתי', 'כיסוי רכוש ואחריות אזרחית', 300, 1500),
(4, 'ביטוח חיים', 'ביטוח על החיים לתקופה', 100, 600),
(5, 'ביטוח תאונות', 'כיסוי תאונות אישיות', 150, 500);

-- פוליסות
INSERT INTO policies VALUES
(1, 1, 1, 'POL-2020-001', '2020-01-15', '2027-01-15', 600, 50, 'Active', '2020-01-10'),
(2, 2, 2, 'POL-2021-002', '2021-06-01', '2024-06-01', 1200, 100, 'Expired', '2021-05-15'),
(3, 3, 3, 'POL-2019-003', '2019-04-10', '2026-04-10', 500, 42, 'Active', '2019-03-20'),
(4, 4, 4, 'POL-2022-004', '2022-08-15', '2027-08-15', 350, 29, 'Active', '2022-08-01'),
(5, 5, 2, 'POL-2018-005', '2018-12-01', '2025-12-01', 1500, 125, 'Active', '2018-11-25'),
(6, 1, 4, 'POL-2021-006', '2021-03-01', '2026-03-01', 400, 33, 'Active', '2021-02-20');

-- תביעות
INSERT INTO claims VALUES
(1, 1, 'CLM-2023-001', '2023-05-10', 2500, 'ביקור רופא ותרופות', 'Paid', '2023-05-15', '2023-05-20', 2500),
(2, 3, 'CLM-2023-002', '2023-08-22', 15000, 'נזק לרכוש בשריפה', 'Approved', '2023-09-01', NULL, NULL),
(3, 5, 'CLM-2023-003', '2023-11-05', 8000, 'תאונת רכב', 'Open', NULL, NULL, NULL),
(4, 1, 'CLM-2024-004', '2024-02-14', 3500, 'בדיקות רפואיות', 'Paid', '2024-02-20', '2024-02-25', 3500),
(5, 4, 'CLM-2023-005', '2023-12-10', 50000, 'תביעת מוות', 'Rejected', '2023-12-20', NULL, NULL);

-- נתונים דמוגרפיים
INSERT INTO customer_demographics VALUES
(1, 1, 'High', 'Employed', 2, 'No', 'Good'),
(2, 2, 'Medium', 'Employed', 1, 'Yes', 'Fair'),
(3, 3, 'High', 'Retired', 3, 'No', 'Good'),
(4, 4, 'Low', 'Self-employed', 0, 'No', 'Excellent'),
(5, 5, 'Medium', 'Employed', 1, 'No', 'Fair');

-- תשלומים
INSERT INTO payments VALUES
(1, 1, '2024-01-15', 600, 'Bank Transfer', 'Completed'),
(2, 1, '2024-02-15', 50, 'Card', 'Completed'),
(3, 3, '2024-01-10', 500, 'Bank Transfer', 'Completed'),
(4, 4, '2024-01-15', 350, 'Card', 'Completed'),
(5, 5, '2024-02-01', 1500, 'Bank Transfer', 'Completed'),
(6, 6, '2024-02-10', 400, 'Bank Transfer', 'Completed'),
(7, 2, '2024-01-20', 1200, 'Card', 'Failed');

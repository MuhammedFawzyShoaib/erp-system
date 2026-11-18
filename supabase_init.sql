-- ==============================================================================
-- ULTRA-LIGHTWEIGHT ZERO-BLOAT ERP SYSTEM - SUPABASE INITIALIZATION SCHEMA
-- Architecture: Supabase Cloud PostgreSQL (0 MB Local Storage)
-- Author: Muhammed Fawzy Shoaib
-- Target: Supabase SQL Editor
-- ==============================================================================

-- Drop existing tables in reverse dependency order if re-running
DROP TABLE IF EXISTS invoices CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS accounts CASCADE;
DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS roles CASCADE;

-- ------------------------------------------------------------------------------
-- 1. ROLES TABLE
-- ------------------------------------------------------------------------------
CREATE TABLE roles (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

-- ------------------------------------------------------------------------------
-- 2. USERS TABLE
-- ------------------------------------------------------------------------------
CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    role_id BIGINT REFERENCES roles(id) ON DELETE RESTRICT,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

-- ------------------------------------------------------------------------------
-- 3. PRODUCTS TABLE (Inventory Module)
-- ------------------------------------------------------------------------------
CREATE TABLE products (
    id BIGSERIAL PRIMARY KEY,
    sku VARCHAR(50) UNIQUE NOT NULL,
    name VARCHAR(150) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price NUMERIC(12, 2) NOT NULL DEFAULT 0.00,
    cost NUMERIC(12, 2) NOT NULL DEFAULT 0.00,
    stock INT NOT NULL DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

-- ------------------------------------------------------------------------------
-- 4. CUSTOMERS TABLE (CRM & Sales Module)
-- ------------------------------------------------------------------------------
CREATE TABLE customers (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(30),
    address TEXT,
    balance NUMERIC(12, 2) NOT NULL DEFAULT 0.00,
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

-- ------------------------------------------------------------------------------
-- 5. INVOICES TABLE (POS & Billing Module)
-- ------------------------------------------------------------------------------
CREATE TABLE invoices (
    id BIGSERIAL PRIMARY KEY,
    invoice_number VARCHAR(50) UNIQUE NOT NULL,
    customer_id BIGINT REFERENCES customers(id) ON DELETE RESTRICT,
    total_amount NUMERIC(12, 2) NOT NULL DEFAULT 0.00,
    tax NUMERIC(12, 2) NOT NULL DEFAULT 0.00,
    status VARCHAR(20) NOT NULL DEFAULT 'pending', -- 'paid', 'pending', 'cancelled'
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

-- ------------------------------------------------------------------------------
-- 6. ACCOUNTS TABLE (General Ledger & Accounting Module)
-- ------------------------------------------------------------------------------
CREATE TABLE accounts (
    id BIGSERIAL PRIMARY KEY,
    account_code VARCHAR(30) UNIQUE NOT NULL,
    account_name VARCHAR(100) NOT NULL,
    account_type VARCHAR(30) NOT NULL, -- 'Asset', 'Liability', 'Equity', 'Revenue', 'Expense'
    balance NUMERIC(14, 2) NOT NULL DEFAULT 0.00,
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

-- ------------------------------------------------------------------------------
-- 7. EMPLOYEES TABLE (HR & Payroll Module)
-- ------------------------------------------------------------------------------
CREATE TABLE employees (
    id BIGSERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    department VARCHAR(50) NOT NULL,
    position VARCHAR(100) NOT NULL,
    salary NUMERIC(12, 2) NOT NULL DEFAULT 0.00,
    hire_date DATE NOT NULL DEFAULT CURRENT_DATE,
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

-- ------------------------------------------------------------------------------
-- PERFORMANCE INDEXES (Optimized for Instant Queries & Cloud Latency)
-- ------------------------------------------------------------------------------
CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_products_sku ON products(sku);
CREATE INDEX idx_products_category ON products(category);
CREATE INDEX idx_customers_email ON customers(email);
CREATE INDEX idx_invoices_customer_id ON invoices(customer_id);
CREATE INDEX idx_invoices_status ON invoices(status);
CREATE INDEX idx_accounts_type ON accounts(account_type);
CREATE INDEX idx_employees_department ON employees(department);

-- ------------------------------------------------------------------------------
-- STRICTLY ONE (1) TEST RECORD PER TABLE SEEDING
-- ------------------------------------------------------------------------------

-- 1. Test Role: Administrator
INSERT INTO roles (id, name, description, created_at)
VALUES (1, 'Admin', 'System Administrator with full access to all ERP modules', NOW());

-- 2. Test User: Admin (Password: admin123 | Bcrypt hashed: $2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy)
INSERT INTO users (id, role_id, username, email, password_hash, full_name, created_at)
VALUES (1, 1, 'admin', 'admin@erp.local', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'System Admin', NOW());

-- 3. Test Product: Ergonomic Office Chair
INSERT INTO products (id, sku, name, category, price, cost, stock, created_at)
VALUES (1, 'PROD-001', 'Ergonomic Executive Office Chair', 'Furniture', 249.99, 140.00, 50, NOW());

-- 4. Test Customer: Acme Global Industries
INSERT INTO customers (id, name, email, phone, address, balance, created_at)
VALUES (1, 'Acme Global Industries', 'contact@acmeglobal.com', '+1-555-0199', '100 Innovation Way, Suite 400, Tech City', 0.00, NOW());

-- 5. Test Invoice: INV-2026-0001
INSERT INTO invoices (id, invoice_number, customer_id, total_amount, tax, status, created_at)
VALUES (1, 'INV-2026-0001', 1, 249.99, 25.00, 'paid', NOW());

-- 6. Test Account: 1010 - Primary Operating Cash
INSERT INTO accounts (id, account_code, account_name, account_type, balance, created_at)
VALUES (1, '1010', 'Primary Operating Cash Account', 'Asset', 50000.00, NOW());

-- 7. Test Employee: Muhammed Fawzy Shoaib (Lead Architect)
INSERT INTO employees (id, first_name, last_name, email, department, position, salary, hire_date, created_at)
VALUES (1, 'Muhammed', 'Shoaib', 'fawzy@erp.local', 'Engineering', 'Principal Software Architect', 125000.00, '2024-01-15', NOW());

-- Reset primary key serial sequences to avoid conflict on next inserts
SELECT setval('roles_id_seq', (SELECT MAX(id) FROM roles));
SELECT setval('users_id_seq', (SELECT MAX(id) FROM users));
SELECT setval('products_id_seq', (SELECT MAX(id) FROM products));
SELECT setval('customers_id_seq', (SELECT MAX(id) FROM customers));
SELECT setval('invoices_id_seq', (SELECT MAX(id) FROM invoices));
SELECT setval('accounts_id_seq', (SELECT MAX(id) FROM accounts));
SELECT setval('employees_id_seq', (SELECT MAX(id) FROM employees));

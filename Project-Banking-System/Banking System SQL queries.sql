-- Accounts table
CREATE TABLE accounts (
    account_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    balance NUMERIC(12,2) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Transaction table
CREATE TABLE transactions (
    transaction_id SERIAL PRIMARY KEY,
    account_id INT REFERENCES accounts(account_id),
    type VARCHAR(20), -- deposit / withdraw / transfer
    amount NUMERIC(12,2),
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Deposit Function
CREATE OR REPLACE FUNCTION deposit(p_account_id INT, p_amount NUMERIC)
RETURNS VOID AS $$
BEGIN
    UPDATE accounts
    SET balance = balance + p_amount
    WHERE account_id = p_account_id;

    INSERT INTO transactions(account_id, type, amount)
    VALUES (p_account_id, 'deposit', p_amount);
END;
$$ LANGUAGE plpgsql;

-- Withdraw function
CREATE OR REPLACE FUNCTION withdraw(p_account_id INT, p_amount NUMERIC)
RETURNS VOID AS $$
DECLARE
    current_balance NUMERIC;
BEGIN
    SELECT balance INTO current_balance
    FROM accounts
    WHERE account_id = p_account_id;

    IF current_balance >= p_amount THEN
        UPDATE accounts
        SET balance = balance - p_amount
        WHERE account_id = p_account_id;

        INSERT INTO transactions(account_id, type, amount)
        VALUES (p_account_id, 'withdraw', p_amount);
    ELSE
        RAISE EXCEPTION 'Insufficient balance';
    END IF;
END;
$$ LANGUAGE plpgsql;


-- Transfer Function
CREATE OR REPLACE FUNCTION transfer(
    sender_id INT,
    receiver_id INT,
    amount NUMERIC
)
RETURNS VOID AS $$
DECLARE
    sender_balance NUMERIC;
BEGIN
    -- Check sender balance
    SELECT balance INTO sender_balance
    FROM accounts
    WHERE account_id = sender_id;

    IF sender_balance >= amount THEN
        -- Deduct from sender
        UPDATE accounts
        SET balance = balance - amount
        WHERE account_id = sender_id;

        -- Add to receiver
        UPDATE accounts
        SET balance = balance + amount
        WHERE account_id = receiver_id;

        -- Log transaction (sender side)
        INSERT INTO transactions(account_id, type, amount)
        VALUES (sender_id, 'transfer_out', amount);

        -- Log transaction (receiver side)
        INSERT INTO transactions(account_id, type, amount)
        VALUES (receiver_id, 'transfer_in', amount);
    ELSE
        RAISE EXCEPTION 'Insufficient balance';
    END IF;
END;
$$ LANGUAGE plpgsql;


-- Queries
SELECT * FROM accounts;

CREATE TABLE IF NOT EXISTS budget_types
(
  budget_type_id   smallserial  NOT NULL,
  budget_type_name varchar(100) NOT NULL,
  PRIMARY KEY (budget_type_id)
);

COMMENT ON TABLE budget_types IS 'Dictionary table listing possible budget types';

CREATE TABLE IF NOT EXISTS budgets
(
  budget_id      bigserial   NOT NULL,
  budget_type_id smallserial NOT NULL,
  user_id        bigserial   NOT NULL,
  created_at     timestamp   NOT NULL,
  state_id       smallint    NOT NULL,
  income         numeric    ,
  start_date     date        NOT NULL,
  end_date       date        NOT NULL,
  state_id       smallserial NOT NULL,
  PRIMARY KEY (budget_id)
);

COMMENT ON TABLE budgets IS 'Table for storing information about budgets';

CREATE TABLE IF NOT EXISTS debts
(
  debt_it       bigserial     NOT NULL,
  user_id       bigserial     NOT NULL,
  creditor_name varchar(100)  NOT NULL,
  amount        numeric       NOT NULL,
  description   varchar(1000),
  PRIMARY KEY (debt_it)
);

COMMENT ON TABLE debts IS 'Table for storing users' debt and loan info';

CREATE TABLE IF NOT EXISTS languages
(
  language_id   smallserial  NOT NULL,
  language_name varchar(100) NOT NULL,
  PRIMARY KEY (language_id)
);

COMMENT ON TABLE languages IS 'Dictionary table listing available languages';

CREATE TABLE IF NOT EXISTS saving_account_transactions
(
  saving_account_id bigserial NOT NULL,
  transaction_id    bigserial NOT NULL,
  amount            numeric   NOT NULL
);

COMMENT ON TABLE saving_account_transactions IS 'Join table between saving_accounts and transactions to track transactions to and from savings accounts';

CREATE TABLE IF NOT EXISTS saving_accounts
(
  saving_account_id bigserial    NOT NULL,
  user_id           bigserial    NOT NULL,
  name              varchar(100) NOT NULL,
  balance           numeric      NOT NULL,
  PRIMARY KEY (saving_account_id)
);

COMMENT ON TABLE saving_accounts IS 'Table for storing users' savings accounts';

CREATE TABLE IF NOT EXISTS spending_categories
(
  spending_category_id serial       NOT NULL,
  category_name        varchar(100),
  PRIMARY KEY (spending_category_id)
);

COMMENT ON TABLE spending_categories IS 'Dictionary table storing available spendign categories for budgets ';

CREATE TABLE IF NOT EXISTS spending_category_to_budget
(
  spending_category_id serial    NOT NULL,
  budget_id            bigserial NOT NULL,
  planned_spending     numeric   NOT NULL
);

COMMENT ON TABLE spending_category_to_budget IS 'Join table between spending categories and budgets';

CREATE TABLE IF NOT EXISTS states
(
  state_id   smallserial NOT NULL,
  state_name varchar(50),
  PRIMARY KEY (state_id)
);

COMMENT ON TABLE states IS 'Dictionary table defining possible entity states';

CREATE TABLE IF NOT EXISTS transactions
(
  transaction_id       bigserial    NOT NULL,
  budget_id            bigserial    NOT NULL,
  amount               numeric      NOT NULL,
  transaction_date     date        ,
  created_at           timestamptz  NOT NULL,
  description          varchar(200),
  spending_category_id serial       NOT NULL,
  PRIMARY KEY (transaction_id)
);

COMMENT ON TABLE transactions IS 'Table for storing transactions';

CREATE TABLE IF NOT EXISTS users
(
  user_id                 bigserial    NOT NULL,
  email                   varchar(100) NOT NULL,
  user_name               varchar(100) NOT NULL,
  password_hash           varchar(256) NOT NULL,
  created_at              timestamptz  NOT NULL,
  state_id                smallint     NOT NULL,
  last_password_change_at timestamptz  NOT NULL,
  language_id             smallserial  NOT NULL,
  state_id                smallserial  NOT NULL,
  PRIMARY KEY (user_id)
);

COMMENT ON TABLE users IS 'Table for storing users, their credentials';

ALTER TABLE budgets
  ADD CONSTRAINT FK_budget_types_TO_budgets
    FOREIGN KEY (budget_type_id)
    REFERENCES budget_types (budget_type_id);

ALTER TABLE budgets
  ADD CONSTRAINT FK_users_TO_budgets
    FOREIGN KEY (user_id)
    REFERENCES users (user_id);

ALTER TABLE budgets
  ADD CONSTRAINT FK_states_TO_budgets
    FOREIGN KEY (state_id)
    REFERENCES states (state_id);

ALTER TABLE debts
  ADD CONSTRAINT FK_users_TO_debts
    FOREIGN KEY (user_id)
    REFERENCES users (user_id);

ALTER TABLE saving_account_transactions
  ADD CONSTRAINT FK_saving_accounts_TO_saving_account_transactions
    FOREIGN KEY (saving_account_id)
    REFERENCES saving_accounts (saving_account_id);

ALTER TABLE saving_account_transactions
  ADD CONSTRAINT FK_transactions_TO_saving_account_transactions
    FOREIGN KEY (transaction_id)
    REFERENCES transactions (transaction_id);

ALTER TABLE saving_accounts
  ADD CONSTRAINT FK_users_TO_saving_accounts
    FOREIGN KEY (user_id)
    REFERENCES users (user_id);

ALTER TABLE spending_category_to_budget
  ADD CONSTRAINT FK_spending_categories_TO_spending_category_to_budget
    FOREIGN KEY (spending_category_id)
    REFERENCES spending_categories (spending_category_id);

ALTER TABLE spending_category_to_budget
  ADD CONSTRAINT FK_budgets_TO_spending_category_to_budget
    FOREIGN KEY (budget_id)
    REFERENCES budgets (budget_id);

ALTER TABLE transactions
  ADD CONSTRAINT FK_budgets_TO_transactions
    FOREIGN KEY (budget_id)
    REFERENCES budgets (budget_id);

ALTER TABLE transactions
  ADD CONSTRAINT FK_spending_categories_TO_transactions
    FOREIGN KEY (spending_category_id)
    REFERENCES spending_categories (spending_category_id);

ALTER TABLE users
  ADD CONSTRAINT FK_languages_TO_users
    FOREIGN KEY (language_id)
    REFERENCES languages (language_id);

ALTER TABLE users
  ADD CONSTRAINT FK_states_TO_users
    FOREIGN KEY (state_id)
    REFERENCES states (state_id);

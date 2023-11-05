## Functional requirements

1. Registration, authentication, password recovery
   * User should provide valid email address and password as their credentials.
   * User should confirm their email after registration.
   * User should be able to recover password through email if password is lost.
2. User data management
   * User should be able to change their password.
   * User should be able to delete their account and all associated data.
3. Budget management and transaction tracking
   * User should be able to specify and manage monthly budget.
      * User should be able to specify categories in the monthly budget, and specify planned spending for each category.
      * User should be able to create budget templates. Those templates would serve as a base, from which actual monthly budgets could be created and modified.
      * User should be able to specify their montly income, although it should not be a necessity.
   * User should be able to track their spending by noting down transactions.
      * Transactions can have either positive or negative balance.
      * User should be able to match every transaction to a spending category to track their spendings in each category.
      * Transactions should have following attributes:
         * Category
         * Amount
         * Transaction date (optional)
         * Description (optional)
         * Record creation timestamp
   * User should be able to see:
      * their spending in each budget category,
      * their total monthly spending, 
      * the difference between their montly budget and spending
      * the difference between their montly budget and income(if they provided their income),
      * the difference between their montly spending and income (if they provided their income).
4. Debt and loan tracking
   * User should be able to note down their debts and loans.
   * Debt/loan has following parameters:
      * Name (of a person to which user owes the money/whom owes the money to the user)
      * Amount
      * Description (e.g. what is the debt for) (optional)
   * User should be able to see the balance of their debts and loans.
   * User should be able to see how the balance of their debts and loans affects their monthly budget balance.
5. Savings
   * User should be able to define savings accounts. 
   * User should be able to deposit and withdraw money from savings accounts. Those operations should be planned and reflected in the monthly budget.

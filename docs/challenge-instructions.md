Welcome! The Tropic Code Challenge is meant to simulate a real-world task that you might encounter working within our codebase.

At Tropic, we have a culture of completeness for the code we ship. This means that the code should be well-tested, documented, and should match the look and feel of the provided Figma designs.

**Once complete, please create a private Github repo and give access to:**
- jwhitmire
- lscoates
- pbcoronel
- samneely

Feel free to update the README with any additional information you'd like to share.

## AI

We're excited to see how you design and implement the solution for this challenge so we ask that you **do not use any AI tools**.

## Setup

This is a Rails 7 application that comes pre-built with TailwindCSS and RSpec. Turbo and Stimulus are installed by default.

**Running the App**
* Install and use the version of Ruby specified in the `.ruby-version` file
* Run `bin/setup` to install dependencies and prepare the database (Postgres)
* Run `bin/dev` to start your local server (http://localhost:3000)

## Stories

As an engineer at Tropic, you are tasked with adding the ability to import a CSV of contracts into the system. The application comes with basic `contract` and `contract_owner` models already, a few seeded contracts, and a contract index.

**Designs**: https://www.figma.com/community/file/1240366036828677673

We also expect engineers at Tropic to have a user-centric and product-oriented mindset when they're building features and capabilities. If you find any gaps in the provided card definitions, use your own product-thinking and approach to complete the requested features. Document your thought processes and assumptions in the README or a PR when you complete the exercise.

---

### Card 101
Add support for contracts to be tied to a specific supplier.
- A contract's supplier should always be present.

---

### Card 102
Add the ability to import a CSV of contracts via a modal that is opened from the contracts index. We've included a CSV of contracts for testing (`lib/fixtures/contracts-and-suppliers.csv`). Your solution should be able to properly handle importing this CSV with a seeded database.
- if any rows fail to create a contract, errors should be displayed for each failed row. Valid contracts should still be created.
- if a contract already exists in the system, don't create a duplicate contract.
    - We can tell a contract exists by it's unique `external_contract_id`
- if a contract already exists in the system, we should update the contract with any new data from the CSV
- if a similar supplier name exists in the database already, use the existing supplier
    - For example, "Access IT" and "AccessIT" should end up as one supplier, not two

---

### Card 103
Add a link within each row of the contracts index to the contract's supplier. The supplier view should display a table of all contracts that belong to that supplier.

---

### Card 104
On the supplier view, display an average contract value for all of the supplier's contracts.

---

### Bonuses

- Use Hotwire to live stream import updates to the page
- Find and remove any N+1 queries in the app
- Refactor parts of the app you think could be improved

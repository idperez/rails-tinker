# Tropic Code Challenge

Original Challenge Instructions: [docs/challenge-instructions](docs/challenge-instructions.md)

## Results

The following is the results from the given requirement cards

### Card 101 - contracts to be tied to a specific supplier

A Supplier [model](app/models/supplier.rb) has been created
- `has_many` Contracts
- Uses `identifier` attribute to prevent similar named suppliers from being created

### Card 102 - import a CSV of contracts via a modal

See CSV upload demo (Hosted on OneDrive): https://1drv.ms/v/s!AhkDeTRiWXeCjS1AGDmHGGmbO5Ui?e=9vLjli

- Modal rendered via turbo-frame tag
- CSV stored using ActiveStorage
- Contract creation/update done via Sidkiq background job
- LightService used to orchestrate the workflow of processing the csv and creating records
- turbo-streams used to notify user the results of the upload including: contracts created, updated and failed

### Cards 103/104 - link from contracts table to a supplier view with average contract value

See supplier page demo (Hosted on OneDrive): https://1drv.ms/v/s!AhkDeTRiWXeCjS1AGDmHGGmbO5Ui?e=9vLjli

- Link to `/contracts/supplier?id={supplier.id}`
- Average contract value derived by the `average_contract_value` method on [Supplier](app/models/supplier.rb) model

### Bonuses

#### Use Hotwire to live stream import updates to the page
- Contracts are updated via turbo stream

#### Find and remove any N+1 queries in the app
- Utilizing `includes` on queries to eager load relationships on Contracts, Suppliers and ContractOwners for better query performance

#### Refactor parts of the app you think could be improved
- Contracts/Suppliers/ContractOwners are core models that drive the enterprise, we should have in pace strong checks and balances with them. Soft deletion via `acts_as_paranoid` and audit logs via `paper_trail` have been added to each model
- Rubocop has been added for better code style
- Mobile friendly tables

## Given More Time, What Next?
- 100% test coverage, currently only have model specs
- Dockerize project, as project grows can be helpful for dependency management, better isolation of various services, ensure each dev has same environment, etc
- Utilize a cloud blob storage. Something like S3 can leverage features like transfer acceleration and infrequent access pricing
- Persist an upload via say an Upload model to tie contracts to an upload event for better record keeping
- Table pagination, sorting, filtering
- CSV download on contract and supplier tables, important feature for many customers
- App observability and monitoring via logs, alerts, session tracking, etc

## Thoughts

Thank you for the opportunity to do this challenge. I have a rails background, but my front end background is primarily in React.
The biggest challenge for me was the front end and wrapping my head around Hotwire. I'm really impressed with how much you can build with so
little Javascript using Hotwire.

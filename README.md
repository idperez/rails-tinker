# Tropic Code Challenge

Original Challenge Instructions: [docs/challenge-instructions](docs/challenge-instructions.md)

## Results

The following is the results from the given requirement cards

### Card 101 - contracts to be tied to a specific supplier

A Supplier [model](app/models/supplier.rb) has been created
- `has_many` Contracts
- Uses `identifier` attribute to prevent similar named suppliers from being created

### Card 102 - import a CSV of contracts via a modal

![Video](./demo/csv-upload.mov)

- Modal rendered via turbo-frame tag
- CSV stored using ActiveStorage
- Contract creation/update done via Sidkiq background job
- LightService used to orchestrate the workflow of processing the csv and creating records
- turbo-streams used to notify user the results of the upload including contracts created, updated and failures with a reasons

### Card 103/104 - link from contracts table to a supplier view with average contract value

![Video](./demo/supplier-view.mov)

- Link to `/contracts/supplier?id={supplier.id}`
- Average contract value derived by the `average_contract_value` method on [Supplier](app/models/supplier.rb) model

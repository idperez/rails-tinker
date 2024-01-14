## Results

The following is the results from the given requirement cards

A Supplier [model](app/models/supplier.rb) has been created
- `has_many` Contracts
- Uses `identifier` attribute to prevent similar named suppliers from being created

See CSV upload demo (Hosted on OneDrive): https://1drv.ms/v/s!AhkDeTRiWXeCjS1AGDmHGGmbO5Ui?e=9vLjli

- Modal rendered via turbo-frame tag
- CSV stored using ActiveStorage
- Contract creation/update done via Sidkiq background job
- LightService used to orchestrate the workflow of processing the csv and creating records
- turbo-streams used to notify user the results of the upload including: contracts created, updated and failed


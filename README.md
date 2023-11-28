# Tea Subscription
## About
This app serves as a Tea Subscription API. This is establishes endpoints usable by a front end team to: 
1. Create a new Tea Subscription for a customer
2. Deactivate a Tea Subscription for a customer
3. View all Tea Subscriptions for a customer

## Endpoints

`post "/api/v1/customer_subscriptions"`
`patch "/api/v1/customer_subscriptions/:id"`
`get '/api/v1/customer_subscriptions', params: { customer_id: <customer_id> }


## Built With: 
- Ruby 3.2.2
- Rails 7.0.8
- RSpec 3.12

## Branch Naming Conventions
When branching on this repo please use the conventions of `userstory#_name_feature`

## Configuration
```
1. Fork and Clone
2. $ bundle install
3. $ rails db:{drop,create,migrate,seed}
```

## Database visualization
![Tea Subscription Schema Visualization](https://gist.github.com/assets/134240535/81c5c81e-b980-4d45-afa3-adb128a039a5)

## How to run the test suite
`bundle exec rspec`

## Contributors 
- Noelle Hemphill | [GitHub](https://github.com/lofi-nowhale) | [LinkedIn](https://www.linkedin.com/in/noelle-hemphill/)

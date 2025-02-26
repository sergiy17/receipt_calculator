# Receipt generator
Prints out the receipt details for specific shopping basket.

- Takes into a count a **basic sales tax** at a rate of 10% on all goods, except books, food, and medical products

- Adds an additional sales tax at a rate of 5% on all imported goods without exceptions

## The flow explanation
To generate the `receipt` we have to feed the `products bucket` str to `Receipt` class.  Then the `products bucket` str is parsed by `ShoppingBucketParser` to `BucketItem`s (json objects). These json objects (@bucket_items) are used by `Receipt` class to _generate_ the str summary.

## Instructions
Execute a script with the test data: `ruby run.rb`

Run tests: `rspec spec`

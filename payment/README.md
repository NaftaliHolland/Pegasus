this contains all the interaction of the payment apis

## customer to business 
also sdk push to our paybill


## the flow of the logic

```
    Customer has to enter the number or either choose to use the number that he or she has used in his whatsapp
    
    The number is sent as a http request or graphql request to the payment gatway
    
    the process of the number takes place
    

    i will update this further



```
authkey --> sdk push --> c2b

done with the auth key

## the sdk push configuration 
    note this is just a thought process

    ```

    Api shall take the following data
    1. the buy for -> these is the number of the person you want to buy credit for
    2. pay_from -> the number that will receive the stk pin 
    3. amount

    if the number if same as the one making payment 
    we will the same as 1 and 2
```
make a post request to this
http://localhost:4000/v1/payment
note there is no +
    ```
    {
        buy_for: 2541234434,
        pay_from: 254232345,
        amount: 2
    }
    ```

23 may
---
working on the clear response from the api


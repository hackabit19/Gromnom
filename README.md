# Gromnom

> A food pooling app bringing foodies together.

![Flutter](https://img.shields.io/badge/Flutter-Made%20with%20Flutter-blue)

## Idea
We noticed that when a person orders a single item from online food ordering and delivery apps like Swiggy, they incur extra charges (such as delivery charges) and are not eligible for discount coupons if their cart price is less than a minimum threshold (say 100 INR). But there are no extra charges when the cart price is above that threshold. Now the person cannot order extra food for himself just to save the extra charges levied or to be eligible to avail discounts. So the idea is to pool in orders from multiple people in the neighbourhood and club them for a single checkout, so that everyone gets their food at a cheaper price. 

For example if a regular pizza costs 85 INR the person has to pay 30 INR as delivery charges (and maybe some money as surcharge) and also he cannot avail any discounts (which can be between 20%-50%; upto 100-120 INR) because his cart price is below the threshold. But if he orders 2 regular pizzas, the price per pizza comes down to 44.20 INR (incl of all taxes).

## Working
We prepare meal combinations out of the food items available at a particular restaurant, which minimizes the total cart price considering the offers available in real-time (to eliminate the user's dilemma of choice while ordering food). The order (or combo) can be hosted (for the people in their neighbourhood) in the "Host a Meal" section of the app, from where other users can claim the remaining items.

Suppose a person A wants to order a pizza from a particular outlet as stated in the above example. He can now 'host a meal' consisting of 2 pizzas (with one pizza left unclaimed) on the app at 1 PM and schedules the checkout at a particular time, say 2 PM. Now, some person B opens the app to see all hosted meals and finds the one created by A. Then, B claims the remaining pizza (which he now can get at appx 44 INR instead of the retail price of 85 INR) and makes a payment through the app. A gets a notification when all the items on his order have been claimed and are ready for checkout or when his scheduled time has come (whichever is earlier). A orders the food for both of them from Swiggy and pays for the whole order. A and B will meet at the delivery location, take their orders and B will mark the order delivered on Gromnom resulting in the staged payment being sent out to A. Thus completing the transaction and terminating the chat group.

## Developed By
- [Vivek Nigam](https://github.com/viveknigam3003)
- [Hemabh Ravee](https://github.com/hemabhravee)

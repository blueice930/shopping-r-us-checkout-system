# shopping-r-us-checkout-system
<<<<<<< Updated upstream
A simple yet robust and customizable checkout system built for Shopping-r-us computer store.
=======
A simple yet robust and customizable checkout system `CLI` built for Shopping-r-us computer store.

### Environment🌞:
> ##### Terminal with ruby 2.7

### Start the engine🚗:💨💨💨
> git clone / download this project into your device,
> At root directory, enter `ruby main.rb` in terminal.
* Follow instructions after running the program: 
  ```
  'scan / s' to scan products
  'price / p' to list the price
  'discount / d' to list the rules
  'quit / q' to exit the program...
  ```

### Data Editing🔧
* `env.json` file contains the relative path to other files.
* Under `data` folder, `price_list.json` is a given example for all items and their prices in the store. You can modify it with your own data.
* `discount.json` is a given example for discount rules in the store. The structure looks like: 
```json
    [
      {
        "item": "atv",
        "discount_type": "XFORY",
        "detail": {
          "trigger_amount": 3,
          "discount_amount": 1
        }
      },
      {
        "item": "ipd",
        "discount_type": "SUBTRACT_PRICE",
        "detail": {
          "trigger_amount": 5,
          "discount_amount": 50
        }
      },
      {
        "item": "mbp",
        "discount_type": "BUNDLE",
        "detail": {
          "trigger_amount": 1,
          "discount_amount": 1,
          "addon": "vga"
        }
      }
    ]
  ```
  * `item`: specifies the item name (MUST be included when configuring item prices)
  * `discount_type`: includes 3 possible type of discount: `XFORY`, `SUBTRACT_PRICE`, and `BUNDLE`. (More discount type may be added in the future)
  * `detail`: the discount detail and conditions, including `trigger_amount` (The amount of `item` to satisfy the discount), and `discount_amount` (The amount of discount to be deducted later, unit is not unified.). For `BUNDLE` type discount, `addon` specifies the item to be given away freely (In `BUNDLE`, `discount_amount` means the number of `addon` -> free gift )

### Testing🤖️

>>>>>>> Stashed changes

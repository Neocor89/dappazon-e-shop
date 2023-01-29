// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Dappazon {
  address public owner;

  // Step 2  
  //Create the Struct Item for list of Items
  struct Item {
    uint256 id;
    string name; 
    string category; 
    string image; 
    uint256 cost; 
    uint256 rating; 
    uint256 stock;
  }

  // Step1 -> Create Struct for Order
  struct Order {
    uint256 time;
    Item item;
    //: Item item = struct Item nested
  }


 /*
  + Mapping 
  Manage Blockchain also Database
  Reference for unique "Key" -> "value" per
  Mapping save Item in Blockchain
  Each item save with unique key
  Public saving, named items   */

  mapping(uint256 => Item) public items;
  //: mapping("Key" = dataType of Key => "value" = Struct Item

  mapping (address => uint256) public orderCount;
  //: address = key of user create Order
  //: uint256 = number Order receive

  mapping (address => mapping(uint256 => Order)) public orders;
  //: mapping for quantity products of the individual Order

  event Buy(address buyer, uint256 orderId, uint256 itemId);
  // Event Step 1 Define the "event" with tracked values
  event List(string name, uint256 cost, uint256 quantity);


  //! WARNING FOR POTENTIAL ERROR "QUANTITY" IN THIS LINE  🚨


  // Modifier Step 1 -> Define
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  constructor() {
    owner = msg.sender;
  }


  // Step 1  
  // Define List of Items with Datatypes

  function list(
  //: dataType _name || dataType visibility _name
    uint256 _id, 
    string memory _name, 
    string memory _category, 
    string memory _image, 
    uint256 _cost, 
    uint256 _rating, 
    uint256 _stock
  ) public onlyOwner {
    // Modifier Step 2 -> Apply to the function


    // Step 3  
    // Create Item Struct
    Item memory item = Item(_id, _name, _category, _image, _cost, _rating,_stock);
    //: Item = Item struct 
    //: memory = location of provide this information
    //: item = Assign and Ceate a new variable
    //: Item() = Create a new Item struct 


    // Step 4 
    // Save Item Struct on the Blockchain
    items[_id] = item;


    // Emit EVENT on Blockchain
    emit List(_name, _cost, _stock);
    /*
    : In Solidity is better emit event in a Function
    : Using "event" Keyword  
    : More tracability = when the function is called on a Blockchain
    : It's possible to recive an alert  
    */
   
  }


  // Buy Products
  function buy(uint256 _id) public payable {
    // Fetch Item
    Item memory item = items[_id];

    // Step2 -> Create Order Struct
    Order memory order = Order(block.timestamp, item);

    //: Add an Order for User
    orderCount[msg.sender]++;
    orders[msg.sender][orderCount[msg.sender]] = order;

    // Substrack item stock
    items[_id].stock = item.stock -1;

    // Emit Event
    emit Buy(msg.sender, orderCount[msg.sender], item.id);

  }

  //: WithDraw funds

  


}

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


 /*
  + Mapping 
  Manage Blockchain also Database
  Reference for unique "Key" -> "value" per
  Mapping save Item in Blockchain
  Each item save with unique key
  Public saving, named items   */

  mapping(uint256 => Item) public items;
  //: mapping("Key" = dataType of Key => "value" = Struct Item

  // Event Step 1 Define the "event" with tracked values
  //! WARNING FOR POTENTIAL ERROR "QUANTITY" IN THIS LINE  🚨
  event List(string name, uint256 cost, uint256 quantity);


  // Modifier Step 1 Define
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
   //: Check condition and return true or false
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
    // Modifier Step 2 Apply to the function

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
    // Receive Crypto

    // Create Order

  }

  //: WithDraw funds

  


}

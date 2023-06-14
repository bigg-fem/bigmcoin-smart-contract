//  BigMcoins ICO

// version of compiler
 pragma solidity ^0.4.2;

 contract BigMcoins {

   //introducing the maximum amount of bigmcoin
   uint public max_bigmcoins = 10000000;

   //introducing the usd to bigmcoin conversion rate
   uint public usd_to_bigmcoins = 100;

   //introducing the ampount of coins bought by investors 
   uint public total_bigmcoins_bought = 0;

   //mapping the investors address to its equity in bigmcoins and usd
   mapping(address => uint) equity_bigmcoins;
   mapping(address => uint) equity_usd;

   //checking if an investor can buy bigmcoin
   modifier can_buy_bigmcoins(uint usd_invested)  {
       require (usd_invested * usd_invested + total_bigmcoins_bought <= max_bigmcoins);
       _;
   }
   // getting the equity in bigmcoins of an investor 
   function equity_in_bigmcoins(address investor) external constant returns (uint) {
   return equity_bigmcoins[investor];
   }

   // getting the equity in usd of an investor 
   function equity_in_usd(address investor) external constant returns(uint) {
   return equity_usd[investor];
   }

   //buying bigmcoin
   function buy_bigmcoins(address investor, uint usd_invested) external
   can_buy_bigmcoins(usd_invested) {
     uint bigmcoins_bought = usd_invested * usd_to_bigmcoins;
     equity_bigmcoins[investor] += bigmcoins_bought;
     equity_usd[investor] = equity_bigmcoins[investor] / 100;
     total_bigmcoins_bought += bigmcoins_bought;
   }
 
   //selling bigmcoin
   function sell_bigmcoins(address investor, uint bigmcoins_sold) external {
     equity_bigmcoins[investor] -= bigmcoins_sold;
     equity_usd[investor] = equity_bigmcoins[investor] / 100;
     total_bigmcoins_bought -= bigmcoins_sold;
   }
 }


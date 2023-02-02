// Hadcoins ICO
// Version 1.0.0
pragma solidity ^0.8.17;

contract hadcoin_ico {
    // introducing the maximum number of hadcoins available for sale
    uint256 public max_hadcoins = 1000000;

    // introducing the USD to hadcoins conversion rate
    uint256 public usd_to_hadcoins = 1000;

    // introducing the total number of hadcoins that have been bought by the investors
    uint256 public total_hadcoins_bought = 0;

    // mapping from the investor address to its equity in hadcoins and usd_to_hadcoins
    mapping(address => uint256) equity_hadcoins;
    mapping(address => uint256) equity_usd;

    // checking if an investor can buy hadcoins
    modifier can_buy_hadcoins(uint256 usd_invested) {
        require(
            usd_invested * usd_to_hadcoins + total_hadcoins_bought <=
                max_hadcoins
        );
        _;
    }

    // getting the equity in hadcoins of an investor
    function equity_in_hadcoins(address investor)
        external
        view
        returns (uint256)
    {
        return equity_hadcoins[investor];
    }

    // getting the equity in usd of an investor
    function equity_in_usd(address investor) external view returns (uint256) {
        return equity_usd[investor];
    }

    // buying hadcoins
    function buy_hadcoins(address investor, uint256 usd_invested)
        external
        can_buy_hadcoins(usd_invested)
    {
        uint256 hadcoins_bought = usd_invested * usd_to_hadcoins;
        equity_hadcoins[investor] += hadcoins_bought;
        equity_usd[investor] = equity_hadcoins[investor] / 1000;
        total_hadcoins_bought += hadcoins_bought;
    }

    // selling hadcoins
    function sell_hadcoins(address investor, uint256 hadcoins_sold) external {
        equity_hadcoins[investor] -= hadcoins_sold;
        equity_usd[investor] = equity_hadcoins[investor] / 1000;
        total_hadcoins_bought -= hadcoins_sold;
    }
}

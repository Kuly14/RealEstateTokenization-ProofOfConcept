# Real Estate Tokenization Project Concept

In this project I tried to create a set of smart contracts that will tokenize any real estate. Then that property will be 
listed on airbnb by a third party which will send the profits from the airbnb to the smart contract. Then the smart contract will distrubute the rewards based on how much tokens or Squared Meters does the owner own.


## Outline

The company that will be managing the property will call the `createToken()` function inside of RETokenFactory.sol. This function will create a REToken.sol for that specific property. And it will credit the company with all the tokens which are equal to square meters.

So let's say there is a property that has 150 meters squared. The company will be credited 150 tokens of that property. They can then sell the tokens. 

After every month the company will send the profits for that month into that contract in ETH. 

Then they will call the `distributeRewards()` function which will distribute the rewards based on how much squared meters do you own.

**This contract is just proof of concept it is not meant to be used in production!**


### RETokenFactory.sol

This is the factory contract it will deploy a new REToken contract for each property. It also stores all the data.


### REToken.sol

This is the contract that will be used by the managment company. To this contract the management company will send the profits and this contrac will distribute them.


## Problems

Even though I think tokenization of real life things will be the future there are still many problems with this approach in this day and age.

There is no real way to make it totally decentralized. Even though in this concept we woulnd't want to decentralize it since we need somebody to take care of that property but I think We could come up with some cool protocol so that anybody will be able to manage that property.

Here are the biggest problems I think this approach has: 

1. Verifying the ownership of the property.

    The biggest problem with this approach in my opinion is that there is no real good way to verify the ownership of the property. If some malicious party created a token for property they don't own how would we know. Every solution I could think of introduce total centrality in which case blockchain is totally unecessary.

2. Authorities don't recognize owning tokens as owning the real estate. 

    Because authorities don't recognize owning tokens proof of ownership. The buyer and the seller would have to go through the tedious process of selling the property in real life. Which means that buying it on blockchain doesn't solve anything.


## Conclusion

The world as of now isn't ready to use this kind of tech in legacy systems if we can call it that. BUT If this gets resolved tokenization will bring a lot of cool features that will make our everyday life easier! 

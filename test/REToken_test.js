const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("REToken", function () {

  let REToken;
  let token;
  let owner;
  let owner2;

  before(async function () {
    [owner, owner2, ...addr] = await ethers.getSigners();
    REToken = await ethers.getContractFactory("REToken");
    token = await REToken.deploy(
      owner.address,
      "Property",
      "Cabanova 15, Bratislava",
      "Great Property",
      150,
      3,
      2,
      "ipfs://property.com"
    );

    await token.connect(owner).transfer(owner2.address, ethers.utils.parseEther("50"));


  })

  describe("RETokenTests", function () {
    
    it("Should check if deployed correctly", async function () {

      expect(await token.nameOfProperty()).to.equal("Property");
      expect(await token.propertyAddress()).to.equal("Cabanova 15, Bratislava");
      expect(await token.propertyDescription()).to.equal("Great Property");
      expect(await token.sqMeters()).to.equal(150);
      expect(await token.bedrooms()).to.equal(3);
      expect(await token.bathrooms()).to.equal(2);
      expect(await token.uri()).to.equal("ipfs://property.com");
      expect(await token.balanceOf(owner2.address)).to.equal(ethers.utils.parseEther("50"));
    
    });

    it("Should check if the math is correct", async function () {

      const txHash = await owner.sendTransaction({
        to: token.address,
        value: ethers.utils.parseEther("1.0")
      });

      await token.connect(owner).distributeTokens();
      
      // There is a small amount of eth left but it is just a few cents
      expect(await token.showBal()).to.be.lt(ethers.utils.parseEther("0.0002"))


      
    });
  });
});

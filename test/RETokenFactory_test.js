const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("RETokenFactroy", function () {
    let REFactory;
    let factory;
    let owner;
    let owner2;

    before(async function () {
        [owner, owner2, ...addrs] = await ethers.getSigners();
        REFactory = await ethers.getContractFactory("RETokenFactory");
        factory = await REFactory.deploy();
        await factory.deployed();
    })

    describe("RETokenFactory Tests", function () {
        it("Should check if deployed correctly", async function () {

            await factory.createToken(
                owner.address,
                "Property",
                "Cabanova 15, Bratislava",
                "Great Property",
                150,
                3,
                2,
                "ipfs://property.com"
            );

            const addressOfContract = await factory.addressOfPropertyToken("Cabanova 15, Bratislava");

            const token = await (await ethers.getContractFactory("REToken")).attach(addressOfContract);
            

            expect(await token.nameOfProperty()).to.equal("Property");
            expect(await token.propertyAddress()).to.equal("Cabanova 15, Bratislava");
            expect(await token.propertyDescription()).to.equal("Great Property");
            expect(await token.sqMeters()).to.equal(150);
            expect(await token.bedrooms()).to.equal(3);
            expect(await token.bathrooms()).to.equal(2);
            expect(await token.uri()).to.equal("ipfs://property.com");
            expect(await token.balanceOf(owner.address)).to.equal(ethers.utils.parseEther("150"));
            expect(await token.balanceOf(owner2.address)).to.equal(0);
        });
    });
});
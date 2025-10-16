const { loadFixture,} = require("@nomicfoundation/hardhat-toolbox/network-helpers");

const { expect } = require("chai") ;
const { ethers } = require("hardhat");


describe("SimpleBank", function() {
    async function deploySimpleBankFixture() {
        const [owner, addr1, addr2] = await ethers.getSigners();

        const SimpleBank = await ethers.getContractFactory("SimpleBank");
        const simpleBank = await SimpleBank.deploy();

        return {simpleBank, owner, addr1, addr2};
    }

describe("Deployment", function() {
    it("Should set the right owner", async function() {
        const { simpleBank, owner} = await loadFixture(deploySimpleBankFixture);

        expect(await simpleBank.owner()).to.equal(owner.address)
    });

    it("Should initialize totalDeposit to 0", async function() {
        const { simpleBank } = await loadFixture(deploySimpleBankFixture);
        expect(await simpleBank.totalDeposits()).to.equal(0);
    });

    it("Should have zero contract balance at the start", async function() {
        const {simpleBank } = await loadFixture(deploySimpleBankFixture);
        expect(await simpleBank.getContractBalance()).to.equal(0);
    });

})
})

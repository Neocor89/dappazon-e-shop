const hre = require("hardhat");
const { items } = require("../src/items.json");

const tokens = (n) => {
  return ethers.utils.parseUnits(n.toString(), "ether");
};

async function main() {
  const [deployer] = await ethers.getSigners();

  //: Deploy Dappazon Contract
  const Dappazon = await hre.ethers.getContractFactory("Dappazon");
  const dappazon = await Dappazon.deploy();
  await dappazon.deployed();

  console.log(`Deployed Dappazon Contract at : ${dappazon.address}\n`);

  //: List items
  for (let i = 0; i < items.length; i++) {
    const transaction = await dappazon
      .connect(deployer)
      .list(
        items[i].id,
        items[i].name,
        items[i].category,
        items[i].image,
        tokens(items[i].price),
        items[i].rating,
        items[i].stock
      );

    await transaction.wait();

    console.log(`Listed item ${items[i].id}: ${items[i].name}`);
  }
}

//! check RESTART PROCESS 🚀
/*
 TODO
+ 1. Run -> npx hardhat node
+ 2. Connect Metamask wallet
+ 3. Start front end creation
*/

// Recommended pattern to be able to use async/await everywhere
// and manage properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

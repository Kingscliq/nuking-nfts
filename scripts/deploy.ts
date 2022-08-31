import { ethers } from "hardhat";
const main = async () => {
  const nftContractFactory = await ethers.getContractFactory('MyEpicNFT');
  const nftContract = await nftContractFactory.deploy();
  await nftContract.deployed();
  console.log("Contract deployed to:", nftContract.address);


  // Call the function.
  let txn = await nftContract.makeAnEpicNFT()
  // Wait for it to be mined.
  await txn.wait()
  console.log("Hey I just Minted My Epic NFT Minted NFT #6")

  // // Mint another NFT for fun.
  // txn = await nftContract.makeAnEpicNFT()
  // // Wait for it to be mined.
  // await txn.wait()
  // console.log("Minted NFT #2")
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();

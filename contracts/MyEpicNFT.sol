// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// We first import some OpenZeppelin Contracts.
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

// import { Base64 } from "./libraries/Base64.sol";
// We inherit the contract we imported. This means we'll have access
// to the inherited contract's methods.
contract MyEpicNFT is ERC721URIStorage {
  // Magic given to us by OpenZeppelin to help us keep track of tokenIds.
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;


 // We split the SVG at the part where it asks for the background color.
  string svgPartOne = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='";
  string svgPartTwo = "'/><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";
  // We need to pass the name of our NFTs token and its symbol.
  constructor() ERC721 ("SquareNFT", "SQUARE") {
    console.log("This is my first NFT contract. Super Excited Woah!");
  }

 // This is our SVG code. All we need to change is the word that's displayed. Everything else stays the same.
  // So, we make a baseSvg variable here that all our NFTs can use.
  string baseSvg = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";
  // A function our user will hit to get their NFT.


  // I create three arrays, each with their own theme of random words.
  // Pick some random funny words, names of anime characters, foods you like, whatever! 
  // string[] firstWords = ["YOUR_WORD", "YOUR_WORD", "YOUR_WORD", "YOUR_WORD", "YOUR_WORD", "YOUR_WORD"];
  // string[] secondWords = ["YOUR_WORD", "YOUR_WORD", "YOUR_WORD", "YOUR_WORD", "YOUR_WORD", "YOUR_WORD"];
  // string[] thirdWords = ["YOUR_WORD", "YOUR_WORD", "YOUR_WORD", "YOUR_WORD", "YOUR_WORD", "YOUR_WORD"];


// Random Words for the NFTs

string[] firstWords = ["onyxis", "nemoricolous", "tourbillon", "gyrose", "mainsail", "teleseism", "incorporate", "burn", "allege", "come"];
string[] secondWords = ["venigenous", "herm", "deprive", "advertise", "enjoy", "stimulate", "telephone", "occur", "include", "recall", "destroy"];
string[] thirdWords = ["spell", "continue", "perceive", "represent", "accommodate", "paint", "choose", "tap", "measure", "propose", "sack", "dance"];

// Get fancy with it! Declare a bunch of colors.
string[] colors = ["red", "#08C2A8", "black", "yellow", "blue", "green"];

event NewEpicNFTMinted(address sender, uint256 tokenId);
 // I create a function to randomly pick a word from each array.
  function pickRandomFirstWord(uint256 tokenId) public view returns (string memory) {
    // I seed the random generator. More on this in the lesson. 
    uint256 rand = random(string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId))));
    // Squash the # between 0 and the length of the array to avoid going out of bounds.
    rand = rand % firstWords.length;
    return firstWords[rand];
  }

  function pickRandomSecondWord(uint256 tokenId) public view returns (string memory) {
    uint256 rand = random(string(abi.encodePacked("SECOND_WORD", Strings.toString(tokenId))));
    rand = rand % secondWords.length;
    return secondWords[rand];
  }

  function pickRandomThirdWord(uint256 tokenId) public view returns (string memory) {
    uint256 rand = random(string(abi.encodePacked("THIRD_WORD", Strings.toString(tokenId))));
    rand = rand % thirdWords.length;
    return thirdWords[rand];
  }


// Same old stuff, pick a random color.
  function pickRandomColor(uint256 tokenId) public view returns (string memory) {
    uint256 rand = random(string(abi.encodePacked("COLOR", Strings.toString(tokenId))));
    rand = rand % colors.length;
    return colors[rand];
  }

  function random(string memory input) internal pure returns (uint256) {
      return uint256(keccak256(abi.encodePacked(input)));
  }

  function makeAnEpicNFT() public returns(uint256) {
     // Get the current tokenId, this starts at 0.
    uint256 newItemId = _tokenIds.current();

 // We go and randomly grab one word from each of the three arrays.
    string memory first = pickRandomFirstWord(newItemId);
    string memory second = pickRandomSecondWord(newItemId);
    string memory third = pickRandomThirdWord(newItemId);
    string memory combinedWord = string(abi.encodePacked(first, second, third));
 // Add the random color in.
    string memory randomColor = pickRandomColor(newItemId);

// I concatenate it all together, and then close the <text> and <svg> tags.
     string memory finalSvg = string(abi.encodePacked(svgPartOne, randomColor, svgPartTwo, combinedWord, "</text></svg>"));
    console.log("\n--------------------");
    console.log(finalSvg);
    console.log("--------------------\n");


    // string memory json = Base64.encode(
    //     bytes(
    //         string(
    //             abi.encodePacked(
    //                 '{"name": "',
    //                 combinedWord,
    //                 '", "description": "A highly acclaimed collection of squares.", "image": "data:image/svg+xml;base64,',
    //                 Base64.encode(bytes(finalSvg)),
    //                 '"}'
    //             )
    //         )
    //     )
    // );

    // string memory finalTokenUri = string(
    //     abi.encodePacked("data:application/json;base64,", json)
    // );

// Actually mint the NFT to the sender using msg.sender.
    _safeMint(msg.sender, newItemId);

// Set the NFTs data.
    _setTokenURI(newItemId, "data:application/json;base64, ewogICAgIm5hbWUiOiAiRXBpY0xvcmRIYW1idXJnZXIiLAogICAgImRlc2NyaXB0aW9uIjogIkFuIE5GVCBmcm9tIHRoZSBoaWdobHkgYWNjbGFpbWVkIHNxdWFyZSBjb2xsZWN0aW9uIiwKICAgICJpbWFnZSI6ICJkYXRhOmltYWdlL3N2Zyt4bWw7YmFzZTY0LGRhdGE6aW1hZ2Uvc3ZnK3htbDtiYXNlNjQsUEhOMlp5QjRiV3h1Y3owaWFIUjBjRG92TDNkM2R5NTNNeTV2Y21jdk1qQXdNQzl6ZG1jaUlIQnlaWE5sY25abFFYTndaV04wVW1GMGFXODlJbmhOYVc1WlRXbHVJRzFsWlhRaUlIWnBaWGRDYjNnOUlqQWdNQ0F6TlRBZ016VXdJajRLSUNBZ0lEeHpkSGxzWlQ0dVltRnpaU0I3SUdacGJHdzZJSGRvYVhSbE95Qm1iMjUwTFdaaGJXbHNlVG9nYzJWeWFXWTdJR1p2Ym5RdGMybDZaVG9nTVRSd2VEc2dmVHd2YzNSNWJHVStDaUFnSUNBOGNtVmpkQ0IzYVdSMGFEMGlNVEF3SlNJZ2FHVnBaMmgwUFNJeE1EQWxJaUJtYVd4c1BTSmliR0ZqYXlJZ0x6NEtJQ0FnSUR4MFpYaDBJSGc5SWpVd0pTSWdlVDBpTlRBbElpQmpiR0Z6Y3owaVltRnpaU0lnWkc5dGFXNWhiblF0WW1GelpXeHBibVU5SW0xcFpHUnNaU0lnZEdWNGRDMWhibU5vYjNJOUltMXBaR1JzWlNJK1JYQnBZMHh2Y21SSVlXMWlkWEpuWlhJOEwzUmxlSFErQ2p3dmMzWm5QZz09Igp9");
    console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);
// Increment the counter for when the next NFT is minted.
    _tokenIds.increment();



    emit NewEpicNFTMinted(msg.sender, newItemId);

   return newItemId;
  }
   
}



// 
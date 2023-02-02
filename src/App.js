import { useEffect, useState } from "react";
import { ethers } from "ethers";

// Components
import Navigation from "./components/Navigation";
import Section from "./components/Section";
import Product from "./components/Product";

// ABIs
import Dappazon from "./abis/Dappazon.json";

// Config
import config from "./config.json";

function App() {
  //: useState return an Array
  const [account, setAccount] = useState(null);
  const [provider, setProvider] = useState(null);

  const loadBlockChainData = async () => {
    //: Etherjs provider -> Transform App in Blockchain DApp
    //: Connect to the blockchain React App
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    setProvider(provider);

    const network = await provider.getNetwork();
    console.log(network);

    // Connect to SMart Contracts
    const dappazon = new ethers.Contract(
      "0x5FbDB2315678afecb367f032d93F642f64180aa3",
      Dappazon,
      provider
    );
    // Load Products
    // Fetch Products
  };

  useEffect(() => {
    loadBlockChainData();
  }, []);

  return (
    <div>
      <Navigation account={account} setAccount={setAccount} />
      <h2>Dapp azon</h2>
    </div>
  );
}

export default App;

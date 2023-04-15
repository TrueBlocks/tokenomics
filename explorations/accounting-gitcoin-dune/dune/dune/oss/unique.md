WITH
  grantees AS (
    SELECT
      title,
      address,
      status
    FROM
      (
        VALUES
          /**(
            'CashmereLabs',
            '\x95a807bcAb5a16901628acF90FC3057061a3fce9' :: bytea,
            'PENDING'
          ),
          
           (
           'Zk- Block | Tools for Zk & Web3 Dapps',
           '\xeEd99E93e073C092131C245C3fDa23781563d67D' :: bytea,
           'PENDING'
           ),
           */
            (
           'DeFi & Web3 Developer Roadmap',
           '\xB25C5E8fA1E53eEb9bE3421C59F6A66B786ED77A' :: bytea,
           'PENDING'
           ),
          (
            'web3swift',
            '\x6A3738c6299f45c31697aceA647D49EdCC9C28A4' :: bytea,
            'PENDING'
          ),
          /**
          (
            'Proof of Integrity',
            '\x75DeD588d2a4734D0a61B9953A3C4e6C6D00AbC4' :: bytea,
            'PENDING'
          ),*/
          (
            'Lenstube',
            '\x01d79BcEaEaaDfb8fD2F2f53005289CFcF483464' :: bytea,
            'PENDING'
          ),
          (
            'ECHO',
            '\xB67FD6f4B908d702c2CF0E2b9d30d52D4EA5B2bC' :: bytea,
            'PENDING'
          ),
          /**
           (
           'Know Your Degens Oracles - doing compliance the DeFi way 🫡',
           '\xced950CDd8D7Cc656a44D7C834a21A1A4239C491' :: bytea,
           'PENDING'
           ),
           */
          (
            'Chaineye',
            '\xE6D7b9Fb31B93E542f57c7B6bfa0a5a48EfC9D0f' :: bytea,
            'PENDING'
          ),/**
          (
            'Phi',
            '\x77D70A4df6436E1979986ecea54A95e3A0E21531' :: bytea,
            'PENDING'
          ),
          (
            'Maven Foundation ',
            '\x698CcCCB5947c54684e17545327A77b9103F1f7a' :: bytea,
            'PENDING'
          ),
          (
            'orb',
            '\x3394F31640dc15c1CC6259402fd774436a3e56aC' :: bytea,
            'PENDING'
          ),
          (
            'B4B WORLD',
            '\x62179dB9a70cB6005596c04e6faa8274DFa7B2D1' :: bytea,
            'PENDING'
          ),
          (
            'Spotify for WEB3',
            '\x1F51c8990234522b66A9A3D1B48552Ee0728493D' :: bytea,
            'PENDING'
          ),*/
          (
            'UBI',
            '\x1D6cB99ff20223d730Ae5D4680EC5154B7FdAefe' :: bytea,
            'PENDING'
          ),
          (
            'White Hat DAO',
            '\x7bD7De26eBD064465Bb9c272513Bb3bcBdDb1E93' :: bytea,
            'PENDING'
          ),
          (
            'devpill',
            '\xEee718c1e522ecB4b609265db7A83Ab48ea0B06f' :: bytea,
            'PENDING'
          ),/**
          (
            'Metopia',
            '\x8012B593917f74dD8C5233FD509B9a02d1bC7079' :: bytea,
            'PENDING'
          ),
          (
            'Officer''s Blog',
            '\xB25C5E8fA1E53eEb9bE3421C59F6A66B786ED77A' :: bytea,
            'PENDING'
          ),*/
          (
            'DefiLab.xyz',
            '\x9fe6764778db6AD5c5ED86242485d1a868a8c52A' :: bytea,
            'PENDING'
          ),/**
          (
            'Nflow',
            '\x619B75f4D55285741a24b047944FBdF27E49f9d1' :: bytea,
            'PENDING'
          ),*/
          (
            'Dweb Movement',
            '\x81Bbc5E83901CA95bb85e3D1916D04D434e7f2bD' :: bytea,
            'PENDING'
          ),
          (
            'Loanshark',
            '\x7D658841f8Ba93299970f6e765C2CE205f1E70DD' :: bytea,
            'PENDING'
          ),
          (
            'Optinames | ENS on Optimism',
            '\x1208a26FAa0F4AC65B42098419EB4dAA5e580AC6' :: bytea,
            'PENDING'
          ),/**
          (
            'Using ZK for game optimization in Dark Forest',
            '\xf0dBDe527c63B63178576578777f0b7E24755ABb' :: bytea,
            'PENDING'
          ),*/
          (
            'Jolly Roger',
            '\xF0D7a8198D75e10517f035CF11b928e9E2aB20f4' :: bytea,
            'PENDING'
          ),
          (
            '0xDeadList',
            '\x799B774204A348E1182fE01074C51444bA70A149' :: bytea,
            'PENDING'
          ),
          (
            'DefiLlama',
            '\x08a3c2A819E3de7ACa384c798269B3Ce1CD0e437' :: bytea,
            'PENDING'
          ),
          (
            'LexDAO',
            '\x5a741ab878Bb65f6AE5506455FB555eaf3094B3F' :: bytea,
            'PENDING'
          ),
          (
            'ITU Blockchain',
            '\xBEC643BD5b7F5e9190617CA4187ef0455950C51C' :: bytea,
            'PENDING'
          ),
          (
            'Jolocom',
            '\xF3CF346DB5DAb30d73d272499CBAe6E6C0eE2C60' :: bytea,
            'PENDING'
          ),
          (
            'Lume Web',
            '\x63cd2C691632720Ff2ABDD0b6AABA2466D3Fe468' :: bytea,
            'PENDING'
          ),
          (
            'Vocdoni',
            '\x74D8967e812de34702eCD3D453a44bf37440b10b' :: bytea,
            'PENDING'
          ),
          (
            'Web3 OSS Libraries by DePay',
            '\x4e260bB2b25EC6F3A59B478fCDe5eD5B8D783B02' :: bytea,
            'PENDING'
          ),
          (
            'WTF Academy',
            '\x25df6DA2f4e5C178DdFF45038378C0b08E0Bce54' :: bytea,
            'PENDING'
          ),
          /**
           (
           'Bundle: Climate Research Alpha Round',
           '\x29C40842a76B0aa28865EbF7c916ec820233b7bB' :: bytea,
           'PENDING'
           ),
          
          (
            'ENS DAO Newsletter',
            '\x4a903f36037da9dc1e1992bc7b8d511170000b07' :: bytea,
            'PENDING'
          ),
          (
            'EthereumCN ',
            '\xaf30B0285Bb41bdBB732E4a533874901E4943522' :: bytea,
            'PENDING'
          ), */
          (
            'eth.limo',
            '\xB352bB4E2A4f27683435f153A259f1B207218b1b' :: bytea,
            'PENDING'
          ),/**
          (
            '3 Box School',
            '\xDF6736104b732CF5d8Fd7f3a8Ef665c1a856649e' :: bytea,
            'PENDING'
          ),*/
          (
            'The Future of Work is Decentralized',
            '\x0406Bf2dAE6A42d567b4e3DbA6ADA99069622fF1' :: bytea,
            'PENDING'
          ),
          (
            'JediSwap',
            '\x18aa467E40E1deFB1956708830A343c1D01d3D7C' :: bytea,
            'PENDING'
          ),
          (
            'CirclesUBI',
            '\xd525fF26F45f3B7D20cfEf170E2cb9E601A0b4dA' :: bytea,
            'PENDING'
          ),
          (
            'word block',
            '\x65a0Af703047dfDd270361659d02f4f0E8547202' :: bytea,
            'PENDING'
          ),
          (
            'StarkDeFi',
            '\x9D100F017095e53b24d81296BcA1D26742f1800F' :: bytea,
            'PENDING'
          ),
          (
            'Malicious Contract Detector',
            '\xA3c2e3d65206deE0456416F8189de7CF4fccbB22' :: bytea,
            'PENDING'
          ),
          (
            'ENS Spoofing Bot',
            '\x7b736FE138775D1fCD2CFE4E1D6158BfF3a2F28e' :: bytea,
            'PENDING'
          ),
          (
            'Krebit',
            '\xd6eeF6A4ceB9270776d6b388cFaBA62f5Bc3357f' :: bytea,
            'PENDING'
          ),
          (
            'W3.work',
            '\x70B20209c83ec8D01e3c7F2ec77BDe7c40cDF2F6' :: bytea,
            'PENDING'
          ),
          (
            'Esteroids - a community .eth websites search engine',
            '\x71c7252Cc1AfC181704ff7fDED27486f5cCd9205' :: bytea,
            'PENDING'
          ),/**
          (
            'Surge Women',
            '\xD9A52b6506743cF5fAFf14C875cB443da9660e00' :: bytea,
            'PENDING'
          ),*/
          (
            'Fileverse - file sharing & collaboration between addresses',
            '\x4aF147188bfE1c02D18D752eD5E473d8394F2300' :: bytea,
            'PENDING'
          ),/**
          (
            'Share',
            '\x629e715dB365FdBac0a61330cbF256237dcCDcB9' :: bytea,
            'PENDING'
          ),*/
          (
            'The MoonMath Manual to zk-SNARKs',
            '\xA8A4912938549d50EF3E7c698C890E18D73408Ee' :: bytea,
            'PENDING'
          ),/**
          (
            'Forta Bots: Funding & Money Laundering Through Aztec Protocol',
            '\x7b736FE138775D1fCD2CFE4E1D6158BfF3a2F28e' :: bytea,
            'PENDING'
          ),*/
          (
            'Rings Network',
            '\xf7FeA1722F9b27B0666919A5664BaB486a4b18D3' :: bytea,
            'PENDING'
          ),
          (
            'Soul Wallet',
            '\xFe97E32a873AA2f926FBfc560AbEEf01f753C128' :: bytea,
            'PENDING'
          ),
          (
            'The Science Commons Initiative',
            '\x3EcB9640ea6cC9bd9D5040713F854634Fd0FCf8a' :: bytea,
            'PENDING'
          ),/**
          (
            'GalaxChat',
            '\xC99C2204297b15cdDE4B0A08b62bEcF4f10DC6dD' :: bytea,
            'PENDING'
          ),*/
          (
            'Kredeum NFTs Factory',
            '\xBC0b437C95c7165F7d1F7C966cb2227DA52a27d7' :: bytea,
            'PENDING'
          ),
          (
            'Scam Sniffer',
            '\x79A9c3aEE79793c2873E6686C22EBf2311778C19' :: bytea,
            'PENDING'
          ),/**
          (
            'zkApe - Newsletter about zero knowledge technology',
            '\xa053473DDa59994682F8e96990ffc36aa982782b' :: bytea,
            'PENDING'
          ),
          
           (
           'Crypto OpSec SelfGuard RoadMap',
           '\xB25C5E8fA1E53eEb9bE3421C59F6A66B786ED77A' :: bytea,
           'PENDING'
           ),
           */
          (
            'Proof of Humanity',
            '\x2AF4125c8fE208a349ef78d3cb980308ab1Ed34f' :: bytea,
            'PENDING'
          ),/**
          (
            'VestLab - analytics service that is a collection of information about tokenomics, metrics, timing of upcoming listing and vesting crypto tokens',
            '\x3e331a358421Ebe3Dc2fEf05449Ec89667E430B9' :: bytea,
            'PENDING'
          ),*/
          (
            'Lighthouse',
            '\x29b1d432a40f40F5418DA2d4ABf740e5E491629B' :: bytea,
            'PENDING'
          ),/**
          (
            'Forta Agent: Money Laundering Detector for Umbra Protocol.',
            '\x7F2436d628137A1a4f07631b1E09e37455f4aDAe' :: bytea,
            'PENDING'
          ),*/
          (
            'zkREPL',
            '\x5B3920527cfe207100312f4685E048ee032Fa391' :: bytea,
            'PENDING'
          ),
          (
            'Dapp-Learning',
            '\x35C6d9117F66943C881E8354138434b8a0727988' :: bytea,
            'PENDING'
          ),
          (
            'Web3MQ',
            '\xA126F99e0DEFc3bFa963064314c4b1D54c872DCc' :: bytea,
            'PENDING'
          ),
          (
            'Voting Contracts',
            '\x5514f4a2BC7194664B12A48E238876Aa53140350' :: bytea,
            'PENDING'
          ),
          (
            'Seedle',
            '\x5c34386552091744717b1c0154b9d48d35f5f435' :: bytea,
            'PENDING'
          ),
          (
            'Umbra',
            '\x57EA12A3A8E441f5FE7B1F3Af1121097b7d3B6A8' :: bytea,
            'PENDING'
          ),
          (
            'Friends of Pooly',
            '\xC876bEC4e02EACc92df0F7b6EEee90c2aD794E50' :: bytea,
            'PENDING'
          ),
          (
            'Starksheet',
            '\x7A0857D314f62d383341b4ED8FE380e7C98Fb978' :: bytea,
            'PENDING'
          ),
          (
            'minipent by pentacle',
            '\x8EFEF51d19EF3844C00076ab9d02847B9C70f94A' :: bytea,
            'PENDING'
          ),/**
          (
            'Orgassign',
            '\xCD9165FF26Ac50ec9bc3207B9d53Bc70998C6b64' :: bytea,
            'PENDING'
          ),*/
          (
            'Rouge Ticket',
            '\xEb439EED5642641968f9D8b52F2788e0F19B443B' :: bytea,
            'PENDING'
          ),
          (
            '1Hive Gardens',
            '\x1B8C7f06F537711A7CAf6770051A43B4F3E69A7e' :: bytea,
            'PENDING'
          ),
          /**
           (
           'L2 Planet',
           '\x2D9d84F4D8a4254ea23Fe18825193Cbd1b21b749' :: bytea,
           'PENDING'
           ),
           */
          (
            'Punk Domains - Modular Web3 Names Protocol',
            '\x12e838f846ffdade34b2e006f84117a370d71687' :: bytea,
            'PENDING'
          ),
          (
            'ETH Leaderboard',
            '\xD0AeA65bb96b823cb30724ee0a6B7588c77dE486' :: bytea,
            'PENDING'
          ),
          (
            'Geo Web',
            '\xDE798cD9C53F4806B9Cc7dD27aDf7c641540167c' :: bytea,
            'PENDING'
          ),/**
          (
            'Impersonator',
            '\xD3b90AfCAcCF0A6913f47761894b2b03f212Fb6a' :: bytea,
            'PENDING'
          ),*/
          (
            'Tally Ho! - Open Source and Community Owned Wallet',
            '\x99b36fDbC582D113aF36A21EBa06BFEAb7b9bE12' :: bytea,
            'PENDING'
          ),/**
          (
            'CounterAgent Art',
            '\xbe7A9D0ee2F1c7F6e44Ea922e52603e921566778' :: bytea,
            'PENDING'
          ),*/
          (
            'IDriss - A more usable web3 for everyone 💚',
            '\x531Eb60b2dDE9a841BA358EE033533AAF90D1feA' :: bytea,
            'PENDING'
          ),/**
          (
            'DeFi & Web3 Developer Roadmap',
            '\xB25C5E8fA1E53eEb9bE3421C59F6A66B786ED77A' :: bytea,
            'PENDING'
          ),
          (
            'Spect',
            '\x55B23ed53Fe13060183b92979c737A8eF9A73b73' :: bytea,
            'PENDING'
          ),*/
          (
            'Giveth',
            '\x4D9339dd97db55e3B9bCBE65dE39fF9c04d1C2cd' :: bytea,
            'PENDING'
          ),
          (
            'LunCo: accelerating Lunar Colonization with opensource',
            '\xA64f2228cceC96076c82abb903021C33859082F8' :: bytea,
            'PENDING'
          ),
          (
            'Blaine Bublitz - ETH/ZK Infrastructure & Ecosystem developer',
            '\x0E4d2ec48f03a9eD9068EeA2926dE34b6AB8646b' :: bytea,
            'PENDING'
          ),/**
          (
            'Contracts bots gang',
            '\x715aCC4a912f979279b9B3d3a46A3cF1e006C033' :: bytea,
            'PENDING'
          ),
          (
            'Open Source AI Podcast',
            '\xFBE7a5a6B823B514aE952D51820940D286EB3Ef1' :: bytea,
            'PENDING'
          ),*/
          (
            'Vyper Smart Contract Language',
            '\x70CCBE10F980d80b7eBaab7D2E3A73e87D67B775' :: bytea,
            'PENDING'
          ),
          (
            'Lenster',
            '\x3A5bd1E37b099aE3386D13947b6a90d97675e5e3' :: bytea,
            'PENDING'
          ),/**
          (
            'SheFi',
            '\x0414189c6eb456b4d62f8CC69bC7Ebdc93C94f0E' :: bytea,
            'PENDING'
          ),*/
          (
            'IDENA',
            '\x8917418aBe36E6E788068E96EF5A47d7484C06b1' :: bytea,
            'PENDING'
          ),
          (
            'ZeroPool',
            '\x947F8A49640B4770A8c7fE3C1E69FfC974295448' :: bytea,
            'PENDING'
          ),/**
          (
            'Dark Sea marketplace in Dark Forest',
            '\x895F63111B97c7Ad0D620f8610Dd360a9c567F31' :: bytea,
            'PENDING'
          ),*/
          (
            'vfat.tools',
            '\xeF0Ca09fbf9a5f61E657Fb208b46b8685c1d4766' :: bytea,
            'PENDING'
          ),
          (
            'Spect',
            '\x55B23ed53Fe13060183b92979c737A8eF9A73b73' :: bytea,
            'PENDING'
          ),
          (
            'BanklessDAO Projects',
            '\xf26d1Bb347a59F6C283C53156519cC1B1ABacA51' :: bytea,
            'PENDING'
          ),
          (
            'Pepemon: Degen Battleground',
            '\xB614B1464c561EB2fD0d7d3475feB52B5a34dEc0' :: bytea,
            'PENDING'
          ),
          (
            'CryptoStats',
            '\x69aa21403244889832609963B0028e337a834953' :: bytea,
            'PENDING'
          ),
          (
            'POAPin',
            '\x5Afc7720b161788f9D833555b7EbC3274FD98Da1' :: bytea,
            'PENDING'
          ),
          (
            'Relay',
            '\x0cb27e883E207905AD2A94F9B6eF0C7A99223C37' :: bytea,
            'PENDING'
          ),
          (
            'Gitcoin China Ecosystem Development',
            '\x521aacB43d89E1b8FFD64d9eF76B0a1074dEdaF8' :: bytea,
            'PENDING'
          ),
          (
            'Faster API for resolving ENS names and avatars for web3 projects',
            '\xC9C022FCFebE730710aE93CA9247c5Ec9d9236d0' :: bytea,
            'PENDING'
          ),/**
          (
            'Uncloak Cryptography',
            '\xaE72f891Fc9914b13a90cbED799ee73359077bee' :: bytea,
            'PENDING'
          ),*/
          (
            'ETHRank - The open source achievement system for every Ethereum address',
            '\x0D538d6253Eb5CeBaEf94a873a7d3DF22D6F936c' :: bytea,
            'PENDING'
          ),
          (
            'Inverter Network - Fund and build in web 3 with ease',
            '\x10666d9c6295E838d3b8B84ffcC97d62EF7e6120' :: bytea,
            'PENDING'
          ),
          (
            'Zero Knowledge Podcast',
            '\x0b0E6486648FBBb8E9ab33e3ae9D0B44B6faa701' :: bytea,
            'PENDING'
          ),
          (
            'datalatte',
            '\x690315449eFad5f8B06a356f16eecFC41F475F70' :: bytea,
            'PENDING'
          ),
          (
            'Electronic Frontier Foundation',
            '\x640C28441f9e73537C63576A0D6f44643a577E32' :: bytea,
            'PENDING'
          ),
          (
            'Nimi.eth',
            '\xdE81d67Af572EC0F22841da702C1EdC25608dBBB' :: bytea,
            'PENDING'
          ),
          /**
           (
           'Ape Framework',
           '\x187089b65520D2208aB93FB471C4970c29eAf929' :: bytea,
           'PENDING'
           ),
           */
          (
            'Commons Stack',
            '\x8110d1D04ac316fdCACe8f24fD60C86b810AB15A' :: bytea,
            'PENDING'
          ),
          (
            'MintBot | Polygon NFT Minter + ENS SubDomains (no gas)',
            '\x1208a26FAa0F4AC65B42098419EB4dAA5e580AC6' :: bytea,
            'PENDING'
          ),
          (
            'BrightID 🔆 Universal Proof of Uniqueness',
            '\x4B8810b079eb22ecF2D1f75E08E0AbbD6fD87dbF' :: bytea,
            'PENDING'
          ),
          (
            'Revoke.cash - Helping you stay safe in web3',
            '\xe126b3E5d052f1F575828f61fEBA4f4f2603652a' :: bytea,
            'PENDING'
          ),/**
          (
            'PoolTogether',
            '\x3927E0642C432A934a4EAA64C79bC8a1D8ac5Fb7' :: bytea,
            'PENDING'
          ),*/
          (
            'MetaMail',
            '\x3806a85D9b8E017d2714B5a240f3e7737279a3Ba' :: bytea,
            'PENDING'
          ),
          (
            'OpSci Society: The Open Science DAO',
            '\x33359285F30E7B3386dE70ca500F4fe27853765B' :: bytea,
            'PENDING'
          ),
          (
            'Upala 🤖 Price-of-forgery digital identity',
            '\x0230c6dD5DB1d3F871386A3CE1A5a836b2590044' :: bytea,
            'PENDING'
          )/**
          (
            'GiveStation',
            '\x66593b8C04a3797F74C786CeB7C22C9746dd5a3A' :: bytea,
            'PENDING'
          )*/
      ) x (title, address, status)
  ),
  eth_donations AS (
    SELECT
      grantees.title,
      tx.block_time,
      (tr.value) / 10 ^ 18 as eth_amount,
      (tr.value / 10 ^ 18) * pr.price as usd_amount,
      tx."from" as donor
    FROM
      ethereum.transactions tx
      LEFT JOIN ethereum.traces AS tr ON tx.hash = tr.tx_hash
      INNER JOIN grantees on tr."to" = grantees.address
      LEFT JOIN (
        SELECT
          price,
          minute
        FROM
          prices.usd
        WHERE
          symbol = 'WETH'
          and minute > '2023-01-17 12:00'
          and minute < '2023-02-01 00:00'
      ) AS pr on pr.minute = date_trunc('minute', tx.block_time)
    WHERE
      tr."from" = '\x746b951FA10a89d6cbe70d4EE23531f907B58Bc0' --ETH SPLITTER ADDRESS? UPDATE
      and date_trunc('hour', tx.block_time) >= '2023-01-17 12:00'
      and date_trunc('hour', tx.block_time) < '2023-02-01 00:00'
      and tr.value > 0
  ),
  dai_donations AS (
    SELECT
      grantees.title,
      erc20.value / 10 ^ 18 as dai_amount,
      erc20.evt_block_time as block_time,
      erc20.from as donor
    FROM
      ethereum.transactions tx --ethereum.traces
      left join erc20."ERC20_evt_Transfer" erc20 ON tx."hash" = erc20."evt_tx_hash"
      INNER JOIN grantees on erc20."to" = grantees.address
    where
      tx."to" = '\xd95a1969c41112cee9a2c931e849bcef36a16f4c'
      and erc20."contract_address" = '\x6b175474e89094c44da98b954eedeac495271d0f'
      and date_trunc('hour', evt_block_time) >= '2023-01-17 12:00'
      and date_trunc('hour', evt_block_time) < '2023-02-01 00:00'
  ),
  all_donations as (
    SELECT
      title,
      usd_amount,
      block_time,
      donor,
      'ETH' as token,
      eth_amount as token_quantity
    FROM
      eth_donations
    UNION ALL
    SELECT
      title,
      dai_amount as usd_amount,
      block_time,
      donor,
      'DAI' as token,
      dai_amount as token_quantity
    FROM
      dai_donations
  ),
  save as (
    SELECT
      ROUND(CAST(sum(usd_amount) AS numeric), 2) as USD,
      count(distinct donor) as unique_donors
    From
      all_donations
  
  )
SELECT
  *
FROM
 save

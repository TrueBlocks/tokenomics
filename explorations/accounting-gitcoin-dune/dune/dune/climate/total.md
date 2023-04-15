WITH
  grantees AS (
    SELECT
      title,
      address,
      status
    FROM
      (
        VALUES
          (
            'Solarpunk Nomads: building the first two Public Goods adventure vehicles',
            '\x474716e617FEa8898D4fa9D891AA67B5BEDd6C4b' :: bytea,
            'PENDING'
          ),
          (
            'Bundle: Agriculture',
            '\x78Dc08c6f14e26B2C91edAE9a6e03eed7Ae5218B' :: bytea,
            'PENDING'
          ),
          (
            'ReFiDAO X Commons Stack: ReFi Commons Prize',
            '\x8D860D4f254eD45946F5FB0e3243C1db63a4ea2f' :: bytea,
            'PENDING'
          ),
          (
            'Atlantis',
            '\xfbCA78474A09E2BF3543f4Fc1037152ea2c6C32d' :: bytea,
            'PENDING'
          ),
          (
            'BETTER',
            '\x0F7272F8873B68b2a2F52685311822D831afC8b4' :: bytea,
            'PENDING'
          ),
          (
            'ReFi Spring',
            '\x14CB60F6Aca2b2A68d975743baCb33F01f587da5' :: bytea,
            'PENDING'
          ),
          (
            'Bloom Network',
            '\xF64bBc221f89cc882fBa507908bbE4Ae3Ad2F470' :: bytea,
            'PENDING'
          ),
          (
            '.basin - perpetual place-based climate & nature finance',
            '\xD2584c1CF7E3fF11957195732d380DC886F5f05b' :: bytea,
            'PENDING'
          ),
          (
            'Barichara Regeneration Fund – Prototyping a Bioregional Regenerative Economy',
            '\xFd9F8A0f4bdEaC72F08AF1c708023cC31dD2E3BE' :: bytea,
            'PENDING'
          ),
          (
            'ReCommon',
            '\xd704C5F9826191F3Bd06caE867d0f20CAfA8AeBA' :: bytea,
            'PENDING'
          ),
          (
            'dMeter',
            '\x788bd114C3f625600b547d5a08EC38E0ee90A06e' :: bytea,
            'PENDING'
          ),
          (
            'The Solar Foundation',
            '\x5B625088Ee2E0E9E3D0BD8AB6Ba3839d68886d2D' :: bytea,
            'PENDING'
          ),
          (
            'Act Now Climate Change Bundle',
            '\x221966004b2001a0dA1274024d67cd09FEbD0b94' :: bytea,
            'PENDING'
          ),
          (
            'Avano',
            '\x3C8281c8786ab29Bcab5B33566968f8011ea6A59' :: bytea,
            'PENDING'
          ),
          (
            'Endangered Tokens: Endangered Trees as ReFi Biodiversity Assets ',
            '\xCe849efC35A0a0a046E67c76B477c5432E4BA58b' :: bytea,
            'PENDING'
          ),
          (
            'Regens Unite: building public goods and a community to support all regens from web3 and beyond',
            '\x371ca2c8f1d02864c7306e5e5ed5dc6edf2dd19c' :: bytea,
            'PENDING'
          ),
          (
            'Bundle ⚡️♻️Renewable Energy',
            '\xFC148c92062Ae30D788d48031b89B45237f27AF7' :: bytea,
            'PENDING'
          ),
          (
            'Bundle: Climate Research Alpha Round',
            '\x29C40842a76B0aa28865EbF7c916ec820233b7bB' :: bytea,
            'PENDING'
          ),
          (
            'Saving forests in Colombia with KOKO DAO',
            '\x7f722b8b013Ac7Bd654B3B102Acc7573A32DB9bc' :: bytea,
            'PENDING'
          ),
          (
            'Natives in Tech',
            '\x2DeE5D7e77A1212b21139Bc1d98B249DCc52055D' :: bytea,
            'PENDING'
          ),
          (
            'Shamba Ecological Oracle and DMRV Network',
            '\x86579EBcE57605929Da73d8cE17f40960c3b052a' :: bytea,
            'PENDING'
          ),
          /**
           (
           'Bens Test Thinger',
           '\x476Bb29493fcB007e3F80c83A3BF80f3f34610fb' :: bytea,
           'PENDING'
           ),*/
          (
            'WaterDAO',
            '\xF427EbbEb0AeE1b06C99333001009188B5086934' :: bytea,
            'PENDING'
          ),
          (
            'ReSci Network',
            '\x9D120Bee68ed792884D340f911D8434306b28605' :: bytea,
            'PENDING'
          ),
          (
            'Kokonut Network',
            '\x0ea26051F7657d59418da186137141CeA90D0652' :: bytea,
            'PENDING'
          ),
          (
            'The Impact App + Eco Labs',
            '\x59490C362C54C1b60158F19CE499C82aa3669820' :: bytea,
            'PENDING'
          ),
          (
            'Bundle: Oceans & Forests',
            '\x48f2696FB6FAB7ac0956175b2E25B456E61B3FCf' :: bytea,
            'PENDING'
          ),
          /**
           (
           'BaseX — new definition of value',
           '\xa0b8de7ee87605c820ab83ddf4605bb0bc9fe6f1' :: bytea,
           'PENDING'
           ),*/
          (
            'Silvi',
            '\xa7CA400d49BBa87EB606ee05af93689BD21FaB99' :: bytea,
            'PENDING'
          ),
          (
            'Bundle #3: Verification Infrastructure (Impact Certs, Measurement, Reporting & Verification (MRV) and Oracles)',
            '\xb0b0c51D98d3c49f7a5E61735db4f084d62954A1' :: bytea,
            'PENDING'
          ),
          (
            '$Earth - Solarpunk Dao',
            '\xd6b97e042d03EdBDc100Eb55fbE43Eb75f2e3036' :: bytea,
            'PENDING'
          ),
          (
            'TaterDAO',
            '\xCbbd18d3aC27ab0FFfD04BCCd091B2802c92e0ca' :: bytea,
            'PENDING'
          ),
          (
            'Astral Protocol',
            '\x41DdE2Dc7f718D5F764fc97e8d122864587642d4' :: bytea,
            'PENDING'
          ),
          (
            'Impact DAOs Research + Podcast + Book : Impact DAO Media Season 2 ',
            '\xb6e780438882f2daa11dA0972807f4D12166af8b' :: bytea,
            'PENDING'
          ),
          (
            'CyberBox ReFi NFT Marketplace',
            '\x65eD9a7CD4890E23Ac5bc8D51498ae955aF00724' :: bytea,
            'PENDING'
          ),
          (
            'The CM Guild',
            '\x18ddbb6e344B11eeDff5A49fA0C0f1a03cc1097E' :: bytea,
            'PENDING'
          ),
          (
            'Treejer Protocol',
            '\x81c776d0D7F7d9D3699851993EcAa88A46187F11' :: bytea,
            'PENDING'
          ),
          (
            'AgroforestDAO',
            '\xdD866169DBCf639ed57f0020c5C9F4F4E1AAB263' :: bytea,
            'PENDING'
          ),
          (
            'MRV Foundation (previously MRV101)',
            '\x1b4463971582f485138879F0e509C160BeB8D5e6' :: bytea,
            'PENDING'
          ),
          (
            'Hibiscus DAO',
            '\x1a6ef6cc28cf60aa0504cfb21cdffa48cfe3a8fb' :: bytea,
            'PENDING'
          ),
          (
            'The Angry Teenagers - democratising investment in reforestation projects',
            '\x3460BF837B6741035d20Ea2D894A4423A859af12' :: bytea,
            'PENDING'
          ),
          (
            'Myseelia 🍄',
            '\x16d46098e455A04Cf7F3e43c3b2706614fDbEC85' :: bytea,
            'PENDING'
          ),
          /**
           (
           'Living Ground project South America',
           '\x348D5e7A1D24B58665a822D3766db5b2A92eC8DA' :: bytea,
           'PENDING'
           ),*/
          (
            'Bundle: Carbon Markets',
            '\xE07b0f3c2A669b656476e4D6A054F4922D539D3D' :: bytea,
            'PENDING'
          ),
          (
            'Carbon DAO',
            '\x035A1F3419DD223293e5411133d9C786f5885425' :: bytea,
            'PENDING'
          ),
          (
            'Scaling Grassroots Commons for Local Regeneration in E. Africa and S. E. Asia',
            '\xd68e5b216FC2AF2854152EAC501F9E00807d8C1d' :: bytea,
            'PENDING'
          ),
          (
            'Earthist - Decentralize Hemp Seeds',
            '\xc2d706398A978b8c5Aa4EFCd824b57E978841107' :: bytea,
            'PENDING'
          ),
          (
            'Community Engagement - Bundle 6',
            '\x315E6c37077cC5772709Bb7fEcd6d7606b4443c4' :: bytea,
            'PENDING'
          ),
          (
            'LOA Labs : ReFi by South',
            '\xd2993E8217063c72BBE8c736404c7fC02adC9761' :: bytea,
            'PENDING'
          ),
          /**
           (
           'Climate Guardians Impact Gaming',
           '\xAd24474f7e779931e37172017278d15a71F6E4Ec' :: bytea,
           'PENDING'
           ),*/
          (
            'Web3beach',
            '\xEFEdaf9c07E6eB56BB8F82f30018e4461B1c5F4c' :: bytea,
            'PENDING'
          ),
          (
            'Bundle: Emerging Economies and Indigenous Communities',
            '\x4574e76CbB9891A90d46b0788cC4094B9275b61E' :: bytea,
            'PENDING'
          ),
          (
            'Plants And Pillars',
            '\x1C4a70EaDeCc48e436Efd0E997445D71DF57a4ED' :: bytea,
            'PENDING'
          ),
          (
            'Bundle: Creative Works',
            '\x2129fCc2baD30a0c7A448FE802265A14643092df' :: bytea,
            'PENDING'
          )
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
      tr."from" = '\xBaA2f652c7a2228F2e161A615B8a55b359a0a2c8' --ETH SPLITTER ADDRESS? UPDATE
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
      tx."to" = '\x1b165fe4da6bc58ab8370ddc763d367d29f50ef0' -- UPDATE w round
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
      count(*) as donations
    From
      all_donations
  )
SELECT
  *
FROM
  save

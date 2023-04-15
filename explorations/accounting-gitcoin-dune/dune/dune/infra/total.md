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
            'Otterscan',
            '\xb7081Fd06E7039D198D10A8b72B824e60C1B1E16' :: bytea,
            'PENDING'
          ),
          /**
          (
            'Optimism DAppNode Package',
            '\xA47669cBc53985333423e4d3D00188f4049fB695' :: bytea,
            'PENDING'
          ),
          */
          (
            'BuidlGuidl',
            '\x97843608a00e2bbc75ab0c1911387e002565dede' :: bytea,
            'PENDING'
          ),
          /**
          (
            'Optimism DAppNode Package',
            '\xA47669cBc53985333423e4d3D00188f4049fB695' :: bytea,
            'PENDING'
          ),
          */
          (
            'Ethereum on ARM',
            '\x7f06Ac71366631157551D97559b82975c293FdBa' :: bytea,
            'PENDING'
          ),
          (
            'Chainlist',
            '\x08a3c2A819E3de7ACa384c798269B3Ce1CD0e437' :: bytea,
            'PENDING'
          ),
          (
            'L2BEAT',
            '\x6c5a2688c83C806150cA9DD0b2f10f16F8f1c33e' :: bytea,
            'PENDING'
          ),
          (
            'wagmi',
            '\x4557B18E779944BFE9d78A672452331C186a9f48' :: bytea,
            'PENDING'
          ),
          (
            'Lighthouse by Sigma Prime',
            '\xC9a872868afA68BA937f65A1c5b4B252dAB15D85' :: bytea,
            'PENDING'
          ),
          (
            'Somer Esat Ethereum Staking Guides (Ubuntu)',
            '\x32B74B90407309F6637245292cd90347DE658A37' :: bytea,
            'PENDING'
          ),
          (
            'rotki',
            '\x9531C059098e3d194fF87FebB587aB07B30B1306' :: bytea,
            'PENDING'
          ),
          (
            'EthStaker',
            '\xD165df4296C85e780509fa1eace0150d945d49Fd' :: bytea,
            'PENDING'
          ),
          (
            'Optimism DAppNode Package (Mainnet)',
            '\xA47669cBc53985333423e4d3D00188f4049fB695' :: bytea,
            'PENDING'
          ),
          (
            'smol-evm',
            '\xD41BDBD4101e02057b7F621f681540ef3Ac81e55' :: bytea,
            'PENDING'
          ),
          (
            'beaconcha.in',
            '\x9d4E94dB689Bc471E45b0a18B7BdA36FcCeC9c3b' :: bytea,
            'PENDING'
          ),
          (
            'NiceNode: Run a node — just press start',
            '\x9cce47E9cF12C6147c9844adBB81fE85880c4df4' :: bytea,
            'PENDING'
          ),
          (
            'PLUME: Pseudonymously Linked Unique Message Entities, aka Verifiably Deterministic Signatures on Ethereum',
            '\x23aDa6E6A9E9D4EcDDd185e3ec353163BCeeBF2a' :: bytea,
            'PENDING'
          ),
          (
            'Stereum - Ethereum Node Setup',
            '\x6E41fe2F8303b89c9dbcCABE59A7F7f8F4312cA9' :: bytea,
            'PENDING'
          ),
          (
            'Lodestar',
            '\xc8F9f8C913d6fF031c65e3bF7c7a51Ad1f3a86E5' :: bytea,
            'PENDING'
          ),
          /**
          (
            'Vyper Smart Contract Language',
            '\x70CCBE10F980d80b7eBaab7D2E3A73e87D67B775' :: bytea,
            'PENDING'
          ),
          */
          (
            'ethers.js',
            '\x8ba1f109551bD432803012645Ac136ddd64DBA72' :: bytea,
            'PENDING'
          ),
          (
            'Ape Framework',
            '\x187089b65520D2208aB93FB471C4970c29eAf929' :: bytea,
            'PENDING'
          ),
          (
            'Blockscout 2.0 - Premium Open-Source Block Explorer',
            '\x242ba6d68FfEb4a098B591B32d370F973FF882B7' :: bytea,
            'PENDING'
          ),
          (
            'Ethereum Magicians',
            '\xB35cD25e91B376EAfbA79AbE71D78814dEC3401a' :: bytea,
            'PENDING'
          ),
          (
            'TrueBlocks and the Unchained Index',
            '\xf503017d7baf7fbc0fff7492b751025c6a78179b' :: bytea,
            'PENDING'
          )
          /**
          ,(
            'DefiLlama APIs',
            '\x08a3c2A819E3de7ACa384c798269B3Ce1CD0e437' :: bytea,
            'PENDING'
          )
          */
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
      tx."to" = '\xe575282b376e3c9886779a841a2510f1dd8c2ce4'
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
      tx."to" = '\xe575282b376e3c9886779a841a2510f1dd8c2ce4' -- UPDATE w round
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
  total_by_grant as (
    SELECT
      title,
      ROUND(CAST(sum(usd_amount) AS numeric), 2) as USD
    From
      all_donations
    group by
      title
  )
SELECT
  sum(USD)
FROM
 total_by_grant

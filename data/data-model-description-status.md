
| (legend) |
| --- |
| **primary key** |
| normal column |

### On-chain data

#### block

- **Structural Status:** good
- **Status:** implemented
- **Notes:**

| column name | type | notes |
| --- | --- | --- |
| blockNumber | integer | |
| timeStamp | integer(11) |  |
| isFinalized | boolean |  |


#### monitor_group

- **Structural Status:** decent, but needs update
- **Status:** half implemented; need way for QB to communicate its monitor groups
- **Notes:**

| column name | type | notes |
| --- | --- | ---|
| **userID** | uint | <ul><li>nullable because some views might be shared between users</li><li>don't need to model users if focusing on single tenant architecture</li></ul> |
| **monitorGroupID** | uint |  |
| **monitorAddress** | string(42) |  |
| nickname | string(50) | |

#### transaction

- **Structural Status:** decent, but need to review column types for numbers
- **Status:** implemented
- **Notes:** charset = utf8mb4 to support emojis. Non-trivially increases table size. Better way?

| column name | type | notes |
| --- | --- | ---|
| **blockNumber** | uint | |
| **transID** | uint |  |
| **traceID** | uint |  |
| fromAddress | string(42) | |
| toAddress | string(42) | |
| valueWei | unsigned decimal(38, 0) | needs review |
| gasUsed | unsigned bigInteger | needs review |
| gasPrice | unsigned bigInteger | needs review |
| isError | boolean | |
| encoding | string(10) | name could be more specific |
| articulated | JSON | |

#### monitor_transaction

- **Structural Status:** good
- **Status:** implemented
- **Notes:** Awfully big. Should consider measuring size impact of compound primary key.

| column name | type | notes |
| --- | --- | ---|
| **monitorAddress** | string(42) | |
| **blockNumber** | uint | |
| **transID** | uint |  |
| **traceID** | uint |  |

#### abi_spec

- **Structural Status:** seems good?
- **Status:** not implemented
- **Notes:** Should be easy to implement from flat file. Need to come up with a way to automate from QB.

| column name | type | notes |
| --- | --- | ---|
| **encoding** | binary | probably should switch to string type to be consistent with hex data elsewhere |
| fnDefinition | JSON | Ex: *(provide example)* |


#### user

- **Structural Status**: incomplete
- **Status**: not implemented
- **Notes**: don't need this if we pursue single tenant architecture (might make sense for v0.1.0)

| column name | type | notes |
| --- | --- | --- |
| userID | integer [increments] | |
| userName | string(40) |  |


#### price

- **Structural Status:** needs review
- **Status:** not implemented
- **Notes:** We haven't talked much about price scraping.

| column name | type | notes |
| --- | --- | --- |
| timeStamp | timestamp | |
| blockNumber | integer |  |
| currencyFrom | string(10) |  |
| currencyTo | string(10) |  |
| exchangeName | enum('coinbase', 'poloniex', 'bittrex') |  |
| exchangeRate | decimal(21, 18) | |

#### exchange

- **Structural Status**: incomplete
- **Status**: not implemented
- **Notes**: just a sketch of a naming table for the exchanges. Takes exchange name from price table and gives it a nicename.

| column name | type | notes |
| --- | --- | ---|
| name | string(25) | |
| nicename | string(25) |  |


### Column limitations in MySQL

unsigned int: 4294967295

unsigned bigint: 18446744073709551615 (All arithmetic is done using signed BIGINT or DOUBLE values, so you should not use unsigned big integers larger than 9223372036854775807 (63 bits) except with bit functions!)

decimal: The maximum number of digits (M) for DECIMAL is 65.

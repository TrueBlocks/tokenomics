I created three executables:

- chifra from master branch
    - new chifra rendering code is disabled — executable: `chifra-master`
- chifra from develop branch
    - new chifra rendering code is enabled — executable: `chifra-develop`
- chifra from perf/receipts branch
    - tests for better performance - executable: `chifra-perf`

### Shell Script

I generated a shell script with this command:

`chifra receipts <bn>.0`

This produced a test that called for receipts from the first transaction in XXX blocks between 0-15,000,000. Note that many of these blocks have no transactions and will therefor report errors. That’s part of the testing.

### Results

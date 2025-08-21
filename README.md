# UVM Testbench for the Dual_Port Memory



This project contains the RTL code for a **dual-port synchronous memory** and the advanced UVM testbench I built to verify its complex behavior.

A dual-port memory is special because it can be accessed from two independent interfaces at the same time. The goal of this project was to create a verification environment that could handle this concurrency and check for the complience.



---

### The RTL Design

The design is a synchronous **dual-port SRAM**. This means it has two complete, independent sets of ports (**Port A** and **Port B**), each with its own clock, address, write enable, and data lines. This allows for simultaneous read and write operations from two different sources.

---

### My Verification Strategy

To tackle the complexity of verifying concurrent operations, my UVM environment is as below:

* **1. Two Independent Agents**: To properly simulate simultaneous access, the testbench uses **two separate agents**. Agent A drives Port A, and Agent B drives Port B. They run independently to create realistic scenarios where both ports are busy.

* **2. The Scoreboard**: A central scoreboard contains a "golden copy" of the memory. It watches the transactions from **both agents** to constantly check for data corruption and ensure the correct data is read from each port.

* **3. Assertions**: In addition to the scoreboard, I wrote **SystemVerilog Assertions (SVA)**. They constantly monitor for illegal behavior on every clock cycle and also checks the functionality of the memory.

* **4. UVM Factory Overrides**: I used the **UVM factory** to make the testbench highly reusable. To test it, I created new driver and new transaction class for the Port A and using factory overriding successfully implemented the new classes, showcasing the ability of the reusabilty of the testbench.

* **5. Functional coverage**: Further, I used functional coverage to get the accuracy and to check if all the functionality of the dual-port memory works as intended.


---

### Key Test Scenarios I Ran

My test suite was designed to create challenging concurrent scenarios:

* **`single_port_tests`**: Basic tests to ensure each port works correctly on its own.
* **`simultaneous_read_write_test`**: A core test where one port is continuously writing to memory while the other is reading from different locations.
* **`read_after_write_test`**: One port reads from an address immediately after the other port writes to it, checking for data consistency.
* **`write_collision_test`**: The ultimate stress test where **both ports try to write to the exact same address at the exact same time**. This verifies the memory's designed priority scheme or error handling.
* **`illegal_access_test`**: A negative test, created using a factory override, to ensure the memory responds correctly to invalid commands.

---


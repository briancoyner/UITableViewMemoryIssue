UITableViewMemoryIssue
======================

1. Launch the "TableViewTest" in Instruments (any simulator)
2. Select the Leaks Instrument
3. Once the app launches filter Instruments to show "UITableView"
    - there is one UITableView instance (good)
4. Tap the "UITableView Memory Issue" row in the "main" view
    - there are now two UITableView instances (good)
6. Tap the back button
    - there is now one UITableView instance (good)
7. Tap the "UITableView Memory Issue" row in the "main" view
    - there are now two UITableView instances (good)
8. Tap the "+" navigation bar button item
    - this executes the "beginUpdates" / "endUpdates" UITableView API
9. Tap the back button
    - there are still two UITableView instances (bad)
    - the HCADynamicTableViewController is released properly (good)

Executing any UITableView animation API causes the UITableView to be retained forever. 

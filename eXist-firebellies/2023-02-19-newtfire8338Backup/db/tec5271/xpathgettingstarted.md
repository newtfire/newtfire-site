# Xpath Getting Started
1. Xpath can distinguish the two by the div element that they are placed under. Each act receives its own div element and then follows the scene div element. 

2. doc('/db/apps/shakespeare/data/tem.xml')//body/div

3. doc('/db/apps/shakespeare/data/tem.xml')//body/div/div

4. doc('/db/apps/shakespeare/data/tem.xml')//body/div[2]/div/head

Part 2

1. doc('/db/apps/sh akespeare/data/tem.xml')//stage

2. doc('/db/apps/shakespeare/data/tem.xml')//body/div[3]/div/stage

3. doc('/db/apps/shakespeare/data/tem.xml')//l/stage

4. doc('/db/apps/shakespeare/data/tem.xml')//sp/stage

5. Is it body or div that holds the stage elements that are not in a speech or line.

6. 149?

Part 3

1. doc('/db/apps/shakespeare/data/tem.xml')//sp[@who]

2. doc('/db/apps/shakespeare/data/tem.xml')//sp[@who = "Prospero"]
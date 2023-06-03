import os

import iterm2


async def main(connection):
    async with iterm2.CustomControlSequenceMonitor(
        connection, "", r"^im-select$"
    ) as mon:
        while True:
            await mon.async_get()
            os.system("im-select com.apple.keylayout.ABC")


iterm2.run_forever(main)

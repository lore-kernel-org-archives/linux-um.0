Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-ID: <38277.82.83.58.52.1110147838.squirrel@82.83.58.52>
Subject: Re: [uml-devel] UML freezes at hdd-intensive processes
From: "Oliver Baltz" <info@OliverBaltz.de>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 6 Mar 2005 23:23:58 +0100 (CET)
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

Hi,

>> > Have you tried attaching it to the host console thingy, or running
UML under
>> > gdb and breaking in to see what it's doing when it hangs?  (Also, if
>> you
>> > can
>> > get it to respond to the magic sysrq, you can get a thread dump...)

My conclusion: The UML does not respond even to a "sysrq" :(

CONFIG_BLK_DEV_UBD_SYNC is NOT compiled in.

You can find my strace-output of the uml-process here:
http://root.baltz-online.de/files/strace-uml-freeze.txt.gz
I hope that there is somebody out there who can hear my scream for help.

I did a UML-setup on a second machine with absolutely different hardware.
But this UML hangs on hdd-intensive processes, too :(
I setup the UMLs follwing this HOWTO:
http://oliverbaltz.de/index.php?id=101. Perhaps you can find a failure in
this documentation.

Thanks for help.
Olli




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

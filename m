Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BKgq0-0002zw-EY for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 May 2004 10:02:40 -0700
Received: from www.tuxrocks.com ([64.62.190.123] helo=tuxrocks.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1BKgq0-0007UJ-5n
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 May 2004 10:02:40 -0700
Received: from tuxrocks.com (localhost.localdomain [127.0.0.1])
	by tuxrocks.com (8.12.8/8.12.8) with ESMTP id i43H2bfI019561
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 3 May 2004 11:02:37 -0600
Received: from localhost (frank@localhost)
	by tuxrocks.com (8.12.8/8.12.8/Submit) with ESMTP id i43H2bjl019558
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 3 May 2004 11:02:37 -0600
From: Frank Sorenson <frank@tuxrocks.com>
Subject: Re: [uml-devel] UML kernel panic
In-Reply-To: <Pine.LNX.4.44.0405031714130.15869-100000@filer.marasystems.com>
Message-ID: <Pine.LNX.4.44.0405031054190.18483-100000@tuxrocks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Mon, 3 May 2004 11:02:37 -0600 (MDT)
To: user-mode-linux-devel@lists.sourceforge.net

On Mon, 3 May 2004, Henrik Nordstrom wrote:
> On Mon, 3 May 2004, Frank Sorenson wrote:
> 
> > The panics are "Segfault with no mm"
> > 
> > gdb backtraces can be found here:
> > http://sco.tuxrocks.com/uml/trace6.txt
> > http://sco.tuxrocks.com/uml/trace7.txt
> 
> Unfortunately both of these traces are incomplete and only shows what 
> happened after the segfault, not where the segfault occurred.
> 
> But it does look like a UML problem. The reason to panic is a segfault 
> while trying to resolve a VM page fault. But it would be interesting to 
> know what/where triggered the first page fault.

I believe I know why the traces didn't have more information.  Reminder to
trace the binary, not a symlink pointing to it.

This time, I got a different panic while doing the same thing as before:
Kernel panic: Kernel mode fault at addr 0xfffe0012, ip 0x40000c20

A trace is at http://sco.tuxrocks.com/uml/trace10.txt 
(http://sco.tuxrocks.com/uml/trace9.txt may also be helpful).

The kernel panics occur while running the j2eesdk installer, and happen at 
the same point each time:
[root@uml12 tmp]# ./j2eesdk-1_4-linux.bin -console
Checking available disk space...
Checking Java(TM) 2 Runtime Environment...
Extracting Java(TM) 2 Runtime Environment files...
Extracting installation files...
Launching Java(TM) 2 Runtime Environment...
Kernel panic: Kernel mode fault at addr 0xfffe0012, ip 0x40000c20

The odd thing is that often (not always), the system appears to hang after
"Launching Java(TM) 2 Runtime Environment...", until I ssh into the UML.  
When I hit enter after typing the root password, the panic occurs.  The 
rest of the time, ssh works just fine.

Thanks for the help,

Frank
---------------------------------------------------------------------------
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

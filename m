Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B7C1d-0007xz-Ka for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 27 Mar 2004 03:30:53 -0800
Received: from hoth.xs4all.nl ([213.84.241.98] helo=seven.hoth.xs4all.nl)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1B7C1c-00051w-Cy for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 27 Mar 2004 03:30:52 -0800
From: Mark Hurenkamp <mark.hurenkamp@xs4all.nl>
Subject: Re: [uml-devel] Kernel panic on UML linux
References: <Pine.LNX.4.44.0403271153250.19079-100000@filer.marasystems.com>
In-Reply-To: <Pine.LNX.4.44.0403271153250.19079-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403271230.45025.mark.hurenkamp@xs4all.nl>
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
Date: Sat, 27 Mar 2004 12:30:44 +0100
To: Henrik Nordstrom <hno@marasystems.com>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

On Saturday 27 March 2004 11:55, Henrik Nordstrom wrote:
> You need to set a breakpoint on panic
>
> break panic

Seems to make no difference, gdb still reports 'Program exited normally'

(gdb) handle SIGSEGV pass nostop noprint
Signal        Stop      Print   Pass to program Description
SIGSEGV       No        No      Yes             Segmentation fault
(gdb) handle SIGUSR1 pass nostop noprint
Signal        Stop      Print   Pass to program Description
SIGUSR1       No        No      Yes             User defined signal 1
(gdb) break panic
Breakpoint 1 at 0xa0011ac7: file panic.c, line 58.

....


Starting Firewall Initialization (phase 2 of 3) Kernel panic: Kernel mode 
fault at addr 0x489f2000, ip 0x400e9df8


Program exited normally.
(gdb) bt
No stack.


> Is this TT or SKAS mode?

This is running in SKAS mode.


Mark.


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B7OhV-0004ib-0n for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 27 Mar 2004 17:02:57 -0800
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1B7OhU-0003ty-2Y for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 27 Mar 2004 17:02:56 -0800
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] Kernel panic on UML linux
In-Reply-To: <33123.192.168.1.9.1080435284.squirrel@hoth.xs4all.nl>
Message-ID: <Pine.LNX.4.44.0403280159130.24847-100000@filer.marasystems.com>
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
Date: Sun, 28 Mar 2004 03:02:50 +0200 (CEST)
To: Mark Hurenkamp <Mark.Hurenkamp@xs4all.nl>
Cc: jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net

On Sun, 28 Mar 2004, Mark Hurenkamp wrote:

> Could be, I don't use gdb often enough to notice...
> I'm using version 6.0 on a Gentoo distro.

Fedora Core 2 test 1 is also GDB 6.0 something...

> Thanks for the tip, this seems to work great :-)
> 
> So here's the stacktrace of the panic:
> 
> #10 0xa00d4974 in read_kmem (file=0xa70c25a0, buf=0x806ec74 <Address0x806ec74 out of bounds>, count=96, ppos=0xa70c25c0) at mem.c:264
> #11 0xa0038d75 in sys_read (fd=96, buf=0x60 <Address 0x60 out of bounds>,count=96) at read_write.c:177
> #12 0xa00d00a2 in execute_syscall_skas (r=0x806ec74) at syscall_kern.c:28
> #13 0xa00d0124 in handle_syscall (regs=0xa70d0274) at syscall_user.c:26

This is the same issue I reported a some week ago.. for now disable klogd 
and things should work..

Regards
Henrik



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

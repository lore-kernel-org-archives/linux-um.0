Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BpjtN-00041O-15 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Jul 2004 01:34:29 -0700
Received: from webhosting.rdsbv.ro ([213.157.185.164] helo=hosting.rdsbv.ro)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1BpjtM-00006S-Am
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Jul 2004 01:34:28 -0700
From: "Catalin(ux aka Dino) BOIE" <util@deuroconsult.ro>
In-Reply-To: <200407280422.i6S4M7fL008720@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.60.0407281131020.23608@hosting.rdsbv.ro>
References: <200407280422.i6S4M7fL008720@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [uml-devel] Re: uml-patch-2.6.7-1
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
Date: Wed, 28 Jul 2004 11:34:19 +0300 (EEST)
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Wed, 28 Jul 2004, Jeff Dike wrote:

> Here is a belated patch that updates UML to 2.6.7.  The update was the only
> change from the 2.6.6 UML.

One problem with debugging. I ran 2.6.7-1 like this:
./K2.6.7 debug ubd0=ROOT1 mem=32M

In xterm shows:
Checking for the skas3 patch in the host...not found
Checking for /proc/mm...not found
tracing thread pid = 14253

Then, in the debugging xterm:
GNU gdb 6.1.1
Copyright 2004 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you 
are
welcome to change it and/or distribute copies of it under certain 
conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for 
details.
This GDB was configured as "i486-slackware-linux"...Using host 
libthread_db library "/lib/libthread_db.so.1".

0xa01c4a71 in kill () at sock.h:805
805     sock.h: No such file or directory.
         in sock.h
Error accessing memory address 0xa0034c20: No such process.
Error accessing memory address 0xa001c530: No such process.
Error accessing memory address 0xa00022a0: No such process.
/tmp/gdb_init-ziuYCQ:6: Error in sourced command file:
ptrace: Operation not permitted.
0xa01c4a71 in kill () at sock.h:805
805     in sock.h
(gdb) Quit
(gdb)

This is a Slackware 10.

No patches on host (also 2.6.7).

How can I help debugging this problem?

Thanks!
---
Catalin(ux aka Dino) BOIE
catab at deuroconsult.ro
http://kernel.umbrella.ro/


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

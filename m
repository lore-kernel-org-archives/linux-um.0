Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CA7o2-0004Q7-2P for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Sep 2004 07:09:14 -0700
Received: from custpop.ca.mci.com ([142.77.1.111] helo=mail.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CA7o1-00011A-F1 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Sep 2004 07:09:13 -0700
Received: from [216.95.199.148] (account alex@xiphos.ca HELO onefishtwo.ca)
	by mail.net (CommuniGate Pro SMTP 3.5.6)
	with ESMTP id 19751091 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Sep 2004 10:09:07 -0400
Message-ID: <41518862.6070202@onefishtwo.ca>
From: Alex deVries <alex@onefishtwo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Problems debugging a UML kernel
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
Date: Wed, 22 Sep 2004 10:12:50 -0400
To: user-mode-linux-devel@lists.sourceforge.net


UML has really helped me with some kernel module debugging in the past, 
but I'm having a problem getting it running in a new environment.

I'm having a problem where I can't seem to get into an interactive debug 
mode with a UML kernel.

In one window, I'm running:

gdb linux-2.4.26/linux

which prints out:

[root@cubalibre uml]# GNU gdb 6.2
Copyright 2004 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain 
conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i686-pc-linux-gnu"...Using host libthread_db 
library "/lib/tls/libthread_db.so.1".



In another window, I run:
linux-2.4.26/linux debug gdb-pid=<pid of gdb> ubd0=fedora

At this point, UML starts up and prints out:

Checking for the skas3 patch in the host...not found
Checking for /proc/mm...not found
tracing thread pid = 14094


Then, if I type 'att 1' in the gdb window, it prints out:

(gdb) Attaching to program: linux-2.4.26/linux, process 1


And then just stops.  I never end up in the interactive debugging mode 
I've seen before.  If I hit ^c, gdb gives me:

0xa015f2f1 in kill () at string.h:486
486                     case 1: COMMON("\n\tstosb"); return s;
(gdb) Quit
(gdb)

but I can never actually run the kernel within the debugger.


My host is Fedora Core 2, running a custom built 2.6.7 kernel.  I'm 
using a custom-built gdb version 6.2, although I see the same behaviour 
with my distribution's gdb (version 6.0post-0.20040223.19rh)

My uml host kernel is 2.6.7, patched with uml-2.6.7-2.  I have 
CONFIG_PT_PROXY, TT and SKAS mode enabled.

Any help is greatly appreciated.

- Alex


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5ts8-0007X8-QR for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Sep 2004 15:28:01 -0700
Received: from mta10.adelphia.net ([68.168.78.202])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C5try-00052H-PK for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Sep 2004 15:27:57 -0700
From: Matt Zimmerman <mdz@debian.org>
Message-ID: <20040910222635.GA5690@alcor.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [smcc@CSAIL.MIT.EDU: Bug#271069: gdb startup fails in
	tracefork check]
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
Date: Fri, 10 Sep 2004 15:26:35 -0700
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Stephen McCamant <smcc@CSAIL.MIT.EDU>, 271069-forwarded@bugs.debian.org

----- Forwarded message from Stephen McCamant <smcc@CSAIL.MIT.EDU> -----

Date: Fri, 10 Sep 2004 18:09:07 -0400
From: Stephen McCamant <smcc@CSAIL.MIT.EDU>
Resent-From: Stephen McCamant <smcc@CSAIL.MIT.EDU>
To: submit@bugs.debian.org
Subject: Bug#271069: gdb startup fails in tracefork check

Package: user-mode-linux
Version: 2.4.26-2um-1

With the current versions of UML and GDB in sarge, with a 2.4.x host
kernel (no SKAS support, so this is in tt mode), gdb runs into an
error when UML tries to start it as requested by a "debug" option. For
instance, given the invocation

% linux debug

the contents of the "UML kernel debugger" window are:

GNU gdb 6.1-debian
Copyright 2004 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i386-linux"...(no debugging symbols found)...Using host libthread_db library "/lib/libthread_db.so.1".

/tmp/gdb_init-lnsVCy:1: Error in sourced command file:
linux_test_for_tracefork: waitpid: Interrupted system call.
(gdb) 

and then GDB doesn't function correctly (for instance, it refuses to
set breakpoints).

The generated gdb_init file looks like:

att 1 
b panic 
b stop 
handle SIGWINCH nostop noprint pass 
b start_kernel
c

where the line 1 the error refers to is "att 1". Despite the message,
though, I don't think the error comes from the init file, but rather
from part of GDB's startup process: linux_test_for_tracefork(), from
the file linux-nat.c in the GDB source, is used to check whether the
kernel supports various options to ptrace which, if present, allow GDB
to follow children that fork. To do this, GDB forks a child process,
waits for the child to stop itself, then sets some ptrace options and
has the child fork. When run on its own, the test executes without
problems, but when gdb is started by UML, the waitpid call that gdb
uses to wait for the first child to call PTRACE_TRACEME is
unexpectedly interrupted; the EINTR return value is what makes gdb
error out.

If I edit the source to gdb so that the function immediately returns a
"not-available" result without actually doing the test, and use that
modified gdb instead of the regular one, debugging the UML kernel
works as I would expect.

I'm seeing this with the 6.1-3 package of gdb, a Debian-standard
2.4.26-1-k7-smp (2.4.26-4) kernel, and libc 2.3.2.ds1-13.

Let me know if I can provide any more information to help track this
down.

 -- Stephen


-- 
To UNSUBSCRIBE, email to debian-bugs-dist-REQUEST@lists.debian.org
with a subject of "unsubscribe". Trouble? Contact listmaster@lists.debian.org

----- End forwarded message -----

-- 
 - mdz


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BXHOk-0006CW-Qc for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Jun 2004 03:30:34 -0700
Received: from exchfe2.cs.cornell.edu ([128.84.97.28])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BXHOk-00021I-Ce for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Jun 2004 03:30:34 -0700
Message-ID: <40C443C2.3020708@cs.cornell.edu>
From: Alan Shieh <ashieh@cs.cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Hangs during boot; Zombie processes + dangling file locks
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
Date: Mon, 07 Jun 2004 06:30:26 -0400
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

I'm having some problems with User-mode Linux. I also have some simple 
questions about running gdb.

I am hosting on Fedora Core 1, w/ a modified 2.4.22 host. I have 
disabled exec-shield{,-randomize}. The guest is vanilla 2.4.26 + uml + 
my modifications. Note that the host and guest kernels have 
modifications to the net/ipv4 and include/net/sock.h. These changes are 
stable under 2.4.26 when running on the real hardware.

I consistently encounter 2 showstoppers.

1. UML hangs at
Setting the System Clock using the Hardware Clock as reference...
It looks like the kernel is not taking interrupts. I can't generate 
breaks from the GDB window. I would like to provide a backtrace, but I 
don't know how to externally force a segfault. I tried sending SIGSEGV, 
SIGABRT, ... , and only elicited the printk

sleeping process <pid> got unexpected signal : <signum>

(insert <pid> and <signum> as appropriate)

Is there way to generate something like an NMI to force a coredump or 
GDB-visible break?

2. Issue #1 came up after I rebuilt the kernel to get rid of possible 
poisoning from i386 build.
   Before hitting issue #1, I encountered problems while mounting hostfs 
on the Debian 3.0 image
   mount none /mnt/home -t hostfs
       -- Panicks immediately. I believe a null parameter is passed to 
do_mount
   mount none /mnt/home -t hostfs -o /tmp/foo
       -- Returns with "invalid option" error

This happened with both vanilla UML, and my patched UML.

Sorry, I did not get a backtrace, and no longer have that instance of 
the kernel. But I fear hitting this problem again once problem #1 is 
resolved.

I also occasionally get stuck with a bunch of UML "linux" zombies after 
a crash. This happens if I kill UML with some signals (SIGHUP). The 
zombies also hold on to the root_fs lock. This problem does not occur 
with SIGKILL.

** GDB
I prefer to use GDB in XEmacs. Do the DDD instructions apply to this 
environment?
With KGDB, it is possible to enable GDB on the fly using the ioctl() 
interface on /dev/ttyS?. Is there equivalent functionality in UML?

Thanks in advance for your help.

Alan


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

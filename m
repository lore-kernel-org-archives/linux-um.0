Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BfNKL-0006gY-1P for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Jun 2004 11:27:29 -0700
Received: from mta11.adelphia.net ([68.168.78.205])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BfNKK-0003Mo-Gq for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Jun 2004 11:27:28 -0700
From: Matt Zimmerman <mdz@debian.org>
Message-ID: <20040629182711.GM5243@alcor.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [mgedmin@b4net.lt: Bug#256873: user-mode-linux: fails to
	start (kernel panic)]
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
Date: Tue, 29 Jun 2004 11:27:11 -0700
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Marius Gedminas <mgedmin@b4net.lt>, 256873-forwarded@bugs.debian.org

I am receiving many reports from my users that 2.4.26-1um is less functional
than past versions, especially (but not exclusively) where hostfs is
concerned.  Are others experiencing problems as well?  I am considering
reverting the Debian packages to 2.4.24-1um, which was the last version
which was stable for me (it had only one frustrating hostfs bug, where
readdir() would read forever).

----- Forwarded message from Marius Gedminas <mgedmin@b4net.lt> -----

Date: Tue, 29 Jun 2004 16:46:21 +0100
From: Marius Gedminas <mgedmin@b4net.lt>
Resent-From: Marius Gedminas <mgedmin@b4net.lt>
To: Debian Bug Tracking System <submit@bugs.debian.org>
Subject: Bug#256873: user-mode-linux: fails to start (kernel panic)

Package: user-mode-linux
Version: 2.4.26-1um-1
Severity: important

After 2.4.26-1um-1 fell into testing (replacing 2.4.24-1um-2), my UML
instances fail to start with a kernel panic.  Rootstrap also crashes
with the same error.  Last several lines of UML output are

  [...]
  Checking that ptrace can change system call numbers...OK
  openpty failed to allocate a pty
  openpty failed to allocate a pty
  POSIX conformance testing by UNIFIX
  process 553 exited with status 0
  Kernel panic: wait_for_stop failed to wait for 553 to stop with 19

  In idle task - not syncing
   <6>SysRq : Show Regs

  Kernel panic: Segfault with no mm
  In idle task - not syncing
   <6>SysRq : Show Regs

  EIP: 0023:[<a015f2e5>] CPU: 0 Not tainted ESP: 002b:a121feb4 EFLAGS: 00010202
      Not tainted
  EAX: 00000000 EBX: a02adee0 ECX: 00000001 EDX: a121c274
  ESI: 00000070 EDI: 00000007 EBP: a121fecc DS: 002b ES: 002b
  Call Trace: [<a016ecd0>] [<a015589f>] [<a0023b2d>] [<a0014c08>] [<a0154b0b>]
     [<a0264a67>] [<a0201c44>] [<a0152503>] [<a0154f65>] [<a015f2e5>] [<a0159241>]
     [<a0155062>] [<a0201b58>] [<a015f2e5>] [<a015f2c7>] [<a0263345>] [<a016ed6a>]
     [<a016ecd0>] [<a015589f>] [<a0023b2d>] [<a0014c08>] [<a0155e6f>] [<a02814c0>]
     [<a014f3cb>] [<a014f360>] [<a021a49a>]

The process ID (553) seems to vary, but the other numbers stay constant,
at a glance.

The contents of my rootstrap.conf, minus comments and empty lines:

  [global]
  fstype=ext3
  initialsize=512
  freespace=0
  modules=network mkfs mount debian uml umount
  PATH=/bin:/sbin:/usr/bin:/usr/sbin
  [network]
  hostname=schooltool-uml
  transport=tuntap
  interface=eth0
  host=192.168.200.1
  uml=192.168.200.100
  netmask=255.255.255.0
  gateway=192.168.200.1
  domain=localdomain
  nameserver=192.168.200.1
  [debian]
  dist=woody
  mirror=http://ftp.uk.debian.org/debian
  exclude=pcmcia-cs setserial
  purge=base-config console-common console-tools console-data
  console-tools-libs
  [base-config]
  root_password=rootstrap
  [tasksel]
  [uml]
  install_modules=yes

Host kernel is kernel-image-2.4.18-1-686, version 2.4.18-13.1.
Rootstrap is version 0.3.20-1.

Downgrading to user-mode-linux version 2.4.24-1um-2 fixes the problem.

I tried rootstrap on a different machine, also with user-mode-linux
2.4.26-1um-1, and it failed with a slightly different error:

-- System Information:
Debian Release: 3.0
  APT prefers testing
  APT policy: (500, 'testing')
Architecture: i386 (i686)
Kernel: Linux 2.4.18-1-686
Locale: LANG=C, LC_CTYPE=C

Versions of packages user-mode-linux depends on:
ii  uml-utilities                 20040406-1 User-mode Linux (utility programs)

----- End forwarded message -----

-- 
 - mdz


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

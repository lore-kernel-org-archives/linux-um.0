Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AwdXH-000492-1O for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Feb 2004 00:39:55 -0800
Received: from hongkong.cs.nmsu.edu ([128.123.64.160] ident=0)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Awd8w-0002mO-DF for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Feb 2004 00:14:46 -0800
From: Ross Combs <rocombs@cs.nmsu.edu>
Message-Id: <200402270829.i1R8TfAX014941@hongkong.cs.nmsu.edu>
Subject: [uml-devel] Crash early in boot with 2.4.25+uml-patch-2.4.24-1
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
Date: Fri, 27 Feb 2004 02:29:41 -0600
To: user-mode-linux-devel@lists.sourceforge.net

I've been trying to debug an early boot crash with 2.4.25 (x86 with
UML running on Red Hat 7.3 with kernel 2.4.20-28.7.

The boot messages look like this when it dies:

 Checking for the skas3 patch in the host...not found
 Checking for /proc/mm...not found
 make_umid - mkstemp failed, errno = 13
 tracing thread pid = 22242
 Segmentation fault

If I keep everything the same except not call chroot() in my startup
script it boots fine (until mounting the root fs which would need
modified paths to work without chroot).  The messages look like this
when it works:

 Checking for the skas3 patch in the host...not found
 Checking for /proc/mm...not found
 make_umid - mkstemp failed, errno = 13
 Checking for /dev/anon on the host...Not available (open failed with errno 2)
 Checking for /dev/anon on the host...Not available (open failed with errno 2)
 Checking for /dev/anon on the host...Not available (open failed with errno 2)
 Checking for /dev/anon on the host...Not available (open failed with errno 2)
 make_umid - mkstemp failed, errno = 13
 Linux version 2.4.25-1um (nospam@nospam.com) (gcc version 3.3.3 20040125 (prerelease) (Debian)) #11 Fri Feb 27 02:23:25 EST 2004
 On node 0 totalpages: 16384
 zone(0): 16384 pages.
 zone(1): 0 pages.
 ...

The mkstemp permission problem with the pidfile has always been there
because there is only one writable place in the chrooted environment,
but it has never caused a problem before.

It looks like the /dev/anon checks are somehow skipped when using
chroot and it jumps directly to starting the tracing thread which then
dies after receiving a SIGUSR1.

I've tried adding more debug messages to the boot sequence.  They
didn't tell me a whole lot but here is the sequence when it dies:

 ...
 Postsetup completed
 tracing thread pid = 21888
 after clone
 after ptrace
 after debug
 ready to loop
 after waitpid
 got sig 10
 before do_proc_op
 before switch
 got REBOOT or HALT
 Segmentation fault


I really have no clue what is causing this and the only factor I have
found to make a difference doesn't make sense.

Has anyone else seen this?  Do you have any ideas?

Thanks,
-Ross


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

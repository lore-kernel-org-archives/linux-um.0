Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D6jGx-0005i4-N3 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Mar 2005 21:53:19 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D6jGv-0001ir-UX for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Mar 2005 21:53:19 -0800
Message-Id: <200503030822.j238MoBY016825@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Triage on the pending patches
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
Date: Thu, 03 Mar 2005 03:22:50 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

Since 2.6.11 is out, it's time to decide what patches go into mainline first.

Here's my cut:

Plain bug-fixes -
	build
	no-kexec
	no-bb
	slirp-is-not-ethernet
	no-grep-st-ino
	fix-hostfs-gid
	usercopy-confusion
	fix-tlb-rounding
	ubd-config
	failed-net-hang
	long-command-line

Safe -
	cleanup-userspace - rearranges code
	syscall-speedup - removes code
	syscall-debug - makes some code configurable
	pread - adds a comment
	remove-useless-code - removes a no-op wrapper
	user-obj-cleanup - build cleanup
	x86_64-ldt - eliminates a reference to mm_indirect
	x86-64-warning - changes some errors from panics to printks
	error-reporting - prints out warnings where there weren't any before
	static-tty-chan - makes a bunch of things static
	stack-expansion - makes UML behave like the underlying arch
	no-mo-perl - generate config.c with sed
	

That's 23 of the 78.  We also need to resurrect the SA_NODEFER patch.

The skas0 stuff needs more baking.  The os-dependent code movement I'm going
to sit on until we have it all in hand and can clean it up.

After that, some of the cleanups like the ubd-mmap removal and tlb flush
cleaning can go.

winch-crash will be nice to get in once we have agreement that it's correct.

no-sys-ptrace seems OK, but it's large, which makes me nervous.  Maybe that's
a reason to get it in early.

fp-state is probably another good early candidate, as is no-bb.

user-constants-dep seems OK, but I just dropped in without understanding it.

random is OK, but needs a bit more work, in particular, it needs to be 
configurable.

				Jeff



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

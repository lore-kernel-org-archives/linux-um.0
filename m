Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BO1Cp-0005YN-NY for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 May 2004 14:23:59 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1BO1Cp-00022B-5e
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 May 2004 14:23:59 -0700
Received: from ccure.user-mode-linux.org (localhost.localdomain [127.0.0.1])
	by ccure.user-mode-linux.org (8.12.5/8.12.5) with ESMTP id
	i4CM8cCe008920 for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 12 May 2004 18:08:38 -0400
Message-Id: <200405122208.i4CM8cCe008920@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] uml-patch-2.4.24-3
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
Date: Wed, 12 May 2004 18:08:37 -0400
To: user-mode-linux-devel@lists.sourceforge.net

This patch contains a ton of hostfs/humfs work.  

The kernel infrastructure that was in hostfs_kern.c was made asynchronous, 
cleaned up, and many bugs fixed.  It was also renamed to externfs.  The old
hostfs_user.c is now host_fs.c.  Previously, there were a number of bugs
conspiring to make hostfs completely synchronous, so you could read a file
in, change it from the host, read it again, and see the new contents.  This
is now very likely not to work.  If you depend on it, yell, and I'll see how
to get it back.  O_SYNC will make writes synchronous, and O_DIRECT (when this
stuff makes it into my 2.6 tree) should do the same for writes, if it can
be invoked from mount for an entire filesystem.

humfs is now able to accept plug-in metadata modules, thanks to Piotr Neuman.
The existing shadow filesystem metadata is now plugged in to this interface, 
and lives in meta_fs.c.  This will enable all the other metadata backends
that people suggested earlier to be plugged in.  Piotr is currently working
on a tdb backend.

There was also a cleanup patch from Paul Wagland.

Everything in arch/um/fs/hostfs is now kernel code, and the USER_* stuff
in the Makefile is now gone.

As for everything else, there were
	a fix from Oleg which causes malloc to call vmalloc, which I changed
to check the allocation size and only use vmalloc for large allocations
	a fix for a bug in mconsole_interrupt which would crash if it ever saw 
an empty to-do list which cleaned up the code
	a ethernet ioctl patch from Gerd Knorr
	clean-up of the AIO support, which should now build and run on 2.4,
falling back to the IO thread if 2.6 AIO support isn't available
	a filehandle abstraction to support reclaiming file descriptors
when we hit the kernel limit

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

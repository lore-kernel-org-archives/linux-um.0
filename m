Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AxGWR-0006hK-Qz for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 28 Feb 2004 18:17:39 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1AxGLY-0004H8-PZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 28 Feb 2004 18:06:25 -0800
Received: from ccure.user-mode-linux.org (localhost.localdomain [127.0.0.1])
	by ccure.user-mode-linux.org (8.12.5/8.12.5) with ESMTP id
	i1T2abM9008321 for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 28 Feb 2004 21:36:37 -0500
Received: (from jdike@localhost)
	by ccure.user-mode-linux.org (8.12.5/8.12.5/Submit) id i1T2ab68008319
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 28 Feb 2004 21:36:37 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20040229023636.GB8272@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [PATCH] fix writing into /dev/kmem
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
Date: Sat, 28 Feb 2004 21:36:36 -0500
To: user-mode-linux-devel@lists.sourceforge.net

The patch below fixes a bug in the /dev/kmem driver which causes UML to
die if you write to it.  Of course, the kernel will die if you write random
crap to kernel memory, but at least it doesn't die in a UML-specific way.

This is a cut'n'paste from an xterm, so apply with patch -l.

				Jeff

--- drivers/char/mem.c~ 2004-01-05 11:23:32.000000000 -0500
+++ drivers/char/mem.c  2004-02-27 08:52:14.000000000 -0500
@@ -287,6 +287,7 @@
        ssize_t virtr = 0;
        char * kbuf; /* k-addr because vwrite() takes vmlist_lock rwlock */
 
+       p = (unsigned long) __va(p);
        if (p < (unsigned long) high_memory) {
                wrote = count;
                if (count > (unsigned long) high_memory - p)
@@ -321,7 +322,7 @@
                free_page((unsigned long)kbuf);
        }
 
-       *ppos = p;
+       *ppos = __pa((void *) p);
        return virtr + wrote;
 }


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cqyfy-0006H4-3R for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 Jan 2005 11:06:02 -0800
Received: from pool-151-203-197-142.bos.east.verizon.net ([151.203.197.142]
	helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1Cqyfw-0003TN-F9
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 Jan 2005 11:06:02 -0800
Message-Id: <200501182128.j0ILSgxi013966@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] SIGSEGV and SA_NODEFER
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
Date: Tue, 18 Jan 2005 16:28:42 -0500
To: Blaisorblade <blaisorblade@yahoo.it>, "Christopher S. Aker" <caker@theshore.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

It turns out that caker's crashes were being caused by the lack of SA_NODEFER
in the SIGSEGV handler registration.

I know I fixed this, and I have no idea where the fix went.  Do you have any
clue what happened to it?

Patch below...

				Jeff

Index: 2.6.10/arch/um/kernel/process.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/process.c        2005-01-17 12:27:47.000000000 -0500
+++ 2.6.10/arch/um/kernel/process.c     2005-01-18 13:55:28.000000000 -0500
@@ -60,7 +60,10 @@
 {
        int flags = altstack ? SA_ONSTACK : 0;
 
-       set_handler(SIGSEGV, (__sighandler_t) sig_handler, flags,
+       /* SIGSEGV needs to be SA_NODEFER because segfaults can happen while
+        * the segfault handler is on the stack.
+        */
+       set_handler(SIGSEGV, (__sighandler_t) sig_handler, flags | SA_NODEFER,
                    SIGUSR1, SIGIO, SIGWINCH, SIGALRM, SIGVTALRM, -1);
        set_handler(SIGTRAP, (__sighandler_t) sig_handler, flags, 
                    SIGUSR1, SIGIO, SIGWINCH, SIGALRM, SIGVTALRM, -1);



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

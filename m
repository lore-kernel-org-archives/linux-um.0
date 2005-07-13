Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DslX7-0000xW-16	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Jul 2005 11:00:33 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.44)
	id 1DslX6-0005mR-FS	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Jul 2005 11:00:33 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050713180210.7DFF621E72A@zion.home.lan>
Subject: [uml-devel] [patch 1/9] uml: fix lvalue for gcc4
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
Date: Wed, 13 Jul 2005 20:02:01 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it, rmk+lkml@arm.linux.org.uk


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>, Russell King <rmk+lkml@arm.linux.org.uk>

This construct is refused by GCC 4, so here's the (corrected) fix. Thanks to
Russell for noticing a stupid mistake I did when first sending this.

As he noted, the code is largely suboptimal however it currently works, and
will be fixed shortly. Just read the access_ok check on
fp which is NULL, or the pointer arithmetic below which should be done with a
cast to void*:

 	frame = (struct rt_sigframe __user *)
 		round_down(stack_top - sizeof(struct rt_sigframe), 16) - 8;

The code shows clearly that has been taken from
arch/x86_64/kernel/signal.c:setup_rt_frame(), maybe in a bit of a hurry.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-broken-paolo/arch/um/sys-x86_64/signal.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/um/sys-x86_64/signal.c~uml-fix-for-gcc4-lvalue arch/um/sys-x86_64/signal.c
--- linux-2.6.git-broken/arch/um/sys-x86_64/signal.c~uml-fix-for-gcc4-lvalue	2005-07-13 19:30:43.000000000 +0200
+++ linux-2.6.git-broken-paolo/arch/um/sys-x86_64/signal.c	2005-07-13 19:30:44.000000000 +0200
@@ -168,7 +168,7 @@ int setup_signal_stack_si(unsigned long 
 
 	frame = (struct rt_sigframe __user *)
 		round_down(stack_top - sizeof(struct rt_sigframe), 16) - 8;
-	((unsigned char *) frame) -= 128;
+	frame -= 128 / sizeof(*frame);
 
 	if (!access_ok(VERIFY_WRITE, fp, sizeof(struct _fpstate)))
 		goto out;
_


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

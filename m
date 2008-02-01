Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JKziL-0004L9-9e for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Feb 2008 09:30:09 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JKziJ-00009C-Jy
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Feb 2008 09:30:09 -0800
Date: Fri, 1 Feb 2008 12:29:55 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080201172955.GA6897@c2.user-mode-linux.org>
References: <20080131150634.GC2471@hacking>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080131150634.GC2471@hacking>
Subject: Re: [uml-devel] [Patch] arch/um/include/init.h: Fix missing macro
	definitions
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: WANG Cong <xiyou.wangcong@gmail.com>, Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

On Thu, Jan 31, 2008 at 11:06:34PM +0800, WANG Cong wrote:
> This patch fixed the following build error in current -git tree.
> 
> arch/um/kernel/config.c:10: error: expected declaration specifiers or '...' before '.' token
> ...

This is close to uml-arch-um-include-inith-needs-a-definition-of-__used.patch
that's currently in -mm.

Andrew, could you replace
uml-arch-um-include-inith-needs-a-definition-of-__used.patch with the
version below and push it to Linus?

				Jeff

-- 
Work email - jdike at linux dot intel dot com


init.h started breaking now for some reason.  It turns out that there wasn't a
definition of __used.  Fixed this by copying the relevant stuff from
compiler.h in the userspace case, and including compiler.h in the kernel case.

From WANG Cong <xiyou.wangcong@gmail.com> - added definition of __section

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
Cc: WANG Cong <xiyou.wangcong@gmail.com>
---
 arch/um/include/init.h |   25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

Index: linux-2.6-git/arch/um/include/init.h
===================================================================
--- linux-2.6-git.orig/arch/um/include/init.h	2008-02-01 10:41:14.000000000 -0500
+++ linux-2.6-git/arch/um/include/init.h	2008-02-01 10:52:34.000000000 -0500
@@ -40,6 +40,20 @@
 typedef int (*initcall_t)(void);
 typedef void (*exitcall_t)(void);
 
+#ifndef __KERNEL__
+#ifndef __section
+# define __section(S) __attribute__ ((__section__(#S)))
+#endif
+
+#if __GNUC_MINOR__ >= 3
+# define __used			__attribute__((__used__))
+#else
+# define __used			__attribute__((__unused__))
+#endif
+
+#else
+#include <linux/compiler.h>
+#endif
 /* These are for everybody (although not all archs will actually
    discard it in modules) */
 #define __init		__section(.init.text)
@@ -127,14 +141,3 @@ extern struct uml_param __uml_setup_star
 #endif
 
 #endif /* _LINUX_UML_INIT_H */
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

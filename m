Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JKb2a-0004GL-Hx for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 31 Jan 2008 07:09:24 -0800
Received: from qb-out-0506.google.com ([72.14.204.227])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JKb2a-0006NG-5h
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 31 Jan 2008 07:09:24 -0800
Received: by qb-out-0506.google.com with SMTP id c8so732801qbc.4
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 31 Jan 2008 07:09:23 -0800 (PST)
Date: Thu, 31 Jan 2008 23:06:34 +0800
From: WANG Cong <xiyou.wangcong@gmail.com>
Message-ID: <20080131150634.GC2471@hacking>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [Patch] arch/um/include/init.h: Fix missing macro
	definitions
Reply-To: WANG Cong <xiyou.wangcong@gmail.com>
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
To: LKML <linux-kernel@vger.kernel.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net


This patch fixed the following build error in current -git tree.

arch/um/kernel/config.c:10: error: expected declaration specifiers or '...' before '.' token
...


Cc: Jeff Dike <jdike@addtoit.com>
Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>

---

diff --git a/arch/um/include/init.h b/arch/um/include/init.h
index cebc6ca..70982e1 100644
--- a/arch/um/include/init.h
+++ b/arch/um/include/init.h
@@ -40,6 +40,18 @@
 typedef int (*initcall_t)(void);
 typedef void (*exitcall_t)(void);
 
+#ifndef __section
+# define __section(S) __attribute__ ((__section__(#S)))
+#endif
+
+#ifndef __used
+#if __GNUC__ == 3 && __GNUC_MINOR__ == 2
+# define __used                 __attribute__((__unused__))
+#else
+# define __used                 __attribute__((__used__))
+#endif
+#endif
+
 /* These are for everybody (although not all archs will actually
    discard it in modules) */
 #define __init		__section(.init.text)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

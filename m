Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HUPqa-0003HF-2W for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Mar 2007 09:09:04 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HUPqX-0005Io-4I
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Mar 2007 09:09:02 -0700
Date: Thu, 22 Mar 2007 12:06:41 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070322160641.GA6997@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [ PATCH 1/7 ] UML - Update UML definition of ARRAY_SIZE
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

This is the minimal change needed to keep UML building with the new
definition of ARRAY_SIZE.  It is defined in user_util.h so that
userspace files, which can't include kernel.h, can still use
ARRAY_SIZE.  However, since user_util.h is included everywhere,
including kernel files, the token sequence of the expansion has to
match.

This patch copies enough from the kernel headers to make that happen.

However, this is too gross to survive, and so is the entire header.
Future patches will make this header disappear, but this is a quick
and simple fix for the problem in case there is a noticable lag
between this patch and the more extensive patches which tidy this mess.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/include/user_util.h |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

Index: linux-2.6.21-mm/arch/um/include/user_util.h
===================================================================
--- linux-2.6.21-mm.orig/arch/um/include/user_util.h	2007-03-21 10:58:05.000000000 -0400
+++ linux-2.6.21-mm/arch/um/include/user_util.h	2007-03-21 11:05:44.000000000 -0400
@@ -8,8 +8,19 @@
 
 #include "sysdep/ptrace.h"
 
-/* Copied from kernel.h */
-#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+/* Copied from kernel.h and compiler-gcc.h */
+
+/* Force a compilation error if condition is true, but also produce a
+   result (of value 0 and type size_t), so the expression can be used
+   e.g. in a structure initializer (or where-ever else comma expressions
+   aren't permitted). */
+#define BUILD_BUG_ON_ZERO(e) (sizeof(char[1 - 2 * !!(e)]) - 1)
+
+/* &a[0] degrades to a pointer: a different type from an array */
+#define __must_be_array(a) \
+  BUILD_BUG_ON_ZERO(__builtin_types_compatible_p(typeof(a), typeof(&a[0])))
+
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
 
 #define CATCH_EINTR(expr) while ((errno = 0, ((expr) < 0)) && (errno == EINTR))
 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

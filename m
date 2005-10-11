Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EPShg-0006vH-Mi	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Oct 2005 15:34:36 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EPShf-0008Th-6A
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Oct 2005 15:34:36 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20051011190101.8637.13495.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH] uml: compile-time fix recent patch
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
Date: Tue, 11 Oct 2005 21:01:01 +0200
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Give an empty definition for clear_can_do_skas() when it is not needed. Thanks
to Junichi Uekawa <dancer@netfort.gr.jp> for reporting the breakage and
providing a fix (I re-fixed it in an IMHO cleaner way).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/include/os.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/um/include/os.h b/arch/um/include/os.h
--- a/arch/um/include/os.h
+++ b/arch/um/include/os.h
@@ -6,6 +6,7 @@
 #ifndef __OS_H__
 #define __OS_H__
 
+#include "uml-config.h"
 #include "asm/types.h"
 #include "../os/include/file.h"
 
@@ -159,7 +160,11 @@ extern int can_do_skas(void);
 
 /* Make sure they are clear when running in TT mode. Required by
  * SEGV_MAYBE_FIXABLE */
+#ifdef UML_CONFIG_MODE_SKAS
 #define clear_can_do_skas() do { ptrace_faultinfo = proc_mm = 0; } while (0)
+#else
+#define clear_can_do_skas() do {} while (0)
+#endif
 
 /* mem.c */
 extern int create_mem_file(unsigned long len);



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

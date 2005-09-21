Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EI7kN-0001EC-FC	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 09:47:03 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EI7kM-0001od-S9
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 09:47:03 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20050921163828.30500.88418.stgit@zion.home.lan>
In-Reply-To: <200509211822.17590.blaisorblade@yahoo.it>
References: <200509211822.17590.blaisorblade@yahoo.it>
Subject: [uml-devel] [PATCH 03/10] uml: remove verify_area_{tt,skas}
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
Date: Wed, 21 Sep 2005 18:38:33 +0200
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

When removing verify_area, verify_area_{tt,skas} were forgotten.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/kernel/skas/include/uaccess-skas.h |    6 ------
 arch/um/kernel/tt/include/uaccess-tt.h     |    6 ------
 2 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/arch/um/kernel/skas/include/uaccess-skas.h b/arch/um/kernel/skas/include/uaccess-skas.h
--- a/arch/um/kernel/skas/include/uaccess-skas.h
+++ b/arch/um/kernel/skas/include/uaccess-skas.h
@@ -18,12 +18,6 @@
 	  ((unsigned long) (addr) + (size) <= FIXADDR_USER_END) && \
 	  ((unsigned long) (addr) + (size) >= (unsigned long)(addr))))
 
-static inline int verify_area_skas(int type, const void __user * addr,
-                                   unsigned long size)
-{
-	return(access_ok_skas(type, addr, size) ? 0 : -EFAULT);
-}
-
 extern int copy_from_user_skas(void *to, const void __user *from, int n);
 extern int copy_to_user_skas(void __user *to, const void *from, int n);
 extern int strncpy_from_user_skas(char *dst, const char __user *src, int count);
diff --git a/arch/um/kernel/tt/include/uaccess-tt.h b/arch/um/kernel/tt/include/uaccess-tt.h
--- a/arch/um/kernel/tt/include/uaccess-tt.h
+++ b/arch/um/kernel/tt/include/uaccess-tt.h
@@ -33,12 +33,6 @@ extern unsigned long uml_physmem;
          (((unsigned long) (addr) <= ((unsigned long) (addr) + (size))) && \
           (under_task_size(addr, size) || is_stack(addr, size))))
 
-static inline int verify_area_tt(int type, const void __user * addr,
-                                 unsigned long size)
-{
-	return(access_ok_tt(type, addr, size) ? 0 : -EFAULT);
-}
-
 extern unsigned long get_fault_addr(void);
 
 extern int __do_copy_from_user(void *to, const void *from, int n,



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

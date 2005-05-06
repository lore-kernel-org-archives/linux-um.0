Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DUBhW-00089V-G7	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 May 2005 15:53:42 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DUBhU-0005HH-UT	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 May 2005 15:53:42 -0700
Message-Id: <200505062248.j46Mmr4K010433@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 1/12] UML - __deprecated makes build unnecessarily
	noisy
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
Date: Fri, 06 May 2005 18:48:53 -0400
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Blaisorblade <blaisorblade@yahoo.it>

Remove the __deprecated from verify_area_skas and verify_area_tt.  Since
verify_area is itself marked __deprecated, and it is the only caller of
these, then they don't need to be marked.  Marking them only makes the
build noisier.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/kernel/skas/include/uaccess-skas.h
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/skas/include/uaccess-skas.h	2005-05-06 15:10:02.000000000 -0400
+++ linux-2.6.11/arch/um/kernel/skas/include/uaccess-skas.h	2005-05-06 15:18:46.000000000 -0400
@@ -18,8 +18,8 @@
 	  ((unsigned long) (addr) + (size) <= FIXADDR_USER_END) && \
 	  ((unsigned long) (addr) + (size) >= (unsigned long)(addr))))
 
-static inline int __deprecated verify_area_skas(int type, const void * addr,
-				   unsigned long size)
+static inline int verify_area_skas(int type, const void * addr,
+                                   unsigned long size)
 {
 	return(access_ok_skas(type, addr, size) ? 0 : -EFAULT);
 }
Index: linux-2.6.11/arch/um/kernel/tt/include/uaccess-tt.h
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/tt/include/uaccess-tt.h	2005-05-06 15:10:02.000000000 -0400
+++ linux-2.6.11/arch/um/kernel/tt/include/uaccess-tt.h	2005-05-06 15:19:04.000000000 -0400
@@ -33,8 +33,8 @@
          (((unsigned long) (addr) <= ((unsigned long) (addr) + (size))) && \
           (under_task_size(addr, size) || is_stack(addr, size))))
 
-static inline int __deprecated verify_area_tt(int type, const void * addr,
-				 unsigned long size)
+static inline int verify_area_tt(int type, const void * addr,
+                                 unsigned long size)
 {
 	return(access_ok_tt(type, addr, size) ? 0 : -EFAULT);
 }



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

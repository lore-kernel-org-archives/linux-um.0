Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GrN2l-0001fd-T6 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Dec 2006 15:16:20 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GrN2l-0005PN-Cj
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Dec 2006 15:16:15 -0800
Message-Id: <200612042312.kB4NCMck024566@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Mon, 04 Dec 2006 18:12:22 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 3/4] UML - Size register files correctly
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
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

We were using the wrong symbol to size register files.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-mm/arch/um/include/sysdep-i386/ptrace.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/sysdep-i386/ptrace.h	2006-11-27 18:55:15.000000000 -0500
+++ linux-2.6.18-mm/arch/um/include/sysdep-i386/ptrace.h	2006-11-29 04:39:05.000000000 -0500
@@ -75,7 +75,7 @@ union uml_pt_regs {
 #endif
 #ifdef UML_CONFIG_MODE_SKAS
 	struct skas_regs {
-		unsigned long regs[HOST_FRAME_SIZE];
+		unsigned long regs[MAX_REG_NR];
 		unsigned long fp[HOST_FP_SIZE];
 		unsigned long xfp[HOST_XFP_SIZE];
                 struct faultinfo faultinfo;
Index: linux-2.6.18-mm/arch/um/include/sysdep-x86_64/ptrace.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/sysdep-x86_64/ptrace.h	2006-11-27 18:55:15.000000000 -0500
+++ linux-2.6.18-mm/arch/um/include/sysdep-x86_64/ptrace.h	2006-11-29 04:38:13.000000000 -0500
@@ -108,7 +108,7 @@ union uml_pt_regs {
 		 * file size, while i386 uses FRAME_SIZE.  Therefore, we need
 		 * to use UM_FRAME_SIZE here instead of HOST_FRAME_SIZE.
 		 */
-		unsigned long regs[UM_FRAME_SIZE];
+		unsigned long regs[MAX_REG_NR];
 		unsigned long fp[HOST_FP_SIZE];
                 struct faultinfo faultinfo;
 		long syscall;


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

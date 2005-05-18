Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DYG7q-00074C-Cg	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 May 2005 21:25:42 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DYG7p-0006MN-S0	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 May 2005 21:25:42 -0700
Message-Id: <200505180420.j4I4KTsf017332@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 6/9] UML - Export clear_user_*
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
Date: Wed, 18 May 2005 00:20:29 -0400
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Oleg Drokin <green@linuxhacker.ru>

From Oleg Drokin:
This patch is needed to support kernel modules that want to use clear_user() 
(that is exported symbol on all other architectures).

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc/arch/um/kernel/ksyms.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/kernel/ksyms.c	2005-05-02 19:42:47.000000000 -0400
+++ linux-2.6.12-rc/arch/um/kernel/ksyms.c	2005-05-06 21:47:49.000000000 -0400
@@ -57,6 +57,7 @@
 EXPORT_SYMBOL(strncpy_from_user_skas);
 EXPORT_SYMBOL(copy_to_user_skas);
 EXPORT_SYMBOL(copy_from_user_skas);
+EXPORT_SYMBOL(clear_user_skas);
 #endif
 EXPORT_SYMBOL(uml_strdup);
 
Index: linux-2.6.12-rc/arch/um/kernel/tt/ksyms.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/kernel/tt/ksyms.c	2005-03-02 02:38:26.000000000 -0500
+++ linux-2.6.12-rc/arch/um/kernel/tt/ksyms.c	2005-05-06 21:47:49.000000000 -0400
@@ -12,6 +12,7 @@
 EXPORT_SYMBOL(__do_strncpy_from_user);
 EXPORT_SYMBOL(__do_strnlen_user); 
 EXPORT_SYMBOL(__do_clear_user);
+EXPORT_SYMBOL(clear_user_tt);
 
 EXPORT_SYMBOL(tracing_pid);
 EXPORT_SYMBOL(honeypot);



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GNWPk-0004Tr-83 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Sep 2006 08:12:36 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GNWPi-0003FS-Gt
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Sep 2006 08:12:36 -0700
Message-Id: <200609131510.k8DFAvIM004159@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Wed, 13 Sep 2006 11:10:57 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH] Properly export ptrace-abi.h
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
To: akpm@osdl.org, David Woodhouse <dwmw2@infradead.org>
Cc: zach@vmware.com, jeremy@xensource.com, user-mode-linux-devel@lists.sourceforge.net, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, ak@muc.de, 76306.1226@compuserve.com

The ptrace.h splitting patch neglected to add the new, userspace-usable
header to the appropriate header export lists.

This patch does so.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-mm/include/asm-i386/Kbuild
===================================================================
--- linux-2.6.18-mm.orig/include/asm-i386/Kbuild	2006-09-12 10:43:40.000000000 -0400
+++ linux-2.6.18-mm/include/asm-i386/Kbuild	2006-09-13 11:03:48.000000000 -0400
@@ -1,5 +1,5 @@
 include include/asm-generic/Kbuild.asm
 
-header-y += boot.h debugreg.h ldt.h ucontext.h
+header-y += boot.h debugreg.h ldt.h ptrace-abi.h ucontext.h
 
 unifdef-y += mtrr.h setup.h vm86.h
Index: linux-2.6.18-mm/include/asm-x86_64/Kbuild
===================================================================
--- linux-2.6.18-mm.orig/include/asm-x86_64/Kbuild	2006-09-11 10:47:53.000000000 -0400
+++ linux-2.6.18-mm/include/asm-x86_64/Kbuild	2006-09-13 11:04:03.000000000 -0400
@@ -5,7 +5,7 @@ ARCHDEF := defined __x86_64__
 ALTARCHDEF := defined __i386__
 
 header-y += boot.h bootsetup.h cpufeature.h debugreg.h ldt.h \
-	 msr.h prctl.h setup.h sigcontext32.h ucontext.h \
+	 msr.h prctl.h ptrace-abi.h setup.h sigcontext32.h ucontext.h \
 	 vsyscall32.h
 
 unifdef-y += mce.h mtrr.h vsyscall.h


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

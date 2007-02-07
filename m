Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HEssV-0003rd-SE for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Feb 2007 11:54:51 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HEssU-0002ye-DT
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Feb 2007 11:54:51 -0800
Message-Id: <200702071947.l17JlnMY006620@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Wed, 07 Feb 2007 14:47:49 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 5/7] UML - ELF locking commentary
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

Comment the lack of locking of the elf data extracted from the ELF headers
passed to UML.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/os-Linux/elf_aux.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: linux-2.6.18-mm/arch/um/os-Linux/elf_aux.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/os-Linux/elf_aux.c	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.18-mm/arch/um/os-Linux/elf_aux.c	2007-01-09 15:33:31.000000000 -0500
@@ -21,12 +21,11 @@ typedef Elf32_auxv_t elf_auxv_t;
 typedef Elf64_auxv_t elf_auxv_t;
 #endif
 
+/* These are initialized very early in boot and never changed */
 char * elf_aux_platform;
 long elf_aux_hwcap;
-
 unsigned long vsyscall_ehdr;
 unsigned long vsyscall_end;
-
 unsigned long __kernel_vsyscall;
 
 __init void scan_elf_aux( char **envp)


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

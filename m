Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GZuvf-0001Ml-Ne for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Oct 2006 12:48:47 -0700
Received: from [151.97.230.90] (helo=memento.home.lan)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GZuvf-0008IB-C5
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Oct 2006 12:48:47 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Date: Tue, 17 Oct 2006 16:58:44 +0200
Message-Id: <11610971243583-git-send-email-blaisorblade@yahoo.it>
Subject: [uml-devel] uml: fix processor selection to exclude unsupported
	processors and features
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: stable@kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Makes UML compile on any possible processor choice. The two problems were:

*) x86 code, when 386 is selected, checks at runtime boot_cpuflags, which we do
   not have.
*) 3Dnow support for memcpy() et al. does not compile currently and fixing this
   is not trivial, so simply disable it; with this change, if one selects MK7
   UML compiles (while it did not).
Merged upstream; I'm resending since spam filters blocked my previous mail.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Index: linux-2.6.git/arch/i386/Kconfig.cpu
===================================================================
--- linux-2.6.git.orig/arch/i386/Kconfig.cpu
+++ linux-2.6.git/arch/i386/Kconfig.cpu
@@ -7,6 +7,7 @@ choice
 
 config M386
 	bool "386"
+	depends on !UML
 	---help---
 	  This is the processor type of your CPU. This information is used for
 	  optimizing purposes. In order to compile a kernel that can run on
@@ -301,7 +302,7 @@ config X86_USE_PPRO_CHECKSUM
 
 config X86_USE_3DNOW
 	bool
-	depends on MCYRIXIII || MK7 || MGEODE_LX
+	depends on (MCYRIXIII || MK7 || MGEODE_LX) && !UML
 	default y
 
 config X86_OOSTORE

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

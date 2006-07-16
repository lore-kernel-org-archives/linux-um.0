Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G1xFV-0002lD-Oq for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 15 Jul 2006 20:24:53 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1G1xFU-0004Da-V2
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 15 Jul 2006 20:24:53 -0700
Date: Sat, 15 Jul 2006 23:24:40 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060716032440.GA5126@ccure.user-mode-linux.org>
References: <200607141952.k6EJqOtL005577@ccure.user-mode-linux.org>
	<44B996B2.8040202@garzik.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <44B996B2.8040202@garzik.org>
Subject: Re: [uml-devel] [PATCH] UML - fix utsname build breakage
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
To: Jeff Garzik <jeff@garzik.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Sat, Jul 15, 2006 at 09:30:26PM -0400, Jeff Garzik wrote:
> I can't find any 'JB_' symbols on my computer, except for the uses in 
> your source code.   :(

In libc, there used to be.

A quick and dirty patch, unsuitable for mainline is this:

Newer libcs don't define the JB_* jmp_buf access macros.  If this is
the case, we provide values ourselves.

Index: linux-2.6.15/arch/um/os-Linux/sys-i386/registers.c
===================================================================
--- linux-2.6.15.orig/arch/um/os-Linux/sys-i386/registers.c	2006-02-13 13:00:06.000000000 -0500
+++ linux-2.6.15/arch/um/os-Linux/sys-i386/registers.c	2006-02-13 13:04:07.000000000 -0500
@@ -130,6 +130,12 @@ void get_safe_registers(unsigned long *r
 		       HOST_FP_SIZE * sizeof(unsigned long));
 }
 
+#ifndef JB_PC
+#define JB_PC 5
+#define JB_SP 4
+#define JB_BP 3
+#endif
+
 void get_thread_regs(union uml_pt_regs *uml_regs, void *buffer)
 {
 	struct __jmp_buf_tag *jmpbuf = buffer;
Index: linux-2.6.15/arch/um/os-Linux/sys-x86_64/registers.c
===================================================================
--- linux-2.6.15.orig/arch/um/os-Linux/sys-x86_64/registers.c	2006-02-13 13:00:06.000000000 -0500
+++ linux-2.6.15/arch/um/os-Linux/sys-x86_64/registers.c	2006-02-13 13:04:07.000000000 -0500
@@ -78,6 +78,12 @@ void get_safe_registers(unsigned long *r
 		       HOST_FP_SIZE * sizeof(unsigned long));
 }
 
+#ifndef JB_PC
+#define JB_PC 7
+#define JB_RSP 6
+#define JB_RBP 1
+#endif
+
 void get_thread_regs(union uml_pt_regs *uml_regs, void *buffer)
 {
 	struct __jmp_buf_tag *jmpbuf = buffer;

I have a couple other patches, which may be better for mainline, which
take klibc's setjmp implementation.  My -mm patch grabs the
appropriate klibc header and object, and my mainline patch simply
copies the klibc sources into the UML tree.  If you want either of
those, let me know.

				Jeff


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

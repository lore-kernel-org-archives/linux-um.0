Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ft8XX-00084i-GM for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Jun 2006 12:39:03 -0700
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user67409)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Ft8XS-000727-S6
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Jun 2006 12:39:00 -0700
Received: from esperi.org.uk (nix@hades.wkstn.nix [192.168.14.18])
	by mail.esperi.org.uk (8.12.11.20060614/8.12.11) with ESMTP id
	k5LJcpXd002069 for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 21 Jun 2006 20:38:51 +0100
From: Nix <nix@esperi.org.uk>
Date: Wed, 21 Jun 2006 20:38:50 +0100
Message-ID: <87sllyl2np.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Subject: [uml-devel] problems compiling 2.6.17 against glibc 2.4
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
To: user-mode-linux-devel@lists.sourceforge.net

The problem is that arch/um/os-Linux/sys-i386/registers.c
messes around inside a jmp_buf, and in glibc 2.4 the glibc
maintainers have helpfully removed the definitions that
let you poke around in there (they were only there for the
sake of one macro, _JMPBUF_UNWINDS, which is no longer
user-visible.)

This vile patch lets me compile but is almost certainly not good enough:
however, I don't know what *is* good enough: now that glibc is blocking
us from the layout of the jmp_buf, what's to stop them from changing it?
(Well, other than that it would break the ABI ;) )

A temporary hack to make it compile is

--- linux-orig/arch/um/os-Linux/sys-i386/registers.c	2006-06-20 08:17:47.000000000 +0100
+++ linux/arch/um/os-Linux/sys-i386/registers.c	2006-06-21 07:54:52.000000000 +0100
@@ -130,6 +130,14 @@
 		       HOST_FP_SIZE * sizeof(unsigned long));
 }
 
+# define JB_BX  0
+# define JB_SI  1
+# define JB_DI  2
+# define JB_BP  3
+# define JB_SP  4
+# define JB_PC  5
+# define JB_SIZE 24
+
 void get_thread_regs(union uml_pt_regs *uml_regs, void *buffer)
 {
 	struct __jmp_buf_tag *jmpbuf = buffer;

but that's hardly acceptable in the long run.

-- 
`NB: Anyone suggesting that we should say "Tibibytes" instead of
 Terabytes there will be hunted down and brutally slain.
 That is all.' --- Matthew Wilcox

All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

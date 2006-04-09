Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FSXcM-0003p0-Ld for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Apr 2006 03:58:06 -0700
Received: from smtp-vbr14.xs4all.nl ([194.109.24.34])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FSXcM-0001q8-Da
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Apr 2006 03:58:06 -0700
Received: from xs2.xs4all.nl (xs2.xs4all.nl [194.109.21.3])
	by smtp-vbr14.xs4all.nl (8.13.6/8.13.6) with ESMTP id k39AvtNV019765
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 9 Apr 2006 12:57:56 +0200 (CEST)
	(envelope-from rjoris@xs4all.nl)
Received: from xs2.xs4all.nl (rjoris@localhost [127.0.0.1])
	by xs2.xs4all.nl (8.13.6/8.13.6) with ESMTP id k39AvtKL025136
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 9 Apr 2006 12:57:55 +0200 (CEST)
	(envelope-from rjoris@xs4all.nl)
Received: (from rjoris@localhost)
	by xs2.xs4all.nl (8.13.6/8.13.6/Submit) id k39AvtMf025135
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 9 Apr 2006 12:57:55 +0200 (CEST) (envelope-from rjoris)
From: Joris van Rantwijk <jvrantwijk@xs4all.nl>
Message-ID: <20060409105755.GA24319@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [PATCH] uml: problem with 2G/2G host address space
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
Date: Sun, 9 Apr 2006 12:57:55 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Hello,

I believe the current version (2.6.16.2) of UML does not work properly
on a i386 host with non-3G/1G address space split. The included patch
attempts to fix this.

On a i386 2.6.16.2 host configured with "3G/1G user/kernel split for
full 1G low memory" (VMSPLIT_3G_OPT), I found that UML would crash
on boot with the following error message:
  mapping mmap stub failed, errno = 12

It soon made sense to me that a 3G/1G configured UML would crash like
this, but I then found that UML 2.6.16.2 configured for 2G/2G crashed
in exactly the same way. I think this is due to the fact that STUB_CODE
and STUB_DATA are fixed at the 3G/1G settings. After changing these
settings, everything seems to work properly in 2G/2G mode.

Bye,
  Joris.

diff -urN -U 5 linux-2.6.16.2/arch/um/Kconfig.i386 linux-2.6.16.2-joris/arch/um/Kconfig.i386
--- linux-2.6.16.2/arch/um/Kconfig.i386	2006-04-07 18:56:47.000000000 +0200
+++ linux-2.6.16.2-joris/arch/um/Kconfig.i386	2006-04-09 11:33:46.000000000 +0200
@@ -33,15 +33,17 @@
 	However, this it experimental on 32-bit architectures, so if unsure say
 	N (on x86-64 it's automatically enabled, instead, as it's safe there).
 
 config STUB_CODE
 	hex
-	default 0xbfffe000
+	default 0xbfffe000 if !HOST_2G_2G
+	default 0x7fffe000 if HOST_2G_2G
 
 config STUB_DATA
 	hex
-	default 0xbffff000
+	default 0xbffff000 if !HOST_2G_2G
+	default 0x7ffff000 if HOST_2G_2G
 
 config STUB_START
 	hex
 	default STUB_CODE
 
--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KY51q-0001m0-6J for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Aug 2008 13:20:38 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KY51o-0005Yz-GZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Aug 2008 13:20:37 -0700
Date: Tue, 26 Aug 2008 16:20:12 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080826202012.GF24342@c2.user-mode-linux.org>
References: <20080813175125.19829.80844.reportbug@carrera.home.cobb.me.uk>
	<20080813221905.GA16104@inferi.kami.home>
	<200808140936.50696.graham@cobb.uk.net>
	<20080814113619.GA21758@inferi.kami.home>
	<20080819114704.GB7425@inferi.kami.home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080819114704.GB7425@inferi.kami.home>
Subject: Re: [uml-devel] Bug#494995: user-mode-linux: static build
	fails	with multiple definition of `strrchr'
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Mattia Dongili <malattia@linux.it>
Cc: 494995@bugs.debian.org, UML-devel <user-mode-linux-devel@lists.sourceforge.net>, Graham Cobb <graham@cobb.uk.net>

On Tue, Aug 19, 2008 at 08:47:04PM +0900, Mattia Dongili wrote:
> In short statically linking the uml kernel fails with the error below.
> Any idea what may be wrong?

A symbol clash between libc and the kernel.   Try this:

Index: linux-2.6.22/arch/um/Makefile
===================================================================
--- linux-2.6.22.orig/arch/um/Makefile	2008-07-07 12:54:13.000000000 -0400
+++ linux-2.6.22/arch/um/Makefile	2008-08-26 11:56:33.000000000 -0400
@@ -75,7 +75,8 @@ include $(srctree)/$(ARCH_DIR)/Makefile-
 # defines more robust
 
 KERNEL_DEFINES = $(strip -Derrno=kernel_errno -Dsigprocmask=kernel_sigprocmask \
-			 -Dmktime=kernel_mktime $(ARCH_KERNEL_DEFINES))
+			 -Dmktime=kernel_mktime -Dstrrchr=kernel_strrchr \
+			 $(ARCH_KERNEL_DEFINES))
 KBUILD_CFLAGS += $(KERNEL_DEFINES)
 
 PHONY += linux

			Jeff
-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

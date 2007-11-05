Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ip5Ux-0007nd-Vz for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Nov 2007 09:12:28 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ip5Ut-0004v7-NA
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Nov 2007 09:12:27 -0800
Date: Mon, 5 Nov 2007 12:12:13 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071105171213.GA7296@c2.user-mode-linux.org>
References: <20071102022749.GB8583@swingline.cs.wisc.edu>
	<20071102155131.GB5760@c2.user-mode-linux.org>
	<20071102162239.GA13481@swingline.cs.wisc.edu>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071102162239.GA13481@swingline.cs.wisc.edu>
Subject: Re: [uml-devel] building 2.6.24-rc1 with VDE in a non-standard
	location?
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
To: Erik Paulson <epaulson@cs.wisc.edu>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, Nov 02, 2007 at 11:22:44AM -0500, Erik Paulson wrote:
> running:
> make linux ARCH=um CFLAGS=-I/scratch/epaulson/vde/include

This isn't going to help with the compilation problems, but the patch
below seems to pass LFLAGS from the command line through to ld nicely.

>   CC      arch/um/kernel/skas/mmu.o
> In file included from include/asm/processor-generic.h:13,
>                  from include/asm/processor.h:77,
>                  from include/asm/thread_info.h:11,
>                  from include/linux/thread_info.h:21,
>                  from include/linux/preempt.h:9,
>                  from include/linux/spinlock.h:49,
>                  from include/linux/mmzone.h:7,
>                  from include/linux/gfp.h:4,
>                  from include/linux/mm.h:8,
>                  from arch/um/kernel/skas/mmu.c:6:
> include/asm/ptrace.h:50: warning: "struct user_fxsr_struct" declared inside parameter list
> include/asm/ptrace.h:50: warning: its scope is only this definition or declaration, which is probably not what you want
> include/asm/ptrace.h:52: warning: "struct user_fxsr_struct" declared
> inside parameter list

Does this happen with plain old defconfig?

				Jeff

-- 
Work email - jdike at linux dot intel dot com

Index: linux-2.6.22/arch/um/Makefile
===================================================================
--- linux-2.6.22.orig/arch/um/Makefile	2007-10-25 12:23:05.000000000 -0400
+++ linux-2.6.22/arch/um/Makefile	2007-11-05 12:02:49.000000000 -0500
@@ -127,7 +127,9 @@ CPPFLAGS_vmlinux.lds = -U$(SUBARCH) -DST
 # The wrappers will select whether using "malloc" or the kernel allocator.
 LINK_WRAPS = -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc
 
-CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS)
+LD_FLAGS_CMDLINE = $(foreach opt,$(LFLAGS),-Wl,$(opt))
+
+CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LD_FLAGS_CMDLINE)
 define cmd_vmlinux__
 	$(CC) $(CFLAGS_vmlinux) -o $@ \
 	-Wl,-T,$(vmlinux-lds) $(vmlinux-init) \

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

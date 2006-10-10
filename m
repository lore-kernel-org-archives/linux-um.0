Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GXAyV-0000q0-34 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 Oct 2006 23:20:23 -0700
Received: from mx2.suse.de ([195.135.220.15])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GXAyU-0006N7-C9
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 Oct 2006 23:20:23 -0700
From: <gregkh@suse.de>
Date: Mon, 09 Oct 2006 23:20:00 -0700
In-Reply-To: <11600768683307-git-send-email-blaisorblade@yahoo.it>
Message-Id: <20061010062015.21E838F9161@imap.suse.de>
Subject: [uml-devel] patch
	uml-allow-using-again-x86-x86_64-crypto-code.patch queued to
	-stable tree
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
To: blaisorblade@yahoo.it, gregkh@suse.de, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net
Cc: stable@kernel.org


This is a note to let we have just queued up the patch titled

     Subject: uml: allow using again x86/x86_64 crypto code

to the -stable tree.  Its filename is

     uml-allow-using-again-x86-x86_64-crypto-code.patch

A git repo of this tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/stable/stable-queue/


From stable-bounces@linux.kernel.org Thu Oct  5 14:10:24 2006
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
To: stable@kernel.org
Date: Thu,  5 Oct 2006 21:34:28 +0200
Message-Id: <11600768683307-git-send-email-blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>,
        "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>,
        <user-mode-linux-devel@lists.sourceforge.net>
Subject: uml: allow using again x86/x86_64 crypto code

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Enable compilation of x86_64 crypto code;, and add the needed constant
to make the code compile again (that macro was added to i386 asm-offsets
between 2.6.17 and 2.6.18, in 6c2bb98bc33ae33c7a33a133a4cd5a06395fece5).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Acked-by: Jeff Dike <jdike@addtoit.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/um/Makefile-x86_64                        |    2 +-
 arch/um/include/common-offsets.h               |    1 +
 arch/um/include/sysdep-i386/kernel-offsets.h   |    1 +
 arch/um/include/sysdep-x86_64/kernel-offsets.h |    1 +
 4 files changed, 4 insertions(+), 1 deletion(-)

--- linux-2.6.18.orig/arch/um/Makefile-x86_64
+++ linux-2.6.18/arch/um/Makefile-x86_64
@@ -1,7 +1,7 @@
 # Copyright 2003 - 2004 Pathscale, Inc
 # Released under the GPL
 
-core-y += arch/um/sys-x86_64/
+core-y += arch/um/sys-x86_64/ arch/x86_64/crypto/
 START := 0x60000000
 
 #We #undef __x86_64__ for kernelspace, not for userspace where
--- linux-2.6.18.orig/arch/um/include/common-offsets.h
+++ linux-2.6.18/arch/um/include/common-offsets.h
@@ -15,3 +15,4 @@ DEFINE_STR(UM_KERN_DEBUG, KERN_DEBUG);
 DEFINE(UM_ELF_CLASS, ELF_CLASS);
 DEFINE(UM_ELFCLASS32, ELFCLASS32);
 DEFINE(UM_ELFCLASS64, ELFCLASS64);
+DEFINE(crypto_tfm_ctx_offset, offsetof(struct crypto_tfm, __crt_ctx));
--- linux-2.6.18.orig/arch/um/include/sysdep-i386/kernel-offsets.h
+++ linux-2.6.18/arch/um/include/sysdep-i386/kernel-offsets.h
@@ -1,6 +1,7 @@
 #include <linux/stddef.h>
 #include <linux/sched.h>
 #include <linux/elf.h>
+#include <linux/crypto.h>
 #include <asm/mman.h>
 
 #define DEFINE(sym, val) \
--- linux-2.6.18.orig/arch/um/include/sysdep-x86_64/kernel-offsets.h
+++ linux-2.6.18/arch/um/include/sysdep-x86_64/kernel-offsets.h
@@ -2,6 +2,7 @@
 #include <linux/sched.h>
 #include <linux/time.h>
 #include <linux/elf.h>
+#include <linux/crypto.h>
 #include <asm/page.h>
 #include <asm/mman.h>
 


Patches currently in stable-queue which might be from blaisorblade@yahoo.it are

queue-2.6.18/uml-allow-using-again-x86-x86_64-crypto-code.patch
queue-2.6.18/uml-use-defconfig_list-to-avoid-reading-host-s-config.patch
queue-2.6.18/uml-fix-uml-build-failure.patch

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

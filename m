Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GVayp-0006YV-Sm for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Oct 2006 14:42:11 -0700
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GVayp-0000NA-BR
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Oct 2006 14:42:11 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Date: Thu, 05 Oct 2006 23:39:06 +0200
Message-Id: <20061005213906.17268.44290.stgit@memento.home.lan>
In-Reply-To: <20061005213212.17268.7409.stgit@memento.home.lan>
References: <20061005213212.17268.7409.stgit@memento.home.lan>
Subject: [uml-devel] [PATCH 10/14] uml: allow using again x86/x86_64 crypto
	code
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
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Enable compilation of x86_64 crypto code;, and add the needed constant to make
the code compile again (that macro was added to i386 asm-offsets between 2.6.17
and 2.6.18, in 6c2bb98bc33ae33c7a33a133a4cd5a06395fece5).

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/Makefile-x86_64                        |    2 +-
 arch/um/include/common-offsets.h               |    1 +
 arch/um/include/sysdep-i386/kernel-offsets.h   |    1 +
 arch/um/include/sysdep-x86_64/kernel-offsets.h |    1 +
 4 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/um/Makefile-x86_64 b/arch/um/Makefile-x86_64
index 87d6373..d278682 100644
--- a/arch/um/Makefile-x86_64
+++ b/arch/um/Makefile-x86_64
@@ -1,7 +1,7 @@
 # Copyright 2003 - 2004 Pathscale, Inc
 # Released under the GPL
 
-core-y += arch/um/sys-x86_64/
+core-y += arch/um/sys-x86_64/ arch/x86_64/crypto/
 START := 0x60000000
 
 _extra_flags_ = -fno-builtin -m64
diff --git a/arch/um/include/common-offsets.h b/arch/um/include/common-offsets.h
index 356390d..39bb210 100644
--- a/arch/um/include/common-offsets.h
+++ b/arch/um/include/common-offsets.h
@@ -15,3 +15,4 @@ DEFINE_STR(UM_KERN_DEBUG, KERN_DEBUG);
 DEFINE(UM_ELF_CLASS, ELF_CLASS);
 DEFINE(UM_ELFCLASS32, ELFCLASS32);
 DEFINE(UM_ELFCLASS64, ELFCLASS64);
+DEFINE(crypto_tfm_ctx_offset, offsetof(struct crypto_tfm, __crt_ctx));
diff --git a/arch/um/include/sysdep-i386/kernel-offsets.h b/arch/um/include/sysdep-i386/kernel-offsets.h
index 2c13de3..2e58c4c 100644
--- a/arch/um/include/sysdep-i386/kernel-offsets.h
+++ b/arch/um/include/sysdep-i386/kernel-offsets.h
@@ -1,6 +1,7 @@
 #include <linux/stddef.h>
 #include <linux/sched.h>
 #include <linux/elf.h>
+#include <linux/crypto.h>
 #include <asm/mman.h>
 
 #define DEFINE(sym, val) \
diff --git a/arch/um/include/sysdep-x86_64/kernel-offsets.h b/arch/um/include/sysdep-x86_64/kernel-offsets.h
index 91d129f..4cbfbb9 100644
--- a/arch/um/include/sysdep-x86_64/kernel-offsets.h
+++ b/arch/um/include/sysdep-x86_64/kernel-offsets.h
@@ -2,6 +2,7 @@ #include <linux/stddef.h>
 #include <linux/sched.h>
 #include <linux/time.h>
 #include <linux/elf.h>
+#include <linux/crypto.h>
 #include <asm/page.h>
 #include <asm/mman.h>
 
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

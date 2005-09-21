Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EI7kL-0001E7-VM	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 09:47:01 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EI7kL-0003vZ-Ar
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 09:47:01 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20050921163946.30500.54980.stgit@zion.home.lan>
In-Reply-To: <200509211822.17590.blaisorblade@yahoo.it>
References: <200509211822.17590.blaisorblade@yahoo.it>
Subject: [uml-devel] [PATCH 07/10] uml: fix bogus HOST_ELF_CLASS symbol name
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
Date: Wed, 21 Sep 2005 18:39:47 +0200
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Even if with a bit of misunderstanding, Al fixed this in commit
95608261dae863bc43292e6fbd946a3abd3aa49f.

Well, the symbol was intended to come from userspace (it exists there on normal
host), but since some hosts may miss that, using the kernel one is just as fine.
However, rename it to be named consistently with the rest.

Actually, he missed converting ELFCLASS32 to coming from kernel headers. For
consistence, add ELFCLASS64 too.

Cc: Al Viro <viro@ZenIV.linux.org.uk>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/include/common-offsets.h |    4 +++-
 arch/um/os-Linux/elf_aux.c       |    3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/um/include/common-offsets.h b/arch/um/include/common-offsets.h
--- a/arch/um/include/common-offsets.h
+++ b/arch/um/include/common-offsets.h
@@ -12,4 +12,6 @@ DEFINE_STR(UM_KERN_WARNING, KERN_WARNING
 DEFINE_STR(UM_KERN_NOTICE, KERN_NOTICE);
 DEFINE_STR(UM_KERN_INFO, KERN_INFO);
 DEFINE_STR(UM_KERN_DEBUG, KERN_DEBUG);
-DEFINE(HOST_ELF_CLASS, ELF_CLASS);
+DEFINE(UM_ELF_CLASS, ELF_CLASS);
+DEFINE(UM_ELFCLASS32, ELFCLASS32);
+DEFINE(UM_ELFCLASS64, ELFCLASS64);
diff --git a/arch/um/os-Linux/elf_aux.c b/arch/um/os-Linux/elf_aux.c
--- a/arch/um/os-Linux/elf_aux.c
+++ b/arch/um/os-Linux/elf_aux.c
@@ -14,7 +14,8 @@
 #include "mem_user.h"
 #include <kernel-offsets.h>
 
-#if HOST_ELF_CLASS == ELFCLASS32
+/* Use the one from the kernel - the host may miss it, if having old headers. */
+#if UM_ELF_CLASS == UM_ELFCLASS32
 typedef Elf32_auxv_t elf_auxv_t;
 #else
 typedef Elf64_auxv_t elf_auxv_t;



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

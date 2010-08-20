Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <roland@redhat.com>) id 1Omaik-00082l-9I
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Aug 2010 23:09:58 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Omaij-0001CU-AC for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Aug 2010 23:09:58 +0000
MIME-Version: 1.0
From: Roland McGrath <roland@redhat.com>
Message-Id: <20100820230938.16A5D402A4@magilla.sf.frob.com>
Date: Fri, 20 Aug 2010 16:09:37 -0700 (PDT)
Subject: [uml-devel] [PATCH] uml: fix CONFIG_STATIC_LINK=y build failure
	with newer glibc
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: Alexander Viro <aviro@redhat.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

The following changes since commit 36423a5ed5e4ea95ceedb68fad52965033e11639:

  Merge branch 'x86-fixes-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip (2010-08-20 14:25:08 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/frob/linux-2.6-roland.git uml/ld-irel

Roland McGrath (1):
      uml: fix CONFIG_STATIC_LINK=y build failure with newer glibc

 arch/um/kernel/dyn.lds.S |   14 ++++++++++++--
 arch/um/kernel/uml.lds.S |   17 +++++++++++++++++
 2 files changed, 29 insertions(+), 2 deletions(-)

Thanks,
Roland
---
[PATCH] uml: fix CONFIG_STATIC_LINK=y build failure with newer glibc

With glibc 2.11 or later that was built with --enable-multi-arch,
the UML link fails with undefined references to __rel_iplt_start and
similar symbols.  In recent binutils, the default linker script
defines these symbols (see ld --verbose).  Fix the UML linker
scripts to match the new defaults for these sections.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 arch/um/kernel/dyn.lds.S |   14 ++++++++++++--
 arch/um/kernel/uml.lds.S |   17 +++++++++++++++++
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/um/kernel/dyn.lds.S b/arch/um/kernel/dyn.lds.S
index 6926801..a3cab6d 100644
--- a/arch/um/kernel/dyn.lds.S
+++ b/arch/um/kernel/dyn.lds.S
@@ -50,8 +50,18 @@ SECTIONS
   .rela.got       : { *(.rela.got) }
   .rel.bss        : { *(.rel.bss .rel.bss.* .rel.gnu.linkonce.b.*) }
   .rela.bss       : { *(.rela.bss .rela.bss.* .rela.gnu.linkonce.b.*) }
-  .rel.plt        : { *(.rel.plt) }
-  .rela.plt       : { *(.rela.plt) }
+  .rel.plt : {
+	*(.rel.plt)
+	PROVIDE_HIDDEN(__rel_iplt_start = .);
+	*(.rel.iplt)
+	PROVIDE_HIDDEN(__rel_iplt_end = .);
+  }
+  .rela.plt : {
+	*(.rela.plt)
+	PROVIDE_HIDDEN(__rela_iplt_start = .);
+	*(.rela.iplt)
+	PROVIDE_HIDDEN(__rela_iplt_end = .);
+  }
   .init           : {
     KEEP (*(.init))
   } =0x90909090
diff --git a/arch/um/kernel/uml.lds.S b/arch/um/kernel/uml.lds.S
index ec63785..a7cbffb 100644
--- a/arch/um/kernel/uml.lds.S
+++ b/arch/um/kernel/uml.lds.S
@@ -43,6 +43,23 @@ SECTIONS
 	__syscall_stub_end = .;
   }
 
+  /*
+   * These are needed even in a static link, even if they wind up being empty.
+   * Newer glibc needs these __rel{,a}_iplt_{start,end} symbols.
+   */
+  .rel.plt : {
+	*(.rel.plt)
+	PROVIDE_HIDDEN(__rel_iplt_start = .);
+	*(.rel.iplt)
+	PROVIDE_HIDDEN(__rel_iplt_end = .);
+  }
+  .rela.plt : {
+	*(.rela.plt)
+	PROVIDE_HIDDEN(__rela_iplt_start = .);
+	*(.rela.iplt)
+	PROVIDE_HIDDEN(__rela_iplt_end = .);
+  }
+
   #include "asm/common.lds.S"
 
   init.data : { INIT_DATA }

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


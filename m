Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iN8kh-0001YJ-0p
 for linux-um@lists.infradead.org; Wed, 23 Oct 2019 05:00:09 +0000
Received: by mail-pf1-x441.google.com with SMTP id 205so12120876pfw.2
 for <linux-um@lists.infradead.org>; Tue, 22 Oct 2019 22:00:06 -0700 (PDT)
From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC PATCH 39/47] Revert "linux/linkage.h: replace
 VMLINUX_SYMBOL_STR() with __stringify()"
Date: Wed, 23 Oct 2019 13:38:13 +0900
Message-Id: <eb9db951afd13b7cca9b77abf804805078dddd32.1571798507.git.thehajime@gmail.com>
In-Reply-To: <cover.1571798507.git.thehajime@gmail.com>
References: <cover.1571798507.git.thehajime@gmail.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: Octavian Purdila <tavi.purdila@gmail.com>, Hajime Tazaki <thehajime@gmail.com>, Akira Moroo <retrage01@gmail.com>

for lkl, mingw32 requires underscore-ed symbols.

This reverts commit 00979ce4fcc90d488c7f27f750097adc6b11bd07.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 include/linux/linkage.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index 7e020782ade2..d287823ee947 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -24,16 +24,16 @@
 
 #ifndef cond_syscall
 #define cond_syscall(x)	asm(				\
-	".weak " __stringify(x) "\n\t"			\
-	".set  " __stringify(x) ","			\
-		 __stringify(sys_ni_syscall))
+	".weak " VMLINUX_SYMBOL_STR(x) "\n\t"		\
+	".set  " VMLINUX_SYMBOL_STR(x) ","		\
+		 VMLINUX_SYMBOL_STR(sys_ni_syscall))
 #endif
 
 #ifndef SYSCALL_ALIAS
 #define SYSCALL_ALIAS(alias, name) asm(			\
-	".globl " __stringify(alias) "\n\t"		\
-	".set   " __stringify(alias) ","		\
-		  __stringify(name))
+	".globl " VMLINUX_SYMBOL_STR(alias) "\n\t"	\
+	".set   " VMLINUX_SYMBOL_STR(alias) ","		\
+		  VMLINUX_SYMBOL_STR(name))
 #endif
 
 #define __page_aligned_data	__section(.data..page_aligned) __aligned(PAGE_SIZE)
-- 
2.20.1 (Apple Git-117)


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


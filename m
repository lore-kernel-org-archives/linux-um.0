Return-Path: <linux-kernel-owner+geert=40linux-m68k.org-S1756094AbZCJOTe@vger.kernel.org>
Date: Tue, 10 Mar 2009 22:19:38 +0800
From: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Subject: [Patch] uml: fix WARNING: vmlinux: 'memcpy' exported twice.
Message-ID: <20090310141938.GE3157@hack>
References: <49AFC206.9080004@panasas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49AFC206.9080004@panasas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Boaz Harrosh <bharrosh@panasas.com>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>, linux-kernel <linux-kernel@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@osdl.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>



This patch fixes the following warning on x86_64:

LD vmlinux.o
MODPOST vmlinux.o
WARNING: vmlinux: 'memcpy' exported twice. Previous export was in
vmlinux

Reported-by: Boaz Harrosh <bharrosh@panasas.com>
Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>
Tested-by: Boaz Harrosh <bharrosh@panasas.com>
Cc: Jeff Dike <jdike@addtoit.com>

---
diff --git a/arch/um/os-Linux/user_syms.c b/arch/um/os-Linux/user_syms.c
index 74f49bb..89b48a1 100644
--- a/arch/um/os-Linux/user_syms.c
+++ b/arch/um/os-Linux/user_syms.c
@@ -14,7 +14,6 @@
 #undef memset
 
 extern size_t strlen(const char *);
-extern void *memcpy(void *, const void *, size_t);
 extern void *memmove(void *, const void *, size_t);
 extern void *memset(void *, int, size_t);
 extern int printf(const char *, ...);
@@ -24,7 +23,11 @@ extern int printf(const char *, ...);
 EXPORT_SYMBOL(strstr);
 #endif
 
+#ifndef __x86_64__
+extern void *memcpy(void *, const void *, size_t);
 EXPORT_SYMBOL(memcpy);
+#endif
+
 EXPORT_SYMBOL(memmove);
 EXPORT_SYMBOL(memset);
 EXPORT_SYMBOL(printf);

 

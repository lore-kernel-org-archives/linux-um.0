Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1495059066.27187.2.camel@m3y3r.de>
Subject: [PATCH] um: Add mark_rodata_ro support.
From: Thomas Meyer <thomas@m3y3r.de>
Date: Thu, 18 May 2017 00:11:06 +0200
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This is actually a no-op as all read-only should be read-only in the ELF.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---
 arch/um/Kconfig.common | 1 +
 arch/um/kernel/mem.c   | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/um/Kconfig.common b/arch/um/Kconfig.common
index 85f6dd2..061009b 100644
--- a/arch/um/Kconfig.common
+++ b/arch/um/Kconfig.common
@@ -2,6 +2,7 @@ config UML
 	bool
 	default y
 	select ARCH_HAS_KCOV
+	select ARCH_HAS_STRICT_KERNEL_RWX
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_UID16
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index e7437ec..027ed03 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -168,7 +168,6 @@ void __init paging_init(void)
  * This can't do anything because nothing in the kernel image can be freed
  * since it's not in kernel physical memory.
  */
-
 void free_initmem(void)
 {
 }
@@ -238,3 +237,7 @@ void *uml_kmalloc(int size, int flags)
 {
 	return kmalloc(size, flags);
 }
+
+void mark_rodata_ro(void)
+{
+}


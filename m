Return-Path: <linux-kernel-owner+geert=40linux-m68k.org-S1751174AbZEKETA@vger.kernel.org>
Date: Mon, 11 May 2009 00:17:25 -0400
From: Amerigo Wang <amwang@redhat.com>
Message-Id: <20090511041817.23062.95361.sendpatchset@localhost.localdomain>
Subject: [PATCH][Resend] uml: fix a section warning
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net, jdike@addtoit.com, sam@ravnborg.org, Amerigo Wang <amwang@redhat.com>, akpm@linux-foundation.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>


When I compiled uml on x86_64, I got this warning:

  MODPOST vmlinux.o
WARNING: vmlinux.o (.__syscall_stub.2): unexpected non-allocatable section.
Did you forget to use "ax"/"aw" in a .S file?
Note that for example <linux/init.h> contains
section definitions for use in .S files.

Because modpost checks for missing SHF_ALLOC section flag. So just
add it. :)

Signed-off-by: WANG Cong <amwang@redhat.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Sam Ravnborg <sam@ravnborg.org>

---
diff --git a/arch/um/sys-x86_64/stub.S b/arch/um/sys-x86_64/stub.S
index 6d9edf9..20e4a96 100644
--- a/arch/um/sys-x86_64/stub.S
+++ b/arch/um/sys-x86_64/stub.S
@@ -1,7 +1,7 @@
 #include "as-layout.h"
 
 	.globl syscall_stub
-.section .__syscall_stub, "x"
+.section .__syscall_stub, "ax"
 syscall_stub:
 	syscall
 	/* We don't have 64-bit constants, so this constructs the address
diff --git a/arch/um/sys-i386/stub.S b/arch/um/sys-i386/stub.S
index c41b04b..54a36ec 100644
--- a/arch/um/sys-i386/stub.S
+++ b/arch/um/sys-i386/stub.S
@@ -1,7 +1,7 @@
 #include "as-layout.h"
 
 	.globl syscall_stub
-.section .__syscall_stub, "x"
+.section .__syscall_stub, "ax"
 
 	.globl batch_syscall_stub
 batch_syscall_stub:

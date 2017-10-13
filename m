Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Thomas Meyer <thomas@m3y3r.de>
Subject: [PATCH] um: Fix kcov crash before kernel is started.
Date: Sat, 14 Oct 2017 00:00:25 +0200
Message-Id: <20171013220025.3619-1-thomas@m3y3r.de>
In-Reply-To: <CACT4Y+Ye1Yw3SPCy80_JAqNGdqtSFTMVMc02-rbfJv1omT5Qhw@mail.gmail.com>
References: <CACT4Y+Ye1Yw3SPCy80_JAqNGdqtSFTMVMc02-rbfJv1omT5Qhw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: syzkaller@googlegroups.com, richard@nod.at, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Thomas Meyer <thomas@m3y3r.de>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

UMLs current_thread_info() unconditionally assumes that the top of the stack
contains the thread_info structure.
Prevent kcov from using invalid curent_thread_info() data by disable
instrumentation of early startup code.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---
 arch/um/kernel/skas/Makefile | 2 ++
 lib/Makefile                 | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/arch/um/kernel/skas/Makefile b/arch/um/kernel/skas/Makefile
index 0b76d8869c94..df3aedb974a2 100644
--- a/arch/um/kernel/skas/Makefile
+++ b/arch/um/kernel/skas/Makefile
@@ -3,6 +3,8 @@
 # Licensed under the GPL
 #
 
+KCOV_INSTRUMENT                := n
+
 obj-y := clone.o mmu.o process.o syscall.o uaccess.o
 
 # clone.o is in the stub, so it can't be built with profiling
diff --git a/lib/Makefile b/lib/Makefile
index dafa79613fb4..18319ad5daab 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -16,6 +16,10 @@ KCOV_INSTRUMENT_list_debug.o := n
 KCOV_INSTRUMENT_debugobjects.o := n
 KCOV_INSTRUMENT_dynamic_debug.o := n
 
+ifdef CONFIG_UML
+KCOV_INSTRUMENT_cmdline.o := n
+endif
+
 lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 rbtree.o radix-tree.o dump_stack.o timerqueue.o\
 	 idr.o int_sqrt.o extable.o \
-- 
2.11.0



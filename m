Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 63/66] arch/um/sys-ppc/shared/sysdep/skas_ptrace.h: Checkpatch cleanup
Date: Sat, 27 Feb 2010 17:51:44 +0100
Message-Id: <1267289508-31031-64-git-send-email-andrea.gelmini@gelma.net>
In-Reply-To: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
References: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Andrea Gelmini <andrea.gelmini@gelma.net>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

arch/um/sys-ppc/shared/sysdep/skas_ptrace.h:10: ERROR: code indent should use tabs where possible
arch/um/sys-ppc/shared/sysdep/skas_ptrace.h:11: ERROR: code indent should use tabs where possible
arch/um/sys-ppc/shared/sysdep/skas_ptrace.h:15: ERROR: code indent should use tabs where possible
arch/um/sys-ppc/shared/sysdep/skas_ptrace.h:16: ERROR: code indent should use tabs where possible
arch/um/sys-ppc/shared/sysdep/skas_ptrace.h:17: ERROR: code indent should use tabs where possible

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/um/sys-ppc/shared/sysdep/skas_ptrace.h |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/um/sys-ppc/shared/sysdep/skas_ptrace.h b/arch/um/sys-ppc/shared/sysdep/skas_ptrace.h
index d9fbbac..f26f93b 100644
--- a/arch/um/sys-ppc/shared/sysdep/skas_ptrace.h
+++ b/arch/um/sys-ppc/shared/sysdep/skas_ptrace.h
@@ -7,14 +7,14 @@
 #define __SYSDEP_PPC_SKAS_PTRACE_H
 
 struct ptrace_faultinfo {
-        int is_write;
-        unsigned long addr;
+	int is_write;
+	unsigned long addr;
 };
 
 struct ptrace_ldt {
-        int func;
-        void *ptr;
-        unsigned long bytecount;
+	int func;
+	void *ptr;
+	unsigned long bytecount;
 };
 
 #define PTRACE_LDT 54
-- 
1.7.0.90.g251a4


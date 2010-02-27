Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 65/66] arch/um/sys-ia64/sysdep/skas_ptrace.h: Checkpatch cleanup
Date: Sat, 27 Feb 2010 17:51:46 +0100
Message-Id: <1267289508-31031-66-git-send-email-andrea.gelmini@gelma.net>
In-Reply-To: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
References: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Andrea Gelmini <andrea.gelmini@gelma.net>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

arch/um/sys-ia64/sysdep/skas_ptrace.h:10: ERROR: code indent should use tabs where possible
arch/um/sys-ia64/sysdep/skas_ptrace.h:11: ERROR: code indent should use tabs where possible
arch/um/sys-ia64/sysdep/skas_ptrace.h:15: ERROR: code indent should use tabs where possible
arch/um/sys-ia64/sysdep/skas_ptrace.h:16: ERROR: code indent should use tabs where possible
arch/um/sys-ia64/sysdep/skas_ptrace.h:17: ERROR: code indent should use tabs where possible

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/um/sys-ia64/sysdep/skas_ptrace.h |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/um/sys-ia64/sysdep/skas_ptrace.h b/arch/um/sys-ia64/sysdep/skas_ptrace.h
index 25a38e7..b49be9e 100644
--- a/arch/um/sys-ia64/sysdep/skas_ptrace.h
+++ b/arch/um/sys-ia64/sysdep/skas_ptrace.h
@@ -7,14 +7,14 @@
 #define __SYSDEP_IA64_SKAS_PTRACE_H
 
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


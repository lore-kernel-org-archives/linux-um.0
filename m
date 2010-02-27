Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 14/66] arch/um/sys-ia64/sysdep/ptrace.h: Checkpatch cleanup
Date: Sat, 27 Feb 2010 17:50:55 +0100
Message-Id: <1267289508-31031-15-git-send-email-andrea.gelmini@gelma.net>
In-Reply-To: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
References: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Andrea Gelmini <andrea.gelmini@gelma.net>, Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@linux-foundation.org>, WANG Cong <xiyou.wangcong@gmail.com>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

arch/um/sys-ia64/sysdep/ptrace.h:1: ERROR: trailing whitespace

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/um/sys-ia64/sysdep/ptrace.h |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/um/sys-ia64/sysdep/ptrace.h b/arch/um/sys-ia64/sysdep/ptrace.h
index 0f0f4e6..8e85f09 100644
--- a/arch/um/sys-ia64/sysdep/ptrace.h
+++ b/arch/um/sys-ia64/sysdep/ptrace.h
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
  * Licensed under the GPL
  */
@@ -13,4 +13,3 @@ struct sys_pt_regs {
 #define EMPTY_REGS { 0 }
 
 #endif
-
-- 
1.7.0.90.g251a4


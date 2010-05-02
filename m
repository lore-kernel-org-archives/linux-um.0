Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Nicolas Thill <nicolas.thill@gmail.com>
Subject: [PATCH] UML: x86_64: fix memcpy export
Date: Mon,  3 May 2010 01:58:20 +0200
Message-Id: <1272844700-32496-1-git-send-email-nico@openwrt.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Nicolas Thill <nico@openwrt.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

./arch/um/sys-x86_64/ksyms.c exports memcpy or __memcpy depending on the gcc
version, use the same logic in ./arch/um/os-Linux/user_syms.c

Signed-off-by: Nicolas Thill <nico@openwrt.org>
---
 arch/um/os-Linux/user_syms.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/um/os-Linux/user_syms.c b/arch/um/os-Linux/user_syms.c
index 89b48a1..e3a12dd 100644
--- a/arch/um/os-Linux/user_syms.c
+++ b/arch/um/os-Linux/user_syms.c
@@ -23,7 +23,8 @@ extern int printf(const char *, ...);
 EXPORT_SYMBOL(strstr);
 #endif
 
-#ifndef __x86_64__
+#if !defined(__x86_64) || \
+	(__GNUC__ == 4 && __GNUC_MINOR__ < 3) || (__GNUC__ < 4)
 extern void *memcpy(void *, const void *, size_t);
 EXPORT_SYMBOL(memcpy);
 #endif
-- 
1.6.0.4


Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 15/66] arch/um/drivers/ssl.h: Checkpatch cleanup
Date: Sat, 27 Feb 2010 17:50:56 +0100
Message-Id: <1267289508-31031-16-git-send-email-andrea.gelmini@gelma.net>
In-Reply-To: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
References: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Andrea Gelmini <andrea.gelmini@gelma.net>, Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@linux-foundation.org>, WANG Cong <xiyou.wangcong@gmail.com>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

arch/um/drivers/ssl.h:1: ERROR: trailing whitespace

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/um/drivers/ssl.h |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/ssl.h b/arch/um/drivers/ssl.h
index 314d177..de82843 100644
--- a/arch/um/drivers/ssl.h
+++ b/arch/um/drivers/ssl.h
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
  * Licensed under the GPL
  */
@@ -10,4 +10,3 @@ extern int ssl_read(int fd, int line);
 extern void ssl_receive_char(int line, char ch);
 
 #endif
-
-- 
1.7.0.90.g251a4


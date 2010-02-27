Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 36/66] arch/um/include/shared/ubd_user.h: Checkpatch cleanup
Date: Sat, 27 Feb 2010 17:51:17 +0100
Message-Id: <1267289508-31031-37-git-send-email-andrea.gelmini@gelma.net>
In-Reply-To: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
References: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Andrea Gelmini <andrea.gelmini@gelma.net>, Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@linux-foundation.org>, WANG Cong <xiyou.wangcong@gmail.com>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

arch/um/include/shared/ubd_user.h:1: ERROR: trailing whitespace

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/um/include/shared/ubd_user.h |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/um/include/shared/ubd_user.h b/arch/um/include/shared/ubd_user.h
index 3845051..9198fa3 100644
--- a/arch/um/include/shared/ubd_user.h
+++ b/arch/um/include/shared/ubd_user.h
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
  * Copyright (C) 2001 RidgeRun, Inc (glonnon@ridgerun.com)
  * Licensed under the GPL
@@ -13,4 +13,3 @@ extern int io_thread(void *arg);
 extern int kernel_fd;
 
 #endif
-
-- 
1.7.0.90.g251a4


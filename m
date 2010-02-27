Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 39/66] arch/um/drivers/pcap_user.h: Checkpatch cleanup
Date: Sat, 27 Feb 2010 17:51:20 +0100
Message-Id: <1267289508-31031-40-git-send-email-andrea.gelmini@gelma.net>
In-Reply-To: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
References: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Andrea Gelmini <andrea.gelmini@gelma.net>, Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@linux-foundation.org>, WANG Cong <xiyou.wangcong@gmail.com>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

arch/um/drivers/pcap_user.h:1: ERROR: trailing whitespace

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/um/drivers/pcap_user.h |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/pcap_user.h b/arch/um/drivers/pcap_user.h
index d8ba615..6ff1c46 100644
--- a/arch/um/drivers/pcap_user.h
+++ b/arch/um/drivers/pcap_user.h
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
  * Licensed under the GPL
  */
@@ -18,4 +18,3 @@ struct pcap_data {
 extern const struct net_user_info pcap_user_info;
 
 extern int pcap_user_read(int fd, void *buf, int len, struct pcap_data *pri);
-
-- 
1.7.0.90.g251a4


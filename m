Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A43FC54731
	for <linux-um@archiver.kernel.org>; Mon, 26 Aug 2024 10:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9bUZVJugjOokUMlJ2o17PYTbMBQk6FoNOY0ajvacRoI=; b=oCqXDuMtihYaKUonJQcKitZPTI
	coBtsCKYlfXSJLmEzs1ag1OHtNQjiejI4vCzgH8pZpbIR2VzT+Jx8Fu/cD8WbO0Eaul2S80UAMMVn
	KeKVCb8PIWIeuH6XpYb9m3uhMLxXZ+t30OFQLBYyvb1LsySZwxFwPLri9h5HlO8xlvyhIZoGoaqhZ
	yhLucLKrXPEcK20T2hvq6y4eSPKLzpNuwLNHR1xiTC3JXxjTIFL6wVmgQj9CGLW/3G/1Zsxn691DL
	bNJxhteduDIR9qoiLhKusrt7rK0CySIQLtJyuYQKl1pwj4IR3kh1UPl1YLXDML2vymhYSXHGFvHbW
	0mX1jofA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siWll-00000006syb-0VV3;
	Mon, 26 Aug 2024 10:16:17 +0000
Received: from out0-205.mail.aliyun.com ([140.205.0.205])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siWeI-00000006qu6-1WAd
	for linux-um@lists.infradead.org;
	Mon, 26 Aug 2024 10:08:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1724666910; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=9bUZVJugjOokUMlJ2o17PYTbMBQk6FoNOY0ajvacRoI=;
	b=hWMjgIngDI7mPw5tiV8oXhGeyyoyD4apLPzLH7bB1+hnQuvda8ZJbbO2TwtGYhJwXoQaPIChTKRRg4vP6Lo7e/uIQ5sYrhMkv0Na5jjxI3/Fx9CGfwrdfWZqnfOdL7Vx9qCmb9bEEaL3QYGoLaom3oxf0pAJKgmI09r5IyUPyTI=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Z2YRsdP_1724666908)
          by smtp.aliyun-inc.com;
          Mon, 26 Aug 2024 18:08:28 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v3 7/7] um: Remove outdated asm/sysrq.h header
Date: Mon, 26 Aug 2024 18:08:15 +0800
Message-Id: <20240826100815.904430-8-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826100815.904430-1-tiwei.btw@antgroup.com>
References: <20240826100815.904430-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240826_030834_688887_B00060F2 
X-CRM114-Status: UNSURE (   7.47  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

This header no longer serves a purpose after show_trace was removed
by commit 9d1ee8ce92e1 ("um: Rewrite show_stack()").

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/asm/sysrq.h | 8 --------
 arch/um/kernel/sysrq.c      | 1 -
 arch/x86/um/sysrq_32.c      | 1 -
 arch/x86/um/sysrq_64.c      | 1 -
 4 files changed, 11 deletions(-)
 delete mode 100644 arch/um/include/asm/sysrq.h

diff --git a/arch/um/include/asm/sysrq.h b/arch/um/include/asm/sysrq.h
deleted file mode 100644
index 8fc8c65cd357..000000000000
--- a/arch/um/include/asm/sysrq.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __UM_SYSRQ_H
-#define __UM_SYSRQ_H
-
-struct task_struct;
-extern void show_trace(struct task_struct* task, unsigned long *stack);
-
-#endif
diff --git a/arch/um/kernel/sysrq.c b/arch/um/kernel/sysrq.c
index 746715379f12..4bb8622dc512 100644
--- a/arch/um/kernel/sysrq.c
+++ b/arch/um/kernel/sysrq.c
@@ -11,7 +11,6 @@
 #include <linux/sched/debug.h>
 #include <linux/sched/task_stack.h>
 
-#include <asm/sysrq.h>
 #include <asm/stacktrace.h>
 #include <os.h>
 
diff --git a/arch/x86/um/sysrq_32.c b/arch/x86/um/sysrq_32.c
index f2383484840d..a1ee415c008d 100644
--- a/arch/x86/um/sysrq_32.c
+++ b/arch/x86/um/sysrq_32.c
@@ -9,7 +9,6 @@
 #include <linux/sched/debug.h>
 #include <linux/kallsyms.h>
 #include <asm/ptrace.h>
-#include <asm/sysrq.h>
 
 /* This is declared by <linux/sched.h> */
 void show_regs(struct pt_regs *regs)
diff --git a/arch/x86/um/sysrq_64.c b/arch/x86/um/sysrq_64.c
index 0bf6de40abff..340d8a243c8a 100644
--- a/arch/x86/um/sysrq_64.c
+++ b/arch/x86/um/sysrq_64.c
@@ -12,7 +12,6 @@
 #include <linux/utsname.h>
 #include <asm/current.h>
 #include <asm/ptrace.h>
-#include <asm/sysrq.h>
 
 void show_regs(struct pt_regs *regs)
 {
-- 
2.34.1



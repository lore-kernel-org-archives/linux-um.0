Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA82C4345F
	for <linux-um@archiver.kernel.org>; Tue, 23 Apr 2024 11:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=35K+byay5rbsmnKXw4pAmKxWNtRGPhfuJu7mpbXe+7w=; b=XMQoPJxM4CM+7QO2YsCtg5ynxe
	Ycd0l7XIAUcW5F3GXrjx7N26Jt7nvHxLNOU9Clm2+wyCrkFMv/onfoSaObcDBZSETI3JOGiWmVOJX
	NWcYhfnhJm3n2AYlONhv7DA2bIT9Bm4se2V/Z7HaXtgVgkGCg5kaB3wc9mAT/SPaFyYn7akNAcQpW
	RFodpv904v1tInAWPGzD0XRBq+1RtB1zLvpdBMPsJz69qOB8GQ3MsgOM3V51zEaxSGQTUyAWng17L
	Eu0rBEnorYSYmRBPNeYCqJWWkQx53hMYeAsiooHqbgc0LE0URmpnq5EMT9I78g+vAXx1xK6OkIxEg
	xMobst0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzEH5-0000000H5Gs-3Zae;
	Tue, 23 Apr 2024 11:25:23 +0000
Received: from out0-209.mail.aliyun.com ([140.205.0.209])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzEH1-0000000H5BQ-1ySb
	for linux-um@lists.infradead.org;
	Tue, 23 Apr 2024 11:25:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1713871513; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=35K+byay5rbsmnKXw4pAmKxWNtRGPhfuJu7mpbXe+7w=;
	b=zpOORgxm7y4rkGhVbqR04m2MFyKaDYASe2TUzeKv1mXU2S4H/xiRBR/iDPWdwYJQLJPGZMHKOZ5+q/CVn7q8e1PUDhYVU2OAdxGDX3+rlqE8JO1yEgssL7h4kzqiPK2YsW0Me4MDZKNDD0bb3Qp/24diOQW1WKS/lZK8VEi+K0w=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047212;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.XJTUYhj_1713871512;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.XJTUYhj_1713871512)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 19:25:12 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 1/7] um: Fix -Wmissing-prototypes warnings for (rt_)sigreturn
Date: Tue, 23 Apr 2024 19:24:51 +0800
Message-Id: <20240423112457.2409319-2-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423112457.2409319-1-tiwei.btw@antgroup.com>
References: <20240423112457.2409319-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240423_042520_360688_4B324A4A 
X-CRM114-Status: UNSURE (   7.20  )
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

Use SYSCALL_DEFINE0 to define (rt_)sigreturn. This will address
below -Wmissing-prototypes warnings:

arch/x86/um/signal.c:453:6: warning: no previous prototype for ‘sys_sigreturn’ [-Wmissing-prototypes]
arch/x86/um/signal.c:560:6: warning: no previous prototype for ‘sys_rt_sigreturn’ [-Wmissing-prototypes]

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/x86/um/signal.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/um/signal.c b/arch/x86/um/signal.c
index 263e1d08f216..48e87b45adba 100644
--- a/arch/x86/um/signal.c
+++ b/arch/x86/um/signal.c
@@ -8,6 +8,7 @@
 #include <linux/personality.h>
 #include <linux/ptrace.h>
 #include <linux/kernel.h>
+#include <linux/syscalls.h>
 #include <asm/unistd.h>
 #include <linux/uaccess.h>
 #include <asm/ucontext.h>
@@ -450,7 +451,7 @@ int setup_signal_stack_si(unsigned long stack_top, struct ksignal *ksig,
 	return 0;
 }
 
-long sys_sigreturn(void)
+SYSCALL_DEFINE0(sigreturn)
 {
 	unsigned long sp = PT_REGS_SP(&current->thread.regs);
 	struct sigframe __user *frame = (struct sigframe __user *)(sp - 8);
@@ -557,7 +558,7 @@ int setup_signal_stack_si(unsigned long stack_top, struct ksignal *ksig,
 }
 #endif
 
-long sys_rt_sigreturn(void)
+SYSCALL_DEFINE0(rt_sigreturn)
 {
 	unsigned long sp = PT_REGS_SP(&current->thread.regs);
 	struct rt_sigframe __user *frame =
-- 
2.34.1



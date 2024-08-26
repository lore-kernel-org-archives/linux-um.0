Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B31C5472F
	for <linux-um@archiver.kernel.org>; Mon, 26 Aug 2024 10:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UE3KVmrhR4CaBxvq16dvb3ocgiXdhekFGviHku9aBeM=; b=EdewVI2KOxxzmospm2npaXLMPc
	AKdO4zJiBBDdJUasSDV3ko9h0YTRcv+THiYEYPwo5F3qkfkkfd6ME3fLginQ0OAOeEF1gCSKXA3yR
	OLOGXH9aTkbnNoe5sl0u93cD50d9JncaNeDHGkelPUogDPU10nnDMNMuiLZ3UsA9ojRVPGf45xmHe
	uAkj7NlGa72D6V0cBcoLxG5EYjT46RxaKht1yQCl6WeYrJcvhRkWRh6YDm7XlRuC9nKZOxNnIvm+z
	vqP7Ot0BJ0zXlKaO9qozyDXHZjbCRHB7soaJfu4uGslYKJFXGbJbv/oN1yzoCd0ekuTnkV5Xf0P8z
	et2Jcc1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siWll-00000006syu-220g;
	Mon, 26 Aug 2024 10:16:17 +0000
Received: from out0-204.mail.aliyun.com ([140.205.0.204])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siWeH-00000006quC-0Yel
	for linux-um@lists.infradead.org;
	Mon, 26 Aug 2024 10:08:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1724666911; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=UE3KVmrhR4CaBxvq16dvb3ocgiXdhekFGviHku9aBeM=;
	b=KpiKwewwCeJuypwK6j+/N3figu93mp7qvXSa6qg2gJmVCZse4g1OEmemn8K44eV7pDUtv5nV41O6h1ZCpafbWlqQElDcT+oCUS3uuR0q0HMLrwVUbHtnura10Xt2tTuiexoSVdnIfeOzNde02bZB5h/uaVeBxXtjYnnx2k7TR6U=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Z2YRsd5_1724666907)
          by smtp.aliyun-inc.com;
          Mon, 26 Aug 2024 18:08:28 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v3 5/7] um: Remove the call to SUBARCH_EXECVE1 macro
Date: Mon, 26 Aug 2024 18:08:13 +0800
Message-Id: <20240826100815.904430-6-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826100815.904430-1-tiwei.btw@antgroup.com>
References: <20240826100815.904430-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240826_030833_698886_B9500BAB 
X-CRM114-Status: UNSURE (   4.97  )
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

This macro has never been defined by any supported sub-architectures
in tree since it was introduced by commit 1d3468a6643a ("[PATCH uml:
move _kern.c files").

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/kernel/exec.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/um/kernel/exec.c b/arch/um/kernel/exec.c
index 2c15bb2c104c..cb8b5cd9285c 100644
--- a/arch/um/kernel/exec.c
+++ b/arch/um/kernel/exec.c
@@ -35,8 +35,5 @@ void start_thread(struct pt_regs *regs, unsigned long eip, unsigned long esp)
 	PT_REGS_IP(regs) = eip;
 	PT_REGS_SP(regs) = esp;
 	clear_thread_flag(TIF_SINGLESTEP);
-#ifdef SUBARCH_EXECVE1
-	SUBARCH_EXECVE1(regs->regs);
-#endif
 }
 EXPORT_SYMBOL(start_thread);
-- 
2.34.1



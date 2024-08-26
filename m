Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E137C54732
	for <linux-um@archiver.kernel.org>; Mon, 26 Aug 2024 10:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ETHDtkvAR5yLwocf1NNAJDJIgmGgz2GYbC6AhVsHb1U=; b=F1dbw5d046Y+8BjX84mIZVC5B9
	SmCtNNBS7C8AT1DWC/sKbLKI/PMRoh0UnThudNY0QTqLtW1T9AFmrb3379Rb8Smh/0+zgmBcM2sxY
	KibUY486HImIwqFYWdBDwqH2Ite+vaRSQlcH/7PLTCzTeZBMNy0yYl6irbC2COk6A7h8Z2eCbITzL
	KONnrUrU2dAiTgTxYTlFY0xFNQ9FKZNDqepFsVi5L9JAsHVUqJ2de1Jzye/lb57myS1+XgdQhgZe0
	nN+9YiecUmuMkQJcyB2CBrxy6pMisR2dCZRHt3mFWkIjOHIRFLHSpHZDnB9Z2hMsKvToLfSZiElFS
	hys4sSeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siWlm-00000006szQ-0hv2;
	Mon, 26 Aug 2024 10:16:18 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siWeW-00000006r2v-0djG
	for linux-um@bombadil.infradead.org;
	Mon, 26 Aug 2024 10:08:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=ETHDtkvAR5yLwocf1NNAJDJIgmGgz2GYbC6AhVsHb1U=; b=IBYEN88EcrobRkr4KwrKUavYwI
	nUJI1ejJYGmkz/pGXaGWXt3QMRxPNsFG+nMU5eMMm6Kza0Z010EvsxH9kgTfQ2v5z8zyB5EN8ZNAo
	zyBrz2vEAZPLb4YxfKTDCYWQeY2hhOPouM2S9vw0o8/ET3jRNLsWO1OgggCrbzXZjzPYTPPRQlU8M
	M4j1FCAjlQhvgBNPO8R4h3+OzeIVpp+zyJkVrF2jTTBK98mv5/NdbU7l4yqombZ1/FLE21x+BLIne
	peok0vxmGf11VfGB16IexfOQYyfXDvWAr1WOYZ0D8hElewrrxL1r8g5SrauiC+PIZixCs4j5xj8fP
	3bAE91kw==;
Received: from out0-203.mail.aliyun.com ([140.205.0.203])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siWeQ-0000000AdFi-1o7R
	for linux-um@lists.infradead.org;
	Mon, 26 Aug 2024 10:08:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1724666910; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ETHDtkvAR5yLwocf1NNAJDJIgmGgz2GYbC6AhVsHb1U=;
	b=ML/ux/WwZN/kzQCi1nUpBCEBidTBf+exhaTjy06+lHlJafMpLnqeX3gwJzI3Sa1nyhIICmYqLS2WMTXDPdh1zMCtK6ZuRmBXr4A+4RCtsxhvm34jfc7NXzKJYW/F2x0JVWEx/QfxdpVzSumHC1zDgRj9t2QKkfBmpzLZhOQwH7Y=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Z2YRsdE_1724666908)
          by smtp.aliyun-inc.com;
          Mon, 26 Aug 2024 18:08:28 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v3 6/7] um: Remove the declaration of user_thread function
Date: Mon, 26 Aug 2024 18:08:14 +0800
Message-Id: <20240826100815.904430-7-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826100815.904430-1-tiwei.btw@antgroup.com>
References: <20240826100815.904430-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240826_110843_943998_32B5E0A8 
X-CRM114-Status: UNSURE (   5.96  )
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

This function has never been defined since its declaration was
introduced by commit 1da177e4c3f4 ("Linux-2.6.12-rc2").

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/shared/skas/skas.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/um/include/shared/skas/skas.h b/arch/um/include/shared/skas/skas.h
index ebaa116de30b..95f5d5d6389a 100644
--- a/arch/um/include/shared/skas/skas.h
+++ b/arch/um/include/shared/skas/skas.h
@@ -10,7 +10,6 @@
 
 extern int userspace_pid[];
 
-extern int user_thread(unsigned long stack, int flags);
 extern void new_thread_handler(void);
 extern void handle_syscall(struct uml_pt_regs *regs);
 extern long execute_syscall_skas(void *r);
-- 
2.34.1



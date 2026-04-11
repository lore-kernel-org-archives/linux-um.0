Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8A6F3ED40
	for <linux-um@archiver.kernel.org>; Sat, 11 Apr 2026 16:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=32XDPxTh3hyuGD6AcGpPtFLd0DUI1/fNrBqBJNZoPuw=; b=vjfM8cHTG54oHbHnP4SE5dT2Po
	ZmIKtmyd87M3Lv6lox3a7dwTFbd+3lTtvFveVzDdgKOyNn/0Ho9vkgTOrF7gfqlTaFhGusu1cJCWe
	ofdP+eJ9ChRpUSWhov4yemcAoawGtGwIsvhPQdvaH8buxAod8UUS2pHIsJ05f+OQuSKDow5vsWWWW
	6c6ggKtoPr2iUXSb42geFDts/FXiAiOGHi2cYMNNkfcvRDszM/yuLlcg5dLKjLewAVxCzTU7nsWq1
	UBYk9xc6nPdtS6RPej+Xzt1AxyEfGMR8vcyNvANckvS5zVnSCLpux0oo7oV3evCmEU/kCNLtAqe7L
	+SAVX4EQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wBbLQ-0000000Ddkk-1mqS;
	Sat, 11 Apr 2026 16:38:04 +0000
Received: from out28-3.mail.aliyun.com ([115.124.28.3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wBbLM-0000000Ddjh-2Pfe
	for linux-um@lists.infradead.org;
	Sat, 11 Apr 2026 16:38:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1775925471; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=32XDPxTh3hyuGD6AcGpPtFLd0DUI1/fNrBqBJNZoPuw=;
	b=qqdU0W9YBaDy2syl7wLI8z7/PcB+mk/X0kw9rVGVSXMheXmuZ9Kz8i3Rk7REAlQJkCvm3mLdlfqzcZWXNUivO7NreBgUxPdcTKdWd1TzriIZndJFtZ+5nla9J4P0EQg2w2loIHabuTNSc/Vl/poRo/AcK4iZaaVC1kOD5aDv5FE=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037031241;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---.h9ur6et_1775925445;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.h9ur6et_1775925445 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 12 Apr 2026 00:37:46 +0800
From: Tiwei Bie <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>
Subject: [PATCH] um: vector: Remove unnecessary NULL check in destroy_queue()
Date: Sun, 12 Apr 2026 00:37:05 +0800
Message-Id: <20260411163705.948426-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260411_093801_189008_E859CC39 
X-CRM114-Status: UNSURE (   7.32  )
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

All callers of destroy_queue() already perform a NULL check, so
a NULL qi will never be passed in. Inside destroy_queue(), we
dereference qi immediately, and the subsequent NULL check on qi
is unnecessary and confusing. Remove it to address the smatch
warning.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202604110937.MLUL70Lx-lkp@intel.com/
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/drivers/vector_kern.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 2cc90055499a..755d936e5b43 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -471,8 +471,6 @@ static void destroy_queue(struct vector_queue *qi)
 	struct vector_private *vp = netdev_priv(qi->dev);
 	struct mmsghdr *mmsg_vector;
 
-	if (qi == NULL)
-		return;
 	/* deallocate any skbuffs - we rely on any unused to be
 	 * set to NULL.
 	 */
-- 
2.34.1



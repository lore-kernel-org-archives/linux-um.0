Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20416D24468
	for <linux-um@archiver.kernel.org>; Fri, 11 Oct 2024 04:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JxRiuypZIeLXCZKlxLO86zep9YFX8spIesFp4LrNwoE=; b=sBripSDpvV+k8I+4u+x6G3wiDL
	fTzGTYOBTrDQoYJEtz6lfy3CqhyMi36V8lEmnhgQqqAq19SWaSUNeQvS0oxMcXvJR+lo+8VR9S8HS
	7V7I5ZjRLz8qeUFmSl4gyc2cDpkoFMkdjN+RWdy6hR98eNKQIgQJDFOxtiFqTskxa3ll8vuuERcfO
	stBjfJtQtMgakdAYXnkMznBTvRAdUt6yaSaqhBzfwip9uGkaeGPrJjD52pFTqjLCK66mBDuwcY5Ts
	RwXyYeoJ2TMIxeBOLB96eHlsq9ZD0t+JgUTkzxIf4HN5gq1t9xt4TYvgauoNy8o68KQ/SgWlYfKR3
	OjMTE91w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sz6tk-0000000FCGT-2Hiz;
	Fri, 11 Oct 2024 04:05:04 +0000
Received: from out0-220.mail.aliyun.com ([140.205.0.220])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sz6tf-0000000FCBy-1ZFv
	for linux-um@lists.infradead.org;
	Fri, 11 Oct 2024 04:05:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1728619497; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=JxRiuypZIeLXCZKlxLO86zep9YFX8spIesFp4LrNwoE=;
	b=APFmnNLTOhEjCNT47eSdVcsVKiDs918D0njx/TPcN5lLypCv831nq/vUbzRvj/4xMNZAjwtY2SQrW/ozNH20+SCS32YRZILxce7fHuhGPMXndB38ESrKXMSoahHSi/uxyrHcSKWBg3tWZ+0KZOjp5zRtCV9bwhPzwToHqDcMD5g=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Ze33tzT_1728619496)
          by smtp.aliyun-inc.com;
          Fri, 11 Oct 2024 12:04:56 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 7/9] um: hostaudio: Do not propagate dsp parameter to kernel
Date: Fri, 11 Oct 2024 12:04:39 +0800
Message-Id: <20241011040441.1586345-8-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011040441.1586345-1-tiwei.btw@antgroup.com>
References: <20241011040441.1586345-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241010_210459_664486_F6A3D53C 
X-CRM114-Status: UNSURE (   6.35  )
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

This parameter is UML specific and is unknown to kernel. It should
not be propagated to kernel, otherwise it will trigger a warning and
be passed to user space as an environment option.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/drivers/hostaudio_kern.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/drivers/hostaudio_kern.c b/arch/um/drivers/hostaudio_kern.c
index 9d228878cea2..09af903b75ae 100644
--- a/arch/um/drivers/hostaudio_kern.c
+++ b/arch/um/drivers/hostaudio_kern.c
@@ -48,6 +48,7 @@ MODULE_PARM_DESC(mixer, MIXER_HELP);
 #ifndef MODULE
 static int set_dsp(char *name, int *add)
 {
+	*add = 0;
 	dsp = name;
 	return 0;
 }
-- 
2.34.1



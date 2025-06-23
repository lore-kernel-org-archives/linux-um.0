Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A642C7115B
	for <linux-um@archiver.kernel.org>; Mon, 23 Jun 2025 13:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=p3bTdK3ztnuVk053pd+3ZPIdxbkEe2aTdMi7s30QJnc=; b=IJo/Kg16JGSsEWekQe+5Jb61jo
	KqNOTk5prfjB9yoIxyfD3IsRYemknyfOImM7IzuDp+Y0DxV+C31VvQ01MNN4WxuYOlA/8uxtCpKVK
	Wq/2UEa8NI7msbMPzLPZeiEzqUfB2Vl4Nocva86NSegq819FIKun9yfZZjOpvJudC9iup1lIhDlVs
	qXr45J4lS1E1/tdg8BRsrt4woO2D466kwELxr8A0uKg0gAT51pSiLoTwAGrLXE/gTExyGRAxM9LXC
	vNRT2t3jsqvMkcTrmMAU0Cia9DN88AF6MBcLvv3QCSdyKmT87qCNBb+9UvEn8CayiwD3a/ZVPIOim
	vAF9rtuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTgrO-00000002oab-3ggH;
	Mon, 23 Jun 2025 13:05:18 +0000
Received: from out0-195.mail.aliyun.com ([140.205.0.195])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTf2j-00000002Tka-1Tvr
	for linux-um@lists.infradead.org;
	Mon, 23 Jun 2025 11:08:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1750676925; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=p3bTdK3ztnuVk053pd+3ZPIdxbkEe2aTdMi7s30QJnc=;
	b=sfICUyq3jsw+coYuZP/pjJWqHY9qplZE5ZEc4MuR4P0KhhCAg6H/ntCF3z+2B2UabMsOFMG6j+eubQx1Jc72kt+vcrQ9xPeq+VhIsDe+9h8WJJZr5ZBMX9brCjGWz5Gk9sbiRwZWriT0bp2mSQAjWAiNi49ZfmU5oLWBoQJ/4Y0=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.dUfUBQp_1750676917 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 23 Jun 2025 19:08:41 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>,
  "kernel test robot" <lkp@intel.com>
Subject: [PATCH] um: vector: Reduce stack usage in vector_eth_configure()
Date: Mon, 23 Jun 2025 19:08:29 +0800
Message-Id: <20250623110829.314864-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250623_040854_050997_019FB4BB 
X-CRM114-Status: UNSURE (   7.80  )
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

When compiling with clang (19.1.7), initializing *vp using a compound
literal may result in excessive stack usage. Fix it by initializing the
required fields of *vp individually.

Without this patch:

$ objdump -d arch/um/drivers/vector_kern.o | ./scripts/checkstack.pl x86_64 0
...
0x0000000000000540 vector_eth_configure [vector_kern.o]:1472
...

With this patch:

$ objdump -d arch/um/drivers/vector_kern.o | ./scripts/checkstack.pl x86_64 0
...
0x0000000000000540 vector_eth_configure [vector_kern.o]:208
...

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506221017.WtB7Usua-lkp@intel.com/
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/drivers/vector_kern.c | 42 +++++++++++------------------------
 1 file changed, 13 insertions(+), 29 deletions(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index f292e0b4ff8b..9bbbddfe866b 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -1625,35 +1625,19 @@ static void vector_eth_configure(
 
 	device->dev = dev;
 
-	*vp = ((struct vector_private)
-		{
-		.list			= LIST_HEAD_INIT(vp->list),
-		.dev			= dev,
-		.unit			= n,
-		.options		= get_transport_options(def),
-		.rx_irq			= 0,
-		.tx_irq			= 0,
-		.parsed			= def,
-		.max_packet		= get_mtu(def) + ETH_HEADER_OTHER,
-		/* TODO - we need to calculate headroom so that ip header
-		 * is 16 byte aligned all the time
-		 */
-		.headroom		= get_headroom(def),
-		.form_header		= NULL,
-		.verify_header		= NULL,
-		.header_rxbuffer	= NULL,
-		.header_txbuffer	= NULL,
-		.header_size		= 0,
-		.rx_header_size		= 0,
-		.rexmit_scheduled	= false,
-		.opened			= false,
-		.transport_data		= NULL,
-		.in_write_poll		= false,
-		.coalesce		= 2,
-		.req_size		= get_req_size(def),
-		.in_error		= false,
-		.bpf			= NULL
-	});
+	INIT_LIST_HEAD(&vp->list);
+	vp->dev		= dev;
+	vp->unit	= n;
+	vp->options	= get_transport_options(def);
+	vp->parsed	= def;
+	vp->max_packet	= get_mtu(def) + ETH_HEADER_OTHER;
+	/*
+	 * TODO - we need to calculate headroom so that ip header
+	 * is 16 byte aligned all the time
+	 */
+	vp->headroom	= get_headroom(def);
+	vp->coalesce	= 2;
+	vp->req_size	= get_req_size(def);
 
 	dev->features = dev->hw_features = (NETIF_F_SG | NETIF_F_FRAGLIST);
 	INIT_WORK(&vp->reset_tx, vector_reset_tx);
-- 
2.34.1



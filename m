Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E6BE81DED
	for <linux-um@archiver.kernel.org>; Fri,  6 Oct 2023 12:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=wr5yKLpjGCsOXYuaPFod8tBO2QYlDXBgmC/tzJSTT7I=; b=doxdtnFxUjNj2F
	FQGb0QwcaVxczy+94lL36aQEVB9WClF+fJTI4PusKzUUs+4Id1tf3imz5uUe4fVP7WZ1mdMXQtJqG
	pOefKCvFvgt1JYij70ZoWdyxpNBtiBrVRZo9UkpQHJID6GaxfUlLzREV2YW8fJ0Ji7x8wVfO+1ZX3
	dP7o7+3oYApSX2HEooqxhau5aQDNMp6NT0kCvgAylaPj6quTToZwTJVkqwXyEZaa234TGwHCnU3rK
	6bLWBsWjwl8wJt2lCizJW8tlxRN0C0XgBBVn028rQpcrA8lZdVZ5Qrmotx4CQDBwlpumaYWi+6brG
	GF57im0/sO7kg99+OfmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qojvv-005mJ7-1k;
	Fri, 06 Oct 2023 12:27:55 +0000
Received: from m12.mail.163.com ([220.181.12.196])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qojvs-005mFQ-0s
	for linux-um@lists.infradead.org;
	Fri, 06 Oct 2023 12:27:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=1a/vW
	nH3Ah5pXEyFX/8tf2+Zvr5M8bQvxpTQY3e+UqA=; b=C2T7kyfWIAIMoRJ/bRm2z
	xeT3mpMXCpdPWWNAMnQ8dsaGaPQdGELhq0nz99G9DzEyLGaQ/Co3dPNbpdmy7Tva
	itDV8YzNT5/RNMS08f29Y6bUuyLAqoHNkc4VzElSalnNWBf7gj08o9hqN3LnWCho
	Eiyw7Az5WzGNa4wglW5IP4=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by zwqz-smtp-mta-g3-4 (Coremail) with SMTP id _____wAnLUQn_R9lBEAAEA--.49286S4;
	Fri, 06 Oct 2023 20:27:28 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	make_ruc2021@163.com,
	xiangyang3@huawei.com
Cc: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] um: vector: fix return value check in vector_legacy_rx
Date: Fri,  6 Oct 2023 20:27:17 +0800
Message-Id: <20231006122717.3984017-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
X-CM-TRANSID: _____wAnLUQn_R9lBEAAEA--.49286S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFyUXr1DCr1kZF4DAFyUGFg_yoWfGrX_Kw
	1xZanrGr47Grn8Xr1DGF13urya93WkZFZ8Z3WFqr9xZw43Z34fAws0qrn8A3WUWay7Wwsr
	Kry3GrWjkw1rKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNeOJUUUUUU==
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbBFRkBC2B9oZDe6wABse
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231006_052752_660149_33F24533 
X-CRM114-Status: UNSURE (   8.68  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

In vector_legacy_rx, to avoid an unexpected result returned by
pskb_trim, we should check the return value of pskb_trim().

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 arch/um/drivers/vector_kern.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 131b7cb29576..822a8c0cdcc1 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -890,7 +890,8 @@ static int vector_legacy_rx(struct vector_private *vp)
 					skb->ip_summed = CHECKSUM_UNNECESSARY;
 				}
 			}
-			pskb_trim(skb, pkt_len - vp->rx_header_size);
+			if (pskb_trim(skb, pkt_len - vp->rx_header_size))
+				return 0;
 			skb->protocol = eth_type_trans(skb, skb->dev);
 			vp->dev->stats.rx_bytes += skb->len;
 			vp->dev->stats.rx_packets++;
-- 
2.37.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

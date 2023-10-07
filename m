Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B43E94139
	for <linux-um@archiver.kernel.org>; Sat,  7 Oct 2023 00:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=kLwMcljxAo2xPPtm30mnpQDYCssJPsjBTMBIUN9Ogxk=; b=eskZ7k4lSIwgUi
	onZlhWPlTK4C4Y03swB5sAtpCeFQ95frZHSrqCH8Xv0njceEkoVPQoai5UfybFd7kHqCbW8oigdsT
	YPdVl89zmB43FX7doxegUxLAVEuyqsG+Dk5veMpj8br+iamc+REFZ9ioQVfZrNl6jgq90loW0yfXK
	RAeRkktfICzCPOLr/gkhkWnextp5+d9uBCVMqJEwGRFFcCAKIHfItU8JU8r+ikTynM0DYbHdamlo/
	8UVJh8KdF2qB2kNI9lzJyleoUag+jcBd1HwoXaR9XqmHEvSRJ5TCk9ye2xUe0HJy9Sn++o5S0jNBy
	nBbpnmtUiF4/up9D8lEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qovXU-006itx-0D;
	Sat, 07 Oct 2023 00:51:28 +0000
Received: from m12.mail.163.com ([220.181.12.215])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qovXQ-006isy-2L
	for linux-um@lists.infradead.org;
	Sat, 07 Oct 2023 00:51:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=p3Qx7
	B082VtZrFxOuYcTvp7+pBO3IhmptOg+FirYoRY=; b=l6pmgkCAodebYncQaXmxV
	5k6RMMYuPSUmRT4u5AupptzsHN2NiEFmk47GZUtl834nZLPEz7OxHR/0UNA59CMw
	ANmedTEuCsJDNVCV0fbrzxIBZmq1VxgtpN8GPXZRpO1RBmIb+bNnKwjiTT3cOBhy
	yHzOCl8a9Bn06/xtypPL7g=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by zwqz-smtp-mta-g4-0 (Coremail) with SMTP id _____wD33OZ5qyBlC+QfEA--.50324S4;
	Sat, 07 Oct 2023 08:51:14 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	xiangyang3@huawei.com,
	make_ruc2021@163.com
Cc: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] um: vector: fix return value check in vector_mmsg_rx
Date: Sat,  7 Oct 2023 08:51:04 +0800
Message-Id: <20231007005104.3994678-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
X-CM-TRANSID: _____wD33OZ5qyBlC+QfEA--.50324S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFyUXr1DAw4kAFy8urW7Arb_yoWfXFX_Gw
	n7XanrJr4xKFn0qr1kCr13uryava1q9F95ZF1FqrW3ZwsxZw1xAF909r15A3WUWa9rGrsr
	Kr93GrW09r1rKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRM5l8UUUUUU==
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbBFQICC2B9oZceNAAAsf
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231006_175125_160720_EA6EF024 
X-CRM114-Status: UNSURE (   9.89  )
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

In vector_mmsg_rx, to avoid an unexpected result returned by
pskb_trim, we should check the return value of pskb_trim().

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 arch/um/drivers/vector_kern.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 131b7cb29576..c280ce5ea6ce 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -1013,8 +1013,8 @@ static int vector_mmsg_rx(struct vector_private *vp, int budget)
 					skb->ip_summed = CHECKSUM_UNNECESSARY;
 				}
 			}
-			pskb_trim(skb,
-				mmsg_vector->msg_len - vp->rx_header_size);
+			if (pskb_trim(skb, mmsg_vector->msg_len - vp->rx_header_size))
+				return 0;
 			skb->protocol = eth_type_trans(skb, skb->dev);
 			/*
 			 * We do not need to lock on updating stats here
-- 
2.37.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

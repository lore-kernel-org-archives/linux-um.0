Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C6AC636D7
	for <linux-um@archiver.kernel.org>; Thu,  9 Feb 2023 09:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Bn1U5orJFrKlHgfxtccaLnwzlWMVx1DIbWAhyHzruPs=; b=PyUAhRSpCwBSuS
	kMpIxW4HZk2YYWvYjAXd9CciMi/Cps6GnCsVqxelTxZGY4aPhCyIe5AEqa2BTXwoyuxDbQeDqle6E
	51LmfUyUwbHJsKPfm2I57JesZosd3FUyuXDDpXLnpaGsd2XwPFh6+tZSBxHpwieI75T9NB6o4DT9k
	gQJdBYmZpGSYh3bdv4tlmZu4YAD0+pii8zzsppXhclBLaqnDypul0L5vCz2OUFUKuIaWarNEQ3+d9
	IWVr7CQdPifMfscsALtV9M2RtpKPc8Izy8CiLZt1qlydT6M9e/BA1X9YzMrm1LJFvs2lWyZWSV9eE
	/6fLPlP15jHyg5Q9kl1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ2nA-000dtw-RZ; Thu, 09 Feb 2023 09:00:32 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ2n6-000doN-IE
	for linux-um@lists.infradead.org; Thu, 09 Feb 2023 09:00:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=T6iA/kTzol/8vqfogpYrbSrdswVrZl6gWjmc7rGXY2A=; t=1675933223; x=1677142823; 
	b=NUNOSj9OGWZcudIlhPjW8FmWINeHXZNA7HodGTUT97GQFfVxDZs/3fFdwHOwzUuItv+nX0YR/Xu
	+BztqmYMjpy+A8BexFrlkEgP8Pp2WzmrT8Fk+WulcGygFsED7ORqV6j4gvW3+NUNLE36fCxwansYv
	dOtYz3UeiznSuAijcV2fbWlksh6chGVwbZWtrCtQnw8qN37+dG+pVNZ2301jV5UZ0Z+qu56hQNsi2
	Nd4G98xMzXttA6FpTv360D0Jyn1wepWCtl3/MPzERF+pMiTgm1MQS5gtEfHzJWEW+8YSnsCq7x0zJ
	U1riifI6I/sgL2tqEe5X17PtQQIY0dqGkuWQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1pQ2mx-007K0c-2L;
	Thu, 09 Feb 2023 10:00:19 +0100
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 1/4] um: virtio_uml: free command if adding to virtqueue failed
Date: Thu,  9 Feb 2023 10:00:02 +0100
Message-Id: <20230209090005.1559828-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230209_010028_621179_C080C7EA 
X-CRM114-Status: GOOD (  10.63  )
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

From: Benjamin Berg <benjamin.berg@intel.com>

If adding the command fails (i.e. the virtqueue is broken) then free it
again if the function allocated a new buffer for it.

Change-Id: I03d2c687aeccb8bc8da280925ffdaeb8fb70eee7
Fixes: 68f5d3f3b654 ("um: add PCI over virtio emulation driver")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/drivers/virt-pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index 3ac220dafec4..3b637ad75ec8 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -132,8 +132,11 @@ static int um_pci_send_cmd(struct um_pci_device *dev,
 				out ? 1 : 0,
 				posted ? cmd : HANDLE_NO_FREE(cmd),
 				GFP_ATOMIC);
-	if (ret)
+	if (ret) {
+		if (posted)
+			kfree(cmd);
 		goto out;
+	}
 
 	if (posted) {
 		virtqueue_kick(dev->cmd_vq);
-- 
2.39.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

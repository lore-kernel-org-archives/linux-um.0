Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA0CD11100
	for <linux-um@archiver.kernel.org>; Sun,  3 Nov 2024 15:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j1RAcwnJO0STzEWDu2TD7nRQn5ElD7M/6C58+3v79R4=; b=Zh003c2NrVZDt0Z9GCIXoemYH0
	i6fUHLT0Tv1zAuEm3Aw4W3cfdPewAaYjrzqKRDZwkA4lmRooZy+F+4pH6lxqnR7ICP3Qc72+cfyYZ
	c2F1i6ERtLqlzhYmxSpR25lZM1/umUR7yt8OhSXexeGoNrS4rjO5w6ucLYrG9COSxfwZNo16oKMeD
	cIHpxu0F2WgOoUsEBp/dUxbsjRA5LtB16oEjHNbUBgwCu+E8OMNf+TV/FTHMF8uTFQ1wKDJHi7WTS
	d34ng5eENZ8Ae/CWrbo+9vT/ipyolQFi8XGu/IJufYdOIongrnZ7X+rCz8bCDcSKzYmiUrQyp70LP
	nejYlkQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7c7Z-0000000Bauo-3zwS;
	Sun, 03 Nov 2024 15:02:29 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7c7Y-0000000Bato-2CEy
	for linux-um@bombadil.infradead.org;
	Sun, 03 Nov 2024 15:02:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=j1RAcwnJO0STzEWDu2TD7nRQn5ElD7M/6C58+3v79R4=; b=EVF+3wk+eYR46QOJKhZlxh35+Y
	Y23MDIVICm3YlESI2NyTNSz9r4PrdBJLHW8rRqqccSRCEdt+ZUu+XQBU17hpyvcMyTM1eW5MzlIc/
	vxYycklxj7Sn9yUptiySpYTJw9XSyf32faHg38+qcfZOes/YWxE3nlLwc68xo6UU+MldqUSgSDEUH
	kfIyJ/ui+lJd0LlQzvNUwRATn2/T+APO/uDMISCf5yLxGw0nuOx4oGF2DRR6wJH3m2nnwhUmevBCM
	ikR9gkk5Cq9HHWrnrkaOiZtaAaSRlHZko5+IwUYg7nVio3EgUesne+LUn+Hv9Ws1sfwL9reGpwxxH
	h3THxtPA==;
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7c7T-0000000B8Nx-31m9
	for linux-um@lists.infradead.org;
	Sun, 03 Nov 2024 15:02:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=j1RAcwnJO0STzEWDu2TD7nRQn5ElD7M/6C58+3v79R4=;
	t=1730646142; x=1731855742; b=BJV/yxD3Jxx5JEx7bbwRSrzr+nHPKY16PbqG486zEOJEjcM
	YgzeYpVQqz59oQ5WjdY7eN9VEQUlMOlx621RcIp6fNAcypkWEtoVAoTqqB6qxGYtEJ04M4/DltP87
	L3rwcnVFw7QlQ4rTx70Lohblg+ZIJijqQOPHd2ZsvaTRr6k0QvqcRCAtJR6wtw74GvQkTishOkK/o
	Uiu16YSRRTOqZ2ZZOqsF8cfK1FjnlzapyM8axZfIBQoV6NOj3KHsfjPjYb9ViaDjDf7O2JzU6iLZT
	LfswFAzeElucpe7xaNr4irFkSYR8KYcJcDZc6WF5NqdBu5wm0XOWO7GpaIMAV1mw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1t7c7Q-0000000D5Ia-37qw;
	Sun, 03 Nov 2024 16:02:20 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 4/5] um: remove duplicate UM_NSEC_PER_SEC definition
Date: Sun,  3 Nov 2024 16:02:10 +0100
Message-ID: <20241103150211.1366452-4-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103150211.1366452-1-benjamin@sipsolutions.net>
References: <20241103150211.1366452-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241103_150224_122449_CF8E7753 
X-CRM114-Status: UNSURE (   7.09  )
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

From: Benjamin Berg <benjamin.berg@intel.com>

Just remove the first entry as there is a second later on.
---
 arch/um/include/shared/common-offsets.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/um/include/shared/common-offsets.h b/arch/um/include/shared/common-offsets.h
index 1d00fc6b6e92..73f3a4792ed8 100644
--- a/arch/um/include/shared/common-offsets.h
+++ b/arch/um/include/shared/common-offsets.h
@@ -6,7 +6,6 @@ DEFINE(KERNEL_MADV_REMOVE, MADV_REMOVE);
 DEFINE(UM_KERN_PAGE_SIZE, PAGE_SIZE);
 DEFINE(UM_KERN_PAGE_MASK, PAGE_MASK);
 DEFINE(UM_KERN_PAGE_SHIFT, PAGE_SHIFT);
-DEFINE(UM_NSEC_PER_SEC, NSEC_PER_SEC);
 
 DEFINE(UM_GFP_KERNEL, GFP_KERNEL);
 DEFINE(UM_GFP_ATOMIC, GFP_ATOMIC);
-- 
2.47.0



Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE00CDD552
	for <linux-um@archiver.kernel.org>; Thu, 19 Sep 2024 12:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dKpH+tlU423xOURAFjrKZyJAMssXrMwBVe1nv9ITqEw=; b=z9mwbA3CD2OoG6h76FxTmZkDTG
	SGrBP/4+Fqot7wvPPbqHWEP8UZB2oBa4cRc25DI3CM6zm5wwAFu1MgzE59LET9jlmJVRCNWm+wIbH
	n9WN9+JO+ZOl61MH8TCy9DW+R2xSkx/x0b2l3M89pHCRyNvO2ykgVSO6eELCtM1BWphqFFOjIb8cP
	dA3APlmDZ8WBn/76V5M5pQDV7elsAUYoKgMDmKokhraTXQgr44hlhs1CNOxdTtUxuMKvSio5wIgRX
	h2pCK0ZdA/Wc46ck5KB2I+JGKpSG0KUIYXpQo3hmv4GW8JZKxK17HsQvehCw8EWNSG7lenuogZUq8
	NXHb8ENA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1srGXb-0000000AGro-1fFL;
	Thu, 19 Sep 2024 12:45:47 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1srGXY-0000000AGq7-0rjQ
	for linux-um@lists.infradead.org;
	Thu, 19 Sep 2024 12:45:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=dKpH+tlU423xOURAFjrKZyJAMssXrMwBVe1nv9ITqEw=;
	t=1726749944; x=1727959544; b=LmANmG1bZs1ZwCnVCQuo3y5KrJLeEslA+GuoN/F4IpKzWPE
	/D/jqLALo6kYqzP2evyYQ9hxeghCqsZuYwC74JVwzM439L+nxLnOPDNFTx1uhvAVJNNwwk+4KQIW3
	MqZr+zhdfCRGhdRAfBPz3tmBHve56n7Tt6hmhIhedDGzoUbXYIfaGaN9lCMZsQJO8tNe91nnvUFS4
	//hXKU8manvk3OUiEKhDmv7VOwsDiyqUpSvxou535isOCJCAj6qnqXBdmtGJtEiT3i6hOLb48MUwo
	5QFFOP+VPsNdz3ipsCByLO78oN943xUZfZAB+zAgw4zRvrf+OHI35W8gsgR+1bLA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1srGXW-000000047AZ-0G6r;
	Thu, 19 Sep 2024 14:45:42 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v9 05/10] um: Add compile time assert that stub fits on a page
Date: Thu, 19 Sep 2024 14:45:06 +0200
Message-ID: <20240919124511.282088-6-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240919124511.282088-1-benjamin@sipsolutions.net>
References: <20240919124511.282088-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240919_054544_328815_7BC61EAD 
X-CRM114-Status: UNSURE (   8.63  )
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

The code assumes that the stub code can fit into a single page. This is
unlikely to ever change, but add a link time assert instead so that
there will be no hard to debug error.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/kernel/dyn.lds.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/um/kernel/dyn.lds.S b/arch/um/kernel/dyn.lds.S
index 3385d653ebd0..dc9d9a68af55 100644
--- a/arch/um/kernel/dyn.lds.S
+++ b/arch/um/kernel/dyn.lds.S
@@ -178,3 +178,6 @@ SECTIONS
 
   DISCARDS
 }
+
+ASSERT(__syscall_stub_end - __syscall_stub_start <= PAGE_SIZE,
+       "STUB code must not be larger than one page");
-- 
2.46.0



Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434E7E77198
	for <linux-um@archiver.kernel.org>; Tue,  7 Jan 2025 13:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HECITSXpRyXit2ex6aglP2NP5KNMdOFcIko25O6IV68=; b=1B46lazPByujAOH93oH6xdao3S
	5yKxaacJnWTFJjrQtoSr/axh9k6K9T0eRhlJUs5+6y1UmXIc2Kp3uYlQQsNVvs2PBaAWRmQpfoJcW
	jAi2PmswX9cDiNnzLs9sLpO2zB0SZH5gY96EvXJd88JHAhJMTQ90I75Dycp6ywg8jcB4D570zzH5/
	tan0UvzDDUWa1LKCGIpgUPeFnw5znv83Ib+//n3XlDwudQARFJuJnwhfk1fvzK+HmKVwyaxpoTYQL
	NeB7wWIeYm/8AEYCvR8StiGZl1xykOET744k3JBGoB9sncag1KOB/qcQPGIGvriSeKEPlegfOP6xO
	S4t0RHGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tV9kE-000000051Ph-24Ot;
	Tue, 07 Jan 2025 13:35:42 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tV9kA-000000051No-0aAA
	for linux-um@lists.infradead.org;
	Tue, 07 Jan 2025 13:35:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=HECITSXpRyXit2ex6aglP2NP5KNMdOFcIko25O6IV68=; t=1736256936; x=1737466536; 
	b=Q4wM9bTRdEhk5Ng6Zz9dFtPf0bbjbZbLny1SEhYwpRM+FofRWGnzDUaTLc88nfboZNVTEDjs9n7
	m0xZJ1YThJFtBjVNfMB5uELZt20chnqVuUGydwIKdGLcL7ys6aSvGe4aqZwQj882iWthr8J3rnAvd
	EJbPNBxwK1OOGFmtBtQlJqS/9EyS00UfjXGd38MA/ScmL7eJbR8JjGbXmOD+dmDvCvXL1Z/pTZ6Oj
	6eymOe5wAP0F/N9XyfxRyXm9rEtpR7c4R/F28q65jbvD/8AeT5+vH/lHbV/XxF67QJQlLJjbLrmHs
	nSmI1OvPVEoLs62FmI9suueAw2PXNEIP3zoA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1tV9k4-00000007DVr-1q0C;
	Tue, 07 Jan 2025 14:35:32 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH] um: properly align signal stack on x86_64
Date: Tue,  7 Jan 2025 14:35:09 +0100
Message-ID: <20250107133509.265576-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_053538_182966_F1D02523 
X-CRM114-Status: UNSURE (   9.16  )
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

The stack needs to be properly aligned so 16 byte memory accesses on the
stack are correct. This was broken when introducing the dynamic math
register sizing as the rounding was not moved appropriately.

Fixes: 3f17fed21491 ("um: switch to regset API and depend on XSTATE")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/x86/um/signal.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/um/signal.c b/arch/x86/um/signal.c
index 75087e85b6fd..9ab9b29a5b25 100644
--- a/arch/x86/um/signal.c
+++ b/arch/x86/um/signal.c
@@ -367,11 +367,13 @@ int setup_signal_stack_si(unsigned long stack_top, struct ksignal *ksig,
 	int err = 0, sig = ksig->sig;
 	unsigned long fp_to;
 
-	frame = (struct rt_sigframe __user *)
-		round_down(stack_top - sizeof(struct rt_sigframe), 16);
+	frame = (void __user *)stack_top - sizeof(struct rt_sigframe);
 
 	/* Add required space for math frame */
-	frame = (struct rt_sigframe __user *)((unsigned long)frame - math_size);
+	frame = (void __user *)((unsigned long)frame - math_size);
+
+	/* ABI requires 16 byte boundary alignment */
+	frame = (void __user *)round_down((unsigned long)frame, 16);
 
 	/* Subtract 128 for a red zone and 8 for proper alignment */
 	frame = (struct rt_sigframe __user *) ((unsigned long) frame - 128 - 8);
-- 
2.47.1



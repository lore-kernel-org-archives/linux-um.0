Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F19ED11184
	for <linux-um@archiver.kernel.org>; Sun,  3 Nov 2024 16:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EJAwLZWR2/MxQZPYV+ZbJdJVrP2bL4eH7he+1wmDhKE=; b=WHSBRnHQD+O+4unJhdnmQVVZWE
	0k1nze4GpX1TRkibNQ3sDz6ElbKzzjrJmCgBG61+jNtRofDsiZkh0sm7tOovWYslJszKwmTYxVFzj
	b2azDPECiNr/21kg1aVR7TLod0ZHaotbltfxBeLCRN3G28Jb6NXmTJ82di+74U9kffOa1D9j8pcs8
	ugqq3NLTeH9yB4SJ4dZu6oyyZXJbMZhseZG3JLBcaXwHunqwKYY6s9Lb5CzwSmkYEq/jEH8o6KuYi
	pGpH5hNW5FaFkEM+L4xHN59dXgqs7ztHgE3jGnTlA7hO1vBl9ZkAaNBbob4YDWux8qMsMT12H3NFI
	CnXeGwcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7dG0-0000000BgGK-3kAs;
	Sun, 03 Nov 2024 16:15:16 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7cAN-0000000BbSC-0nzk
	for linux-um@bombadil.infradead.org;
	Sun, 03 Nov 2024 15:05:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=EJAwLZWR2/MxQZPYV+ZbJdJVrP2bL4eH7he+1wmDhKE=; b=rhElrWZTt/pb0v+msy38MaalPB
	NkhaqTyQTSqk3xcDYXiWelDZf2g+QzGuulGsWpam8E5pGzDi9+m+nvfD2oXJwdXDNC0KfYAwXx7Wi
	wePMr6Wjn5t2t7m0O9MgmlTiYZLsHqoWQwevElHDXCluDtF+Dce1XhqNsPNjS+gu9EB6HWCyNpRJQ
	gLqE201SeCzr1udr9WKecOuw5UPHLWjfwAm2hejhxCDEqRiFmMSi4nClIgvFw6mPq6oaRaXSsZjw7
	tQF/VkDtWybeMYHjdMOy0cqOEEhKECumzCnC1vP/vvixf98vWlFzWftHuSqIQ6CL/aj7l+huwsw/a
	l36r1ffw==;
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7cAJ-0000000B8fB-2VF2
	for linux-um@lists.infradead.org;
	Sun, 03 Nov 2024 15:05:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=EJAwLZWR2/MxQZPYV+ZbJdJVrP2bL4eH7he+1wmDhKE=; t=1730646319; x=1731855919; 
	b=P38HzJmSo+NpXlrV5ueNb+BifuEJOExVE9FhVMu+rI4ckQ8xKJxuOgDmnp1QDHBMXuTCfyjgCND
	yLsf2WvdIwG1RIb8zV3l3YGeQg4u2phdbVLXsGjSAOo6ISiY1nf80Tax3ii00oXg0UAaBwNsbCIua
	NpZScutj377woWNxAdcLtADGwx4vclDZ3LrSJ7m4a4BFnmyHDHCGfvOHAlJvxQkABa3tkK2vnXI9V
	mAcw3EQYFgt8AMCyLf3hRilHPhJ13xEMZlkkAeYkWi63XdVFSFtCPY2jv0F/Zxf2fQXebmGoEo4ur
	fK3aiNLmTBhBHa/ylEQ98hNFNr4PNbcQyWFA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1t7cAH-0000000D5NG-448A;
	Sun, 03 Nov 2024 16:05:18 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 1/5] um: set DONTDUMP and DONTFORK flags on KASAN shadow memory
Date: Sun,  3 Nov 2024 16:05:02 +0100
Message-ID: <20241103150506.1367695-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241103_150519_843149_0330AC8D 
X-CRM114-Status: UNSURE (   6.93  )
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

There is no point in either dumping the KASAN shadow memory or doing
copy-on-write after a fork on these memory regions.

This considerably speeds up coredump generation.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/os-Linux/mem.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/um/os-Linux/mem.c b/arch/um/os-Linux/mem.c
index 857e3deab293..72f302f4d197 100644
--- a/arch/um/os-Linux/mem.c
+++ b/arch/um/os-Linux/mem.c
@@ -39,6 +39,18 @@ void kasan_map_memory(void *start, size_t len)
 			strerror(errno));
 		exit(1);
 	}
+
+	if (madvise(start, len, MADV_DONTDUMP)) {
+		os_info("Couldn't set MAD_DONTDUMP on shadow memory: %s\n.",
+			strerror(errno));
+		exit(1);
+	}
+
+	if (madvise(start, len, MADV_DONTFORK)) {
+		os_info("Couldn't set MADV_DONTFORK on shadow memory: %s\n.",
+			strerror(errno));
+		exit(1);
+	}
 }
 
 /* Set by make_tempfile() during early boot. */
-- 
2.47.0



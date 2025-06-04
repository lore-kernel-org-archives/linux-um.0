Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE84C5B552
	for <linux-um@archiver.kernel.org>; Wed,  4 Jun 2025 08:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YTvdxGZu5zEqWRNMyCUu7b2OSqg6UY2SnZPES5oc+E0=; b=3H5/7eINMnz6pV3RILZ8kJB9ai
	E1Nr9t7YSis46IuIubQlK63iPmN1Z8HqZwzC+0tsVCJC0baDMkA9iQGqu1KfRKhg0a2z/MPJ3uq4j
	DBcp7imF6ziGYQYBCXAzA5mnm3iDBA2eRjcK7Xs+avulRbpyb3WO2Wo6VaguTVc/drjKBzm6oQdKN
	mpRfpvZfG+5vfRjXW2mdUPla6NrnoWrrywz4KoSCfUhrWSfy4r5QiSH64PduWELrbSPb/NX87iSPp
	/Kgvk3Mm7IVlkGLb0vtfZiKb2lNDFabGP5Oo401VlVRxh7mLZIrBJ1P2Khi35lR+L6oDU7mRpToAA
	yAGae31A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMjjy-0000000CvjE-3RAz;
	Wed, 04 Jun 2025 08:44:54 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMjK3-0000000CsAL-2aKt
	for linux-um@lists.infradead.org;
	Wed, 04 Jun 2025 08:18:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=YTvdxGZu5zEqWRNMyCUu7b2OSqg6UY2SnZPES5oc+E0=; t=1749025085; x=1750234685; 
	b=rr0H8jy6OkuwuF4bIKRQjXVyhkH753t6X9jEa0tQ5U4PvazCSoiGRk/QmLz/NsoPO7QRXsjHeAl
	9OgL+2XgajgId4fS26WrygDIHXVgNL/oTbR9lI2i4DnVM8NW8nSImqvx34l0pe99qWl4w1GoR6o2/
	nn4BCk4DrCkC6TyhPzoWWZcvGEXn5IZLSLxCtCo8CWv/IAHWtgw8n5E2vE12krO9M/+MZzgClvh+U
	7K40BsXleQh+GchmSRQ9iORNyfUIJ/RKE1idcUvnkoPR3k8+kaHazZkL28O0RgpQTFEjnZ49+J1In
	M+kXbQc5WotDS+e3gSuAek/AgPObomxeSLlQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uMjJx-0000000Dsg4-175B;
	Wed, 04 Jun 2025 10:18:01 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH] um: fix SECCOMP 32bit xstate register restore
Date: Wed,  4 Jun 2025 10:17:05 +0200
Message-ID: <20250604081705.934112-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250604_011807_675361_D6084856 
X-CRM114-Status: GOOD (  13.23  )
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

There was a typo that caused the extended FP state to be copied into the
wrong location on 32 bit. On 32 bit we only store the xstate internally
as that already contains everything. However, for compatibility, the
mcontext on 32 bit first contains the legacy FP state and then the
xstate.

The code copied the xstate on top of the legacy FP state instead of
using the correct offset. This offset was already calculated in the
xstate_* variables, so simply switch to those to fix the problem.

With this SECCOMP mode works on 32 bit, so lift the restriction.

Fixes: b1e1bd2e6943 ("um: Add helper functions to get/set state for SECCOMP")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/os-Linux/start_up.c     | 4 ----
 arch/x86/um/os-Linux/mcontext.c | 2 +-
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index 49015be1aaaf..a827c2e01aa5 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -296,10 +296,6 @@ static bool __init init_seccomp(void)
 	int n;
 	unsigned long sp;
 
-	/* doesn't work on 32-bit right now */
-	if (!IS_ENABLED(CONFIG_64BIT))
-		return false;
-
 	/*
 	 * We check that we can install a seccomp filter and then exit(0)
 	 * from a trapped syscall.
diff --git a/arch/x86/um/os-Linux/mcontext.c b/arch/x86/um/os-Linux/mcontext.c
index e661fdc44db9..a21403df6663 100644
--- a/arch/x86/um/os-Linux/mcontext.c
+++ b/arch/x86/um/os-Linux/mcontext.c
@@ -231,7 +231,7 @@ int set_stub_state(struct uml_pt_regs *regs, struct stub_data *data,
 	xstate_size = fp_size;
 #endif
 
-	memcpy(fpstate_stub, &regs->fp, fp_size);
+	memcpy(xstate_stub, &regs->fp, xstate_size);
 
 #ifdef __i386__
 	/*
-- 
2.49.0



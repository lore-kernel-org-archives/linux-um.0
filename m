Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6E7C38150
	for <linux-um@archiver.kernel.org>; Thu,  4 Jul 2024 16:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/RHcd/yUmz0Gk8fIDLX6wsZ8ME7gFNvXydNGe/JBc3w=; b=zeGbbiJIsPB2nDbPTmjp2xR+D6
	cxEjam3leWr62sD22bVYPc3bQN+fmyB/jy/l8cmwwfaDd+nXvnCtCPMKgWm68p6RycFhNNWe/toHE
	87xGRTMxtQBQeBzI9g1GaF13q1XsZbaUXGHpJ1Xjsu00vX99WWfWKpu/Ekkwx2D44rsaeGH9rtaK+
	Je+T1UuDAmDz4kx0Rx5rcfCoXPTDr85r5w1ew5dIwZL127NhAjnpxn7IWbsj2QJfsKnMhhYRbdVgw
	sANeqJG3DEbQMb0WXpfhrltTtOZtVCOZ7B9i1O578bef1t1p1SqqR6h4hYFfefffrdMd+DxzbMPTS
	V+z0UWLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPPJF-0000000DqFF-2ins;
	Thu, 04 Jul 2024 16:27:49 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPPJC-0000000DqDO-2TGp
	for linux-um@lists.infradead.org;
	Thu, 04 Jul 2024 16:27:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=/RHcd/yUmz0Gk8fIDLX6wsZ8ME7gFNvXydNGe/JBc3w=;
	t=1720110466; x=1721320066; b=ph4fDmZ/iFKZj10Hch8KYx0eQHH4fzKNTl4W/nMulv/m6tF
	V+fugDy9OUsraD8ltw6kcW259EF7mFQ+SNh4Y9d/1nUyCIa0kmZzTr1mPXx4D84H+aV4c5EXOihJf
	zWBeRvM52Xo6FN0DESHXSweEtQfNosn47hTJ6SOnpM+fET6Ar7msvEI0eqmAFb8SV3QDd/uxqjZW3
	JHsp117s7tzwt6OKotgby63naUbPa3F61a2b9joIU6Zg9+4nRbmoQ8RnTSrgqEcMmWYqnmJLKroV7
	5GBdzuI+lUPM17+0fZ2aHgmwXHNBv2IU9fv0OEWqFYhaN5M2dwlLLLVMVlVVkMqQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sPPJ9-0000000DOu8-06sm;
	Thu, 04 Jul 2024 18:27:43 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v7 1/7] um: Add generic stub_syscall1 function
Date: Thu,  4 Jul 2024 18:27:11 +0200
Message-ID: <20240704162717.1417338-2-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704162717.1417338-1-benjamin@sipsolutions.net>
References: <20240704162717.1417338-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240704_092746_649922_B8E60712 
X-CRM114-Status: UNSURE (   7.31  )
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

The 64bit version did not have a stub_syscall1 function yet. Add it as
it will be useful to implement a static binary for stub loading.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/x86/um/shared/sysdep/stub_64.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/um/shared/sysdep/stub_64.h b/arch/x86/um/shared/sysdep/stub_64.h
index 67f44284f1aa..8e4ff39dcade 100644
--- a/arch/x86/um/shared/sysdep/stub_64.h
+++ b/arch/x86/um/shared/sysdep/stub_64.h
@@ -28,6 +28,17 @@ static __always_inline long stub_syscall0(long syscall)
 	return ret;
 }
 
+static __always_inline long stub_syscall1(long syscall, long arg1)
+{
+	long ret;
+
+	__asm__ volatile (__syscall
+		: "=a" (ret)
+		: "0" (syscall), "D" (arg1) : __syscall_clobber );
+
+	return ret;
+}
+
 static __always_inline long stub_syscall2(long syscall, long arg1, long arg2)
 {
 	long ret;
-- 
2.45.2



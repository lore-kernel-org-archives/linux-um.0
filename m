Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281C5C27C79
	for <linux-um@archiver.kernel.org>; Wed, 19 Jun 2024 15:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q/uPnkGh6x94Y9qp1898LiLzzo92vyHXmEu9GICBDog=; b=q4VF87onM3bD7O5nZUPSVoWHVe
	x3lmKXwzVIT+e6oJIn9IIyxSwHMVAAGD79vo9ZbbDcWKx3jX0mEXQPwu0ugBI6nsG8ZSbGlKFi33h
	TsloaUAA8L/jPnqYbfxvB19OSQ/TIlYoyP2djiW3GorrZPC82aP3DOIq7NrG/MOuNM7DTn/yo3jZg
	BsvxqrhL+tDu+fZoSqtRFsR3TjmFv1QkAYtnDbFbcOqB2LP3UHV97Gl5fYJ99n05ltpqGqgqYS++a
	9eCu7EQYLPex4idFcoqWhu26PS0WE3rnrQi7HgWY0tPv1bb3Y4LvvOvttorAL6zFmKQ4NWHvi2ZWu
	1+LOYoNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJxLp-00000001pQ4-22yS;
	Wed, 19 Jun 2024 15:35:57 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJxLi-00000001pKw-3U6n
	for linux-um@lists.infradead.org;
	Wed, 19 Jun 2024 15:35:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Q/uPnkGh6x94Y9qp1898LiLzzo92vyHXmEu9GICBDog=;
	t=1718811350; x=1720020950; b=Fk59oTyMZGT0knjK+ZJaFpggCcV7NKsF5GEASgV7iMIGiuc
	c52lW1Eu5YPKbWaLinZE9JX/LCcvQVSOpYF31U9riwWUziSsF/pVAoxXPFng6vnMVusR8YF4Y2LhC
	li2ff8SDQ/gd/9906nJEsRgBQVecPWJdbihzYvKh6c5qNpSRqFUtezqpjTUcXuEctBuf9Hd5Z6UYt
	ARFqBUR2BSa6siHduVEuM06Mfi64RjZVKiKAfVGfVGKqh0pwlezc3U1dJ3Rig47Og3bPX+TB7Ipm6
	HbwtR/LxdUls7IxTVXIS2a7MlLRIfSZiZIarAVTA60HF4mCCiJX6j+OeJ0sVoO/A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sJxLg-000000072rR-16LD;
	Wed, 19 Jun 2024 17:35:48 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v5 2/7] um: Add generic stub_syscall1 function
Date: Wed, 19 Jun 2024 17:34:06 +0200
Message-ID: <20240619153411.2596774-3-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240619153411.2596774-1-benjamin@sipsolutions.net>
References: <20240619153411.2596774-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240619_083550_954841_42305A39 
X-CRM114-Status: UNSURE (   7.46  )
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
index c99ea6e06f96..6ed2ce4b54ba 100644
--- a/arch/x86/um/shared/sysdep/stub_64.h
+++ b/arch/x86/um/shared/sysdep/stub_64.h
@@ -27,6 +27,17 @@ static __always_inline long stub_syscall0(long syscall)
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
2.45.1



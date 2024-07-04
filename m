Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5EC4C41513
	for <linux-um@archiver.kernel.org>; Thu,  4 Jul 2024 19:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/RHcd/yUmz0Gk8fIDLX6wsZ8ME7gFNvXydNGe/JBc3w=; b=xYoHfaMxDK5GDVgJ/mu8sXGaVD
	Ka8QmpkJr+C3jsTPxU7sHlPKUQvZpgbhCn/jsw9HakSnBAfYt0VvIiyrlbrXo//HpqmM7TX8ePSUp
	MuufoFSFsWtMG0sAu/iDhe4Dfgk5N7rEchNDYM4aAHTJvmHO0TTUbnaSzhwZxVsf5fz2x5Uf4+fLs
	BNmSzlRWny4PPSMTsWLXf0TI+Ht2hRJswo0DlnqTm5qk+7778dlX9ANn75LvxdemI6Q0ByMt1NIqU
	DGi46Z8l+zRER1TGBGRMkVF9okwjZfhIMtB1bbzyMWojZic8xpaoZ6Sh1yOzSCB2pVpwx61d0m1Gb
	04ZJojIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPRle-0000000EEDS-1FUH;
	Thu, 04 Jul 2024 19:05:18 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPRlb-0000000EECO-3LP0
	for linux-um@lists.infradead.org;
	Thu, 04 Jul 2024 19:05:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=/RHcd/yUmz0Gk8fIDLX6wsZ8ME7gFNvXydNGe/JBc3w=;
	t=1720119915; x=1721329515; b=ayCgz4Vi/iwIqFHhZOVxmiH8JXYyGdRBSc9yT/d8VJfdpOW
	U4O/cfKP1i9FjkCnFuf0SHItT1KaRte1PC0GTMNLJiOWGbll0rosPhTF+FFkK5djf2lnhMwGoLaid
	2aCoH3wnBuWgGxHFoU2tXaQ+V5xNpmBgSPq9xz7Y5m0XaJYBW8xj8izeEBwXiFIKzHlNY4pVdXv8D
	zZtrPHLb4ttvo0mzuX/StYeGkJMedwEV9wwJOu3maieT3ZZJ+3ffYNMLfWwm/4firM36FyrtWpbph
	1Hw2NE1lWYT+eIrx/HTra2/eZ2Sh6ZOFFerRx0fv0bohnoMBW5WlF21XIMd1DGYw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sPRlZ-0000000DrZs-1HOC;
	Thu, 04 Jul 2024 21:05:13 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v8 1/7] um: Add generic stub_syscall1 function
Date: Thu,  4 Jul 2024 21:05:00 +0200
Message-ID: <20240704190506.1438493-2-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704190506.1438493-1-benjamin@sipsolutions.net>
References: <20240704190506.1438493-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240704_120515_845087_8043D9B5 
X-CRM114-Status: UNSURE (   7.28  )
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



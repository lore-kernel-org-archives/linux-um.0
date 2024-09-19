Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C542DCE8D7D
	for <linux-um@archiver.kernel.org>; Thu, 19 Sep 2024 12:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WUAkBV6KXK1KZHfM+hjNmf8pG0ktRO581fqHKFz/fLs=; b=aSf9dx14FmMzVecFmA/G/ZitJr
	ke8aS3n7YjGGBbcBeQEQ6QdUeFVmOCGIVS9d8oE3J3ZvNKtqCHhBN6JzPjVP2Y5cyhgBlqzHr6GCH
	fy8E5xntliGQuHRwGC71WmRTqHOYQqDQgEMzT0WPfQZo39qn94txRCRxNfLPqYzWHVquCy05OpMja
	KSsc0VYW7iBZyPBgL9nec3tCrNM5XeTYQQt9LQ4W0l4QFeF8nQrUKFYBC+BhyRcJXmpThVTwrVDe/
	LUCIpPI8zzd8RB0QnUq7Pg026smHi92UjP67Gd9iqEjd2jdx95HJTHandX55E1ZiVM5EcXcg26Xz0
	qB3OZ3/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1srGXU-0000000AGo1-1wEH;
	Thu, 19 Sep 2024 12:45:40 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1srGXR-0000000AGmi-3NMD
	for linux-um@lists.infradead.org;
	Thu, 19 Sep 2024 12:45:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=WUAkBV6KXK1KZHfM+hjNmf8pG0ktRO581fqHKFz/fLs=;
	t=1726749936; x=1727959536; b=gDnGFKpmOvlnq6pChG4SclHDyNtxaODSKOxVzAix6M+QM+L
	5tu3fu4UT8CFPIq3XRRGYQUGBaN0zSfEp5GYul7l7jsz4FF5vVMlScH+3TGp1X3VkUvX3LtIHaZz3
	kkFr/1eapadMpv/eFISduYVWURx35N39xpkau960GRnEUhpcj3umoxNiReGUpnqYpfBIFLivbD53j
	Op8tH3I3tEXHqGw30n83jelbY6eRVaew+RtK5gOKSlJ5sYcrwK61sW8wA4/g1mbWPwX8QuOm4cfYN
	ebrrdLU4+Y48alLkK6w/bT+crGJl+UCFRNj8dllZS3KqF/h1EYUJC1VKEVAzL3sw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1srGXN-000000047AZ-23mZ;
	Thu, 19 Sep 2024 14:45:33 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v9 01/10] um: Add generic stub_syscall1 function
Date: Thu, 19 Sep 2024 14:45:02 +0200
Message-ID: <20240919124511.282088-2-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240919124511.282088-1-benjamin@sipsolutions.net>
References: <20240919124511.282088-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240919_054537_955682_532CECE6 
X-CRM114-Status: UNSURE (   7.74  )
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
2.46.0



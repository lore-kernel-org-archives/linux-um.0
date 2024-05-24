Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D8EFC41513
	for <linux-um@archiver.kernel.org>; Fri, 24 May 2024 21:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g56d/xHBpUWGzqqTH0FbaK9FdwzD0VPn9INiOk1xHiI=; b=HGrD+/HXIpT154dd1XDM9CfHg2
	dD2xEhTLFqyRudEBaHMDq/9fkF3uqUvp7EjX0ZfA5LegPPGhslbDflqcDZywljuaQZ1x4I5fKeOTK
	7u390RAigqU4xBmSc0gA03+dzzuomUc/e5fRAR/dNhoFvlYtWCitGXBeSItfVHqR/UkIOYii1ggBT
	V5cvRsINaByx2xipjE0Ao8H9hiahieG64XK7v731liw2/BVKwcbLY9thWGudm1yQW5vZvYv/Z/U/D
	s5Or2SNHXtIgVeTh8x1nSkd3BUh4d2di9Xsfe/3aHYMJV3aAuepfJf0SdAkguE8DPpb0sB/jjr9cv
	+EG2Zszg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAcf3-00000009wbc-1X5N;
	Fri, 24 May 2024 21:41:13 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAcez-00000009wa1-3lwM
	for linux-um@lists.infradead.org;
	Fri, 24 May 2024 21:41:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=g56d/xHBpUWGzqqTH0FbaK9FdwzD0VPn9INiOk1xHiI=;
	t=1716586869; x=1717796469; b=mpSwNAZ60iWStn3uKhrd/6w+/MWx5KybV1IppV/HD40rp9s
	JwVzTgwWtOQ/gFJOtq2AElHRTjDGsGx/crT6C9UbPHM/54QqDqdKeLuY8iJL5Qd8Uh/Nd4ISQ2tI/
	vQBujXNEWUquX7qAgzK8Ntgzjh4xezOcvomgtAJFNjOQdWXUdODzF48Vmicf3TzriRYCrPm47c7d5
	1RRfkJHoPrV0FHvPeve+eR4nbR/MeilkzEQy7O7FT/ldjhAK/OK8mY6p24rgP7jYNGvfGQ3JRqsfw
	biNyFYR+KFG4Miw545LEAQvD9bfRgYwSp3M9CFNFaHbiS/mMqPODiSh+PdZ/649w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sAceu-00000008ke7-20FD;
	Fri, 24 May 2024 23:41:05 +0200
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v3 03/12] um: Add generic stub_syscall6 function
Date: Fri, 24 May 2024 23:37:09 +0200
Message-ID: <20240524213718.1757703-4-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524213718.1757703-1-benjamin@sipsolutions.net>
References: <20240524213718.1757703-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240524_144109_968768_3468EA2C 
X-CRM114-Status: UNSURE (   7.75  )
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

From: Benjamin Berg <benjamin@sipsolutions.net>

This function will be used by the new syscall handling code.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/x86/um/shared/sysdep/stub_32.h | 22 ++++++++++++++++++++++
 arch/x86/um/shared/sysdep/stub_64.h | 16 ++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/x86/um/shared/sysdep/stub_32.h b/arch/x86/um/shared/sysdep/stub_32.h
index 2748b7ee031a..ab08a69fb57f 100644
--- a/arch/x86/um/shared/sysdep/stub_32.h
+++ b/arch/x86/um/shared/sysdep/stub_32.h
@@ -80,6 +80,28 @@ static __always_inline long stub_syscall5(long syscall, long arg1, long arg2,
 	return ret;
 }
 
+static __always_inline long stub_syscall6(long syscall, long arg1, long arg2,
+					  long arg3, long arg4, long arg5,
+					  long arg6)
+{
+	struct syscall_args {
+		int ebx, ebp;
+	} args = { arg1, arg6 };
+	long ret;
+
+	__asm__ volatile ("pushl %%ebp;"
+			"movl 0x4(%%ebx),%%ebp;"
+			"movl (%%ebx),%%ebx;"
+			"int $0x80;"
+			"popl %%ebp"
+			: "=a" (ret)
+			: "0" (syscall), "b" (&args),
+			"c" (arg2), "d" (arg3), "S" (arg4), "D" (arg5)
+			: "memory");
+
+	return ret;
+}
+
 static __always_inline void trap_myself(void)
 {
 	__asm("int3");
diff --git a/arch/x86/um/shared/sysdep/stub_64.h b/arch/x86/um/shared/sysdep/stub_64.h
index 50c5e0529dfb..d27b34d75d70 100644
--- a/arch/x86/um/shared/sysdep/stub_64.h
+++ b/arch/x86/um/shared/sysdep/stub_64.h
@@ -80,6 +80,22 @@ static __always_inline long stub_syscall5(long syscall, long arg1, long arg2,
 	return ret;
 }
 
+static __always_inline long stub_syscall6(long syscall, long arg1, long arg2,
+					  long arg3, long arg4, long arg5,
+					  long arg6)
+{
+	long ret;
+
+	__asm__ volatile ("movq %5,%%r10 ; movq %6,%%r8 ; movq %7,%%r9 ; "
+		__syscall
+		: "=a" (ret)
+		: "0" (syscall), "D" (arg1), "S" (arg2), "d" (arg3),
+		  "g" (arg4), "g" (arg5), "g" (arg6)
+		: __syscall_clobber, "r10", "r8", "r9");
+
+	return ret;
+}
+
 static __always_inline void trap_myself(void)
 {
 	__asm("int3");
-- 
2.45.1



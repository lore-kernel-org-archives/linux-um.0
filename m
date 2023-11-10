Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C668C4332F
	for <linux-um@archiver.kernel.org>; Fri, 10 Nov 2023 11:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nPd5Chgvm1gGswyhi9q6PNpCpRH0btEwv+VdrVnjaxs=; b=nSucnVa8e6Wm/g
	QG20FC1lUYVilHEAtA0Bzx7opM6HYqGVSNjSaIgJdwY+r8I+q2xopMGeMTYJPkX3D9NI+Qt1FPt0v
	K5skMlR3LijMuj3sbrXNu+rvtz6M9Eq6RTd6KKKBr//XgKTKkdI9nPsi0/4+t7zB+03Xtw6UcQRd1
	ULfFCHQ5LwZ2B5GcN2G7s+bZ6WALKbv+3toKk8uSMo/46QigoCoG3Umtdq2xDHhmK4nKkHDlJ6y6O
	W0FpIgsLlFHEGosVz6dh3tkkz0Xu7VnP1CsvMplpI3BIEWLMFvhbe+FEKhd4Kwrx2y59ii43ivud6
	bqOcGJ0BGDYcbbMC3Buw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r1PJP-008M4v-0e;
	Fri, 10 Nov 2023 11:04:31 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r1PJK-008LzE-0R
	for linux-um@lists.infradead.org;
	Fri, 10 Nov 2023 11:04:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=XSudjHgghTPFhLyU0XD3jR3iavflbyhUZIrEjo+QMNI=;
	t=1699614265; x=1700823865; b=yJ9ILFKbMFQB2PCANBUBRZutvUqhOWq+y36Qt2eozfbsKfm
	MMNOGemD2lLxn19NEgp4i6Lh8lVG45QgEpa8loxnl7w2f6zbG6oDHrcohpjYZYohfn3d/7wxrB6nT
	jgzdEvqaLFKM4eebO2LjYGoeH7YwQcWHQdA2fgA/jp3OYd8ZUR5V6PWIpxFS+RR5po3aAk2+YUSur
	m83XeFX6CmAb/cvrKjyybXLqjGu1Gz1J5fl0PaE+hAT1zqx9nJp8qPXvtPcdThWrCT49Lg1jqD+2s
	ir6oM5GBL5e2+0ev1oOBCGSGqJ9k3RGjuU55EC3Y/tbgyoS/liO4r1+2olpSB85g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1r1PJG-00000002xHc-0wMe;
	Fri, 10 Nov 2023 12:04:22 +0100
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v3 11/11] um: Mark 32bit syscall helpers as clobbering memory
Date: Fri, 10 Nov 2023 12:03:48 +0100
Message-ID: <20231110110348.1815612-12-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231110110348.1815612-1-benjamin@sipsolutions.net>
References: <20231110110348.1815612-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231110_030426_173848_A48118D2 
X-CRM114-Status: UNSURE (   7.65  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Benjamin Berg <benjamin@sipsolutions.net>

The 64bit helper are marked to clobber the memory, but the 32bit ones
are not. Add the appropriate clobber to the 32bit helper routines so
that the compiler cannot do invalid optimizations.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/x86/um/shared/sysdep/stub_32.h | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/x86/um/shared/sysdep/stub_32.h b/arch/x86/um/shared/sysdep/stub_32.h
index 4e763f8b380f..ea8b5a2d67af 100644
--- a/arch/x86/um/shared/sysdep/stub_32.h
+++ b/arch/x86/um/shared/sysdep/stub_32.h
@@ -16,7 +16,8 @@ static __always_inline long stub_syscall0(long syscall)
 {
 	long ret;
 
-	__asm__ volatile ("int $0x80" : "=a" (ret) : "0" (syscall));
+	__asm__ volatile ("int $0x80" : "=a" (ret) : "0" (syscall)
+			: "memory");
 
 	return ret;
 }
@@ -25,7 +26,8 @@ static __always_inline long stub_syscall1(long syscall, long arg1)
 {
 	long ret;
 
-	__asm__ volatile ("int $0x80" : "=a" (ret) : "0" (syscall), "b" (arg1));
+	__asm__ volatile ("int $0x80" : "=a" (ret) : "0" (syscall), "b" (arg1)
+			: "memory");
 
 	return ret;
 }
@@ -35,7 +37,8 @@ static __always_inline long stub_syscall2(long syscall, long arg1, long arg2)
 	long ret;
 
 	__asm__ volatile ("int $0x80" : "=a" (ret) : "0" (syscall), "b" (arg1),
-			"c" (arg2));
+			"c" (arg2)
+			: "memory");
 
 	return ret;
 }
@@ -46,7 +49,8 @@ static __always_inline long stub_syscall3(long syscall, long arg1, long arg2,
 	long ret;
 
 	__asm__ volatile ("int $0x80" : "=a" (ret) : "0" (syscall), "b" (arg1),
-			"c" (arg2), "d" (arg3));
+			"c" (arg2), "d" (arg3)
+			: "memory");
 
 	return ret;
 }
@@ -57,7 +61,8 @@ static __always_inline long stub_syscall4(long syscall, long arg1, long arg2,
 	long ret;
 
 	__asm__ volatile ("int $0x80" : "=a" (ret) : "0" (syscall), "b" (arg1),
-			"c" (arg2), "d" (arg3), "S" (arg4));
+			"c" (arg2), "d" (arg3), "S" (arg4)
+			: "memory");
 
 	return ret;
 }
@@ -68,7 +73,8 @@ static __always_inline long stub_syscall5(long syscall, long arg1, long arg2,
 	long ret;
 
 	__asm__ volatile ("int $0x80" : "=a" (ret) : "0" (syscall), "b" (arg1),
-			"c" (arg2), "d" (arg3), "S" (arg4), "D" (arg5));
+			"c" (arg2), "d" (arg3), "S" (arg4), "D" (arg5)
+			: "memory");
 
 	return ret;
 }
-- 
2.41.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

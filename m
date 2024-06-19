Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7343C27C79
	for <linux-um@archiver.kernel.org>; Wed, 19 Jun 2024 15:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xmTFsgl24bof8shyvGSfXwvg6mRdf8z6pEjQuUxHf24=; b=uI9dbcZloSnYNV60OB3vavOnHV
	4ZBAnxF8kcobL7p3u4BSYRD4NL/vX27ihHxGVeo7/KzB20/1LrBGw3GqbSOH44R4CIc6vdL3waz8c
	hHJ7WP6RKS17ndn5fjFFzydTZX5bwCRcMtA5ppi5d955YTvTGEhHojFVF3UTAJyOH7/TUjftv2WYM
	PFfJyL3OIFvvswz/vQ1eQrqvzANcZvDY2axKsckfv6xm8UmJWgB5VYQ8QLcAnMPPSO+enwxaTb/ft
	a9dTC7ThSNXj1rtV5tCJzLlkp2sd8aQXu4/1AxEky1XXl0uDgZd2VrrVCgYHKug6+zDbzJ1+GddCy
	OTweC9cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJxLk-00000001pMA-1vnO;
	Wed, 19 Jun 2024 15:35:52 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJxLh-00000001pKJ-2Spo
	for linux-um@lists.infradead.org;
	Wed, 19 Jun 2024 15:35:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=xmTFsgl24bof8shyvGSfXwvg6mRdf8z6pEjQuUxHf24=;
	t=1718811349; x=1720020949; b=r0coxxFoXP5jSMLMTQPRYx0LFxJTOa2R8QvMJXjYWfh9pO1
	kRWIvncKnQeLkogLgVu8mGzwOnq4VJbSAWEHe10FniMngI3CA2rYH61CGAq/GCcOfZWKUUNNTPjdt
	T2OtN6ZYCWPfUDb+8xNSyg0JCbxR367il3wAMGUtvDcxnr45b19IcHS7UCMj07s03Mu7bvZeHGSXx
	0qvLDoMnMaofvu/RYN7uQt1HJK1t5gfcERve1lk1unfa1EgLUOP/XdJfc1Trmg5U9bQkszkOzq5H+
	7IpFltL5yWk2vGwAQ4N/b6r3LNlLQQjldnWzSXNqcdxr4LPXgm+67wwkRtJZjHpQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sJxLe-000000072rR-20s6;
	Wed, 19 Jun 2024 17:35:46 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v5 1/7] um: Add generic stub_syscall6 function
Date: Wed, 19 Jun 2024 17:34:05 +0200
Message-ID: <20240619153411.2596774-2-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240619153411.2596774-1-benjamin@sipsolutions.net>
References: <20240619153411.2596774-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240619_083549_653194_9AFB2A74 
X-CRM114-Status: UNSURE (   7.39  )
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

This function will be used by the new static stub binary.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/x86/um/shared/sysdep/stub_32.h | 22 ++++++++++++++++++++++
 arch/x86/um/shared/sysdep/stub_64.h | 16 ++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/x86/um/shared/sysdep/stub_32.h b/arch/x86/um/shared/sysdep/stub_32.h
index ea8b5a2d67af..ca2dd9263cf2 100644
--- a/arch/x86/um/shared/sysdep/stub_32.h
+++ b/arch/x86/um/shared/sysdep/stub_32.h
@@ -79,6 +79,28 @@ static __always_inline long stub_syscall5(long syscall, long arg1, long arg2,
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
index b24168ef0ac4..c99ea6e06f96 100644
--- a/arch/x86/um/shared/sysdep/stub_64.h
+++ b/arch/x86/um/shared/sysdep/stub_64.h
@@ -79,6 +79,22 @@ static __always_inline long stub_syscall5(long syscall, long arg1, long arg2,
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



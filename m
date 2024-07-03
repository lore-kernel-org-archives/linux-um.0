Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C18C41513
	for <linux-um@archiver.kernel.org>; Wed,  3 Jul 2024 15:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eoNAHHTUuajA5LGHAGwd3ipWQaKfQaFtCEfYMI2xYrs=; b=O/1+obP1TM3wheMS6Iv1aSP+/J
	24A9fzHiKW8s9BrQnbuNxPyB6eHD9SvR77ALtewAaqVRY55DQsEC7l8UybXU/jznfO6bikLX83LeH
	jimmMaNpjnTDenbiobI7l+W1xjoxWEbDWFJf+W4LuTxG/ojt610GLMls8WysVoeEtG59IZ4NclSXJ
	eTOWfvCDKst53CtlFQZnUCrtxKNiAbIiNucp1W3NGN7jBQF93GqrCjwSjMATuQpc42LZKsR0+uEm/
	AI06Hr412qnL8SBK+ZCArql5PspgCec81wJVqu6PT/2HviHz+GxlxTp/QXhHFQhCgzjSIzh7CbSav
	JTgezEbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP1TU-0000000Aab8-0vbN;
	Wed, 03 Jul 2024 15:00:48 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP0JN-0000000ALGw-2yyO
	for linux-um@lists.infradead.org;
	Wed, 03 Jul 2024 13:46:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=eoNAHHTUuajA5LGHAGwd3ipWQaKfQaFtCEfYMI2xYrs=;
	t=1720014377; x=1721223977; b=b350Fw/Y6TxCVAjzF8TeSHqzR9drutOrKe0NDlIbd4w52k1
	C4oElp2txoBA3AG6tgIbjjfmfLS7/F6+xgoQirYmbi5NuAFln4aYAbY6yvdsbbbve2ceN2wttKsmH
	vTiWVP/QG0A7o9Fp27N33eAfpMUB9qi0YucDEPRa8DoIyYetUMFZcWprDAX9EnRS5OKfWjfI1JBaP
	wzAx/ZxBwqET7TaU8ORSA9n3lOEUQQyafQSI3FQZTBaUHilicTIBNFWObme5bHSRq13BPqqx9tPeK
	xLgaJNU4y5DBgTCS/x9EgPhQ6hI3uiYBw7AWPUBqkvHemJ2lQfaws0UGKXj+S+YA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sP0JI-000000094nb-3pP2;
	Wed, 03 Jul 2024 15:46:13 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v4 03/12] um: Add generic stub_syscall6 function
Date: Wed,  3 Jul 2024 15:45:27 +0200
Message-ID: <20240703134536.1161108-4-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703134536.1161108-1-benjamin@sipsolutions.net>
References: <20240703134536.1161108-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_064617_782102_45B32F30 
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
2.45.2



Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFF3CE8E68
	for <linux-um@archiver.kernel.org>; Thu, 24 Oct 2024 12:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HLezBSRvtfmvUG7OGWu8Dvrc68zUbgVO3wSMAfeRQsA=; b=vY76lI/FbxYFe94Wn9e9tlxL9T
	nzpjgwh2RKtTyzlhvPmVNgDQERuXUtUWTZfNWFddIR+y3w3yOLJNVAyVdP4LgJRhXwWny67FlOm0y
	VFca+j8SMGxxqRkmFZc1L8i4ofdCrdZ553U0Lw776Gy74BhRHiDraHpX897gAzOmvsBru9SFRUpa4
	VePpbqo5fmNuf6ziraPL+XPU+Dn0lZ5Dh1jmvvj/JAuRYEhOl3jpTshBp/qUgGFddX+pjNDkFO9fA
	Wghnls2/lPbRQbun01+hCra/yhjGBdHaeYDI0cLtUpw8Exe+E+xFexyzyIiw1SS5CtwFV+w3miJu2
	YgZ6QnDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3wgV-00000000Isi-43Me;
	Thu, 24 Oct 2024 12:11:23 +0000
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3wfX-00000000Idm-3xEK
	for linux-um@lists.infradead.org;
	Thu, 24 Oct 2024 12:10:25 +0000
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-7ea7ad1e01fso568385a12.0
        for <linux-um@lists.infradead.org>; Thu, 24 Oct 2024 05:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729771822; x=1730376622; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLezBSRvtfmvUG7OGWu8Dvrc68zUbgVO3wSMAfeRQsA=;
        b=aQk2RGeQBqII2bgmjs7jYujyQzEpqj5AZAW+zJnMEtles2maTtP29HBsGrQmfxGRAN
         +vwuJ9v4q3PIhRPOVR8UcQyoWniC8TUHmXefDynAPuQZXJQDhWK3/EmD+jvFNzVXQjEg
         GzOLkyrxP3jtJLUu6ibiJG7i6eaibxN4htdFUrz/sVNvmzkoX4wpkpr4nESiHwHaUPHP
         HmKSIcnmb6ZduIExGgguxKqOZbBKybJhisyn10aXnqCWvEuBpuxkj2QXM97ccfnUKu1Q
         /kIe/LAj8IIKk32q3F9DTjprWy4jCGsKr6OrDnUiSNbHcbVKldTkvGSrPWXnNWX/Rh69
         1vsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729771822; x=1730376622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLezBSRvtfmvUG7OGWu8Dvrc68zUbgVO3wSMAfeRQsA=;
        b=kHwxxRsbBt+7mBvn0Sud9q23lxExr469UvTREtrnxYnxHHZ1Q69e/hJHB7Ot/Aarpl
         jAbWgjIVHWzOMnmgY+4G+jmdG8D4nAhVgVDSnsw1aE3K22bQ9HlUXcllN7sNSLlVN0fl
         EBh0zWZo4zcgLcEvGz/CdbbGaVvz0+6gJDTIARFI0i+2astaBLFQSyZw0+9QDw2BsanE
         qnUoIsjsGeggdioTHVe4OgssG6NXMpSOIubgKXgNvpcVMrV8+EFWEtUjt4P5pEvUyMt+
         tQ9yfgJxDtkfwaJSTO54pnxm+bitvFhP3DSO7GeG++rXyLn5lWTTEvBo7qPEfkc9FZPl
         iFsQ==
X-Gm-Message-State: AOJu0Yz2z0xfEEPecvVG+pLTIPdr7xq6Ov2kuyb0RL7NupJync9cc1o2
	EbTttod9dDcz5S80WDS9d5ydLae3HFLlFVSnZ0e8zjSYrMMuH9H8
X-Google-Smtp-Source: AGHT+IG3iEp80oEstszILK6cQgNZ9GU1HXbz6EGYNeoERgYifM+NAAk5UxjEKiUB5+/OzmNLjYCsbQ==
X-Received: by 2002:a05:6a21:4603:b0:1d9:651:7d34 with SMTP id adf61e73a8af0-1d9888bb579mr2880882637.12.1729771822450;
        Thu, 24 Oct 2024 05:10:22 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec14159d4sm7804026b3a.210.2024.10.24.05.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 05:10:21 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 2EEC2D51259; Thu, 24 Oct 2024 21:10:20 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org,
	jdike@addtoit.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: thehajime@gmail.com,
	ricarkol@google.com
Subject: [RFC PATCH 09/13] x86/um: nommu: signal handling
Date: Thu, 24 Oct 2024 21:09:17 +0900
Message-ID: <f3c873365cccce18b2f1889984bf521d3cfb68f2.1729770373.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729770373.git.thehajime@gmail.com>
References: <cover.1729770373.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241024_051024_001519_8EB66B71 
X-CRM114-Status: UNSURE (   9.92  )
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

This commit updates the behavior of signal handling under !MMU
environment. 1) the stack preparation for the signal handlers and
2) retoration of stack after rt_sigreturn(2) syscall.  Those are needed
as the stack usage on vfork(2) syscall is different.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/x86/um/signal.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/x86/um/signal.c b/arch/x86/um/signal.c
index 2cc8c2309022..ae9b231dd8f8 100644
--- a/arch/x86/um/signal.c
+++ b/arch/x86/um/signal.c
@@ -537,6 +537,18 @@ int setup_signal_stack_si(unsigned long stack_top, struct ksignal *ksig,
 		/* could use a vstub here */
 		return err;
 
+#ifndef CONFIG_MMU
+	/*
+	 * we need to push handler address at top of stack, as
+	 * __kernel_vsyscall, called after this returns with ret with
+	 * stack contents, thus push the handler here.
+	 */
+	frame = (struct rt_sigframe __user *) ((unsigned long) frame -
+					       sizeof(unsigned long));
+	err |= __put_user((unsigned long)ksig->ka.sa.sa_handler,
+			  (unsigned long *)frame);
+#endif
+
 	if (err)
 		return err;
 
@@ -562,6 +574,20 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	unsigned long sp = PT_REGS_SP(&current->thread.regs);
 	struct rt_sigframe __user *frame =
 		(struct rt_sigframe __user *)(sp - sizeof(long));
+#ifndef CONFIG_MMU
+	/**
+	 * we enter here with:
+	 *
+	 * __restore_rt:
+	 *     mov $15, %rax
+	 *     call *%rax (translated from syscall)
+	 *
+	 * (code is from musl libc)
+	 * so, stack needs to be popped of "call"ed address before
+	 * looking at rt_sigframe.
+	 */
+	frame = (struct rt_sigframe __user *)((unsigned long)frame + sizeof(long));
+#endif
 	struct ucontext __user *uc = &frame->uc;
 	sigset_t set;
 
-- 
2.43.0



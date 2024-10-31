Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7DDD767D7
	for <linux-um@archiver.kernel.org>; Thu, 31 Oct 2024 14:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GjG1Jqg2zggFojVZ7xhgNAm0cBw8ujXS9U8aBr/OGbM=; b=wDGmzrOZOUM4POIW3FM+KiL6Sl
	OaHbiRnmXzlao7h7NZhocCmaWc7qckQh9sHY7hLqeg3Yf7+XwObSRJyHslNZE9NBFzSbRntJRXAcB
	bjGhtaCXqWnoJkeuvwcWzIMBlJaWhp6SFiYUBxzHcectRT2mbHr7JpSlTGClP+JxFgqVLQhX+CGyz
	Bv8V6RQyoqCJhAUbnaT9QXVzAQX57UZRlAI/RjaYt1MNRP3bLGMzmzB9VVjzbMw65wxf7sz7kEc2l
	CoUQyVPVfzMNVqAaqkhFX/XWZBsmX7JvFeFZTS58o7fpGWyjYF5SFz+sohBWj5tmiF8NfQJiRLAj1
	cRjCtLxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6W3W-00000003n63-33PL;
	Thu, 31 Oct 2024 14:21:46 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6W3E-00000003n3e-2SfQ
	for linux-um@lists.infradead.org;
	Thu, 31 Oct 2024 14:21:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=GjG1Jqg2zggFojVZ7xhgNAm0cBw8ujXS9U8aBr/OGbM=;
	t=1730384486; x=1731594086; b=npq3DeSRZt051UCWOc8Js0AnHiDKzPJFSZJD/ULM1bb0WqL
	KRaU6/gQkeRt0vvAF9QJ2rzxwz+u2E/UOyMKpfvfo6dyZWasJm3lORv08YSjLUPed6smjIbFCW1XF
	3XG6UsAv6KTxsg/OQblWfaHrGK4XS3Plwiof2g9gHQsNR0MOaEmfWi3Q6tEcDSNPekPYI7Yiw9uRY
	OMOV7GkKWIigelVhUzsm1wFMl4HAxOrAMDQPGclvDUh7MWN5SuHxr3/tLXMpQ+/aWHF1d10WoCTzu
	sOkS/oci/fKgWYbqQnEd8zWPdWooOuVEHlbATagq72UhRY+DF0nqGXBtsDw+UUkg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1t6W3A-0000000AUMx-1RvT;
	Thu, 31 Oct 2024 15:21:24 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 2/2] um: fix sparse warnings in signal code
Date: Thu, 31 Oct 2024 15:20:17 +0100
Message-ID: <20241031142017.430420-2-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031142017.430420-1-benjamin@sipsolutions.net>
References: <20241031142017.430420-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241031_072128_666980_40A8B1FC 
X-CRM114-Status: UNSURE (   8.01  )
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

sparse reports that various places were missing the __user tag in casts.
In addition, one location was using 0 instead of NULL.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/x86/um/signal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/um/signal.c b/arch/x86/um/signal.c
index 797c4e4e57f3..75087e85b6fd 100644
--- a/arch/x86/um/signal.c
+++ b/arch/x86/um/signal.c
@@ -242,7 +242,7 @@ int setup_signal_stack_sc(unsigned long stack_top, struct ksignal *ksig,
 	if (ksig->ka.sa.sa_flags & SA_RESTORER)
 		restorer = ksig->ka.sa.sa_restorer;
 
-	err |= __put_user(restorer, (void **)&frame->pretcode);
+	err |= __put_user(restorer, (void __user * __user *)&frame->pretcode);
 	err |= __put_user(sig, &frame->sig);
 
 	fp_to = (unsigned long)frame + sizeof(*frame);
@@ -298,10 +298,10 @@ int setup_signal_stack_si(unsigned long stack_top, struct ksignal *ksig,
 	if (ksig->ka.sa.sa_flags & SA_RESTORER)
 		restorer = ksig->ka.sa.sa_restorer;
 
-	err |= __put_user(restorer, (void **)&frame->pretcode);
+	err |= __put_user(restorer, (void __user * __user *)&frame->pretcode);
 	err |= __put_user(sig, &frame->sig);
-	err |= __put_user(&frame->info, (void **)&frame->pinfo);
-	err |= __put_user(&frame->uc, (void **)&frame->puc);
+	err |= __put_user(&frame->info, (void __user * __user *)&frame->pinfo);
+	err |= __put_user(&frame->uc, (void __user * __user *)&frame->puc);
 	err |= copy_siginfo_to_user(&frame->info, &ksig->info);
 
 	fp_to = (unsigned long)frame + sizeof(*frame);
@@ -387,7 +387,7 @@ int setup_signal_stack_si(unsigned long stack_top, struct ksignal *ksig,
 
 	/* Create the ucontext.  */
 	err |= __put_user(0, &frame->uc.uc_flags);
-	err |= __put_user(0, &frame->uc.uc_link);
+	err |= __put_user(NULL, &frame->uc.uc_link);
 	err |= __save_altstack(&frame->uc.uc_stack, PT_REGS_SP(regs));
 
 	fp_to = (unsigned long)frame + sizeof(*frame);
@@ -411,7 +411,7 @@ int setup_signal_stack_si(unsigned long stack_top, struct ksignal *ksig,
 	 */
 	/* x86-64 should always use SA_RESTORER. */
 	if (ksig->ka.sa.sa_flags & SA_RESTORER)
-		err |= __put_user((void *)ksig->ka.sa.sa_restorer,
+		err |= __put_user((void __user *)ksig->ka.sa.sa_restorer,
 				  &frame->pretcode);
 	else
 		/* could use a vstub here */
-- 
2.47.0



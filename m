Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA56FD11182
	for <linux-um@archiver.kernel.org>; Sun,  3 Nov 2024 16:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uvTUeY4nW8G96d6r63V1w93F5PG8BhriH1sJwMIWNAk=; b=KGb/GGLTK0aIc/BNyw0Hr9wIuj
	qfkuOTiTDfKV9Byl5Gr1T3oJa519S8nAunjLm1Ra3ZIUhCg8d+uqWkcE1fB2ZF1M9bjIOO51gG+1p
	GsPO73iIz1KfINB7tSud791Qfo2XWu3zEhvg0N1FqWMBErvMWAmLFsh8a+EwN02Z+kUPqinuOS9B4
	6vG0Uc+1wkIpS6nUijthLQ8K4kB5N2EMsGU+Ppn/rYDZ/tgJvc1UgDasqDysQM6lMwqaR+4jcLSq3
	ofdaKXvkj1GbLbJsGovhhpvPnQHcE1QYTOZJCVoKbxeZSqW6NCuITUFr4eMB5LyCdN1r++TfpD7LP
	s0rbDBpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7dG2-0000000BgHR-0ZEk;
	Sun, 03 Nov 2024 16:15:18 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7cAR-0000000BbTs-17Ms
	for linux-um@bombadil.infradead.org;
	Sun, 03 Nov 2024 15:05:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=uvTUeY4nW8G96d6r63V1w93F5PG8BhriH1sJwMIWNAk=; b=QUFvlR2H+divHvqIe688XlGrJE
	NJZt0WGFou21RRkgfHzyiY2tsXfb1ASKyzV046D79GvC12oi2DvlTTnT5JoZq9cdaOTFk3z5TZUNW
	0p8RRFbvL3kJ7O7kOI1hOXCTXCaZgcffIjdDcDDX+aCdbBg1jYIk7/g1I71LSCXqWuss+40FqLQtn
	tgnhvYENTHtGI1ToQH8gscDIAAPJKVJiMQazUzmLWHkHH3chHKqdpHouOCTzPT/564Xd7p2BHNWAw
	94gst9KcZDd98ERSE4abm1dFVldajpkUsyl5s+mUSNa2GvAPC6r4wDIvHAZmYxnRmLHDvpcVDElpT
	e6fvYfmg==;
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7cAO-0000000B8gA-0WL4
	for linux-um@lists.infradead.org;
	Sun, 03 Nov 2024 15:05:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=uvTUeY4nW8G96d6r63V1w93F5PG8BhriH1sJwMIWNAk=;
	t=1730646324; x=1731855924; b=PZE6ldoyWgNA4ITlwOPp6iO0nkacsey1zl5MKevWr+01/Zf
	WA6T/WWhZkznrrlKy360TlrTTM6HmdfpEd9XTWUBSApfQRYhZwRsK20j9e6RXiN9tzlsZVkSnpaTC
	60f3KrFGr1Edqm4Zh1Qo45Btm/tLfMES7/agTZypIYg5N2BGEXTG8QgN8OtSNviT7C2gtyKjrLxa6
	rBUmpiu8Ma0kK/1ZbM9vCSImQMGOgjQgxMXS6M3KCY/ftYYJESt8hVkbJ9LAwv8ewOuakc/a0O9Qz
	CsqW23h13eWKrYeyFIP9tF9/aZSj59RJzNc/o6TEtjG7RM7Us9qwEfZZbgAhsKnw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1t7cAM-0000000D5NG-4ASN;
	Sun, 03 Nov 2024 16:05:23 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 5/5] um: remove broken double fault detection
Date: Sun,  3 Nov 2024 16:05:06 +0100
Message-ID: <20241103150506.1367695-5-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103150506.1367695-1-benjamin@sipsolutions.net>
References: <20241103150506.1367695-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241103_150524_335972_D3D215B4 
X-CRM114-Status: GOOD (  11.89  )
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

The show_stack function had some code to detect double faults. However,
the logic is wrong and it would e.g. trigger if a WARNING happened
inside an IRQ.

Remove it without trying to add a new logic. The current behaviour,
which will just fault repeatedly until the IRQ stack is used up and the
host kills UML, seems to be good enough.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/include/shared/os.h | 1 -
 arch/um/kernel/sysrq.c      | 6 ------
 arch/um/os-Linux/signal.c   | 8 --------
 3 files changed, 15 deletions(-)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 6c656ef096c9..5babad8c5f75 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -241,7 +241,6 @@ extern void block_signals(void);
 extern void unblock_signals(void);
 extern int um_set_signals(int enable);
 extern int um_set_signals_trace(int enable);
-extern int os_is_signal_stack(void);
 extern void deliver_alarm(void);
 extern void register_pm_wake_signal(void);
 extern void block_signals_hard(void);
diff --git a/arch/um/kernel/sysrq.c b/arch/um/kernel/sysrq.c
index 4bb8622dc512..a3bdab048617 100644
--- a/arch/um/kernel/sysrq.c
+++ b/arch/um/kernel/sysrq.c
@@ -32,12 +32,6 @@ void show_stack(struct task_struct *task, unsigned long *stack,
 	struct pt_regs *segv_regs = current->thread.segv_regs;
 	int i;
 
-	if (!segv_regs && os_is_signal_stack()) {
-		pr_err("Received SIGSEGV in SIGSEGV handler,"
-				" aborting stack trace!\n");
-		return;
-	}
-
 	if (!stack)
 		stack = get_stack_pointer(task, segv_regs);
 
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 1c6caa9dbd6c..52852018a3ad 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -487,11 +487,3 @@ void unblock_signals_hard(void)
 	unblocking = false;
 }
 #endif
-
-int os_is_signal_stack(void)
-{
-	stack_t ss;
-	sigaltstack(NULL, &ss);
-
-	return ss.ss_flags & SS_ONSTACK;
-}
-- 
2.47.0



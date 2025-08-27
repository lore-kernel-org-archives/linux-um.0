Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DC8CA0EFF
	for <linux-um@archiver.kernel.org>; Wed, 27 Aug 2025 22:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uQYJoCHr8UsTe/NWEdR+cbblxqgBEXUC11uzxpt2GJM=; b=A67xRmJa67givbqvTwpsBenFRL
	jRauL4JG8ubYLNNKCMf3nc/FKUx7n2/D1xmpMLoXbWgzq6McZykQtOQ61OD1To8xFzNws7WjyUAaq
	53cZmewL65rhrLMZnyEHelgh/HELtXvbrM+Hsog9km2dqrGGqg5fRcYOB0885j1+xGiNtqrWLMJnR
	yxHKwJUsFuq06G7ltZ31xaAV5n4b/yLSQEzd+4HKvhX1y4KEOvA07rznlaC7o/uC0e/W1suUM0Rai
	Gs7PW6uk5OSk/j/A9mivdIGz4Pruz5nnaVQ/XG7JZ/fQ00KJy/5rA/QhAkcn5hDFlsLbATSxpVNqo
	tkCo/TIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urONo-0000000H217-14ir;
	Wed, 27 Aug 2025 22:12:44 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urOGA-0000000GyVa-1480
	for linux-um@lists.infradead.org;
	Wed, 27 Aug 2025 22:04:51 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2489c65330aso3196755ad.0
        for <linux-um@lists.infradead.org>; Wed, 27 Aug 2025 15:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756332289; x=1756937089; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uQYJoCHr8UsTe/NWEdR+cbblxqgBEXUC11uzxpt2GJM=;
        b=D/F7U8Mxdq0mTrZEtFswxAPRuqE0Fag6UwaZWjXd1G4N4q9EnN+ojxpq/n1A2MqC/2
         O4nC9ZkI8ts684wi+fgOES6HFzXRO9LpRXVsrFthQcRtSP2zaly118Gi/Te1z+EraPFb
         qKRYRNzMsxjvg5Q0ITBPUHB8NQOOM7s7tIrRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756332289; x=1756937089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uQYJoCHr8UsTe/NWEdR+cbblxqgBEXUC11uzxpt2GJM=;
        b=V0a0re7rY0BPPgtvyuTkn0SVc9MCnLmJd2XUXHnjcedqtAOosNTqBGYRkly5oHTpUB
         t2kI/7lnnhaj8wjADsq1DkroRD2knRCHOIKVPNNHbhCz5GsbnPZtieC7bfdt9dKqkhxk
         XZmx7qfP/BVPfaa9D8M/HuVsxmfy/tQ4RipGKYxDBVeWa7y3YY0GTgCLIPSf3ERwboJP
         hdiRO5H1FrNDfG2M03E8WnPho+1gP+MHcLxxxYhhiLHRXrSbr4VDZDB4b5SENP0ZCc8b
         IVvmW7Uh3uD3r2m1r84OohGqcsYhrzT8lmbBSLJ6f3pZSMHEwzDUyp8MbfKhsiVw1Unz
         dlzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSmOYP36ZQORAyXnCnntJq2Pslot/dCKbQNhZM5JpieEZNTy01k8dOQ9mkoydDRBZx5SlwJTWr+A==@lists.infradead.org
X-Gm-Message-State: AOJu0YzTJmj9L7jH3lr+JqKtL0VUPMeHQ2djSLA+oBtEC24Ljzfx1FR4
	53Tq31v6O7mvm3xVhnrwwTFLmzLN3ZnHvwsAEZ1oTL06YlZSEMusspW0RIrFVw3F8w==
X-Gm-Gg: ASbGnctFnfggnvyeR6/hEo8MClTNYwGCvM5hxBUiEqDLZQAbdW4pZ0lgdVYP6db6KLR
	qKU1AYcPjKePTX7zE6UEtGIJM3/5pwb1uQO87MG6z0Ckp5DgU4J1sXKegRBsVQCkedI+fzvR0y4
	Dg1pTykShfU6nW/KMnHVuPLVexWgHhRk+btPm3BiWz4bhaeT+M/PKSJmCRwPcOqJIHGINM/xQvT
	8yxvJN3Rhdf0hL1zjdIvj2jP07pmq/hDcn3dk5f5WRWxwi0rzk5tsM6G6FNio28Hr0b8XiZXr1t
	lw65GTCmbss1aguHhyz25dg6UdE3H8sMzCSXPfEyIS8RXQ+MWkjetamxQfQfOWIrm1sXkFjCZF2
	OxF8zr8Lt1SGRsXeCe67iSe0+IXdpHc3ySrrnDfTYgI/JB5gSbLyhBIjF4X3n
X-Google-Smtp-Source: AGHT+IEMjqSQ+fgnoPTouIyunJfw71nzg7Eizpd9nDcGum95CFW4usmdozPBVbnaQPZxtX8XoFntCQ==
X-Received: by 2002:a17:903:1a2b:b0:242:9d61:2b60 with SMTP id d9443c01a7336-2462edac937mr313050745ad.6.1756332289446;
        Wed, 27 Aug 2025 15:04:49 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:36f6:f0a2:9401:263d])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2466885ed38sm130742425ad.95.2025.08.27.15.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 15:04:48 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	David Gow <davidgow@google.com>,
	Sinan Nalkaya <sardok@gmail.com>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2] um: Support SPARSE_IRQ
Date: Wed, 27 Aug 2025 15:04:18 -0700
Message-ID: <20250827220434.1896850-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250827_150450_329985_4416E279 
X-CRM114-Status: GOOD (  13.52  )
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

From: Sinan Nalkaya <sardok@gmail.com>

Motivation: IRQ KUnit tests are going to require CONFIG_SPARSE_IRQ [1] in
order to:
(a) reliably allocate additional (fake) IRQs and
(b) ensure we can test managed affinity, which is only supported with
    SPARSE_IRQ.

It seems that the only thing necessary for ARCH=um is to tell the genirq
core to skip over our preallocated NR_IRQS.

Tested with:

  $ ./tools/testing/kunit/kunit.py run
  [...]
  [13:55:58] Testing complete. Ran 676 tests: passed: 646, skipped: 30
  [...]

This compares with pre-patch results:

    Ran 672 tests: passed: 644, skipped: 28

i.e., we no longer skip tests that 'depend on SPARSE_IRQ', and existing
tests all pass.

[1]
[PATCH v2 4/6] genirq/test: Depend on SPARSE_IRQ
https://lore.kernel.org/all/CABVgOSngoD0fh1WEkUCEwSdk0Joypo3dA_Y_SjW+K=nVDnZs3Q@mail.gmail.com/

Signed-off-by: Sinan Nalkaya <sardok@gmail.com>
[Brian: Adapted Sinan's patch; rewrote commit message]
Signed-off-by: Brian Norris <briannorris@chromium.org>
Tested-by: David Gow <davidgow@google.com>
---
This is adapted from Sinan's work at:
[PATCH 1/1] um: Fix broken IRQs if SPARSE_IRQ is selected
https://lore.kernel.org/all/1360193940-31504-1-git-send-email-sardok@gmail.com/

Place any blame for errors on me of course.

I'm not much of a UML developer, although I've been developing KUnit
tests which default to running on ARCH=um.

I also can't quite tell if MAY_HAVE_SPARSE_IRQ or SPARSE_IRQ is a better
'select' target. Almost every other architecture uses 'select
SPARSE_IRQ', with the one exception of arch/csky. For my purposes, it's
better to 'select SPARSE_IRQ', for consistency with other ARCH'es, and
to make it easier for KUnit builds to get it. But I'm less sure if there
are good reasons to want to make it user-(un)selectable.

Changes in v2:
 * Drop #ifdef

 arch/um/Kconfig      | 1 +
 arch/um/kernel/irq.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 9083bfdb7735..8161cc5ae6f7 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -38,6 +38,7 @@ config UML
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_SYSCALL_TRACEPOINTS
 	select THREAD_INFO_IN_TASK
+	select SPARSE_IRQ
 
 config MMU
 	bool
diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index 0dfaf96bb7da..d69d137a0334 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -691,6 +691,11 @@ void __init init_IRQ(void)
 	os_setup_epoll();
 }
 
+int __init arch_probe_nr_irqs(void)
+{
+	return NR_IRQS;
+}
+
 void sigchld_handler(int sig, struct siginfo *unused_si,
 		     struct uml_pt_regs *regs, void *mc)
 {
-- 
2.51.0.268.g9569e192d0-goog



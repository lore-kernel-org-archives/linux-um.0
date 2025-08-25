Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E607C8303F
	for <linux-um@archiver.kernel.org>; Mon, 25 Aug 2025 21:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=415LBzM8hZdcn0llBBL+cpvcLMGysoV8tKCiyVqoPY4=; b=qE5mr5HQOW+rk4PWZCXDynlGBu
	xkxh5IOT6wV0SXtDv4v8FkQJX42HGxSvheYVUV+02pE3xUrNvWSnjz5VwTBOL+mjja8AMEfLhSlBS
	HYjlM6lvgtXVCnnaphwI++1MR0kdmBZGoRUo+zgD5gnyfDEoSruXCi46oYC4FZX38BKBgbxQesHUC
	wwgnFxV8O5sUUFIM/LVl7cSqSw3FZaVWwsBMWLCGHF3qYJn9xXNghjT7tptUWD8K7T9yY1ysM1S2o
	wSivdXQnFadEJUT6S475e302DO04aMbyeBnIXJWgym3c5rMAYm4uWzXxxrGXnzhA+zHTNYk5uTNZI
	7zOLjo7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqecT-00000009lIZ-38WQ;
	Mon, 25 Aug 2025 21:20:49 +0000
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqecR-00000009lID-0vRG
	for linux-um@lists.infradead.org;
	Mon, 25 Aug 2025 21:20:48 +0000
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-3258cdb7253so1950452a91.3
        for <linux-um@lists.infradead.org>; Mon, 25 Aug 2025 14:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756156846; x=1756761646; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=415LBzM8hZdcn0llBBL+cpvcLMGysoV8tKCiyVqoPY4=;
        b=GuyJ0mhfZHlmoZOl581AwhxLHcN+wmMYxeBnBSTXfeLVNn+v15QcS5+DPfo16IX8h8
         A/DjGlD1txHnaYzDJGpb33HVXCZUWamq7Ajfiu7fdE5x7bsfLHRK2oizfjBB7pEqdO/f
         tGrGGSXXsKIQcNx9a42CP/kJrwJP5eTbeDJ+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756156846; x=1756761646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=415LBzM8hZdcn0llBBL+cpvcLMGysoV8tKCiyVqoPY4=;
        b=X3x2/xCPPVr+3xO6bn9SxRfxMuPlN3BvWI7mr931Bx6POLf9Z9w0F6JpAqahPASZ7u
         rari6jSkjtgTegYoXGj8UjOtrXdhI2UZQI/3xVaH6WmqtIAKWDvGsAkEBZB9bOWSwny1
         codivjZAFfBntLQIYZIrqOs8VnGO80jHactKTatLfHsv0gE68lQMOwYdcieCCx37bRnx
         YnuKJjTu6gf9EeTgzZ7pvqanQqh01YD53xhAwd+zUDYZPMqkkV/ecoLA0mmNDgHA2ghx
         XHKslO607juUId5dyhbdJXSRvwBbZCqTIhpDRUPvzKsRKBjm4tREFWiZXbjeSQYW35wf
         KytA==
X-Gm-Message-State: AOJu0YwhVVXF/1+oo/NETk+6CJI2ZdzYFJClfR3DiVt4Dn3gS3eQdaan
	lnYJKhbFHjj83lA3BSFf6JZqq5Jih3t1fgocUhYLujioaAv2GDuLQ1EaagnaaKrO+A==
X-Gm-Gg: ASbGncv4VJ/LuR0vgzfV7tH3sicOMXinw7bf7cVNLt5Xl9p2DLTH0P1p82AYgv2qXA8
	kbfo8Td69VIBINSerVhw8RanSubby5TbfK/MtMd4GCSxb549U2rQiuoS4sNHLbX7tH5N5cg8ujP
	rH+ArApbbRCL8gfpL6aStiUrCaV9bIfEtuT7NWGTeo7DqPPzCzyLbW3CoyB8lrMc8UN/OHPPLtp
	QjiRIcDdT3hK8uOTvtZCiYg+FUfkkE1bxz5FS1N+dgqMzX54RhT3FlCaDEgWz3zaapx0pH+b9R4
	u1CFwUGwiDTbaZEiPguu+ESoDsnRoP07AOi7rgkGGRvOTOBh2lEfMSzE8JLr9B6efdCvK4+F0aQ
	iAgCW3fu1V8xuYn5o8msVsJDlVWyzTAUyET7ugYeitd0aP1tbXookm73nQp7E3mG4r/oV
X-Google-Smtp-Source: AGHT+IHF8MOd3EdGFOYW1z3Ecj0EnwmW/nsob9IgPBVbInj/t2YlO5iUytv57P9VYQ3LDbFnmtbluA==
X-Received: by 2002:a17:90b:4c0b:b0:325:8a91:cebe with SMTP id 98e67ed59e1d1-3258a91d131mr7473494a91.35.1756156846019;
        Mon, 25 Aug 2025 14:20:46 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:230e:95:218f:e216])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3254aa71348sm7839396a91.29.2025.08.25.14.20.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 14:20:45 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	David Gow <davidgow@google.com>,
	Sinan Nalkaya <sardok@gmail.com>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH] um: Support SPARSE_IRQ
Date: Mon, 25 Aug 2025 14:19:51 -0700
Message-ID: <20250825212031.111027-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250825_142047_289478_1F467501 
X-CRM114-Status: GOOD (  13.20  )
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

This comparse with pre-patch results:

    Ran 672 tests: passed: 644, skipped: 28

i.e., we no longer skip tests that 'depend on SPARSE_IRQ', and existing
tests all pass.

[1]
[PATCH v2 4/6] genirq/test: Depend on SPARSE_IRQ
https://lore.kernel.org/all/CABVgOSngoD0fh1WEkUCEwSdk0Joypo3dA_Y_SjW+K=nVDnZs3Q@mail.gmail.com/

Signed-off-by: Sinan Nalkaya <sardok@gmail.com>
[Brian: Adapted Sinan's patch; rewrote commit message]
Signed-off-by: Brian Norris <briannorris@chromium.org>
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

 arch/um/Kconfig      | 1 +
 arch/um/kernel/irq.c | 7 +++++++
 2 files changed, 8 insertions(+)

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
index 0dfaf96bb7da..d59a5a0f7fbf 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -691,6 +691,13 @@ void __init init_IRQ(void)
 	os_setup_epoll();
 }
 
+#ifdef CONFIG_SPARSE_IRQ
+int __init arch_probe_nr_irqs(void)
+{
+	return NR_IRQS;
+}
+#endif
+
 void sigchld_handler(int sig, struct siginfo *unused_si,
 		     struct uml_pt_regs *regs, void *mc)
 {
-- 
2.51.0.261.g7ce5a0a67e-goog



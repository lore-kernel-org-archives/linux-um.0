Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E413C001DB
	for <linux-um@archiver.kernel.org>; Tue,  8 Aug 2023 18:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	Mime-Version:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=lkbwTdRcAMV+6yGhi6t7hQuCxpUJ8qb9HHofQ6Br2FY=; b=EDA
	l2AUyLJybB0zdT4B4EMa7STGcHkaVEVWqk3jf7B+mEJl4izxhK0ajjg71mk7ghjU3yxtbH/8GtNEh
	0m8KLD0LTltISa/QajQEud4C40jmxKtSVxLugzYCWEZVyCJloGQ4ru/WpNLyEiG/e1YJdr/nrbD0w
	6gQgbMP8lNqoQsfEQKyokUf3PquAtDA+uoLpiPLDFl7SHajCshhc2hQLLbP+qtBS6BT6vfc6OXZnW
	ZdRJmEfuVJokTIadxY7NNUuHgaxXVHlGDjbuq8z/90ML7ZrlEMelYbmqjs/adJzld50rU+s6+lPvs
	cxKlUocjRKV/U99Wcnh3/lUtzNKbvew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTREz-003CpA-1G;
	Tue, 08 Aug 2023 18:15:33 +0000
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTREw-003Cna-1y
	for linux-um@lists.infradead.org;
	Tue, 08 Aug 2023 18:15:32 +0000
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d20d99c03fbso6870038276.3
        for <linux-um@lists.infradead.org>; Tue, 08 Aug 2023 11:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691518526; x=1692123326;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=++mpSQJ+mJn1Llix5TblC7hjUvrlCzptkSAClKDtJeM=;
        b=XW9ukvoM+p//jGYXwqWGCmky/EuZMgn69MkD7p0oLRrOfDeOq42mjJd8V9+9Q8vfPQ
         gSQ1jVDK8EssKXTrkeheqs6PULfDGrCFFXTlZ6WFJCsxNZ3KD+V1ua/+Kk+XOoU21ZeB
         oXMV0mHg8Ed633uwg456hKWORDIN0vB/8CDAjsdo8pXorOHRXhiKUnsaElUDf2iETyfl
         GbvSevbV9yaZuQtN6Dc13QulswlpLX/Of6p0ICyjJ6n5LZbgto5164Dsv4hNmD3TR0MD
         9ZMNRQG7SWrT/SqcY88xmBY9Wzm/WIePW6nohjOPxkCUYQPEXaUSwtwPsCUvTjOtR0uF
         6j4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691518526; x=1692123326;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=++mpSQJ+mJn1Llix5TblC7hjUvrlCzptkSAClKDtJeM=;
        b=mBG/XpBVgNCPZ2g8MuoJUWtyHjWAO5K/23eqjOR0zk3IyWzzlJTv5OGebkdh3gGKcu
         yfUFa12rKZL4Zr9fYs62yA258RFPqsNYTSFcQuRbykqgcBNTbwfIqoAiHsb7suCKKHfx
         XHDdnq1cWilR+HUgdHzesyxwPYxtez/fPj9BriSQVqhl0lcw3vXYEOpSnMc+EKgNbf4Z
         mwDjx02kIlVt61tNtw4JYDqS1osb5QRQ2xmP+1ApKA6g3uT063UdQRR8CP7KDLE7vHoA
         3o7SvHwxowHAjRHMnwiC5GSEzx0eYwc4I2njEECNU3Ax7yG0P8bw2jPF+s47XhadbVa8
         awdg==
X-Gm-Message-State: AOJu0Yz0Cd5hf+nEmOZPW/8niO1dLFXEJZKGIfqOaR2Nj6ClN6Vsefoq
	/H9/hiqeCE/0oeyS4LfEKyo8MDGw22FSI+4eB7s=
X-Google-Smtp-Source: AGHT+IE3MGEXN7ItXl+piiGaEJGZkqQqvLuCBrx7bsnL2sCaX7FxIRR2YFPtOsHjhD2OjzUumMdVKWM0ziJJ8J2OScU=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:cc03:38d0:9718:e90b])
 (user=ndesaulniers job=sendgmr) by 2002:a05:6902:181c:b0:d40:932e:f7b1 with
 SMTP id cf28-20020a056902181c00b00d40932ef7b1mr6558ybb.7.1691518526803; Tue,
 08 Aug 2023 11:15:26 -0700 (PDT)
Date: Tue, 08 Aug 2023 11:15:24 -0700
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADuG0mQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDCwML3dLc+IqS1KJcXQvzZAPDJAuguJGZElB5QVFqWmYF2Kjo2NpaAII KUV1aAAAA
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=UIrHvErwpgNbhCkRZAYSX0CFd/XFEwqX3D0xqtqjNug=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691518525; l=3445;
 i=ndesaulniers@google.com; s=20220923; h=from:subject:message-id;
 bh=9XjxFoK6lbzNOvJ7p7D8sDLgGVp84//wBryTl/745d4=; b=2cBqCA5rJKD2OhqHWbQ18ZQgxbsIiae9vJN9MGnIluSnQNsC1LXgmSBJXB+nh/4nJ+RF0x8e2
 /O0cikkGsk3Ca1A6fTdsWdYtE5hKXvy2eWTlvTWhW4j8Ac7a2tHMCMT
X-Mailer: b4 0.12.3
Message-ID: <20230808-um_xterm-v1-1-f326e441e47f@google.com>
Subject: [PATCH] um: fix 3 instances of -Wmissing-prototypes
From: Nick Desaulniers <ndesaulniers@google.com>
To: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>, Nick Desaulniers <ndesaulniers@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_111530_650370_2A75694E 
X-CRM114-Status: GOOD (  14.74  )
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

Fixes the following build errors observed from W=1 builds:
  arch/um/drivers/xterm_kern.c:35:5: warning: no previous prototype for
  function 'xterm_fd' [-Wmissing-prototypes]
  35 | int xterm_fd(int socket, int *pid_out)
     |     ^
  arch/um/drivers/xterm_kern.c:35:1: note: declare 'static' if the
  function is not intended to be used outside of this translation unit
  35 | int xterm_fd(int socket, int *pid_out)
     | ^
     | static
  arch/um/drivers/chan_kern.c:183:6: warning: no previous prototype for
  function 'free_irqs' [-Wmissing-prototypes]
  183 | void free_irqs(void)
      |      ^
  arch/um/drivers/chan_kern.c:183:1: note: declare 'static' if the
  function is not intended to be used outside of this translation unit
  183 | void free_irqs(void)
      | ^
      | static
  arch/um/drivers/slirp_kern.c:18:6: warning: no previous prototype for
  function 'slirp_init' [-Wmissing-prototypes]
  18 | void slirp_init(struct net_device *dev, void *data)
     |      ^
  arch/um/drivers/slirp_kern.c:18:1: note: declare 'static' if the
  function is not intended to be used outside of this translation unit
  18 | void slirp_init(struct net_device *dev, void *data)
     | ^
     | static

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308081050.sZEw4cQ5-lkp@intel.com/
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/um/drivers/slirp_kern.c      | 2 +-
 arch/um/drivers/xterm_kern.c      | 1 +
 arch/um/include/shared/irq_kern.h | 1 +
 arch/um/kernel/irq.c              | 2 --
 4 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/um/drivers/slirp_kern.c b/arch/um/drivers/slirp_kern.c
index 2d9769237f08..0a6151ee9572 100644
--- a/arch/um/drivers/slirp_kern.c
+++ b/arch/um/drivers/slirp_kern.c
@@ -15,7 +15,7 @@ struct slirp_init {
 	struct arg_list_dummy_wrapper argw;  /* XXX should be simpler... */
 };
 
-void slirp_init(struct net_device *dev, void *data)
+static void slirp_init(struct net_device *dev, void *data)
 {
 	struct uml_net_private *private;
 	struct slirp_data *spri;
diff --git a/arch/um/drivers/xterm_kern.c b/arch/um/drivers/xterm_kern.c
index 50f11b7b4774..8011e51993d5 100644
--- a/arch/um/drivers/xterm_kern.c
+++ b/arch/um/drivers/xterm_kern.c
@@ -9,6 +9,7 @@
 #include <asm/irq.h>
 #include <irq_kern.h>
 #include <os.h>
+#include "xterm.h"
 
 struct xterm_wait {
 	struct completion ready;
diff --git a/arch/um/include/shared/irq_kern.h b/arch/um/include/shared/irq_kern.h
index f2dc817abb7c..44357fa6ee29 100644
--- a/arch/um/include/shared/irq_kern.h
+++ b/arch/um/include/shared/irq_kern.h
@@ -76,4 +76,5 @@ static inline bool um_irq_timetravel_handler_used(void)
 }
 
 void um_free_irq(int irq, void *dev_id);
+void free_irqs(void);
 #endif
diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index a8873d9bc28b..635d44606bfe 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -23,8 +23,6 @@
 #include <linux/time-internal.h>
 
 
-extern void free_irqs(void);
-
 /* When epoll triggers we do not know why it did so
  * we can also have different IRQs for read and write.
  * This is why we keep a small irq_reg array for each fd -

---
base-commit: 14f9643dc90adea074a0ffb7a17d337eafc6a5cc
change-id: 20230808-um_xterm-87c01b802326

Best regards,
-- 
Nick Desaulniers <ndesaulniers@google.com>


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

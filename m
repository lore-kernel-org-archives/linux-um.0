Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4351C4167B
	for <linux-um@archiver.kernel.org>; Sat, 17 Dec 2022 04:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	References:Mime-Version:In-Reply-To:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Q0WHYt/blxH4iMxmj2WVlxAFxMNGFNBDt36hWwmSbD0=; b=OpNVE1qCIeZbeCppB5DXm6HzEc
	pCZwCgy5hBflu/YAyU5uKTNaWNW1PUpbRPk5vUYhT7J8CeV/Ps8A14DvVSeWx2uc+OBCS2uVR84ox
	kWh3iPZaT3V47xpbEwLqfL1dA8H3cYHya7JkvTPCNBz7grIs9etLswIBscZpDnjhaIqM8HGjZ7kd3
	SK/CPaAdSKaWsw1c4J+E7YAnVqNUZDBm8AdtGHkF3Qgt1DTPO11AFQpwBbwEGwyUfQX5sTtrjQiJJ
	XqwwDtJxjYh8kc9pv3Le5TExA+V8sB74QqfLWSjbqxl9l9/hBrq+WoKpJGH/XXu98wRpvWUL6dL+x
	Mq4Qty5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6P4I-005Ssb-4c; Sat, 17 Dec 2022 04:45:02 +0000
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6P4F-005SnH-Hh
	for linux-um@lists.infradead.org; Sat, 17 Dec 2022 04:45:00 +0000
Received: by mail-pl1-x64a.google.com with SMTP id f8-20020a170902ce8800b00190c6518e21so3008376plg.1
        for <linux-um@lists.infradead.org>; Fri, 16 Dec 2022 20:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YND6/2+MHvKx/dzQIvDqR3IvAStElNFUwtkZlZ3WKgQ=;
        b=QMd8J7EJRoRyHw9X4KgOQl8PvNtaLwUhiAS3fSGBCOFhPoHi9xnvzQDYxVD7j5amTH
         Q4GsEYMqTBsn7iQ3GKJlOQR7EYCNqdaNx2qM4/U0btqkZqTcRMc1G1ID4ksjk8w1ygdM
         DAJeLauQhKJzcld5IN4m9ojYJJXJWXH/+Ncc0RYib27ehXOQzrkybiAFl8r2x8Ptjl/S
         +YkSCxfYkmE6lb0ISCS9tQc9f+6I+0E0L/Tx5CAD18WVWeqB1ST40GnnDKUI3RFsEfBa
         yGtQZgSh/2My4u1fuJc0S39x7Y8SoUOc2boVv2C5FpiuBzR3ANMP90xclhrEoiRdL/87
         jXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YND6/2+MHvKx/dzQIvDqR3IvAStElNFUwtkZlZ3WKgQ=;
        b=D4NujMrv9IMVbSEDRFFnYTH8w6RYaDE5ItEt5cHEG/JACZVXH03pNS8mmR/O23G82I
         q3082yXYrWPMZpVQypDag5VoDaBXUgUMLny0C1Hb27J90xBN81uFijqJBtktnBwyaSSb
         2gCEus0Z7nK/YRNgmuiJDKpnD/UsJ1fySZQJm+CM07wWhXnP2kysqJzXBuD6klacMp1B
         d9g3sORjXT9TI4hE+Lq+sxIo9c2VNGfwjthiRy8CFYsoRrWhbDSqEq9kO8KBIAaP5pyE
         /SWYrjlhUGpgh05ILAQ6EFo706DigxbPN47iws3SWVUCre3qSCCLGNAkMI9rAiePjqLi
         HdPQ==
X-Gm-Message-State: ANoB5pn33xTSVXclw2WsbLC+377oV+HteiZeBnfmLWZMilN6d8J1tRP2
	QANIAtBV8SfE5jupVFSqz0dL6m/7hFoLvg==
X-Google-Smtp-Source: AA0mqf6DRN18kEtRr6vU/bQebITkL+OzR7rXnAWVsO4WmsI6YKnoCOGcBUx49MMTn8GtKKmZYYEz8T0hXzfXAA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:902:8698:b0:188:e255:39af with SMTP
 id g24-20020a170902869800b00188e25539afmr80407695plo.86.1671252297906; Fri,
 16 Dec 2022 20:44:57 -0800 (PST)
Date: Sat, 17 Dec 2022 12:44:36 +0800
In-Reply-To: <20221217044436.4138642-1-davidgow@google.com>
Mime-Version: 1.0
References: <20221217044436.4138642-1-davidgow@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221217044436.4138642-4-davidgow@google.com>
Subject: [PATCH 3/3] rust: arch/um: Add support for CONFIG_RUST under x86_64 UML
From: David Gow <davidgow@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>
Cc: David Gow <davidgow@google.com>, rust-for-linux@vger.kernel.org, 
	linux-um@lists.infradead.org, llvm@lists.linux.dev, linux-doc@vger.kernel.org, 
	kunit-dev@googlegroups.com, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Daniel Latypov <dlatypov@google.com>, 
	Jonathan Corbet <corbet@lwn.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221216_204459_613368_8F3FB5FE 
X-CRM114-Status: GOOD (  10.92  )
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

CONFIG_RUST currently supports x86_64, but does not support it under
UML. With the previous patches applied, adding support is trivial:
add CONFIG_HAVE_RUST to UML if X86_64 is set.

The scripts/generate_rust_target.rs file already checks for
CONFIG_X86_64, not CONFIG_X86, so is prepared for UML support.

The Rust support does not currently support X86_32.

Also, update the Rust architecture support documentation to not that
this is being maintained: I intend to look after this as best I can.

Signed-off-by: David Gow <davidgow@google.com>
---
 Documentation/rust/arch-support.rst | 2 ++
 arch/um/Kconfig                     | 1 +
 2 files changed, 3 insertions(+)

diff --git a/Documentation/rust/arch-support.rst b/Documentation/rust/arch-support.rst
index 6982b63775da..a526ca1c688b 100644
--- a/Documentation/rust/arch-support.rst
+++ b/Documentation/rust/arch-support.rst
@@ -17,3 +17,5 @@ Architecture  Level of support  Constraints
 ============  ================  ==============================================
 ``x86``       Maintained        ``x86_64`` only.
 ============  ================  ==============================================
+``um``        Maintained        ``x86_64`` only.
+============  ================  ==============================================
diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index ad4ff3b0e91e..4db186f019ae 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -28,6 +28,7 @@ config UML
 	select TRACE_IRQFLAGS_SUPPORT
 	select TTY # Needed for line.c
 	select HAVE_ARCH_VMAP_STACK
+	select HAVE_RUST			if X86_64
 
 config MMU
 	bool
-- 
2.39.0.314.g84b9a713c41-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

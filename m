Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B2FC25B75
	for <linux-um@archiver.kernel.org>; Wed, 29 May 2024 09:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=A7jFrnYLPr4qszl6iKNvj0kihvPlgpEbfCiq9QGfEb4=; b=CMoQP9Tr4Cv5bbBudcpTMkCxOf
	rFaUwRviVKlOqLxc2eC9qrm1CUXib2wGqI9VM7AXKv5D5fZTeFzCxFUqOxvK3oyj5Xj4+wJkQaLBx
	QetVLxFOxDufi3t/Yzd27lFfzWY4gHbKl59IyNXm+YlScIWbVLWkKR6F9u46QGix3lcGGzLbCtTk/
	a6q77nOXr4bg18ZdAOTUsrt1lE+Z6hVcMDUdogD8495dfhwQTW8JJCKRisT+5BeHUSlvqIxJOqEMj
	OvBMbHfIJGXKIIppvxPfcwS/BnSflfRB/65O8v98KACPVHZMDQfRoiuqAMAJTYARabAlG+MW5wM7n
	WAm13vAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCFgv-00000003du2-3Hpe;
	Wed, 29 May 2024 09:33:53 +0000
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCFgs-00000003drB-27q8
	for linux-um@lists.infradead.org;
	Wed, 29 May 2024 09:33:52 +0000
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-62a3dec382eso7726677b3.1
        for <linux-um@lists.infradead.org>; Wed, 29 May 2024 02:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716975222; x=1717580022; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A7jFrnYLPr4qszl6iKNvj0kihvPlgpEbfCiq9QGfEb4=;
        b=gx1D2uzl92Wi2pvbnsGMCMLPOfIRXkszhfnB2O/n9OFCKrfzNUj7Z7/bxU+4wMSMiz
         76Xw4g98kQi33WkMRd7FW2hi1uuCchvP8CLm/Q6k8XQZLjkoooPh/EYOVrMWZmN8wS2c
         7607n+dYYitUZpk2ogJpyIj8I2GALn6mbsfD0+pRbFKsvSx3hBGutf+jcsQkX3nY68ql
         zb6cT14DjQxkTBJdXGlGn6i44ED4WDPF11yRZGUHSsCh2l5xvoZSHL6SgVXroCvL8pEK
         pGDQPiYQ+U/YiwD4gIpuiG1QWKh85U4CP35rvdk14Dz9YUgrdzDWbBjWDysdjyW5dnMf
         2t8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716975222; x=1717580022;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A7jFrnYLPr4qszl6iKNvj0kihvPlgpEbfCiq9QGfEb4=;
        b=qYVjQ7JjiLc6sSDmY+tVdp9XW6UsLnUzbU6AkZK4+ERlyadBW5gOfucf6YLMnAJ2Dh
         Dg9UQWk9CFEVPI5eZlN6zXjx0HZQYwPcpXKLnAzOOZI4UYirwhvjDsDJIWK6PW+++d9Z
         fYgzkKgjHINJgt8utxnhE1ZDbTwVxuI+RFF6m90RjtwyTO3xt9D4YewMSL/c0hnug7GM
         A3YQ9Z6mqrhgYkVeHXQdBkBK2rryTCPxZrU77IciTm4TWb39os0+RAWdJ/4i7auo7/q/
         dKifmANfv8+Usmtq2r5lXntSTQnzkNMdVZhYVo8PMcoLKWLrcu3H8j0YbtO0EyEkTYMF
         4o3w==
X-Forwarded-Encrypted: i=1; AJvYcCXYso6AyYdqa7j9Xxf/YvUHspVlB/K2i8XhgUr0XDzEA0nKmzXnbYjQ0DvFrzs3bljIu0GPIX4Y3u6Ak3A+BtDhigILZ66caEzofH0v
X-Gm-Message-State: AOJu0YyjKNjjyz4B0zVS9upqMb0zyWOrQ/zs+zYO0aRRA6HJ24SRSCdW
	/gGuA26CJ6hMsKk958XbKUTs1EEgr/GJq3DBQNx3Qh0xh9fPe/7glMgkQsuwghgXm+vxuVn/FU+
	fV4RLaXcsTg==
X-Google-Smtp-Source: AGHT+IHxdg2ya01s660665HE7gx0TzIhtq+AMegN495R/PRhtdyxXJThsqXUppWR5I/ihiLisAVQ7G09XOsdQg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a81:924c:0:b0:627:edcb:cbe2 with SMTP id
 00721157ae682-62c5d5d451bmr2897097b3.5.1716975222191; Wed, 29 May 2024
 02:33:42 -0700 (PDT)
Date: Wed, 29 May 2024 17:33:35 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240529093336.4075206-1-davidgow@google.com>
Subject: [PATCH] arch: um: rust: Use the generated target.json again
From: David Gow <davidgow@google.com>
To: Rae Moar <rmoar@google.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Miguel Ojeda <ojeda@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Jamie Cunliffe <Jamie.Cunliffe@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>
Cc: David Gow <davidgow@google.com>, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, 
	rust-for-linux@vger.kernel.org, x86@kernel.org, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_023350_578969_1871F095 
X-CRM114-Status: GOOD (  12.03  )
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

The Rust compiler can take a target config from 'target.json', which is
generated by scripts/generate_rust_target.rs. It used to be that all
Linux architectures used this to generate a target.json, but now
architectures must opt-in to this, or they will default to the Rust
compiler's built-in target definition.

This is mostly okay for (64-bit) x86 and UML, except that it can
generate SSE instructions, which we can't use in the kernel. So
re-instate the custom target.json, which disables SSE (and generally
enables the 'soft-float' feature). This fixes the following compile
error:

error: <unknown>:0:0: in function _RNvMNtCs5QSdWC790r4_4core3f32f7next_up float (float): SSE register return with SSE disabled

Fixes: f82811e22b48 ("rust: Refactor the build target to allow the use of builtin targets")
Signed-off-by: David Gow <davidgow@google.com>
---
 arch/x86/Makefile.um | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Makefile.um b/arch/x86/Makefile.um
index 2106a2bd152b..a46b1397ad01 100644
--- a/arch/x86/Makefile.um
+++ b/arch/x86/Makefile.um
@@ -9,6 +9,7 @@ core-y += arch/x86/crypto/
 #
 ifeq ($(CONFIG_CC_IS_CLANG),y)
 KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx
+KBUILD_RUSTFLAGS += --target=$(objtree)/scripts/target.json
 KBUILD_RUSTFLAGS += -Ctarget-feature=-sse,-sse2,-sse3,-ssse3,-sse4.1,-sse4.2,-avx,-avx2
 endif
 
-- 
2.45.1.288.g0e0cd299f1-goog



Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB8DC02198
	for <linux-um@archiver.kernel.org>; Mon, 10 Feb 2025 11:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LQhJyhQWjxv+Zy6zdPYkWUMUnHGtnz45HWDSo6oMzGY=; b=r/DQwe9QPdfsmVqaNEWeX90iYW
	JOLgJ8BpVA6mfl4pr0hlvQ5SsMKbYMcmkwqFrXfUQqem/oGrEh76i4UY925tUrc1PbFzuEn0FOr/+
	nxCmWJKRHuVppniF8qrbpVhEhf/JKffbjs60cyEL+MySzDEHWHSzHsosjItZtuUS3q09enOT4MT3q
	kT8ZO7Gviha6BB7NirNTGHz1EEzJX/TRw4fmdIC3Df/Kh09kT+TFxjXGdBrjEuQbdD4GPWTSKV37k
	vknYzTBPcx9Uodf5/UBBi3ZkXNsEGn6L/XfVy2d4nbsoLRhXHLQBvQpf5hoPH08KZs1yNN78rgCb7
	zcXJKtQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thRhe-0000000HAM1-0pjH;
	Mon, 10 Feb 2025 11:11:50 +0000
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thRQc-0000000H69I-1545
	for linux-um@lists.infradead.org;
	Mon, 10 Feb 2025 10:54:15 +0000
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-2fa6610fe70so2400886a91.1
        for <linux-um@lists.infradead.org>; Mon, 10 Feb 2025 02:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739184853; x=1739789653; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LQhJyhQWjxv+Zy6zdPYkWUMUnHGtnz45HWDSo6oMzGY=;
        b=aAurAMBuAXWsOtZKXB4ZOpzTJpMghIJvB35YHK/sohh7CKrhONXdrt1nATSprgbMXb
         r0qjN6J6c2kRtgixacrxNN4pWdQ0TGqwi1BDaabsxaWX3BFdgfm92h0A230+adkM6Q2Z
         zYdf7RAZvwuKi902yiuDpNHGC5fm12F2AwfHmSijBhl5cdR6ltHWFLfWzCJoEL1m7gNQ
         NB+2sduHNMG0S2zx0hzDG7AIaikuXkWJTMcQuFwl+qm+r9rqreej04Lzv7j2qXxrFWLm
         a+esSnheXG7/KkRQWrXCbWJzG7j74hnBVQvH1eMOJFhg8AbYeF2qkT5I4CRsIyTvtbOj
         55Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739184853; x=1739789653;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LQhJyhQWjxv+Zy6zdPYkWUMUnHGtnz45HWDSo6oMzGY=;
        b=aAGPu2GjyemyqK6EaGl/M/lWzh5TS5tLjzAY1lDzij6O1RxaBRkcR0t4t2IaiGtghF
         YlVVBcmbBtQTWN5S1ZatfFmq7yfIjcaSCLNqUHLJTKrUNJ7Mtd5njZwi6QR7NIqR2Ot3
         kPenN+xen26z0ggI5aN1AoY3r6L00E1q2aZivvGGVkBufuYxIUKQ3pFbhP2K+6h/7JLj
         rGJk3Ype/kv60jSQfwJnMH+5UBpIzT2zPAbDHqUVlf2Zaw2P/fxBDvdaei1xljkl2C/p
         ILpMTLyXckaDKG/ryilAPPw7eGPw2Xs1qtj6lceJZGbS5DsNrDhmzNYQsyAAUIOrlCma
         bQfA==
X-Forwarded-Encrypted: i=1; AJvYcCVXJrinymkQmOF8TgFCS2ThK7HmNkC/FtaKN09M59EmmVyPBFmGOqPh9X5gmGD2Wr51fPcsF1cSIw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz7ZUxNSMrtJjHVu6mhIcTeCP6MkM1BFXfB0Siyxa9UnO9MtFjf
	ZHV0cITusiTsXepmhAmM3SM4nmqLOq4SVN+Xe73GDZ/zjPsyQioGxyZpwbo+QAtrfbTy2KBrt6v
	+pIV0EVMudQ==
X-Google-Smtp-Source: AGHT+IEvW+/sOqnBG/VAtH/2gdqFYMC0pJvpIBft12t8qfeTZRUBDUmiUgXHCCq/urY4SSKI4OrQQQksWUjU5Q==
X-Received: from pjboi14.prod.google.com ([2002:a17:90b:3a0e:b0:2ef:d283:5089])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4b0b:b0:2f4:49d8:e718 with SMTP id 98e67ed59e1d1-2fa23f6d51cmr20575597a91.9.1739184852968;
 Mon, 10 Feb 2025 02:54:12 -0800 (PST)
Date: Mon, 10 Feb 2025 18:53:51 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250210105353.2238769-2-davidgow@google.com>
Subject: [PATCH] arch: um: Pass the correct Rust target and options with gcc
From: David Gow <davidgow@google.com>
To: "=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?=" <linux@weissschuh.net>, Miguel Ojeda <ojeda@kernel.org>, 
	Richard Weinberger <richard@nod.at>, Johannes Berg <johannes@sipsolutions.net>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>, 
	Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Cc: David Gow <davidgow@google.com>, x86@kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, llvm@lists.linux.dev, 
	linux-um@lists.infradead.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250210_025414_314154_66FE0FEC 
X-CRM114-Status: GOOD (  16.97  )
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

In order to work around some issues with disabling SSE on older versions
of gcc (compilation would fail upon seeing a function declaration
containing a float, even if it was never called or defined), the
corresponding CFLAGS and RUSTFLAGS were only set when using clang.

However, this led to two problems:
- Newer gcc versions also wouldn't get the correct flags, despite not
  having the bug.
- The RUSTFLAGS for setting the rust target definition were not set,
  despite being unrelated. This works by chance for x86_64, as the
  built-in default target is close enough, but not for 32-bit x86.

Move the target definition outside the conditional block, and update the
condition to take into account the gcc version.

Fixes: a3046a618a28 ("um: Only disable SSE on clang to work around old GCC bugs")
Signed-off-by: David Gow <davidgow@google.com>
---

When combined with Thomas' patch [1], this gets Rust/UML building
correctly with gcc. (Indeed, Thomas' patch works fine by itself for the
64-bit case, and the 32-bit build is broken anyway due to the Rust block
driver not supporting 64-bit atomics on 32-bit systems.)

Given the other patches will probably go in via the rust-for-linux tree,
I'd be happy for this to do so as well (given it mostly affects Rust),
but it's not a disaster if they go in independently: there shouldn't be
any merge conflicts, and they work independently.

Note also that I don't actually have an old enough gcc nearby, so
haven't actually tested this on gcc < 11. So please let me know if this
breaks for you.

Cheers,
-- David

[1]: https://lore.kernel.org/rust-for-linux/20250208-rust-kunit-v1-1-94a026be6d72@weissschuh.net/

---
 arch/x86/Makefile.um | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Makefile.um b/arch/x86/Makefile.um
index a46b1397ad01..c86cbd9cbba3 100644
--- a/arch/x86/Makefile.um
+++ b/arch/x86/Makefile.um
@@ -7,12 +7,13 @@ core-y += arch/x86/crypto/
 # GCC versions < 11. See:
 # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99652
 #
-ifeq ($(CONFIG_CC_IS_CLANG),y)
-KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx
-KBUILD_RUSTFLAGS += --target=$(objtree)/scripts/target.json
+ifeq ($(call gcc-min-version, 110000)$(CONFIG_CC_IS_CLANG),y)
+KBUILD_CFLAGS +=  -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx
 KBUILD_RUSTFLAGS += -Ctarget-feature=-sse,-sse2,-sse3,-ssse3,-sse4.1,-sse4.2,-avx,-avx2
 endif
 
+KBUILD_RUSTFLAGS += --target=$(objtree)/scripts/target.json
+
 ifeq ($(CONFIG_X86_32),y)
 START := 0x8048000
 
-- 
2.48.1.502.g6dc24dfdaf-goog



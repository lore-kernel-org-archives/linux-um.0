Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B923C4332F
	for <linux-um@archiver.kernel.org>; Sat, 17 Dec 2022 04:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	References:Mime-Version:In-Reply-To:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Io0AkrKPhwZHe/WrHTSCxJznH3jtmkHtlflqG+LdZss=; b=I7FMQ00WUjj7OvqIKVrxGKuI3y
	z8n+iKnL0DWpQK7sRLyG4088uWK4NdTDq/OYtzjqIkJfud/KvDwFljHBw4V3VnmhdNZvOhXtBDUhF
	QYsOxwvlN3B5PS7VLx3OHbBJIDO8tzwVOt+kT2/O3rjjkPdHPY8MsN4pHLToy7ygcxph/C3d5oVev
	yDZSBARTGQN2IhO7lDJh9YXOB+tweD1X90zljy39D5J7qIY0MMGc0Vp68W4N/tAx4SHXpZwAiSEIW
	87qBNE4xKDetLaoOUZN4zOVyIic0hC7wDX33Qz13R6XiYVMG6BC0V6caEcHLJJ9glUX8ooNr/M3oT
	zoyWjKog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6P4D-005Smi-I9; Sat, 17 Dec 2022 04:44:57 +0000
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6P4A-005Sj0-SJ
	for linux-um@lists.infradead.org; Sat, 17 Dec 2022 04:44:56 +0000
Received: by mail-pf1-x449.google.com with SMTP id v16-20020a62a510000000b005745a58c197so2492958pfm.23
        for <linux-um@lists.infradead.org>; Fri, 16 Dec 2022 20:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jwt0kX7GS9Jckw+q61cDxTvmoFnclM/QaQDYT1WYliI=;
        b=RQ2MUmTtopYEBs/CsWjtSAyRTvbAwWSpFqzIOEJodjsQaoaickkjjJcJM86W1PRm4+
         L00WYFsnPLw6RPqkS5rZvaE70xfTxfyUMv79omPJp5QGU1h3uXSb9yo+1im3ScqkawMg
         0B/OSMYKVttHgeP6PUEHZ/S/2Jj599bUE4n3VDzeHY6bvfvlw0RfzPSQoVlRq1hzGggA
         17Q3yPTaMCL+y8dA9cjPe9lauNt+Cbb2UIEfwfJxjJ1rkiA/H6bAYxnVN2t3EqHd9pgc
         /PwIwuBDmPZlDtujda8rUptA0z951PK+Z8zZA/JQkFcBA3vT92ThAInyxKet9KPswEsB
         RkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jwt0kX7GS9Jckw+q61cDxTvmoFnclM/QaQDYT1WYliI=;
        b=PEEZFAunjkWdsBo6WpkxQvqu7PvZwg3D3rUG5KFVNI4hvKpPySHgdZCqgMkquV4ejm
         +u8bYug6m2nD2WPVaUm3w15gTag5ZYMIxPFH1Ek0eM0YbTaNtXlIyBVUztEv+QkGaNUj
         ACNPF15/wvfLaDPxpeAwOAeX3rMBIairie2YH+rF8WdqZ8evQZHAYBUC3c/qm/0sDWro
         sCdqkeqgve8dlWzrHcfnag1ozun8LWLKNFQ/lGyXRmZIabKt98WSL7A1EfB+VzDbt9V6
         AUxREokwUHVDxwD9vnBu+TxnirnqBtgLnqhAOAj+kCOFb5dAuA0LRha3xMG5Q9DlptAR
         hj6g==
X-Gm-Message-State: ANoB5pkrY6pqhE7U+8qndZdkSo/4gN4C8jtYG2NpqocfiM5LoPRWBOlO
	6oEdepsoJhZg/iuzsL9qi6iYyncNYGc/fg==
X-Google-Smtp-Source: AA0mqf6pD4dEjuFSn7wKhwS/R03VrxJSzS2ylnHvSFKZV2uccGUmlvQ5iNHEZZiveaurf+cNA4fNNoa/mp3DaQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:aa7:85cb:0:b0:575:871f:2e7a with SMTP id
 z11-20020aa785cb000000b00575871f2e7amr4562595pfn.35.1671252293098; Fri, 16
 Dec 2022 20:44:53 -0800 (PST)
Date: Sat, 17 Dec 2022 12:44:35 +0800
In-Reply-To: <20221217044436.4138642-1-davidgow@google.com>
Mime-Version: 1.0
References: <20221217044436.4138642-1-davidgow@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221217044436.4138642-3-davidgow@google.com>
Subject: [PATCH 2/3] rust: arch/um: Disable FP/SIMD instruction to match x86
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
X-CRM114-CacheID: sfid-20221216_204454_929682_090B98C4 
X-CRM114-Status: UNSURE (   8.77  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

The kernel disables all SSE and similar FP/SIMD instructions on
x86-based architectures (partly because we shouldn't be using floats in
the kernel, and partly to avoid the need for stack alignment, see:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=53383 )

UML does not do the same thing, which isn't in itself a problem, but
does add to the list of differences between UML and "normal" x86 builds.

In addition, there was a crash bug with LLVM < 15 / rustc < 1.65 when
building with SSE, so disabling it fixes rust builds with earlier
compiler versions, see:
https://github.com/Rust-for-Linux/linux/pull/881

Signed-off-by: David Gow <davidgow@google.com>
---
 arch/x86/Makefile.um | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/Makefile.um b/arch/x86/Makefile.um
index b3c1ae084180..d2e95d1d4db7 100644
--- a/arch/x86/Makefile.um
+++ b/arch/x86/Makefile.um
@@ -1,6 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0
 core-y += arch/x86/crypto/
 
+#
+# Disable SSE and other FP/SIMD instructions to match normal x86
+#
+KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx
+KBUILD_RUSTFLAGS += -Ctarget-feature=-sse,-sse2,-sse3,-ssse3,-sse4.1,-sse4.2,-avx,-avx2
+
 ifeq ($(CONFIG_X86_32),y)
 START := 0x8048000
 
-- 
2.39.0.314.g84b9a713c41-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE1DC3DA6E
	for <linux-um@archiver.kernel.org>; Sat, 17 Dec 2022 04:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	Mime-Version:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=WJZP6cJvPf85lguVjIOdypq+QQV2hjw0Uv4fcWz2e+c=; b=EFG
	PJFFDdwoAuV0c0UIWxSVuq5J4mTnL+kvzcmIFM3hcCiwAdasH6wy2wg5CHv0UA5eapagMxkYqlfqN
	sBL7+KPNCjeb9HfMfpQlqcXowcbSVbzG/2ddVfVlhmYAZkjOp8kw1oh8CtSUo91sbTwRzUfAAtZqv
	6b2YY5ZHkWOm47li9IzMvMdupcUN6wvuPGdFpso7jOvesM/rtKHAP//UJN1dqrxO1wCopwGFXEl/R
	75x6Tf1j+PGvt6VaRTtl0AKqsWleOeAuM9KIiVAax96fLEF6uTpd7JKGMppLOcOO/lTHuGvcWpVdj
	a73QaPRciidWgpoFAAt1j9PxUr1nAEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6P45-005SgR-0X; Sat, 17 Dec 2022 04:44:49 +0000
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6P41-005SaF-Ln
	for linux-um@lists.infradead.org; Sat, 17 Dec 2022 04:44:47 +0000
Received: by mail-pj1-x1049.google.com with SMTP id x17-20020a17090a8a9100b002196a3b190cso5193221pjn.6
        for <linux-um@lists.infradead.org>; Fri, 16 Dec 2022 20:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lq5qLaqjn47UolL4tsokkeSChCFRg4lpAueP7xiyK5c=;
        b=hI3GPjV+otMa4Ye095FQjaGiWFlvwbSCtpy0DBUgqx9lFQzUf2P0+VMQ+0p2TVTqA5
         RWgmwjx++Vat5TAo6ZfBcEzl2ZRlK0ZvijwVXFFrEBj2H0CDfCxn7T4YMffcWbCjNa1k
         OJ1EPcqIFGczYb7jLwFDNuh3dCqMPAyPDyafE9GbwooLR5G9wHsJJe+T94Zh3w3gAyx+
         mdEDkdd8xr1Tfwaqf9PpBiVqe0nyLrdo8K7KCclSR7jY4bh0MjIjPp0ejIeHUmkRkjI1
         wnNzvdOhssab9K/qDUX2tlWPiLFv8SGiFbH+aFMdn+xsjdYLaNd8mNcT9S/wPq2j5kby
         0GjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lq5qLaqjn47UolL4tsokkeSChCFRg4lpAueP7xiyK5c=;
        b=fJsJKKmTiao3MgRzuTZHv3t6bXVPDA7LgWxxe7rQC5jGsUOuh/MAY06Hp3+mW/M64E
         BboqL+kw1mk5NXTKfX7c8mTnxQRZGbC/2AdtUpBSKfaIMYMFMNHGKYHiPLozuJUfm7rD
         GArQCAwKyL1tz4a2ZVe+DvY7j8BcK9f5YGuflhwTyAy4qfqOWQL311Lw5a0iGUdcOK34
         bN9ehLymFAMAPTKCj5d0KXWmsKlIGDiWQWb9yznyO7BWxW0jO20ztyGImG6AOXd2LTLg
         u1IsH5tiZeOD8keX2YTXsWP9h/n9ewTOCnLVburRrM05vUJk3sJstHHqhy5by2N0VMTE
         dBow==
X-Gm-Message-State: AFqh2kqCtXnIpzrfjLKGL3V5IeqEsBSLRvdvtGpJDoQOKSRJZGoJISRo
	4upF072R1WsxAmyzJcwlS5i3dWhdiMHRBg==
X-Google-Smtp-Source: AMrXdXvH1QaOoHmXxQnjA4mtzl2imb7fSbG7jRPeov73t2X0+amIt1J7VPlYImsSKZuDLTlFJocq/RGIXZxZFA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:90a:d318:b0:220:1f03:129b with SMTP
 id p24-20020a17090ad31800b002201f03129bmr138587pju.0.1671252283386; Fri, 16
 Dec 2022 20:44:43 -0800 (PST)
Date: Sat, 17 Dec 2022 12:44:33 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221217044436.4138642-1-davidgow@google.com>
Subject: [PATCH 0/3] rust: arch/um: Rust support for UML
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
X-CRM114-CacheID: sfid-20221216_204445_778136_E6ECB37F 
X-CRM114-Status: GOOD (  14.41  )
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

This series adds support for building and running code in the Rust
programming language under x86_64 UML kernels.

It is based on two Pull Requests from the Rust-for-Linux GitHub page:
- https://github.com/Rust-for-Linux/linux/pull/766
- https://github.com/Rust-for-Linux/linux/pull/881

The series consists of three patches: the first two set up various
compiler options to match both the UML and the X86 CFLAGS.

Rust support can be enabled by setting CONFIG_RUST=y, when the suitable
Rust compiler and bindgen versions are available (run make rustavaiable
to check). LLVM=1 is also required at present with all Rust builds.

The whole thing can be built and tested with kunit.py:
./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_RUST=y --make_options LLVM=1

(Note that there are no Rust-based KUnit tests upstream yet. The "rust"
branch of the Rust-for-Linux GitHub repository does use KUnit for its
"doctests", and all of those tests pass under UML with these patches.)

This series is currently based on the uml/next branch: I'm happy to
rebase it next year once we're past the 6.2 merge window (though it
applies cleanly to torvalds/master at the moment). Equally, it
should be possible to take these changes in via the rust tree instead,
but since it's mostly UML Makefile changes, it probably makes more sense
for it to go in via the uml tree.

Also note that this series marks UML as a "maintained" architecture for
Rust support. It's definitely my intention to keep this working, but if
anyone has serious concerns, we can downgrade that.

Cheers,
-- David

David Gow (3):
  rust: arch/um: Use 'pie' relocation mode under UML
  rust: arch/um: Disable FP/SIMD instruction to match x86
  rust: arch/um: Add support for CONFIG_RUST under x86_64 UML

 Documentation/rust/arch-support.rst | 2 ++
 arch/um/Kconfig                     | 1 +
 arch/um/Makefile                    | 2 ++
 arch/x86/Makefile.um                | 6 ++++++
 4 files changed, 11 insertions(+)

-- 
2.39.0.314.g84b9a713c41-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

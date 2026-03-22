Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E904DFC72D8
	for <linux-um@archiver.kernel.org>; Sun, 22 Mar 2026 19:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SiYymjyqLJQefau8a4gy6w/Vver9WdiGFOPB8YRefA8=; b=CkyooyFBz3mXm+xXS4D8OLS0Vo
	k4yLAAWAFEtCkwnHLSodg32piMCJELxO94lVWlZ9vA5yi0xUSmhxdAf/gKFtZtkMeW5H/xt+eKtCA
	puOrALvsWnx62HJ4JBlQqRRxPjUH8YFRxr12NdUrcs/fGG1EgX59xpd9NVsxMEcNEsooFsVYBrAyF
	tPFYfBDUHHWHcymoWyH9jD6zQM9N7cabXkuN+1OFjJaDZNprK5SfAws1QLUgbmjclfUoA50uQMxkL
	jGliNxxhhgrURP6Y0I/pICeioGigSE2zkPpVTviXkBKowfcOHMlXbE3MNjaRAj1GZJ/vJFG3inKCB
	PZxJiyaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4ONS-0000000FbCx-18oD;
	Sun, 22 Mar 2026 19:22:22 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4ONP-0000000FbC4-3VTP;
	Sun, 22 Mar 2026 19:22:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1AD89416B0;
	Sun, 22 Mar 2026 19:22:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192DCC19424;
	Sun, 22 Mar 2026 19:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774207336;
	bh=KE0Ehn2v53KTMI2yWR0Gn7GG8ek8iWJ5qKwd+6T9w6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jFJL0HTlpz2kyveKolahrRLNphDakm+Q0lH8RMUli8M7xc1fwB7R2zBva4trgzUpd
	 lk8r9iTZ7RK9+n11jpBQXj1Y4rhWoaJvX51FBQNmMEQ4I19oTrOeT5zbF/kKWhqeho
	 6b4Aq0d6LPYr0Yw97mZL2MZRfOYyM+WWsosZrbssdYmQvnxj51nQJGuT66y6OcCvRw
	 hNpkBjyo9j85cWcwnilz/5/JIyry8guW3hTlC48UGLFpxvnc67sza+0l5xyMRo4/u6
	 2FI0aKfs+8mqtv6TmnabtUH0CdEYOwNh97gqsacWIR5/7UbfPNWxkFDoq3gmq13g2s
	 WMG4aJ4fhX7tQ==
From: Miguel Ojeda <ojeda@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	David Gow <david@davidgow.net>,
	Russell King <linux@armlinux.org.uk>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	aliceryhl@google.com
Cc: linux-um@lists.infradead.org,
	llvm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kbuild@vger.kernel.org,
	a.hindborg@kernel.org,
	acourbot@nvidia.com,
	akpm@linux-foundation.org,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	dakr@kernel.org,
	gary@garyguo.net,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lossin@kernel.org,
	mark.rutland@arm.com,
	mmaurer@google.com,
	nicolas.schier@linux.dev,
	ojeda@kernel.org,
	peterz@infradead.org,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu,
	urezki@gmail.com,
	will@kernel.org
Subject: Re: [PATCH v2 0/3] Inline helpers into Rust without full LTO
Date: Sun, 22 Mar 2026 20:21:59 +0100
Message-ID: <20260322192159.88138-1-ojeda@kernel.org>
In-Reply-To: <20260203-inline-helpers-v2-0-beb8547a03c9@google.com>
References: <20260203-inline-helpers-v2-0-beb8547a03c9@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260322_122219_919584_1EBDD355 
X-CRM114-Status: GOOD (  16.81  )
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

On Tue, 03 Feb 2026 11:34:07 +0000 Alice Ryhl <aliceryhl@google.com> wrote:
>
> To get rid of these helper symbols, provide functionality to inline
> helpers into Rust using llvm-link. This option complements full LTO, by
> being much cheaper and avoiding incompatibility with BTF.

I have been testing this. I think we can go ahead with it, with a few
notes.

I will reply to a couple other bindings in separate emails to avoid
spamming people too much.

  - I will mark the Kconfig option as "(EXPERIMENTAL)", since that is
    what the commit message says and it allows us to be a bit
    conservative.


  - Clang passes `-Werror=unused-command-line-argument`, which means
    under arm (i.e. 32-bit) we get:

      clang: error: argument unused during compilation: '-U arm' [-Werror,-Wunused-command-line-argument]

    And under UML I see:

      clang: error: argument unused during compilation: '-I ./arch/um/include/shared' [-Werror,-Wunused-command-line-argument]
      clang: error: argument unused during compilation: '-I ./arch/x86/um/shared' [-Werror,-Wunused-command-line-argument]
      clang: error: argument unused during compilation: '-I ./arch/um/include/shared/skas' [-Werror,-Wunused-command-line-argument]

    So we would need e.g. `-Wno-unused-command-line-argument` there
    close to the `-Wno-override-module` one, unless Kbuild or
    ClangBuiltLinux thinks it is important to keep it for this case.

    On the other hand, regardless of whether we fix this (and another
    issue in a separate email found thanks to the UML build), we could
    instead add `depends on` listing explicitly the architectures where
    this is going to be actually tested. That way maintainers can decide
    whether they want to support it when they are ready. Thoughts?

    Cc'ing Nathan, Nicolas, Nick, Bill, Justin, David, UML, ARM.


  - If we use the `.bc` extension, we need to add a `.gitignore` for
    `.bc` files, and an exception for `kernel/time/timeconst.bc`.

    I guess we will not have too many `bc` scripts in the future for
    that to be a problem. On the other hand, we have the chance to use
    another extension (either for LLVM bitcode or for `bc` scripts).

    But please let me know on e.g. the Kbuild side if someone has
    concerns...


  - Do we want to have the `cmd_ld_single` step even if the new mode is
    not enabled? i.e. we are gating the other steps, so we could gate
    that one too easily, no?

        -       $(cmd_ld_single) \
        +       $(if $(link_helper),$(cmd_ld_single)) \

        -       $(cmd_ld_single) \
        +       $(if $(CONFIG_RUST_INLINE_HELPERS),$(cmd_ld_single)) \

    I mean, it only affects `CONFIG_LTO_CLANG` configs, which are on
    their own experimental as far as I can see, so it is probably fine
    as it is, but still, while making things unconditional on the caller
    is good, it is also a behaviour change for configs outside the thing
    introduced here, so I am asking.

    (We could use something like a `is-rust-object` to do it on the
    definition side, but I would leave that for later.)

Thanks!

Cheers,
Miguel


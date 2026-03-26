Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F7C8109E53D
	for <linux-um@archiver.kernel.org>; Thu, 26 Mar 2026 02:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWjcQxkIkXKJWQMQD//4uoNpukCWFp7/8TrvqUt2M6o=; b=T6TC30UP6OM4edej2+uqi2YiYk
	zKI2w2/8Kd56sKx7Vg0zxlUKz8x0ePnoWHou9DA90AiIkEMsSTWlOmJodORmwPCHqh0ORi3t/dxH9
	AflTkc04OCwlbaTbjL/n1mTy47/iWmdDJbaSpqCrMtqMe1zsaWxArRLWN6Qan3JuqE9QbOsDUE3ND
	TeAb3Q2yjXsgapcNnS9Qqz8weSw1D8g+6NiOa40U1tzN3cTkCmPv+lGZaMYQ/2mwrV8wPvccycZGH
	EnuZJEgYqLvPkxlvjBENele6oErit82bsyGoZH/wGmOnIExIvErv/DqE52Bp/HiQsOslFKUzInRfP
	/z3Bl+Ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5agA-00000004ar7-2CCH;
	Thu, 26 Mar 2026 02:42:38 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5ag8-00000004aqT-0WWK;
	Thu, 26 Mar 2026 02:42:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3113960053;
	Thu, 26 Mar 2026 02:42:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB208C4CEF7;
	Thu, 26 Mar 2026 02:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774492954;
	bh=zQaAoby1LL5qtX0PbqpV15cjdPtMgN1fWIPjYj6cHHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S8zGn/i+Spyx9XA47CpCu/vQAg2jkahFRQzQumLqtrDpCNSJTCj03aAkEznFHIBqF
	 BHqQtK9yH0jlsDRFhpqINdr/8qKOFZZ33DoLjiHS1rBQN8A7rN6+cd4XspEv86q4aw
	 fX5sdIVSmixq08mIaV+WQ20CFRO/xOqtaVcHBACJLjdgVgNEAW/1eD2ppZ4E8Sqo34
	 KMBXF5A5vLLXjt9vVzfBdhnIBFejLTjFksFyWA19+Dk1JNuNC3tUVbCRh3Eo+Ed2YP
	 iTNr+GVTtwyhLeEY70H14v74c5VO6yI6pMXy8ExXxlKbsKAbxCmXLa/pnbG4dlN+CH
	 y4s8jAUhtp60A==
Date: Wed, 25 Mar 2026 19:42:26 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	David Gow <david@davidgow.net>,
	Russell King <linux@armlinux.org.uk>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>, aliceryhl@google.com,
	linux-um@lists.infradead.org, llvm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
	a.hindborg@kernel.org, acourbot@nvidia.com,
	akpm@linux-foundation.org, bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com, dakr@kernel.org, gary@garyguo.net,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lossin@kernel.org,
	mark.rutland@arm.com, mmaurer@google.com, nicolas.schier@linux.dev,
	peterz@infradead.org, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu, urezki@gmail.com, will@kernel.org
Subject: Re: [PATCH v2 0/3] Inline helpers into Rust without full LTO
Message-ID: <20260326024226.GB2302780@ax162>
References: <20260203-inline-helpers-v2-0-beb8547a03c9@google.com>
 <20260322192159.88138-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260322192159.88138-1-ojeda@kernel.org>
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

On Sun, Mar 22, 2026 at 08:21:59PM +0100, Miguel Ojeda wrote:
>   - Clang passes `-Werror=unused-command-line-argument`, which means
>     under arm (i.e. 32-bit) we get:
> 
>       clang: error: argument unused during compilation: '-U arm' [-Werror,-Wunused-command-line-argument]
> 
>     And under UML I see:
> 
>       clang: error: argument unused during compilation: '-I ./arch/um/include/shared' [-Werror,-Wunused-command-line-argument]
>       clang: error: argument unused during compilation: '-I ./arch/x86/um/shared' [-Werror,-Wunused-command-line-argument]
>       clang: error: argument unused during compilation: '-I ./arch/um/include/shared/skas' [-Werror,-Wunused-command-line-argument]
> 
>     So we would need e.g. `-Wno-unused-command-line-argument` there
>     close to the `-Wno-override-module` one, unless Kbuild or
>     ClangBuiltLinux thinks it is important to keep it for this case.

No, I don't think it is worth trying to make -Wunused-command-line-argument
work for this command. Just disable it. This mirrors what is being done
for cmd_cc_o_bc in the distributed ThinLTO:

  https://lore.kernel.org/20260316212930.120438-3-xur@google.com/

>     On the other hand, regardless of whether we fix this (and another
>     issue in a separate email found thanks to the UML build), we could
>     instead add `depends on` listing explicitly the architectures where
>     this is going to be actually tested. That way maintainers can decide
>     whether they want to support it when they are ready. Thoughts?
> 
>     Cc'ing Nathan, Nicolas, Nick, Bill, Justin, David, UML, ARM.

I do agree with some of the concerns that adding an architecure
dimension to this is a little complicated. I would rather try to flush
out those build problems with patches and keep it enabled for all
architectures. At the same time though, I understand that enabling it
for the "tier 1" architectures is a low barrier of entry for getting the
feature upstream, validated, and distributed to the majority of people
that would actually use and depend on it, so I ultimately leave that
call up to you.

>   - If we use the `.bc` extension, we need to add a `.gitignore` for
>     `.bc` files, and an exception for `kernel/time/timeconst.bc`.
> 
>     I guess we will not have too many `bc` scripts in the future for
>     that to be a problem. On the other hand, we have the chance to use
>     another extension (either for LLVM bitcode or for `bc` scripts).
> 
>     But please let me know on e.g. the Kbuild side if someone has
>     concerns...

No real concern on that front but .gitignore has a command to run when
modifying it, which will require a !timeconst.bc in a
kernel/time/.gitignore file.

Cheers,
Nathan


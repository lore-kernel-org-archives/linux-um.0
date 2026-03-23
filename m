Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DA0F46102
	for <linux-um@archiver.kernel.org>; Mon, 23 Mar 2026 12:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1d81UGW+g5moJ12QZLJ70AfXTnILA70sV1AIVfxWkPk=; b=wXNOBrDdkKUlvrY42lTjqyC/rr
	SG5uH8FMd6cFe67DoipGO8xaNhpJmawV2XcA136ywA8fPhU2xOYKhEtu884TxM99p4PCn3doppduV
	yif5prMy2jZTxhMzNwa9uoJr6hUnyLvVOa8IWZ+jWDauk5ijnLTSViuN75Sbkz90sp6Mz8QjpQZ3J
	RQzEjbtWwuY0CfA4lkMut1dGVM/r+9Em/9d1Lv8O7jyYb++vkZK0aFu1Ez9MSARAgkO+dOCT4A2BR
	Iu5kvWX3wPAUtDaZa1IF5bXasv31q1Qk/yCw2+zDklw89tnmPFhz1hwqdGAjpw8ktOjWX9Kx67kKg
	qVgHqK3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4eoN-0000000GjHS-3BGM;
	Mon, 23 Mar 2026 12:55:15 +0000
Received: from vps0.lunn.ch ([156.67.10.101])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4eoK-0000000GjG0-3hWn;
	Mon, 23 Mar 2026 12:55:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=1d81UGW+g5moJ12QZLJ70AfXTnILA70sV1AIVfxWkPk=; b=jA
	1fKF6JCm07M3XMCGUuLHhhI9Pu6ECn1GJ3yeUqHNhRkzLmXiEKTE/QlBMy2b+v7qeDJ/Lwc6gzpEd
	uTbq1XPNawby4AoIaQRDN6D1/Dwq4q51KKQd6nnrU4sc4PnuPzJ60QWKwdET9ZkSy1PsI6j8uUhzN
	bgmLoRVpwaHE16E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w4eo2-00CvjR-O0; Mon, 23 Mar 2026 13:54:54 +0100
Date: Mon, 23 Mar 2026 13:54:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, a.hindborg@kernel.org,
	acourbot@nvidia.com, akpm@linux-foundation.org,
	aliceryhl@google.com, anton.ivanov@cambridgegreys.com,
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dakr@kernel.org,
	david@davidgow.net, gary@garyguo.net, johannes@sipsolutions.net,
	justinstitt@google.com, linux-arm-kernel@lists.infradead.org,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-um@lists.infradead.org,
	linux@armlinux.org.uk, llvm@lists.linux.dev, lossin@kernel.org,
	mark.rutland@arm.com, mmaurer@google.com, morbo@google.com,
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
	nicolas.schier@linux.dev, nsc@kernel.org, peterz@infradead.org,
	richard@nod.at, rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	urezki@gmail.com, will@kernel.org
Subject: Re: Re: [PATCH v2 0/3] Inline helpers into Rust without full LTO
Message-ID: <65336ad0-ac37-416f-b6ae-e691e3e375ae@lunn.ch>
References: <20260322192159.88138-1-ojeda@kernel.org>
 <20260323000327.111235-1-ojeda@kernel.org>
 <96287f3a-d245-47cf-b7cb-f821451493d3@lunn.ch>
 <CANiq72nwSWVDRqm0Vap5j5X5k+Q-wq8okQ9d3KUgZt6M4CpW9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72nwSWVDRqm0Vap5j5X5k+Q-wq8okQ9d3KUgZt6M4CpW9g@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260323_055512_938476_523B4C46 
X-CRM114-Status: GOOD (  16.74  )
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

On Mon, Mar 23, 2026 at 04:24:59AM +0100, Miguel Ojeda wrote:
> On Mon, Mar 23, 2026 at 4:04 AM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > Rust is already fragmented, because it does not support all
> > architectures. Do we really want to make it even more fragmented by
> > having some bindings only work on a subset of the subset of
> > architectures?
> 
> That is not the case. The `depends on` is not about putting them on
> abstractions, but on this experimental build feature, which is gated
> on `EXPERT` to begin with, because it uses a fairly exotic approach
> involving LLVM bitcode, which carries potential pitfalls, like the
> mismatches on the target string like one of the commit messages
> mentions, and possibly others.

I'm not sure i follow this.

Maybe i should ask a different question.

You said:

> we
> may want to start simple with x86_64 and arm64 or similar first.

The current proposed code for netlink needs this feature, because it
needs access to inline C functions. Is the implication, following a
chain of dependencies, that netlink would only build on x86_64 and
arm64?

If you want netlink on um, arm32, riscv, loongarch you would need a
different implementation of the binding?

And a completely different question. Are there other work in progress
solutions to allow the use of inline C functions? For networking, in
particularly MAC and protocol code, anything which needs to access a
struct sk_buf, a solution to this problem will be required. Do you see
this "fairly exotic approach" as just a sort term bridge until some
other "boring approach" is ready?

	Andrew


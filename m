Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5569DF4610D
	for <linux-um@archiver.kernel.org>; Mon, 23 Mar 2026 13:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5ffZcBi0UU6q88Ce7nJSzo/9O0PBONBoKE6v9nT0tfQ=; b=VR/9mkRNYmNubi2qgqPXnBB+4M
	v0XpW/z2zMGFIlGNYu4wdYvw8BQQw33wNqIFsHcwV9cf6DFOr38borRhmkyvL1dYlR07VJG534osS
	NHCXN9VBR111VEhBYQvEYLBI6OmC14V/gzxfv2/S5rgwmof5PgPe9fATF9Smx5hVeiEKVXyz6QpyS
	MLR9mSJQ/+A/SCBob9Ii1aw/S6oHGyJRxQ2e3U+goOtUhBml5spYEEZUkwFqZ0jBLo0rWxLPYcu1t
	G3i2czDkx2dA2JljkX9lVPRIFpRkbZ0z4bA/XS2DZe5SEDUQuWyZwF47jIum2FCq/V3j5WEE0VFSm
	7682Z4MQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4fKk-0000000GpI6-3Tgx;
	Mon, 23 Mar 2026 13:28:42 +0000
Received: from vps0.lunn.ch ([156.67.10.101])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4fKi-0000000GpHC-2B8a;
	Mon, 23 Mar 2026 13:28:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5ffZcBi0UU6q88Ce7nJSzo/9O0PBONBoKE6v9nT0tfQ=; b=k7sIINJIYCzIpzZ2gI5it43Ag6
	kvT42IIsbXwV7JvxdG5TtKzLycY7I/GlZ189VNwiAeNQ09bB8gR5Ah6+IcHW6BmNfxqetQ7Xlt9oH
	T7zzeRvxjh+oHL2kLEEPZALfZYETH8PDWPPP3/DOZmbV7KliYRBmFOeX+G2g6lZbgixY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w4fKT-00Cw79-Bh; Mon, 23 Mar 2026 14:28:25 +0100
Date: Mon, 23 Mar 2026 14:28:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>, a.hindborg@kernel.org,
	acourbot@nvidia.com, akpm@linux-foundation.org,
	aliceryhl@google.com, anton.ivanov@cambridgegreys.com,
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dakr@kernel.org,
	david@davidgow.net, johannes@sipsolutions.net,
	justinstitt@google.com, linux-arm-kernel@lists.infradead.org,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-um@lists.infradead.org,
	linux@armlinux.org.uk, llvm@lists.linux.dev, lossin@kernel.org,
	mark.rutland@arm.com, mmaurer@google.com, morbo@google.com,
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
	nicolas.schier@linux.dev, nsc@kernel.org, peterz@infradead.org,
	richard@nod.at, rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	urezki@gmail.com, will@kernel.org
Subject: Re: [PATCH v2 0/3] Inline helpers into Rust without full LTO
Message-ID: <b5063e7e-9245-434e-9877-5ac7b45f4bc7@lunn.ch>
References: <20260322192159.88138-1-ojeda@kernel.org>
 <20260323000327.111235-1-ojeda@kernel.org>
 <96287f3a-d245-47cf-b7cb-f821451493d3@lunn.ch>
 <CANiq72nwSWVDRqm0Vap5j5X5k+Q-wq8okQ9d3KUgZt6M4CpW9g@mail.gmail.com>
 <65336ad0-ac37-416f-b6ae-e691e3e375ae@lunn.ch>
 <DHA6SE9EMEQF.1PKVHEG18I5FS@garyguo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DHA6SE9EMEQF.1PKVHEG18I5FS@garyguo.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260323_062840_555611_196F1F5B 
X-CRM114-Status: UNSURE (   9.45  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

> > If you want netlink on um, arm32, riscv, loongarch you would need a
> > different implementation of the binding?
> 
> It doesn't need this feature to build and function. It'll just be a bit slower
> because inlining from C to Rust won't happen.

So it sounds like my understanding is out of date. When the first
Ethernet PHY driver was being merged, Rust could not access inline C
functions. The binding had to replicate the functionality. But you are
saying that Rust can now make use of inline C code, but not actually
inline it? It results in a function call?

What this feature does it actually allows inline C functions to be
inline? So it is just an optimisation?

	Andrew


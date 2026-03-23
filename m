Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69DDD58CC6
	for <linux-um@archiver.kernel.org>; Mon, 23 Mar 2026 03:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0o3IMkXU9M+ra6jtZIePmaIM7c78nzlX/rqtiYyUMUs=; b=eeJTgrW53llhbZruzZdtSuCaZp
	oU5b59KN+TGcGIYzXrTq310KUyGL6he8vysnAwXyzpTiMEw1wZ9XNNCmUZE4+9Zy1WS+j+Wmdup7w
	cbAbsgKwOEfAP35RFtCQ4ll8xrcz8AR90ZfgXmqyCUBmaqXvBt4Qtvxepjs9sYWpsQK1BEV8hkF4f
	p+TZ/ku31pIOv46sjZcumqRFwbgIUN5cjyRF3TMZqK9Wypdr0YdeUMm587hSWz7Teu+Bz75a0jsPu
	Po8b/Bfc7ZfeS25NgN29YlwnVZp+ONaF+yTEwj8tp7ix/HHitcGcRuVllCWVUbyOUYIa9NQP7OBSg
	x1xmhc9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4Vb3-0000000Fvmf-3qgG;
	Mon, 23 Mar 2026 03:04:53 +0000
Received: from vps0.lunn.ch ([156.67.10.101])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4Vb0-0000000FvmD-2etA;
	Mon, 23 Mar 2026 03:04:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0o3IMkXU9M+ra6jtZIePmaIM7c78nzlX/rqtiYyUMUs=; b=Cgzrqx8GftS1h7cFSUrWUQgVHX
	Oh5P3qaAHvzzIytGyVzyTqcRYfVSrxZKFIjJlQR/n2YNmzpRaq+HqDI5Yc9o0F7SqIqnOwI+6P0AC
	pkYpFBz2YLxvMYi4mly+bn6M59Uog8kGy1QttCO/yD64ayMbRm+bt7PXlzvZ2SezX0M0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w4Vah-00Cs79-Lr; Mon, 23 Mar 2026 04:04:31 +0100
Date: Mon, 23 Mar 2026 04:04:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: a.hindborg@kernel.org, acourbot@nvidia.com, akpm@linux-foundation.org,
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
Message-ID: <96287f3a-d245-47cf-b7cb-f821451493d3@lunn.ch>
References: <20260322192159.88138-1-ojeda@kernel.org>
 <20260323000327.111235-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323000327.111235-1-ojeda@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260322_200450_702037_C50822BB 
X-CRM114-Status: GOOD (  17.34  )
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

On Mon, Mar 23, 2026 at 01:03:27AM +0100, Miguel Ojeda wrote:
> On Sun, 22 Mar 2026 20:21:59 +0100 Miguel Ojeda <ojeda@kernel.org> wrote:
> >
> >     On the other hand, regardless of whether we fix this (and another
> >     issue in a separate email found thanks to the UML build), we could
> >     instead add `depends on` listing explicitly the architectures where
> >     this is going to be actually tested. That way maintainers can decide
> >     whether they want to support it when they are ready. Thoughts?
> 
> Another one for arm 32-bit:
> 
>       LD      .tmp_vmlinux1
>     ld.lld: error: undefined symbol: __aeabi_read_tp
>     >>> referenced by uaccess.rs:349 (rust/kernel/uaccess.rs:349)
>     >>>               samples/rust/rust_misc_device.o:(<rust_misc_device::RustMiscDevice as kernel::miscdevice::MiscDevice>::ioctl) in archive vmlinux.a
>     >>> referenced by uaccess.rs:543 (rust/kernel/uaccess.rs:543)
>     >>>               samples/rust/rust_misc_device.o:(<rust_misc_device::RustMiscDevice as kernel::miscdevice::MiscDevice>::ioctl) in archive vmlinux.a
>     >>> referenced by uaccess.rs:543 (rust/kernel/uaccess.rs:543)
>     >>>               drivers/android/binder/rust_binder_main.o:(rust_binder_main::rust_binder_ioctl) in archive vmlinux.a
>     >>> referenced 36 more times
> 
> I think this reinforces the case that this is something that arch folks
> should think about case by case, and decide if they want to try -- we
> may want to start simple with x86_64 and arm64 or similar first.

But is this an architecture thing?

The netlink binding required this, because many of the netlink API
calls are implemented in inline function. However, netlink is
architecture independent.

Rust is already fragmented, because it does not support all
architectures. Do we really want to make it even more fragmented by
having some bindings only work on a subset of the subset of
architectures?

	Andrew


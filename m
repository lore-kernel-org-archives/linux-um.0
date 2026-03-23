Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76BEEC01B9
	for <linux-um@archiver.kernel.org>; Mon, 23 Mar 2026 10:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cz+j7B7EZWXqL1NEdjNkb8+tqvgFwGtEmQlc0a4uF/I=; b=yjzfe3+O48C+6nR5tnI/M4Ur3V
	M2GCMPrlbSy5msPsKDxMtXeD02/QHRceop2wsdqqG4sOb9pxCxWeOIPGdC5B0XuVE9v1DECActCNR
	XJ9L98wzLeHt+z6rCA/gJuxKiCegLSCXwzCzk6bC5nMvIYjoBRVFAbsqnWBOdrstIJLaHGemdz7Bz
	GwAK9s8LNDYNFudWns//LoFtRU/qEwWUYwXKsmMvwmLf21aA5OJ/1+bg7wsTF8WzYKg1+O7FBZUo8
	2BqH9XFf4CSXKRffJS6+TaOPmdARJCQblRjqrqX3nrGHDokjdRUzwNuq6scl/xNx6pZcCallpQJgj
	9/GGwLHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4c8X-0000000GS9R-1mwc;
	Mon, 23 Mar 2026 10:03:53 +0000
Received: from pandora.armlinux.org.uk ([2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4c8V-0000000GS8T-0ItI;
	Mon, 23 Mar 2026 10:03:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Cz+j7B7EZWXqL1NEdjNkb8+tqvgFwGtEmQlc0a4uF/I=; b=0YF0XiuwT3u8tR4oPMYWEV/KFK
	H9fwrg4T/+n+RJ03PpS/Fav/FeJLLU7KVNxg/rC1jqK+w+LeTgzBtMY5uSRpKHO0wDv+X6cxP7NiC
	m75SRUqkIW5e3TcIYnU2V/9uxpyA8Sc/j0NWipcGGGzkIgVZX5Q+p4QRq+XPer8SHbcl8QxCKLAjM
	+YmYDZJz5gc2FBjWWOLytVpK4pbu5cpv+VXUz3RUGr/wvAMjrH6Zo5aYlwvQ2q7xNgwDr/8QYZiUW
	W9lgLx+4dBjuEbKoTDvDCm6znHsF6AcsyhR8Ua14v4nYL8zIAC5TUrwz1CHT9EOJzgzdxIrCwHslC
	8tWM9ivQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45792)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w4c8C-000000000IN-2POJ;
	Mon, 23 Mar 2026 10:03:32 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w4c86-000000003wH-1o0a;
	Mon, 23 Mar 2026 10:03:26 +0000
Date: Mon, 23 Mar 2026 10:03:26 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: a.hindborg@kernel.org, acourbot@nvidia.com, akpm@linux-foundation.org,
	aliceryhl@google.com, anton.ivanov@cambridgegreys.com,
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dakr@kernel.org,
	david@davidgow.net, gary@garyguo.net, johannes@sipsolutions.net,
	justinstitt@google.com, linux-arm-kernel@lists.infradead.org,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-um@lists.infradead.org,
	llvm@lists.linux.dev, lossin@kernel.org, mark.rutland@arm.com,
	mmaurer@google.com, morbo@google.com, nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com, nicolas.schier@linux.dev,
	nsc@kernel.org, peterz@infradead.org, richard@nod.at,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu, urezki@gmail.com,
	will@kernel.org
Subject: Re: Re: [PATCH v2 0/3] Inline helpers into Rust without full LTO
Message-ID: <acEP7tl8pqFA3tK8@shell.armlinux.org.uk>
References: <20260322192159.88138-1-ojeda@kernel.org>
 <20260323000327.111235-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323000327.111235-1-ojeda@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260323_030351_109161_65E3B21D 
X-CRM114-Status: GOOD (  14.81  )
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

Why is Rust generating code for userspace thread accessors for kernel
space, where userspace threads are meaningless. This is totally wrong.
The kernel must not reference __aeabi_read_tp().

Note: I know nothing about Rust, but I know enough to say the above is
pointing to a fundamental issue in Rust for 32-bit ARM.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


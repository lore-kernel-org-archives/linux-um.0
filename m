Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B3FFF886D
	for <linux-um@archiver.kernel.org>; Tue, 28 Apr 2026 11:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wVlN3F/adnpU3EbVMRovr5PQ7UzNKrgvugpJLXSzjvA=; b=oRcVKAUKufJI9GFijrnAA9GqN2
	XMa5VZ/12pvXLArSepb38XVjpHb/Ormskl9RGIaDhb/jwF4KOn/yglICaoM7dc82Igz6pfpHNAzio
	tP9Tgw2mnXdn7vF87+WWhw3Ab8ICSfE+JJiPYoC9Oy298UPOCZSsa2Qk0VMvD2ACs5ofqFlSkF51j
	Cwa+YRmZypj/T1Uxdimbx2nUapr3zmJ8lTkS2kZJ3LJJVIxxEZeG6FfXCwqwB8SAT+E/FhdYx2kTS
	6dC9evn6d+3Nocwtn5zbvlDpr0PTLkrlq3KNWGlQtrWojCHLwwz1goa4SUgRr+mP/hSbs0+aUshj/
	GYFKhAdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHgUz-00000001L41-3LO1;
	Tue, 28 Apr 2026 11:21:05 +0000
Received: from gate.crashing.org ([63.228.1.57])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHgUw-00000001L32-2Vcd;
	Tue, 28 Apr 2026 11:21:04 +0000
Received: from gate.crashing.org (localhost [127.0.0.1])
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 63SBKIxF1057213;
	Tue, 28 Apr 2026 06:20:18 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.18.1/8.18.1/Submit) id 63SBKHXo1057211;
	Tue, 28 Apr 2026 06:20:17 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Tue, 28 Apr 2026 06:20:17 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Laight <david.laight.linux@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org,
        Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        dmaengine@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-fsi@lists.ozlabs.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
        ocfs2-devel@lists.linux.dev, bpf@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH v1 7/9] x86: Add unsafe_copy_from_user()
Message-ID: <afCX8WlnEFUei1y6@gate>
References: <cover.1777306795.git.chleroy@kernel.org>
 <0ee46bb228d97163fbdc14f2a7c52b93d8bc34ce.1777306795.git.chleroy@kernel.org>
 <ae-j2_QirCySZD02@yury>
 <63a4d0f6-0eb3-48cd-9f98-bf7b223b2606@kernel.org>
 <ae-2yLWSGnfeTvh1@yury>
 <CAHk-=wgPrLy0FR3sEWBYQuNAac1axDASYMnTuPuxEU0WytzL7w@mail.gmail.com>
 <ae_jeJLlVWjJ4sOY@yury>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae_jeJLlVWjJ4sOY@yury>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260428_042102_834754_31566CF4 
X-CRM114-Status: GOOD (  21.19  )
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

Hi!

On Mon, Apr 27, 2026 at 06:30:16PM -0400, Yury Norov wrote:
> On Mon, Apr 27, 2026 at 02:52:05PM -0700, Linus Torvalds wrote:
> > On Mon, 27 Apr 2026 at 12:19, Yury Norov <ynorov@nvidia.com> wrote:
> > >
> > > This is what Linus said when added x86 implementation for copy_from_user()
> > > in c512c69187197:
> > 
> > Note that some things have happily changed in the six+ years since...
> > 
> > >   That's partly because we have no current users of it, but also partly
> > >   because the copy_from_user() case is slightly different and cannot
> > >   efficiently be implemented in terms of a unsafe_get_user() loop (because
> > >   gcc can't do asm goto with outputs).
> > 
> > now everybody can do asm goto with outputs.
> > 
> > Yes, it's disabled on older versions, so it's not *always* available,
> > but all modern versions do it. And if you care about performance, you
> > won't be using an old compiler.
> 
> The minimal GCC version is 8.1, and asm goto with outputs is supported
> since GCC-11. That would brake the build, if we just switch to using it
> without "CC_IS_GCC && (GCC_VERSION >= 110100)" guard.
> 
> Is it worth to maintain 2 version of the function? I don't know...

GCC 11 was released five years and a day ago.  The last GCC 11 release
(that of 11.5) is not even two years ago though (but there will be no
more!)

So it would be not conservative at all to require GCC 11 as minimum now,
some people might even call it a bit aggressive.  But in a year (or
maybe two) the lay of the land will be rather different.


Segher


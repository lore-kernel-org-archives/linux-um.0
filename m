Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6FAC5B572
	for <linux-um@archiver.kernel.org>; Thu, 13 Aug 2026 06:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ns4GoDNqcj/9AON25YCP9GahdV/I2v0GEJ5Utg1AonY=; b=GV9f13kSXtWNGt6LfH1ezFn5Jl
	Z3DDrvQGsGAUdn73W9f1XfZMCQP7izXMxCCQdHGw9TeC11v0f/zat3vxfYaCmlkBMQb1DzBh2ZDA+
	3SCiMR/JesyLqtkmXX+vg1Vb8WN+aIm5WLNoZ4UkKLZS+01KdiWJkrHIEbXBMPj9nrqXfJ+CCDVYC
	iPGduQhMeoMnFk23GZN8/DTqFocr9J5Xr9PXatt+tQ18JdvEDgeOmqOmgggCF3TK0yOpTovXS1ZEj
	fIysIBVOXAkwFFahL6z4fEOsDD0OJVLsMetNIS0Lln8PRfmTue9TVVA+h/KTa6By/ipEgSlrH7h2k
	iWsg3lyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuOXM-0000000HSMo-1Gqn;
	Thu, 13 Aug 2026 06:03:32 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuOXI-0000000HSLn-0yta;
	Thu, 13 Aug 2026 06:03:30 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27767153B;
	Wed, 12 Aug 2026 23:03:23 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B05F3F632;
	Wed, 12 Aug 2026 23:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786601007; bh=urvzQP14xjouAFJaMxm1KkmF2FK+YkPxtlg+0tmM3dk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FCmrH71a8GibDaT/4TzLpR5i+19TJkV8Y7yUEveP9J/tnpZ41lNWsq0jvpmBepdWh
	 3M9emmtusN3STsiD2oIUPfk8jrriw7cyAgWrBFzUsYOHmzUnSzzBNBDES9ShVkwlc0
	 +Kv5zwJCzOVfLHIcWwsl8hCWFk4UC3OStKBDaUuE=
Date: Thu, 13 Aug 2026 11:33:23 +0530
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC V2 6/6] mm: Drop pxd_ERROR()
Message-ID: <2ys7apbnfuj3ugfoqgbptgej3jjcyfpmdgbv6qbxupmwg6mefc@h5p33ua2nzlu>
References: <20260811042119.3652929-1-anshuman.khandual@arm.com>
 <20260811042119.3652929-7-anshuman.khandual@arm.com>
 <1fb9ed88-67d0-4ac1-878d-0dc8e1135d19@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fb9ed88-67d0-4ac1-878d-0dc8e1135d19@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_230328_346729_A58E2C1B 
X-CRM114-Status: GOOD (  18.47  )
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

On Wed, Aug 12, 2026 at 01:33:14PM +0200, David Hildenbrand (Arm) wrote:
> On 8/11/26 06:21, Anshuman Khandual wrote:
> > pxd_ERROR() has been used in generic mm just to print the page table entry
> > in pxd_clear_bad() before clearing those out with pxd_clear() later. These
> > pxd_ERROR() macros have been provided by all platforms which basically did
> > the same thing.
> > 
> > Make pxd_clear_bad() use recently added ptval_to_str() instead for printing
> > page table entries thus completely dropping dependency on platform provided
> > pxd_ERROR() macros which can then be dropped off. First move all required
> > helpers in core MM into a header file which could then be used else where.
> > 
> 
> It might make sense to split this patch further up to ease review:
> 
> Patch 1) provide ptval_to_str() a header.
> 
> Patch 2) Stop using pxd_ERROR() and friends in common code, converting to
> pteval_to_str()
> 
> Patch 3) Remove now unused pxd_ERROR() and friends from arch code.

Sure but the intiial platform changes which now use ptval_to_str() as well
will probably come after the Patch (2) but before the Patch (3).

> 
> ...
> > +static inline void
> > +ptval_bytes_to_hex_str(char *buf, size_t buf_size, const void *entry, size_t entry_size)
> > +{
> > +	if (WARN_ON_ONCE(buf_size < entry_size * 2 + 1)) {
> > +		snprintf(buf, buf_size, "overflow");
> > +		return;
> > +	}
> > +
> > +	switch (entry_size) {
> > +	case sizeof(u32):
> > +		snprintf(buf, buf_size, "%08x", *(const u32 *)entry);
> > +		break;
> > +	case sizeof(u64):
> > +		snprintf(buf, buf_size, "%016llx", *(const u64 *)entry);
> > +		break;
> > +#if defined(__SIZEOF_INT128__)
> > +	case sizeof(u128):
> > +		snprintf(buf, buf_size, "%016llx%016llx",
> > +			 (unsigned long long)(*(const u128 *)entry >> 64),
> > +			 (unsigned long long)*(const u128 *)entry);
> > +		break;
> > +#endif
> > +	default:
> > +		snprintf(buf, buf_size, "unsupported");
> > +		break;
> > +	}
> > +}
> 
> Why not leave ptval_bytes_to_hex_str() in the C file for less churn for now?

Agreed - will change.

> 
> -- 
> Cheers,
> 
> David

Thanks for the review.


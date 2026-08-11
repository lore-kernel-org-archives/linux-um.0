Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720E6C5CFC1
	for <linux-um@archiver.kernel.org>; Tue, 11 Aug 2026 08:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FpB3+FkrG1uWOg00/UfBQNwp9iXrIA9AhO2Rb76OdaI=; b=kD/cn3Hw2eOwHLXAZX9vk5Yyvb
	5g0Qz2XWt8NDkWc0bkXoDkiY7xk4Z/Pwc2skcVt/JMLIPtggzjiJLtYw0BrakKL8ZQa5fR/VpRbwQ
	kvGUcuBMuiwnxFGlrGqO02FzHQ0yftvK+A4OXwLb3SRgyfjwdeyDuNTblAwaPN9ia18Fbn1zaqxqi
	T3d0J/wjvPjLT6ZGvrXnS5h8hOGhj3M5ey+abAoBMmZy+AC1wNesu4jm4Xe6PgsDK0s51nwo2l/A9
	21pWNlqFWb0dXZvOtCoLc996uwYqEAvvbSjky78S3hJ/kueWWtlYT1zWeTq5WzzLc3DTMGY/3dBye
	vQr9Q8ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wthwX-0000000DcGo-3ZW0;
	Tue, 11 Aug 2026 08:34:41 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wthwT-0000000DcEz-2qRo;
	Tue, 11 Aug 2026 08:34:39 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B295E1516;
	Tue, 11 Aug 2026 01:34:31 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA58F3F673;
	Tue, 11 Aug 2026 01:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786437275; bh=ZT08f1GiOgKpD31g66zZnUhmuNu7zNORWfMHkMNA+MM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ILvmNn+1uP0GCjTeWxHAARq3POjelk/zkkggHRqr669N5vBlnXQv9Yg8uShAHAWPV
	 r+uFJpIr4Ahch5mMzxC2ouczYWRZPMGrkwVkFNIVMPn+HCacIXd33isOumG+cExtcS
	 egAiyy/T4cf+1AQQkz3B427/hIS4SjOBaBYGwt8M=
Date: Tue, 11 Aug 2026 14:04:32 +0530
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, david@kernel.org, 
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
Message-ID: <ijjadks7zjpwqlw4nbcawr3tva2r4y6gn3weuc73vbec46petn@ovlf52m2kugw>
References: <20260811042119.3652929-1-anshuman.khandual@arm.com>
 <20260811042119.3652929-7-anshuman.khandual@arm.com>
 <CAMuHMdXfpkpYzZWGVb0fQrdn3uYHU3pyCkyAX9o2ux_Jj=2ByA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXfpkpYzZWGVb0fQrdn3uYHU3pyCkyAX9o2ux_Jj=2ByA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260811_013438_850904_CA0F1E06 
X-CRM114-Status: GOOD (  23.98  )
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

On Tue, Aug 11, 2026 at 08:49:43AM +0200, Geert Uytterhoeven wrote:
> Hi Anshuman,
> 
> Thanks for your patch!
> 
> On Tue, 11 Aug 2026 at 06:22, Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
> > pxd_ERROR() has been used in generic mm just to print the page table entry
> > in pxd_clear_bad() before clearing those out with pxd_clear() later. These
> > pxd_ERROR() macros have been provided by all platforms which basically did
> > the same thing.
> >
> > Make pxd_clear_bad() use recently added ptval_to_str() instead for printing
> > page table entries thus completely dropping dependency on platform provided
> > pxd_ERROR() macros which can then be dropped off. First move all required
> > helpers in core MM into a header file which could then be used else where.
> 
> Oh, the "x" in "pxd" is a wildcard?
> Except that is not, as it does not match "pte" ;-)

Unfortunately that's the odd one but "pxd" was the closest possible :)

> 
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> >  arch/m68k/include/asm/mcf_pgtable.h           |  6 ---
> >  arch/m68k/include/asm/motorola_pgtable.h      |  8 ----
> >  arch/m68k/include/asm/sun3_pgtable.h          |  7 ----
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Thanks !

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds


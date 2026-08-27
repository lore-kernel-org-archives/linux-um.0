Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C48AC61DCB
	for <linux-um@archiver.kernel.org>; Thu, 27 Aug 2026 06:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QFqSOaKx9Xi2yFDGQqxuznFOFvbkTjJnP1Uaos7GH1U=; b=ocGJJf7TbifSSu8C5nXKzyUJmU
	VmVv4NaesFNIlkXWRJoEpb9rrKcWYewhBAhRbrLFTZANBdCQSoe1MYftPeRY4IyD8ObdiBp99d6gw
	zMtLhaAJz9fNbOAvCh35+YFcstyJRnxmQ9WblOyNAbD5AwtyuX3onDwg7uraD3PxWjN4XKdOrfjVY
	TpTE2I4A5tzKKIT2n5rIwjCAYb6Mn4po1r7wCE/qXTQR6xxXDfvJXcc08oEzuHmi0OyGWCsKpWm9y
	tMhMpasLvD0MyyWDbUrQuDvGtff9JWXXP3paHd+0/PmZjBCwxpElFV7x84CVa+dBxpsfGT65beHFb
	N0ROz98w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzTG2-00000003SOZ-1sbd;
	Thu, 27 Aug 2026 06:06:38 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzTFz-00000003SNZ-3MMN;
	Thu, 27 Aug 2026 06:06:36 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 343D01691;
	Wed, 26 Aug 2026 23:06:29 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46D2D3F85F;
	Wed, 26 Aug 2026 23:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787810793; bh=4MEVYAYSJL4cEovvPaUuVnqFB51awZSJxYddF6SWzro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=atxvd2MBYeFEkKGg88c3L5GRhXIVBg8ao3BgsUAsWkYA7ds0RiLYyyyMKGlCqEe4v
	 MOEpEcQqGd8VjOnqn4rLw1NEKggOUfl9biN2Je1oGa1rmznEcLbhjXu1/IkCtDfkV+
	 TlSm0YogFKVAPwPubmvtzGJxMq025DHHeIV/tBH0=
Date: Thu, 27 Aug 2026 11:36:29 +0530
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Stoakes <ljs@kernel.org>, 
	linux-mm@kvack.org, akpm@linux-foundation.org, david@kernel.org
Subject: Re: [RFC V3 1/8] mm: Make ptrval_to_str() generally available
Message-ID: <xj6w5re27lbtih3lxksk2jxv6kvnpek25urjjcoobwj5pgfqtr@z5loauvsw3jj>
References: <20260818040041.1891769-1-anshuman.khandual@arm.com>
 <20260818040041.1891769-2-anshuman.khandual@arm.com>
 <029cfde8-74fc-4437-bc18-b1b53d44cab2@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <029cfde8-74fc-4437-bc18-b1b53d44cab2@sifive.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260826_230635_891528_A3EF40B3 
X-CRM114-Status: GOOD (  14.39  )
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

On Mon, Aug 24, 2026 at 10:45:09AM -0500, Samuel Holland wrote:
> On 2026-08-17 11:00 PM, Anshuman Khandual wrote:
> > Move ptrval_to_str() inside a header thus making the helper more generally
> 
> Typo here and in subject: ptrval -> ptval

Fixed.

> 
> > available for new users which are being added later. While here, also move
> > another related string size macro PTVAL_STR_MAX inside the header as well.
> > 
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: David Hildenbrand <david@kernel.org>
> > Cc: Lorenzo Stoakes <ljs@kernel.org>
> > Cc: linux-mm@kvack.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > ---
> >  include/linux/mm_types.h | 15 +++++++++++++++
> >  mm/memory.c              | 16 ++--------------
> >  2 files changed, 17 insertions(+), 14 deletions(-)
> > 
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index b18c2b2e7d2c..a5b514e55dd7 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -2001,4 +2001,19 @@ static inline unsigned long mmf_init_legacy_flags(unsigned long flags)
> >  	return flags & MMF_INIT_LEGACY_MASK;
> >  }
> >  
> > +void ptval_bytes_to_hex_str(char *buf, size_t buf_size, const void *entry, size_t entry_size);
> > +
> > +#define ptval_to_str(buf, val)								\
> >...


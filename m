Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73B1C5CFCF
	for <linux-um@archiver.kernel.org>; Thu, 13 Aug 2026 05:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PZARLK//mxzBm5+oVQwAyaOB1/sFHwMbhqQJ5pXDXaA=; b=E71A2VihWUUaFc1L57Ti0q39ls
	Veth8gja8n49/8j6Eqhmse+CdpEc9M8o5PiO9uCyWTQJOnudElX81aZH6uLjiM3KQzBpKsxEdpJ+X
	sTLHCzlp2tzTYa4JYAmhlvMjL1lNE7OFisvCrdCR2gwwvoR3VXkxvoVD//EERhFb+qo366A0lcSjp
	l4DHcoEGZc4uX6YnG/RlGOE5ndTs+eyQTKjwCHef0SA03UgUbylAGv78Z67NLT3bUOgNv9+D71mxj
	BLcpXROtvY+HeDbKsc06m8qEUaycSyYAridbqXW9Mgq51jzU3H6BHnT5sWim7CKgS5fI3ODn7qp+A
	VjD0D5FA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuOFL-0000000HRPv-1rtZ;
	Thu, 13 Aug 2026 05:44:55 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuOFI-0000000HROT-2xXs;
	Thu, 13 Aug 2026 05:44:54 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 708381516;
	Wed, 12 Aug 2026 22:44:47 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A22393F673;
	Wed, 12 Aug 2026 22:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786599891; bh=CoIN6guADWC+zDyPfhFO/S+t2cXcLfG3khdmtOUCkug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=anxqrjk0iLjQHV3BgBtB7FofiyVfbzxU/TOQyrqfHVrE3KY34mv1wfvSAdfZk8k+b
	 NqfdwWG4Em+MP9I5C6wmSIbC3ZhVt828UvY5voXcU42QX/ayulcSospBc/5SlZ/BEt
	 dTzsVhGl1W0qDqm43doqgOf533QinHxqjz/j8G+o=
Date: Thu, 13 Aug 2026 11:14:48 +0530
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
Subject: Re: [RFC V2 4/6] sh/mm: Stop using [p4d|pud|pmd]_ERROR()
Message-ID: <3bruvrvxg5blgzuhqg2f27yvfjvvsycx6lmt3jcianvpuqcs5n@zdgzfhmmhvom>
References: <20260811042119.3652929-1-anshuman.khandual@arm.com>
 <20260811042119.3652929-5-anshuman.khandual@arm.com>
 <94b52871-9cfc-42d6-b30f-545b722e71a0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94b52871-9cfc-42d6-b30f-545b722e71a0@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_224452_917988_4CA2F757 
X-CRM114-Status: GOOD (  16.97  )
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

On Wed, Aug 12, 2026 at 01:21:28PM +0200, David Hildenbrand (Arm) wrote:
> On 8/11/26 06:21, Anshuman Khandual wrote:
> > Stop using [p4d|pud|pmd]_ERROR() in __get_pte_phys() as the pgtable entries
> > are known to be NULL and hence could not really be accessed.
> > 
> > Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> > Cc: Rich Felker <dalias@libc.org>
> > Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > Cc: linux-sh@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > ---
> >  arch/sh/mm/init.c | 12 +++---------
> >  1 file changed, 3 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
> > index b3c7fd84ceb4..0bb8555568a4 100644
> > --- a/arch/sh/mm/init.c
> > +++ b/arch/sh/mm/init.c
> > @@ -58,22 +58,16 @@ static pte_t *__get_pte_phys(unsigned long addr)
> >  	}
> >  
> >  	p4d = p4d_alloc(NULL, pgd, addr);
> > -	if (unlikely(!p4d)) {
> > -		p4d_ERROR(*p4d);
> > +	if (unlikely(!p4d))
> >  		return NULL;
> > -	}
> >  
> >  	pud = pud_alloc(NULL, p4d, addr);
> > -	if (unlikely(!pud)) {
> > -		pud_ERROR(*pud);
> > +	if (unlikely(!pud))
> >  		return NULL;
> > -	}
> >  
> >  	pmd = pmd_alloc(NULL, pud, addr);
> > -	if (unlikely(!pmd)) {
> > -		pmd_ERROR(*pmd);
> > +	if (unlikely(!pmd))
> >  		return NULL;
> > -	}
> >  
> >  	return pte_offset_kernel(pmd, addr);
> >  }
> 
> Do we want to print an error like "allocating p4d table failed"?

Sure, will add error prints like the following.

--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -56,16 +56,22 @@ static pte_t *__get_pte_phys(unsigned long addr)
                return NULL;

        p4d = p4d_alloc(NULL, pgd, addr);
-       if (unlikely(!p4d))
+       if (unlikely(!p4d)) {
+               pr_err("allocating p4d table failed\n");
                return NULL;
+       }

        pud = pud_alloc(NULL, p4d, addr);
-       if (unlikely(!pud))
+       if (unlikely(!pud)) {
+               pr_err("allocating pud table failed\n");
                return NULL;
+       }

        pmd = pmd_alloc(NULL, pud, addr);
-       if (unlikely(!pmd))
+       if (unlikely(!pmd)) {
+               pr_err("allocating pmd table failed\n");
                return NULL;
+       }

        return pte_offset_kernel(pmd, addr);
 }

> 
> Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
> 
> -- 
> Cheers,
> 
> David


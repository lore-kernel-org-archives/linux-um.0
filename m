Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 410D7C4452E
	for <linux-um@archiver.kernel.org>; Mon, 20 Jul 2026 19:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kPMaiKQm/Lrn2+15jJw1Tz84+egEdnjBHflNkHpDaxg=; b=MzosOE3lSlNWI7RFXATsk1eXl5
	IvuYnG1PLkK57og3+bThTARNSCAo6gW4wro28XPuI3chXXJSS5ji8zTlyZ4n/MFaEynBeHYpZc73V
	u/OPxUz4wUSbL+UgImD6jPgorm0/1M5nc8M34hp+beW2nF5V1/1O1vHCl1vOlIuaLzMKoKT4pJ/6q
	fuqlGmNA5n6vnfNdwGacIXcV81r0OCDsMNKIDQy1/y1rQogqs8fXaWaGrscSqxxVJOzPlVtYB9Ki4
	5BSgQ2bs1wxqd1qm52LDcoJxJeUPjFBfNTEUVRBHQu5q49goMp9ddm5J9fpbkkipxZuhyhcPo11wB
	Iqw0YINA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wltIm-00000007iki-2dfG;
	Mon, 20 Jul 2026 19:05:20 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wltIg-00000007iiR-1zHC
	for linux-um@lists.infradead.org;
	Mon, 20 Jul 2026 19:05:18 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso77530635ad.2
        for <linux-um@lists.infradead.org>; Mon, 20 Jul 2026 12:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784574313; x=1785179113; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kPMaiKQm/Lrn2+15jJw1Tz84+egEdnjBHflNkHpDaxg=;
        b=UBo88U6OuaWJQo6wbNNQ4fEK8ht2MGh+8erPQ84WnrqKZA+8H3CRCwDhlB62gTMYPY
         VOkNyFnTnSjyZvzIfhDtyUYbDXIJL5RSwrO+cpO+1EEGY8jGn7+Ti9sGZBNaD+v/ZHx1
         DZY3j9t47Te9h/1khdN5HVZEfa0qWhe2xvQNIMzm+F+m07vOeISvMPMXqtstC8y4uLdQ
         pr8BK2AcQyjasdHbcmMyfQSDX4BVUViACqIlaqNA/5Z3gCk53obhll91zqr2rIj/8N5B
         oGGwE3GHlXgHbUp8WIPPi8qOOTqFmK7JUCCq7sN6nxpav8tuR9sDLrCzHmwCLY7UtExv
         /xwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784574313; x=1785179113;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kPMaiKQm/Lrn2+15jJw1Tz84+egEdnjBHflNkHpDaxg=;
        b=J3wRsyOwBZqY4nM9KoKcS5hwLrHWcvwvxYN60BUe/Ak4nWhpjDZcP6kCajunbQ1MbZ
         1h4yUtcrXNbChtPcCBtX2q3XwRlshChH3Evy5X05ThroMgFZMyWvSBFvLYzdRoyFm706
         /ZLntVgqjHvpZOEnSKRgIhMdOIb5Zo724W75OImtXTvLhkzbBxVtLZGz/7zwTaDIDqQS
         LyKCqwLQSfGIrXev5S+cx7sEbH1lVfXwx5uHWe379hEdtiIrGyGUHxC3/82NlrPcx2eo
         mQq5E3tFWI/DnkbxPwYV9/ugDdHSQWNJde791471CyE0Ih7DMqwxxNopPOiqJwQxPxnQ
         mlcg==
X-Forwarded-Encrypted: i=1; AHgh+RrukjgKr8n03MfZ7kR/ywqcSXwYFETn6gHM8V4shb5qaY6QpGDxR3fliKX1SugI8+UoSfdm//tnkQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxAYZe4aNvYRoR4xh29/ZYTL5TFSA/qMZHfzlARgArDXkfaP8Ob
	OXVXkIXmevKFR6xIcAQMCM9NVvZRGnBYVz6RURBHQlf6BVd1pG06GXVF
X-Gm-Gg: AR+sD10UA8Fv4oKPt40SL/mloG1WZTVPntDz1DeEx6a2VWHZakdGa4BDaXPdsi6Gg7w
	eIsIKvNHRyyFgVHrmoy7O4OCEMBsMUtMWZe+nkMLZ9ClH4hm2fV97/zC/0ty3kzd6msCFMY/RJB
	zADr+NkjSTMaWM0Fp3ccaYPq4r+boOw/IRc3sySqDWcepTaBV1kxarv5CC/5RrKSb9pJkfRB+2m
	Lho5bi15G8sE2aEnmMpnoDHqpO4fteKutvWt5qRjSiKjnVwhmEAucK208mPCVIIakCHkNPnWbRQ
	OxAYmpAtXdW7QN+IUo7GF7Xs9klKCKmiSvDeKcC5TYronyGlm4dwaEhoRJ0w/8zYBoAftTC4AQ+
	f0buze5VOsl6YGzay/ViVCLwFNXOSnaZUX/FBjCFnRr6jeNiA2PENNfdhMrUHRNLi3Wng85xBOO
	xlBPozgRpyF0P9dz7I1ggflcWkFBNu/PMYAw==
X-Received: by 2002:a17:902:f681:b0:2ca:3e3f:4956 with SMTP id d9443c01a7336-2cf34a35445mr164591015ad.44.1784574312756;
        Mon, 20 Jul 2026 12:05:12 -0700 (PDT)
Received: from fedora ([2601:644:937c:6c90:6d4e:7b2d:4a39:fb0c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448f73esm60735085ad.16.2026.07.20.12.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:05:11 -0700 (PDT)
Date: Mon, 20 Jul 2026 12:05:08 -0700
From: Vishal Moola <vishal.moola@gmail.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	linux-s390@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ning Sun <ning.sun@intel.com>, x86@kernel.org,
	tboot-devel@lists.sourceforge.net, Ard Biesheuvel <ardb@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	linux-efi@vger.kernel.org, Alistair Popple <apopple@nvidia.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 14/22] mm: set page table page type when allocated
Message-ID: <al5xZHiFwatn518I@fedora>
References: <20260714-remove_pgtable_cdtor-v1-0-44be8a7685d7@arm.com>
 <20260714-remove_pgtable_cdtor-v1-14-44be8a7685d7@arm.com>
 <alZSwAM4pwmMOeaD@fedora>
 <f3afa5df-73f3-49da-87a6-d75eb5f3610f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3afa5df-73f3-49da-87a6-d75eb5f3610f@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260720_120514_518808_74CFBA3A 
X-CRM114-Status: GOOD (  27.02  )
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

On Thu, Jul 16, 2026 at 11:49:31AM +0200, Kevin Brodsky wrote:
> On 14/07/2026 17:16, Vishal Moola wrote:
> > On Tue, Jul 14, 2026 at 03:04:03PM +0100, Kevin Brodsky wrote:
> >> As a step towards removing pagetable ctor/dtor calls for kernel
> >> mm's, move the page type updates from the ctor/dtor to
> >> pagetable_{alloc,free}.
> > Thanks for doing this patchset.
> 
> Thanks for suggesting it :) It's turning out to be quite a bit more
> involved than I expected though! (There are multiple cases where we call
> the ctor/dtor without using pagetable_{alloc,free}, see my reply to the
> cover letter.)
> 
> > We should switch over from __folio_set_pgtable() to __SetPagePgtable()
> > in this patch. Ptdescs and folios should be treated as distinctly
> > independent of each other.
> 
> I sure remember the previous discussion, but my reading of your comments
> [1] is that we cannot really change this as long as pagetable_alloc()
> can be called with order > 0, right? Multiple archs still rely on that.

Kinda...

The concern was about callers accessing tail pages directly for that
information. Using the folio API ensures that we always look into the
head page.

Since we're now doing it at allocation time, we know we always have the
head page, so it's fine.

The dtor/free should be more questionable because the underlying api
uses virt_to_page() which could look at a tail page... oopsie. I
haven't seen any reports tied to it so its probably fine (the
setting/clearing has been using the folio API since ptdescs).

We can say thats a happy accident that makes distinguishing ptdescs
and folios easier :)

> > Eventually, we want to replace the memcg accounting as well, but
> > there's no existing API for that right now. Lets leave that as is for
> > now; this patchset is big enough already ;)
> 
> Yep, looks like there was an attempt to improve this but it had to be
> reverted [2].
> 
> - Kevin
> 
> [1] https://lore.kernel.org/all/aha321ndGSdReBJR@fedora/
> [2]
> https://lore.kernel.org/all/20260225002434.2953895-1-axelrasmussen@google.com/
> 


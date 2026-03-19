Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4446B1090257
	for <linux-um@archiver.kernel.org>; Thu, 19 Mar 2026 16:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ySKX/SdqeoTiP9pwQcgZ94qbw5sb0oTPtV3x6ZUzB64=; b=jfhL4nTdAYtcd3Ww89NEWeSn3w
	u7RujP1GuKAnWHas9tU/OJvxtgeQoQQ8ZFHkHT6F03GiGhITgocGAtoSXi6CCTJ6f6RS1a31tbE5r
	QmJpS46oGNrS3g6ALfcPI4JzPRNUaYOmPDuWM0OlLv5FWJn8+/MI+BM/uX7U8kIt+LH9D52mvb/6S
	9806LcLpzwizaF6pqSM6AkoBEbjxUgkAD1V0i4yyVQeGha97ITa1KmOlSozw6cLR3UiUwb0SO1kfu
	mBolpoqK+FGsAndl9oW27b00OzvtlSJb9aUDNJGgo8TD5oA8xhv/mhSDeDgTrZEIQnXjIVdBJ3pHF
	Vr+HOriA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3GZo-0000000B76P-1dSg;
	Thu, 19 Mar 2026 16:50:28 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3GZl-0000000B75M-3Dt8;
	Thu, 19 Mar 2026 16:50:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7AA6760097;
	Thu, 19 Mar 2026 16:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41945C19424;
	Thu, 19 Mar 2026 16:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773939024;
	bh=ySKX/SdqeoTiP9pwQcgZ94qbw5sb0oTPtV3x6ZUzB64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YgTWHgcwTFKs1gBYxdYW33eFt5gNoD63sWPX8mdYVejWbKUuDdrFkJsiURNl6lSLi
	 XYkJpx/wRyyEkQGRCONtUVwp8dlhSmjpJmDCO67CtepROdANquLF914vAvs8F03t4f
	 bTPzUwW9A/1agL8G//3eqOLaaV9TNMSiL0J0t6/c4zk5axQdTYHz2ZOVPKnbSwlk6K
	 qocxlmnDCy6A8nO8NHNs/bLSd9OhmFGiAmqwSf3sFUuUX0nCndmYw9sGuphDXOX2tS
	 i4TA+BApsD8Pt+tqXbprswARO/rjXi7FaX5y7BenKplS9DF3okpkWVua6BEbY/FEZi
	 KOJGjMYMEW9VA==
Date: Thu, 19 Mar 2026 16:50:08 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Kees Cook <kees@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@suse.com>, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v2 01/23] mm/vma: add vma_flags_empty(), vma_flags_and(),
 vma_flags_diff_pair()
Message-ID: <3cf675e3-d333-45f1-bcf9-466c7b16f916@lucifer.local>
References: <cover.1773665966.git.ljs@kernel.org>
 <ede9b0f8a2e2dc72e7fbc1a0ddbeb513364c28a2.1773665966.git.ljs@kernel.org>
 <4620167c-bcfe-414b-85f6-a5d28563b9af@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4620167c-bcfe-414b-85f6-a5d28563b9af@kernel.org>
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

On Wed, Mar 18, 2026 at 03:40:45PM +0100, Vlastimil Babka (SUSE) wrote:
> On 3/16/26 14:07, Lorenzo Stoakes (Oracle) wrote:
> > Firstly, add the ability to determine if VMA flags are empty, that is no
> > flags are set in a vma_flags_t value.
> >
> > Next, add the ability to obtain the equivalent of the bitwise and of two
> > vma_flags_t values, via vma_flags_and().
>
> Nit: "two values" is vma_flags_and_mask(), while vma_flags_and() takes one
> value and list of flags, no?

Sorry missed this. Yeah should be 'via vma_flags_and_mask()', or a better
description of vma_flags_and() :)

>
> > Next, add the ability to obtain the difference between two sets of VMA
> > flags, that is the equivalent to the exclusive bitwise OR of the two sets
> > of flags, via vma_flags_diff_pair().
> >
> > vma_flags_xxx_mask() typically operates on a pointer to a vma_flags_t
> > value, which is assumed to be an lvalue of some kind (such as a field in a
> > struct or a stack variable) and an rvalue of some kind (typically a
> > constant set of VMA flags obtained e.g. via mk_vma_flags() or equivalent).
> >
> > However vma_flags_diff_pair() is intended to operate on two lvalues, so use
> > the _pair() suffix to make this clear.
> >
> > Finally, update VMA userland tests to add these helpers.
> >
> > We also port bitmap_xor() and __bitmap_xor() to the tools/ headers and
> > source to allow the tests to work with vma_flags_diff_pair().
> >
> > Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
>
> Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
>


Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A87C83F34
	for <linux-um@archiver.kernel.org>; Thu, 17 Jul 2025 22:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LZCCFSUO+wfzHPsPwgejKoRmReB7/qEwEHJdDzPicLw=; b=K2MYvWbbhtcYPSukZ1bS3TSt4n
	l7t0FBa9XGl6Pe3aVQ+nKa1qqHKvQ5LowUPGNdgdagnYySxAzeAW+w7bZ03wr0PveE/wt/XZMe17V
	jE2hvsMIFnJdvcgzL9Lu6FWrZQ13B0Lk10jqtqAtlMM4lyxLcRGFA3jxDO4eMjleAe86TjKOJ1gUC
	tBf0SC67Pxyduyu+1VWxPsoVWP1JTcmBxs6woghPendr1ddRHzehou17BYT/ubJenQKx3tSvkO9nj
	69qi+kGCIIICIWslIwdqH1edMfy1MM0GYw6mRdxX8emftgamxngE/Fe/HDves9XoVBY1KLOEw3N1U
	Tszccssw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucWoX-0000000BCoc-31S7;
	Thu, 17 Jul 2025 22:10:53 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucWoU-0000000BCnq-1Jp6;
	Thu, 17 Jul 2025 22:10:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3C44A43447;
	Thu, 17 Jul 2025 22:10:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A609C4CEE3;
	Thu, 17 Jul 2025 22:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1752790249;
	bh=vZ0u5fd3DfJ6yBk3+g+sfM/GC0NNG81eBl17aO+ZI9c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JnFTsEv6asV1QHvn9oyLm0adlVD8YAwUk8D9+xSBsZ/4xRhcX7l4l0qMZNDgSRPEr
	 VDRVgiNcFppstl5irHVMQqIlu2EyZC6EiTz9tDOSSNke5t727uDO0ipCsMi5ieUTgf
	 xIAtuMC6pkfxnueF+6ZvQa0PYivWUcYkQ1GV4da4=
Date: Thu, 17 Jul 2025 15:10:48 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: hca@linux.ibm.com, christophe.leroy@csgroup.eu, andreyknvl@gmail.com,
 agordeev@linux.ibm.com, ryabinin.a.a@gmail.com, glider@google.com,
 dvyukov@google.com, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v3 01/12] lib/kasan: introduce CONFIG_ARCH_DEFER_KASAN
 option
Message-Id: <20250717151048.bb6124bea54a31cd2b41faaf@linux-foundation.org>
In-Reply-To: <20250717142732.292822-2-snovitoll@gmail.com>
References: <20250717142732.292822-1-snovitoll@gmail.com>
	<20250717142732.292822-2-snovitoll@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250717_151050_382479_26A4E570 
X-CRM114-Status: GOOD (  11.69  )
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

On Thu, 17 Jul 2025 19:27:21 +0500 Sabyrzhan Tasbolatov <snovitoll@gmail.com> wrote:

> Introduce CONFIG_ARCH_DEFER_KASAN to identify architectures that need
> to defer KASAN initialization until shadow memory is properly set up.
> 
> Some architectures (like PowerPC with radix MMU) need to set up their
> shadow memory mappings before KASAN can be safely enabled, while others
> (like s390, x86, arm) can enable KASAN much earlier or even from the
> beginning.
> 
> This option allows us to:
> 1. Use static keys only where needed (avoiding overhead)
> 2. Use compile-time constants for arch that don't need runtime checks
> 3. Maintain optimal performance for both scenarios
> 
> Architectures that need deferred KASAN should select this option.
> Architectures that can enable KASAN early will get compile-time
> optimizations instead of runtime checks.

Looks nice and appears quite mature.  I'm reluctant to add it to mm.git
during -rc6, especially given the lack of formal review and ack tags.

But but but, that's what the mm-new branch is for.  I guess I'll add it
to get some additional exposure, but whether I'll advance it into
mm-unstable/linux-next for this cycle is unclear.

What do you (and others) think?


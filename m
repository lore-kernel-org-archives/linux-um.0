Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07326CF31AE
	for <linux-um@archiver.kernel.org>; Wed, 19 Nov 2025 11:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Eq4WscAyZwt7xa5/w9xC/NYo57RAulVfgxORylBgydM=; b=gNiSRbHDFz50vUX3L/2is/tTr2
	CV7nQHWrIGMkXYEbJtAbdaRqWTdZhaIiE5XZYXPs5TKcofzMKZU72HdvhEQc/il2tb75GLd69GUUA
	zJXtU/cbg6hPctGiuQKXH0Ah4Iucl9oq2Wp+yb1c7yVALbeofScr7XtqEtIZ2vXj2+jnRBojVsDH+
	NoDRjg6Ib3ZOQQqPe6tq6HI5XZdodirPSgxnId28v5dS84329Oh0l4qSGCQVherK6xRl5gFGnFGkx
	G7yONxSv4HAkaeFr2FgKj4k991cSjiZnUSq0evORJ+iaq+otLLPQTmeGvUEXSwm2aIoPNcFbAwV/X
	SgoActEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLgZ2-000000033dv-2qWZ;
	Wed, 19 Nov 2025 11:41:32 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLgZ1-000000033dX-0TW0
	for linux-um@lists.infradead.org;
	Wed, 19 Nov 2025 11:41:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 86D1C60126;
	Wed, 19 Nov 2025 11:41:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F382FC116B1;
	Wed, 19 Nov 2025 11:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763552490;
	bh=HXpQLGEYTPYES14JBHZvvFK44MSIkNFIzwcCwSjsouc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dJbIHiQryWS5vtNu02vTmwBFqXplLmDlrRF3Oj/Hv8Rl3ZpPg4lfks4k8cE/XqwR9
	 V9MAm853Im7SAdK7OXzlQw1hc6tyKLDgzb0uKjIo0GCzMjAqscZ2owxQPDp1CdEz7a
	 7usbZ/LyHrmIBFSRl4TInJY6BMkNTTqpwNiRaRzl4++4YCRK4dWRMoJoh2WkvIkdYZ
	 xgI0cA9TTcO8KXj59OYrhJ5G/eM4nqANztmks5pHkQqHorWXCFHTgtIibsN3o8GESg
	 KcvLEYucw41mQLZuYbSRCwcgj/tdWLOnihNqvwOfKxarPLIBUMfK6lvxodlvk9eBbF
	 XeSn8dvhB6NSg==
Message-ID: <e539179f-668e-452d-a08e-6143392dae6a@kernel.org>
Date: Wed, 19 Nov 2025 12:41:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] mm: change mm/pt_reclaim.c to use asm/tlb.h
 instead of asm-generic/tlb.h
To: Qi Zheng <qi.zheng@linux.dev>, will@kernel.org, aneesh.kumar@kernel.org,
 npiggin@gmail.com, peterz@infradead.org, dev.jain@arm.com,
 akpm@linux-foundation.org, ioworker0@gmail.com, linmag7@gmail.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-alpha@vger.kernel.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-um@lists.infradead.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1763537007.git.zhengqi.arch@bytedance.com>
 <e9d510106b5bf72a9b577b8c5ad161fd3c29c2b6.1763537007.git.zhengqi.arch@bytedance.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <e9d510106b5bf72a9b577b8c5ad161fd3c29c2b6.1763537007.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 19.11.25 08:31, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Generally, the asm/tlb.h will include asm-generic/tlb.h, so change
> mm/pt_reclaim.c to use asm/tlb.h instead of asm-generic/tlb.h. This can
> also fix compilation errors on some architecture when CONFIG_PT_RECLAIM
> is enabled (such as alpha).

"This is a preparation for enabling CONFIG_PT_RECLAIM on other 
architectures, such as alpha."

> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>   mm/pt_reclaim.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/pt_reclaim.c b/mm/pt_reclaim.c
> index 0d9cfbf4fe5d8..46771cfff8239 100644
> --- a/mm/pt_reclaim.c
> +++ b/mm/pt_reclaim.c
> @@ -2,7 +2,7 @@
>   #include <linux/hugetlb.h>
>   #include <linux/pgalloc.h>
>   
> -#include <asm-generic/tlb.h>
> +#include <asm/tlb.h>
>   
>   #include "internal.h"
>   

Right, we're using pte_free_tlb(), and the default lives in 
include/asm-generic/tlb.h.

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David


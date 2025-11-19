Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F641CF31B0
	for <linux-um@archiver.kernel.org>; Wed, 19 Nov 2025 12:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9eiK6+KP3sQeus9efFgfEbOH2adoGq+RjOojwb3xNjU=; b=ocDe63msJ1Ut6E4bUZQz6pTdQZ
	Yz+B1KJEx6RRWhbovvCDibzfJ75AZzVafP7zEUvBiQkQVdnz7yC/t/lCBvQ47dNO9DuZlm9ZXxkhZ
	xTy81PXXlR+sfWqUCEA7MQrVhQJ14Jcirl1EpL/nQMnOjHDwAYs1yWI9A7zgs6kL4LuDn58umIkVJ
	RG3rWGIeG3B4Vn4GCNw4cJ02Iw+msMqdsn8iTY50iTCbIOF8PmJ8NXAFCK6Tas41X/GUkB8ZsmaZk
	pr0OS8oYrIrg5c+nyqC4pf4rTGz+gXO0XDGmavvauhXVvYHqSHx7Z3JtcIM9PjSEDlI8nBNk+M6ps
	w3fIMVgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLh87-000000036Ta-36Ws;
	Wed, 19 Nov 2025 12:17:47 +0000
Received: from out-184.mta0.migadu.com ([2001:41d0:1004:224b::b8])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLh85-000000036T4-1HJa
	for linux-um@lists.infradead.org;
	Wed, 19 Nov 2025 12:17:46 +0000
Message-ID: <939e3496-5012-4e7d-8a33-e9de4354d4fd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763554662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9eiK6+KP3sQeus9efFgfEbOH2adoGq+RjOojwb3xNjU=;
	b=Zqy5lX1a8NH32Urc6QLDGvEAqomF2lRwsHiYL0l9i1s/rF3dYjFpcG8gjDNr8eJS2XwRye
	ZVGhpKOTCj8lKt/dfRzfgKw3J1mAcg3B69SNBb0spvOTCzuF7kU0BWqQyFrC8oudnT+l5K
	mEXeAABjnQT0helIioSYA0k5eRwmsng=
Date: Wed, 19 Nov 2025 20:17:31 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/7] mm: change mm/pt_reclaim.c to use asm/tlb.h
 instead of asm-generic/tlb.h
To: "David Hildenbrand (Red Hat)" <david@kernel.org>, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, peterz@infradead.org,
 dev.jain@arm.com, akpm@linux-foundation.org, ioworker0@gmail.com,
 linmag7@gmail.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-alpha@vger.kernel.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-um@lists.infradead.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1763537007.git.zhengqi.arch@bytedance.com>
 <e9d510106b5bf72a9b577b8c5ad161fd3c29c2b6.1763537007.git.zhengqi.arch@bytedance.com>
 <e539179f-668e-452d-a08e-6143392dae6a@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <e539179f-668e-452d-a08e-6143392dae6a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251119_041745_504838_30B64701 
X-CRM114-Status: GOOD (  13.43  )
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



On 11/19/25 7:41 PM, David Hildenbrand (Red Hat) wrote:
> On 19.11.25 08:31, Qi Zheng wrote:
>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> Generally, the asm/tlb.h will include asm-generic/tlb.h, so change
>> mm/pt_reclaim.c to use asm/tlb.h instead of asm-generic/tlb.h. This can
>> also fix compilation errors on some architecture when CONFIG_PT_RECLAIM
>> is enabled (such as alpha).
> 
> "This is a preparation for enabling CONFIG_PT_RECLAIM on other 
> architectures, such as alpha."

OK, will modify it in the next version.

> 
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   mm/pt_reclaim.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/pt_reclaim.c b/mm/pt_reclaim.c
>> index 0d9cfbf4fe5d8..46771cfff8239 100644
>> --- a/mm/pt_reclaim.c
>> +++ b/mm/pt_reclaim.c
>> @@ -2,7 +2,7 @@
>>   #include <linux/hugetlb.h>
>>   #include <linux/pgalloc.h>
>> -#include <asm-generic/tlb.h>
>> +#include <asm/tlb.h>
>>   #include "internal.h"
> 
> Right, we're using pte_free_tlb(), and the default lives in include/asm- 
> generic/tlb.h.
> 
> Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

Thanks!

> 



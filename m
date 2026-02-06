Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2A5EE20A0
	for <linux-um@archiver.kernel.org>; Fri,  6 Feb 2026 13:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vb13Vwh1fPqNxRNlEIYNEmJHIJtcIK4aczKvaS88OeA=; b=hXNwaRxuEzgR8yaBCLwj+1YqNv
	iKG0OpD6dR5lQYbETT31R6dUj03gx8ne/TSvwgQWo/DpILpQstg0fw54k8j+5WvwE5AEgnOOZXYJO
	8V7UhmXniRBpkiykWpacNyS8sMKUxKBW2HG60bcNr3/wFZ3d+eTRgqCoFE9BFwwfMy4CUwp7BSoQd
	kutdM0+HcIaSw3UxMqilTh2+Spx28XnMtWnujT/8/vjm0kWESVrbJBSBSz5X6JWMJoqudiUio75Wd
	q1oAVXj9IdMF/XoelZfq7T6srbynQRMPY+V/SGlCnYCt+fNYtd6kP56uiWgcaADeVWzThzFRiwTMZ
	WcMDMj+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voLxn-0000000BMyn-29nU;
	Fri, 06 Feb 2026 13:33:35 +0000
Received: from smtp-out3.simply.com ([94.231.106.210])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voLxj-0000000BMxb-1RsN
	for linux-um@lists.infradead.org;
	Fri, 06 Feb 2026 13:33:34 +0000
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4f6w5f1jGqz1FDXx;
	Fri,  6 Feb 2026 14:33:26 +0100 (CET)
Received: from [10.10.15.18] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4f6w5d3Z4Lz1FQVL;
	Fri,  6 Feb 2026 14:33:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1770384806;
	bh=vb13Vwh1fPqNxRNlEIYNEmJHIJtcIK4aczKvaS88OeA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Z9Z88cebMu7Ddw1jVWtT448QIvjHL3GiCwWDGvsQ01Wxtyv3l79H+bPYslc1UOB9Y
	 BdTB81cJcyiWlbAk4Xtv+cSCwqG0dm8ZtfsJ0+1NUs0nMYD/nsZAWUQ7EG3GW5LUcx
	 0wBqY7vrdo20aOPF/76QbRmshC7PSNXwuN38zJAxeBlYBIzyXSflwMh2TZ4DIboOxw
	 vVux+ighrR6Q5uNjNY7Izr87aZexRGjwxcfGrRU9WPwEYfMjDFCgLUCpuncK1iWdjy
	 /ZR4ft/NA5cLVxWSHqdmyJ6d7uUMeuP1zpoKteadSBJ5gNGxos6/Pw/tMDP1Ddpwbt
	 dhqXYTI9hYY9A==
Message-ID: <847afd79-e8f8-4547-8167-0125809de055@gaisler.com>
Date: Fri, 6 Feb 2026 14:33:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/8] mm: convert __HAVE_ARCH_TLB_REMOVE_TABLE to
 CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE config
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Qi Zheng <qi.zheng@linux.dev>, richard.weiyang@gmail.com, will@kernel.org,
 peterz@infradead.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 dev.jain@arm.com, ioworker0@gmail.com, linmag7@gmail.com,
 akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-alpha@vger.kernel.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-um@lists.infradead.org, sparclinux@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1769515122.git.zhengqi.arch@bytedance.com>
 <5ebfa3d4b56e63c6906bda5eccaa9f7194d3a86b.1769515122.git.zhengqi.arch@bytedance.com>
 <a404e9ec-35ff-44b1-b321-9cc4fbf72060@kernel.org>
 <1663ae90-3247-4e12-a25a-049fc3281e19@linux.dev>
 <538fef61-3903-407e-8486-538a28b99e9d@kernel.org>
 <53a1bbdd-26d1-454d-af06-169172278718@linux.dev>
 <c24c32bd-085d-460a-833a-a982eb5becaa@kernel.org>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <c24c32bd-085d-460a-833a-a982eb5becaa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260206_053331_741864_F709859B 
X-CRM114-Status: GOOD (  11.68  )
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

On 2026-02-06 13:59, David Hildenbrand (Arm) wrote:
> On 2/6/26 12:58, Qi Zheng wrote:
>>
>>
>> On 2/6/26 7:45 PM, David Hildenbrand (Arm) wrote:
>>> On 2/6/26 12:13, Qi Zheng wrote:
>>>>
>>>>
>>>>
>>>> Ah, It's just simply aligned with the MMU_GATHER_RCU_TABLE_FREE above.
>>>
>>> But does that work as expected for !SMP?
>>
>> In the case of !SMP, tlb_remove_table() will not be called:
>>
>> static inline void pgtable_free_tlb(struct mmu_gather *tlb, void *table, bool is_page)
>> {
>>      pgtable_free(table, is_page);
>> }
> 
> Ah, okay. Confusing stuff. Would have been nice to document/mention that in the patch description.
> 
> So if it compiles, all good
> 
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> 

It looks a bit weird, but it is actually more logically correct than
before the patch. Before this in the !SMP sparc64 case
__HAVE_ARCH_TLB_REMOVE_TABLE was defined even with no actual
__tlb_remove_table() present. But it did not matter in practice.
But I agree that a mention would not hurt.

Tested both with SMP and !SMP

Tested-by: Andreas Larsson <andreas@gaisler.com> #sparc
Acked-by: Andreas Larsson <andreas@gaisler.com> #sparc

Cheers,
Andreas



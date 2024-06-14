Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B9BC27C6E
	for <linux-um@archiver.kernel.org>; Fri, 14 Jun 2024 07:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JQQxsPBCGNlGltg90dHlzYb1+dKHXWo1jn5ufOqQtzw=; b=s3LczeiyXHoFT2/R6+vIT2Mfpr
	I1b1zQonuAkYLc/mv8NESGFJjuzARzIQZJJpkPFOMfn4LEh4WAkaSf+kWkv5DAhrlUTbb128JhUcT
	AwKVvgcU6TWNBkch9Jvfmgb7hUoosALw6Nq1r2KNj8HkhuvPq3Zy6jdFnLTb03ECPpYEvUdffPtRP
	MWb0dSKiVKgSZjVznCnDRlZXCfw3fUrZQSP3zQreZlsgvvCCXHH7NR6hk66jvAF1VWXkfhVY4IcFn
	yQNEc8c7rjjTz7JhGETb0bH6dBo3DZD8levOHbgySDBHvn/0fvRsDbqfh0X2YJvzBt13xlYS0MKjk
	QPvGW7lA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI1Pw-00000001o8n-3NLs;
	Fri, 14 Jun 2024 07:32:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI1Pt-00000001o69-2Yxo
	for linux-um@lists.infradead.org;
	Fri, 14 Jun 2024 07:32:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718350327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JQQxsPBCGNlGltg90dHlzYb1+dKHXWo1jn5ufOqQtzw=;
	b=U8BMNL/fUuBLZGOUOtAiqZn+h7illajZvL4wVCaeGzT4h6yFiCi0vC0NDkStoUhmOrlofa
	kFIlEdYkaIDNdFr8PZ4FbRFrb26WUyWOt9OrB2ApXF8XOLgXjN0pChVqy7+izOGcO+NSIr
	7fzuvGKXLPoW1AFmeWrdWXfKnAXkRPQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-IfyhlGFqOku2t9i8nSSnMw-1; Fri, 14 Jun 2024 03:32:03 -0400
X-MC-Unique: IfyhlGFqOku2t9i8nSSnMw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52c8a4ef5e5so1555686e87.1
        for <linux-um@lists.infradead.org>; Fri, 14 Jun 2024 00:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718350322; x=1718955122;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQQxsPBCGNlGltg90dHlzYb1+dKHXWo1jn5ufOqQtzw=;
        b=KE7YE+fK4UFkkaxZ+kM5+v8X5a4GwTBmGVM3C6QSATvfQOYprC3MGIDF3DkHaVHjix
         EPS2DPopZMAQQrZ40UBCut1+Lm1iU1E7x4vs0CKdgQFSXC6vaY22L34pCL97OopRqdSj
         WSYjfFC/0HefMe4Z2gQZD5XyU/3RpDw8GYvr0tY8SDDwxa0jbpXixMYllYuVfUOov2TL
         Diet+h8JT7JxXuLsCaFsimIVIDiiWr0bdi7W95aOgVhSOOnZYSE8URgac4wgQy7ufKeb
         uj58mX7LF3AFzSfeNrPTZbaXTkzPtRxqdqONa5DPPFC4SyzST+9G/SPRJgkFtKnIHza9
         CI+w==
X-Gm-Message-State: AOJu0Yx8Q0UhpUS4gNJ5PFVJhIwVLAXxQXTmpespzglbJz+W3JCxp7XZ
	o0K24RZScJGcWC5uPDAJP4zbsgWq46mbKPilrwxUMs2yvhQG3LgBnQGLHrM84O8uqRHfBap2VLL
	HWE7B5lvsWxd11wmbqErM5CypuFJhEu9ZYAYtcQkxM7YeQiarzgPSlUIn73XM6g==
X-Received: by 2002:a05:6512:24c:b0:52c:84a5:6617 with SMTP id 2adb3069b0e04-52ca6e9eb89mr1073944e87.68.1718350322133;
        Fri, 14 Jun 2024 00:32:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFihBuTEOEDGNiwwCtY19FqpqtczDOedWWjPsEX1AockcBtJRBs033ICPEr5aYYYymQLaAzQg==
X-Received: by 2002:a05:6512:24c:b0:52c:84a5:6617 with SMTP id 2adb3069b0e04-52ca6e9eb89mr1073926e87.68.1718350321633;
        Fri, 14 Jun 2024 00:32:01 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4f:2b00:69b5:3684:56c:6dd5? (p200300d82f4f2b0069b53684056c6dd5.dip0.t-ipconnect.de. [2003:d8:2f4f:2b00:69b5:3684:56c:6dd5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750ad082sm3504522f8f.59.2024.06.14.00.32.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 00:32:01 -0700 (PDT)
Message-ID: <d21c00f1-bd9d-48ae-bb54-86cf126c45ef@redhat.com>
Date: Fri, 14 Jun 2024 09:31:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um/mm: get max_low_pfn from memblock
To: Wei Yang <richard.weiyang@gmail.com>, richard@nod.at,
 anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org, linux-mm@kvack.org,
 Jason Lunz <lunz@falooley.org>, Jeff Dike <jdike@linux.intel.com>,
 Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>,
 Alasdair G Kergon <agk@redhat.com>, Jens Axboe <jens.axboe@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
 Tiezhu Yang <yangtiezhu@loongson.cn>
References: <20240614015840.12632-1-richard.weiyang@gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240614015840.12632-1-richard.weiyang@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_003209_884922_11F0CE2A 
X-CRM114-Status: GOOD (  21.73  )
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

On 14.06.24 03:58, Wei Yang wrote:
> Current calculation of max_low_pfn is introduced in commit af84eab20891
> ("[PATCH] uml: fix LVM crash"). It is intended to set max_low_pfn to the
> same value as max_pfn.
> 
> But I am not sure why the max_pfn is set to totalram_pages, which
> represents the number of usable pages in system instead of an absolute
> page frame number. (The change history stops there.)
> 
> While we can get the maximum page frame number from memblock, this looks
> more reasonable than setting to totalram_pages.
> 
> Also this would help changing totalram_pages accounting, since we plan
> to move the accounting into __free_pages_core(). With this change,
> totalram_pages may not represent the total usable pages at this point,
> since some pages would be deferred initialized.

Question is if deferred page init is even a thing on UM. But it certainly looks odd+suspiciously wrong to rely on totalram_pages().

> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> CC: Jason Lunz <lunz@falooley.org>
> CC: Jeff Dike <jdike@linux.intel.com>
> Cc: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> Cc: Alasdair G Kergon <agk@redhat.com>
> Cc: Jens Axboe <jens.axboe@oracle.com>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: Mike Rapoport (IBM) <rppt@kernel.org>
> CC: David Hildenbrand <david@redhat.com>
> 
> ---
> A simple UML bootup test looks good.
> ---
>   arch/um/kernel/mem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
> index ca91accd64fc..ca682879e28f 100644
> --- a/arch/um/kernel/mem.c
> +++ b/arch/um/kernel/mem.c
> @@ -73,7 +73,7 @@ void __init mem_init(void)
>   
>   	/* this will put all low memory onto the freelists */
>   	memblock_free_all();
> -	max_low_pfn = totalram_pages();
> +	max_low_pfn = PFN_DOWN(memblock_end_of_DRAM());
>   	max_pfn = max_low_pfn;
>   	kmalloc_ok = 1;
>   }

Matches what a bunch of other archs do.

Acked-by: David Hildenbrand <david@redhat.com>


Randomly staring at other users:

arch/loongarch/kernel/numa.c:   max_low_pfn = PHYS_PFN(memblock_end_of_DRAM());
arch/loongarch/kernel/setup.c:  max_low_pfn = PFN_PHYS(memblock_end_of_DRAM());

What? the latter cannot possibly be right, no? Looks odd at least.
Only applies to CONFIG_OF_EARLY_FLATTREE. CCing loongarch maintainer.

-- 
Cheers,

David / dhildenb



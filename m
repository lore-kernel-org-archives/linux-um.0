Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E3A9C27C79
	for <linux-um@archiver.kernel.org>; Sat, 15 Jun 2024 03:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eag/ffHulJTH11LAEEzgdujJj7/fMx8Zcn2PVrCD/DQ=; b=hOtkDEhgsd0JBT0Ag7sgRXaybe
	8vtAHT1odQ44KBFGpFajR599ADue9ACY2M6OjG3A5ogaqSYjzQMHAFn8jL7+u7L0eLytYcSoDGadU
	6X43KLDIVqGh5Mgt24PSzlWC+HitDCyuFQRzjvbYMnC8EiR3gMAweAqhi1cxQjRaccxAGvzAqkuP0
	qTKsjjvuzgtaI5z0siMI4vxCKeb3isateVHbDhCX9syljDgojg7DagGdrNPbmaPTsyoZOn80FVgxb
	TIHaeh9wj1HrlYR/RHxTyyeMNl1Wi6iguHi/sHhRLN4WQxU6R2ZmxyDrLsXqUeYSDZlORomjhUiQp
	rymul94Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIKB3-00000004aTo-2vLK;
	Sat, 15 Jun 2024 03:34:05 +0000
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIKAx-00000004aQj-0Wu5
	for linux-um@lists.infradead.org;
	Sat, 15 Jun 2024 03:34:04 +0000
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-57ccd1111b0so96054a12.3
        for <linux-um@lists.infradead.org>; Fri, 14 Jun 2024 20:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718422435; x=1719027235; darn=lists.infradead.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eag/ffHulJTH11LAEEzgdujJj7/fMx8Zcn2PVrCD/DQ=;
        b=Xk27QLvLmtjrEbSYYFosjk6h5zV1+DCGQG3JV2M7ccGHm+SROlP2WoXmh6NC6fzNl1
         n4l/PtUkT0xYDjAzVM3e1FNMr38quVsw4nZpUII+crMCW0hxfsLXUDds1ghsAiFVInaB
         8yHujY+dRCMP4LdDLqSrkhmjaRELZgCOi5SefcMMX20cTiGWkXkbh4X9zHI2ZAdZxsfs
         bo7NvXH10yrwQMz6D+C8iu6JWMJ6qFjTFs7TOwR3d9eP9kJrplkUp8B09CJWKdUCSXb/
         jzcOsR3hXj2Ow8Uuhu5C2Jk4rwgUMV9pWV5Wzk1PgGr+ltpXsN8AFyawOMQx2qRrVuhm
         18cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718422435; x=1719027235;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eag/ffHulJTH11LAEEzgdujJj7/fMx8Zcn2PVrCD/DQ=;
        b=X2QT0xAtcB7glYvbtXTKk7Uz6x6EXD6reavjmGS5/C9DrlZ83gtI+Uv/Aeh6Bkykcl
         0ZiA7SAXY63EDrvRs+T5pPGvWppguFIKVx7sWtrMVb85eL7dEdY/gJfxzsTraJSP1/XA
         Ca6ZaZUmhHAH1lgsNkTvjuRPkiwIydWWO+Rc+qEqh9LkLEg83mYaWJsvLHOwAuiwByb2
         +HizOtCFVscmx82Jkz8TcEphwHG/Q1nysAtxYjWUZ3SH0w8Bx9UH7Hedc4doQAc7bnNz
         mkaM30HRwJ+U7VgMglcYf/UvEO4R6qWF8nMc7fuLgHtSUkMol3rgoBnTOTYQOphTSGiM
         Mr6A==
X-Forwarded-Encrypted: i=1; AJvYcCVpevQvrHzB8iZjwDXP1Ot8Fi6FUgiO27O2hGcYVi0ijOiAM6g3C7SvK4x349RtV1lEgAEhDjgn6+OzWQTkmyWa0uO639kbnV8VHn1T
X-Gm-Message-State: AOJu0YyjT0ld9tO+Le1nqXvYjhMkD7lsUPqxXQckbC2XN8GAyT02z1w9
	6W/fwhWwrBCFx0WfbiRYmE3lfqzg3Lv5L/Z6TFzfobbq6yT4wEjY
X-Google-Smtp-Source: AGHT+IGL7lAZIJvw5lleyUnHUqAnu7lF9NTcOm9/IBkUDKuK0w+zvsi9O2+fFGT2y0TvKYrCDgUKkQ==
X-Received: by 2002:a50:c056:0:b0:57c:6338:328a with SMTP id 4fb4d7f45d1cf-57cbd6c7589mr4084253a12.30.1718422435215;
        Fri, 14 Jun 2024 20:33:55 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72ce067sm3072462a12.9.2024.06.14.20.33.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Jun 2024 20:33:54 -0700 (PDT)
Date: Sat, 15 Jun 2024 03:33:53 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: David Hildenbrand <david@redhat.com>,
	Wei Yang <richard.weiyang@gmail.com>, richard@nod.at,
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
	linux-um@lists.infradead.org, linux-mm@kvack.org,
	Jason Lunz <lunz@falooley.org>, Jeff Dike <jdike@linux.intel.com>,
	Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>,
	Alasdair G Kergon <agk@redhat.com>,
	Jens Axboe <jens.axboe@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH] um/mm: get max_low_pfn from memblock
Message-ID: <20240615033353.ett6vou7da6hixwe@master>
References: <20240614015840.12632-1-richard.weiyang@gmail.com>
 <d21c00f1-bd9d-48ae-bb54-86cf126c45ef@redhat.com>
 <Zmv2hHamxBh0_Gew@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zmv2hHamxBh0_Gew@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_203359_241843_36C2584E 
X-CRM114-Status: GOOD (  28.95  )
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
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Fri, Jun 14, 2024 at 10:51:32AM +0300, Mike Rapoport wrote:
>On Fri, Jun 14, 2024 at 09:31:59AM +0200, David Hildenbrand wrote:
>> On 14.06.24 03:58, Wei Yang wrote:
>> > Current calculation of max_low_pfn is introduced in commit af84eab20891
>> > ("[PATCH] uml: fix LVM crash"). It is intended to set max_low_pfn to the
>> > same value as max_pfn.
>> > 
>> > But I am not sure why the max_pfn is set to totalram_pages, which
>> > represents the number of usable pages in system instead of an absolute
>> > page frame number. (The change history stops there.)
>> > 
>> > While we can get the maximum page frame number from memblock, this looks
>> > more reasonable than setting to totalram_pages.
>> > 
>> > Also this would help changing totalram_pages accounting, since we plan
>> > to move the accounting into __free_pages_core(). With this change,
>> > totalram_pages may not represent the total usable pages at this point,
>> > since some pages would be deferred initialized.
>> 
>> Question is if deferred page init is even a thing on UM. But it certainly looks odd+suspiciously wrong to rely on totalram_pages().
> 
>As long as there is no HIGHMEM, 
>
>max_pfn = max_low_pfn = PFN_DOWN(memblock_end_of_DRAM())
>
>should be ok.
> 
>> > Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> > CC: Jason Lunz <lunz@falooley.org>
>> > CC: Jeff Dike <jdike@linux.intel.com>
>> > Cc: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
>> > Cc: Alasdair G Kergon <agk@redhat.com>
>> > Cc: Jens Axboe <jens.axboe@oracle.com>
>> > CC: Andrew Morton <akpm@linux-foundation.org>
>> > CC: Mike Rapoport (IBM) <rppt@kernel.org>
>> > CC: David Hildenbrand <david@redhat.com>
>> > 
>> > ---
>> > A simple UML bootup test looks good.
>> > ---
>> >   arch/um/kernel/mem.c | 2 +-
>> >   1 file changed, 1 insertion(+), 1 deletion(-)
>> > 
>> > diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
>> > index ca91accd64fc..ca682879e28f 100644
>> > --- a/arch/um/kernel/mem.c
>> > +++ b/arch/um/kernel/mem.c
>> > @@ -73,7 +73,7 @@ void __init mem_init(void)
>> >   	/* this will put all low memory onto the freelists */
>> >   	memblock_free_all();
>> > -	max_low_pfn = totalram_pages();
>> > +	max_low_pfn = PFN_DOWN(memblock_end_of_DRAM());
>
>This assignment seem redundant as there is already
>
>	max_low_pfn = min_low_pfn + (map_size >> PAGE_SHIFT);
>
>in setup_physmem
>

Looks right, I added some log and shows they are the same.

Thanks

>> >   	max_pfn = max_low_pfn;
>> >   	kmalloc_ok = 1;
>> >   }
>> 
>> Matches what a bunch of other archs do.
>> 
>> Acked-by: David Hildenbrand <david@redhat.com>
>> 
>> 
>> Randomly staring at other users:
>> 
>> arch/loongarch/kernel/numa.c:   max_low_pfn = PHYS_PFN(memblock_end_of_DRAM());
>> arch/loongarch/kernel/setup.c:  max_low_pfn = PFN_PHYS(memblock_end_of_DRAM());
>> 
>> What? the latter cannot possibly be right, no? Looks odd at least.
>> Only applies to CONFIG_OF_EARLY_FLATTREE. CCing loongarch maintainer.
>> 
>> -- 
>> Cheers,
>> 
>> David / dhildenb
>> 
>
>-- 
>Sincerely yours,
>Mike.

-- 
Wei Yang
Help you, Help me


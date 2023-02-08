Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E86EC636CC
	for <linux-um@archiver.kernel.org>; Wed,  8 Feb 2023 14:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:Subject:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jbOYQN0W+4TSB77hWsfpaybd3WURs3MauUn4HoZ05lE=; b=OyMaCK2RZU4Ygd
	JPSxQR7K0vPDzALrmmG0aHAVuuRxKooutlm0UxL4aFbRnty1kA5/Euo9Z4Ml+xznOU7FZ+S9jHWr6
	MR/7XfI9k53qjwN8Yz735LOmTDevJi1j+0U1Txjb+i1HDeGwMQYWl7SA515E6NA5zDqd0n5KMA9vY
	PkEWwdmJSKVTwnoSKs4uzSNTWH0ht6WGDG6hHrhje193oXg5wySy7U+3IWC2ODjWJeiGz5jaJ98TK
	tEFbOy9qeDBJJlnYUG4A/OmehAQpPChtaiyZrgOCBlfh64b3aCrckMqdK81TuqPV0m44RAD7z6zSX
	kRx95CCd7L8CJYo8PoIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPlBR-00Fr38-Mk; Wed, 08 Feb 2023 14:12:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPlBH-00Fqzk-7X
	for linux-um@lists.infradead.org; Wed, 08 Feb 2023 14:12:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1675865534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MVdXAMmBKMdGVdB031db9qoOwXwbq1WnNqDyKF+cm50=;
	b=CPO++j16ssfrygSjiUWHVjcqYqmvbD4z6se3E9WBVNebAjxGY1FguXmFm5iSVHj+2J4xB+
	tu8Iv9zAmozBbHF0yF5x+F5/ThEUBrQ91arhLNE1whzoGTCaGDKa+Jc6u5AVzErrHQI4MG
	fFcxjU+ewh5PJKx7nEQ+CkGTyzPwZwg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-412-BZrkHrBxPwOJsjS3KLBCNw-1; Wed, 08 Feb 2023 09:12:11 -0500
X-MC-Unique: BZrkHrBxPwOJsjS3KLBCNw-1
Received: by mail-wr1-f69.google.com with SMTP id b9-20020adfc749000000b002c3dede475cso1991204wrh.6
        for <linux-um@lists.infradead.org>; Wed, 08 Feb 2023 06:12:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MVdXAMmBKMdGVdB031db9qoOwXwbq1WnNqDyKF+cm50=;
        b=4WHFNulCddfb8t9xYpoa7dPXCTZ5/xCKTIPE/eeSaf6SaIdJGH7vK51YnDjs/Bdy5v
         /Z7i9HSIR2D7ep774yUn3XBXvoOFjycydsClkEgzhhNEovun+zjXoKEyUj9b/kT0Vgjf
         Lt2q1Eaa/YIWQtRIlK202YbJEU9rAjnt2pa/S0qibceH9cH529SiqXIS7c5I6Pe0cG7m
         zMzdWyTE6ACJDnOkRW9MPqtlWjW8Bz9zngZs9AccW4459Se2agrnNOuggyarfIcF81Wa
         Ycoq0dlG+cZnELhfq0ad+NOJIIr44tJndK49UjZ810Zi2vX3ejVtCJ0U+2o3K+WqPLGX
         fWvA==
X-Gm-Message-State: AO0yUKUmrzW2uJAS1cMZyuRD1n616pGkFsQGx8xbxIW/8L2RbJWBiewZ
	65Ba2NSwQruGDJaCJfM3MrCaKpIXV8zfeMUBLtM3TxjzqMn1y8SNsrzcGrME63x2xcewWCcSqud
	1cVpeKcqRk6X6VEr9EXcJ4QlX
X-Received: by 2002:a05:600c:2ac8:b0:3d9:fb59:c16b with SMTP id t8-20020a05600c2ac800b003d9fb59c16bmr6807523wme.36.1675865529849;
        Wed, 08 Feb 2023 06:12:09 -0800 (PST)
X-Google-Smtp-Source: AK7set9buY9+5cxJmjHAU1gwkYhkjh45ggBfiU2I1/g0SGqFxOSQ99Rkm86npGHpTIA79oxlUNrbqQ==
X-Received: by 2002:a05:600c:2ac8:b0:3d9:fb59:c16b with SMTP id t8-20020a05600c2ac800b003d9fb59c16bmr6807491wme.36.1675865529588;
        Wed, 08 Feb 2023 06:12:09 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:b300:758c:6214:cd51:8ab0? (p200300cbc704b300758c6214cd518ab0.dip0.t-ipconnect.de. [2003:cb:c704:b300:758c:6214:cd51:8ab0])
        by smtp.gmail.com with ESMTPSA id a3-20020a05600c224300b003db01178b62sm2066527wmm.40.2023.02.08.06.12.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 06:12:08 -0800 (PST)
Message-ID: <39fd91e3-c93b-23c6-afc6-cbe473bb0ca9@redhat.com>
Date: Wed, 8 Feb 2023 15:12:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Hugh Dickins <hughd@google.com>, John Hubbard <jhubbard@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Mike Rapoport <rppt@linux.ibm.com>,
 Yang Shi <shy828301@gmail.com>, Vlastimil Babka <vbabka@suse.cz>,
 Nadav Amit <namit@vmware.com>, Andrea Arcangeli <aarcange@redhat.com>,
 Peter Xu <peterx@redhat.com>, linux-mm@kvack.org, x86@kernel.org,
 linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
 Russell King <linux@armlinux.org.uk>
References: <20230113171026.582290-1-david@redhat.com>
 <20230113171026.582290-5-david@redhat.com> <Y+GcDFMNHw2cdDN1@sirena.org.uk>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH mm-unstable v1 04/26] arm/mm: support
 __HAVE_ARCH_PTE_SWP_EXCLUSIVE
In-Reply-To: <Y+GcDFMNHw2cdDN1@sirena.org.uk>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230208_061215_357888_4C7122E9 
X-CRM114-Status: GOOD (  24.07  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On 07.02.23 01:32, Mark Brown wrote:
> On Fri, Jan 13, 2023 at 06:10:04PM +0100, David Hildenbrand wrote:
>> Let's support __HAVE_ARCH_PTE_SWP_EXCLUSIVE by stealing one bit from the
>> offset. This reduces the maximum swap space per file to 64 GiB (was 128
>> GiB).
>>
>> While at it drop the PTE_TYPE_FAULT from __swp_entry_to_pte() which is
>> defined to be 0 and is rather confusing because we should be dealing
>> with "Linux PTEs" not "hardware PTEs". Also, properly mask the type in
>> __swp_entry().
> 
> Today's -next (and at least back to Friday, older logs are unclear - I
> only noticed -next issues today) fails to NFS boot on an AT91SAM9G20-EK
> (an old ARMv5 platform) with multi_v5_defconfig, a bisect appears to
> point to this patch (20aae9eff5acd8f5 in today's -next) as the culprit.

It's been in -next for quite a while, thanks for the report!

> 
> The failure happens at some point after starting userspace, the kernel
> starts spamming the console with messages in the form:
> 
>      get_swap_device: Bad swap file entry 10120d20
> 

_swap_info_get() tells us that the swp type seems to be bad.
I assume we're dealing with a migration entry, if swap is disabled, and fail to
detect is_migration_entry() correctly because the type is messed up.

Could you give the following a test?


 From 8c4bdbd9862f85782d5919d044c172b584063e83 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Wed, 8 Feb 2023 15:08:01 +0100
Subject: [PATCH] arm/mm: Fix swp type masking in __swp_entry()

We're masking with the number of type bits instead of the type mask, which
is obviously wrong.

Fixes: 20aae9eff5ac ("arm/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE")
Reported-by: Mark Brown <broonie@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
  arch/arm/include/asm/pgtable.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 2e626e6da9a3..a58ccbb406ad 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -292,7 +292,7 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
  
  #define __swp_type(x)		(((x).val >> __SWP_TYPE_SHIFT) & __SWP_TYPE_MASK)
  #define __swp_offset(x)		((x).val >> __SWP_OFFSET_SHIFT)
-#define __swp_entry(type, offset) ((swp_entry_t) { (((type) & __SWP_TYPE_BITS) << __SWP_TYPE_SHIFT) | \
+#define __swp_entry(type, offset) ((swp_entry_t) { (((type) & __SWP_TYPE_MASK) << __SWP_TYPE_SHIFT) | \
  						   ((offset) << __SWP_OFFSET_SHIFT) })
  
  #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
-- 
2.39.1


-- 
Thanks,

David / dhildenb


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

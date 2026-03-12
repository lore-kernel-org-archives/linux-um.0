Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36FB105A583
	for <linux-um@archiver.kernel.org>; Thu, 12 Mar 2026 11:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lHgPc4c+EM1wDk0QatI4ONB6TYrHc3Tzig8f9b6Zjag=; b=eiKXrwHjpJh5U8VX4vnqYJvbRy
	d4J9Q0trb/4PSR8v/aeYxRMoQBG++6HMWykblfGqP7E6OrK4SIffUQYT9ftbBwWw2KOCm88xA+REY
	x1HoYemEL96TlCmKqIKDRUmWl4ocdLc7tSDVNtsTtogSt1vnSBZtAJVl5/KXcdMkvxWXkv0cawI9P
	pKg9+uDjodGi9bHib+wMvxwR2FHaQ1whvs2xEBxc4PpfDjfcRqFW5w2iaXn6W5sGFUljKHo4RLXB4
	zlZs0Oj230QW5aX3C7XOKyvYit/V+sXxNzhspNNjMLXtp1lNZipM/MzUYFYgF/hv5a0tYNfXwizS6
	kfj3ETuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0e95-0000000DwHM-1BEJ;
	Thu, 12 Mar 2026 11:24:03 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0e92-0000000DwGf-1NbB;
	Thu, 12 Mar 2026 11:24:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 88FA9403C8;
	Thu, 12 Mar 2026 11:23:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32B8C4CEF7;
	Thu, 12 Mar 2026 11:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773314639;
	bh=QmUndoWKkvGu15ytPgiNk/W/zfIzuga6NPM0kq37X6g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gddxThvuN8nEkxb1oe2xYVqYBPcAGoZjE0JamctgWmvcBJC+2RXK4H1Oaf+f3JOwW
	 fxwH+WLkxZbJY0MknBkur5pI7FCchUtXNdDKsThu5lMuoBANKs+UeoyfTMkJ1sO3+r
	 4hpyJwTo29UlAt3cBAFFMBFuxc1orHcop3iw89T3rJ87yz2VKPaAXnDxEi2c/fTd87
	 eJ/zbtp6tA8W/XODS6RYQsmWksPaTPRpOv5PRjQnkFFww5eYDtX/ErhgfeDObPX20h
	 SEdGEgkqgOZOHOJQuURbLLXig62kg6JD5Fx4CH2RFeTqabIPhh1ARDfQqZ3yTDKMjS
	 /FQjMq5HRAp3w==
Message-ID: <0bc30137-3f1d-4a4a-8573-8f26866fcc26@kernel.org>
Date: Thu, 12 Mar 2026 12:23:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/15] arch/powerpc: don't initialize kasan if it's
 disabled
To: Sourabh Jain <sourabhjain@linux.ibm.com>, Baoquan He <bhe@redhat.com>,
 kasan-dev@googlegroups.com
Cc: linux-mm@kvack.org, andreyknvl@gmail.com, ryabinin.a.a@gmail.com,
 glider@google.com, dvyukov@google.com, linux-kernel@vger.kernel.org,
 linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, x86@kernel.org, chris@zankel.net,
 jcmvbkbc@gmail.com, linux-s390@vger.kernel.org, hca@linux.ibm.com
References: <20260225081412.76502-1-bhe@redhat.com>
 <20260225081412.76502-10-bhe@redhat.com>
 <71921cca-b890-41c4-93e9-957d3f647ffa@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <71921cca-b890-41c4-93e9-957d3f647ffa@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_042400_408801_4179A2AD 
X-CRM114-Status: GOOD (  16.15  )
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



Le 12/03/2026 à 12:12, Sourabh Jain a écrit :
> 
> 
> On 25/02/26 13:44, Baoquan He wrote:
>> Here, kasan is disabled if specified 'kasan=off' in kernel cmdline.
>>
>> This includes 32bit, book3s/64 and book3e/64.
>>
>> Signed-off-by: Baoquan He <bhe@redhat.com>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> ---
>>   arch/powerpc/mm/kasan/init_32.c        | 6 +++++-
>>   arch/powerpc/mm/kasan/init_book3e_64.c | 4 ++++
>>   arch/powerpc/mm/kasan/init_book3s_64.c | 4 ++++
>>   3 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/mm/kasan/init_32.c b/arch/powerpc/mm/kasan/ 
>> init_32.c
>> index 1d083597464f..0ea2a636c992 100644
>> --- a/arch/powerpc/mm/kasan/init_32.c
>> +++ b/arch/powerpc/mm/kasan/init_32.c
>> @@ -141,6 +141,10 @@ void __init kasan_init(void)
>>       u64 i;
>>       int ret;
>> +    /* If KASAN is disabled via command line, don't initialize it. */
>> +    if (kasan_arg_disabled)
>> +        return;
>> +
>>       for_each_mem_range(i, &base, &end) {
>>           phys_addr_t top = min(end, total_lowmem);
>> @@ -170,7 +174,7 @@ void __init kasan_init(void)
>>   void __init kasan_late_init(void)
>>   {
>> -    if (IS_ENABLED(CONFIG_KASAN_VMALLOC))
>> +    if (IS_ENABLED(CONFIG_KASAN_VMALLOC) && kasan_enabled())
>>           kasan_unmap_early_shadow_vmalloc();
>>   }
>> diff --git a/arch/powerpc/mm/kasan/init_book3e_64.c b/arch/powerpc/mm/ 
>> kasan/init_book3e_64.c
>> index 0d3a73d6d4b0..fbe4c9a7e460 100644
>> --- a/arch/powerpc/mm/kasan/init_book3e_64.c
>> +++ b/arch/powerpc/mm/kasan/init_book3e_64.c
>> @@ -111,6 +111,10 @@ void __init kasan_init(void)
>>       u64 i;
>>       pte_t zero_pte = pfn_pte(virt_to_pfn(kasan_early_shadow_page), 
>> PAGE_KERNEL_RO);
>> +    /* If KASAN is disabled via command line, don't initialize it. */
>> +    if (kasan_arg_disabled)
>> +        return;
>> +
>>       for_each_mem_range(i, &start, &end)
>>           kasan_init_phys_region(phys_to_virt(start), phys_to_virt(end));
>> diff --git a/arch/powerpc/mm/kasan/init_book3s_64.c b/arch/powerpc/mm/ 
>> kasan/init_book3s_64.c
>> index dcafa641804c..f7906f9ef9be 100644
>> --- a/arch/powerpc/mm/kasan/init_book3s_64.c
>> +++ b/arch/powerpc/mm/kasan/init_book3s_64.c
>> @@ -54,6 +54,10 @@ void __init kasan_init(void)
>>       u64 i;
>>       pte_t zero_pte = pfn_pte(virt_to_pfn(kasan_early_shadow_page), 
>> PAGE_KERNEL);
>> +    /* If KASAN is disabled via command line, don't initialize it. */
>> +    if (kasan_arg_disabled)
>> +        return;
>> +
>>       if (!early_radix_enabled()) {
>>           pr_warn("KASAN not enabled as it requires radix!");
>>           return;
> 
> Should we log in the kernel log buffer that KASAN is disabled?
> 
> Right now, I don't see the kernel advertising the same.

When KASAN is enabled it is advertised with:

	pr_info("KernelAddressSanitizer initialized (generic)\n");

Isn't the absence of that message enough to understand KASAN is not there ?

> 
> $ dmesg | grep -i kasan
> [    0.000000] Kernel command line: BOOT_IMAGE=(ieee1275//vdevice/v- 
> scsi@30000070/disk@8100000000000000,msdos2)/vmlinuz-7.0.0-rc3+ 
> crashkernel=2G kasan=off
> 
> Tested this series on powerpc Pseries platform.
> So feel free to add:
> Tested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> 
> - Sourabh Jain
> 



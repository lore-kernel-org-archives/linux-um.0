Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B78DC4332F
	for <linux-um@archiver.kernel.org>; Tue, 22 Nov 2022 16:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Z+rFZHjwcyhhLaBmGkLL4/HYdKobsy3XgjtA8LiAuj8=; b=WD06QzAEaj3+EI
	xaWH9yAoYj9TXfBKXXKtSwb4+4RJDyGsXJVw5vM1kAVvoLeGG0qC6jSsfP6Dov8ghT5jkuGkgzjte
	+HFnoE++93Y7C2+zZxOqhayO3YKg99rL8DW4MGXYXEtHn6lj8IxfSqx+JXANdTmaoOFmxnIrb6Csw
	allGOzQxxWyzMlxtptldqmtt5nEcXYsgfBxWKDYs1pnzUMf7JO2S6ZmmegqqXDbCv9f92ok6iu2AP
	gdAGRW5XaiFBvLoMTMW6JA3JHvLLs8LAV7iLat3l+onj7CSKybNUKO6nMKifoLta1r6m4nBDYXdCJ
	2ZNHIzc75UQ4a4+MvaDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxWar-00AtFp-Nb; Tue, 22 Nov 2022 16:57:57 +0000
Received: from [2601:1c2:d80:3110::a2e7]
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxWao-00AtEM-BC; Tue, 22 Nov 2022 16:57:54 +0000
Message-ID: <5e27ba9e-69a1-bf70-941e-88637b4f5a3c@infradead.org>
Date: Tue, 22 Nov 2022 08:57:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: Build regressions/improvements in v6.1-rc6
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
 Alex Deucher <alexdeucher@gmail.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-um@lists.infradead.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <CAHk-=wjKJyzfJmOzBdEOqCFRc8Fh-rdGM4tvMXfW0WXbbHwV0w@mail.gmail.com>
 <20221122105054.4062213-1-geert@linux-m68k.org>
 <alpine.DEB.2.22.394.2211221154280.284524@ramsan.of.borg>
 <CADnq5_PvouSKugXxJXqkVeZf+kbP8+hhUKFgVALSO=MOW3jzvA@mail.gmail.com>
 <021efb6c9295402cf05406bb319c441c0b0229b3.camel@sipsolutions.net>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <021efb6c9295402cf05406bb319c441c0b0229b3.camel@sipsolutions.net>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org



On 11/22/22 07:00, Johannes Berg wrote:
> On Tue, 2022-11-22 at 08:55 -0500, Alex Deucher wrote:
>>>
>>>    + /kisskb/src/arch/um/include/asm/processor-generic.h: error: called object is not a function or function pointer:  => 94:18
>>>    + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c: error: control reaches end of non-void function [-Werror=return-type]:  => 1934:1
>>>
>>> um-x86_64/um-all{mod,yes}config (in kfd_cpumask_to_apic_id())
>>
>> Presumably cpu_data is not defined on um-x86_64?  Does it even make
>> sense to build drivers on um-x86_64?
> 
> Drivers in general yes ;-)
> 
> This driver, probably not.
> 
> But the issue is that a lot of drivers "depends on X86_64" or such,
> where only "X86" is the arch symbol. You could add "X86 && X86_64" to
> really build on x86 64-bit only.
> 
> I didn't check this driver, but this has mostly popped up since UM got
> PCI support some time ago (which I added.)

I have patches for lots of these issues, but some people said that they
would want to build DRM drivers for use with KUNIT (i.e. UML), so I thought
that meant my patches were not needed.

-- 
~Randy

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

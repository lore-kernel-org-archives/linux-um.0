Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4907EC87FD2
	for <linux-um@archiver.kernel.org>; Fri,  8 Aug 2025 08:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MYY170L5/j8gQmCV0i0KP9yMXLZ9vOW8yjQXrZqWtaY=; b=RtSJa4rIzJdcn5YkVuFCVlbyAD
	mbN34n0iWAAEl15V0VnH3N24ERkl+NfJcvg9efw2KHmHT9Gn45aVEo91X3K9n1n1Vo7MExa3VAHo6
	JlPnCRbdCOAFrm1enOwNqJ5foXCClPR317JjXZrGky2Kjt591J3JJMW93XVwMJwZ1QXSt8bzA3pzN
	avs3NnKvB0OUJnr/oAB4AMTF5C7DsDOLnDdXOSrqd3WnNsxzMjJKUZBZG6FUWcCa2woyYZeK0SFZ3
	guFNABE/VV9vwqtvU9DVZ8ckjA/uw9V8RezDkGo9+EFwgA+MRvM66Btps8Ug9ttqIwCi9aZ8c84fv
	5u2xmHdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukI69-00000002HbA-0i1s;
	Fri, 08 Aug 2025 08:05:09 +0000
Received: from pegase2.c-s.fr ([93.17.235.10])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukHs3-00000002FsX-1r20;
	Fri, 08 Aug 2025 07:50:36 +0000
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4bywkg3Mhqz9sS7;
	Fri,  8 Aug 2025 09:33:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6-UTSoBBRo41; Fri,  8 Aug 2025 09:33:47 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4bywkg2Vk1z9sRy;
	Fri,  8 Aug 2025 09:33:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 3F40D8B770;
	Fri,  8 Aug 2025 09:33:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id UAt1KEdP_5VW; Fri,  8 Aug 2025 09:33:47 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 1F8218B763;
	Fri,  8 Aug 2025 09:33:46 +0200 (CEST)
Message-ID: <59ce87be-0a0a-4f6b-b439-bc7a4a037fc2@csgroup.eu>
Date: Fri, 8 Aug 2025 09:33:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] kasan: introduce ARCH_DEFER_KASAN and unify static
 key across modes
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>, ryabinin.a.a@gmail.com
Cc: bhe@redhat.com, hca@linux.ibm.com, andreyknvl@gmail.com,
 akpm@linux-foundation.org, zhangqing@loongson.cn, chenhuacai@loongson.cn,
 davidgow@google.co, glider@google.com, dvyukov@google.com, alex@ghiti.fr,
 agordeev@linux.ibm.com, vincenzo.frascino@arm.com, elver@google.com,
 kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
References: <20250807194012.631367-1-snovitoll@gmail.com>
 <20250807194012.631367-2-snovitoll@gmail.com>
 <22872a3f-85dc-4740-b605-ba80b5a3b1bc@csgroup.eu>
 <CACzwLxiVURgamkv2ws5sK9BQVMz7VPSWGy_aQb+MT8jtv03d3Q@mail.gmail.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <CACzwLxiVURgamkv2ws5sK9BQVMz7VPSWGy_aQb+MT8jtv03d3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250808_005035_644892_FC4E0485 
X-CRM114-Status: GOOD (  10.88  )
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



Le 08/08/2025 à 09:26, Sabyrzhan Tasbolatov a écrit :
> On Fri, Aug 8, 2025 at 10:03 AM Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
>>> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
>>> index 9083bfdb773..a12cc072ab1 100644
>>> --- a/arch/um/Kconfig
>>> +++ b/arch/um/Kconfig
>>> @@ -5,6 +5,7 @@ menu "UML-specific options"
>>>    config UML
>>>        bool
>>>        default y
>>> +     select ARCH_DEFER_KASAN if STATIC_LINK
>>
>> No need to also verify KASAN here like powerpc and loongarch ?
> 
> Sorry, I didn't quite understand the question.
> I've verified powerpc with KASAN enabled which selects KASAN_OUTLINE,
> as far as I remember, and GENERIC mode.

The question is whether:

	select ARCH_DEFER_KASAN if STATIC_LINK

is enough ? Shouldn't it be:

	select ARCH_DEFER_KASAN if KASAN && STATIC_LINK

Like for powerpc and loongarch ?


> 
> I haven't tested LoongArch booting via QEMU, only tested compilation.
> I guess, I need to test the boot, will try to learn how to do it for
> qemu-system-loongarch64. Would be helpful LoongArch devs in CC can
> assist as well.
> 
> STATIC_LINK is defined for UML only.
> 


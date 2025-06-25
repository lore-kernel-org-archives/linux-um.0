Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF518C7EE30
	for <linux-um@archiver.kernel.org>; Wed, 25 Jun 2025 12:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aekhGqf6P/O199m3eOaLFTaZxD8oT2lv9cl8d0b7XDc=; b=Go6zgbsn3YLJiERfWvNQJ2yRLl
	Bvof9DYQ66iBlNcKg9g1sYD+bcpaPxams56s6OoegqPkHqZ0k0wkVOTXHczWmEUzf3Hs4RfSO6X+/
	O4toeis7IKVXZLM6Nk+/CVjZ+DYKysplBj4IFx0iZnNB/icmNh+mcxrTwzyOk/g7ToFr2VeEsQYbQ
	R5ObKCB3fhNUobSKXaFod10Q/FUuRHxK0FgEcUaSVrD0Sid2FJWdlRjoV4wZg+06f24ooayxUUuW0
	pqIaSJLkEnVkKvMt3tzToOi6ri4TYuxTLrN0EUZmKKg+8WpLZc4EGK+Vib+aY7VXhj1GsKpFOZ7nE
	pwq+rfhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUPFe-00000008cxg-2SyG;
	Wed, 25 Jun 2025 12:29:18 +0000
Received: from pegase1.c-s.fr ([93.17.236.30])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUNiE-00000008MwF-3ea9;
	Wed, 25 Jun 2025 10:50:44 +0000
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bRynq72Rpz9vCc;
	Wed, 25 Jun 2025 12:33:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wkd8VwLop-3S; Wed, 25 Jun 2025 12:33:03 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bRynq5zBhz9vDF;
	Wed, 25 Jun 2025 12:33:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C1DE58B7B7;
	Wed, 25 Jun 2025 12:33:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 3S-OpwLkq4z3; Wed, 25 Jun 2025 12:33:03 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id EAC428B7A7;
	Wed, 25 Jun 2025 12:33:01 +0200 (CEST)
Message-ID: <4d568111-9615-4fba-884a-f2ae629776fe@csgroup.eu>
Date: Wed, 25 Jun 2025 12:33:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] kasan/powerpc: call kasan_init_generic in kasan_init
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>, ryabinin.a.a@gmail.com,
 glider@google.com, andreyknvl@gmail.com, dvyukov@google.com,
 vincenzo.frascino@arm.com, catalin.marinas@arm.com, will@kernel.org,
 chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
 hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
 akpm@linux-foundation.org
Cc: guoweikang.kernel@gmail.com, geert@linux-m68k.org, rppt@kernel.org,
 tiwei.btw@antgroup.com, richard.weiyang@gmail.com, benjamin.berg@intel.com,
 kevin.brodsky@arm.com, kasan-dev@googlegroups.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
References: <20250625095224.118679-1-snovitoll@gmail.com>
 <20250625095224.118679-10-snovitoll@gmail.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250625095224.118679-10-snovitoll@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_035043_061735_78AB901F 
X-CRM114-Status: UNSURE (   3.15  )
X-CRM114-Notice: Please train this message.
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



Le 25/06/2025 à 11:52, Sabyrzhan Tasbolatov a écrit :
> Call kasan_init_generic() which enables the static flag
> to mark generic KASAN initialized, otherwise it's an inline stub.
> Also prints the banner from the single place.

What about:

arch/powerpc/mm/kasan/init_32.c:void __init kasan_init(void)
arch/powerpc/mm/kasan/init_book3e_64.c:void __init kasan_init(void)

Christophe



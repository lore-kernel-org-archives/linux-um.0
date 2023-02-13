Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD73DC636D4
	for <linux-um@archiver.kernel.org>; Mon, 13 Feb 2023 06:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=E3uwTawmoZDngmG/V0T+6TmkzsCELe29YUpXnYtKnjI=; b=Sz3oGBoNmHwGZa
	vviiwZwtsWzCQbfuuyAOJ7izDcPjyoQoUrsixeTkmG5jaMnYmAQuzkLIVFuxtD+bbPf5pSytOc9oi
	l42hkL5KENkRDaYvkpPS1+RhOccxnm5Hg1xVHVZUprEN2MumqFYUOCL2pim8Uu69BGtlJi5xAqdXQ
	xfC4iDFunzR0fTBbMUeeAeeoMZ4Y+bFDxT9JqhlTmxrI7p5aTV/A0IIVRlDcc5P7HJsWcR0P15AG2
	bqzVtEsJBE0c7Mol7mUvwu148z5pIuBliR/PFuGvWZ7BHEDSvqyqktaMAXi9Q0SttmRFtO8Okn8mz
	P5u9xctIz7UFEkBZ8xyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRST5-00DMQr-94; Mon, 13 Feb 2023 06:37:39 +0000
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRSSn-00DMNM-Fz; Mon, 13 Feb 2023 06:37:26 +0000
Received: by mail-oo1-xc29.google.com with SMTP id b10-20020a4a9fca000000b004e6f734c6b4so1099485oom.9;
        Sun, 12 Feb 2023 22:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=r+mD21wjZ7sbz4e4MxBS6xbK/1FhjAg9+awm6A789ww=;
        b=k6tlOEQZNhmHTa+ZCajRLjNoXOkqSfo4mR8OrWgNmaL2MKywaTjKPH0ulYH6V9boxY
         52UWHSIcC8rNsw1dQfTkq/COZKRQGSqbB6Kc2G15s3DFFoFMZdeK0fle1rX83pU7KJ4L
         ++BO1fcXWC7mjkIEb9evuvP+OSvCviMd3N1ZHNescW7Lpv6a0HL6BarepuSkif6zPqmJ
         C0miEzpiGke8zc2vSBRq5eRVJsUX8UcbybG0D55ni/6ICUXuIpztwVcd4DNb/6z3a9gS
         0Q6J9mDHSQbj/EfASGYAa6yP1HnW6//0d7Bxm++QcZv8+DAFF4S+17znkvYeLv4XlC8U
         Iyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r+mD21wjZ7sbz4e4MxBS6xbK/1FhjAg9+awm6A789ww=;
        b=Ef130xTIT7cChz3ge9c14NpOAHmWUU+atuVt+WtGEdhnC6/cgtDPWiZw63mhrVi1fg
         ZR6wPDi+PuRDTbgT3LhNO2OBx96UCqX+IMpbJedPx5zGVXVYmqHNc3Nw7AoX/dWueczP
         c7dj6HDW5Hhf+06VH+A+s+pcEvlJebTM/rcvZBG6M+3A2B//W1e3FQALbCg9L82CJ8Zu
         7OC/qVkpALm/V6CQ0Pomfyk291zhcqgvk1xVjyd7LNGcWfdC0FAlzS2JTj9vYGOcp0Cm
         S6yihczZLkBuw1/ZJtX8MLcooF6Y4qC7k/SyeT+ygvsAcJRz9NR16/vmnV2UQQbHclUf
         Vp0Q==
X-Gm-Message-State: AO0yUKU/Hsma2EgmzaKGlnihMq6yMA8oQcanNsfi9i35xPDggeiqRKNA
	hsn8h3bzrObAEmtSg0Poa7I=
X-Google-Smtp-Source: AK7set8CrGfl+FsDAT8ZOxZzNC5b1OZaQkksHfF8KDK4IpXQlQWLkqRaCxpy9jhC5xUjdOk1jrrITw==
X-Received: by 2002:a4a:d623:0:b0:512:2016:53e5 with SMTP id n3-20020a4ad623000000b00512201653e5mr12513885oon.6.1676270240292;
        Sun, 12 Feb 2023 22:37:20 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b15-20020a4ad88f000000b004fc4000ae48sm4528998oov.15.2023.02.12.22.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Feb 2023 22:37:19 -0800 (PST)
Message-ID: <15a2c023-fdfa-9543-ac36-a846e5f8a000@roeck-us.net>
Date: Sun, 12 Feb 2023 22:37:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 4/4] mm, arch: add generic implementation of
 pfn_valid() for FLATMEM
Content-Language: en-US
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Brian Cain <bcain@quicinc.com>, "David S. Miller" <davem@davemloft.net>,
 Dinh Nguyen <dinguyen@kernel.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Greg Ungerer <gerg@linux-m68k.org>,
 Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
 Huacai Chen <chenhuacai@kernel.org>, Matt Turner <mattst88@gmail.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michal Simek <monstr@monstr.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Rich Felker <dalias@libc.org>, Richard Weinberger <richard@nod.at>,
 Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Vineet Gupta <vgupta@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-alpha@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-mm@kvack.org, linux-parisc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
 linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
 loongarch@lists.linux.dev, openrisc@lists.librecores.org,
 sparclinux@vger.kernel.org, x86@kernel.org,
 Huacai Chen <chenhuacai@loongson.cn>
References: <20230129124235.209895-1-rppt@kernel.org>
 <20230129124235.209895-5-rppt@kernel.org>
 <20230212161320.GA3784076@roeck-us.net> <Y+mRz6Wfocopv9jw@kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <Y+mRz6Wfocopv9jw@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230212_223724_412259_3E1F2DC9 
X-CRM114-Status: GOOD (  18.55  )
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

On 2/12/23 17:26, Mike Rapoport wrote:
> On Sun, Feb 12, 2023 at 08:13:20AM -0800, Guenter Roeck wrote:
>> On Sun, Jan 29, 2023 at 02:42:35PM +0200, Mike Rapoport wrote:
>>> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>>>
>>> Every architecture that supports FLATMEM memory model defines its own
>>> version of pfn_valid() that essentially compares a pfn to max_mapnr.
>>>
>>> Use mips/powerpc version implemented as static inline as a generic
>>> implementation of pfn_valid() and drop its per-architecture definitions.
>>>
>>
>> With this patch in the tree, sh4 and sh4eb qemu emulations no longer boot.
>> Reverting this patch fixes the problem.
> 
> This should be a better fix than a revert:
> 
> diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
> index 506784702430..bf1b54055316 100644
> --- a/arch/sh/mm/init.c
> +++ b/arch/sh/mm/init.c
> @@ -301,6 +301,7 @@ void __init paging_init(void)
>   	 */
>   	max_low_pfn = max_pfn = memblock_end_of_DRAM() >> PAGE_SHIFT;
>   	min_low_pfn = __MEMORY_START >> PAGE_SHIFT;
> +	set_max_mapnr(max_low_pfn - min_low_pfn);
>   
>   	nodes_clear(node_online_map);
>   

Confirmed, this fixes the problem for me.

Thanks,
Guenter

>   
>> Guenter
>>
>> ---
>> # bad: [6ba8a227fd19d19779005fb66ad7562608e1df83] Add linux-next specific files for 20230210
>> # good: [4ec5183ec48656cec489c49f989c508b68b518e3] Linux 6.2-rc7
>> git bisect start 'HEAD' 'v6.2-rc7'
>> # good: [94613f0efc69ed41f9229ef5c294db3ec37145da] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
>> git bisect good 94613f0efc69ed41f9229ef5c294db3ec37145da
>> # good: [19e62c715fe70dae4582c2874ed3e66715d09af6] Merge branch 'rcu/next' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
>> git bisect good 19e62c715fe70dae4582c2874ed3e66715d09af6
>> # good: [5d8b7ecef7f4a681b6e5538db59ff26c389c0ab6] Merge branch 'for-next' of https://gitlab.com/peda-linux/mux.git
>> git bisect good 5d8b7ecef7f4a681b6e5538db59ff26c389c0ab6
>> # good: [c349bf6ec83903b20fe570c5609b9a864a64e09c] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git
>> git bisect good c349bf6ec83903b20fe570c5609b9a864a64e09c
>> # good: [5a06a9f17454df38f35672be522ff5eb9b4277d2] selftest: add testing unsharing and counting ksm zero page
>> git bisect good 5a06a9f17454df38f35672be522ff5eb9b4277d2
>> # bad: [f5d115a7b06e5661ed5218ffa9a2644c4ff1c135] Merge branch 'mm-nonmm-unstable' into mm-everything
>> git bisect bad f5d115a7b06e5661ed5218ffa9a2644c4ff1c135
>> # bad: [acb018d6ea0c055381fba7dddaef386ee28f8075] mm/vmalloc.c: allow vread() to read out vm_map_ram areas
>> git bisect bad acb018d6ea0c055381fba7dddaef386ee28f8075
>> # good: [1a5d9782ac969dc6e61c6786500b5160603188ea] mm/mmap: remove __vma_adjust()
>> git bisect good 1a5d9782ac969dc6e61c6786500b5160603188ea
>> # good: [4b32363697de957dcc890b6245bec3f58903639a] arm: include asm-generic/memory_model.h from page.h rather than memory.h
>> git bisect good 4b32363697de957dcc890b6245bec3f58903639a
>> # bad: [328cf3fa6682ce6a4de6f8bb8009c833dc33f3c8] mm/migrate: convert isolate_movable_page() to use folios
>> git bisect bad 328cf3fa6682ce6a4de6f8bb8009c833dc33f3c8
>> # bad: [b704c765b08cabe82adf76a4d1a74f3688eee410] mm/mempolicy: convert queue_pages_pmd() to queue_folios_pmd()
>> git bisect bad b704c765b08cabe82adf76a4d1a74f3688eee410
>> # bad: [e5734c8b0edfd2a053a5c256189586a3b1e9f63d] mm, arch: add generic implementation of pfn_valid() for FLATMEM
>> git bisect bad e5734c8b0edfd2a053a5c256189586a3b1e9f63d
>> # good: [ad8aecea034c591b9754bc5908da9719853aa7fa] mips: drop definition of pfn_valid() for DISCONTIGMEM
>> git bisect good ad8aecea034c591b9754bc5908da9719853aa7fa
>> # first bad commit: [e5734c8b0edfd2a053a5c256189586a3b1e9f63d] mm, arch: add generic implementation of pfn_valid() for FLATMEM
> 


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

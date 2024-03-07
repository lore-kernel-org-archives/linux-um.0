Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB6B4C48BF6
	for <linux-um@archiver.kernel.org>; Thu,  7 Mar 2024 14:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9Vrev7IgmUrXRDq+27lTQvP4S7JHkTqf6RpOH6wBrY8=; b=NjZrqiMT9ATV9trpPnHFTmV/s/
	3cKA/xjUQMtwkPKJa1lzyle+H3+hhflihAHj9OW/SoRMMcdZyQLRpQPc52AM3SYw+xjkHq0wI0dsA
	dLk0fuAuWKvaGgmWUSSWSD19kURgoe/BCLAocvKoKFn4lQimil9PcWQX3oWHmfuzCu4OPOz9OPsZg
	qMq9TIhjQJTV3YHDL6CG3Jby70Oh+vtOkRDnQKU13zZ/5ltAi461he+iCwITo25K1K1YoXYvW6fjL
	DaaWvPD3SkMonHRLKAY0WDfg3BayuxQSYcDka/IGxvvOE7cN0xwhaabLHN6AeDOpNpKWqdNXmvn/v
	GimO1o3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riEyD-000000056Mv-3YcU;
	Thu, 07 Mar 2024 14:43:41 +0000
Received: from smtp-out3.simply.com ([94.231.106.210])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riExz-000000056KJ-2Kzn;
	Thu, 07 Mar 2024 14:43:31 +0000
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4TrBqw0YTHz6871;
	Thu,  7 Mar 2024 15:43:24 +0100 (CET)
Received: from [192.168.0.25] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4TrBpz5w11z686W;
	Thu,  7 Mar 2024 15:42:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1709822603;
	bh=9Vrev7IgmUrXRDq+27lTQvP4S7JHkTqf6RpOH6wBrY8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cI0rJs/n2a5JovKEHh1TYmBzRxJ87Bt5Bk9Xi2ViHf6tqC5yT0pNhekjnIplLA6zG
	 +pFOMlnBFON+gaT+yppwquMwOHjqvX6GtdSnkG7oU1AsXu0gfEswgGVp6gSOiWhYfY
	 6DpsBN4xKX8XZflxM1403bFN0rq2D47eZSFJCk/Y=
Message-ID: <86cf6c72-e15a-4aa1-8c4b-499ec90a9a82@gaisler.com>
Date: Thu, 7 Mar 2024 15:42:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arch: define CONFIG_PAGE_SIZE_*KB on all
 architectures
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Kees Cook <keescook@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Matt Turner <mattst88@gmail.com>,
 Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>,
 Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Helge Deller
 <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Richard Weinberger <richard@nod.at>, x86@kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, Andy Lutomirski <luto@kernel.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
 Heiko Carstens <hca@linux.ibm.com>, Stafford Horne <shorne@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>
References: <20240306141453.3900574-1-arnd@kernel.org>
 <20240306141453.3900574-4-arnd@kernel.org>
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20240306141453.3900574-4-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_064329_713336_1AF777E3 
X-CRM114-Status: GOOD (  11.97  )
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

On 2024-03-06 15:14, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Most architectures only support a single hardcoded page size. In order
> to ensure that each one of these sets the corresponding Kconfig symbols,
> change over the PAGE_SHIFT definition to the common one and allow
> only the hardware page size to be selected.
> 
> Acked-by: Guo Ren <guoren@kernel.org>
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
> Acked-by: Stafford Horne <shorne@gmail.com>
> Acked-by: Johannes Berg <johannes@sipsolutions.net>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> No changes from v1

>  arch/sparc/Kconfig                 | 2 ++
>  arch/sparc/include/asm/page_32.h   | 2 +-
>  arch/sparc/include/asm/page_64.h   | 3 +--

Acked-by: Andreas Larsson <andreas@gaisler.com>

Thanks,
Andreas



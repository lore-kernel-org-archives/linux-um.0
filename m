Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E325C54798
	for <linux-um@archiver.kernel.org>; Tue, 27 Feb 2024 10:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Date:References:In-Reply-To:Message-Id:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ALe4jRIpXwGFVbo3YEKz32tiMZckplvn+7Agjim/VUs=; b=4QniVMEEkEpzT3ghJoQqVonfkG
	kp3PUFooElJ/vx5OzL0zFwAC/jyBT6KYd1VLZEG1HS9jmCg9QwRJwsDgcmO5yHPYq3p32q5HDirB5
	dGsq3ZpnPCxSPizJdiNOwX613NtMOks2UI1/6I85DAgzTsOpPIe7M9aJEn02UOVVxNP3MTL2ELyTB
	2P+mKE8xEWhz+ZLD+tTxJAtK3dQ4rROX2OMH2aCiLqYLB2ay5vD29XRPm9rrTvcRTC/S5pwbd6cXm
	akYbXL06tDvVXRykSVq64/Nqg1FO8cicE3noq5i1+l58WSvGE5ty2KmB2i8SnwIfaO0ShIR4twOR/
	3FscM/Ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1revBM-00000004rPD-0qcI;
	Tue, 27 Feb 2024 10:59:32 +0000
Received: from flow2-smtp.messagingengine.com ([103.168.172.137])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1revBH-00000004rO9-0xly;
	Tue, 27 Feb 2024 10:59:29 +0000
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailflow.nyi.internal (Postfix) with ESMTP id 78DBA200138;
	Tue, 27 Feb 2024 05:59:24 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 27 Feb 2024 05:59:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709031564; x=1709038764; bh=ALe4jRIpXw
	GFVbo3YEKz32tiMZckplvn+7Agjim/VUs=; b=KreeJwgJS47kfteNF0Atm9VoLT
	mRfGs//TxfpC0fFZ9SEmCaC2swxwVrdN/3Ir+9oF+fbHxOtydzs0GOj0O1ITDp51
	ZhOnnsY7S3TnCZ4KCQAKSLYiFfKjoPsBoAlA8dApodL0QZ6nRCISIYBeFh2ul3w/
	q59zfzcWezxy3DWuubch7g8lA2Drw5Ez0jYc9VWGFhZDa2LlhFdeHC7I+E7yatGM
	hJNcDmI6gI3Zx71w11VLK+zKbOxBUMm1nalGz6w7e9Wc1kc8YztPLUVQ8LkOyg65
	8WPuiETbWNlfqV0KEzh2qfROCbOq47LpMKoQbeNARU2PmuDi7KJ3PGB2mQlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709031564; x=1709038764; bh=ALe4jRIpXwGFVbo3YEKz32tiMZck
	plvn+7Agjim/VUs=; b=bBO3jySluCJ8iVd9SgGyaduu/7B7YWQLFiJ9Ps7xlapC
	2Lu1jhKLr4XQz6dXwNluypZlvD7ktNGmEBmDx+l/7yB8xrGle+W+vyms/K+FVKb6
	vfmssdRCf1wqieikEjJKlb4PL5URebMEeI7syXqZL8FtQxHCsQt7H3xzRq5ndzoQ
	oZYNOTsMDpvjTL6WgQqY2GdPhVBq45+29NWAcjyYpqxh67E2AyyZ323tgVUDvNzD
	j1qYSIwN2bTbtxvpO5Qnw5eDvGuNoreXZ4SGviyGwWwNwe24kyiKu1PnLoTqm6Hx
	IZfTtcsnJMRwsibpxr+rL7unENDS3lSef9Mi0eR4QA==
X-ME-Sender: <xms:isDdZafoyfIa2slvrGRb4QuGqlhK60arMii6iYL9riKPHpp4cGpkDg>
    <xme:isDdZUM16FrnZSoIWKFKjkea6vNGsbbxm1_XQpYP7hU7n55KtwCjU4HyZXe4xvGnR
    al4oJbACmXVdB8-sZs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeeggddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:isDdZbg33X-NA4Q4g8hs1l1s2knS3VeDh75_ybtft9UbLAD21da0lQ>
    <xmx:isDdZX91w2MZ5hgE7eH834qgzVQv9GUyFiDnpUSBzy5R9xSTy3NkLA>
    <xmx:isDdZWvlIMVHAGfyORa7V5l8neOSYMEy4LWAa7attify04IxVKQb6Q>
    <xmx:jMDdZVrJHSt9kALdLSyweF2DkUkEC1DI1fmVrfUCTkdSqb87F7HE81ozT4I>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 9822DB6008D; Tue, 27 Feb 2024 05:59:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
MIME-Version: 1.0
Message-Id: <164616c2-94f6-40e8-86e0-850dc8da212e@app.fastmail.com>
In-Reply-To: <CAMuHMdWRBQF95fJ+NkPUdvpu5VfRm2WyTnvdqB1Xe7d4vsvY2g@mail.gmail.com>
References: <20240226161414.2316610-1-arnd@kernel.org>
 <20240226161414.2316610-4-arnd@kernel.org>
 <CAMuHMdWRBQF95fJ+NkPUdvpu5VfRm2WyTnvdqB1Xe7d4vsvY2g@mail.gmail.com>
Date: Tue, 27 Feb 2024 11:59:01 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Thomas Gleixner" <tglx@linutronix.de>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 "Kees Cook" <keescook@chromium.org>,
 "Anna-Maria Gleixner" <anna-maria@linutronix.de>,
 "Matt Turner" <mattst88@gmail.com>, "Vineet Gupta" <vgupta@kernel.org>,
 "Russell King" <linux@armlinux.org.uk>,
 "Catalin Marinas" <catalin.marinas@arm.com>, guoren <guoren@kernel.org>,
 "Brian Cain" <bcain@quicinc.com>, "Huacai Chen" <chenhuacai@kernel.org>,
 "Michal Simek" <monstr@monstr.eu>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Helge Deller" <deller@gmx.de>, "Michael Ellerman" <mpe@ellerman.id.au>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "Richard Weinberger" <richard@nod.at>, x86@kernel.org,
 "Max Filippov" <jcmvbkbc@gmail.com>, "Andy Lutomirski" <luto@kernel.org>,
 "Jan Kiszka" <jan.kiszka@siemens.com>,
 "Kieran Bingham" <kbingham@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org
Subject: Re: [PATCH 3/4] arch: define CONFIG_PAGE_SIZE_*KB on all architectures
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240227_025928_013302_9C48422A 
X-CRM114-Status: GOOD (  14.46  )
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

On Tue, Feb 27, 2024, at 09:54, Geert Uytterhoeven wrote:
> Hi Arnd,
>> diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
>> index 9dcf245c9cbf..c777a129768a 100644
>> --- a/arch/m68k/Kconfig.cpu
>> +++ b/arch/m68k/Kconfig.cpu
>> @@ -30,6 +30,7 @@ config COLDFIRE
>>         select GENERIC_CSUM
>>         select GPIOLIB
>>         select HAVE_LEGACY_CLK
>> +       select HAVE_PAGE_SIZE_8KB if !MMU
>
> .... if you would drop the !MMU-dependency here.
>
>>
>>  endchoice
>>
>> @@ -45,6 +46,7 @@ config M68000
>>         select GENERIC_CSUM
>>         select CPU_NO_EFFICIENT_FFS
>>         select HAVE_ARCH_HASH
>> +       select HAVE_PAGE_SIZE_4KB
>
> Perhaps replace this by
>
>     config M68KCLASSIC
>             bool "Classic M68K CPU family support"
>             select HAVE_ARCH_PFN_VALID
>   +         select HAVE_PAGE_SIZE_4KB if !MMU
>
> so it covers all 680x0 CPUs without MMU?

I was a bit unsure about how to best do this since there
is not really a need for a fixed page size on nommu kernels,
whereas the three MMU configs clearly tie the page size to
the MMU rather than the platform.

There should be no reason for coldfire to have a different
page size from dragonball if neither of them actually uses
hardware pages, so one of them could be changed later.

Let me know if that makes sense to you, or you still
prefer me to change it like you suggested.

      Arnd


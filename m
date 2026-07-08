Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C9DC44501
	for <linux-um@archiver.kernel.org>; Wed,  8 Jul 2026 09:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mYG6WaG7m68VASwoH/Qbw0bAKXQeJJcttE2MKggz9kU=; b=20HeFFPJ8RxNS8Nx+QMixiv2BH
	isBV02ZdFQnb6XMf2v6xdCXxfXcJqJ4RuhcuaS4+F7yYc+qSc9jzIsn29+AUn+keG6gA50g4eDHvz
	51qsV2OBFifDdRU2U7tTjCw0r2naYLqtQ8T4qAzLhiw1plFoYytuTdhONd2OrvOp8TpkYX1sdJ/rU
	yxxDdRarUxkyXpIgm5qjHTuSRtm1UyuQeIaLddHyn8VnEocrGEc4ELoxiCnaWGf/fxsbxVj6VLhfK
	DyQvO0EwMuAoYXsagB657UdJkqokeS078bhYJZBBxqMrbL+3kvN1Ke91G/7Gyv+DefypRfiDPCzYJ
	m6A0Iinw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whOOM-0000000Gj8u-3Oj1;
	Wed, 08 Jul 2026 09:16:30 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whOOK-0000000Gj7f-3UxX;
	Wed, 08 Jul 2026 09:16:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5308240128;
	Wed,  8 Jul 2026 09:16:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F891F000E9;
	Wed,  8 Jul 2026 09:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783502188;
	bh=mYG6WaG7m68VASwoH/Qbw0bAKXQeJJcttE2MKggz9kU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=N1o7Cy/2UAb5pvDnsW2W/2IEWfzlvPb5qh6tUiAem8Gf2M7VhGzhZ/Y2Jx40amSta
	 eRYwR2//CYve1u4uzypgFTemTLGPafIx5fVQioLJD5Sn4hdfvpP5u4eZkeOM833ouq
	 3G+3Mlh8e7JmA5rStlaPedSdWHh/t+ELsZVQ0VNJ6mieO79DKlgD0lbLcCskpo8frt
	 Ek2lck3KWosiUBwUhmEc4sxs8Xn8DQLyVRoOsZlF1VniYeV+rnE4EXiJUggm2doJ5h
	 E24L6gP0rJ3vUHlKDAV+stjtsRYHo0Hqfr+yfpngxNIhAv4MFlNEU9teLXpTQ3Gqv7
	 Wt6aASI6cp48A==
From: Thomas Gleixner <tglx@kernel.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Michal =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>, Jonathan Corbet <corbet@lwn.net>, Arnd Bergmann
 <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Huacai Chen
 <chenhuacai@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Sven
 Schnelle <svens@linux.ibm.com>, linux-doc@vger.kernel.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, Kees Cook
 <kees@kernel.org>, x86@kernel.org, Jinjie Ruan <ruanjinjie@huawei.com>,
 Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Guo
 Ren <guoren@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Helge Deller <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger
 <richard@nod.at>, Chris Zankel <chris@zankel.net>,
 linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org, Vineet Gupta
 <vgupta@kernel.org>, Will Deacon <will@kernel.org>, Brian Cain
 <bcain@kernel.org>, Michal Simek <monstr@monstr.eu>, Dinh Nguyen
 <dinguyen@kernel.org>, "David S. Miller" <davem@davemloft.net>, Andreas
 Larsson <andreas@gaisler.com>, linux-snps-arc@lists.infradead.org,
 linux-hexagon@vger.kernel.org, linux-openrisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [patch 18/18] entry, treewide: Make
 syscall_enter_from_user_mode[_work]() indicate syscall execution
In-Reply-To: <5c202ab4-33f1-42e9-bef2-81fbd0a9992e@linux.ibm.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.603111179@kernel.org>
 <5c202ab4-33f1-42e9-bef2-81fbd0a9992e@linux.ibm.com>
Date: Wed, 08 Jul 2026 11:16:25 +0200
Message-ID: <87y0flrgd2.ffs@fw13>
MIME-Version: 1.0
Content-Type: text/plain
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

On Wed, Jul 08 2026 at 10:51, Shrikanth Hegde wrote:
> On 7/8/26 12:37 AM, Thomas Gleixner wrote:
>> -	r0 = syscall_enter_from_user_mode_randomize_stack(regs, r0);
>> +	if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, &r0))
>> +		return syscall_get_error(current, regs);
>>   
>
> There is one missing )

Bah.


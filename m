Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE3AC43602
	for <linux-um@archiver.kernel.org>; Wed,  8 Jul 2026 09:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QXKIkU3dsIb83LaNl9YeImi7A85K1dyuGPQma33N644=; b=s/Dy6mmOz1BF6gaxKbBsDeEQdn
	E0gH7LvkLb1ln1y0O1y5X0D20jdTHUFg2+sK2QWyagJe4KxC7SfCvXKhjjHXRoqFxi7PmKFh65D0q
	1eMb0adR4DuEfxW9mc+YTnMpZutQlQnfsS6cEsj9cKQ1nBPa6sOcsgLqQpu50ai4DElWjoeMS9y3h
	muED3VSqu+pI3+tZyr+2ROyF/D6m9f6xpkpeR8rWw0c12Q++PenU4uCkqklsBEOD8nkcVRVNcqP4M
	oQlT//Q8GyQIj/vZcU80A6iaqDWZFfsK6HHmWK3vJcYw/nRdnBFuQQQlHvVfbBzNAP5qmo7CBC4xd
	QKmZYZBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whONB-0000000GiuA-1OaT;
	Wed, 08 Jul 2026 09:15:17 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whON8-0000000GitZ-1Ak3;
	Wed, 08 Jul 2026 09:15:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DC95A40128;
	Wed,  8 Jul 2026 09:15:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D697D1F00A3A;
	Wed,  8 Jul 2026 09:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783502113;
	bh=QXKIkU3dsIb83LaNl9YeImi7A85K1dyuGPQma33N644=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=DFMxLuEi7KbiLxKOKr7+5tYyHQCk3JpHfb6tuRzE2WRkuMx1mPUf9jIugzEHb8/5x
	 LO8Xyowg5mKltHMmbDOr+gi5tZvNMk+K5CLlhuwiVeBNQv3EKRcMCXRbA9wKg3qjXN
	 yktK4sMH/4XosacPFHJ3cmJotsn19Buu9FUV++AMzk2yr3c1ztSf7A6xr+F2FPufYH
	 7C4ovIQAnZoRC6G/Qa1C+7b0RWd5ohzlBHkaLFo1vS55Av8D6fJzCv3nFP2MI70JYw
	 B1ItdudtjTbPFz/5q4TbBg2sVxB0g3L5dtrLprFMkBcrpN5g+UQIf8TbjYMP31tAm2
	 nw7+qD9T59MIw==
From: Thomas Gleixner <tglx@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Mark Rutland
 <mark.rutland@arm.com>, Kees Cook <kees@kernel.org>, Andy Lutomirski
 <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Russell King <linux@armlinux.org.uk>,
 Catalin
 Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, Helge Deller <deller@gmx.de>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Richard Weinberger <richard@nod.at>, Chris
 Zankel <chris@zankel.net>, linux-arm-kernel@lists.infradead.org,
 linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org, Michael Ellerman <mpe@ellerman.id.au>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org, Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>, Brian
 Cain <bcain@kernel.org>, Michal Simek <monstr@monstr.eu>, Dinh Nguyen
 <dinguyen@kernel.org>, "David S. Miller" <davem@davemloft.net>, Andreas
 Larsson <andreas@gaisler.com>, linux-snps-arc@lists.infradead.org,
 linux-hexagon@vger.kernel.org, linux-openrisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, Michal
 =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org
Subject: Re: [patch 11/18] seccomp, treewide: Rename and convert
 __secure_computing() to return boolean
In-Reply-To: <2e6ed364-ce8f-4b4b-8675-acd07f140f4f@huawei.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.230735780@kernel.org>
 <2e6ed364-ce8f-4b4b-8675-acd07f140f4f@huawei.com>
Date: Wed, 08 Jul 2026 11:15:10 +0200
Message-ID: <871pddsuzl.ffs@fw13>
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

On Wed, Jul 08 2026 at 09:43, Jinjie Ruan wrote:
> On 7/8/2026 3:06 AM, Thomas Gleixner wrote:
> As Ada pointed out, the description of secure_computing in arch/Kconfig
> need to be updated, a possible suggestion:
>
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -636,8 +636,8 @@ config HAVE_ARCH_SECCOMP_FILTER
>           - syscall_rollback()
>           - syscall_set_return_value()
>           - SIGSYS siginfo_t support
> -         - secure_computing is called from a ptrace_event()-safe context
> -         - secure_computing return value is checked and a return value
> of -1
> +         - seccomp_permits_syscall is called from a ptrace_event()-safe
> context
> +         - seccomp_permits_syscall return value is checked and if false

Makes sense.
>>  		if (__seccomp_filter(this_syscall, true))
>> -			return -1;
>> +			return false;
>
> The return value of __seccomp_filter is checked in the wrong way, check
> -1 should be replaced with check false, maybe:
>
> -               if (__seccomp_filter(this_syscall, true))
> -                       return -1;
> +               if (!__seccomp_filter(this_syscall, true))
> +                       return false;

Ooops.


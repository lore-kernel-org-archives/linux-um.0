Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA332C61DCB
	for <linux-um@archiver.kernel.org>; Sat, 29 Aug 2026 21:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dtc/3TiWrxvKp0avjjHTAnH0zP9eaKC6iJzs8wdLbVc=; b=C744V7iUaoa4bhFg2FIf268Ew/
	JVbBnVnq5By21RUuXbk1J+tAGtVEXuSdajRAJQgl8pTx2VIVi1AiV5xDgutY2KxM0U+d50CdYm3Pg
	AlfDdLndtqt0x9BXijlPVBMhvvFsrCgjTg9nHYtDknqoRLzWgPWrQ0k1jWkK1WqELjJfvrtvahY6P
	JCaZMlNKO2szALjZhWSBfYkn6g2gqnDZIQ6vyzIBP+3dqBF0FtA+r8/o6VSaOl/IxcWAnc73NFC1v
	9hDTzNME2BjbmeKVQPGEwv7v9WETj0qvvXBo3TzTnOU1d6Av9cUm31LP6YjlNfgSH7QbuA0i52BFr
	GiM/1htg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0QM8-00000007Kbf-2TOv;
	Sat, 29 Aug 2026 21:12:52 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0QM7-00000007KbG-0Tmx;
	Sat, 29 Aug 2026 21:12:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2C70F42D83;
	Sat, 29 Aug 2026 21:12:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649AD1F000E9;
	Sat, 29 Aug 2026 21:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788037970;
	bh=Dtc/3TiWrxvKp0avjjHTAnH0zP9eaKC6iJzs8wdLbVc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=n1seToYoBBT3aH6XYy57AvAYoTN8Sa1DDhmW2pGm9sBs8rkBWyAhcowrHekDBroX/
	 LQ9shz0t6AxoS/RQDPShfDSc0m9IWLcU9cIQJq3FkW1jzrInW5+Iv/KAuW8URYVB2n
	 2vCrp2pcnJfrchIq4fTPd7v9FJeK1MDe0dV9wrUv3zK9IWSwAUoaPxvg0yAGixhM4c
	 Z9dwi/DUpv4kJC8uG3byshQrVjTrnzKYKROHUXMRnPyH/qBRKuo9hNfxOcn7FEeewO
	 jvzQ+uh7MKEZRseKSgUEU40CtjsBO3Ee/xgR+WN5+SACHRv8m1z/ulKCStwZ7OqVFK
	 esh+04RW4xs+A==
From: Thomas Gleixner <tglx@kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, Huacai Chen
 <chenhuacai@kernel.org>, loongarch@lists.linux.dev, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org, Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org, x86@kernel.org, Mark Rutland
 <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, Andy
 Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Guo
 Ren <guoren@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Helge Deller <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger
 <richard@nod.at>, Chris Zankel <chris@zankel.net>,
 linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-m68k@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org, Arnd Bergmann
 <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Will Deacon
 <will@kernel.org>, Brian Cain <bcain@kernel.org>, Michal Simek
 <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
 linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, Michal =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [patch 03/18] entry: Provide
 [syscall_]enter_from_user_mode_randomize_stack()
In-Reply-To: <995a61ef-ce8c-4c8b-bea8-77f375076a39@zytor.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190253.816918647@kernel.org>
 <995a61ef-ce8c-4c8b-bea8-77f375076a39@zytor.com>
Date: Sat, 29 Aug 2026 23:12:47 +0200
Message-ID: <87bjakeils.ffs@fw13>
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

On Thu, Aug 27 2026 at 15:46, H. Peter Anvin wrote:
> Can anyone *please* find out what the actual security requirements are for the
> syscall randomization offset?
>
> The original checkin, 39218ff4c625 ("stack: Optionally randomize kernel stack
> offset each syscall") indicates that it is fundamental that the stack offset
> is applied *after* pt_regs pushing, but that isn't documented anywhere in the
> kernel sources as far as I can tell.

> However, I have also come to understand that there are further, undocumented
> constraints; at least at one point I was told that "the offset should not be
> stored in memory while running in the kernel", which seems more than a bit odd.

This thread has the initial discussions about it with more explanations:

  https://lore.kernel.org/kernel-hardening/2236FBA76BA1254E88B949DDB74E612BA4BC57C1@IRSMSX102.ger.corp.intel.com/

Thanks,

        tglx


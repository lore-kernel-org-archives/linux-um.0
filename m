Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F509C87FCF
	for <linux-um@archiver.kernel.org>; Sun, 10 Aug 2025 21:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wwun8C53OEKLGsw85SfB6sZsEhws/7mYqqzX9Lv5cF8=; b=Lt69Pe+Fg3NTWrcVQeZD73L935
	DXn+hzrFvDguqgja9oq40VXmwfA6lFz9uMPl1OyD9Vc2uvQyz7e89UMRtiUxFKm7KGXqnK0iMUvFj
	LLztsgNsgySP3m/r96hkurneSHiDt3iAE0OR0YQK8z4j/Xis4cJneJnhUj/erDNTZ3r/NRiRvN80g
	sOexS+yY9FljBuqFyFQ0bPhWZr8H3pde5HBdhg80IwZnojMVcCPkgjFg6GeW0K+6Klhucq5zc5Kka
	CfdHlh8jgMynRn3BPbMWGec/JWCjUjVEQxaU2uejat0CoNf2sPcwNBPJhBYV616m//VmgcqkyKQ6V
	jIxdO9YA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulDmx-000000063TD-2jVi;
	Sun, 10 Aug 2025 21:41:11 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulDLE-00000005zmd-1ze8;
	Sun, 10 Aug 2025 21:12:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id B3E0DA568E7;
	Sun, 10 Aug 2025 21:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B60AC4CEEB;
	Sun, 10 Aug 2025 21:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754860351;
	bh=+EPDIqigYF0dLwDVKm4n7P07Soa8UCdwgsSbIhQglhg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PRWX9qbyv9u6FbnKrFjePyfsaZ737MOhr4mO7TsZ7R+GzU8zlYvZAYf8JD/OXtEUT
	 hA9ZGe4MgMB70B1Zw0njMIw4A2/fhOmu8/xlsiHxmIUZJvNyZW6a8uiunB9JTjc62k
	 WQvCcnsGvL3edUrU5mU3msfwtOhFXOborJRekZFipn3fdTQKLp1K+FdaZrtWvHMoCG
	 BjGMfqHcgkkIzLtrpEo6cyj4t26pG93hr2845rzETZe270MpglUmq+wxcG1OLi+DB/
	 81Kg/BR1SiRTfzYt5r1OrTvGUw8lrqFdyiU9Eqy8LtRG2Wu0knKnUQq5VbApAR7XFV
	 wpBAVMLGZQIKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BB739D0C2B;
	Sun, 10 Aug 2025 21:12:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 00/23] binfmt_elf,arch/*: Use elf.h for coredump note
 names
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: <175486036374.1221929.319441619761028585.git-patchwork-notify@kernel.org>
Date: Sun, 10 Aug 2025 21:12:43 +0000
References: <20250701135616.29630-1-Dave.Martin@arm.com>
In-Reply-To: <20250701135616.29630-1-Dave.Martin@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, hpa@zytor.com, James.Bottomley@HansenPartnership.com,
 akihiko.odaki@daynix.com, aou@eecs.berkeley.edu, agordeev@linux.ibm.com,
 alex@ghiti.fr, andreas@gaisler.com, anton.ivanov@cambridgegreys.com,
 bp@alien8.de, bcain@kernel.org, catalin.marinas@arm.com, chris@zankel.net,
 borntraeger@linux.ibm.com, christophe.leroy@csgroup.eu,
 dave.hansen@linux.intel.com, dinguyen@kernel.org, geert@linux-m68k.org,
 guoren@kernel.org, hca@linux.ibm.com, deller@gmx.de, chenhuacai@kernel.org,
 mingo@redhat.com, johannes@sipsolutions.net, glaubitz@physik.fu-berlin.de,
 jonas@southpole.se, kees@kernel.org, maddy@linux.ibm.com, jcmvbkbc@gmail.com,
 mpe@ellerman.id.au, npiggin@gmail.com, oleg@redhat.com, palmer@dabbelt.com,
 paul.walmsley@sifive.com, dalias@libc.org, richard@nod.at,
 linux@armlinux.org.uk, shorne@gmail.com, stefan.kristiansson@saunalahti.fi,
 svens@linux.ibm.com, tsbogend@alpha.franken.de, tglx@linutronix.de,
 gor@linux.ibm.com, vgupta@kernel.org, kernel@xen0n.name, will@kernel.org,
 ysato@users.sourceforge.jp, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-um@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 loongarch@lists.linux.dev, sparclinux@vger.kernel.org, x86@kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250810_141232_640362_3F48BAFF 
X-CRM114-Status: GOOD (  10.66  )
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

Hello:

This patch was applied to riscv/linux.git (fixes)
by Kees Cook <kees@kernel.org>:

On Tue,  1 Jul 2025 14:55:53 +0100 you wrote:
> This series aims to clean up an aspect of coredump generation:
> 
> ELF coredumps contain a set of notes describing the state of machine
> registers and other information about the dumped process.
> 
> Notes are identified by a numeric identifier n_type and a "name"
> string, although this terminology is somewhat misleading.  Officially,
> the "name" of a note is really an "originator" or namespace identifier
> that indicates how to interpret n_type [1], although in practice it is
> often used more loosely.
> 
> [...]

Here is the summary with links:
  - [16/23] riscv: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
    https://git.kernel.org/riscv/c/c9502cc7bef5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




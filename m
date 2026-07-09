Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE1CC44506
	for <linux-um@archiver.kernel.org>; Thu,  9 Jul 2026 16:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PVNPrFU1PGB9ZkQlUfz3ePnrtlBWmUW1vci7gbMc020=; b=0z+k6ZLwuStxoB2hdSCHG12i74
	+g1Q28j1JboxUq3I7xEV8WpNENJZjoDIKPhxqecP4oq07AIJQgIL/x3DDSKPjD+DBbaKCzb/aIlnX
	R7c3QsOjl8zY46qM9Wb4Pn4ZmV71vJDgjQWHfCi0y4XtZXYYS1KYuqL8IzWlUijf9sfvTPRKRQZUR
	aLRv2g31AZn8VU6ED9UfqMsRNDCGk7Cc2VwzmbPsaew3NNgC8wmXLU5IT8pGTV97rXMNSm75SQ5eF
	icmtBVtmgUhQPlQyXaenq4JxWXILLzQwj/Qljuo13DqbOO66RaL+hoHSaWNacqkHrZ29gyqYo9krw
	1oGoPYlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whrXT-0000000321R-1UOm;
	Thu, 09 Jul 2026 16:23:51 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whrXQ-000000031zu-3R3W;
	Thu, 09 Jul 2026 16:23:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 16346405C4;
	Thu,  9 Jul 2026 16:23:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F271F00A3A;
	Thu,  9 Jul 2026 16:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783614228;
	bh=PVNPrFU1PGB9ZkQlUfz3ePnrtlBWmUW1vci7gbMc020=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dEsGFvG0entc+CRLpmVOaUBCJG4D03DxA7ZPHMA+0bz+ArzFZ4oZ25h3XsZAVyxRR
	 x10/LoE7lElTzHD06XWpE2m6rYMtKRUGebUhQapIBfB+ep4fG37Ng0RaVsx6GdmjM4
	 W83GkVnhwTOjct2PRlsvXAgfF8WsuxadhgjUrZKIFxbiAgM07wgLkRHLtXBID76WXL
	 vXpw2i5GZ2AEQYDFtIGxLdWwAY7AsLhILvFuoodFrluXUPHF4msNedMhyKYrHXoB8T
	 JJj34DTu2/8Sq2sDLaSW1Xi2u/2ZNgMk1vZ51THvkxDDB/2K6ZsmwZ7UkwuT1KfO4D
	 Hq6xN5eyBwNEw==
Date: Thu, 9 Jul 2026 09:23:47 -0700
From: Kees Cook <kees@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Huacai Chen <chenhuacai@kernel.org>,
	loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Guo Ren <guoren@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Helge Deller <deller@gmx.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Richard Weinberger <richard@nod.at>,
	Chris Zankel <chris@zankel.net>,
	linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
	linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>,
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
	linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [patch 02/18] randomize_kstack: Provide
 add_random_kstack_offset_irqsoff()
Message-ID: <202607090922.4ECAE32C07@keescook>
References: <20260707181957.433213175@kernel.org>
 <20260707190253.768842729@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707190253.768842729@kernel.org>
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

On Tue, Jul 07, 2026 at 09:06:02PM +0200, Thomas Gleixner wrote:
> add_random_kstack_offset() uses get/put_cpu_var() which is pointless
> overhead when it is invoked from low level entry code with interrupts
> disabled.
> 
> Provide a irqsoff() variant, which avoids that.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>

Seems good. I don't think macro'izing the interior is worth it since
both cases are very short, with only the lockdep and raw bits changed.

Reviewed-by: Kees Cook <kees@kernel.org>

-Kees

-- 
Kees Cook


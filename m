Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF42D3C92D
	for <linux-um@archiver.kernel.org>; Sat, 19 Oct 2024 22:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7zUTFOALmvJecWb9wB6YiXPzPNuTlzsgzqq4AD+I6Bk=; b=YO8W3D5DcxtRpiNGwG4dxPmYEk
	PRGaByAsbmcN540Tokvl6bUYH2MJmnoLpBbYbTqqMES303o6llvoBnbY3kKJ2lWObHv7II2uIEUj/
	gtoeOiuTxp3a0EePXw/fmPZoIszNsRvjxUt45aFFHBnzH5m9tocie5XnwZR8ERUDIPdY6o82LwDJX
	Isq3613nb9UNIT6DsMdZBwPEqIAS1oh+gjlZvzEWFJvK/rPEHKxFN5n+C0clM8/Pw38Ca9sj0FA7V
	QS7xPm6svgjGeMBF5k16042X+xiX8SLsV2BY/VZ6QzbRzV7LS+bB1RS54DrANINYp95Ph3QhvyhnV
	XHCYHDqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2IIh-000000043IV-0fQG;
	Sat, 19 Oct 2024 22:51:59 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2IIe-000000043HA-3Nr1;
	Sat, 19 Oct 2024 22:51:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7zUTFOALmvJecWb9wB6YiXPzPNuTlzsgzqq4AD+I6Bk=; b=Zs7HVgr75quueuGjRc4nNKtmO2
	PMvYeEylscL8oHTKxFrHLXoFgTXro9jh4CFsWa2tYPf4Pb1DWlGt/8n3EEoJC8NJDt4vssaj4NG4E
	5uA4EZrVYTndKnsdA+LPmUVYEBKBT893zZxojkcQy0kdfwmAh1WC47hsx3xjXpBx5ed1LlRVsZeUI
	SzYXcFmbdfGV0TDiF9J8KS/F757N0aHrzZnJIrFIKvs16p8xM5D4ET2be+GhJaRon0tGcaJcRpm2C
	2GClzYkbAMth7jIx0wyrQqiXGgUQa7Dofc/LlIp7yonhkr83QkraPsgjrafEJTR8lqafweGPchG2G
	qFbJkOKA==;
Received: from dfw.source.kernel.org ([139.178.84.217])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2IIa-00000007bbK-3NkU;
	Sat, 19 Oct 2024 22:51:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D5BAF5C1627;
	Sat, 19 Oct 2024 22:51:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A509C4CEC5;
	Sat, 19 Oct 2024 22:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729378307;
	bh=iaKyJYsgDj5oq6LrolQ8TT/cIGmsXYFI9lXbWUpr55Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PWWcwFHRKAv10UFeMWidR+oArwiG2+r721GO7uSmTpQx0pOBJf1X5cPUKD4gQg0+v
	 evgCS5YusRtKfCXFwytoJRX7ZRENJRAMHCt8HvG03nMPWzjaJDvjdrgLKvwNx81i5w
	 NIzDOiB7M0V+Ul7Gwqxo7hFP4wjCIx8CdeY/s0mZyLShSAGZB3TOEh3ca9PA+vMo3W
	 q8+DRfeiSbEMT2pfBoZx2+ts1c/ZoMbSDOpbvF1L4SRM4K2S0rC8EknH09OaDU5jzH
	 5NBzulTpDRDsAwrp/w7GYCrOs4CtagANrNUd5w9SX4IoQrxyUxMdI/Mnop054oa6hH
	 EFlkfWan9WOpw==
Date: Sat, 19 Oct 2024 15:51:43 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v6 0/8] x86/module: use large ROX pages for text
 allocations
Message-ID: <ZxQ3_8xNPYsQA5GH@bombadil.infradead.org>
References: <20241016122424.1655560-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016122424.1655560-1-rppt@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241019_235153_268877_C99B02A0 
X-CRM114-Status: GOOD (  12.02  )
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

On Wed, Oct 16, 2024 at 03:24:16PM +0300, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Hi,
> 
> This is an updated version of execmem ROX caches.
> 
> Andrew, Luis, there is a conflict with Suren's "page allocation tag
> compression" patches:
> 
> https://lore.kernel.org/all/20241014203646.1952505-1-surenb@google.com
> 
> Probably taking this via mmotm would be more convenient.

Yeah, it's already there on Andrew's tree, fine with me to go through there.

The linux modules KPD [0] has picked this up from the mailing list and
tested with kdevops, and this series passes our modules test now [1], and so:

Tested-by: kdevops <kdevops@lists.linux.dev> [1]

Link https://github.com/linux-kdevops/linux-modules-kpd/actions/runs/11420097546 # [0]

  Luis


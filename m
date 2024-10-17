Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C372AD374AF
	for <linux-um@archiver.kernel.org>; Thu, 17 Oct 2024 15:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c8uvdJJtMhQM0BlLRDZIrk4gS9WA0Ztt7+5eIGzcjpA=; b=Tgb5QWfArlp5TyOv48/SZ+1RQp
	P73kbyxiuiZhZB3DzTsbMMjMeczR3jznzN/1lxiuJTNpO5ZzcNQ55Bzdkeud7v2zdYkEo+MBqV/HG
	LFWFdmvlJwZusZvcFAgUblRb337ud6sMf81lrtj3MfwzMpq8tFgqKVesoEHcKoSRCB8bWhRPODVul
	XAY61tZCCXc+94qrqwDeHs0T/XIUwlaICWbw6/yO2aL505y9Jv2evGDnOjGmxqbojF3yBRiPcaBDD
	R3oLA5S/PlDPi7L+nz+P0aKDPpLzmVW+XmP5AnPyA7cSFsxnlEosRQIcQezPOSd9ZW2s+pspopyaI
	xkYmJDkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1SZE-0000000FJNr-3ZJc;
	Thu, 17 Oct 2024 15:37:36 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1SWV-0000000FIUq-0Grn;
	Thu, 17 Oct 2024 15:34:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 492E1A4412A;
	Thu, 17 Oct 2024 15:34:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1027DC4CECD;
	Thu, 17 Oct 2024 15:34:38 +0000 (UTC)
Date: Thu, 17 Oct 2024 11:35:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Andrew Morton
 <akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, Andreas
 Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, Ard
 Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav
 Petkov <bp@alien8.de>, Brian Cain <bcain@quicinc.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Christoph Hellwig <hch@infradead.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Dave Hansen
 <dave.hansen@linux.intel.com>, Dinh Nguyen <dinguyen@kernel.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>, Helge
 Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Kent Overstreet
 <kent.overstreet@linux.dev>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Matt Turner <mattst88@gmail.com>, Max Filippov
 <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek
 <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Richard Weinberger <richard@nod.at>, Russell King
 <linux@armlinux.org.uk>, Song Liu <song@kernel.org>, Stafford Horne
 <shorne@gmail.com>, Suren Baghdasaryan <surenb@google.com>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner
 <tglx@linutronix.de>, Uladzislau Rezki <urezki@gmail.com>, Vineet Gupta
 <vgupta@kernel.org>, Will Deacon <will@kernel.org>, bpf@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
 linux-um@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 loongarch@lists.linux.dev, sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v6 6/8] x86/module: prepare module loading for ROX
 allocations of text
Message-ID: <20241017113453.685ba175@gandalf.local.home>
In-Reply-To: <ZxD0EVBoO-jcxEGE@kernel.org>
References: <20241016122424.1655560-1-rppt@kernel.org>
	<20241016122424.1655560-7-rppt@kernel.org>
	<20241016170128.7afeb8b0@gandalf.local.home>
	<20241017093515.GU16066@noisy.programming.kicks-ass.net>
	<ZxD0EVBoO-jcxEGE@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_083447_209290_5B2C1B9F 
X-CRM114-Status: GOOD (  13.90  )
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

On Thu, 17 Oct 2024 14:25:05 +0300
Mike Rapoport <rppt@kernel.org> wrote:

> With this series the module text is allocated as ROX at the first place, so
> the modifications ftrace does to module text have to either use text poking
> even before complete_formation() or deal with a writable copy like I did
> for relocations and alternatives.
> 
> I've been carrying the ftrace changes from a very old prototype and
> didn't pay enough attention to them them until Steve's complaint.
> 
> I'll look into it.

I just posted a patch where you can see the effects of these changes with
respect to ftrace patching times.

  https://lore.kernel.org/all/20241017113105.1edfa943@gandalf.local.home/

I'll be adding this to the next merge window.

-- Steve


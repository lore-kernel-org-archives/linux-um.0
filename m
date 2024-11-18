Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D8BD591AD
	for <linux-um@archiver.kernel.org>; Mon, 18 Nov 2024 18:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zk38Xe/iH95eayJVebT/nkAzanSuabbOIFGgWA1qSMc=; b=MCZTktcX4+EwVtJMZ93SGU7yl1
	gUPO3Mtl6dFshhEN4ovCSq00j6jPvyRfaq9qy/C8ED0KHwXmmcIX5YTF4zMypieu8NNhio0IREudD
	JvLnqrJa9+PBgpom5qz3lJcKZ2taEqQWLHrVfRbtshzf8BfjMUUovzGIHIujQ0pl48IabxO4GwRXq
	BiVerA1nsjAnanrsANTg246V7g4/pL+GbGz+Kjgse2TCA57XHJJI0koykSNB+HTV7oqCbO+VcdGfe
	xiMT/XaU71wgSc33y5vFSSIvPSnP2GDWWlZW8tHWMN0obUreBsSdycbeLTBd3/FU4u0tEYMOAhhkx
	gBEdYVyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tD6QW-0000000AKc1-1wG4;
	Mon, 18 Nov 2024 18:24:44 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tD6QS-0000000AKZu-491T;
	Mon, 18 Nov 2024 18:24:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 293C15C54CA;
	Mon, 18 Nov 2024 18:23:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4F3C4CECC;
	Mon, 18 Nov 2024 18:24:30 +0000 (UTC)
Date: Mon, 18 Nov 2024 13:25:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Luis Chamberlain
 <mcgrof@kernel.org>, Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski
 <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Brian Cain
 <bcain@quicinc.com>, Catalin Marinas <catalin.marinas@arm.com>, Christoph
 Hellwig <hch@infradead.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Dave Hansen <dave.hansen@linux.intel.com>,
 Dinh Nguyen <dinguyen@kernel.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>, Helge Deller
 <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Kent Overstreet
 <kent.overstreet@linux.dev>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Matt Turner <mattst88@gmail.com>, Max Filippov
 <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek
 <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Peter Zijlstra <peterz@infradead.org>, Richard
 Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Song Liu
 <song@kernel.org>, Stafford Horne <shorne@gmail.com>, Suren Baghdasaryan
 <surenb@google.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Thomas Gleixner <tglx@linutronix.de>, Uladzislau Rezki <urezki@gmail.com>,
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
Subject: Re: [PATCH v7 0/8] x86/module: use large ROX pages for text
 allocations
Message-ID: <20241118132501.4eddb46c@gandalf.local.home>
In-Reply-To: <20241023162711.2579610-1-rppt@kernel.org>
References: <20241023162711.2579610-1-rppt@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241118_102441_061636_DD0F8811 
X-CRM114-Status: GOOD (  12.87  )
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

On Wed, 23 Oct 2024 19:27:03 +0300
Mike Rapoport <rppt@kernel.org> wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Hi,
> 
> This is an updated version of execmem ROX caches.
> 

FYI, I booted a kernel before and after applying these patches with my
change:

  https://lore.kernel.org/20241017113105.1edfa943@gandalf.local.home

Before these patches:

 # cat /sys/kernel/tracing/dyn_ftrace_total_info
57695 pages:231 groups: 9
ftrace boot update time = 14733459 (ns)
ftrace module total update time = 449016 (ns)

After:

 # cat /sys/kernel/tracing/dyn_ftrace_total_info
57708 pages:231 groups: 9
ftrace boot update time = 47195374 (ns)
ftrace module total update time = 592080 (ns)

Which caused boot time to slowdown by over 30ms. That may not seem like
much, but we are very concerned about boot time and are fighting every ms
we can get.

-- Steve


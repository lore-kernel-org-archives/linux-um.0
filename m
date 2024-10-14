Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F0C4D18144
	for <linux-um@archiver.kernel.org>; Mon, 14 Oct 2024 20:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qj93O1JIO0dJGWm+S+jc//U0Xrz7rDNTjeJUxiHmdlM=; b=y6otE1ttbfPRP98zxYnlNDQpCy
	anLNt/G3DNOWBpOLiQfSrvc4FVH7tl0AZATjkquzZIfGIJTI5o4+yF9EtHuWcUzUVcFtjZ3wMCvyk
	rHrXr4n4KlbX9UDAUw8ODUd57YLiE7BtbY3k8bE6Pf5jL95dU90HzegXB3L6Djq2gDSaUhJMRBCWq
	o4kewv7x0k5xqasDUleZOQu+4zI/2LcUW+9+qIE2VShT1AdEQqEik+cBUvlZOAfalLvBFJ6HHfzL7
	+kCQH0GIzDDJhZIcKxk56ZmYDf19gR/CafCMcPuZrOoUCJWERmHRoWNQ4Fm5HGJetx/AI81PF5I+C
	E76SH2yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0Ri0-00000006OP1-1YoY;
	Mon, 14 Oct 2024 20:30:28 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0QYL-00000006Gsx-3bMD;
	Mon, 14 Oct 2024 19:16:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 3E184A4271A;
	Mon, 14 Oct 2024 19:16:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC60C4CEC3;
	Mon, 14 Oct 2024 19:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728933383;
	bh=UuppSLaM0kOzMrDSh2RloHR9IgCcKKb57FBSLEkEUWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EjG/5WZADaXhvwARHnqKg67eiuXX7gTWxPoitBNELLTxxDNviuMSsmlu/en6P6ED8
	 zpJ52uHjqiz/g2IcIGwuziTngHnAXDzicRERzVAAIDP4l2L6y33KAuyIagMcpMXzl4
	 9dBRK2tjgLlrX3Ons9R5vBST3i3yiewblKFLfAI64WB5+23Fn5KkJljDLeTWRKDZ84
	 jnexNcW9vYFK3px9crwCiVYgH/8ctiyb/DdHjxU96pqWdOL1lwHrwqpz6qzLtvvsU8
	 7pmIeyrMmskmV1mcXKss65BVVX6VBxafQdYx2gdNsA2KwzhcBEiTj2VcG0YSmjPMmN
	 oCmkdGtrERExg==
Date: Mon, 14 Oct 2024 12:16:20 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Mike Rapoport <rppt@kernel.org>, Christoph Hellwig <hch@infradead.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
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
Subject: Re: [PATCH v5 7/8] execmem: add support for cache of large ROX pages
Message-ID: <Zw1uBBcG-jAgxF_t@bombadil.infradead.org>
References: <20241009180816.83591-1-rppt@kernel.org>
 <20241009180816.83591-8-rppt@kernel.org>
 <Zwd7GRyBtCwiAv1v@infradead.org>
 <ZwfPPZrxHzQgYfx7@kernel.org>
 <ZwjXz0dz-RldVNx0@infradead.org>
 <ZwuIPZkjX0CfzhjS@kernel.org>
 <20241013202626.81f430a16750af0d2f40d683@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241013202626.81f430a16750af0d2f40d683@linux-foundation.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_121626_053486_1D01AF4B 
X-CRM114-Status: GOOD (  13.79  )
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

On Sun, Oct 13, 2024 at 08:26:26PM -0700, Andrew Morton wrote:
> On Sun, 13 Oct 2024 11:43:41 +0300 Mike Rapoport <rppt@kernel.org> wrote:
> 
> > > > The idea is to keep everything together and have execmem_info describe all
> > > > that architecture needs. 
> > > 
> > > But why?  That's pretty different from our normal style of arch hooks,
> > > and introduces an indirect call in a security sensitive area.
> > 
> > Will change to __weak hook. 
> > 
> 
> Thanks, I'll drop the v1 series;
> 
> The todos which I collected are:
> 
> https://lkml.kernel.org/r/CAPhsuW66etfdU3Fvk0KsELXcgWD6_TkBFjJ-BTHQu5OejDsP2w@mail.gmail.com
> https://lkml.kernel.org/r/Zwd6vH0rz0PVedLI@infradead.org
> https://lkml.kernel.org/r/ZwjXz0dz-RldVNx0@infradead.org
> https://lkml.kernel.org/r/202410111408.8fe6f604-lkp@intel.com

BTW Andrew I'd like to pick this up through the modules tree, and while
at it, also beat it up with some more testing as we're expanding also
with the modversions stuff for Rust modules.

  Luis


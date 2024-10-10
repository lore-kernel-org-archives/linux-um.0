Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A41ACCF07A5
	for <linux-um@archiver.kernel.org>; Thu, 10 Oct 2024 05:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7pL9DjnUbhD4Jj4TUGmgK/B+QAzH921/eIKxZUNyPg0=; b=Tf9/LYN+mJYK3E5e3xyqeugUcY
	2jKpamLmDyXSIXch9oRwL2CecoEDvCqSQJPrLY7Pc8VCNCosU0Dth1YFmA4NUW+XSiZD75Fl4Pnem
	Y2fJN9R8wOr5WuDmXnd0vOTMMsGvskJ90kTsOh8oRQ1J/z9N0ziML3+HotJTB1aCGo7Y8VxLbFwUx
	AQr/iyiGJEZMiVoA1eOXAK/ukLv2hBkMVRR88t/lVZFLOQ8/A451mo+X6RqAsbupNhaHvFOsxkKE8
	/csHScoW101M6RwwupTMUGTfM+zTT3RxZ0sWyGdpgIlFxhiwnVIUNJjr0OEyOd5bYKShrJVVoIWw1
	JRqnkkyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sym1d-0000000BbWY-3dmG;
	Thu, 10 Oct 2024 05:47:49 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sym1Z-0000000BbTl-3PkR;
	Thu, 10 Oct 2024 05:47:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 729BE5C5406;
	Thu, 10 Oct 2024 05:47:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941A0C4CECC;
	Thu, 10 Oct 2024 05:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728539264;
	bh=OTuy4VqE5rZSLBEA0/Pnb2zLZJiAXIMvgimloV5JAr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e1wK0sqCj1hFSMccCG8VnSk9aTxpzFJTrYzsRT9VXVEEoRS3hraEZu619qHthJzSx
	 DynBiJLcPJQRbA9J0lLh6ATNk3FB4/xFOM4dXnLEGXWPkSrxd0XcoTxriiWODdioLD
	 1sWIJTn6uT4ZOaW12OrRLOdpildKc5e58UW0/bc2P0yDusD5bq7Iwbf8r4b7hIX5Iy
	 XccbgL+BkzqR13hBcI+eIsGnGBFTEruC5c+E0zapz7RRHpVu6gMKoZHI6cwfi2IRZM
	 bP+nlVliXD/Sq3TcOU7AO/E8ZEwKb501SlYT1dTNQaVEK/mrQ9FtlySueDuymdFkFN
	 xybmhUi0XMlmg==
Date: Thu, 10 Oct 2024 08:43:56 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Song Liu <song@kernel.org>
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
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
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
Subject: Re: [PATCH v5 4/8] module: prepare to handle ROX allocations for text
Message-ID: <ZwdpnPKKQGF5DtSv@kernel.org>
References: <20241009180816.83591-1-rppt@kernel.org>
 <20241009180816.83591-5-rppt@kernel.org>
 <CAPhsuW66etfdU3Fvk0KsELXcgWD6_TkBFjJ-BTHQu5OejDsP2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW66etfdU3Fvk0KsELXcgWD6_TkBFjJ-BTHQu5OejDsP2w@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241009_224745_946664_0DF79C5B 
X-CRM114-Status: GOOD (  14.32  )
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

On Wed, Oct 09, 2024 at 03:23:40PM -0700, Song Liu wrote:
> On Wed, Oct 9, 2024 at 11:10 AM Mike Rapoport <rppt@kernel.org> wrote:
> [...]
> > diff --git a/include/linux/module.h b/include/linux/module.h
> > index 88ecc5e9f523..7039f609c6ef 100644
> > --- a/include/linux/module.h
> > +++ b/include/linux/module.h
> > @@ -367,6 +367,8 @@ enum mod_mem_type {
> >
> >  struct module_memory {
> >         void *base;
> > +       void *rw_copy;
> > +       bool is_rox;
> >         unsigned int size;
> 
> Do we really need to hold the rw_copy all the time? 

We hold it only during module initialization, it's freed in
post_relocation.

> Thanks,
> Song
> 
> [...]

-- 
Sincerely yours,
Mike.


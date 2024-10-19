Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35AECD3C92E
	for <linux-um@archiver.kernel.org>; Sat, 19 Oct 2024 23:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VuHy1HrHdhUjSm/D9WaG63hW9NcA1Axd/7XrPQvY+Bo=; b=ckVa54k+giZi1obOC1LFGvC6gH
	BZRRi0a/3Wfg4Q7d2mPnxdYabLHKcAUTXm01AQcwY0VaIeItgLNZ9vlZuUdnCbK0jUzWiM8QPhTi0
	OjEIhvMT5OybwiI2x4tBBdGoLxCCzfkj0wdFyTgADVZgpTlNACoqkvh/aP3mfpKDqKu8Ni+0rnFWZ
	L2ZWos2l1GkDDleRPdr2rxmHNIeDYJ37J5K/mKZnHxT8gWu9TJ3U8gvxoYmVrfIp7fg8FSf8JzRaE
	DllSTevTHKeIjzoC4Ie9epCel8Fp+WTEkiXDsLmpUxV2aE+Z+q9h+LX2Onb5LgaK9xfzT5yHZwcgF
	DpGBc5tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2Iuu-000000046Ba-0WRM;
	Sat, 19 Oct 2024 23:31:28 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2HyA-000000040uO-1hId;
	Sat, 19 Oct 2024 22:30:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 0111FA40448;
	Sat, 19 Oct 2024 22:30:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF36EC4CEC5;
	Sat, 19 Oct 2024 22:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729377044;
	bh=QyfIXk+096xDFBJfNhGtA+h7+x144NJyXqGZEWCxEbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CErL8/nta/6r/1WJkkwG/t5evnd+rztuMKPvEAcvD2SnHlbG8tiM8oebQum4YnbtM
	 jKRTZBaC+ATcd4VCxL5682bSGxbHvqjRzPrn6cR/xecdWEBWr3gweQycvt1RfyCGs7
	 MiXNOy+V4Fewi4RfizJAsZmsup5CQWNXqWmaamyVMyXGW/hUqx3sW49nhqNlGd3ZzY
	 ETj4BkT4BYSwhfn/AQ96YSvs+Sq6IlTIlZXVNMpeHMX+0ZQjv+FZRA/RKrz+t3dZ4u
	 1qH1N38SWuCE3fte75V0TIkKwCKF9lts668sBgQlwW5eAV1dEKJXhxg+1WEdnmmBQI
	 jKYmcc+lcknEw==
Date: Sat, 19 Oct 2024 15:30:41 -0700
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
Subject: Re: [PATCH v6 4/8] module: prepare to handle ROX allocations for text
Message-ID: <ZxQzEdJqU6TCEH5f@bombadil.infradead.org>
References: <20241016122424.1655560-1-rppt@kernel.org>
 <20241016122424.1655560-5-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016122424.1655560-5-rppt@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241019_153046_600636_D7E90C0A 
X-CRM114-Status: GOOD (  17.53  )
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

On Wed, Oct 16, 2024 at 03:24:20PM +0300, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> In order to support ROX allocations for module text, it is necessary to
> handle modifications to the code, such as relocations and alternatives
> patching, without write access to that memory.
> 
> One option is to use text patching, but this would make module loading
> extremely slow and will expose executable code that is not finally formed.
> 
> A better way is to have memory allocated with ROX permissions contain
> invalid instructions and keep a writable, but not executable copy of the
> module text. The relocations and alternative patches would be done on the
> writable copy using the addresses of the ROX memory.
> Once the module is completely ready, the updated text will be copied to ROX
> memory using text patching in one go and the writable copy will be freed.
> 
> Add support for that to module initialization code and provide necessary
> interfaces in execmem.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewd-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis


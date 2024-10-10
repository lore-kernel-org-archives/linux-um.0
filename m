Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F30BCF11CD
	for <linux-um@archiver.kernel.org>; Thu, 10 Oct 2024 10:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GAyGpq2ToVprQTiU0GHlGT9QpKdbqvtvC7vVE+iJ9ss=; b=0JU+NWzW5UDGN8Eh0qesQf6z0/
	pCwbobmhD0OpPX4ujrTq7H6SfySflqSBz/++upHVRPJN+S0iwwikVjoab/00yIlthn9c7J85Kfxvd
	UN8xqacA49kwpJpsfSgtJysoCSX0h2UlUErAMMC+fYLAvRRHuUh424M7XZ0H7DvocyjgbDI68+AmC
	ACPT9m2LJCnbrLZhQFi09ogu+MEt49cifz3j9ZVoHh/6UXDJanXiOJjTCxpHaRW0wbltBoI5iuYkr
	a3TIL0ASmt7OaCh96lgOz83p79LtJjmcOtH8QFKIhXGgvuigVGx9Kr58LY843zUdQi4WVu+GwycAm
	FNZfyVcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syqgJ-0000000CRub-1v76;
	Thu, 10 Oct 2024 10:46:07 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sypY1-0000000CFUR-47zz;
	Thu, 10 Oct 2024 09:33:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 3129CA43782;
	Thu, 10 Oct 2024 09:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18111C4CEC5;
	Thu, 10 Oct 2024 09:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728552807;
	bh=IHjj8Pm1cvim8ImsaUaQl0ADY0QKS9kDKJZxcyI9510=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TOVNNKtrf8daQuuMacjY7pAlRlt/k4vb7wjQCQYF0aVuw/4MxtY1IEDmecYy869WA
	 eL70bjSLCWzeSg87onzBIfUU+BSv9+MhwYkC/eIJ924jg8Lyc5Ubk1r7GreDoZptDJ
	 teVpdajxre4MsBPJA9mql4sRA7irY3J0uloNZaSVW+zDmxt4CzZVh6D1UOnW7YD45l
	 /XMlYCHBMS9YgkvBhtdnENr2FDWIvohUoNzgrqIpRpXIOWraQQuc8IrP9OJlfmnsWJ
	 /Y7TcehyVVbI3ky02lFC2Bu9TlmKaTridXnO8cdxvFKPK24cuDB2/RZZ9PsqYrxZV2
	 Py4W9D9Jti/XA==
Date: Thu, 10 Oct 2024 12:29:39 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andreas Larsson <andreas@gaisler.com>,
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
Message-ID: <Zweeg3oc-zrrG_D9@kernel.org>
References: <20241009180816.83591-1-rppt@kernel.org>
 <20241009180816.83591-8-rppt@kernel.org>
 <20241009132427.5c94fb5942bae3832446bca5@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009132427.5c94fb5942bae3832446bca5@linux-foundation.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241010_023330_184985_0FEE732D 
X-CRM114-Status: GOOD (  15.75  )
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

On Wed, Oct 09, 2024 at 01:24:27PM -0700, Andrew Morton wrote:
> On Wed,  9 Oct 2024 21:08:15 +0300 Mike Rapoport <rppt@kernel.org> wrote:
> 
> > Using large pages to map text areas reduces iTLB pressure and improves
> > performance.
> 
> Are there any measurable performance improvements?

I don't have any numbers, I just followed the common sense of "less TLB
entries is better" and relied on Thomas comments from previous discussions.
 
> What are the effects of this series upon overall memory consumption?
 
There will be some execmem cache fragmentation and an increase in memory
consumption. It depends on the actual modules loaded and how large it the
fragmentation.

For a set of pretty randomly chosen modules where most come from
net/netfilter I see an increase from 19M to 25M.

> The lack of acks is a bit surprising for a v5 patch, but I'll add all
> this to mm.git for some testing, thanks.
> 

-- 
Sincerely yours,
Mike.


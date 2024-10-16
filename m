Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8504AD2F7D7
	for <linux-um@archiver.kernel.org>; Wed, 16 Oct 2024 23:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E/0jVX1ynRBLjz392OEzox61biVXJJJAy4k1d8yOf0E=; b=nAYfJtekJlZ8l67XcAgqFbvPWa
	+RAkxhXas7XOYgIq7vWx1DwIQQaYjR1+IrtqY8RJKcLU+RiUfSBT3MXFVnsPFAUai4Wkkfy11B7SJ
	2EjSBqQjyCCLDwy5snStpYj3c7/QizFKCc/dxKIoEm85YkGrn8zJu87pDa3DgCAVf8F4C4BX5Ij+5
	9wBABC5ps+54ilgBrKIzFLGyypqNPHR8xU7PViMJbDfxKrXBa8wr0XUhOEUELU0R+MyeFJY/H91Xc
	3wfb0dAJ+iYBAcwrR8edg+8wB4EhVIzgb7hwC2BV95kbU+Xi+1xGjlRFBaJkOHXI0HNRqoEfP+7hL
	bqVZDnRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1DuL-0000000DGV6-0w44;
	Wed, 16 Oct 2024 23:58:25 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1DuG-0000000DGSU-1ez4;
	Wed, 16 Oct 2024 23:58:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id DEA45A4293C;
	Wed, 16 Oct 2024 23:58:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0128CC4CEC5;
	Wed, 16 Oct 2024 23:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729123098;
	bh=dl4ZMMi6UkY66eeJUj39rk75iod/Rq4ydDN6GkT6Ce0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aUyJRTRo0x2+3z/2y/FQ+aEK3XYUoN8mcz2N9MbvfVeg7WtoOgXSHf9qFPMa9WqK4
	 I4Eb7NqiTNyvOxrYQ0Ck1crWzLXaJyBVvU1iHXhrLqptfZmWv1nwU+oeXM6onwo7B1
	 Bjome/eLzoTdbg0LAyDRkQaPt6vpNKaP3Fks19G43RKkcc3xWsk/OAukW5yOL9KK4T
	 DRNRLea/INzHDvb30jc2JX11dyzgwAjaplu5U/zrOnXLPkT+ALdxPNd3g3qhlwF7Nb
	 IhixQCW/u2nVSk7r2vmTsqvA+1zxrdLaddel3zcxJ5QIG57g91CYpQvbUsqReiBH8k
	 JX5BKTdKfsQpQ==
Date: Wed, 16 Oct 2024 16:58:15 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
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
	sparclinux@vger.kernel.org, x86@kernel.org, kdevops@lists.linux.dev
Subject: Re: [PATCH v5 7/8] execmem: add support for cache of large ROX pages
Message-ID: <ZxBTFyyzZhByMjmo@bombadil.infradead.org>
References: <Zwd7GRyBtCwiAv1v@infradead.org>
 <ZwfPPZrxHzQgYfx7@kernel.org>
 <ZwjXz0dz-RldVNx0@infradead.org>
 <ZwuIPZkjX0CfzhjS@kernel.org>
 <20241013202626.81f430a16750af0d2f40d683@linux-foundation.org>
 <Zw1uBBcG-jAgxF_t@bombadil.infradead.org>
 <Zw3rDS3GRWZe4CBu@bombadil.infradead.org>
 <Zw4DlTTbz4QwhOvU@kernel.org>
 <Zw7MirnsHnhRveBB@bombadil.infradead.org>
 <Zw-YN4JIltntY52Y@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw-YN4JIltntY52Y@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241016_165820_582465_5A69D80C 
X-CRM114-Status: GOOD (  21.50  )
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

On Wed, Oct 16, 2024 at 01:40:55PM +0300, Mike Rapoport wrote:
> On Tue, Oct 15, 2024 at 01:11:54PM -0700, Luis Chamberlain wrote:
> > On Tue, Oct 15, 2024 at 08:54:29AM +0300, Mike Rapoport wrote:
> > > On Mon, Oct 14, 2024 at 09:09:49PM -0700, Luis Chamberlain wrote:
> > > > Mike, please run this with kmemleak enabled and running, and also try to get
> > > > tools/testing/selftests/kmod/kmod.sh to pass.
> > > 
> > > There was an issue with kmemleak, I fixed it here:
> > > 
> > > https://lore.kernel.org/linux-mm/20241009180816.83591-1-rppt@kernel.org/T/#m020884c1795218cc2be245e8091fead1cda3f3e4
> > 
> > Ah, so this was a side fix, not part of this series, thanks.
> > 
> > > > I run into silly boot issues with just a guest.
> > > 
> > > Was it kmemleak or something else?
> > 
> > Both kmemleak and the kmod selftest failed, here is a run of the test
> > with this patch series:
> > 
> > https://github.com/linux-kdevops/linux-modules-kpd/actions/runs/11352286624/job/31574722735
> 
> Is there a kernel log to look at? Could not find it in the run report

No, I forgot to include the guestfs console on artifacts, I'll do that
in the next run.

  Luis


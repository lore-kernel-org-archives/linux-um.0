Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A695AC02192
	for <linux-um@archiver.kernel.org>; Tue, 28 Jan 2025 16:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q+GzEo6xQjcCivH2uqqJkJdbnOBUjgfD/PowAlU4fmM=; b=a8yjz8iFl7IsfNgBwGg/F/zJKy
	WYgoRGwV3gt90RgOVfgFDIpqeJq1ayxxlkWqInQ2MK/vGkKbFilDtCzxB2X2in4TnMwcB5BMeQMII
	r1bwBIe3WFzn2OOoEnkektooUm2NTdPPvyTzwW1z6EvqFLRea8YzUG8FzUzI7O10a0pyzLl++PUsj
	cYtD/+bcCFg5A22jtt/eXNHfFhQp+NCLM35FZBGBQP2WMHMWZyqUCWBt06pbrof0/z3vxw9BKzZZ6
	vrVUaf7vcQcTY64AMh5sAiHvUe5fmw5VgAFuv1TFlHtJ/uxi94Xk2Tun9O8av2hWexsGAaTtu9AwO
	1kZE6WlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcoW7-00000005KpK-1m3w;
	Tue, 28 Jan 2025 16:32:47 +0000
Received: from vmicros1.altlinux.org ([194.107.17.57])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcoPK-00000005JRY-03Fa;
	Tue, 28 Jan 2025 16:25:47 +0000
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 2308C72C8CC;
	Tue, 28 Jan 2025 19:25:45 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id 0E2917CCB3A; Tue, 28 Jan 2025 18:25:45 +0200 (IST)
Date: Tue, 28 Jan 2025 18:25:44 +0200
From: "Dmitry V. Levin" <ldv@strace.io>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Oleg Nesterov <oleg@redhat.com>, linux-snps-arc@lists.infradead.org,
	Rich Felker <dalias@libc.org>, Thomas Gleixner <tglx@linutronix.de>,
	Andreas Larsson <andreas@gaisler.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
	linux-mips@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
	linux-hexagon@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
	Will Deacon <will@kernel.org>,
	Eugene Syromyatnikov <evgsyr@gmail.com>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-riscv@lists.infradead.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Vineet Gupta <vgupta@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	strace-devel@lists.strace.io, linux-arch@vger.kernel.org,
	Albert Ou <aou@eecs.berkeley.edu>,
	Mike Frysinger <vapier@gentoo.org>,
	Davide Berardi <berardi.dav@gmail.com>,
	Renzo Davoli <renzo@cs.unibo.it>, linux-um@lists.infradead.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Naveen N Rao <naveen@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	linux-m68k@lists.linux-m68k.org, Borislav Petkov <bp@alien8.de>,
	loongarch@lists.linux.dev, Paul Walmsley <paul.walmsley@sifive.com>,
	Stafford Horne <shorne@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Brian Cain <bcain@quicinc.com>, Michal Simek <monstr@monstr.eu>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-parisc@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Dinh Nguyen <dinguyen@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Richard Weinberger <richard@nod.at>,
	Johannes Berg <johannes@sipsolutions.net>,
	Alexey Gladkov <legion@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v3 3/6] syscall.h: introduce syscall_set_nr()
Message-ID: <20250128162544.GE11869@strace.io>
References: <20250128091636.GC8601@strace.io>
 <e76df471-1346-459a-9f24-fa053d7dcbe8@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e76df471-1346-459a-9f24-fa053d7dcbe8@csgroup.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_082546_382770_80078A28 
X-CRM114-Status: GOOD (  25.84  )
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

On Tue, Jan 28, 2025 at 04:13:52PM +0100, Christophe Leroy wrote:
> Le 28/01/2025 à 10:16, Dmitry V. Levin a écrit :
> > Similar to syscall_set_arguments() that complements
> > syscall_get_arguments(), introduce syscall_set_nr()
> > that complements syscall_get_nr().
> > 
> > syscall_set_nr() is going to be needed along with
> > syscall_set_arguments() on all HAVE_ARCH_TRACEHOOK
> > architectures to implement PTRACE_SET_SYSCALL_INFO API.
> > 
> > Signed-off-by: Dmitry V. Levin <ldv@strace.io>
> > Tested-by: Charlie Jenkins <charlie@rivosinc.com>
> > Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >   arch/arc/include/asm/syscall.h        | 11 +++++++++++
> >   arch/arm/include/asm/syscall.h        | 24 ++++++++++++++++++++++++
> >   arch/arm64/include/asm/syscall.h      | 16 ++++++++++++++++
> >   arch/hexagon/include/asm/syscall.h    |  7 +++++++
> >   arch/loongarch/include/asm/syscall.h  |  7 +++++++
> >   arch/m68k/include/asm/syscall.h       |  7 +++++++
> >   arch/microblaze/include/asm/syscall.h |  7 +++++++
> >   arch/mips/include/asm/syscall.h       | 14 ++++++++++++++
> >   arch/nios2/include/asm/syscall.h      |  5 +++++
> >   arch/openrisc/include/asm/syscall.h   |  6 ++++++
> >   arch/parisc/include/asm/syscall.h     |  7 +++++++
> >   arch/powerpc/include/asm/syscall.h    | 10 ++++++++++
> >   arch/riscv/include/asm/syscall.h      |  7 +++++++
> >   arch/s390/include/asm/syscall.h       | 12 ++++++++++++
> >   arch/sh/include/asm/syscall_32.h      | 12 ++++++++++++
> >   arch/sparc/include/asm/syscall.h      | 12 ++++++++++++
> >   arch/um/include/asm/syscall-generic.h |  5 +++++
> >   arch/x86/include/asm/syscall.h        |  7 +++++++
> >   arch/xtensa/include/asm/syscall.h     |  7 +++++++
> >   include/asm-generic/syscall.h         | 14 ++++++++++++++
> >   20 files changed, 197 insertions(+)
> > 
> 
> > diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
> > index 76020b66286b..712daa90e643 100644
> > --- a/arch/arm64/include/asm/syscall.h
> > +++ b/arch/arm64/include/asm/syscall.h
> > @@ -61,6 +61,22 @@ static inline void syscall_set_return_value(struct task_struct *task,
> >   	regs->regs[0] = val;
> >   }
> >   
> > +static inline void syscall_set_nr(struct task_struct *task,
> > +				  struct pt_regs *regs,
> > +				  int nr)
> > +{
> > +	regs->syscallno = nr;
> > +	if (nr == -1) {
> > +		/*
> > +		 * When the syscall number is set to -1, the syscall will be
> > +		 * skipped.  In this case the syscall return value has to be
> > +		 * set explicitly, otherwise the first syscall argument is
> > +		 * returned as the syscall return value.
> > +		 */
> > +		syscall_set_return_value(task, regs, -ENOSYS, 0);
> > +	}
> > +}
> > +
> >   #define SYSCALL_MAX_ARGS 6
> >   
> >   static inline void syscall_get_arguments(struct task_struct *task,
> 
> > diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
> > index 521f279e6b33..7505dcfed247 100644
> > --- a/arch/powerpc/include/asm/syscall.h
> > +++ b/arch/powerpc/include/asm/syscall.h
> > @@ -39,6 +39,16 @@ static inline int syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
> >   		return -1;
> >   }
> >   
> > +static inline void syscall_set_nr(struct task_struct *task, struct pt_regs *regs, int nr)
> > +{
> > +	/*
> > +	 * Unlike syscall_get_nr(), syscall_set_nr() can be called only when
> > +	 * the target task is stopped for tracing on entering syscall, so
> > +	 * there is no need to have the same check syscall_get_nr() has.
> > +	 */
> > +	regs->gpr[0] = nr;
> 
> Doesn't the same as for ARM64 apply here as well ?

I carefully checked all affected architectures and added that
syscall_set_return_value() call only where I think it's needed.

On powerpc it's not needed with the current implementation: their
do_seccomp() sets -ENOSYS before __secure_computing() invocation, and
their do_syscall_trace_enter() sets -ENOSYS in case of an invalid syscall
number.


-- 
ldv


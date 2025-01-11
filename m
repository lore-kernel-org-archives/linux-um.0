Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99966E7719D
	for <linux-um@archiver.kernel.org>; Sat, 11 Jan 2025 01:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OGaUIIECp53nz7ZUChA/HGseFYhZkADFgRs/+WkgOTc=; b=Und5AvGWZHT5WJEEbdXuglWuvL
	DJ5YQ64UqZFJ8NFtmR/3yNs5VNwZkkiGmH0PNIAuqwOxdLQpRdqQ1AgXaEbzmqweieuAQxd+MqkNY
	+0b9Q8OdsWywrmNJ2iMo1s61Joi6KS7HfPg/PaAXwyrWb7XJ0Dl4M8BkXXV9WlXaiqns1q9hFhoL3
	MtyHlCSMkGha0wJfq5c6N0LrI+OQTnkVAtMo7syktcIdBeMPKhKJ56j/5orO4BtMWy8FyKyeH2pyQ
	t2MxB8DfTjswNHWr6zm7mBcwjqI5Ox0AXh/HBBx1zGjzi1twIg9mn5M/wpeTMitE3hYsZCZF6O6AE
	NsCnRulA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWQ7E-0000000HTnw-2sUf;
	Sat, 11 Jan 2025 01:16:40 +0000
Received: from vmicros1.altlinux.org ([194.107.17.57])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWQ7B-0000000HTmw-0Y2E;
	Sat, 11 Jan 2025 01:16:38 +0000
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 3D21472C8FB;
	Sat, 11 Jan 2025 04:16:32 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id 2736C7CCB3A; Sat, 11 Jan 2025 03:16:32 +0200 (IST)
Date: Sat, 11 Jan 2025 03:16:32 +0200
From: "Dmitry V. Levin" <ldv@strace.io>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Oleg Nesterov <oleg@redhat.com>,
	Eugene Syromyatnikov <evgsyr@gmail.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Renzo Davoli <renzo@cs.unibo.it>,
	Davide Berardi <berardi.dav@gmail.com>,
	strace-devel@lists.strace.io, Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Brian Cain <bcain@quicinc.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michal Simek <monstr@monstr.eu>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 3/6] syscall.h: introduce syscall_set_nr()
Message-ID: <20250111011632.GA1724@strace.io>
References: <20250107230438.GC30633@strace.io>
 <yt9dzfjz6rw5.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9dzfjz6rw5.fsf@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_171637_501766_72E36C16 
X-CRM114-Status: GOOD (  21.30  )
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

On Fri, Jan 10, 2025 at 08:37:46AM +0100, Sven Schnelle wrote:
> "Dmitry V. Levin" <ldv@strace.io> writes:
> 
> > Similar to syscall_set_arguments() that complements
> > syscall_get_arguments(), introduce syscall_set_nr()
> > that complements syscall_get_nr().
> >
> > syscall_set_nr() is going to be needed along with
> > syscall_set_arguments() on all HAVE_ARCH_TRACEHOOK
> > architectures to implement PTRACE_SET_SYSCALL_INFO API.
[...]
> > diff --git a/arch/s390/include/asm/syscall.h b/arch/s390/include/asm/syscall.h
> > index b3dd883699e7..1c0e349fd5c9 100644
> > --- a/arch/s390/include/asm/syscall.h
> > +++ b/arch/s390/include/asm/syscall.h
> > @@ -24,6 +24,13 @@ static inline long syscall_get_nr(struct task_struct *task,
> >  		(regs->int_code & 0xffff) : -1;
> >  }
> >  
> > +static inline void syscall_set_nr(struct task_struct *task,
> > +				  struct pt_regs *regs,
> > +				  int nr)
> > +{
> 
> I think there should be a
> 
> 	if (!test_pt_regs_flags(regs, PIF_SYSCALL))
> 		return;
> 
> before the modification so a user can't accidentally change int_code
> when ptrace stopped in a non-syscall path.

The reason why syscall_get_nr() has this check on s390 (and similar checks
on arc, powerpc, and sparc) is that syscall_get_nr() can be called while
the target task is not in syscall.

Unlike syscall_get_nr(), syscall_set_nr() can be called only when the
target task is stopped for tracing on entering syscall: the description in
include/asm-generic/syscall.h explicitly states that, and the follow-up
patch that introduces PTRACE_SET_SYSCALL_INFO adds a syscall_set_nr() call
when the tracee is stopped on entering syscall in either
PTRACE_SYSCALL_INFO_ENTRY or PTRACE_SYSCALL_INFO_SECCOMP state.

I don't mind adding a check, but syscall_set_nr() invocation while the
target task is not in syscall wouldn't be a result of user actions but
a kernel programing error, and in that case WARN_ON_ONCE() would be more
appropriate.

If calling syscall_set_nr() while the target task is not in syscall was
legal, then syscall_set_nr() would have been designed to return a value
indicating the status of operation.

Anyway, I'll add an explanatory comment to syscall_set_nr() on all
architectures where syscall_get_nr() has a check.


-- 
ldv


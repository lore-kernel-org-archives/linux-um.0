Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24A9FC02193
	for <linux-um@archiver.kernel.org>; Mon,  3 Feb 2025 10:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FEmiugC6rBX2OLCTg0Nwo4vFpIRSKT7Cs1VYExDtmL0=; b=g80wuVi7YVfQEcnKkjWsCgLaGx
	pTWRnyQsIsGt4qIWtOETzF33VIFYdIOmOI7tg9Wm02QplFFVr33rc9UiaFo0FFAV+NqR6U0c1tTYh
	d27FV5tlxgjhQVixT/mTtsbI05lQ6Dp0yqm1EN/v40tCG54K+Rhov5TAYZrAOP2OnZd6Mqi6CJ3bt
	ztz9u9qF8UiajSaDeki+Eeqm42K8P+glAks1WN0CwE67vd3q6lY4oECyGsA7VUsXGBVbT/QIv+DWa
	MZtDHmiP2rvwcw1PqyqZV6OTCbRfDl300yH1XjpvywZqw4e/mxVDSRZoipP0VJduTTw6Vb/rOzcCi
	UQyRKwFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1teu8o-0000000FAmS-2Qh2;
	Mon, 03 Feb 2025 10:57:22 +0000
Received: from vmicros1.altlinux.org ([194.107.17.57])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tetnu-0000000F8R7-0waq;
	Mon, 03 Feb 2025 10:35:48 +0000
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 33C4872C8CC;
	Mon,  3 Feb 2025 13:35:43 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id 1956F7CCB3A; Mon,  3 Feb 2025 12:35:43 +0200 (IST)
Date: Mon, 3 Feb 2025 12:35:43 +0200
From: "Dmitry V. Levin" <ldv@strace.io>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-snps-arc@lists.infradead.org, Rich Felker <dalias@libc.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Larsson <andreas@gaisler.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org,
	linux-kselftest@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org,
	WANG Xuerui <kernel@xen0n.name>, linux-api@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Eugene Syromyatnikov <evgsyr@gmail.com>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Vineet Gupta <vgupta@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
	Mike Frysinger <vapier@gentoo.org>,
	Davide Berardi <berardi.dav@gmail.com>,
	Renzo Davoli <renzo@cs.unibo.it>, linux-um@lists.infradead.org,
	Heiko Carstens <hca@linux.ibm.com>, strace-devel@lists.strace.io,
	Charlie Jenkins <charlie@rivosinc.com>,
	Naveen N Rao <naveen@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	linux-m68k@lists.linux-m68k.org, Borislav Petkov <bp@alien8.de>,
	loongarch@lists.linux.dev, Paul Walmsley <paul.walmsley@sifive.com>,
	Stafford Horne <shorne@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-arm-kernel@lists.infradead.org,
	Brian Cain <bcain@quicinc.com>, Michal Simek <monstr@monstr.eu>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-parisc@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Oleg Nesterov <oleg@redhat.com>, Dinh Nguyen <dinguyen@kernel.org>,
	linux-riscv@lists.infradead.org,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Richard Weinberger <richard@nod.at>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexey Gladkov <legion@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v4 0/7] ptrace: introduce PTRACE_SET_SYSCALL_INFO API
Message-ID: <20250203103542.GA16165@strace.io>
References: <20250203065849.GA14120@strace.io>
 <Z6CMgVm8QKEMRf8L@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6CMgVm8QKEMRf8L@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250203_023546_591166_D1BC158C 
X-CRM114-Status: GOOD (  15.36  )
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

On Mon, Feb 03, 2025 at 10:29:37AM +0100, Alexander Gordeev wrote:
> On Mon, Feb 03, 2025 at 08:58:49AM +0200, Dmitry V. Levin wrote:
> 
> Hi Dmitry,
> 
> > PTRACE_SET_SYSCALL_INFO is a generic ptrace API that complements
> > PTRACE_GET_SYSCALL_INFO by letting the ptracer modify details of
> > system calls the tracee is blocked in.
> ...
> 
> FWIW, I am getting these on s390:
> 
> # ./tools/testing/selftests/ptrace/set_syscall_info 
> TAP version 13
> 1..1
> # Starting 1 tests from 1 test cases.
> #  RUN           global.set_syscall_info ...
> # set_syscall_info.c:87:set_syscall_info:Expected exp_entry->nr (-1) == info->entry.nr (65535)
> # set_syscall_info.c:88:set_syscall_info:wait #3: PTRACE_GET_SYSCALL_INFO #2: syscall nr mismatch
> # set_syscall_info: Test terminated by assertion
> #          FAIL  global.set_syscall_info
> not ok 1 global.set_syscall_info
> # FAILED: 0 / 1 tests passed.
> # Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0
> 
> I remember one of the earlier versions (v1 or v2) was working for me.
> 
> Thanks!

In v3, this test was extended to check whether PTRACE_GET_SYSCALL_INFO
called immediately after PTRACE_SET_SYSCALL_INFO returns the same syscall
number, and on s390 it apparently doesn't, thanks to its implementation
of syscall_get_nr() that returns 0xffff in this case.

To workaround this, we could either change syscall_get_nr() to return -1
in this case, or add an #ifdef __s390x__ exception to the test.

What would you prefer?


-- 
ldv


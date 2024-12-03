Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 663AEE64AB7
	for <linux-um@archiver.kernel.org>; Tue,  3 Dec 2024 15:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/O0wmVHWIR+aspdrRumbZfBcZnms2oy/7x7jXPZAvuo=; b=02EcvIza8oAdHkZ4xw6aOEbjKn
	telgc4B/59juodxl08/vV2H/Px+iJREKoqyFoAZpJE1n0CnhR5l6zi+WDYoUWli30XnT3LBI+0UXJ
	ysx+RgAF4Co2/wVoIoAp1YJBfcq9W9QWtlqUIvLGGPjeeJ1hyOtMli+JTCx14BpUEiIt51dapo4kt
	eRi07HRuJwTRDVsuS3kb6c9B0MOgJRUNBzUL6Ot4TO+/qCZeeZ2p+/mH4gQLhw/bkJok0eSLslKEb
	XatQ85UbYsKkJA8zv+f+xyUjaneEsP3EZDPpYW4c7p9r/NdbQUokuzdOrNTOhNk8JWO55VgC5i3nu
	RR74CtwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIUO6-00000009rIq-1LWi;
	Tue, 03 Dec 2024 15:00:30 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIUO3-00000009rHh-2g0B
	for linux-um@lists.infradead.org;
	Tue, 03 Dec 2024 15:00:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 8B8E7A40E0D;
	Tue,  3 Dec 2024 14:58:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BEFC4CECF;
	Tue,  3 Dec 2024 15:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733238026;
	bh=NFJYScey6WlaM0/KP5ssIcH1z5YmJHnofy8ESVWE4+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fgBbj5Zlwd9pt9XWg8GqwCGXWheAWHY5qMKU/k0qYRtdWtPQvF4tsaPEFRJsl4N9t
	 qkyzSenSLm0FKzryZ+LvAozh2N0rpeTI1LZjOHBbssEJ5gJslXPa1bNEQnfQb/LNyC
	 nbGXJB7WhJwiqaAtEH1k7FA6lZDm3p0i+AHKUX1lzF3yBMm+oNrrprbErUNSXGRSyc
	 w1/0apv8tpvNHLl3dDB5oEETM8A0Zu8dGqfLEig7PEuFBw46XxmBqKhLcqsPNeTIvB
	 FM30pCWsr/lK5oX1eBdjA2/ZjauGiEFUJUMgekJP2OTOOpnc0kjPrxnj3s394xSlcg
	 EcXAkZqTWIhGg==
From: SeongJae Park <sj@kernel.org>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: SeongJae Park <sj@kernel.org>,
	linux-um@lists.infradead.org,
	johannes@sipsolutions.net
Subject: Re: [PATCH v5] um: switch to regset API and depend on XSTATE
Date: Tue,  3 Dec 2024 07:00:20 -0800
Message-Id: <20241203150021.981-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <029ad08a1aa2dc512b442c988d0edebdd7aef4b0.camel@sipsolutions.net>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241203_070027_811925_2BFFD3A3 
X-CRM114-Status: GOOD (  37.62  )
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

On Tue, 03 Dec 2024 09:40:34 +0100 Benjamin Berg <benjamin@sipsolutions.net> wrote:

> Hi,
> 
> that probably means the size detection for the FPU state (i.e.
> PTRACE_GETREGSET for NT_X86_XSTATE is incorrect on a 32bit host in some
> way.
> 
> Is there anything special about the qemu setup or it is just a default
> qemu-x86?

I use default qemu-system-x86_64 on my system.

    $ qemu-system-x86_64 --version
    QEMU emulator version 8.2.2 (qemu-8.2.2-1.1.hs+fb.el9)
    Copyright (c) 2003-2023 Fabrice Bellard and the QEMU Project developers

I forgot saying it is not just x86 but x86_64, sorry.


Thanks,
SJ

> 
> Benjamin
> 
> On Mon, 2024-12-02 at 23:02 -0800, SeongJae Park wrote:
> > Hello,
> > 
> > 
> > On Wed, 23 Oct 2024 11:41:20 +0200 Benjamin Berg <benjamin@sipsolutions.net> wrote:
> > 
> > > From: Benjamin Berg <benjamin.berg@intel.com>
> > > 
> > > The PTRACE_GETREGSET API has now existed since Linux 2.6.33. The XSAVE
> > > CPU feature should also be sufficiently common to be able to rely on it.
> > > 
> > > With this, define our internal FP state to be the hosts XSAVE data. Add
> > > discovery for the hosts XSAVE size and place the FP registers at the end
> > > of task_struct so that we can adjust the size at runtime.
> > > 
> > > Next we can implement the regset API on top and update the signal
> > > handling as well as ptrace APIs to use them. Also switch coredump
> > > creation to use the regset API and finally set HAVE_ARCH_TRACEHOOK.
> > > 
> > > This considerably improves the signal frames. Previously they might not
> > > have contained all the registers (i386) and also did not have the
> > > sizes and magic values set to the correct values to permit userspace to
> > > decode the frame.
> > > 
> > > As a side effect, this will permit UML to run on hosts with newer CPU
> > > extensions (such as AMX) that need even more register state.
> > 
> > I just found kunit starts failing from the mainline commit of this patch on my
> > qemu-x86 Debian system, as below.
> > 
> >     $ git checkout 3f17fed2149192c7d3b76a45a6a87b4ff22cd586
> >     $ ./tools/testing/kunit/kunit.py run --kunitconfig mm/damon/tests/ --build_dir ../kunit.out/
> >     [...]
> >     [22:48:27] Configuring KUnit Kernel ...
> >     Regenerating .config ...
> >     Populating config with:
> >     $ make ARCH=um O=../kunit.out/ olddefconfig
> >     [22:48:30] Building KUnit Kernel ...
> >     Populating config with:
> >     $ make ARCH=um O=../kunit.out/ olddefconfig
> >     Building with:
> >     $ make all compile_commands.json ARCH=um O=../kunit.out/ --jobs=40
> >     [...]
> >     [22:48:46] Starting KUnit Kernel (1/1)...
> >     [22:48:46] ============================================================
> >     Running tests with:
> >     $ ../kunit.out/linux kunit.enable=1 mem=1G console=tty kunit_shutdown=halt
> >     [22:48:46] [ERROR] Test: <missing>: Could not find any KTAP output. Did any KUnit tests run?
> >     [22:48:46] ============================================================
> >     [22:48:46] Testing complete. Ran 0 tests: errors: 1
> >     [22:48:46] Elapsed time: 19.285s total, 3.805s configuring, 15.475s building, 0.006s running
> > 
> > > 
> > > Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> > [...]
> > > -void arch_init_registers(int pid)
> > > -{
> > > -	struct user_fpxregs_struct fpx_regs;
> > > -	int err;
> > > -
> > > -	err = ptrace(PTRACE_GETFPXREGS, pid, 0, &fpx_regs);
> > > -	if (!err)
> > > -		return;
> > > -
> > > -	if (errno != EIO)
> > > -		panic("check_ptrace : PTRACE_GETFPXREGS failed, errno = %d",
> > > -		      errno);
> > > -
> > > -	have_fpx_regs = 0;
> > > -}
> > > -#else
> > > -
> > > -int get_fp_registers(int pid, unsigned long *regs)
> > > +int arch_init_registers(int pid)
> > >  {
> > > -	return save_fp_registers(pid, regs);
> > > +	struct iovec iov = {
> > > +		/* Just use plenty of space, it does not cost us anything */
> > > +		.iov_len = 2 * 1024 * 1024,
> > > +	};
> > > +	int ret;
> > > +
> > > +	iov.iov_base = mmap(NULL, iov.iov_len, PROT_WRITE | PROT_READ,
> > > +			    MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> > > +	if (iov.iov_base == MAP_FAILED)
> > > +		return -ENOMEM;
> > > +
> > > +	/* GDB has x86_xsave_length, which uses x86_cpuid_count */
> > > +	ret = ptrace(PTRACE_GETREGSET, pid, NT_X86_XSTATE, &iov);
> > > +	if (ret)
> > > +		ret = -errno;
> > > +	munmap(iov.iov_base, 2 * 1024 * 1024);
> > > +
> > > +	host_fp_size = iov.iov_len;
> > > +
> > > +	return ret;
> > >  }
> > 
> > And seems it fails from the registers initialization step:
> > 
> >     $ ../kunit.out/linux
> >     Core dump limits :
> >             soft - 0
> >             hard - NONE
> >     Checking that ptrace can change system call numbers...OK
> >     Checking syscall emulation for ptrace...OK
> >     Checking environment variables for a tempdir...none found
> >     Checking if /dev/shm is on tmpfs...OK
> >     Checking PROT_EXEC mmap in /dev/shm...OK
> >     Failed to initialize default registers
> > 
> > I'm not familiar with uml code, so reporting this issue first.  Any thought, please?
> > 
> > 
> > Thanks,
> > SJ
> > 
> > [...]
> > 
> 
> 
> 


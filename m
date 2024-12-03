Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2EADE6C60D
	for <linux-um@archiver.kernel.org>; Tue,  3 Dec 2024 07:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AS5+NXMzQjPO4NLT5tcS/+xjkcTjArZdd+McsaG11RI=; b=KHC7E1qjRwloxyUhbnPPoVj03t
	KVt6EgOoE9a4mGhSQy0EOBYza7KMSR3pbZ4NAp/pSCmJ/jTBR5HS1Sna1WHDOc9dH7zlbIhxdJwmM
	z3SMC3QjCejKt8maF9Zq5WSkWBBis2qHY+cwGXqQxbo6hg0syua3thW4/RJ2sEX4vFMtNyseBOwrF
	mXCtbXndgIiCtIonB2N06peuTE6GTC981Wqgt9s781qwxsx7RIoQDhHhe1rPxoanIT9Vk400dXZXp
	yHmP9Qnv1eCoQaxZ03b+OIrPbO+IlEEUiw2OgqX/GZvPG5U7fAXpMIW8JKNt+yiZE/F98+Zmp/Iv0
	9I5hBTBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIMvT-00000008THy-3uk8;
	Tue, 03 Dec 2024 07:02:27 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIMvR-00000008THX-110A
	for linux-um@lists.infradead.org;
	Tue, 03 Dec 2024 07:02:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 9093FA4068D;
	Tue,  3 Dec 2024 07:00:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645DFC4CECF;
	Tue,  3 Dec 2024 07:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733209343;
	bh=/qV9pYMCGqm3kV7JpHK5/L0p6ge9PvHzzGMUq4BKXB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ETmCAkc3/tM3j5RyEOq8eHv899klewP9QlQgfqaFCtNFsKqoGIowy/w5Ki/ZdJ9oP
	 9w5GRDSoMfBdx9kX5Xq1OsGi7GFPLvTmvhC9l+QQwsw7suQvRaw2CJtPRghCzUFoFi
	 SkDxXu3z+dFyOKg2QHLiz6nWNJVDjdAROpynEmLnw8+VOWKiBo+TsA84MkOkBqQsL6
	 vVFobLUeLbxxaPgtl/nz7O3gzI+bzlhhYu9oW5CaTGrXbotuqKc/G/tgEIJMhUvTgo
	 r6+7T505SXAbALgJxv3OnEsb/7F9zVlac+gY9aJFfoVxIWpPK1kLuI7KKeYRSGlbm2
	 OeQI6fF4WLm8A==
From: SeongJae Park <sj@kernel.org>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: SeongJae Park <sj@kernel.org>,
	linux-um@lists.infradead.org,
	johannes@sipsolutions.net,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH v5] um: switch to regset API and depend on XSTATE
Date: Mon,  2 Dec 2024 23:02:18 -0800
Message-Id: <20241203070218.240797-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023094120.4083426-1-benjamin@sipsolutions.net>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_230225_405202_B05B1687 
X-CRM114-Status: GOOD (  21.66  )
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

Hello,


On Wed, 23 Oct 2024 11:41:20 +0200 Benjamin Berg <benjamin@sipsolutions.net> wrote:

> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> The PTRACE_GETREGSET API has now existed since Linux 2.6.33. The XSAVE
> CPU feature should also be sufficiently common to be able to rely on it.
> 
> With this, define our internal FP state to be the hosts XSAVE data. Add
> discovery for the hosts XSAVE size and place the FP registers at the end
> of task_struct so that we can adjust the size at runtime.
> 
> Next we can implement the regset API on top and update the signal
> handling as well as ptrace APIs to use them. Also switch coredump
> creation to use the regset API and finally set HAVE_ARCH_TRACEHOOK.
> 
> This considerably improves the signal frames. Previously they might not
> have contained all the registers (i386) and also did not have the
> sizes and magic values set to the correct values to permit userspace to
> decode the frame.
> 
> As a side effect, this will permit UML to run on hosts with newer CPU
> extensions (such as AMX) that need even more register state.

I just found kunit starts failing from the mainline commit of this patch on my
qemu-x86 Debian system, as below.

    $ git checkout 3f17fed2149192c7d3b76a45a6a87b4ff22cd586
    $ ./tools/testing/kunit/kunit.py run --kunitconfig mm/damon/tests/ --build_dir ../kunit.out/
    [...]
    [22:48:27] Configuring KUnit Kernel ...
    Regenerating .config ...
    Populating config with:
    $ make ARCH=um O=../kunit.out/ olddefconfig
    [22:48:30] Building KUnit Kernel ...
    Populating config with:
    $ make ARCH=um O=../kunit.out/ olddefconfig
    Building with:
    $ make all compile_commands.json ARCH=um O=../kunit.out/ --jobs=40
    [...]
    [22:48:46] Starting KUnit Kernel (1/1)...
    [22:48:46] ============================================================
    Running tests with:
    $ ../kunit.out/linux kunit.enable=1 mem=1G console=tty kunit_shutdown=halt
    [22:48:46] [ERROR] Test: <missing>: Could not find any KTAP output. Did any KUnit tests run?
    [22:48:46] ============================================================
    [22:48:46] Testing complete. Ran 0 tests: errors: 1
    [22:48:46] Elapsed time: 19.285s total, 3.805s configuring, 15.475s building, 0.006s running

> 
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
[...]
> -void arch_init_registers(int pid)
> -{
> -	struct user_fpxregs_struct fpx_regs;
> -	int err;
> -
> -	err = ptrace(PTRACE_GETFPXREGS, pid, 0, &fpx_regs);
> -	if (!err)
> -		return;
> -
> -	if (errno != EIO)
> -		panic("check_ptrace : PTRACE_GETFPXREGS failed, errno = %d",
> -		      errno);
> -
> -	have_fpx_regs = 0;
> -}
> -#else
> -
> -int get_fp_registers(int pid, unsigned long *regs)
> +int arch_init_registers(int pid)
>  {
> -	return save_fp_registers(pid, regs);
> +	struct iovec iov = {
> +		/* Just use plenty of space, it does not cost us anything */
> +		.iov_len = 2 * 1024 * 1024,
> +	};
> +	int ret;
> +
> +	iov.iov_base = mmap(NULL, iov.iov_len, PROT_WRITE | PROT_READ,
> +			    MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> +	if (iov.iov_base == MAP_FAILED)
> +		return -ENOMEM;
> +
> +	/* GDB has x86_xsave_length, which uses x86_cpuid_count */
> +	ret = ptrace(PTRACE_GETREGSET, pid, NT_X86_XSTATE, &iov);
> +	if (ret)
> +		ret = -errno;
> +	munmap(iov.iov_base, 2 * 1024 * 1024);
> +
> +	host_fp_size = iov.iov_len;
> +
> +	return ret;
>  }

And seems it fails from the registers initialization step:

    $ ../kunit.out/linux
    Core dump limits :
            soft - 0
            hard - NONE
    Checking that ptrace can change system call numbers...OK
    Checking syscall emulation for ptrace...OK
    Checking environment variables for a tempdir...none found
    Checking if /dev/shm is on tmpfs...OK
    Checking PROT_EXEC mmap in /dev/shm...OK
    Failed to initialize default registers

I'm not familiar with uml code, so reporting this issue first.  Any thought, please?


Thanks,
SJ

[...]


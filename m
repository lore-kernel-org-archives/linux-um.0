Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE7C9CA0FFE
	for <linux-um@archiver.kernel.org>; Sat, 30 Aug 2025 00:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IM3Rq/jMchEW7yYUELIEwYv6KDlI0ImkIrkVAXEH6so=; b=k0PlZ7a20GQ85ah4ymve3uAH+J
	bAvjTE/Uy1J345MuOQW2nTJtKoPvn50Jta4b6ViLyCywd44G2Ne/wIBkEAZFg0NQGnIKjdnQpg6rw
	JF04XzwpcppcDyAEF3M3SyFEn7WuI2SFzrG4dxUrYssqGWAQO/vMQDRxdaErfV9RMkx/PXQO4l14D
	Y5McuHVMJst/peiuOma29v9BfgPihOfuL4hBF1qwnq97UvPMF87UiN/4MpyxETgVaGmRB9VC1FUTs
	L0kn0RLucuZxTKsb9QCnmANOyNgAAFDQAYhJDNt/snFYoKiYXKY53tSDUhU3B7PiXvvjoCijR9fVp
	c90/80Kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1us9m6-00000007B2q-2uVe;
	Sat, 30 Aug 2025 00:48:58 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1us3YJ-00000006boT-0noe
	for linux-um@lists.infradead.org;
	Fri, 29 Aug 2025 18:10:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C9BED456C4;
	Fri, 29 Aug 2025 18:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C02C4CEF0;
	Fri, 29 Aug 2025 18:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756491018;
	bh=SXu3T17dYbp/ukZ8uJydGVdZ6zcCuFcjGzpDGMwa+Nc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ooi7zA7T9NmpAVf2EhalPYoUyuzdraHp5C4oj/l4tumul2weopj5FJ1utOM+alOHE
	 kKgusS+zU63i44OmypyAXKPtErTb3bB1GndFYFN2okuf9dT8hCaNdpoFVkJ5p8agh+
	 KkkEsMX5T3gC8JIm2Ov+5zT8s4L7tpEw7w/6ThgCsQL1Xlg6GXrAAbC6OLHWNTeh0w
	 FXzd4JTSiV52V1QufIh9KkzXjYT+hvbp3zSg4ylf/XGvXabRt4g7AwLZFCUhy7Zrgf
	 S8hNoGjWZuOpsjDmYOt//9aCCpoZgyxV/RwMeINevxHuMv5KmXpH/JQL39xFf9C15W
	 UspQvwHff7f7A==
Date: Fri, 29 Aug 2025 11:10:07 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Jinghao Jia <jinghao7@illinois.edu>,
	Wentao Zhang <wentaoz5@illinois.edu>,
	Sasha Levin <sashal@kernel.org>
Cc: Matt.Kelly2@boeing.com, akpm@linux-foundation.org,
	andrew.j.oppelt@boeing.com, anton.ivanov@cambridgegreys.com,
	ardb@kernel.org, arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
	chuck.wolber@boeing.com, dave.hansen@linux.intel.com,
	dvyukov@google.com, hpa@zytor.com, johannes@sipsolutions.net,
	jpoimboe@kernel.org, justinstitt@google.com, kees@kernel.org,
	kent.overstreet@linux.dev, linux-arch@vger.kernel.org,
	linux-efi@vger.kernel.org, Wentao Zhang <wentaoz5@illinois.edu>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	llvm@lists.linux.dev, luto@kernel.org, marinov@illinois.edu,
	masahiroy@kernel.org, maskray@google.com,
	mathieu.desnoyers@efficios.com, matthew.l.weber3@boeing.com,
	mhiramat@kernel.org, mingo@redhat.com, morbo@google.com,
	ndesaulniers@google.com, oberpar@linux.ibm.com, paulmck@kernel.org,
	peterz@infradead.org, richard@nod.at, rostedt@goodmis.org,
	samitolvanen@google.com, samuel.sarkisian@boeing.com,
	steven.h.vanderleest@boeing.com, tglx@linutronix.de,
	tingxur@illinois.edu, tyxu@illinois.edu, x86@kernel.org
Subject: Re: [PATCH v2 0/4] Enable measuring the kernel's Source-based Code
 Coverage and MC/DC with Clang
Message-ID: <20250829181007.GA468030@ax162>
References: <20241002045347.GE555609@thelio-3990X>
 <20241002064252.41999-1-wentaoz5@illinois.edu>
 <20241003232938.GA1663252@thelio-3990X>
 <284fe8fa-c094-49b7-8e16-3318676d38e3@illinois.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <284fe8fa-c094-49b7-8e16-3318676d38e3@illinois.edu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250829_111019_275568_597EBCAB 
X-CRM114-Status: GOOD (  27.35  )
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

Hi Jinghao and Wentao,

On Thu, Nov 21, 2024 at 11:05:14PM -0600, Jinghao Jia wrote:
...
> On 10/3/24 6:29 PM, Nathan Chancellor wrote:
> > I seem to have narrowed down it to a few different configurations on top
> > of x86_64_defconfig but I will include the full bad configuration as an
> > attachment just in case anything else is relevant.
...
> > $ qemu-system-x86_64 \
> >     -display none \
> >     -nodefaults \
> >     -M q35 \
> >     -d unimp,guest_errors \
> >     -append 'console=ttyS0 earlycon=uart8250,io,0x3f8' \
> >     -kernel arch/x86/boot/bzImage
> >     -initrd rootfs.cpio \
> >     -cpu host \
> >     -enable-kvm \
> >     -m 8G \
> >     -smp 8 \
> >     -serial mon:stdio
> > <hangs with no output>
> 
> This hang is caused by an early boot exception -- gdb shows the execution
> reaches the halt loop in early_fixup_exception().  Dumping regs->ip associated
> with this exception points us to the following instruction:
> 
> ffffffff89b58074:       48 ff 05 85 7f 4a 76    incq   0x764a7f85(%rip)        # 0 <fixed_percpu_data>
> 
> This is apparently an incorrect access to the per-cpu variable (the cpu offset
> in %gs is needed) and triggers a null-ptr-deref. Without CONFIG_AMD_MEM_ENCRYPT
> (one of the bad configs), it turns out the instruction is actually accessing
> the llvm prof-counter of strscpy():
> 
> ffffffff89b85a04:       48 ff 05 6d 94 7d fa    incq   -0x5826b93(%rip)        # ffffffff8435ee78 <__profc__Z13sized_strscpyPcU25pass_dynamic_object_size1PKcU25pass_dynamic_object_size1m>
> 
> This symbol is left undefined in the bad vmlinux, which explains why the
> faulting instruction is accessing address 0.  Tracing through the kernel
> linking process shows that the symbol is still defined (as a weak symbol) in
> vmlinux.a and vmlinux.o, but becomes undefined after the first round of linking
> of the kernel image (.tmp_vmlinux1).
> 
> After playing with it a little bit, we found the creation of vmlinux.o to be
> the problem. Specifically, if we use mold[1] instead of lld to create the
> object and pass it to the later stages of kernel linking, the symbol will be
> properly defined as a data symbol (and the kernel can boot).
> 
> It seems that the issue does not reproduce with LLVM-20. Nevertheless we have
> reported[2] this to upstream llvm.
> 
> [1]: https://github.com/rui314/mold
> [2]: https://github.com/llvm/llvm-project/issues/116575

Sasha pinged me on IRC earlier this week about this series and this
issue, noting that he was unable to reproduce it with a similar
toolchain version and the instructions above. I was able to confirm that
at 6.17-rc1 with this patch set applied (after fixing a couple of minor
conflicts), I no longer see this boot issue but it is still reproducible
on 6.12.

In attempting to narrow my bisect window to find what patch fixes this
issue, I noticed that this configuration actually fails to build with

  Absolute reference to symbol '__llvm_prf_cnts' not permitted in .head.text

in 6.15 and 6.14 as a result of Ard's commit faf0ed487415 ("x86/boot:
Reject absolute references in .head.text"). Bisecting between 6.15 and
6.16 reveals Ard's commit a3cbbb4717e1 ("x86/boot: Move SEV startup code
into startup/") resolves the build error and that kernel boots, which
seems to make sense to me given what code was involved here. It is
possible that arch/x86/boot/startup will want 'LLVM_COV_PROFILE := n'
since all other instrumentation is disabled.

I built v6.17-rc1 + this series with a fuller distribution configuration
and CONFIG_LLVM_COV_PROFILE_ALL=y. That kernel boots fine in QEMU but I
have done no further evaluation.

Cheers,
Nathan


Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC44EE6ADE2
	for <linux-um@archiver.kernel.org>; Sat, 23 Nov 2024 04:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nFI9JpuuQ1p7CvEthBSfXJRoZ51aDWsY9GoLBE194EI=; b=wNm37qucG1RqnvTjdMEvouZAe2
	oLAdwbGHsLsS9o6WtDoMa1zFHMQnhHjNhSl5wugplfAhGgvxdiiiIFlKjfW/mRpIVWYA6CjmMFzaJ
	IJDVPF6RWVgThoVzjILE5lKWEvDrViNPKNbeo32ESyf1rKZqACK8nK2Svi2s2CJE5kU2uccyiJgO/
	wC5rHDlRnHfjviDEgGXiOs/X/BK379BYiesiyEW1BGRoO7BByWqg39iedWR5/06rVN5q5jXUS7GRE
	PWfzFQtEagqf2IXKpSrwmGsSbPV1nMBfe3agKTApvRzXoZEZGeMpArv4m3TLwUaeXhWv2+/9aBxLS
	KFGyq2kA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEhvd-00000003l01-3npg;
	Sat, 23 Nov 2024 04:39:29 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEhvb-00000003kz9-45Zw
	for linux-um@lists.infradead.org;
	Sat, 23 Nov 2024 04:39:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 343215C1049;
	Sat, 23 Nov 2024 04:38:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7B3C4CECD;
	Sat, 23 Nov 2024 04:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732336766;
	bh=RSjYYjrrzb2PbRZF/14EK1yzOHGZbo8F7kcCSSaYqTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E+P2EpSoNxCd1yzDpF+ymxHEr3YHldUzBDgEr5AciDyxvtgFuqiLFc8KmtFYq9k0W
	 N9yhgMqy74SeJEeiPDT2AIvfo8R2dgwVobpHr9ZwYzsWPCatVlPp01CKL/LPv+Rey5
	 3JtyP/pOWgk7cYnXO02Iyi14js/q3aQpGu7Wnt8XSgXVLFlqmPb48QgNHSrUdvZmJn
	 cEwDNkpqAbO26SWyeGFLYopzrXtjpe0GGWEsqwoJHeebvErsSEh5TAraAlQTg8ZCVO
	 tY7zEKAnMUjlbQWWk2B4+i862CLdVDTJyYs/RUD3Uq7aYDaK7nnEfD2RXjGykKyOp3
	 jH+Uza90NK4Ig==
Date: Fri, 22 Nov 2024 21:39:22 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Jinghao Jia <jinghao7@illinois.edu>
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
Message-ID: <20241123043922.GA584876@thelio-3990X>
References: <20241002045347.GE555609@thelio-3990X>
 <20241002064252.41999-1-wentaoz5@illinois.edu>
 <20241003232938.GA1663252@thelio-3990X>
 <284fe8fa-c094-49b7-8e16-3318676d38e3@illinois.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <284fe8fa-c094-49b7-8e16-3318676d38e3@illinois.edu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241122_203928_095033_A556D863 
X-CRM114-Status: GOOD (  33.56  )
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

Hi Jinghao,

On Thu, Nov 21, 2024 at 11:05:14PM -0600, Jinghao Jia wrote:
> Wentao and I were looking into this issue in the past weeks. The high level
> conclusion is that it seems to be some problem with lld and I will go over the
> detail here.

Thanks a lot for looking into this!

> On 10/3/24 6:29 PM, Nathan Chancellor wrote:
> > I seem to have narrowed down it to a few different configurations on top
> > of x86_64_defconfig but I will include the full bad configuration as an
> > attachment just in case anything else is relevant.
> > 
> > $ echo 'CONFIG_LLVM_COV_KERNEL=y
> > CONFIG_LLVM_COV_PROFILE_ALL=y' >kernel/configs/llvm_cov.config
> > 
> > $ echo CONFIG_FORTIFY_SOURCE=y >kernel/configs/fortify_source.config
> > 
> > $ echo CONFIG_AMD_MEM_ENCRYPT=y >arch/x86/configs/amd_mem_encrypt.config
> > 
> > $ /usr/bin/time -v make -skj"$(nproc)" ARCH=x86_64 LLVM=1 mrproper {def,amd_mem_encrypt.,fortify_source.,llvm_cov.}config bzImage
> > ...
> > vmlinux.o: warning: objtool: __sev_es_nmi_complete+0x6e: call to kasan_check_write() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: do_syscall_64+0x141: call to lockdep_hardirqs_off() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: do_int80_emulation+0x138: call to lockdep_hardirqs_off() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: handle_bug+0x5: call to kmsan_unpoison_entry_regs() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0x105: call to lockdep_hardirqs_off() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: syscall_exit_to_user_mode+0x73: call to user_enter_irqoff() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0x105: call to lockdep_hardirqs_off() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: irqentry_exit_to_user_mode+0x62: call to user_enter_irqoff() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: irqentry_enter+0x45: call to lockdep_hardirqs_off() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: irqentry_exit+0x4a: call to lockdep_hardirqs_on() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: irqentry_nmi_enter+0x4: call to lockdep_off() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: irqentry_nmi_exit+0x67: call to lockdep_on() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: enter_s2idle_proper+0xb5: call to lockdep_hardirqs_off() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: cpuidle_enter_state+0x113: call to lockdep_hardirqs_off() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: default_idle_call+0xad: call to lockdep_hardirqs_on() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: cpu_idle_poll+0x29: call to lockdep_hardirqs_on() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: acpi_idle_enter_bm+0x118: call to lockdep_hardirqs_on() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: acpi_idle_do_entry+0x4: call to perf_lopwr_cb() leaves .noinstr.text section
> > ...
> >         User time (seconds): 670.86
> >         System time (seconds): 459.05
> >         Percent of CPU this job got: 169%
> >         Elapsed (wall clock) time (h:mm:ss or m:ss): 11:06.15
> >         Average shared text size (kbytes): 0
> >         Average unshared data size (kbytes): 0
> >         Average stack size (kbytes): 0
> >         Average total size (kbytes): 0
> >         Maximum resident set size (kbytes): 38644844
> >         Average resident set size (kbytes): 0
> >         Major (requiring I/O) page faults: 18694
> >         Minor (reclaiming a frame) page faults: 23068856
> >         Voluntary context switches: 32215431
> >         Involuntary context switches: 46422
> >         Swaps: 0
> >         File system inputs: 0
> >         File system outputs: 40127696
> >         Socket messages sent: 0
> >         Socket messages received: 0
> >         Signals delivered: 0
> >         Page size (bytes): 4096
> >         Exit status: 0
> > 
> > $ curl -LSs https://urldefense.com/v3/__https://github.com/ClangBuiltLinux/boot-utils/releases/download/20230707-182910/x86_64-rootfs.cpio.zst__;!!DZ3fjg!7BrjObiTQ7yWOq1feQGQPxe3uzUM5t4pPHkLUuijWyjOwoaX2rdCwZoD4P52pNU_t1tCT2OCWV3GPtNnAw8$  | zstd -d >rootfs.cpio
> > 
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
> It seems that the issue does not reproduce with LLVM-20.

I just ran my original reproducer with a version of ld.lld from LLVM
main (132de3a71f581dcb008a124d52c83ccca8158d98) and I still see the boot
hang, so it seems like it might still be relevant there? Or am I
misunderstanding your comment here?

> Nevertheless we have reported[2] this to upstream llvm.

Thank you for reporting this upstream. Hopefully Fangrui or someone more
familiar with LLD internals can take a look. I am guessing it is not too
easy to get a concise reproducer for this behavior.

> [1]: https://github.com/rui314/mold
> [2]: https://github.com/llvm/llvm-project/issues/116575
> 
> P.S.: We used mold because gnu ld is simply too slow with all these llvm-cov
> sections -- the vmlinux.o step ran for 10+ hours and still didn't stop. At the
> same time, the fact that the creation of vmlinux.o does not use a linker script
> allows us to directly plug mold in.

Hmmm, that seems like it might be worth reporting to binutils upstream
to see if that is a bug or expected.

Cheers,
Nathan


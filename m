Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 814BAD10BF5
	for <linux-um@archiver.kernel.org>; Sat, 26 Oct 2024 10:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GsGqTJYkQY2mvDj2S4lAf7DYdVtXmK7XJ/ip7jWfqFc=; b=kj2OKpPFApIW1ACI3ei0+hQRX7
	BR+Fe/nQW83Xh5JP/P31w+e8zdK1NK2Bix6rHO9AKY1FZ1JNxRfSsb4DMKfRct6oYpSiLFxx4FDhG
	r+nYLQ7nw1ylJOaApcnm+uFaZLCZ6LY0NcaRoxFb6sxIeh5ECVkdttRdQ3Ip72qcd2WGC/+QIuzty
	xt0W7sEzcsHWhiyNV4/j+d9+L7NlyW2StQWXYX15kNA4cNV8kT18CKHETMcFiEilZze3p9iy7iMOG
	Z8vz/WUDh2q6n83wjmEf895tJNps7j3x8vLHy2mk2+foQnVkxaz8afwSYAIk4WsJnaWVKYBljfLnr
	6BSZnaFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4dtD-00000006MJg-0rZO;
	Sat, 26 Oct 2024 10:19:23 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4dt9-00000006MIe-0ARA
	for linux-um@lists.infradead.org;
	Sat, 26 Oct 2024 10:19:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=GsGqTJYkQY2mvDj2S4lAf7DYdVtXmK7XJ/ip7jWfqFc=;
	t=1729937956; x=1731147556; b=ahttPe9q1d0upqVp6XQjVv1smNescAY6FJdS14ZwsX5SING
	sgdtJtnUs7rwfNpzLr1uoR2P0xFnYQKY2v1IWF4VVmlkMaVpmqBI01Uv0LSStLBFnuAEx8yUSDZEp
	NMNhcT0KrM2uhGOLilwK9nFA1lXQEhlt5L3Ts97loicW+/zYILlbCnIjYH2SEs1vTfrvVgdbsoxh+
	0Bj2tEeCgY8aRmybjIj8+ZXlGnpHWnNwZOoeglsArQbzXLtEpJZknocfMHB7V5lIfbIFR4St2nlQt
	EBifuXdUyjHY2ExZXnh4maIA1D4HToAITkKds5tHiI8BNHbsVQeFYrakuU6oEprg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1t4dt1-00000005MIu-2ea7;
	Sat, 26 Oct 2024 12:19:12 +0200
Message-ID: <f482739aa05abd80479804054e4affe23f0dc6c5.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 00/13] nommu UML
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org, 
	jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, 
	johannes@sipsolutions.net
Cc: ricarkol@google.com
Date: Sat, 26 Oct 2024 12:19:08 +0200
In-Reply-To: <cover.1729770373.git.thehajime@gmail.com>
References: <cover.1729770373.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241026_031919_411250_965EFD77 
X-CRM114-Status: GOOD (  53.97  )
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

Hi,

On Thu, 2024-10-24 at 21:09 +0900, Hajime Tazaki wrote:
> This is a series of patches of nommu arch addition to UML.=C2=A0 It would
> be nice to ask comments/opinions on this.
>=20
> There are several limitations/issues which we already found; here is
> the list of those issues.
>=20
> - prompt configured with /etc/profile is broken (variables are not
> =C2=A0 expanded, ${HOSTNAME%%.*}:$PWD#)
> - there are no mechanism implemented to cache for mapped memory of
> =C2=A0 exec(2) thus, always read files from filesystem upon every exec,
> =C2=A0 which makes slow on some benchmark (lmbench).
> - a crash on userspace programs crashes a UML kernel, not signaling
> =C2=A0 with SIGSEGV to the program.
> - commit c27e618 (during v6.12-rc1 merge) introduces invalid access to
> =C2=A0 a vma structure for our case, which updates the internal procedure
> =C2=A0 of maple_tree subsystem.=C2=A0 We're trying to fix issue but still=
 a
> =C2=A0 random process on exit(2) crashes.

Btw. are you handling FP register save/restore? If it is not there, it
probably would not be too hard to add (XSAVE, etc.), though it might
add a bit of additional overhead. Especially as UML always saves the FP
state rather than optimizing it like the x86 architectures.


I am a bit confused overall. I mean, zpoline seems kind of neat, but a
requirement on patching userspace code also seems like a lot.

To me, it seems much more natural to catch the userspace syscalls using
a SECCOMP filter[1]. While quite a lot slower, that should be much more
portable across architectures. For improved speed one could still do
architecture specific things inside the vDSO or by using zpoline. But
those would then "just" be optimizations and unpatched code would still
work correctly (e.g. JIT).

For me, a big argument in favour of such an approach is its simplicity.
I am mostly basing that on the fact that this patchset should properly
handle other signals like SIGFPE and SIGSEGV. And, once it does that,
you will already have all the infrastructure to do the correct register
save/restore using the host mcontex, which is what is needed in the
SIGSYS handler when using SECCOMP. The filter itself should be simple
as it just needs to catch all syscalls within valid userspace
executable memory[2] ranges.

Benjamin

[1] Maybe not surprising, as I have been working on a SECCOMP based UML
that does not require ptrace.
[2] I am assuming that userspace executable code is already confined to
a certain address space within the UML process. Obviously, the kernel
itself and loaded modules need to be free to do host syscalls and
should not be affected by the SECCOMP filter.



>=20
> UML has been built with CONFIG_MMU since day 0.=C2=A0 The feature
> introduces the nommu mode in a different angle from what Linux Kernel
> Library tried.
>=20
>=20
> What is it for ?
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> - Alleviate syscall hook overhead implemented with ptrace(2)
> - To exercises nommu code over UML (and over KUnit)
> - Less dependency to host facilities
>=20
>=20
> How it works ?
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> To illustrate how this feature works, the below shows how syscalls are
> called under nommu/UML environment.
>=20
> - boot kernel, setup zpoline trampoline code (detailed later) at address =
0x0
> - (userspace starts)
> - calls vfork/execve syscalls
> - during execve, more specifically during load_elf_fdpic_binary()
> =C2=A0 function, kernel translates `syscall/sysenter` instructions with `=
call
> =C2=A0 *%rax`, which usually point to address 0 to NR_syscalls (around
> =C2=A0 512), where trampoline code was installed during startup.
> - when syscalls are issued by userspace, it jumps to *%rax, slides
> =C2=A0 until `nop` instructions end, and jump to hooked function,
> =C2=A0 `__kernel_vsyscall`, which is an entrypoint for syscall under nomm=
u
> =C2=A0 UML environment.
> - call handler function in sys_call_table[] and follow how UML syscall
> =C2=A0 works.
> - return to userspace
>=20
>=20
> What are the differences from MMU-full UML ?
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> The current nommu implementation adds 3 different functions which
> MMU-full UML doesn't have:
>=20
> - kernel address space can directly be accessible from userspace
> =C2=A0 - so, uaccess() always returns 1
> =C2=A0 - generic implementation of memcpy/strcpy/futex is also used
> - alternate syscall entrypoint without ptrace
> - translation of syscall/sysenter instructions to a trampoline code
> =C2=A0 and syscall hooks
>=20
> With those modifications, it allows us to use unmodified userspace
> binaries with nommu UML.
>=20
>=20
> History
> =3D=3D=3D=3D=3D=3D=3D
>=20
> This feature was originally introduced by Ricardo Koller at Open
> Source Summit NA 2020, then integrated with the syscall translation
> functionality with the clean up to the original code.
>=20
> Building and run
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> ```
> % make ARCH=3Dum x86_64_nommu_defconfig
> % make ARCH=3Dum
> ```
>=20
> will build UML with CONFIG_MMU=3Dn applied.
>=20
> Kunit tests can run with the following command:
>=20
> ```
> % ./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_MMU=3Dn
> ```
>=20
> To run a typical Linux distribution, we need nommu-aware userspace.
> We can use a stock version of Alpine Linux with nommu-built version of
> busybox and musl-libc.
>=20
>=20
> Preparing root filesystem
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>=20
> nommu UML requires to use a specific standard library which is aware
> of nommu kernel.=C2=A0 We have tested custom-build musl-libc and busybox,
> both of which have built-in support for nommu kernels.
>=20
> There are no available Linux distributions for nommu under x86_64
> architecture, so we need to prepare our own image for the root
> filesystem.=C2=A0 We use Alpine Linux as a base distribution and replace
> busybox and musl-libc on top of that.=C2=A0 The following are the step to
> prepare the filesystem for the quick start.
>=20
> ```
> =C2=A0=C2=A0=C2=A0=C2=A0 container_id=3D$(docker create ghcr.io/thehajime=
/alpine:3.20.3-um-nommu)
> =C2=A0=C2=A0=C2=A0=C2=A0 docker start $container_id
> =C2=A0=C2=A0=C2=A0=C2=A0 docker wait $container_id
> =C2=A0=C2=A0=C2=A0=C2=A0 docker export $container_id > alpine.tar
> =C2=A0=C2=A0=C2=A0=C2=A0 docker rm $container_id
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 mnt=3D$(mktemp -d)
> =C2=A0=C2=A0=C2=A0=C2=A0 dd if=3D/dev/zero of=3Dalpine.ext4 bs=3D1 count=
=3D0 seek=3D1G
> =C2=A0=C2=A0=C2=A0=C2=A0 sudo chmod og+wr "alpine.ext4"
> =C2=A0=C2=A0=C2=A0=C2=A0 yes 2>/dev/null | mkfs.ext4 "alpine.ext4" || tru=
e
> =C2=A0=C2=A0=C2=A0=C2=A0 sudo mount "alpine.ext4" $mnt
> =C2=A0=C2=A0=C2=A0=C2=A0 sudo tar -xf alpine.tar -C $mnt
> =C2=A0=C2=A0=C2=A0=C2=A0 sudo umount $mnt
> ```
>=20
> This will create a file image, `alpine.ext4`, which contains busybox
> and musl with nommu build on the Alpine Linux root filesystem.=C2=A0 The
> file can be specified to the argument `ubd0=3D` to the UML command line.
>=20
> ```
> =C2=A0 ./vmlinux eth0=3Dtuntap,tap100,0e:fd:0:0:0:1,172.17.0.1 ubd0=3D./a=
lpine.ext4 rw mem=3D1024m loglevel=3D8 init=3D/sbin/init
> ```
>=20
> We plan to upstream apk packages for busybox and musl so that we can
> follow the proper procedure to set up the root filesystem.
>=20
>=20
> Quick start with docker
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> There is a docker image that you can quickly start with a simple step.
>=20
> ```
> =C2=A0 docker run -it -v /dev/shm:/dev/shm --rm ghcr.io/thehajime/alpine:=
3.20.3-um-nommu
> ```
>=20
> This will launch a UML instance with an pre-configured root filesystem.
>=20
> Benchmark
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> The below shows an example of performance measurement conducted with
> lmbench and (self-crafted) getpid benchmark (with v6.12-rc3 linus tree).
>=20
> ### lmbench (usec)
>=20
> > > native|um|um-nommu|
> > --|--|--|--|
> > select-10=C2=A0=C2=A0=C2=A0 |0.5645|28.3738|0.2647|
> > select-100=C2=A0=C2=A0 |2.3872|28.8385|1.1021|
> > select-1000=C2=A0 |20.5527|37.6364|9.4264|
> > syscall=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |0.1735|26.8711|0.1037|
> > read=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |0.3442|28.5771|0.=
1370|
> > write=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |0.2862|28.7340|0.1236|
> > stat=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |1.9236|38.5928|0.=
4640|
> > open/close=C2=A0=C2=A0 |3.8308|66.8451|0.7789|
> > fork+sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |1176.4444|8221.5000|21443.0000|
> > fork+execve=C2=A0 |533.1053|3034.5000|4894.3333|
>=20
> ### do_getpid bench (nsec)
>=20
> > > native|um|um-nommu|
> > --|--|--|--|
> > getpid | 180 | 31579 | 101|
>=20
>=20
> Limitations
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> generic nommu limitations
> -------------------------
> Since this port is a kernel of nommu architecture so, the
> implementation inherits the characteristics of other nommu kernels
> (riscv, arm, etc), described below.
>=20
> - vfork(2) should be used instead of fork(2)
> - ELF loader only loads PIE (position independent executable) binaries
> - processes share the address space among others
> - mmap(2) offers a subset of functionalities (e.g., unsupported
> =C2=A0 MMAP_FIXED)
>=20
> Thus, we have limited options to userspace programs.=C2=A0 We have tested
> Alpine Linux with musl-libc, which has a support nommu kernel.
>=20
> access to mmap_min_addr
> ----------------------
> As the mechanism of syscall translations relies on an ability to
> write/read memory address zero (0x0), we need to configure host kernel
> with the following command:
>=20
> ```
> % sh -c "echo 0 > /proc/sys/vm/mmap_min_addr"
> ```
>=20
> supported architecture
> ----------------------
> The current implementation of nommu UML only works on x86_64 SUBARCH.
> We have not tested with 32-bit environment.
>=20
> target of syscall translation
> -----------------------------
> The syscall translation only applies to the executable and interpreter
> of ELF binary files which are processed by execve(2) syscall for the
> moment: other libraries such as linked library and dlopen-ed one
> aren't translated; we may be able to trigger the translation by
> LD_PRELOAD.
>=20
> Note that with musl-libc in Alpine Linux which we've been tested, most
> of syscalls are implemented in the interpreter file
> (ld-musl-x86_64.so) and calling syscall/sysenter instructions from the
> linked/loaded libraries might be rare.=C2=A0 But it is definitely possibl=
e
> so, a workaround with LD_PRELOAD is effective.
>=20
>=20
> Further readings about NOMMU UML
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> - NOMMU UML (original code by Ricardo Koller)
> https://static.sched.com/hosted_files/ossna2020/ec/kollerr_linux_um_nommu=
.pdf
>=20
> - zpoline: syscall translation mechanism
> https://www.usenix.org/conference/atc23/presentation/yasukata
> Please review the following changes for suitability for inclusion. If you=
 have
> any objections or suggestions for improvement, please respond to the patc=
hes. If
> you agree with the changes, please provide your Acked-by.
>=20
> The following changes since commit c2ee9f594da826bea183ed14f2cc029c719bf4=
da:
>=20
> =C2=A0 KVM: selftests: Fix build on on non-x86 architectures (2024-10-21 =
15:49:33 -0700)
>=20
> are available in the Git repository at:
>=20
> =C2=A0 https://github.com/thehajime/linux=C2=A082a7ee8b31c51edb47e1449225=
81824a3b5e371d
> =C2=A0 https://github.com/thehajime/linux/tree/um-nommu-v6.12-rc4-rfc
>=20
> Hajime Tazaki (13):
> =C2=A0 fs: binfmt_elf_efpic: add architecture hook elf_arch_finalize_exec
> =C2=A0 x86/um: nommu: elf loader for fdpic
> =C2=A0 um: nommu: memory handling
> =C2=A0 x86/um: nommu: syscall handling
> =C2=A0 x86/um: nommu: syscall translation by zpoline
> =C2=A0 x86/um: nommu: process/thread handling
> =C2=A0 um: nommu: configure fs register on host syscall invocation
> =C2=A0 x86/um/vdso: nommu: vdso memory update
> =C2=A0 x86/um: nommu: signal handling
> =C2=A0 x86/um: nommu: stack save/restore on vfork
> =C2=A0 um: change machine name for uname output
> =C2=A0 um: nommu: add documentation of nommu UML
> =C2=A0 um: nommu: plug nommu code into build system
>=20
> =C2=A0Documentation/virt/uml/nommu-uml.rst=C2=A0=C2=A0=C2=A0 | 219 ++++++=
+++++++++++++++++
> =C2=A0arch/um/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 13 +-
> =C2=A0arch/um/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 6 +
> =C2=A0arch/um/configs/x86_64_nommu_defconfig=C2=A0 |=C2=A0 64 +++++++
> =C2=A0arch/um/include/asm/futex.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +
> =C2=A0arch/um/include/asm/mmu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +
> =C2=A0arch/um/include/asm/mmu_context.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 14 +-
> =C2=A0arch/um/include/asm/ptrace-generic.h=C2=A0=C2=A0=C2=A0 |=C2=A0 17 +=
+
> =C2=A0arch/um/include/asm/tlbflush.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 23 ++-
> =C2=A0arch/um/include/asm/uaccess.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +-
> =C2=A0arch/um/include/shared/common-offsets.h |=C2=A0=C2=A0 3 +
> =C2=A0arch/um/include/shared/os.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 9 +
> =C2=A0arch/um/kernel/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +-
> =C2=A0arch/um/kernel/exec.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 8 +
> =C2=A0arch/um/kernel/mem.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 13 ++
> =C2=A0arch/um/kernel/physmem.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 +
> =C2=A0arch/um/kernel/process.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 34 +++-
> =C2=A0arch/um/kernel/skas/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +-
> =C2=A0arch/um/kernel/trap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 4 +
> =C2=A0arch/um/os-Linux/main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 5 +
> =C2=A0arch/um/os-Linux/process.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 22 +++
> =C2=A0arch/um/os-Linux/skas/process.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +
> =C2=A0arch/um/os-Linux/start_up.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 47 +++++
> =C2=A0arch/um/os-Linux/time.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +-
> =C2=A0arch/um/os-Linux/util.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +-
> =C2=A0arch/x86/um/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 18 ++
> =C2=A0arch/x86/um/asm/elf.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 12 =
+-
> =C2=A0arch/x86/um/asm/module.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 19 +-
> =C2=A0arch/x86/um/asm/processor.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 12 ++
> =C2=A0arch/x86/um/do_syscall_64.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 113 ++++++++++++
> =C2=A0arch/x86/um/entry_64.S=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 110 +++++++++++=
+
> =C2=A0arch/x86/um/shared/sysdep/syscalls_64.h |=C2=A0=C2=A0 4 +
> =C2=A0arch/x86/um/signal.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 26 +++
> =C2=A0arch/x86/um/syscalls_64.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 67 +++++++
> =C2=A0arch/x86/um/vdso/um_vdso.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 20 +++
> =C2=A0arch/x86/um/vdso/vma.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 16 +-
> =C2=A0arch/x86/um/zpoline.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 228 +++++=
+++++++++++++++++++
> =C2=A0fs/Kconfig.binfmt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0fs/binfmt_elf_fdpic.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 10 =
++
> =C2=A039 files changed, 1164 insertions(+), 35 deletions(-)
> =C2=A0create mode 100644 Documentation/virt/uml/nommu-uml.rst
> =C2=A0create mode 100644 arch/um/configs/x86_64_nommu_defconfig
> =C2=A0create mode 100644 arch/x86/um/do_syscall_64.c
> =C2=A0create mode 100644 arch/x86/um/entry_64.S
> =C2=A0create mode 100644 arch/x86/um/zpoline.c
>=20



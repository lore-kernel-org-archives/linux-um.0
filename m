Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD2DEDB7ED
	for <linux-um@archiver.kernel.org>; Tue,  7 Apr 2026 10:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Okc/NGVzKgwXO9HqRPceYseMQLICRsIHcETO9XgZCf0=; b=BVGstEeKOUIOFCLUSq4GwTpZ/j
	XL7fHF1H5JoIH4lDE/MmyZYR4Z3nIrNBR/7UaaJIu74YqdTF2Q+Qqg/l5fvaq+KQhnspDZv/qp6XZ
	r+jInRq5G2gPzBFg81lDAlemDL9YD1Kcng/OmyQwUHdGfbMqAIYR87bI0uEmiu9jfDJMrRXGjTi7E
	vmSbEvE/wQ2XvH0LSQ+YX5eBfA87wUWK6HUBnfPFSiWKBgLBNq6LQiADc52sTXwmZCvBgabWEoerD
	8JgkVsRJZr+/Whuph0AuW7p1OZcsaXuJvfmdjYgIMGxhCx7dq0xK05BdzAslVcC4d7oNQzbiHMAw9
	ELv0eG5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wA3YV-00000006HEb-2vrE;
	Tue, 07 Apr 2026 10:21:11 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wA3YQ-00000006HDc-0JwY
	for linux-um@lists.infradead.org;
	Tue, 07 Apr 2026 10:21:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Okc/NGVzKgwXO9HqRPceYseMQLICRsIHcETO9XgZCf0=;
	t=1775557265; x=1776766865; b=CnFz0liZwc6YfDhfLosxhWYrozRTG+u5QH2jCeqQG4/X5n+
	Vv1dTVjhV/ofwx+h9+vP/m4rMkldeA0WPwYP3H1sY+nogZhtRh9moCovPiP/r9Z2AQSBN1S/E8ot+
	CsgdtHACkuC2TpdDjk8e7GA1iTFF/AJy+hlRQ4WoHxHkEUB9LNEjQ5/6teXAUyNWJENtHmuTIZU6r
	DXtn6mMsTC6pwL2qO81lNew/7bBSRR51VfMLsI4WXxRA3MMqxqSs/A5rdIOI6lWzUH/uMYIcqdP/q
	obwULSXDSulsVPqttUilBVZ4p+2h+GiwYKBFSoUD7uqpe+imUC1ED3KqZ5UsAUnQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1wA3YL-0000000CF8J-3qop;
	Tue, 07 Apr 2026 12:21:02 +0200
Message-ID: <31ea232d4b85e0c2b2931010e426c45a0650c297.camel@sipsolutions.net>
Subject: Re: 6.13+ uml crash
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Maciej =?UTF-8?Q?=C5=BBenczykowski?= <maze@google.com>
Cc: "Berg, Johannes" <johannes.berg@intel.com>,
 linux-um@lists.infradead.org,  Tiwei Bie <tiwei.btw@antgroup.com>
Date: Tue, 07 Apr 2026 12:21:01 +0200
In-Reply-To: <CANP3RGdxC=w=Tqq_A9DVYig_dYfhBficmU9vQCySoCx72oCckA@mail.gmail.com> (sfid-20260407_114803_248342_1ACFC8FA)
References: <CANP3RGd1SYY-Xakfq93Ttb-m1xXWdMAq=HEJMk6-KMcGmPWMtg@mail.gmail.com>
	 <CANP3RGeOQa_s5ZyCp9MBVAR3cAz25=t=sYCdQgjsPCmA25F3=w@mail.gmail.com>
	 <PH8PR11MB8285E84708CCB0C5799C1B4DE95AA@PH8PR11MB8285.namprd11.prod.outlook.com>
	 <CANP3RGec_Skbzm3OFFhSJRFigsoQQ8hRL3JJxsVYMz3QtoguXA@mail.gmail.com>
	 <9960ac97a83c4d37da513644b5019f96e03b55f2.camel@sipsolutions.net>
	 <CANP3RGdxC=w=Tqq_A9DVYig_dYfhBficmU9vQCySoCx72oCckA@mail.gmail.com>
	 (sfid-20260407_114803_248342_1ACFC8FA)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260407_032106_481797_3B67076C 
X-CRM114-Status: GOOD (  46.63  )
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

On Tue, 2026-04-07 at 02:47 -0700, Maciej =C5=BBenczykowski wrote:
> On Tue, Apr 7, 2026 at 5:01=E2=80=AFPM Benjamin Berg <benjamin@sipsolutio=
ns.net> wrote:
> > you get an ESRCH error, which means that either the UML userspace
> > process does not exist or maybe we do not have permission to trace for
> > some reason.
> >=20
> > Now, the difference is that before the patch UML would just clone to
> > create the userspace processes. After the patch, it will execve() into
> > a separate executable that exists only as a memfd.
> >=20
> > I am noticing now, that we are doing the PTRACE_TRACEME inside the new
> > executable instead of the usual method of doing it before execve. So
> > maybe that makes a difference with AppArmor.
> >=20
> > So, I think you can do two things:
> > =C2=A0=C2=A0 1. As a quick workaround, simply use "seccomp=3Don".
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 However, the sandboxing of the userspace=
 processes is not quite
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 as secure if you do that (i.e. they curr=
ently can break out and
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 make host syscalls).
>=20
> I tried the breaking commit, and 6.13.latest but it doesn't appear to
> support seccomp=3Don
>=20
> I tried 6.18.latest but it fails to build for me with
>=20
> In file included from ./include/linux/unwind_user.h:6,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/unwind_deferred.h:6,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from kernel/fork.c:108:
> ./arch/x86/include/asm/unwind_user.h: In function =E2=80=98unwind_user_wo=
rd_size=E2=80=99:
> ./arch/x86/include/asm/unwind_user.h:23:17: error: =E2=80=98struct pt_reg=
s=E2=80=99
> has no member named =E2=80=98flags=E2=80=99
> =C2=A0=C2=A0 23 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (reg=
s->flags & X86_VM_MASK)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~
> =C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/ipv6/addrconf.o
> ./arch/x86/include/asm/unwind_user.h:23:27: error: =E2=80=98X86_VM_MASK=
=E2=80=99
> undeclared (first use in this function)
> =C2=A0=C2=A0 23 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (reg=
s->flags & X86_VM_MASK)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~
> ./arch/x86/include/asm/unwind_user.h:23:27: note: each undeclared
> identifier is reported only once for each function it appears in
> =C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block/blk-settings.o
> =C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/core/net_namespace.o
> ./arch/x86/include/asm/unwind_user.h:26:14: error: implicit
> declaration of function =E2=80=98user_64bit_mode=E2=80=99
> [-Wimplicit-function-declaration]
> =C2=A0=C2=A0 26 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!us=
er_64bit_mode(regs))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~
>=20
> it's likely related to some combination of kconfig options needed for
> android net tests...
>=20
> 6.16.latest builds but still crashes (not sure if it supports
> seccomp=3Don), but the crash is different:

The below trace uses seccomp mode. In this case, it looks to me like
the stub process died on us during startup. I am kind of thinking that
in the ptrace case the stub executed but we couldn't trace it (i.e. it
likely managed to do the self kill with SIGSTOP in real_init, see
below).

I guess you'll need to debug it some more.

You could try to add some more logging, to e.g. print the status code
in os_reap_child. That information is missing in the log and may tell
you what failed when starting the stub process.

So, what you are looking at is:
 * start_userspace, clone() a new process
 * userspace_tramp, sets up the FDs
 * userspace_tramp, execve() the memfd
 * real_init in stub_exe.c continues and sets up the stub
   - sets up required memory maps and FDs
   - in seccomp mode, installs SECCOMP filters, etc.
   - in ptrace mode, does PTRACE_TRACEME and sends SIGSTOP to itself

Note that you cannot do much in stub_exe.c, which is why it uses
different exit codes to convey the error.

In seccomp mode you should be able to "strace -f" the UML process,
which should show you what is happening to the stub.

Not sure I can help more than this though.

Benjamin

> Run /sbin/net_test.sh as init process
> Unexpectedly lost MM child! Affected tasks will segfault.
> wait_stub_done_seccomp : failed to wait for stub, pid =3D -1, errno =3D 0
> Kernel panic - not syncing: Attempted to kill init! exitcode=3D0x0000000b
> CPU: 0 UID: 0 PID: 1 Comm: net_test.sh Not tainted 6.16.12-g7e13344d2211 =
#4 NONE
> Stack:
> =C2=A080803b60 6063f23b 6051b353 00000000
> =C2=A000000001 6063f23b 606314ef 60027dfc
> =C2=A080803b90 6002f679 60c70000 609374c0
> Call Trace:
> =C2=A0[<60027dfc>] ? _printk+0x0/0x57
> =C2=A0[<6003237a>] show_stack+0x10b/0x11a
> =C2=A0[<6051b353>] ? dump_stack_print_info+0x0/0x12b
> =C2=A0[<60027dfc>] ? _printk+0x0/0x57
> =C2=A0[<6002f679>] dump_stack_lvl+0x5e/0x79
> =C2=A0[<6002f6ae>] dump_stack+0x1a/0x1c
> =C2=A0[<60026626>] panic+0x156/0x377
> =C2=A0[<6003ff78>] ? unblock_signals+0x25/0x28
> =C2=A0[<6003ffa1>] ? um_set_signals+0x26/0x3e
> =C2=A0[<600264d0>] ? panic+0x0/0x377
> =C2=A0[<60049fd8>] do_exit+0x205/0x9f6
> =C2=A0[<60162f26>] ? kmem_cache_free+0x118/0x12b
> =C2=A0[<6004a9ff>] sys_exit_group+0x0/0x16
> =C2=A0[<60055d9c>] get_signal+0x7dc/0x803
> =C2=A0[<600555c0>] ? get_signal+0x0/0x803
> =C2=A0[<6004349c>] ? setup_signal_stack_si+0x0/0x1f0
> =C2=A0[<60055166>] ? signal_setup_done+0x0/0xb1
> =C2=A0[<600320f5>] do_signal+0x54/0x1ce
> =C2=A0[<60539370>] ? _raw_spin_unlock_irqrestore+0x0/0x39
> =C2=A0[<60032db6>] fatal_sigsegv+0x32/0x3e
> =C2=A0[<60041ac6>] wait_stub_done_seccomp+0x2b1/0x2c0
> =C2=A0[<60041efa>] userspace+0xff/0x694
> =C2=A0[<60031769>] ? interrupt_end+0x0/0xac
> =C2=A0[<60179ba4>] ? copy_strings_kernel+0x0/0x9e
> =C2=A0[<6003166a>] new_thread_handler+0x5a/0x5e
> /aosp-tests/net/test/run_net_test.sh: line 503: 939215 Aborted
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (core dumped=
) $KERNEL_BINARY umid=3Dnet_test mem=3D512M
> seccomp=3Don $blockdevice=3D$ROOTFS $netconfig $consolemode ssl3=3Dnull,f=
d:3
> $cmdline 1>&2 3> "${SSL3}"
> Warning: UML exited with 134 instead of zero.
>=20
> > =C2=A0=C2=A0 2. Move the ptrace(PTRACE_TRACEME) call into userspace_tra=
mp to
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 check if AppArmor is permitting ptrace t=
hen.
>=20
> haven't yet had time to try this approach.


Benjamin

>=20
> >=20
> > Benjamin
> >=20
> > On Tue, 2026-04-07 at 15:15 +0900, Maciej =C5=BBenczykowski wrote:
> > > On Tue, Apr 7, 2026 at 2:56=E2=80=AFPM Berg, Johannes <johannes.berg@=
intel.com> wrote:
> > > > Hi,
> > > >=20
> > > > Haven't looked at this yet - but really better if you CC the UML li=
st.
> > > >=20
> > > > johannes
> > > >=20
> > > > > -----Original Message-----
> > > > > From: Maciej =C5=BBenczykowski <maze@google.com>
> > > > > Sent: Saturday, April 4, 2026 5:25 AM
> > > > > To: Berg, Benjamin <benjamin.berg@intel.com>; Berg, Johannes
> > > > > <johannes.berg@intel.com>; Tiwei Bie <tiwei.btw@antgroup.com>
> > > > > Subject: Re: 6.13+ uml crash
> > > > >=20
> > > > > On Fri, Apr 3, 2026 at 12:34=E2=80=AFPM Maciej =C5=BBenczykowski =
<maze@google.com>
> > > > > wrote:
> > > > > >=20
> > > > > > Host is:
> > > > > >=20
> > > > > > 6.18.14-1rodete1-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.18.14-
> > > > > 1rodete1
> > > > > > (2026-03-06) x86_64 GNU/Linux
> > > > > >=20
> > > > > > /proc/cmdline
> > > > > > ima_hash=3Dsha256 kfence.sample_interval=3D100 intel_iommu=3Dsm=
_off
> > > > > > pci=3Dnoats printk.devkmsg=3Don slab_nomerge
> > > > > > lsm=3Dlandlock,lockdown,yama,loadpin,safesetid,integrity,apparm=
or,selinu
> > > > > > x,smack,tomoyo,bpf
> > > > > > apparmor=3D1 panic=3D30 glinux-boot-image=3Ddefault-20260324.03=
.00
> > > > > > earlycon=3Duart8250,io,0x3f8 console=3DttyS0,115200n8 console=
=3Dhvc0
> > > > > > console=3Dtty0 splash plymouth.ignore-serial-consoles i915.enab=
le_psr=3D0
> > > > > >=20
> > > > > > No SELinux, but I think there is likely some corporate AppArmor=
 policy...
> > > > > >=20
> > > > > > I seem to hit this problem while trying to use UML on latest
> > > > > > 6.13/6.14/6.15/6.16/6.17/6.18/6.19
> > > > > > 6.12 guests are the last ones that work.
> > > > > >=20
> > > > > > I noticed 6.13 had many UML changes...
> > > > > >=20
> > > > > > This is while trying to run the android net tests.
> > > > > >=20
> > > > > > https://android.googlesource.com/kernel/tests/+log/refs/heads/m=
irror-g
> > > > > > oog-main-kernel /aosp-tests/net/test/run_net_test.sh --builder
> > > > > > all_tests.sh
> > > > > >=20
> > > > > > ...
> > > > > > VFS: Mounted root (ext3 filesystem) readonly on device 98:0.
> > > > > > devtmpfs: mounted
> > > > > > This architecture does not have kernel memory protection.
> > > > > > Run /sbin/net_test.sh as init process
> > > > > > Registers -
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0x60025a90
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0x2e2ea5
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0x600423e4
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0x2e2ea8
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0x7fffffffbe30
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0x0
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0x206
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0x0
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0x7fffffffbe30
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 9=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0xffffffff
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 10=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0x0
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 11=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0x7ffff7c40c87
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 12=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0x0
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 13=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0x13
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 14=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0x2e2ea8
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 15=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0x3e
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0x7fffffffc000
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 17=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0x33
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 18=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0x206
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 19=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0x7fffffffeff8
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0x2b
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 21=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0x7ffff7f9d740
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 22=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0x0
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 23=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0x0
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 24=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0x0
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 25=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0x0
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 26=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0x0
> > > > > > Kernel panic - not syncing: do_syscall_stub : PTRACE_SETREGS fa=
iled,
> > > > > > errno =3D 3=C2=A0 [ESRCH]
> > > > > > CPU: 0 UID: 0 PID: 1 Comm: net_test.sh Not tainted
> > > > > > 6.13.12-g2abfa5d47651 #3
> > > > > > Stack:
> > > > > > =C2=A0600277e4 60629dd1 80803d80 00000000
> > > > > > =C2=A000000001 60629dd1 6061c0a9 600277e4
> > > > > > =C2=A080803db0 6002efd2 60c70000 609171c0
> > > > > > Call Trace:
> > > > > > =C2=A0[<600277e4>] ? _printk+0x0/0x57
> > > > > > =C2=A0[<600322ec>] show_stack+0x10b/0x11a
> > > > > > =C2=A0[<600277e4>] ? _printk+0x0/0x57
> > > > > > =C2=A0[<600277e4>] ? _printk+0x0/0x57
> > > > > > =C2=A0[<6002efd2>] dump_stack_lvl+0x5e/0x79=C2=A0 [<6002f007>]
> > > > > > dump_stack+0x1a/0x1c=C2=A0 [<60026838>] panic+0x156/0x377=C2=A0=
 [<600277e4>] ?
> > > > > > _printk+0x0/0x57=C2=A0 [<600266e2>] ? panic+0x0/0x377=C2=A0 [<6=
00277e4>] ?
> > > > > > _printk+0x0/0x57=C2=A0 [<6004555b>] do_syscall_stub+0xa6/0x132
> > > > > > [<60031608>] ? interrupt_end+0x0/0xae=C2=A0 [<6004560b>]
> > > > > > syscall_stub_flush+0x24/0x2e=C2=A0 [<60045daf>] userspace+0x81/=
0x469
> > > > > > [<60031608>] ? interrupt_end+0x0/0xae=C2=A0 [<601761ba>] ?
> > > > > > copy_strings_kernel+0x0/0x9e=C2=A0 [<60031509>]
> > > > > > new_thread_handler+0x5a/0x5e
> > > > > > /aosp-tests/net/test/run_net_test.sh: line 498: 3026597 Aborted
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 (core dumped) $KERNEL_BINARY umid=3Dnet_test mem=3D512M
> > > > > > $blockdevice=3D$ROOTFS $netconfig $consolemode ssl3=3Dnull,fd:3=
 $cmdline
> > > > > > 1>&2 3> "${SSL3}"
> > > > > > Warning: UML exited with 134 instead of zero.
> > > > >=20
> > > > > It appears this broke at:
> > > > >=20
> > > > > commit 32e8eaf263d9be014ba1970444f745682fa9c6c0
> > > > > Author: Benjamin Berg <benjamin.berg@intel.com>
> > > > > =C2=A0=C2=A0=C2=A0 um: use execveat to create userspace MMs
> > > > Intel Deutschland GmbH
> > > > Registered Address: Dornacher Strasse 1, 85622 Feldkirchen, Germany
> > > > Tel: +49 89 991 430, www.intel.de
> > > > Managing Directors: Harry Demas, Jeffrey Schneiderman, Yin Chong So=
rrell
> > > > Chairperson of the Supervisory Board: Nicole Lau
> > > > Registered Seat: Munich
> > > > Commercial Register: Amtsgericht Muenchen HRB 186928
> > >=20
> > > --
> > > Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google
>=20
> --
> Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google


Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43AA5EDB7E0
	for <linux-um@archiver.kernel.org>; Tue,  7 Apr 2026 09:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3s0EL2GK9isiaMh6qYRIskpS648V2bnP/Cut8ycAb74=; b=SoAyamAPrBqApzYQrNBFvg1w92
	EA5krKtSe2z0Bs95U0mbVA3NcTzMPBDQdxVVkV2mx08KhidDYqSZhjDROCe1A6DcAOsqS6bI4p9Ms
	9D0tKVwIwzHQV7ZGgeXplDkZ7yhW2tpSifzmVzCTOoEyg2/6dsBO1U2wfPHcgXuJJJLNUHdMIK7ip
	X43wFNmi57wLkA6eWOn+f+DMVu8TTtereaSLbuMC9NivOMcbnB1Te1JWw7oOAF/d5Dx/g1iqJtpEa
	FzWnj0+pTbOoCIU4aG6G0R96TuoUsicKi4ZWJRTyHKuFQCngIcWk7YH3Nx/o3mUt8EfEYX3PGVKrY
	xzEpwRkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wA32T-00000006FCl-09to;
	Tue, 07 Apr 2026 09:48:05 +0000
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wA32Q-00000006FCN-0wHp
	for linux-um@lists.infradead.org;
	Tue, 07 Apr 2026 09:48:03 +0000
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-50d836552daso1089371cf.0
        for <linux-um@lists.infradead.org>; Tue, 07 Apr 2026 02:48:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775555281; cv=none;
        d=google.com; s=arc-20240605;
        b=FgXdfn8T8+8H0qWk+5LXr2zO4YaIU6J6xJ67sVPdEVDwEg0D0ubtp6ZnGTBOp3lF0V
         rUh9jiRgj1OFX+Yg6BMinCN4zAg8HO56yjcMGKXhT5hirk782tvPvPBlLzYI4rLGp5ko
         iv6Vo/9e2E8SBx7YIrCfTa2Oa0yXZ8jT6y2Qwc0Rs0yDHFAXWjsJOEcLnpCyMefGsxDj
         FfOrNTRRj4NKos2SOZj+pPWKz6zNbO1gyfKAOBcuB5Yiu/I/Pe3Jo73eBZotd6Co88Kh
         tlquGJsdMyy7pGibD3kzDuI7h4CfKldH/qOHaqCpAlvdMvCf3c69JYPnkZHHNqiP/vUk
         Yrsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3s0EL2GK9isiaMh6qYRIskpS648V2bnP/Cut8ycAb74=;
        fh=OrdBwwTTR/nchsXbIOLGI/WlF2LByyxfUZJHkKQQGEo=;
        b=I8wf9uIe8nygYRwAGwHSLPhQhBwN/Ygmane8eGjeptqDvdSVVlNrW5FIfMqGj/8PLP
         5Hbrz6IZ2JFywmvzU+oFeTdCpwbgg7sh3QNOOyZr+1hPEK+YgG9zKyMmOp0TurMop71a
         l1QK3sV/FJtLtHqVQdGe7I4LN9m6H8TynL2zovkQZ0KYJyRPwI8n2P+mK8QzsmZvDAFs
         appVlLJwAU9x3ubj5v6mQweq+oguiJ+JsVUVrTvBvA+TsGXIYj6qB/BzHLIeTPrGoJZU
         /zhfLkkYCqgyqUH8HzXlRVReLIuWr5J5Z/gcjgYNJtbSrI61c+D1STq9C3VZwZO5t30g
         jacw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775555281; x=1776160081; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3s0EL2GK9isiaMh6qYRIskpS648V2bnP/Cut8ycAb74=;
        b=jReM7qpNtihOuCtT0xAWTTp+Xk5QpKt2zr6PLIU/4WbqcqsYslmsSyQSAnY9bOIKXi
         g+U9Ha88scQmXSfn9kMKdlOyuLgb8ostkr7UU4sJ9CZSmzqcS0McVP8EatM/fxVFuFgy
         zFfh9vsb544mFtX8zYw6Eq62VZ0nPjMLOCBcGmvHtwhpFcXkTs+dKr9FJV8a1mF29hUV
         0RvPWvRvn6kg1+74fLtCJ/7GsxzwHGfhN1DnOiOd5KZKEto9odKQLVtH93SQ6bljEnFr
         0Ya5oBAwXj0lwAOQniHgOESatPSknqNLceUXocm4wvqzLP8msQA9Hz0ukDqGUSTESwcI
         tKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775555281; x=1776160081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3s0EL2GK9isiaMh6qYRIskpS648V2bnP/Cut8ycAb74=;
        b=QioFBWnFFUmJzYcEm5NtfyRy6BtBUSFs859y0xTsBO+rtoLpeiNl2pS4Bfm81yj7Hz
         7lGj2syNwUjmsLbnJSjNuqufJYDrkuBJfGyzMKxZsvuInjKfX7FgOsjSPts6Cyv53ECC
         MskbKqdrkSjvsOY2AzohV0WP/Oat+UtP3rQAqkxhuRKOaTcJKmF7zVErGILou1fsvxVu
         EoRFUkReWRi1H8jWLNEhsi7UdFkHLYZx1bHks1ZDa0w+4Y8fm0Zm448hBAYtku9pEsED
         DeI7bCT+P9Al5VhOPk2166L1ssv9H9PHZKqkKa6Vw9WmsNr3sJWkLUQHSLGHgjnnlH5w
         w2dw==
X-Forwarded-Encrypted: i=1; AJvYcCW5nW2icI8s8DbywGrzgD0iMMdqQYHnzAg9xO/66AkU/6W72dm43PSKxeTay5Jr6/I1A8JZa6Zl/g==@lists.infradead.org
X-Gm-Message-State: AOJu0YyUQ6A93aSAYgeFoNbBpR3LYRZdBX4YkZoJDyIiY6amiD3ctIpj
	Wt1l7dQnDNcL5ZkMw+GZRFpsiqPVVmY1vCN+XgFsSrE8m1XJtUGkBe5yrrwwuB4LW1ECClbgMVw
	gjuG2WIjVZdgkaT8iNECM7Tm3FaETJ73i92d0s5aA
X-Gm-Gg: AeBDiesaPkjEJCglwOaLzFDYBk45K2zovfiOItgILXoPSOjqITyc7W0T2Tfcu9grF3b
	wrCe3jEq0x/1u/GbgQQD+uyp7SbNt4mfYCcaacI6LHmzMFWTmybWmGEa6zrenah9mWqF/akBLbe
	sArAHS0WZgl2hTksRS+R5CB8ZDoOZ3JaQQbcj591tPpV09IHzkQpu76GhcchsZDrfj6hStlvv4O
	rqZERcXYVceg3QyCA304xa8IvvAUYn1cRtLQF3Pob6JNvZAkMbOlYH+6bvF/rcP3efRo7Z0U92Z
	BxlGmMx/NOOivVpSV6q9EPhdysVQ42UCnmadZQ==
X-Received: by 2002:a05:622a:684f:20b0:509:2cd4:b705 with SMTP id
 d75a77b69052e-50d63eb03bfmr6243281cf.4.1775555280440; Tue, 07 Apr 2026
 02:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <CANP3RGd1SYY-Xakfq93Ttb-m1xXWdMAq=HEJMk6-KMcGmPWMtg@mail.gmail.com>
 <CANP3RGeOQa_s5ZyCp9MBVAR3cAz25=t=sYCdQgjsPCmA25F3=w@mail.gmail.com>
 <PH8PR11MB8285E84708CCB0C5799C1B4DE95AA@PH8PR11MB8285.namprd11.prod.outlook.com>
 <CANP3RGec_Skbzm3OFFhSJRFigsoQQ8hRL3JJxsVYMz3QtoguXA@mail.gmail.com> <9960ac97a83c4d37da513644b5019f96e03b55f2.camel@sipsolutions.net>
In-Reply-To: <9960ac97a83c4d37da513644b5019f96e03b55f2.camel@sipsolutions.net>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Tue, 7 Apr 2026 02:47:48 -0700
X-Gm-Features: AQROBzCk0MJ6RU57HK5q4egWyu2ym7f38tVcz6x9V5-obnVdakL1824i_pqjbB8
Message-ID: <CANP3RGdxC=w=Tqq_A9DVYig_dYfhBficmU9vQCySoCx72oCckA@mail.gmail.com>
Subject: Re: 6.13+ uml crash
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: "Berg, Johannes" <johannes.berg@intel.com>, linux-um@lists.infradead.org, 
	Tiwei Bie <tiwei.btw@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260407_024802_378061_52099650 
X-CRM114-Status: GOOD (  41.39  )
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

On Tue, Apr 7, 2026 at 5:01=E2=80=AFPM Benjamin Berg <benjamin@sipsolutions=
.net> wrote:
>
> Hi,
>
> you get an ESRCH error, which means that either the UML userspace
> process does not exist or maybe we do not have permission to trace for
> some reason.
>
> Now, the difference is that before the patch UML would just clone to
> create the userspace processes. After the patch, it will execve() into
> a separate executable that exists only as a memfd.
>
> I am noticing now, that we are doing the PTRACE_TRACEME inside the new
> executable instead of the usual method of doing it before execve. So
> maybe that makes a difference with AppArmor.
>
> So, I think you can do two things:
>    1. As a quick workaround, simply use "seccomp=3Don".
>       However, the sandboxing of the userspace processes is not quite
>       as secure if you do that (i.e. they currently can break out and
>       make host syscalls).

I tried the breaking commit, and 6.13.latest but it doesn't appear to
support seccomp=3Don

I tried 6.18.latest but it fails to build for me with

In file included from ./include/linux/unwind_user.h:6,
                 from ./include/linux/unwind_deferred.h:6,
                 from kernel/fork.c:108:
./arch/x86/include/asm/unwind_user.h: In function =E2=80=98unwind_user_word=
_size=E2=80=99:
./arch/x86/include/asm/unwind_user.h:23:17: error: =E2=80=98struct pt_regs=
=E2=80=99
has no member named =E2=80=98flags=E2=80=99
   23 |         if (regs->flags & X86_VM_MASK)
      |                 ^~
  CC      net/ipv6/addrconf.o
./arch/x86/include/asm/unwind_user.h:23:27: error: =E2=80=98X86_VM_MASK=E2=
=80=99
undeclared (first use in this function)
   23 |         if (regs->flags & X86_VM_MASK)
      |                           ^~~~~~~~~~~
./arch/x86/include/asm/unwind_user.h:23:27: note: each undeclared
identifier is reported only once for each function it appears in
  CC      block/blk-settings.o
  CC      net/core/net_namespace.o
./arch/x86/include/asm/unwind_user.h:26:14: error: implicit
declaration of function =E2=80=98user_64bit_mode=E2=80=99
[-Wimplicit-function-declaration]
   26 |         if (!user_64bit_mode(regs))
      |              ^~~~~~~~~~~~~~~

it's likely related to some combination of kconfig options needed for
android net tests...

6.16.latest builds but still crashes (not sure if it supports
seccomp=3Don), but the crash is different:

Run /sbin/net_test.sh as init process
Unexpectedly lost MM child! Affected tasks will segfault.
wait_stub_done_seccomp : failed to wait for stub, pid =3D -1, errno =3D 0
Kernel panic - not syncing: Attempted to kill init! exitcode=3D0x0000000b
CPU: 0 UID: 0 PID: 1 Comm: net_test.sh Not tainted 6.16.12-g7e13344d2211 #4=
 NONE
Stack:
 80803b60 6063f23b 6051b353 00000000
 00000001 6063f23b 606314ef 60027dfc
 80803b90 6002f679 60c70000 609374c0
Call Trace:
 [<60027dfc>] ? _printk+0x0/0x57
 [<6003237a>] show_stack+0x10b/0x11a
 [<6051b353>] ? dump_stack_print_info+0x0/0x12b
 [<60027dfc>] ? _printk+0x0/0x57
 [<6002f679>] dump_stack_lvl+0x5e/0x79
 [<6002f6ae>] dump_stack+0x1a/0x1c
 [<60026626>] panic+0x156/0x377
 [<6003ff78>] ? unblock_signals+0x25/0x28
 [<6003ffa1>] ? um_set_signals+0x26/0x3e
 [<600264d0>] ? panic+0x0/0x377
 [<60049fd8>] do_exit+0x205/0x9f6
 [<60162f26>] ? kmem_cache_free+0x118/0x12b
 [<6004a9ff>] sys_exit_group+0x0/0x16
 [<60055d9c>] get_signal+0x7dc/0x803
 [<600555c0>] ? get_signal+0x0/0x803
 [<6004349c>] ? setup_signal_stack_si+0x0/0x1f0
 [<60055166>] ? signal_setup_done+0x0/0xb1
 [<600320f5>] do_signal+0x54/0x1ce
 [<60539370>] ? _raw_spin_unlock_irqrestore+0x0/0x39
 [<60032db6>] fatal_sigsegv+0x32/0x3e
 [<60041ac6>] wait_stub_done_seccomp+0x2b1/0x2c0
 [<60041efa>] userspace+0xff/0x694
 [<60031769>] ? interrupt_end+0x0/0xac
 [<60179ba4>] ? copy_strings_kernel+0x0/0x9e
 [<6003166a>] new_thread_handler+0x5a/0x5e
/aosp-tests/net/test/run_net_test.sh: line 503: 939215 Aborted
           (core dumped) $KERNEL_BINARY umid=3Dnet_test mem=3D512M
seccomp=3Don $blockdevice=3D$ROOTFS $netconfig $consolemode ssl3=3Dnull,fd:=
3
$cmdline 1>&2 3> "${SSL3}"
Warning: UML exited with 134 instead of zero.

>    2. Move the ptrace(PTRACE_TRACEME) call into userspace_tramp to
>       check if AppArmor is permitting ptrace then.

haven't yet had time to try this approach.

>
> Benjamin
>
> On Tue, 2026-04-07 at 15:15 +0900, Maciej =C5=BBenczykowski wrote:
> > On Tue, Apr 7, 2026 at 2:56=E2=80=AFPM Berg, Johannes <johannes.berg@in=
tel.com> wrote:
> > > Hi,
> > >
> > > Haven't looked at this yet - but really better if you CC the UML list=
.
> > >
> > > johannes
> > >
> > > > -----Original Message-----
> > > > From: Maciej =C5=BBenczykowski <maze@google.com>
> > > > Sent: Saturday, April 4, 2026 5:25 AM
> > > > To: Berg, Benjamin <benjamin.berg@intel.com>; Berg, Johannes
> > > > <johannes.berg@intel.com>; Tiwei Bie <tiwei.btw@antgroup.com>
> > > > Subject: Re: 6.13+ uml crash
> > > >
> > > > On Fri, Apr 3, 2026 at 12:34=E2=80=AFPM Maciej =C5=BBenczykowski <m=
aze@google.com>
> > > > wrote:
> > > > >
> > > > > Host is:
> > > > >
> > > > > 6.18.14-1rodete1-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.18.14-
> > > > 1rodete1
> > > > > (2026-03-06) x86_64 GNU/Linux
> > > > >
> > > > > /proc/cmdline
> > > > > ima_hash=3Dsha256 kfence.sample_interval=3D100 intel_iommu=3Dsm_o=
ff
> > > > > pci=3Dnoats printk.devkmsg=3Don slab_nomerge
> > > > > lsm=3Dlandlock,lockdown,yama,loadpin,safesetid,integrity,apparmor=
,selinu
> > > > > x,smack,tomoyo,bpf
> > > > > apparmor=3D1 panic=3D30 glinux-boot-image=3Ddefault-20260324.03.0=
0
> > > > > earlycon=3Duart8250,io,0x3f8 console=3DttyS0,115200n8 console=3Dh=
vc0
> > > > > console=3Dtty0 splash plymouth.ignore-serial-consoles i915.enable=
_psr=3D0
> > > > >
> > > > > No SELinux, but I think there is likely some corporate AppArmor p=
olicy...
> > > > >
> > > > > I seem to hit this problem while trying to use UML on latest
> > > > > 6.13/6.14/6.15/6.16/6.17/6.18/6.19
> > > > > 6.12 guests are the last ones that work.
> > > > >
> > > > > I noticed 6.13 had many UML changes...
> > > > >
> > > > > This is while trying to run the android net tests.
> > > > >
> > > > > https://android.googlesource.com/kernel/tests/+log/refs/heads/mir=
ror-g
> > > > > oog-main-kernel /aosp-tests/net/test/run_net_test.sh --builder
> > > > > all_tests.sh
> > > > >
> > > > > ...
> > > > > VFS: Mounted root (ext3 filesystem) readonly on device 98:0.
> > > > > devtmpfs: mounted
> > > > > This architecture does not have kernel memory protection.
> > > > > Run /sbin/net_test.sh as init process
> > > > > Registers -
> > > > >         0       0x60025a90
> > > > >         1       0x2e2ea5
> > > > >         2       0x600423e4
> > > > >         3       0x2e2ea8
> > > > >         4       0x7fffffffbe30
> > > > >         5       0x0
> > > > >         6       0x206
> > > > >         7       0x0
> > > > >         8       0x7fffffffbe30
> > > > >         9       0xffffffff
> > > > >         10      0x0
> > > > >         11      0x7ffff7c40c87
> > > > >         12      0x0
> > > > >         13      0x13
> > > > >         14      0x2e2ea8
> > > > >         15      0x3e
> > > > >         16      0x7fffffffc000
> > > > >         17      0x33
> > > > >         18      0x206
> > > > >         19      0x7fffffffeff8
> > > > >         20      0x2b
> > > > >         21      0x7ffff7f9d740
> > > > >         22      0x0
> > > > >         23      0x0
> > > > >         24      0x0
> > > > >         25      0x0
> > > > >         26      0x0
> > > > > Kernel panic - not syncing: do_syscall_stub : PTRACE_SETREGS fail=
ed,
> > > > > errno =3D 3  [ESRCH]
> > > > > CPU: 0 UID: 0 PID: 1 Comm: net_test.sh Not tainted
> > > > > 6.13.12-g2abfa5d47651 #3
> > > > > Stack:
> > > > >  600277e4 60629dd1 80803d80 00000000
> > > > >  00000001 60629dd1 6061c0a9 600277e4
> > > > >  80803db0 6002efd2 60c70000 609171c0
> > > > > Call Trace:
> > > > >  [<600277e4>] ? _printk+0x0/0x57
> > > > >  [<600322ec>] show_stack+0x10b/0x11a
> > > > >  [<600277e4>] ? _printk+0x0/0x57
> > > > >  [<600277e4>] ? _printk+0x0/0x57
> > > > >  [<6002efd2>] dump_stack_lvl+0x5e/0x79  [<6002f007>]
> > > > > dump_stack+0x1a/0x1c  [<60026838>] panic+0x156/0x377  [<600277e4>=
] ?
> > > > > _printk+0x0/0x57  [<600266e2>] ? panic+0x0/0x377  [<600277e4>] ?
> > > > > _printk+0x0/0x57  [<6004555b>] do_syscall_stub+0xa6/0x132
> > > > > [<60031608>] ? interrupt_end+0x0/0xae  [<6004560b>]
> > > > > syscall_stub_flush+0x24/0x2e  [<60045daf>] userspace+0x81/0x469
> > > > > [<60031608>] ? interrupt_end+0x0/0xae  [<601761ba>] ?
> > > > > copy_strings_kernel+0x0/0x9e  [<60031509>]
> > > > > new_thread_handler+0x5a/0x5e
> > > > > /aosp-tests/net/test/run_net_test.sh: line 498: 3026597 Aborted
> > > > >             (core dumped) $KERNEL_BINARY umid=3Dnet_test mem=3D51=
2M
> > > > > $blockdevice=3D$ROOTFS $netconfig $consolemode ssl3=3Dnull,fd:3 $=
cmdline
> > > > > 1>&2 3> "${SSL3}"
> > > > > Warning: UML exited with 134 instead of zero.
> > > >
> > > > It appears this broke at:
> > > >
> > > > commit 32e8eaf263d9be014ba1970444f745682fa9c6c0
> > > > Author: Benjamin Berg <benjamin.berg@intel.com>
> > > >     um: use execveat to create userspace MMs
> > > Intel Deutschland GmbH
> > > Registered Address: Dornacher Strasse 1, 85622 Feldkirchen, Germany
> > > Tel: +49 89 991 430, www.intel.de
> > > Managing Directors: Harry Demas, Jeffrey Schneiderman, Yin Chong Sorr=
ell
> > > Chairperson of the Supervisory Board: Nicole Lau
> > > Registered Seat: Munich
> > > Commercial Register: Amtsgericht Muenchen HRB 186928
> >
> > --
> > Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google

--
Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google


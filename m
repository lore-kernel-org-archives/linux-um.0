Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B60A0EDB7CC
	for <linux-um@archiver.kernel.org>; Tue,  7 Apr 2026 08:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gxoL+nShyKByi7Jt/W3+0/61RoQCL0mAYaari1/+XFk=; b=mQlNkOTbzBnZxW0dvFcCfeIl7I
	txA5pDWEq7wHqPfdEA1JbgSkffkh7fUPb5ceT9WFNGmwzElVTHb+2Jd20GPzscgXYknSyfUuFBBW0
	aTZ17fCRHu+0Bz/Vwi40Mip/olWz6IdCn2mmJ+N2RA/+Q5uJgjlozel29WS/w9/T9CtUPtJxKdWhd
	FhS1eGKwJLcWbIkoNXylxFK1vlfd/avkjx5i5P1HIHmkGBEX2gaM4WlKb8qPTqltSo9I0QY+Lfvqd
	66fOJ1RgJWeX3wFv5xnLqIFO+TQ5zmKncOmATJs5s8bWToooOuaXNqg0CzrBdn4wTBd48/WP81tJ3
	XuvBMLag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wA1NM-000000066vU-1Bxm;
	Tue, 07 Apr 2026 08:01:32 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wA1NJ-000000066v4-0vPt
	for linux-um@lists.infradead.org;
	Tue, 07 Apr 2026 08:01:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=gxoL+nShyKByi7Jt/W3+0/61RoQCL0mAYaari1/+XFk=;
	t=1775548889; x=1776758489; b=rbFkf0sTMREwjNQ9HsA1ngxweSqE9lt7CYKvgFNdPN20pO6
	x8QDmOWwU/R0TU7dqVUtldVyFZH3IloSPDS7nBPPqe0c8TmIXbAODUaVvmVTXa6QGYptdFKsW14/W
	Asag9xYHaA/rNzYEmwPX9Lyd2QMuij3kC0guo9SYzzc9soEL2Gpr3PZ9VsJ3eCndm01w8dNJ5Vocx
	bGQWICWFTnbatX6dn7RvPnd208uDDK3p7XGw6g2pPCwPYY0a8RvHDG3rJgq/3ExR8RfHCZLNH1GvA
	CxXR917OHLtKusCsX9j0+ZgZ2SC/XPbU/uNDrd121cY2Po0CiYRu83pMpuUHxLWQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1wA1NC-0000000C7Ad-0sSb;
	Tue, 07 Apr 2026 10:01:22 +0200
Message-ID: <9960ac97a83c4d37da513644b5019f96e03b55f2.camel@sipsolutions.net>
Subject: Re: 6.13+ uml crash
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Maciej =?UTF-8?Q?=C5=BBenczykowski?= <maze@google.com>, "Berg, Johannes"
	 <johannes.berg@intel.com>, linux-um@lists.infradead.org
Cc: Tiwei Bie <tiwei.btw@antgroup.com>
Date: Tue, 07 Apr 2026 10:01:21 +0200
In-Reply-To: <CANP3RGec_Skbzm3OFFhSJRFigsoQQ8hRL3JJxsVYMz3QtoguXA@mail.gmail.com>
References: <CANP3RGd1SYY-Xakfq93Ttb-m1xXWdMAq=HEJMk6-KMcGmPWMtg@mail.gmail.com>
	 <CANP3RGeOQa_s5ZyCp9MBVAR3cAz25=t=sYCdQgjsPCmA25F3=w@mail.gmail.com>
	 <PH8PR11MB8285E84708CCB0C5799C1B4DE95AA@PH8PR11MB8285.namprd11.prod.outlook.com>
	 <CANP3RGec_Skbzm3OFFhSJRFigsoQQ8hRL3JJxsVYMz3QtoguXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260407_010129_492290_21743904 
X-CRM114-Status: GOOD (  27.37  )
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

you get an ESRCH error, which means that either the UML userspace
process does not exist or maybe we do not have permission to trace for
some reason.

Now, the difference is that before the patch UML would just clone to
create the userspace processes. After the patch, it will execve() into
a separate executable that exists only as a memfd.

I am noticing now, that we are doing the PTRACE_TRACEME inside the new
executable instead of the usual method of doing it before execve. So
maybe that makes a difference with AppArmor.

So, I think you can do two things:
   1. As a quick workaround, simply use "seccomp=3Don".
      However, the sandboxing of the userspace processes is not quite
      as secure if you do that (i.e. they currently can break out and
      make host syscalls).
   2. Move the ptrace(PTRACE_TRACEME) call into userspace_tramp to
      check if AppArmor is permitting ptrace then.

Benjamin

On Tue, 2026-04-07 at 15:15 +0900, Maciej =C5=BBenczykowski wrote:
> On Tue, Apr 7, 2026 at 2:56=E2=80=AFPM Berg, Johannes <johannes.berg@inte=
l.com> wrote:
> > Hi,
> >=20
> > Haven't looked at this yet - but really better if you CC the UML list.
> >=20
> > johannes
> >=20
> > > -----Original Message-----
> > > From: Maciej =C5=BBenczykowski <maze@google.com>
> > > Sent: Saturday, April 4, 2026 5:25 AM
> > > To: Berg, Benjamin <benjamin.berg@intel.com>; Berg, Johannes
> > > <johannes.berg@intel.com>; Tiwei Bie <tiwei.btw@antgroup.com>
> > > Subject: Re: 6.13+ uml crash
> > >=20
> > > On Fri, Apr 3, 2026 at 12:34=E2=80=AFPM Maciej =C5=BBenczykowski <maz=
e@google.com>
> > > wrote:
> > > >=20
> > > > Host is:
> > > >=20
> > > > 6.18.14-1rodete1-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.18.14-
> > > 1rodete1
> > > > (2026-03-06) x86_64 GNU/Linux
> > > >=20
> > > > /proc/cmdline
> > > > ima_hash=3Dsha256 kfence.sample_interval=3D100 intel_iommu=3Dsm_off
> > > > pci=3Dnoats printk.devkmsg=3Don slab_nomerge
> > > > lsm=3Dlandlock,lockdown,yama,loadpin,safesetid,integrity,apparmor,s=
elinu
> > > > x,smack,tomoyo,bpf
> > > > apparmor=3D1 panic=3D30 glinux-boot-image=3Ddefault-20260324.03.00
> > > > earlycon=3Duart8250,io,0x3f8 console=3DttyS0,115200n8 console=3Dhvc=
0
> > > > console=3Dtty0 splash plymouth.ignore-serial-consoles i915.enable_p=
sr=3D0
> > > >=20
> > > > No SELinux, but I think there is likely some corporate AppArmor pol=
icy...
> > > >=20
> > > > I seem to hit this problem while trying to use UML on latest
> > > > 6.13/6.14/6.15/6.16/6.17/6.18/6.19
> > > > 6.12 guests are the last ones that work.
> > > >=20
> > > > I noticed 6.13 had many UML changes...
> > > >=20
> > > > This is while trying to run the android net tests.
> > > >=20
> > > > https://android.googlesource.com/kernel/tests/+log/refs/heads/mirro=
r-g
> > > > oog-main-kernel /aosp-tests/net/test/run_net_test.sh --builder
> > > > all_tests.sh
> > > >=20
> > > > ...
> > > > VFS: Mounted root (ext3 filesystem) readonly on device 98:0.
> > > > devtmpfs: mounted
> > > > This architecture does not have kernel memory protection.
> > > > Run /sbin/net_test.sh as init process
> > > > Registers -
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0x60025a90
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0x2e2ea5
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0x600423e4
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0x2e2ea8
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0x7fffffffbe30
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0x0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0x206
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0x0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0x7fffffffbe30
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 9=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0xffffffff
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 10=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0x0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 11=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0x7ffff7c40c87
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 12=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0x0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 13=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0x13
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 14=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0x2e2ea8
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 15=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0x3e
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0x7fffffffc000
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 17=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0x33
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 18=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0x206
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 19=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0x7fffffffeff8
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0x2b
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 21=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0x7ffff7f9d740
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 22=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0x0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 23=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0x0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 24=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0x0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 25=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0x0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 26=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0x0
> > > > Kernel panic - not syncing: do_syscall_stub : PTRACE_SETREGS failed=
,
> > > > errno =3D 3=C2=A0 [ESRCH]
> > > > CPU: 0 UID: 0 PID: 1 Comm: net_test.sh Not tainted
> > > > 6.13.12-g2abfa5d47651 #3
> > > > Stack:
> > > > =C2=A0600277e4 60629dd1 80803d80 00000000
> > > > =C2=A000000001 60629dd1 6061c0a9 600277e4
> > > > =C2=A080803db0 6002efd2 60c70000 609171c0
> > > > Call Trace:
> > > > =C2=A0[<600277e4>] ? _printk+0x0/0x57
> > > > =C2=A0[<600322ec>] show_stack+0x10b/0x11a
> > > > =C2=A0[<600277e4>] ? _printk+0x0/0x57
> > > > =C2=A0[<600277e4>] ? _printk+0x0/0x57
> > > > =C2=A0[<6002efd2>] dump_stack_lvl+0x5e/0x79=C2=A0 [<6002f007>]
> > > > dump_stack+0x1a/0x1c=C2=A0 [<60026838>] panic+0x156/0x377=C2=A0 [<6=
00277e4>] ?
> > > > _printk+0x0/0x57=C2=A0 [<600266e2>] ? panic+0x0/0x377=C2=A0 [<60027=
7e4>] ?
> > > > _printk+0x0/0x57=C2=A0 [<6004555b>] do_syscall_stub+0xa6/0x132
> > > > [<60031608>] ? interrupt_end+0x0/0xae=C2=A0 [<6004560b>]
> > > > syscall_stub_flush+0x24/0x2e=C2=A0 [<60045daf>] userspace+0x81/0x46=
9
> > > > [<60031608>] ? interrupt_end+0x0/0xae=C2=A0 [<601761ba>] ?
> > > > copy_strings_kernel+0x0/0x9e=C2=A0 [<60031509>]
> > > > new_thread_handler+0x5a/0x5e
> > > > /aosp-tests/net/test/run_net_test.sh: line 498: 3026597 Aborted
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
(core dumped) $KERNEL_BINARY umid=3Dnet_test mem=3D512M
> > > > $blockdevice=3D$ROOTFS $netconfig $consolemode ssl3=3Dnull,fd:3 $cm=
dline
> > > > 1>&2 3> "${SSL3}"
> > > > Warning: UML exited with 134 instead of zero.
> > >=20
> > > It appears this broke at:
> > >=20
> > > commit 32e8eaf263d9be014ba1970444f745682fa9c6c0
> > > Author: Benjamin Berg <benjamin.berg@intel.com>
> > > =C2=A0=C2=A0=C2=A0 um: use execveat to create userspace MMs
> > Intel Deutschland GmbH
> > Registered Address: Dornacher Strasse 1, 85622 Feldkirchen, Germany
> > Tel: +49 89 991 430, www.intel.de
> > Managing Directors: Harry Demas, Jeffrey Schneiderman, Yin Chong Sorrel=
l
> > Chairperson of the Supervisory Board: Nicole Lau
> > Registered Seat: Munich
> > Commercial Register: Amtsgericht Muenchen HRB 186928
>=20
> --
> Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google


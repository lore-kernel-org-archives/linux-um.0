Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137A7FB519B
	for <linux-um@archiver.kernel.org>; Tue,  7 Apr 2026 06:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dtiz7Gkr44bdBY+oHLTxhUafHlH0dmAfJQMKyk3lEbY=; b=nOFxip8FErvFCPFwDljONOzynj
	R7w44CXwoKgohk3+vR9IJTiTBbJGuKaoVbTU7DEqr5UKpvz5m0CwvZar8w0d1OlS1nCNbzTtY9qRN
	Lv/uT5NjXgryvNB7HwnLyTo7JQoZcq6vJaQdGkcV21u28y6QBh6V3agfrGJ0oNWJdINVZwAonL+FV
	3mWtnm0vzZ+czQwtWlXNcYbNiJIsrGEstZG2mmeMVblp9hplAVA0SjdcFOZTdPUFXDE79M9I/Zh/8
	/6GLkxxfZAXuQ8K9vWegglg+1Uo8cjLPKaT0PA1lx2JgXK1gEqPhpG77Fzu9a+OlgVOAc3R2ybIWE
	EVBFidLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9ziu-00000005yLJ-0eyT;
	Tue, 07 Apr 2026 06:15:40 +0000
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9zis-00000005yJZ-0BIs
	for linux-um@lists.infradead.org;
	Tue, 07 Apr 2026 06:15:39 +0000
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-50d6b393d60so1827781cf.0
        for <linux-um@lists.infradead.org>; Mon, 06 Apr 2026 23:15:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775542536; cv=none;
        d=google.com; s=arc-20240605;
        b=e0Jj4FXSrvIlZNOds7ykxMOFrTQlIddUkOSBCNDdJeJ+ad5dkYYAld52xi+HQ0/fKM
         FdrJ20m9EWM2NF5hDK5KmRBgGJZzR4xpDx/zRODGQ8YYfevsZ0TENbxeUlgjAdr+WJ5G
         qr0lp6PYeHzTZjrVZ6opl/BaDuAXVa2Kxb6s0dJGk1q00mVr/k6glgzAn6h1hXSBE9il
         6DeoK/PACdeT/rDRWJuONnxJTLFIciPdfNloZ51faTBiKyqkxoMMD4MSw/lcaSq57+RF
         4H6D+fxUDgYCD4wA7fPMedriwzyL3OnIHx+HtZnmuGUAgmfQCufd+9vFPWtiabj2oJZf
         yjOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dtiz7Gkr44bdBY+oHLTxhUafHlH0dmAfJQMKyk3lEbY=;
        fh=UNliaCi9HqKzXKvpYevGQJ0tgUA1UsrGjSvvWTRT5f4=;
        b=flGGrCNMW5jCitb7oidWcXIYNyGVAvdbPcfRGfcV66wPI54blRdL9FMAIEeCzefe2Z
         x/xV4Bw4bVJ3z32BBGP2hHQrF0RmKcnBqqUyKICjVFPUzgr4AE86bTw9tbd3Lky+d7W3
         SGu0gXZsETZBCuUQpbx52Pd3vQwICbU5zEetJxJLogiSN6QcZAx/LBTzGT6e/8tFYwjv
         wvknNy7AkkgdrGzigpWy/UEV+ujvFlB+XhPGLhfonhz+wO/jNb2WLDMA4+8H3oMBGOkG
         eEXYXV/CEqFKGcWwTLYlITpIfaj+jdzhiNtmZoECb8chyy4UviKGwBWegYU+74Pmv1Yi
         0l9w==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775542536; x=1776147336; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dtiz7Gkr44bdBY+oHLTxhUafHlH0dmAfJQMKyk3lEbY=;
        b=fL42sIOdIaU2kqjQgkplO7R3kF+ZO5ouDWwZtqr2/hhyXxbD6cqZKLBx0MwLE09HAY
         3oHzATCmgGgsdKQ5tL6DcJ2Vv0EB+J6LoRhaojMUM6IZY8aV20iLqHDwouARA53Bonve
         7nRVKtAcEiI9gFANodbaAW/NgsnaLDkDw/1LvQMYDW0gY75CSS38APhlHgzkmzAqeKRY
         3nIgN9EP3bCMajAH6ocYch20/vfR8Qh0kXALo3ZK9YRcdTaoil7T6tbHu4h+HBKBNKoH
         ZK3YPXBmYjjqPwOflprwLWcChlerPsdFcKKlpshlDF+KTgIGzj9NcrAXM1cio7QW6wru
         zaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775542536; x=1776147336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dtiz7Gkr44bdBY+oHLTxhUafHlH0dmAfJQMKyk3lEbY=;
        b=oFH0oPcZ/9vKFgGk6yyK/ad5AM6Y4Wo/kjftg9KYOUSYU5BvEjpQBTY5c+PUN0T/y9
         5UApItWQDh25qBu8Jt8T+kse5DFBawlEZdfhjkaQxlQ/D20tspW/ezDLd3mxta0/YH9N
         CdVFSxG21GIDkjKzAz3BVx3Frx3BeSrv3fhV6lkV7D5Ldr/MROhhaZfPgJ5cBl3JKwtu
         +r3F6Vs5jll6nAEl/LsKCAg0rBbbsco5cxkM8j3O35vKBvuwmmyeZ2e2xGplh5HcQd6G
         2DgeRZYJs9MfBJnoq/zeOy8k5z77h+gAhCvQYgUx9eeXvLfC5+PYDPE/GOIdYOXk6kxA
         zRBw==
X-Forwarded-Encrypted: i=1; AJvYcCVTYu4nlJ7ffvpwghcJVHVjHrSq8d/MSVI+u/RxBR+bOKYS/viCJV6j+RrwKkNV8/vVeJ57Sd4Sxw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx/Wd6n1RdTIrvH7awjjqYKqYQUsD3TzEBMs7daw7RAaqb8Z7eO
	rAP/THo4HLEu/0JrJT0Qy4NoSEejtQO6oNQ588Jg+SI/Cuoo0yqJz1e5sbjl7UJTmeMkWAmWFFX
	zVCr73Q7IXbTZg8m4r0SSZ3vaKGz/ihILrQrgrAe6
X-Gm-Gg: AeBDieu9Ou7FKBmw0XfckYn7hVR8cCyelDB4Ri/+1AERUBc+PgGDyTmc3j8ffQzDyLU
	Wno9YDoWPHOXrgBU90IcF20SIFCce5i8N0Vf1dh/ppxbDkl/Ld4iJ09RHQpoPTWC4x47zYHhg64
	Hxo4N9phDuohIBOxCHMCVZbWiPJ0LgFNAcXdBjFfAd9sPnDGzzQEMsfDzb7cZ986orByJIff5J+
	3pw7fScmJm/Iq6qZzof7LLshn1Ni8Xry1zKXGkBsvvTShlLWzSmg6gSzmtblj7xyB9I+tCm10qc
	I3vgEkV4f3z+O2xWFKsr4z83G5pwgye1RHcMiQ==
X-Received: by 2002:ac8:5893:0:b0:50d:418a:9770 with SMTP id
 d75a77b69052e-50d63ea43bcmr52167921cf.2.1775542535247; Mon, 06 Apr 2026
 23:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <CANP3RGd1SYY-Xakfq93Ttb-m1xXWdMAq=HEJMk6-KMcGmPWMtg@mail.gmail.com>
 <CANP3RGeOQa_s5ZyCp9MBVAR3cAz25=t=sYCdQgjsPCmA25F3=w@mail.gmail.com> <PH8PR11MB8285E84708CCB0C5799C1B4DE95AA@PH8PR11MB8285.namprd11.prod.outlook.com>
In-Reply-To: <PH8PR11MB8285E84708CCB0C5799C1B4DE95AA@PH8PR11MB8285.namprd11.prod.outlook.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Tue, 7 Apr 2026 15:15:23 +0900
X-Gm-Features: AQROBzCARvkNT55ihLunf9kGESe6p6PUmA5VahBjmmx_SrrVZMOao8wWsQevwIg
Message-ID: <CANP3RGec_Skbzm3OFFhSJRFigsoQQ8hRL3JJxsVYMz3QtoguXA@mail.gmail.com>
Subject: Re: 6.13+ uml crash
To: "Berg, Johannes" <johannes.berg@intel.com>, linux-um@lists.infradead.org
Cc: "Berg, Benjamin" <benjamin.berg@intel.com>, Tiwei Bie <tiwei.btw@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260406_231538_174587_318AB601 
X-CRM114-Status: GOOD (  21.04  )
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

On Tue, Apr 7, 2026 at 2:56=E2=80=AFPM Berg, Johannes <johannes.berg@intel.=
com> wrote:
> Hi,
>
> Haven't looked at this yet - but really better if you CC the UML list.
>
> johannes
>
> > -----Original Message-----
> > From: Maciej =C5=BBenczykowski <maze@google.com>
> > Sent: Saturday, April 4, 2026 5:25 AM
> > To: Berg, Benjamin <benjamin.berg@intel.com>; Berg, Johannes
> > <johannes.berg@intel.com>; Tiwei Bie <tiwei.btw@antgroup.com>
> > Subject: Re: 6.13+ uml crash
> >
> > On Fri, Apr 3, 2026 at 12:34=E2=80=AFPM Maciej =C5=BBenczykowski <maze@=
google.com>
> > wrote:
> > >
> > > Host is:
> > >
> > > 6.18.14-1rodete1-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.18.14-
> > 1rodete1
> > > (2026-03-06) x86_64 GNU/Linux
> > >
> > > /proc/cmdline
> > > ima_hash=3Dsha256 kfence.sample_interval=3D100 intel_iommu=3Dsm_off
> > > pci=3Dnoats printk.devkmsg=3Don slab_nomerge
> > > lsm=3Dlandlock,lockdown,yama,loadpin,safesetid,integrity,apparmor,sel=
inu
> > > x,smack,tomoyo,bpf
> > > apparmor=3D1 panic=3D30 glinux-boot-image=3Ddefault-20260324.03.00
> > > earlycon=3Duart8250,io,0x3f8 console=3DttyS0,115200n8 console=3Dhvc0
> > > console=3Dtty0 splash plymouth.ignore-serial-consoles i915.enable_psr=
=3D0
> > >
> > > No SELinux, but I think there is likely some corporate AppArmor polic=
y...
> > >
> > > I seem to hit this problem while trying to use UML on latest
> > > 6.13/6.14/6.15/6.16/6.17/6.18/6.19
> > > 6.12 guests are the last ones that work.
> > >
> > > I noticed 6.13 had many UML changes...
> > >
> > > This is while trying to run the android net tests.
> > >
> > > https://android.googlesource.com/kernel/tests/+log/refs/heads/mirror-=
g
> > > oog-main-kernel /aosp-tests/net/test/run_net_test.sh --builder
> > > all_tests.sh
> > >
> > > ...
> > > VFS: Mounted root (ext3 filesystem) readonly on device 98:0.
> > > devtmpfs: mounted
> > > This architecture does not have kernel memory protection.
> > > Run /sbin/net_test.sh as init process
> > > Registers -
> > >         0       0x60025a90
> > >         1       0x2e2ea5
> > >         2       0x600423e4
> > >         3       0x2e2ea8
> > >         4       0x7fffffffbe30
> > >         5       0x0
> > >         6       0x206
> > >         7       0x0
> > >         8       0x7fffffffbe30
> > >         9       0xffffffff
> > >         10      0x0
> > >         11      0x7ffff7c40c87
> > >         12      0x0
> > >         13      0x13
> > >         14      0x2e2ea8
> > >         15      0x3e
> > >         16      0x7fffffffc000
> > >         17      0x33
> > >         18      0x206
> > >         19      0x7fffffffeff8
> > >         20      0x2b
> > >         21      0x7ffff7f9d740
> > >         22      0x0
> > >         23      0x0
> > >         24      0x0
> > >         25      0x0
> > >         26      0x0
> > > Kernel panic - not syncing: do_syscall_stub : PTRACE_SETREGS failed,
> > > errno =3D 3  [ESRCH]
> > > CPU: 0 UID: 0 PID: 1 Comm: net_test.sh Not tainted
> > > 6.13.12-g2abfa5d47651 #3
> > > Stack:
> > >  600277e4 60629dd1 80803d80 00000000
> > >  00000001 60629dd1 6061c0a9 600277e4
> > >  80803db0 6002efd2 60c70000 609171c0
> > > Call Trace:
> > >  [<600277e4>] ? _printk+0x0/0x57
> > >  [<600322ec>] show_stack+0x10b/0x11a
> > >  [<600277e4>] ? _printk+0x0/0x57
> > >  [<600277e4>] ? _printk+0x0/0x57
> > >  [<6002efd2>] dump_stack_lvl+0x5e/0x79  [<6002f007>]
> > > dump_stack+0x1a/0x1c  [<60026838>] panic+0x156/0x377  [<600277e4>] ?
> > > _printk+0x0/0x57  [<600266e2>] ? panic+0x0/0x377  [<600277e4>] ?
> > > _printk+0x0/0x57  [<6004555b>] do_syscall_stub+0xa6/0x132
> > > [<60031608>] ? interrupt_end+0x0/0xae  [<6004560b>]
> > > syscall_stub_flush+0x24/0x2e  [<60045daf>] userspace+0x81/0x469
> > > [<60031608>] ? interrupt_end+0x0/0xae  [<601761ba>] ?
> > > copy_strings_kernel+0x0/0x9e  [<60031509>]
> > > new_thread_handler+0x5a/0x5e
> > > /aosp-tests/net/test/run_net_test.sh: line 498: 3026597 Aborted
> > >             (core dumped) $KERNEL_BINARY umid=3Dnet_test mem=3D512M
> > > $blockdevice=3D$ROOTFS $netconfig $consolemode ssl3=3Dnull,fd:3 $cmdl=
ine
> > > 1>&2 3> "${SSL3}"
> > > Warning: UML exited with 134 instead of zero.
> >
> > It appears this broke at:
> >
> > commit 32e8eaf263d9be014ba1970444f745682fa9c6c0
> > Author: Benjamin Berg <benjamin.berg@intel.com>
> >     um: use execveat to create userspace MMs
> Intel Deutschland GmbH
> Registered Address: Dornacher Strasse 1, 85622 Feldkirchen, Germany
> Tel: +49 89 991 430, www.intel.de
> Managing Directors: Harry Demas, Jeffrey Schneiderman, Yin Chong Sorrell
> Chairperson of the Supervisory Board: Nicole Lau
> Registered Seat: Munich
> Commercial Register: Amtsgericht Muenchen HRB 186928

--
Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google


Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA8FC54E41
	for <linux-um@archiver.kernel.org>; Tue,  5 Mar 2024 10:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JXTqeVr+qrXEBZGxIVeu9k5JfN3ASb8sYgC/jg25F7c=; b=Kj3GuOC4YnUKeRH0sV8Pmq93T8
	rt4QW1RWMWKJhl392CMwjCuUoT2HA4XT3uy6G5zsvk9+egko7nOEAGKkWzth4Qi/FUPHHNz0gqU1v
	omIsVN82Qb7mrghErYj9NIl6iP2d3r0PCJmkL7a0Gcyi8c7//vDXAftMzklIFLPJHD2w2drvbL4Gr
	YQESr122ukdsNMngjIEmcMQ/pDkQ3c/iJUZkD2M6HKC84tAQuT1GTgkKUrDk7rNpguUuY6XqZ3ziZ
	lMiPZtvbXIwB5tO+b3Mfz2kYq3HzwHlBuCmW95IjWf/qvGwrYo6sM4+yFTir/TTG9vNg46u8VGlsw
	FrCqJNmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhSMK-0000000DAQa-3HZC;
	Tue, 05 Mar 2024 10:49:20 +0000
Received: from mgamail.intel.com ([192.198.163.18])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhSMH-0000000DAP2-2RDs
	for linux-um@lists.infradead.org;
	Tue, 05 Mar 2024 10:49:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709635757; x=1741171757;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=X/PYHDtxD7jKHwnl5WoYA9cooxV7ZqnZGAlm3GIJVfI=;
  b=IkcP0gV97zn1OeoUNTtmlJ55Q1GCuD7Pj0DBuZFKGaIear6hD8dhAn2F
   sR81lXUSjZREC5CPpcyTJETXGPNLxHNrUqwjEaEliurt/+jKm8LYh6YUL
   PEYUAsZD5JGdytpjdnq0PyJI9c7u3vZDW38I8UCj/HlpsRuXEpxoKGPpG
   NFEdF+oytSVCk+JrJHu9bbctjIgkAVYk1m+t8MbMufhUybbgH1wmB/qsi
   jUpqEnMgzgaFOtHczGhGRhw1o82ppfEDinUdh83Wg+R3SepLcNYcXUZoV
   b1HnTz9ADyLqaNm6ck6k4Vrc/B2S4O93r1XQv9OkoSY4svdnv9YaIRerX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4042309"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4042309"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 02:49:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9188949"
Received: from omakhlou-mobl4.amr.corp.intel.com (HELO localhost) ([10.252.51.143])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 02:49:14 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: Johannes Berg <johannes@sipsolutions.net>, Richard Weinberger
 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 linux-um@lists.infradead.org
Cc: intel-xe@lists.freedesktop.org, Lucas De Marchi
 <lucas.demarchi@intel.com>, Tiwei Bie <tiwei.btw@antgroup.com>
Subject: Re: -Wmissing-prototypes warnings in user-mode linux
In-Reply-To: <5d1dfb9fce5d7647ff3203080416eadc9806059a.camel@sipsolutions.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <87jzmh2chs.fsf@intel.com>
 <5d1dfb9fce5d7647ff3203080416eadc9806059a.camel@sipsolutions.net>
Date: Tue, 05 Mar 2024 12:49:10 +0200
Message-ID: <87frx52btl.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_024917_655653_BF926592 
X-CRM114-Status: GOOD (  13.69  )
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

On Tue, 05 Mar 2024, Johannes Berg <johannes@sipsolutions.net> wrote:
> On Tue, 2024-03-05 at 12:34 +0200, Jani Nikula wrote:
>> We're seeing a lot of -Wmissing-prototypes warnings when building
>> user-mode Linux. For example, our CI hits things like [1], and it's just
>> extra noise in the build.
>
> Yeah ...
>
>> I started adding some prototypes, but I lost my way around the arch/
>> subdirectory a bit. I'm not always quite sure what should or could be
>> included where, or whether a new header should be added instead, etc.,
>> so it wasn't going as quickly as I'd hoped.
>>=20
>> Do you perhaps already have plans or, better yet, patches to address
>> this? Feels like it should be fairly quick for someone familiar with the
>> arch/um codebase.
>
> I think this series addressed most already?
>
> https://patchwork.ozlabs.org/project/linux-um/list/?series=3D393619
>
> But I haven't checked myself yet.

Oh, nice, it certainly helps!

But after applying that in my branch, I do still get a bunch of
warnings.

BR,
Jani.



../arch/x86/um/user-offsets.c:17:6: warning: no previous prototype for =E2=
=80=98foo=E2=80=99 [-Wmissing-prototypes]
   17 | void foo(void)
      |      ^~~
In file included from ../arch/um/kernel/asm-offsets.c:1:
../arch/x86/um/shared/sysdep/kernel-offsets.h:9:6: warning: no previous pro=
totype for =E2=80=98foo=E2=80=99 [-Wmissing-prototypes]
    9 | void foo(void)
      |      ^~~
../arch/x86/um/os-Linux/registers.c:146:15: warning: no previous prototype =
for =E2=80=98get_thread_reg=E2=80=99 [-Wmissing-prototypes]
  146 | unsigned long get_thread_reg(int reg, jmp_buf *buf)
      |               ^~~~~~~~~~~~~~
../arch/x86/um/vdso/um_vdso.c:16:5: warning: no previous prototype for =E2=
=80=98__vdso_clock_gettime=E2=80=99 [-Wmissing-prototypes]
   16 | int __vdso_clock_gettime(clockid_t clock, struct __kernel_old_times=
pec *ts)
      |     ^~~~~~~~~~~~~~~~~~~~
../arch/x86/um/vdso/um_vdso.c:30:5: warning: no previous prototype for =E2=
=80=98__vdso_gettimeofday=E2=80=99 [-Wmissing-prototypes]
   30 | int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct tim=
ezone *tz)
      |     ^~~~~~~~~~~~~~~~~~~
../arch/x86/um/vdso/um_vdso.c:44:21: warning: no previous prototype for =E2=
=80=98__vdso_time=E2=80=99 [-Wmissing-prototypes]
   44 | __kernel_old_time_t __vdso_time(__kernel_old_time_t *t)
      |                     ^~~~~~~~~~~
../arch/x86/um/vdso/um_vdso.c:57:1: warning: no previous prototype for =E2=
=80=98__vdso_getcpu=E2=80=99 [-Wmissing-prototypes]
   57 | __vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *u=
nused)
      | ^~~~~~~~~~~~~
../arch/x86/um/ptrace_64.c:111:5: warning: no previous prototype for =E2=80=
=98poke_user=E2=80=99 [-Wmissing-prototypes]
  111 | int poke_user(struct task_struct *child, long addr, long data)
      |     ^~~~~~~~~
../arch/x86/um/ptrace_64.c:171:5: warning: no previous prototype for =E2=80=
=98peek_user=E2=80=99 [-Wmissing-prototypes]
  171 | int peek_user(struct task_struct *child, long addr, long data)
      |     ^~~~~~~~~
../arch/x86/um/signal.c:560:6: warning: no previous prototype for =E2=80=98=
sys_rt_sigreturn=E2=80=99 [-Wmissing-prototypes]
  560 | long sys_rt_sigreturn(void)
      |      ^~~~~~~~~~~~~~~~
../arch/um/os-Linux/skas/process.c:107:6: warning: no previous prototype fo=
r =E2=80=98wait_stub_done=E2=80=99 [-Wmissing-prototypes]
  107 | void wait_stub_done(int pid)
      |      ^~~~~~~~~~~~~~
../arch/um/os-Linux/skas/process.c:683:6: warning: no previous prototype fo=
r =E2=80=98__switch_mm=E2=80=99 [-Wmissing-prototypes]
  683 | void __switch_mm(struct mm_id *mm_idp)
      |      ^~~~~~~~~~~
../arch/um/kernel/um_arch.c:408:19: warning: no previous prototype for =E2=
=80=98read_initrd=E2=80=99 [-Wmissing-prototypes]
  408 | int __init __weak read_initrd(void)
      |                   ^~~~~~~~~~~
../arch/um/kernel/um_arch.c:461:7: warning: no previous prototype for =E2=
=80=98text_poke=E2=80=99 [-Wmissing-prototypes]
  461 | void *text_poke(void *addr, const void *opcode, size_t len)
      |       ^~~~~~~~~
../arch/um/kernel/um_arch.c:473:6: warning: no previous prototype for =E2=
=80=98text_poke_sync=E2=80=99 [-Wmissing-prototypes]
  473 | void text_poke_sync(void)
      |      ^~~~~~~~~~~~~~
../arch/um/os-Linux/main.c:187:7: warning: no previous prototype for =E2=80=
=98__wrap_malloc=E2=80=99 [-Wmissing-prototypes]
  187 | void *__wrap_malloc(int size)
      |       ^~~~~~~~~~~~~
../arch/um/os-Linux/main.c:208:7: warning: no previous prototype for =E2=80=
=98__wrap_calloc=E2=80=99 [-Wmissing-prototypes]
  208 | void *__wrap_calloc(int n, int size)
      |       ^~~~~~~~~~~~~
../arch/um/os-Linux/main.c:222:6: warning: no previous prototype for =E2=80=
=98__wrap_free=E2=80=99 [-Wmissing-prototypes]
  222 | void __wrap_free(void *ptr)
      |      ^~~~~~~~~~~
../arch/um/os-Linux/mem.c:28:6: warning: no previous prototype for =E2=80=
=98kasan_map_memory=E2=80=99 [-Wmissing-prototypes]
   28 | void kasan_map_memory(void *start, size_t len)
      |      ^~~~~~~~~~~~~~~~
../arch/um/os-Linux/mem.c:212:13: warning: no previous prototype for =E2=80=
=98check_tmpexec=E2=80=99 [-Wmissing-prototypes]
  212 | void __init check_tmpexec(void)
      |             ^~~~~~~~~~~~~
../arch/x86/um/syscalls_64.c:48:6: warning: no previous prototype for =E2=
=80=98arch_switch_to=E2=80=99 [-Wmissing-prototypes]
   48 | void arch_switch_to(struct task_struct *to)
      |      ^~~~~~~~~~~~~~
../arch/um/os-Linux/start_up.c:301:12: warning: no previous prototype for =
=E2=80=98parse_iomem=E2=80=99 [-Wmissing-prototypes]
  301 | int __init parse_iomem(char *str, int *add)
      |            ^~~~~~~~~~~



--=20
Jani Nikula, Intel


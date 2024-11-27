Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFA7D609CF
	for <linux-um@archiver.kernel.org>; Wed, 27 Nov 2024 10:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Subject:Cc:To:From:
	Message-ID:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7GvlRQIosSyFCCzlEXbkN5CZTYPb7RwPbgF2z0yVs2g=; b=rB+AtFviG3yIUStrS4D6aL0Nk2
	eoUaqSeiZZKFV7uW7vh/WZzMgaRwxS+zFa6fFmd8Pfax67ElWBGXVGpofpenQz/d1LIxlR3nwl7s/
	bVdxERAXkUcnanFdyQVbviaNrR8GzPzx2ylzba/F3xFIaT8y/MzZeX017GwD9qpKQvp7sP8BIrsZ6
	tV9FYPpK78tpFVrIiW5DqWLXklwbkuEFknmornkd4fXyLg+QZw4XCI8XNn4o/pQslRASPuB0iUCTt
	NRKyJiPP/g19GXYTCsu60XPRMnTnDukshsG8iGjV2ugkY9bPynuBhRWCv4cP9Ynsrmf8bgeWPx4en
	/z1VZY3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGFH0-0000000CqO6-48o4;
	Wed, 27 Nov 2024 10:27:54 +0000
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGFG1-0000000CqAH-28rj
	for linux-um@lists.infradead.org;
	Wed, 27 Nov 2024 10:26:54 +0000
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-7fc8f0598cdso289795a12.1
        for <linux-um@lists.infradead.org>; Wed, 27 Nov 2024 02:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732703212; x=1733308012; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7GvlRQIosSyFCCzlEXbkN5CZTYPb7RwPbgF2z0yVs2g=;
        b=WSApGzTawNuqrAtmxje0n7dPgHOFBMyuOrsqog1YiLjsjm+eez4aFdHZaz2qs5SeuX
         ckVbGysPrF6mps9pQ9qdnVozBSEQQls4GYnze3QWEEPF5iT0Y7zDApzW086yoTv17pyX
         8xdRAVKZifCMEwGYpIsqsw+ruEhKCQsvDHbYecVFNoGopgjKA+W2fllphyGEoPHweHav
         RmBsac8lxhqvyBYAQ7l0xqWfzcP8I59dlP0nCXVf3Wa3dooRXKf/GqBni/Jm9SKj+ks4
         qAYSHj8S38KebEA/ApaCPkxPD0jbFdRWDcdmR7C6gDuje+sp/KVvEBoRjTDPCFmE+NxZ
         4Pvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732703212; x=1733308012;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7GvlRQIosSyFCCzlEXbkN5CZTYPb7RwPbgF2z0yVs2g=;
        b=EDGMgFYRVNJSP7jNhGzayyzQ/ym5hnsHB4G02bEKsZeVwTHlddM7RUWqOUQt9zQdFc
         Y6Uf3NaX3RMJINboyz7+9cYgVUK2KrdhvuVKA1TGHozThnbIDzfqx0pAVmlcs0YFwD41
         9w/buwTGtVBrZReaiiXd1X9xeTAU3Osm1qKMBW+qL7RI4zw8qru8r+XT1DYcr/pJV/cX
         786skfE+jNnHv3CfY3NBvvwZ0y9HpEXCGFosd1ASs8zKURNCRbzYWhbhtN0QcKqqs2d0
         QOTQBHwT3VkVdyLUNAONpJkU9HQAWM8DAi1TlDguUXguBbLJKsDQGrNS1vzRZG4TwJsW
         /WWQ==
X-Gm-Message-State: AOJu0YwfjFNhSK/6+AqhA2gH5+oFLoLXu/woMCFWYwcCSP+v1EivLFNm
	nOJb94vlACwJ0/g0TfZWwhdU7v+3YZoizTNo4Ne/jWDMUtICM+UY
X-Gm-Gg: ASbGnctnIO0JWSueUG0b8Qk7yL6NXvO6QoBKizZzP+oZ4gf2WR9V5TM1fEdqSeQ3w/H
	45jfwTCvjhZDnsnM5huFdlp4AWgyRivfkMhNSHSnS3gN+sRfKn935dpp2TuZj2K3PPNvmn/Sioi
	d79MvhLEqFJJxA9pxgLqiMdbksDTEU/e/SS7VWNzDWTd5FtMkvt43D86m+Gq9vxiFO+ixd7aLZX
	j5qGZw/hr36TFnrD6MSZP0vJekZV7cn+3tRQtN1gqVe3oWhF6GFeErXXpfkLi9gCjGGUVzbe9U6
	TfGZnmmmVL+QF2KGz8VuKTMD3+nGPbuaj3kN
X-Google-Smtp-Source: AGHT+IGowT3ZQ5qbHhh85uHgJn0gQFHZyZ3SfvaCRpEHdCdG0mg8YSw2JmnBmcHJEP2FHIVekhPOCA==
X-Received: by 2002:a17:90a:fb90:b0:2ea:7ba7:33b9 with SMTP id 98e67ed59e1d1-2edebf22a2dmr10408257a91.14.1732703211993;
        Wed, 27 Nov 2024 02:26:51 -0800 (PST)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de5767ddsm10177916b3a.185.2024.11.27.02.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 02:26:51 -0800 (PST)
Date: Wed, 27 Nov 2024 19:26:48 +0900
Message-ID: <m2plmhvuon.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: benjamin@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: Re: [RFC PATCH v2 08/13] um: nommu: configure fs register on host syscall invocation
In-Reply-To: <10522b8bd09c5900164692281cce47fef5bd6be8.camel@sipsolutions.net>
References: <cover.1731290567.git.thehajime@gmail.com>
	<894d17f7924e7d31bfd5d6595ee84158f7411e47.1731290567.git.thehajime@gmail.com>
	<10522b8bd09c5900164692281cce47fef5bd6be8.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241127_022653_567672_195E16CA 
X-CRM114-Status: GOOD (  28.95  )
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


On Wed, 27 Nov 2024 19:00:11 +0900,
Benjamin Berg wrote:

> > +
> > +	os_info("Checking FSGSBASE instructions...");
> > +	if (sigsetjmp(jmpbuf, 0) =3D=3D 0) {
> > +		asm volatile("rdfsbase %0" : "=3Dr" (fsbase) :: "memory");
> > +		host_has_fsgsbase =3D 1;
> > +		os_info("OK\n");
> > +	} else {
> > +		host_has_fsgsbase =3D 0;
> > +		os_info("disabled\n");
> > +	}
> > +}
>=20
> According to Documentation/arch/x86/x86_64/fsgs.rst it looks like this
> can also be checked using the HWCAP2_FSGSBASE bit in AT_HWCAP2.
>=20
> Maybe that is a bit simpler?

Ah, thanks.  This should be much simpler:

+#include <sys/auxv.h>
+#include <asm/hwcap2.h>
+void __init check_fsgsbase(void)
+{
+       unsigned long auxv =3D getauxval(AT_HWCAP2);
+
+       os_info("Checking FSGSBASE instructions...");
+       if (auxv & HWCAP2_FSGSBASE) {
+               host_has_fsgsbase =3D 1;
+               os_info("OK\n");
+       } else {
+               host_has_fsgsbase =3D 0;
+               os_info("disabled\n");
+       }
+}


>=20
> > [SNIP]
> >=20
> > =A0__visible void do_syscall_64(struct pt_regs *regs)
> > =A0{
> > =A0	int syscall;
> > @@ -49,6 +76,9 @@ __visible void do_syscall_64(struct pt_regs *regs)
> > =A0	if (syscall =3D=3D __NR_vfork)
> > =A0		stack_copy =3D vfork_save_stack();
> > =A0
> > +	/* set fs register to the original host one */
> > +	os_x86_arch_prctl(0, ARCH_SET_FS, (void *)host_fs);
> > +
> > =A0	if (likely(syscall < NR_syscalls)) {
> > =A0		PT_REGS_SET_SYSCALL_RETURN(regs,
> > =A0				EXECUTE_SYSCALL(syscall, regs));
> > @@ -63,6 +93,11 @@ __visible void do_syscall_64(struct pt_regs *regs)
> > =A0	set_thread_flag(TIF_SIGPENDING);
> > =A0	interrupt_end();
> > =A0
> > +	/* restore back fs register to userspace configured one */
> > +	os_x86_arch_prctl(0, ARCH_SET_FS,
> > +		=A0=A0=A0=A0=A0 (void *)(current->thread.regs.regs.gp[FS_BASE
> > +						=A0=A0=A0=A0 / sizeof(unsigned long)]));
> > +
> > =A0	/* execve succeeded */
> > =A0	if (syscall =3D=3D __NR_execve && regs->regs.gp[HOST_AX] =3D=3D 0)
> > =A0		userspace(&current->thread.regs.regs);
> > diff --git a/arch/x86/um/syscalls_64.c b/arch/x86/um/syscalls_64.c
> > index edb17fc73e07..d56df936a2d7 100644
> > --- a/arch/x86/um/syscalls_64.c
> > +++ b/arch/x86/um/syscalls_64.c
> > @@ -12,11 +12,26 @@
> > =A0#include <asm/prctl.h> /* XXX This should get the constants from lib=
c */
> > =A0#include <registers.h>
> > =A0#include <os.h>
> > +#include <asm/thread_info.h>
> > +#include <asm/mman.h>
> > +
> > +#ifndef CONFIG_MMU
> > +/*
> > + * The guest libc can change FS, which confuses the host libc.
> > + * In fact, changing FS directly is not supported (check
> > + * man arch_prctl). So, whenever we make a host syscall,
> > + * we should be changing FS to the original FS (not the
> > + * one set by the guest libc). This original FS is stored
> > + * in host_fs.
> > + */
> > +long long host_fs =3D -1;
>=20
> Right, the libc already uses it for its own thread-local storage. That
> is a bit annoying, as UML doesn't need threading in that sense.
>=20
> Note that similar handling needs to happen for every userspace to
> kernel switch. I guess the only other location is the signal handler.

Thanks too.
I guess the former (arch_switch_to) handles in my patch but the latter
(signal handler) doesn't.  Let me try to check.

-- Hajime


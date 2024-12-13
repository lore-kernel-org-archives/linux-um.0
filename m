Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A62E7717F
	for <linux-um@archiver.kernel.org>; Fri, 13 Dec 2024 21:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Subject:Cc:To:From:
	Message-ID:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8t+pvAMtOWDjCtG5J8ZuTH7O8Q4x6TstRG2+LrMbBso=; b=lg27nB6bX7nE4YAibATWL/DF1u
	6YHCuD2cRjm+7h8dYkceeJ6GR/CR08y2sFJSKVHPfX4fuuce+PzY3cKi1dbYbyRDVVOcHFN9yIW07
	NKsaeDV81y6RlJ2tYvxfHE1IN9pnzid+CPeLJEMJH6nE7Ie0XvHT/ofSWmOc8NRUVV5pQlh+2xZXC
	e+5wulri089ddY7fVKsVPfxA1ZPXaLR++4lvnRbHSryri3ZIp4IxW5djElu7GVWUC2GyKHqfE3VP1
	U4955HUZtwkBgRLMXqAVNEL/71VW0SxwV7TNgVcCU4+uvwAVSAhYOAhEgRYh+XAWnjKx/jtodreDV
	OiR/+PPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tMD9G-000000054me-2403;
	Fri, 13 Dec 2024 21:24:34 +0000
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tMD8Y-000000054fi-3DUz
	for linux-um@lists.infradead.org;
	Fri, 13 Dec 2024 21:23:51 +0000
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-7273967f2f0so2363688b3a.1
        for <linux-um@lists.infradead.org>; Fri, 13 Dec 2024 13:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734125029; x=1734729829; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8t+pvAMtOWDjCtG5J8ZuTH7O8Q4x6TstRG2+LrMbBso=;
        b=hpZnTMoxxsq71NQ7UAImFHrHozvl4odITcdlu2zXC8MsSmCN5NA3lXtgsXq9W2vOsZ
         AKKLxOWpj/H7UHthjaUtYBk4MSht5RgYjZmgCsfaxvk9Y5P2Zc6Ex1C+LjHAAtaqw6jr
         1Me8E/i044vLWb6BSvk/TKtolPfAgkpVkLmb5GIc7hYPEglAbmyRMs4I5mZycdBETSkf
         1u5gHqr51mT08R4jYr/ZVuBYGx3CJaghOhbLRvhkb8KoQxCOMJ81/4oM8zx61rvoCIhK
         LGAhR+H4sjnVN/bwuGCuykQJf/9JdcmCk9XajDnao7E2W6zAkLEWS7pqtzM6IAAwNltT
         XggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734125029; x=1734729829;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8t+pvAMtOWDjCtG5J8ZuTH7O8Q4x6TstRG2+LrMbBso=;
        b=icW4CwocUAWOppw71ZYY0kFpnDHgGkU97ZwbpvITttX0r03pOwoXt6jUGaKyKjw6Rg
         PCLUJRl7ULl9cp6gus9cVe3qhncOCCMJD2TX22jvUDzUwtyIhDFyIY2JuYTfkCWzUAxl
         GZravrqLZhMJcS3bg6gG64ay53AN6vRRMq//6bs8HpomiBpV0iDSLBT6fDsjGv3DXFm9
         OUY9FYEfpIjLOv/Vhop8gxtmjNgF6dE3vuRaoSmtFroQ1ydoLtUV8pLTWTttviq9MV+K
         cu3nWdLWCJRDVF6B2MuttcRqFnqxf1MsZ4TSb8+Ph29cAuiA9uXbCvuCWfm91lqtAUBX
         Gl1w==
X-Gm-Message-State: AOJu0Yw64OkpTNzO5QQGrhNZ7fplMsuyd6CtTCFmOTeocl6sFnOCKI6K
	VaLvItOin1p7vJSg1dXDf0sc4Rr5yJ8F0314CaM6b/kcIFTgD9wQ
X-Gm-Gg: ASbGnctinECZUzX7bq57mOGGY8bKF6HqWs8p7pXA17mpkE8zGZ/ZVKcn2mctSEKjvjj
	kDAOWfbFnXsZ9AmpVBewOcMzOd81WNBA4J6hnIvhn6zIpYGABg4GgYt9CqadC2RvpFhUlut0ZBb
	Zpk3kkkYCBIgia/MMu4U6k9DQ0wI96G6g3qlcqz3dPZ2DENCBlHOFlMkXpz6bTswNSn/+OhcNDA
	NDBsRNQpLksyaDIEOEg1Syj1l8ZYJMK4/IzG22buvO8ASDWC8Nfd/3W7yzPwiqpwK5uzvMV1bSB
	VJZ0JxwE48cpHg6EC4qYL3bwTNXYfzWnR5ZKdIyOAuQ=
X-Google-Smtp-Source: AGHT+IHm5jDaFWl/YmgjUBKhId5yd6hUrqANfbI90i7yVFkha7OT2ZmyCwMQWfL65vYaU3UyHkwPQw==
X-Received: by 2002:a05:6a20:1590:b0:1e1:d22d:cf38 with SMTP id adf61e73a8af0-1e1dfd6c603mr6501049637.21.1734125029354;
        Fri, 13 Dec 2024 13:23:49 -0800 (PST)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918bac570sm227247b3a.131.2024.12.13.13.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 13:23:48 -0800 (PST)
Date: Sat, 14 Dec 2024 06:23:44 +0900
Message-ID: <m2pllv5lb3.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: ebiederm@xmission.com
Cc: linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	kees@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 02/13] x86/um: nommu: elf loader for fdpic
In-Reply-To: <87bjxf1he1.fsf@email.froward.int.ebiederm.org>
References: <cover.1733998168.git.thehajime@gmail.com>
	<d387e58f08b929357a2651e82d2ee18bcf681e40.1733998168.git.thehajime@gmail.com>
	<87r06d0ymg.fsf@email.froward.int.ebiederm.org>
	<m2r06c59t9.wl-thehajime@gmail.com>
	<87bjxf1he1.fsf@email.froward.int.ebiederm.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241213_132350_804551_216B8499 
X-CRM114-Status: GOOD (  25.70  )
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


On Sat, 14 Dec 2024 05:01:58 +0900,
Eric W. Biederman wrote:

> >> Last time I looked the regular binfmt_elf works just fine
> >> without an mmu.  I looked again and at a quick skim the
> >> regular elf loader still looks like it will work without
> >> an MMU.
> >
> > I'm wondering how you looked at it and how you see that it works
> > without MMU.
>=20
> I got as far as seeing that vm_mmap should work.  As all of the
> bits for mmap to work, are present in both mmu and nommu.

hmm, at least MAP_FIXED doesn't work in current mm/nommu.c.
# also documented at Documentation/admin-guide/mm/nommu-mmap.rst.

> > I also wish to use the regular binfmt_elf, but it doesn't allow me to
> > compile with !CONFIG_MMU right now.
>=20
> Then I may simply be confused.  Where does the compile fail?
> Is it somewhere in Kconfig?
>=20
> I could be completely confused.  It has happened before.

If I applied to below in addition to my whole patchset,

diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index 419ba0282806..b34d0578a22f 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -4,7 +4,6 @@ menu "Executable file formats"
=20
 config BINFMT_ELF
        bool "Kernel support for ELF binaries"
-       depends on MMU
        select ELFCORE
        default y
        help
@@ -58,7 +57,7 @@ config ARCH_USE_GNU_PROPERTY
 config BINFMT_ELF_FDPIC
        bool "Kernel support for FDPIC ELF binaries"
        default y if !BINFMT_ELF
-       depends on ARM || ((M68K || RISCV || SUPERH || UML || XTENSA) && !M=
MU)
+       depends on ARM || ((M68K || RISCV || SUPERH || XTENSA) && !MMU)
        select ELFCORE
        help
          ELF FDPIC binaries are based on ELF, but allow the individual load

this is the output from `make ARCH=3Dum`.

  GEN     Makefile
  CALL    ../scripts/checksyscalls.sh
  CC      fs/binfmt_elf.o
In file included from ./arch/x86/include/generated/asm/rwonce.h:1,
                 from ../include/linux/compiler.h:317,
                 from ../include/linux/build_bug.h:5,
                 from ../include/linux/container_of.h:5,
                 from ../include/linux/list.h:5,
                 from ../include/linux/module.h:12,
                 from ../fs/binfmt_elf.c:13:
../fs/binfmt_elf.c: In function =A1load_elf_binary=A2:
../include/asm-generic/rwonce.h:44:71: error: lvalue required as unary =A1&=
=A2 operand
   44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x)=
 *)&(x))
      |                                                                    =
   ^
../include/asm-generic/rwonce.h:50:9: note: in expansion of macro =A1__READ=
_ONCE=A2
   50 |         __READ_ONCE(x);                                            =
     \
      |         ^~~~~~~~~~~
../fs/binfmt_elf.c:1006:49: note: in expansion of macro =A1READ_ONCE=A2
 1006 |         const int snapshot_randomize_va_space =3D READ_ONCE(randomi=
ze_va_space);
      |  =20

I avoided this issue (with nasty MAP_FIXED workaround) but there seems
to be still a lot of things that I need to fix to work with nommu.

> I just react a little strongly to the assertion that elf_fdpic is
> the only path when I don't see why that should be.
>=20
> Especially for an architecture like user-mode-linux where I would expect
> it to run the existing binaries for a port.

I understand your concern, and will try to work on improving this
situation a bit.

Another naive question: are there any past attempts to do the similar
thing (binfmt_elf without MMU) ?

-- Hajime


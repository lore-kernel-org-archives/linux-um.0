Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD976C54FC6
	for <linux-um@archiver.kernel.org>; Mon,  2 Sep 2024 23:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UaJezUaY19zxJWqob2w1cOAk5qiAPl5VHmtR3xKChPw=; b=d/YJNXOeW4k5VGaCTTdi7J7azu
	U968fpO2ufaMfs9hhuUNYdjNYxPvZFYurutCyc5/YcpoAhdqvTUQdgkXHLLW2Cp/PWtuMtp86IdzE
	n3uCgeqK9cZ8EsNbgqzi0FEQcG0f72KBKUKj1I/EsdYSHfrk0l4wTCkUvlho5BdZzDkvLJpkg06GR
	HrguW+99/8+AMF0B9httfGFqeHoJGMDHEkQk5vT7R1rk/szseuBfrV0OtuBttNzdRKVufo2JNcVHt
	ARqElyR0JkpubQcTJpfcq+f92l8fDfc9hqEv8XN4ZDKbtSkWtY16PGJyZZz/eKP7UAycWd2OykxTB
	z+pVti7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slGkb-0000000Fo8t-0LHC;
	Mon, 02 Sep 2024 23:46:25 +0000
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slGjZ-0000000Fns4-3ZPB;
	Mon, 02 Sep 2024 23:45:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1725320712;
	bh=UaJezUaY19zxJWqob2w1cOAk5qiAPl5VHmtR3xKChPw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SVJPlBNP8APfuR/jBD4BjKXOasjSRZ3dbEv80YacUUHbcdDw+XM6x2QOEMOi1xx0G
	 2YI84S67i5/r6XZ2EhcaDv98rdhCTGlEoi1jECCm64pD3ZPLG9/H5Q/8B0fDuEFnn0
	 ODaujSs7E9rewRWin3OvP+Wi7kVFPTMXmkAtlOVngxeC9c92hxF0K9sD5LWYyiAqz9
	 XX/5QjfzVMkzcIC5jr62Zzp+L4JnzRecg6m4Zt5sMtEE1k/SNxRAfgO7Uhbr4eH27d
	 TDyAw6f/mrTclwB3jDJ3y1IQnfoXHfFk61zd0A7zo2gIuket9WZa/x4aJ3zVCrY44b
	 JAHuQDXFAf6gQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WyQNR6tgxz4x1V;
	Tue,  3 Sep 2024 09:45:11 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Vegard Nossum <vegard.nossum@oracle.com>, Masahiro Yamada
 <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
 kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-um@lists.infradead.org,
 bpf@vger.kernel.org, llvm@lists.linux.dev, Vegard Nossum
 <vegard.nossum@oracle.com>
Subject: Re: [PATCH] kbuild: use objcopy to generate asm-offsets
In-Reply-To: <20240828083605.3093701-1-vegard.nossum@oracle.com>
References: <20240828083605.3093701-1-vegard.nossum@oracle.com>
Date: Tue, 03 Sep 2024 09:45:11 +1000
Message-ID: <875xrd7h88.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240902_164522_340143_591C19A4 
X-CRM114-Status: GOOD (  14.50  )
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

Vegard Nossum <vegard.nossum@oracle.com> writes:
> In order to give assembly code access to C structs without having to
> hardcore member offsets, the kernel compiles a C source file listing all
> the structs and offsets that are needed in assembly code. Using some
> C preprocessor trickery and a sed script, the compiled assembly code is
> turned back into C preprocessor code that in turn can be used by the
> asssembly code.
>
> This sed script is very hard to read and understand.
>
> Remove the sed script and compile the C source listing structs and
> offsets to an object file (instead of assembly code) that embeds C source
> directly. Then extract the C source using objcopy.
>

I threw some builders at this and hit a few errors:

parisc:
  # make -s -j 160 ARCH=parisc64 O=/kisskb/build/mpe_generic-64bit_defconfig_parisc64-gcc13 CROSS_COMPILE=/opt/cross/kisskb/korg/gcc-13.1.0-nolibc/hppa-linux/bin/hppa64-linux-  
  {standard input}: Assembler messages:
  {standard input}: Error: .size expression for main does not evaluate to a constant
  make[3]: *** [/kisskb/src/scripts/Makefile.build:244: scripts/mod/devicetable-offsets.o] Error 1

s390:
  # make -s -j 32 ARCH=s390 O=/kisskb/build/mpe_defconfig_s390x-gcc13 CROSS_COMPILE=/opt/cross/kisskb/korg/gcc-13.1.0-nolibc/s390-linux/bin/s390-linux-  
  In file included from /kisskb/src/arch/s390/include/asm/ptrace.h:11,
                   from /kisskb/src/arch/s390/kernel/vdso64/vdso_user_wrapper.S:7:
  /kisskb/src/arch/s390/include/uapi/asm/ptrace.h:167: warning: "STACK_FRAME_OVERHEAD" redefined
    167 | #define STACK_FRAME_OVERHEAD    160      /* size of minimum stack frame */
        | 
  In file included from /kisskb/src/include/asm-generic/asm-offsets.h:1,
                   from ./arch/s390/include/generated/asm/asm-offsets.h:1,
                   from /kisskb/src/arch/s390/kernel/vdso64/vdso_user_wrapper.S:5:
  ./include/generated/asm-offsets.h:51: note: this is the location of the previous definition
     51 | #define STACK_FRAME_OVERHEAD -96 /* sizeof(struct stack_frame) */

mips:
  # make -s -j 32 ARCH=mips O=/kisskb/build/mpe_defconfig_mips-gcc13 CROSS_COMPILE=/opt/cross/kisskb/korg/gcc-13.1.0-nolibc/mips-linux/bin/mips-linux-  
  {standard input}: Assembler messages:
  {standard input}:27: Error: junk at end of line, first unrecognized character is `M'
  {standard input}:212: Error: junk at end of line, first unrecognized character is `M'
  {standard input}:265: Error: junk at end of line, first unrecognized character is `M'
  {standard input}:338: Error: junk at end of line, first unrecognized character is `M'
  {standard input}:596: Error: junk at end of line, first unrecognized character is `S'
  {standard input}:608: Error: junk at end of line, first unrecognized character is `L'
  {standard input}:721: Error: junk at end of line, first unrecognized character is `L'
  {standard input}:806: Error: junk at end of line, first unrecognized character is `L'
  {standard input}:963: Error: junk at end of line, first unrecognized character is `P'
  {standard input}:996: Error: junk at end of line, first unrecognized character is `K'
  {standard input}:1161: Error: junk at end of line, first unrecognized character is `M'
  make[3]: *** [/kisskb/src/scripts/Makefile.build:244: arch/mips/kernel/asm-offsets.o] Error 1

riscv:
  # make -s -j 160 ARCH=riscv O=/kisskb/build/mpe_defconfig_riscv-gcc13 CROSS_COMPILE=/opt/cross/kisskb/korg/gcc-13.1.0-nolibc/riscv64-linux/bin/riscv64-linux-  
  In file included from /kisskb/src/arch/riscv/kernel/asm-offsets.c:9:
  /kisskb/src/arch/riscv/kernel/asm-offsets.c: In function 'asm_offsets':
  /kisskb/src/include/linux/kbuild.h:6:9: error: invalid 'asm': invalid use of '%c'
      6 |         asm volatile( \
        |         ^~~
  /kisskb/src/include/linux/kbuild.h:12:9: note: in expansion of macro '_LINE'
     12 |         _LINE("#define " #sym " %c0 /* " #val " */", "i" (val))
        |         ^~~~~
  /kisskb/src/include/linux/kbuild.h:15:9: note: in expansion of macro 'DEFINE'
     15 |         DEFINE(sym, offsetof(struct str, mem))
        |         ^~~~~~
  /kisskb/src/arch/riscv/kernel/asm-offsets.c:25:9: note: in expansion of macro 'OFFSET'
     25 |         OFFSET(TASK_THREAD_RA, task_struct, thread.ra);
        |         ^~~~~~
  /kisskb/src/include/linux/kbuild.h:6:9: error: invalid 'asm': invalid use of '%c'
      6 |         asm volatile( \
        |         ^~~


Full list here, but note there are some unrelated pre-existing failures:
  http://kisskb.ellerman.id.au/kisskb/head/259bba3447faaf5e5b12ae41a26a62978d4c1965/


cheers


Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC654C79FB7
	for <linux-um@archiver.kernel.org>; Wed,  9 Sep 2026 19:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+dGDqKIiorLm4PMRWZf+lcjSymk+duftPVKL8h3BRa8=; b=A5d6rw+cUbHp6EKoWFxJEIR95C
	Idh5BZuF5w247cv8dgocIvdCxm3fKL2bQDsx25fhHc/IubmrDumw3y0m9LPlNqvd0cuGi7H9QBeSR
	EioHilvrhZTuZuoLOJcQ6Tp7SUQRrtswrvkFRBp9uTNb2qnZ9i1UCEynU+2ADVNEECtxboLRIXWEt
	w1d3zCkMjk8f3opfS8gX8sbfuvUsAIFAYBT1kj4zUhd7+W29uEWQFvDVYP5XW+QxrDT/bRvl/e4T9
	plgYZ/59K/dZ6Z9dliMq1BnrLbIslrISXr5QgaKC1wxU41v6DuUAX+3nbNh3TJyymWw2I2bImcWOE
	Gl90Po0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4O2q-0000000CihT-1IGi;
	Wed, 09 Sep 2026 19:33:20 +0000
Received: from terminus.zytor.com ([2607:7c80:54:3::136] helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4O2m-0000000Cigf-3Eqb;
	Wed, 09 Sep 2026 19:33:18 +0000
Received: from ehlo.thunderbird.net ([172.59.163.39])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 689JW0Ri241996
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 9 Sep 2026 12:32:01 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 689JW0Ri241996
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026082801; t=1788982324;
	bh=+dGDqKIiorLm4PMRWZf+lcjSymk+duftPVKL8h3BRa8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=gofX7hrQMbsXkfAGKbIB5EEVBWalAWuw926LqzLEOVYYNLyZUfbWEzWPGDLj9bbmQ
	 WFie+ve7lUQ9pYuRVmVYjV+EqzzAArpgHRWshxY1qKfnMcxxPUBe/xs1MmeSmnGIOJ
	 dPgyxNew5qsHsjhQOA41SlBB/MQHD0m+r1YFZE3wLCs3umtpLH2oSsE4iYDyt3+j/i
	 rnjM7tEna8nBlg7YqDxC5Ptjf5+Rcrbt1/0XzPeibvb/+oRmhKO1xpHus1ynWSXLJ8
	 MI9bdFysgi5uqG5wVEpJJTL/7pSn2oMlC1a/K6We8WFSaRVoteYLUt+37PBgC/p1jC
	 eVbxDJsilqYjA==
Date: Wed, 09 Sep 2026 12:31:53 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Peter Zijlstra <peterz@infradead.org>,
        =?ISO-8859-1?Q?Thomas_Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
CC: Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?ISO-8859-1?Q?Bj=F6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <lossin@kernel.org>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
        Danilo Krummrich <dakr@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Christophe Leroy <chleroy@kernel.org>, Boqun Feng <boqun@kernel.org>,
        Nicolas Schier <nsc@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev, linux-mm@kvack.org,
        linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-mips@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Jan Stancek <jstancek@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH v5 12/24] vdso: Add the vdsocheck tool
User-Agent: K-9 Mail for Android
In-Reply-To: <20260908071911.GU4120091@noisy.programming.kicks-ass.net>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de> <20260908-vdso-absolute-reloc-v5-12-3a93791af1cf@linutronix.de> <20260908071911.GU4120091@noisy.programming.kicks-ass.net>
Message-ID: <ABBC0C50-847F-406A-B426-55D0C2BE15EA@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260909_123316_815142_83EA1383 
X-CRM114-Status: GOOD (  16.35  )
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

On September 8, 2026 12:19:11 AM PDT, Peter Zijlstra <peterz@infradead=2Eor=
g> wrote:
>On Tue, Sep 08, 2026 at 08:33:46AM +0200, Thomas Wei=C3=9Fschuh wrote:
>> All vDSO code needs to be completely position independent=2E Symbol
>> references are marked as hidden so the compiler emits PC-relative
>> relocations=2E However there are cases where the compiler may still
>> emit absolute relocations, as they are valid in regular PIC DSO code=2E
>> These would be resolved by the linker and will break at runtime=2E
>> This has been observed on arm64, see commit 0c314cda9325 ("arm64: vdso:
>> Work around invalid absolute relocations from GCC")
>>=20
>> Introduce a tool to check for absolute relocations during the build,
>> as the current inline-shell logic is not expressive enough=2E
>> The check is done on the object files as the relocations will not exist
>> anymore in the final DSO=2E As there is no extension point for the
>> compilation of each object file, perform the validation in vdso_check=
=2E
>>=20
>> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas=2Eweissschuh@linutronix=2E=
de>
>> ---
>>  Makefile                    |  19 ++
>>  lib/vdso/Kconfig            |   5 +
>>  lib/vdso/Makefile           |   2 +
>>  lib/vdso/Makefile=2Einclude   |  14 ++
>>  lib/vdso/check/=2Egitignore   |   3 +
>>  lib/vdso/check/Makefile     |  34 +++
>>  lib/vdso/check/elf=2Ers       | 498 ++++++++++++++++++++++++++++++++++=
++++++++++
>>  lib/vdso/check/vdsocheck=2Ers | 154 ++++++++++++++
>>  8 files changed, 729 insertions(+)
>
>Urgh, does this mean I have to have rust installed just to build a
>kernel now?

It was going to happen, and now we'll have to suffer the instability of ru=
st=2E=2E=2E


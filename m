Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D675E606A319
	for <linux-um@archiver.kernel.org>; Thu, 22 Oct 2026 15:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=A6mLbVzj;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=2kUGpeTG;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=rACQg86H
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=UzBCi/OSOXBVd/hf35Hctx/8s00KKyC8gNB54GWWKuw=; b=A6mLbVzjRe1YR9HtSqPpwG4w/4
	0U5w4lsv+5ovHoI4cm2hhUS7skE5J+umpSfYKKG7T/SkZPR1AWF7t1HAkBRS4cRNjJGQfZ2lYjnZW
	jqxIzLuwc9QyPAPNR5279qg6glK2Zc50uk+OinYfEYCbqrD/B7mbspy2pFqeksEugkuPkwpPpSHl7
	/i2buHzV8rwTppkJbkRD1F+FfIE7gmUDE/ImnCRztKh5reOxOU6szwPGxvpUpUB56pHQjd9inEsoO
	A4KAx59nvfvEKIfakux5ExWXxZakVFFNEPDhegmK6iAkEPcNKz963HmAOykhBrxZYSIXt4Sw8KUA4
	xZXb5o3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJuJY-0000000ENCG-3mOQ;
	Thu, 22 Oct 2026 15:02:44 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJuJV-0000000ENBV-23v0;
	Thu, 22 Oct 2026 15:02:42 +0000
Date: Thu, 22 Oct 2026 17:02:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792681357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UzBCi/OSOXBVd/hf35Hctx/8s00KKyC8gNB54GWWKuw=;
	b=2kUGpeTGDVBuYHmtDUk+ioLvFvif4ltj8rhWzocDuPm3HaFe4R4vTlOrnH+/NsK85KtmTp
	BQjRWdChCYWAdK0+eKUDRrdj71IFDIxlOzl/dpE7YHJOp63rkeZsrL+lIMWPOayKDZmWQS
	jZAmsd4OLiERAIm81xpmW1yxnaZhra+XaRdURt8feLSfDQkUZypkuicnE2Chx4WDXJq1W7
	gDW8/bA/PN+qgiQxlc+hLTJKpE5MORxYd7/+QpWeOeTOBVrrUrdM+PZPV0PqyhtRPzLVvf
	zZtCZj7gdLMshXYHbUIElhTwDBoSLh7+UVN4FV0jNASdMsB3S53YU8lnjUcMbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792681357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UzBCi/OSOXBVd/hf35Hctx/8s00KKyC8gNB54GWWKuw=;
	b=rACQg86HepNQ8r26wtL/lrV9xxe+QpJ6z/mp4SnHXzsO+wI4ld+mzpC3AGpr+fKJ/pFfac
	AwRn+5gmUDC3CcCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Guo Ren <guoren@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Helge Deller <deller@gmx.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Richard Weinberger <richard@nod.at>,
	Chris Zankel <chris@zankel.net>,
	linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
	linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>,
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
	linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch 16/18] x86/entry: Get rid of the sys_ni_syscall()
 indirection
Message-ID: <20261022150235.V2CSdtmu@linutronix.de>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.493733289@kernel.org>
 <20261022142425.3Wx-RrU5@linutronix.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261022142425.3Wx-RrU5@linutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261022_080241_695314_B1825290 
X-CRM114-Status: GOOD (  11.53  )
X-Spam-Score: -2.8 (--)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-22 16:24:30 [+0200], To Thomas Gleixner wrote:
> The test could be updated via the hunk below in case the new behaviour
> is what is expected. hpa made the extension to the test in commit
> 795e2a023b808 ("selftests/x86/syscall: Add tests under ptrace to
> syscall_numbering_64").
>=20
> diff --git a/tools/testing/selftests/x86/syscall_numbering.c b/tools/test=
ing/selftests/x86/syscall_numbering.c
> index ca0eca7b9dced..1435394fba022 100644
> --- a/tools/testing/selftests/x86/syscall_numbering.c
> +++ b/tools/testing/selftests/x86/syscall_numbering.c

Now I notice the fix depends on CONFIG_X86_X32_ABI=3Dy (fails for =3Dn).
But we want to get rid of it anyway so=E2=80=A6
CONFIG_IA32_EMULATION is not affected (with the fix).

Sebastian


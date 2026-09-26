Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C9AC9832A
	for <linux-um@archiver.kernel.org>; Sat, 26 Sep 2026 19:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Io4wnXahglDcD1fw17hJtB+q5cY1BH8blFTxuDCKiG4=; b=D/RPRz7LRdeMMLAxRoovvdnW8L
	gO7xqKGnVgqxezFYF2NSzACg+Mft+aS1iNX8n6Z2pWRzh1kSxaMy32iaIuo/LWl9bs9goaMYAQWrs
	Q6MNPCsdqNuDP5VHPZGSdFbTadsKr5bJtckxi87+mc0+CkI2kcx0H/sooVacbhvd1qQPrNmfCbOoq
	mBqqwUpl5UA8TUtd0xw9829oPCUyW5B0HjbLqqjSN/KyeyqXi8sghueOGa9QNPCZ92d5jjDYTxlV/
	izQJPzxHYUfAnwOJzLcZXZQPCCzApvUs8KIj/YYpLkEQKzfwL7t0Fs5wh5xgrJBp65lNKHDz7UviA
	/KE3eynQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAYRo-0000000Flwj-0bFA;
	Sat, 26 Sep 2026 19:52:36 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAYRk-0000000FlwD-2c20
	for linux-um@lists.infradead.org;
	Sat, 26 Sep 2026 19:52:34 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5631A40E01F9;
	Sat, 26 Sep 2026 19:52:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id yVhWzCsEK9wq; Sat, 26 Sep 2026 19:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1790452325; bh=UiMSyRFKs7VC0vsliyJ+JCT7GZBHFu90GqFe0oIG6hE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VSV6b0Pfpcbadj+z1O0dIqxuh8GsGgZAsmDEln8avnprJpQy12o7Tty9JXLw/EBs3
	 E+uWgY8bJi+pwGk9P9wAP2Timg+l9KXHF4ZVAN8vacoolIITh5pPwNzo7Uat4mM4/H
	 Emwain9eUGcvJBpst3gdFHWric4ioFhjhrlpCeQ8Cb9WiQSAA4UOVAPUWf9xOE0+fC
	 Mn4qNNzJnoXi0YyieOP/5LYqPfmbxGth5Lu8YR6RrsX4nBxu+qbCBqdJhsFQMB7d+A
	 RxTKzqRdre/6a7NAx6i+/1KUAqyCYL2r3hQK1d7qV5yn669k1lphmN1PQdt/GJHjBY
	 xfxv65ZyQEkwnivnDOHpp9djTTzHQ7x5PjQdpzbVfbVEjuIUomdinddrUQrpUXT5UA
	 0lFQVC5iirRU/3TbzPIhv6qP3oIU+Xi+GkdbRSLj9VXCSZE8cx/S/zqkbf0rUxYFWT
	 b5UmgVG5BMW5fyzWpVDA9D0ulTVUxQJCNeeILutVWQOsoPFPy6KhlSmmLZxVCTnAH4
	 b4WFDeur8BoODY6CEOHvuaW9R5LMu0jW8ShEGlezD12JkmmubDUijfPsTMnWtqbcrW
	 dQRCyLwiWHAaoHzOgtcYid2tY+w9pjcVXbMbMjauHf9rWJXN7uJ4dfLK88FqmNOlHp
	 olNsauftvm5VpsJZRDtaWeOY=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CC81F40E00E7;
	Sat, 26 Sep 2026 19:51:48 +0000 (UTC)
Date: Sat, 26 Sep 2026 12:51:45 -0700
From: Borislav Petkov <bp@alien8.de>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Oleg Nesterov <oleg@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [PATCH] x86: uapi: ptrace: guard register offset macros with
 __ASSEMBLER__ or __FRAME_OFFSETS
Message-ID: <20260926195145.GBargiUSEEqjWPpuaK@fat_crate.local>
References: <20260821-ptrace_uapi-v1-1-3de8638a29f2@google.com>
 <e801211b4c71ddd919fa5d7b9c859b86addf3fb7.camel@sipsolutions.net>
 <CAKwvOdkMK9Tj=JgsPeQj6_Xtx3FgZK2SWTSJVU_BJ7G17pDC2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdkMK9Tj=JgsPeQj6_Xtx3FgZK2SWTSJVU_BJ7G17pDC2w@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260926_125232_846263_9B784D92 
X-CRM114-Status: GOOD (  13.20  )
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

On Fri, Sep 25, 2026 at 02:25:47PM -0700, Nick Desaulniers wrote:
> On Thu, Sep 24, 2026 at 7:54=E2=80=AFAM Johannes Berg <johannes@sipsolu=
tions.net> wrote:
> >
> > On Fri, 2026-08-21 at 15:45 -0700, Nick Desaulniers wrote:
> > >
> > >  arch/x86/um/asm/ptrace.h               | 4 +---
> > >  arch/x86/um/ptrace_32.c                | 1 +
> >
> > This seems like a simple adjustment for what you need to do in x86, s=
o
> > that's OK, but I don't think we'll take this through the UML tree.
>=20
> Appreciated! I agree, maybe with Oleg's review this can go via the x86 =
tree?

Do we want it in stable too even if it is not really stable material so t=
hat
userspace does not have to upgrade kernels just for this?

Or are they simply copying upstream UAPI headers from the latest kernel s=
o
that stable backports don't matter?

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


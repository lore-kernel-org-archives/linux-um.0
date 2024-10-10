Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E00CFC5E7
	for <linux-um@archiver.kernel.org>; Thu, 10 Oct 2024 17:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YWTfDGJOVIcVIWG5RKfiNKmMCfgGLl0hOHgzmSzW7HE=; b=lqgh5u3ViEW3uGLtyNi1r9W9OD
	RWVIS1Z9wVm+NNBcuaAUND2uF8I3oq9Lw73ESFZki2h2kQgU2EHm2OI2yaQXDKnNpR48fCxPx51RV
	lDOKGrNDfQ7pib7JYGs5e1iN+F5wLo+MGzjPkKzFiOFWbUIidesl6Cho/U7eBQL7ttKlZqrr1sPbm
	KqEAabw89UjDL9Jz1EDRWe4ymkqAtnt57W6vg+KZnKH92RLmIZYpHfGG+ixYYSbXhRHerfohk9+Ui
	ic/A14VDQSX71sGZZ12fL5dTtGnczSPNZBg4ntdwb4YcuN0+bPyrnOVs1qd5uFfJSGbj4ddclgKYs
	eW4yMlhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sywov-0000000DfIa-074d;
	Thu, 10 Oct 2024 17:19:25 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sywoF-0000000Df6q-06Qi;
	Thu, 10 Oct 2024 17:18:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=YWTfDGJOVIcVIWG5RKfiNKmMCfgGLl0hOHgzmSzW7HE=; b=QuSZoO2TBDAExKucwr5fRH3C9k
	0W+HjyTI3VjC4JgrTExoFVPT5MF2PJVdxb95MZS0QTbSDQhQ/xgGOkQvn3lpq/BncrCV8dSAJHtnj
	4Z+/MaJbbfGrVUuvFVgUDWBHNX4mOoGmUtAGUAbrJGTaLdpcqBJj8RjUjQwLowWLyv0VU8tDY2G5j
	e7goae5ZfmhkO3/1FJSk6dnKG+vWEp0FgQ+B+9Qi4mgGyNHvfZNRgxgDdWIIwkrD3zr92UH2bYM5A
	oaR0fQhs26aI+PeGEsYZMu040YAjH1MXDRobX7KSFbibr7JM28H7Zwv5cetInO0Dx9HX6RGhN3Yh8
	0oZiVuNw==;
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sywoC-00000005T0q-02Hb;
	Thu, 10 Oct 2024 17:18:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id E7F71A44C1F;
	Thu, 10 Oct 2024 17:18:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A01C4CEDB;
	Thu, 10 Oct 2024 17:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728580711;
	bh=vaucBuX2fMrEpT3kygwI4CcFnWG5blOdj+4yYIH1/lc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YGQC3YGTpIM/Tv02Vn7usGJD/6tt+x+KTKu3UxnMO5NCC8+C7ZPh5ezrehFriglwe
	 0kHT558np8Wr8rw+tHrk6iFdI6TYZzj/XuDQyl1ohCHGBlLvqRKvMY9o2gFo+NuycW
	 y20uvBOD9Gdu+xnvXvzrx2PBIPwMfqD7Kk74Y5ZM4wURiZxI3kabAPnyXgltKV5Te8
	 nLgYuMl0XB6UP3CI6ocVV8lyp79EB210TDlqZm0fWRLk96yJAx28fczirFRv8Ok4xn
	 g28YaYfndtMh2lJkpow1r3uH0m1V9UcGEfvj2KBq6mV0UhVTJerIhIuFum/RTZvtMI
	 Z12HDd0NC/l1Q==
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-8354851fcabso48912239f.2;
        Thu, 10 Oct 2024 10:18:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUBmQEpbLW3U1XhBNmLaF6RumPEExPMY3tn4qTyIhDVeLOwVTaxw77R/34G7hmQrVorGWtqaFyZpJ4=@lists.infradead.org, AJvYcCUrkLH7sK73Qwxx3CCzwEhAzTMOzuH8kq7Q41392q6zpo0Miz5cXB24oPUHwm8BUnm1mVH8eLounez/QyQ=@lists.infradead.org, AJvYcCWiedAUlsaIB7MOu0/uxOgh7+Eolg3TaYj2OBhPp9LQwn0rgJ5qSPVrahsKG608t6xIVjqZTT5hGFhmuw0xB3um@lists.infradead.org, AJvYcCWo8jD5Cb2TpzVzbQGNORTn8iSBhbz0/Wv3ppJMUHa95y5W6aG+MyWzfxQ8Ou65A6NCjA6CdjTX40qErDAswJ8=@lists.infradead.org
X-Gm-Message-State: AOJu0YyTgs93AkkUgpc/zNMrHDw24mgTAQUnu1aq/cfCuar48cCE6O6v
	8LMZ+h8JgQhXqHS9p6B3yg/PhR2lgfZLam4jO4JI5ftPDEkG+CEkwnM1JiLVq7iSHuwnzI499LM
	3QZpfd7/zbloM1iNA7F6qf/F5eaU=
X-Google-Smtp-Source: AGHT+IGszKBBrf1gYsUhslMqcPNpC/f6sAFFbsmL+u+zGmeEd2sYZs3+7Tvb9T+CKCsx/nhk3yidKvoEgysxI18Lmn4=
X-Received: by 2002:a05:6e02:144d:b0:3a0:92e5:af68 with SMTP id
 e9e14a558f8ab-3a3b51daa94mr2839515ab.15.1728580710921; Thu, 10 Oct 2024
 10:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <20241009180816.83591-1-rppt@kernel.org> <20241009180816.83591-5-rppt@kernel.org>
 <CAPhsuW66etfdU3Fvk0KsELXcgWD6_TkBFjJ-BTHQu5OejDsP2w@mail.gmail.com> <ZwdpnPKKQGF5DtSv@kernel.org>
In-Reply-To: <ZwdpnPKKQGF5DtSv@kernel.org>
From: Song Liu <song@kernel.org>
Date: Thu, 10 Oct 2024 10:18:19 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6gb76T_75TPzb-AvfyAcYE83iYhDpjJNHJQWDd3Fki_Q@mail.gmail.com>
Message-ID: <CAPhsuW6gb76T_75TPzb-AvfyAcYE83iYhDpjJNHJQWDd3Fki_Q@mail.gmail.com>
Subject: Re: [PATCH v5 4/8] module: prepare to handle ROX allocations for text
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andreas Larsson <andreas@gaisler.com>, 
	Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@quicinc.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christoph Hellwig <hch@infradead.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Dinh Nguyen <dinguyen@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>, 
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Kent Overstreet <kent.overstreet@linux.dev>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Peter Zijlstra <peterz@infradead.org>, 
	Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, 
	Stafford Horne <shorne@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Uladzislau Rezki <urezki@gmail.com>, Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>, 
	bpf@vger.kernel.org, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-mm@kvack.org, linux-modules@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-trace-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	loongarch@lists.linux.dev, sparclinux@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241010_181840_381660_955DAF9A 
X-CRM114-Status: GOOD (  15.78  )
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

On Wed, Oct 9, 2024 at 10:47=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Wed, Oct 09, 2024 at 03:23:40PM -0700, Song Liu wrote:
> > On Wed, Oct 9, 2024 at 11:10=E2=80=AFAM Mike Rapoport <rppt@kernel.org>=
 wrote:
> > [...]
> > > diff --git a/include/linux/module.h b/include/linux/module.h
> > > index 88ecc5e9f523..7039f609c6ef 100644
> > > --- a/include/linux/module.h
> > > +++ b/include/linux/module.h
> > > @@ -367,6 +367,8 @@ enum mod_mem_type {
> > >
> > >  struct module_memory {
> > >         void *base;
> > > +       void *rw_copy;
> > > +       bool is_rox;
> > >         unsigned int size;
> >
> > Do we really need to hold the rw_copy all the time?
>
> We hold it only during module initialization, it's freed in
> post_relocation.

Ah, I missed this part. Sorry for the noise.

Song


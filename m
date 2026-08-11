Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4329C5CFC1
	for <linux-um@archiver.kernel.org>; Tue, 11 Aug 2026 08:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kRDEH2ssIQhIkVPOR6PkKFR0aBPP8ALbaUyGO3LvVVE=; b=HjpoQvhanpW09Hnx2M98lOUBSB
	usQWWTaH3O4nmT4WYVdln2i4nUme48jZhSMQtAVzMl01rlAgW4uq5zBmdYN34KGOnVYefMkRbWWiB
	uOql8GDP7G1kuNJPa8uqhr98M0EOeCFu+QCjOj0D42GluU2IATlonPBoWZK1H1BiQK+0VFZzBWhzC
	oMbg0GggnWMK61zd38PnKEPeo7wiSTEmQoPuJ7u38yYrq9Vi40FCI0n8SVeeU+FhLezh7S9a0oMSb
	F9MVRhK8secXtiHGohn+h9hoi75QW0XGMz00VBwpcYm7N7DiqfukzbrjWwuI58WnclihbAHN/Pld4
	voTHWf+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wthZ3-0000000DZiF-2hFW;
	Tue, 11 Aug 2026 08:10:25 +0000
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wthYz-0000000DZgk-474H
	for linux-um@lists.infradead.org;
	Tue, 11 Aug 2026 08:10:23 +0000
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so24575415e9.3
        for <linux-um@lists.infradead.org>; Tue, 11 Aug 2026 01:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786435819; x=1787040619; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kRDEH2ssIQhIkVPOR6PkKFR0aBPP8ALbaUyGO3LvVVE=;
        b=IbCB4UCt65CWD7whx42PKHjHdRoRnSSGa0kkGnLuKqXAxAnpad3VEZmuuHcAq3b54J
         H/O1DeFRcJ7LHZQjBvDAW3JfZ27Cl2PDXTt6henxcQjnMHDQF/byEJO/fBYVB9LkVJFe
         idXL/r4d0U5HA/MJfwirD9JN70sPjTnqOzEWgetCfqNClPZTJwgYFfqKYRuOSb+k5Zar
         v56Zj7G/065dFzrmzC4Pf1Y2Px9X0IWd5A5yPXxYW2VCoP5QIllBwh5MWRAzNjJXwfUN
         goxTi2UeY0PqWTK0k12Zmt1M0ppIxt5VjpPBopjzt7S/JPIGDzTrEod6HAWg9EScVXEC
         F2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786435819; x=1787040619;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kRDEH2ssIQhIkVPOR6PkKFR0aBPP8ALbaUyGO3LvVVE=;
        b=cDYilO8mRq97OB42LeJ/qa0d8BKZz5/Q5gtIAuwIk7T68ynRa6QKd+XN/4tMDpt+ta
         5EkFo2JN2A3zc0/Ya7Aa/NgAJiNK16V/IsskQm9qLcZ+ZD0zSfxtF5RrGLp9pAnMun6v
         MrjX3CX5p2juczpkOzgYBJTbs3TxeBGc5qwXdLNQVNzz8D2F1ZtakUEh+tCPhf9Nfjgo
         FxTwLenCC5bWj26ApoG6AMnFWCQiDZJ+Gf92coYQzxUTk9fO612d+kX/XbxeZHf6R1Sc
         zcMQhXi4svsOoq12YiDOFFPoFXY7Yw1ZOjzgzrEBQeJa1u8QxSFXuY4dHWwWrkxFnZm5
         spvA==
X-Forwarded-Encrypted: i=1; AHgh+RqpcFcO+adkMlkxH4z6zB0dt9Xx0q51feDVA9Iam0mwJRc4a+cX6ar1RkcouSSLIUidF1RPBldtRA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyhv5PpFQgRPJSZX5Gx/q4FszqdneCtY17ZWbwGRtCK42NE/87k
	HnHoIxUq674gBQGmmROaDIkSWutEZmopoEZBZCaFLXze1cAQG+3cjncZ
X-Gm-Gg: AR+sD10n2Bqx40djPOzdxrEUZFkpPMvE6e5q4gQCrgpSYPVi1JXHSO98LGX9hf+0r0r
	inSMLMfoAIvCkz4LsLP979cCEql7SC6SU11Hh/j7xmAuKJpeapKtMNAmwby1JXLYX0Cq2/gb/q8
	YjZFGebmz69geWWPz0M9QJlgYDVx+8SSP2q3NP6M+UcTFRMJWNyAG+XZSYPlN1Y+y6YqAPFvel4
	8m0YjxbEMTg+SlIYOKgbJvLQfQSRoDMd3n32wU/8oNcDYYVqZ6Nkxvu4BQp8wNViLunYSx+IeCP
	mP0mqFB1ajzqhBgNKD20FvPaT25DaUMlGTemnU8xBn/FrYl8zAWLZOphNsuUAqG0+Y6TKwNINht
	VP1Dv2zlPXU03Zb/bZBBehO+ECSGSj1DPGoK14wbZ2rL9ybbjKoWKMyo3zhfRei8Vtj2QuagUfD
	4CUV82NFrPcZRJg26ENjApDKK+kG684prN/9cJHm53igF8wZ7cEjqXQ01WZW64eYNWGka3p5E2o
	Qx+sx74SZhHluc8RuTmDdRI24630E91CgE=
X-Received: by 2002:a05:600c:821b:b0:499:6a92:fff1 with SMTP id 5b1f17b1804b1-4997847e9b5mr25827975e9.18.1786435818734;
        Tue, 11 Aug 2026 01:10:18 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4814a5ac6e6sm2454288f8f.6.2026.08.11.01.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 01:10:18 -0700 (PDT)
Date: Tue, 11 Aug 2026 09:10:16 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Kevin Brodsky
 <kevin.brodsky@arm.com>, linux-mm@kvack.org, Andrew Morton
 <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R.
 Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Russell King <linux@armlinux.org.uk>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Ryan Roberts
 <ryan.roberts@arm.com>, linux-arm-kernel@lists.infradead.org, Huacai Chen
 <chenhuacai@kernel.org>, loongarch@lists.linux.dev, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>,
 linux-parisc@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 linux-s390@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org, Richard
 Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
 <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ning Sun <ning.sun@intel.com>, x86@kernel.org,
 tboot-devel@lists.sourceforge.net, Ard Biesheuvel <ardb@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, linux-efi@vger.kernel.org, Vishal
 Moola <vishal.moola@gmail.com>, Alistair Popple <apopple@nvidia.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 03/22] mm: introduce MMF_KERNEL flag and set it for
 init_mm
Message-ID: <20260811091016.5ca67143@pumpkin>
In-Reply-To: <33fc9d31-2866-4315-9510-0004deb93994@kernel.org>
References: <20260714-remove_pgtable_cdtor-v1-0-44be8a7685d7@arm.com>
	<20260714-remove_pgtable_cdtor-v1-3-44be8a7685d7@arm.com>
	<01f07ea2-8bdd-4450-8a49-548f8b646cfd@kernel.org>
	<33fc9d31-2866-4315-9510-0004deb93994@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260811_011022_035934_1C15CDEC 
X-CRM114-Status: GOOD (  22.91  )
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

On Wed, 5 Aug 2026 14:07:01 +0200
"David Hildenbrand (Arm)" <david@kernel.org> wrote:

> On 8/3/26 15:59, Christophe Leroy (CS GROUP) wrote:
> >=20
> >=20
> > Le 14/07/2026 =C3=A0 16:03, Kevin Brodsky a =C3=A9crit=C2=A0: =20
> >> mm code often needs to know whether some mm represents a kernel or
> >> user address space. This is currently done by comparing the mm
> >> pointer with &init_mm; besides not being particularly elegant, this
> >> ignores the fact that other mm's (e.g. efi_mm) may also represent
> >> parts of the kernel address space.
> >>
> >> Introduce a new mm flag MMF_KERNEL and set it for init_mm.
> >> Subsequent patches will use this flag to replace comparisons with
> >> &init_mm. No functional change is introduced for now. =20
> >=20
> > Did you consider performance impact ? This test is usually done in quite
> > critical memory handling functions.
> >=20
> > init_mm is known at link time. Before your patch 08/22 there is just a
> > comparison of mm (r3) with a constant (loaded in r10):
> >=20
> > c0014048 <assert_pte_locked>:
> > c0014048:=C2=A0=C2=A0=C2=A0 3d 40 c1 09=C2=A0=C2=A0=C2=A0=C2=A0 lis=C2=
=A0=C2=A0=C2=A0=C2=A0 r10,-16119
> > c001404c:=C2=A0=C2=A0=C2=A0 39 4a 03 98=C2=A0=C2=A0=C2=A0=C2=A0 addi=C2=
=A0=C2=A0=C2=A0 r10,r10,920
> > c0014050:=C2=A0=C2=A0=C2=A0 7c 03 50 00=C2=A0=C2=A0=C2=A0=C2=A0 cmpw=C2=
=A0=C2=A0=C2=A0 r3,r10
> > c0014054:=C2=A0=C2=A0=C2=A0 4d 82 00 20=C2=A0=C2=A0=C2=A0=C2=A0 beqlr
> > ...
> >=20
> > After patch 08/22 we have, it first checks that mm is not 0, then it lo=
ads the
> > word located at mm+528 then AND it with 0x1. This load might be costly.
> >=20
> > c0014048 <assert_pte_locked>:
> > c0014048:=C2=A0=C2=A0=C2=A0 2c 03 00 00=C2=A0=C2=A0=C2=A0=C2=A0 cmpwi=
=C2=A0=C2=A0 r3,0
> > c001404c:=C2=A0=C2=A0=C2=A0 7c 85 23 78=C2=A0=C2=A0=C2=A0=C2=A0 mr=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 r5,r4
> > c0014050:=C2=A0=C2=A0=C2=A0 41 82 00 10=C2=A0=C2=A0=C2=A0=C2=A0 beq=C2=
=A0=C2=A0=C2=A0=C2=A0 c0014060 <assert_pte_locked+0x18>
> > c0014054:=C2=A0=C2=A0=C2=A0 81 23 02 10=C2=A0=C2=A0=C2=A0=C2=A0 lwz=C2=
=A0=C2=A0=C2=A0=C2=A0 r9,528(r3)
> > c0014058:=C2=A0=C2=A0=C2=A0 71 29 00 01=C2=A0=C2=A0=C2=A0=C2=A0 andi.=
=C2=A0=C2=A0 r9,r9,1
> > c001405c:=C2=A0=C2=A0=C2=A0 4c 82 00 20=C2=A0=C2=A0=C2=A0=C2=A0 bnelr =
=20
>=20
> Is that a real problem, though?

The cost of the read is likely to matter most if the branch gets mispredict=
ed.
I'd also guess the mm isn't usually NULL - so that branch needs to statical=
ly
predicted correctly as well.
I'd also not assume that the mm is in the cache (unless the surrounding code
has already accessed it), the L1 data caches are small.

	David


>=20
> What we could do is to just keep the =3D=3D &init_mm check internally on =
configs
> where we know that there is only a single such MM context.
>=20
> Just a thought.
>=20



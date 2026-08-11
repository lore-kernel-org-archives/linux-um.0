Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D792BC5CFC1
	for <linux-um@archiver.kernel.org>; Tue, 11 Aug 2026 11:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WpHpX3dMx1OmUziffO2NidzvFmW3rlX7MNbm6J/WhK0=; b=4JokL4SM+dzZ1WLDeJgd7ZV4lM
	XpBkWFC44FLcsBHsCv58pRjwYBZM/8VvM1iVLuFWqzRMv2dEyYYHF1W3KqBXm7LEzFYzDi5am9Jlt
	sUj6zJvS8qDULLkZk9PNCZHnO27vAXs9e1UcVCSxsSYFTIx/Kn+3EdZlQVmxBki52k131EA31CyMY
	LKwr86AQqP+I3eAQKwsnG28RzXHZmSIaVLzVNVUgTllwlLnHOJaa29U1niKZfD4E1xR8st7v/iuHe
	8blqefNyuFCkQYmKu6A7jZoXv78rIdh3pxjHLFQTbFTdzXyQo3apVYCkdWu27f+UPtd/T2GS1JeGo
	eKs7/EcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtkWL-0000000Dv8j-2wUd;
	Tue, 11 Aug 2026 11:19:49 +0000
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtkWI-0000000Dv6P-2KgE
	for linux-um@lists.infradead.org;
	Tue, 11 Aug 2026 11:19:48 +0000
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-47f93b2fe4cso1621673f8f.0
        for <linux-um@lists.infradead.org>; Tue, 11 Aug 2026 04:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786447185; x=1787051985; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WpHpX3dMx1OmUziffO2NidzvFmW3rlX7MNbm6J/WhK0=;
        b=fUXKGApFcWgdI8I1EPP0gY+24s1nXgYPScThdfmH4kS2fxLmWTHqAbOqleJYSaK6Dq
         ld29z4aIkmHEo7BhMuR6qz3LTD9sPUCv0D3brqh5Y3x8lZIf4Rtcu0bIHPEET6Pde5sF
         0v3JX3+V+rLYQ2HhRi3tmMcdij5M78Rzg+AA6deqZ0nmUuIyahvjfsHUch2Y/s1mXgZ4
         DhoZcJCnEHAkmfhPVTwTmVRLV8J/OqTsNaz5EowABY6Vo76IIEIxS8vKQD3ljIWx+QrS
         F7hwxGRbGWQ4t6JHiTLKf3c0BYBZ3GbrDQ1FoMGXomNSuOVT5zHsa6+VQVAHx9gPn6KO
         jb5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786447185; x=1787051985;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WpHpX3dMx1OmUziffO2NidzvFmW3rlX7MNbm6J/WhK0=;
        b=YpNygswwpvCgfq2DyF5LFL+E7mdRw0uInozgYE3ZprRjYrwvgZ1yjEqoDKgFibq8yL
         dnQwMQwfRBZmdPgrkRoZYCHQp13224YRaguZz/Li+GXJuAjwWMYdCzy1Fa8tZCsg1ZlS
         j/iNB//WqDcAXz6NsJP7GxXWO1iqhNFL2pmig+wgxiHnDz89cPdAKYM20OK6DA3BHpwy
         q459RqK/6UhhLgx3+kgU0cTlpG5z2jluoGrU7FdECdN2ezPbs9XBYb26aebxsoYzTPzd
         WDLAMXX2qLreiWSdKYBEsoN5+NXmF/lQFcQ/k21MQzFgTTrI4xEvCdekZh/dIm3ePn7x
         5NHA==
X-Forwarded-Encrypted: i=1; AHgh+Ro/hUsrqHcIT8yMHy8dh5xWOLMIBVrNG8pTvSIPZOyYN8h/5TYafp9WXlPzuBcjxt+/tFdV7hklAg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzyzNsSzWIWJ/ypMHuVSUVLY/ASJXNSRQitH/gueiIJz9ucjo2G
	WLWJuxxDD4WeA41AqbwgXMlkv7U0ozdxVPKQuhv4B0ZhXqDRXHKGqyal
X-Gm-Gg: AR+sD11Z8pyIsMAhx88UmLygfjf05p5QIxzWndw+tchVu4DW21yle77hfmUE4Ifj/y0
	L5LmvpZOU29/UbkCguayoxO1KowVpCZqS9SEHgHkADChqIiE1Cm8T9XJHZDCDLVF547AuSwkQzE
	CMHVJ1Dn/SVEHFONkM0T8p1KSPBMP/HlUui0cpZQsQxAN9ghaK43RANHsPtyA7b3kGj99nAxdyc
	u180796VVvPLBRSWnD659IY4+hiRA7+ys6OTEx908FS8DpVBQ/D3DO/bw3vdzIugvkdTGe+uy1w
	R4iVlLvP7H27nRt012BJLxLZKEuiyK4jU7IvrJRgsLO/M4ZM6EH/d7FrsKLo4/9D8HB8PgEowPQ
	HQR1iqTErT0CIXEmbT5lEDG2bxp9wj1R6vdV9VbVnsMOmCRGVTeSXEjcdy5ZYLoTZDzfL73Piq7
	Rilro3x8yEfAhpCSddxwWMwq4t8PQZuRWT+LTtcEJPBOqWM5VEW381RTnsWIw/rfNH0Fqhu6xW2
	X5Ngh0TGoZ992VzjpdzS/gvMw==
X-Received: by 2002:a5d:5e8f:0:b0:47f:6f6a:6a7f with SMTP id ffacd0b85a97d-4814ad890fbmr4370323f8f.8.1786447184497;
        Tue, 11 Aug 2026 04:19:44 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4814a5ac75dsm3318120f8f.7.2026.08.11.04.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 04:19:44 -0700 (PDT)
Date: Tue, 11 Aug 2026 12:19:41 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, "Christophe Leroy (CS
 GROUP)" <chleroy@kernel.org>, linux-mm@kvack.org, Andrew Morton
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
Message-ID: <20260811121941.4ca20b88@pumpkin>
In-Reply-To: <643a624d-0106-44ed-a7f5-aaf9316f94fd@arm.com>
References: <20260714-remove_pgtable_cdtor-v1-0-44be8a7685d7@arm.com>
	<20260714-remove_pgtable_cdtor-v1-3-44be8a7685d7@arm.com>
	<01f07ea2-8bdd-4450-8a49-548f8b646cfd@kernel.org>
	<33fc9d31-2866-4315-9510-0004deb93994@kernel.org>
	<20260811091016.5ca67143@pumpkin>
	<643a624d-0106-44ed-a7f5-aaf9316f94fd@arm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260811_041946_670607_0600E2DC 
X-CRM114-Status: GOOD (  27.89  )
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

On Tue, 11 Aug 2026 11:00:09 +0200
Kevin Brodsky <kevin.brodsky@arm.com> wrote:

> On 11/08/2026 10:10, David Laight wrote:
> > On Wed, 5 Aug 2026 14:07:01 +0200
> > "David Hildenbrand (Arm)" <david@kernel.org> wrote:
> > =20
> >> On 8/3/26 15:59, Christophe Leroy (CS GROUP) wrote: =20
> >>>
> >>> Le 14/07/2026 =C3=A0 16:03, Kevin Brodsky a =C3=A9crit=C2=A0:   =20
> >>>> mm code often needs to know whether some mm represents a kernel or
> >>>> user address space. This is currently done by comparing the mm
> >>>> pointer with &init_mm; besides not being particularly elegant, this
> >>>> ignores the fact that other mm's (e.g. efi_mm) may also represent
> >>>> parts of the kernel address space.
> >>>>
> >>>> Introduce a new mm flag MMF_KERNEL and set it for init_mm.
> >>>> Subsequent patches will use this flag to replace comparisons with
> >>>> &init_mm. No functional change is introduced for now.   =20
> >>> Did you consider performance impact ? This test is usually done in qu=
ite
> >>> critical memory handling functions.
> >>>
> >>> init_mm is known at link time. Before your patch 08/22 there is just a
> >>> comparison of mm (r3) with a constant (loaded in r10):
> >>>
> >>> c0014048 <assert_pte_locked>:
> >>> c0014048:=C2=A0=C2=A0=C2=A0 3d 40 c1 09=C2=A0=C2=A0=C2=A0=C2=A0 lis=
=C2=A0=C2=A0=C2=A0=C2=A0 r10,-16119
> >>> c001404c:=C2=A0=C2=A0=C2=A0 39 4a 03 98=C2=A0=C2=A0=C2=A0=C2=A0 addi=
=C2=A0=C2=A0=C2=A0 r10,r10,920
> >>> c0014050:=C2=A0=C2=A0=C2=A0 7c 03 50 00=C2=A0=C2=A0=C2=A0=C2=A0 cmpw=
=C2=A0=C2=A0=C2=A0 r3,r10
> >>> c0014054:=C2=A0=C2=A0=C2=A0 4d 82 00 20=C2=A0=C2=A0=C2=A0=C2=A0 beqlr
> >>> ...
> >>>
> >>> After patch 08/22 we have, it first checks that mm is not 0, then it =
loads the
> >>> word located at mm+528 then AND it with 0x1. This load might be costl=
y.
> >>>
> >>> c0014048 <assert_pte_locked>:
> >>> c0014048:=C2=A0=C2=A0=C2=A0 2c 03 00 00=C2=A0=C2=A0=C2=A0=C2=A0 cmpwi=
=C2=A0=C2=A0 r3,0
> >>> c001404c:=C2=A0=C2=A0=C2=A0 7c 85 23 78=C2=A0=C2=A0=C2=A0=C2=A0 mr=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 r5,r4
> >>> c0014050:=C2=A0=C2=A0=C2=A0 41 82 00 10=C2=A0=C2=A0=C2=A0=C2=A0 beq=
=C2=A0=C2=A0=C2=A0=C2=A0 c0014060 <assert_pte_locked+0x18>
> >>> c0014054:=C2=A0=C2=A0=C2=A0 81 23 02 10=C2=A0=C2=A0=C2=A0=C2=A0 lwz=
=C2=A0=C2=A0=C2=A0=C2=A0 r9,528(r3)
> >>> c0014058:=C2=A0=C2=A0=C2=A0 71 29 00 01=C2=A0=C2=A0=C2=A0=C2=A0 andi.=
=C2=A0=C2=A0 r9,r9,1
> >>> c001405c:=C2=A0=C2=A0=C2=A0 4c 82 00 20=C2=A0=C2=A0=C2=A0=C2=A0 bnelr=
   =20
> >> Is that a real problem, though? =20
> > The cost of the read is likely to matter most if the branch gets mispre=
dicted.
> > I'd also guess the mm isn't usually NULL - so that branch needs to stat=
ically
> > predicted correctly as well.
> > I'd also not assume that the mm is in the cache (unless the surrounding=
 code
> > has already accessed it), the L1 data caches are small. =20
>=20
> You're right, I didn't think about this the right way round - in general
> it may not be easy to predict that mm points to init_mm, and an
> arbitrary user mm isn't guaranteed to be cached. Repeated calls to
> mm_is_kernel(mm) in the same function shouldn't cost much though.

Depends.
If it is real function call the code will be in the I-cache and is likely
to get predicted correctly by the third call.
OTOH if inlined you've all the I-cache loads and that static branch
prediction might get them all wrong.

Oh, and saving the result in a local might cause a register spill.

	David

>=20
> Would some (micro)benchmark be particularly relevant to measure the
> overhead, if any?
>=20
> - Kevin



Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CA9C5B572
	for <linux-um@archiver.kernel.org>; Tue, 11 Aug 2026 13:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HfUDfNxB65XZqovwWVBLkrKpJgUq3OtZ1XoJNMhjK1c=; b=kdhN3D4lY6Q7WD67rWNizSgEZO
	qRQO/5hbMv0VX1SsZt61vnUgNIS9NUGsRhx4cKr9InATW2+hNF5txWIMxESGD89WG6ESCqFxlfSbz
	1SDvFKtoJiz9L2yNzmwJrRoj1NYmm4L6jj/T0uFAlfQR4e1jtJqGX1+HL4AZvC0EO82ybK3HbHm51
	m9zyG4PpnZ3JT49TDboFk4DG0yTkNy2E+1vnfcw58l01WQgNYgECZCF0kbE1SsrhoPR5sDuKxn6aq
	UPUxT0CAmI5KXqhpdsJLTVNw/nomX7slRq4WcoJI9HXCmWHlsp0szF8WOTpawEh24uy5TEqLsTjfO
	uVhOQYyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtmTk-0000000E6Gz-45oF;
	Tue, 11 Aug 2026 13:25:17 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtmTg-0000000E6FP-0tiG
	for linux-um@lists.infradead.org;
	Tue, 11 Aug 2026 13:25:14 +0000
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4957eefd361so23702895e9.1
        for <linux-um@lists.infradead.org>; Tue, 11 Aug 2026 06:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786454710; x=1787059510; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HfUDfNxB65XZqovwWVBLkrKpJgUq3OtZ1XoJNMhjK1c=;
        b=oJJAnnmLZMQ507yOE0ImuVqszgF5WTxQe15p4aEYI53j7POiFtXRXbvpcHGJBst1fU
         LXWMX6rL0DoMlKmCMrLVdfMdNbWtiEWFvgrLnh9BGplZPS8bjSAcqwtSe3KPqC5mVryk
         Nf/kXgIsbTiNngXUdQ9ZdaCULW85mkGnl/01gK9F+QjErruqv5YhSoN2ISwH/P289Rms
         Bv4cbww+PYleALRQhGPtviYefZXo53w6zLdIRnFakxNf7F/F2gPYCN12LS1jwX6X6vXw
         C/uioKtdl9xHHq5jTQ55PsgpISs+ayFiZUtyQmOYFSBFug9ZV8By6ovX0Aj/hcQ7LYnD
         +wVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786454710; x=1787059510;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HfUDfNxB65XZqovwWVBLkrKpJgUq3OtZ1XoJNMhjK1c=;
        b=J2lLycTNBaxeLGiapA22MRRex7mbNq/Dd3gbuIN+L3LaMJPWxXW0w1vzcdqZjOv7Mb
         PBywOswCpT1bzasndfjlsWAElQbIg5DEBGkNiw8M7O/gPlVI/DkYHfhj5ckTkKSQ46PJ
         aYJ/hpZN+5yFB/NDAp8KeLSpsvBmhiNBTLUtVio6gz6q1xJCWYKmphrHldDRLWoT4c7v
         ZbSET5v8s68IWZRINCq10SehMw7Ok6ZLAzjJ5QyPmwJ5x1mebixjCe09CL2R0sG78O0x
         QRTs9K20Aat+zXuXsgPiK3wPEVK7WnMPUXVeWWZMfNZ3Kbn9a45aVRa5FRp9P1wdIEfe
         OEuA==
X-Forwarded-Encrypted: i=1; AHgh+RqavEmUnV0Ps7whqzxj3phDbMysxzRILApS0BHTzSq6ulNtJ47C72fiooYbMCZPwLYhE45UMmBusg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzaGW3O9HpnjFTdZzY5xkNfZT8KSEggRZzjgNX0lSO+lugcLAKN
	avjIdIEAOnEq0D0PopW+ZEIbCtNP6CmOtZfSXFlhmgq/3rqn9grYxep5
X-Gm-Gg: AR+sD13Xm3eA895wVSUtSu+lQBMEwhCUo+gA91YYIVg7x80TbZXZibgPcwMAPXMn67p
	J+4nl1Asj0QXLO9FXnj1EVBY936M8sIOfJRaGZPWBzi8M5c91W5GT9H3CqMtHUAhyNjvmcvnR6b
	YlbyAUZqPcKFpMl7SRBbGQ2A2wqnPP7kInpkYt+6IMMRAVZCdFThoadK4LbYr6chO3/RSFKdZ9Q
	uW6Ry6LIhBMPTtkBcLu2z4LlDyrxA1mVpiyo8JBl+1SafhKwGmv8d3vl4D7UEHDsqt8nt9DT1cH
	ADlg45r9xT4tvBnEmDHi2AeOWF5tlPVC0ujDHB8SiQYLiAPtCsrMxdEgAuMEbMow7wSdz4D7vik
	AMNll6k4QhfgCOrhbv1QIOwDZCw8pt3MEoSbE+yuuhA6u93cqOSBX68gz87ALdZ7zQ/Vxu1ziyq
	QQmVdEEtSEJ809J3jcDK5qQTka7Lik/+DtsG1YdvDiD5R2TxbiBlcGYFeeOhYm3dw7rosMn2d+d
	AAOty5VIl2notZUkB3iliors42SKJoj0Yvj
X-Received: by 2002:a05:600c:4513:b0:495:3e08:ad19 with SMTP id 5b1f17b1804b1-49978468c2bmr48261215e9.9.1786454709883;
        Tue, 11 Aug 2026 06:25:09 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49977df9489sm83541285e9.1.2026.08.11.06.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 06:25:09 -0700 (PDT)
Date: Tue, 11 Aug 2026 14:25:07 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org, Andrew Morton
 <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, Lorenzo
 Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil
 Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Pasha
 Tatashin <pasha.tatashin@soleen.com>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>, linux-arm-kernel@lists.infradead.org,
 Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, "James E.J.
 Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller
 <deller@gmx.de>, linux-parisc@vger.kernel.org, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
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
Message-ID: <20260811142507.4c6c760f@pumpkin>
In-Reply-To: <01f07ea2-8bdd-4450-8a49-548f8b646cfd@kernel.org>
References: <20260714-remove_pgtable_cdtor-v1-0-44be8a7685d7@arm.com>
	<20260714-remove_pgtable_cdtor-v1-3-44be8a7685d7@arm.com>
	<01f07ea2-8bdd-4450-8a49-548f8b646cfd@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260811_062512_283326_AC9BCC97 
X-CRM114-Status: GOOD (  20.31  )
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

On Mon, 3 Aug 2026 15:59:35 +0200
"Christophe Leroy (CS GROUP)" <chleroy@kernel.org> wrote:

> Le 14/07/2026 =C3=A0 16:03, Kevin Brodsky a =C3=A9crit=C2=A0:
> > mm code often needs to know whether some mm represents a kernel or
> > user address space. This is currently done by comparing the mm
> > pointer with &init_mm; besides not being particularly elegant, this
> > ignores the fact that other mm's (e.g. efi_mm) may also represent
> > parts of the kernel address space.
> >=20
> > Introduce a new mm flag MMF_KERNEL and set it for init_mm.
> > Subsequent patches will use this flag to replace comparisons with
> > &init_mm. No functional change is introduced for now. =20
>=20
> Did you consider performance impact ? This test is usually done in quite=
=20
> critical memory handling functions.
>=20
> init_mm is known at link time. Before your patch 08/22 there is just a=20
> comparison of mm (r3) with a constant (loaded in r10):
>=20
> c0014048 <assert_pte_locked>:
> c0014048:	3d 40 c1 09 	lis     r10,-16119
> c001404c:	39 4a 03 98 	addi    r10,r10,920
> c0014050:	7c 03 50 00 	cmpw    r3,r10
> c0014054:	4d 82 00 20 	beqlr
> ...
>=20
> After patch 08/22 we have, it first checks that mm is not 0, then it=20
> loads the word located at mm+528 then AND it with 0x1. This load might=20
> be costly.
>=20
> c0014048 <assert_pte_locked>:
> c0014048:	2c 03 00 00 	cmpwi   r3,0
> c001404c:	7c 85 23 78 	mr      r5,r4
> c0014050:	41 82 00 10 	beq     c0014060 <assert_pte_locked+0x18>
> c0014054:	81 23 02 10 	lwz     r9,528(r3)
> c0014058:	71 29 00 01 	andi.   r9,r9,1
> c001405c:	4c 82 00 20 	bnelr
> ...

Thought...
Could the check be replaced by one that checks for kernel static data?
That would require that other mm that represent part of the kernel
address space be static (and probably not in modules).
ISTR there is an address range check that can be used - and might be
cheaper than the explicit test for init_mm on many 64bit archs.

	David




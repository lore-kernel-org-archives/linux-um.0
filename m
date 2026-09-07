Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7A6C79F99
	for <linux-um@archiver.kernel.org>; Mon,  7 Sep 2026 16:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WOgo3zFXzbtiQDjz57z5HXaLiQwAncd9HG4Gw1Bp/lg=; b=os6IArAvXFKs60pmYH+Ww+46BR
	7Lt8IXBFuk8aj7Eh1nsEb33RvZRPHF9L/SGdO4VvSPTHsauwrlIs5AKQTxKLQRq9SWmO7b7LpO2RQ
	FEEt9KiU4cCjBtCC2OqYZ2Z3Wgj6rdMHy/pZeTl+HcuCVBtUs+cPj1ItLSg6yY1cL1qDoSHYadqMB
	PwRuUnXThrP9pKP0x7gKyLSrokGe4QKKMJrvJtXsf16qyYMKKM5fToPfPzFx9a3k6vE97A7bhzYkM
	ZCZbrdvXmzesjjHQcbyLLuCQG9OkT/PFr3dVf3DhdRBs6RodKxIMM0pABaiCZ9XuNSJmA/baWcTt6
	md7aSCEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3cbd-00000007Pgj-436O;
	Mon, 07 Sep 2026 16:54:05 +0000
Received: from mail-qk2-x10.google.com ([2607:f8b0:4864:34::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3cbZ-00000007Pei-0aqJ
	for linux-um@lists.infradead.org;
	Mon, 07 Sep 2026 16:54:03 +0000
Received: by mail-qk2-x10.google.com with SMTP id d75a77b69052e-530411c7ee1so368501cf.0
        for <linux-um@lists.infradead.org>; Mon, 07 Sep 2026 09:53:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788800036; cv=none;
        d=google.com; s=arc-20260327;
        b=qw3GfneuIOfh2ogVGIF5Xcmn3Dfc3uNUTKnv6FKzunWt8+xKnl2NEww6zhhfH14Avo
         lO6u5H399cZAfZUyJjKYh7rgBptesRj6iBTcW4sJ+fJ3+/JfLfOl8B5XdHnla4X4nURe
         PQXYLrStUUO3MwUChJkEJMlr17DWnaJXAOtl5yu3NoeJEgSA3wbidvPJ4XSXH5SbUGG4
         WvZva2CVkfk3VBp8ZIV7urgkuVNJjvGtbdWI6+5oTZzRgRfaxYQ1oeXpSfaOGtJZqUbY
         DZgq/JDlwlFgtBVFU5+J6zZVo9Yt4uXtn20L1lcrYs/pWXTSyqGPCy53jJLOfGF9D06Y
         CV+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WOgo3zFXzbtiQDjz57z5HXaLiQwAncd9HG4Gw1Bp/lg=;
        fh=w/HEhUfdN4MufTLCmQZFD6HgZh5GFhLbezN3mDhEkMQ=;
        b=LOO8jdygsgxEUOWnV8HXrQBo4AO8uWDB9VZ8EkP5FC9xMh2RxDue050h2gkfHYAprk
         Ts5tzpvNTc+uz5R0WQBsxEsvp0cxfuwY97qzz0DqFBj/HXBeUFNYt7Uu52coZRIcYaz4
         DnWb3ahf2NsPrluBukjRP3+edTe9b9lz7g0wuVHRz130JL0I5xJQzw+pYGIXCSkjApSU
         QN3rbyG3D+uWCg3RPiumneKD8J8t3+Cg/4+JcnSPp7S80L7alpUQFb63M8w1A9XPoUuV
         lfQJrqwrwuOuM3zvcCVR2L0n+PzN/JvnJFVglN71Tmlo47XKwvVzYlqEAsH0LSHG2lkd
         Zk5g==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788800036; x=1789404836; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WOgo3zFXzbtiQDjz57z5HXaLiQwAncd9HG4Gw1Bp/lg=;
        b=LYymi73UhgbSYoM2au7j/fs0QQeZcu6SP4+iqdilIM/lu6uzLsBiwJurS8jbeW5zPO
         d+egXZ/2SBKJvvzT8ruU9VPIXzxPzwjDKLz7dPz1QNyPyvmyyc/AcwoHnyjZ8XrOsLAP
         m+XOgER7q7kH2Fps0jjiN36yEghXbvxdWlvphEmhvPbSJVh95BvTzJcjB3KtJVxrX+WE
         Ua9pf3em89Tzk8cxbpgRhxTNih3CP3QLyERwDb9weCt0LhQorIseDYaFoSOmZJHHZURV
         GbRQikDx8r8s3zPyzw3PELt4gPS7ArlYNygt5lXCVqcf1TokJHF034a9nR71oKDX+U2B
         jqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788800036; x=1789404836;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WOgo3zFXzbtiQDjz57z5HXaLiQwAncd9HG4Gw1Bp/lg=;
        b=bbwODEHbSLCo07cMQf6Bfwkb02CHGhmkmWZBEJ0ga4Zp3wEKinVMcjbLn4yTggzrhX
         1yTqY8P7TXV2ozReLhkgVGAtc01ZcVeV2i8WbfIwniu7U61t6+5LDi8hOP+0xisoc8GI
         RZyphijyIEsaNz90D9pdoIh3Uf9wHYBYmIw5NyinJd/9OBuQlCszL4XnAguWGyvf26wm
         lrQ73T0lgRfwS9zDWXYVKPbB7SjEVf3WfB44B2bfMK3g+609rgxGrF4hsfZSnLCm7NmX
         ExfNEwaP8TrobtH/9ZlYjBvh9BPYoHWaaHx6IgiHTwfDEn1jXog5m+tmKGaOF67cV0IU
         DVJg==
X-Forwarded-Encrypted: i=1; AKwUvByEmSHz1NCe3mU1vrW2BHv0WU9Gv6dGOqqT2t0F1tqu0HCec7De/+BsRe/rfdZx+m5O2qXMAt9skg==@lists.infradead.org
X-Gm-Message-State: AFuF++k18hhLguKFy8Jvrh1isvama1/cv65gty1wWTHtetcBaGNrxKV6
	2gLDJT97f7bUcABYiJ53xJ4xYlyXnkVKgJTBSNcOpUpyjCqqll+R2GYd08zd64USxoGPq3fufEz
	ioV4kB0CbZTioY2oopB460kJg8durSVSwnNxHR1RB
X-Gm-Gg: AYBFou05cf+zhEl2cmHetG51xadvldS7rc8zQymZYdmyKwEYP2FnWoSDSGvL/JFLMBu
	5Ln8kA0/Y9uURvI8a/KZ3N3VPHD3nHHTn+NO6dqazp9e4jfZShyDb83OiBSqVMQ8/dupr9stuEK
	VkKqZMlfwngKCmAbRBKi8b3e3ItZwyE2+t26ptmQ6k5sL8OSSjo6pvjPMIZSdenCrexfwHhGXKz
	aqDo4IMBpRCC3jz8fAIjEB63gowfbKoW+VZVH1Xr5153UZ3sTXRSAy1n9ffSOvKQ7a6B79SM8Ic
	bd7YdQlPK9lb+XwmSZCIBsfJ+pKsKpoKBAJrMaE7O18=
X-Received: by 2002:a05:622a:28e:b0:52f:8389:29e0 with SMTP id
 d75a77b69052e-530920caba6mr3560401cf.0.1788800035234; Mon, 07 Sep 2026
 09:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org>
 <20260901-rcu-pagetable-freeing-v1-12-5456a81c8212@kernel.org>
 <apbUpMDJglS99_yK@thinkstation> <apbfzUwBQyxe3P9R@gremlin>
 <apcH74QsR5I-DIbL@thinkstation> <apcJhtvnd45EkjJI@gremlin>
In-Reply-To: <apcJhtvnd45EkjJI@gremlin>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 7 Sep 2026 09:53:43 -0700
X-Gm-Features: AcwNN1WRGdFWOzxEbOcmfkztqDuQQAGpor7Xm60pdWlD2DjKNo1Y7S4S7DNXdgs
Message-ID: <CAJuCfpH_v4YU+hsQDU_yQ4HZDf-2C6DuiJU5PGL+uVAsTwkZug@mail.gmail.com>
Subject: Re: [PATCH 12/12] mm: change the contract for free_pgtables(), update docs
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Kiryl Shutsemau <kas@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Dinh Nguyen <dinguyen@kernel.org>, 
	Simon Schuster <schuster.simon@siemens-energy.com>, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Russell King <linux@armlinux.org.uk>, Vineet Gupta <vgupta@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
	Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Magnus Lindholm <linmag7@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-alpha@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, 
	Hugh Dickins <hughd@google.com>, Qi Zheng <qi.zheng@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260907_095401_200507_7D0824F2 
X-CRM114-Status: GOOD (  31.83  )
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

On Tue, Sep 1, 2026 at 10:25=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> On Tue, Sep 01, 2026 at 06:15:17PM +0100, Kiryl Shutsemau wrote:
> > On Tue, Sep 01, 2026 at 03:31:26PM +0100, Lorenzo Stoakes (ARM) wrote:
> > > On Tue, Sep 01, 2026 at 02:57:13PM +0100, Kiryl Shutsemau wrote:
> > > > On Tue, Sep 01, 2026 at 12:01:32PM +0100, Lorenzo Stoakes (ARM) wro=
te:
> > > > > diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> > > > > index b91b1a98029c..ff8ff3706485 100644
> > > > > --- a/mm/pgtable-generic.c
> > > > > +++ b/mm/pgtable-generic.c
> > > > > @@ -386,9 +386,21 @@ pte_t *pte_offset_map_rw_nolock(struct mm_st=
ruct *mm, pmd_t *pmd,
> > > > >   * be read-only/read-write protected.
> > > > >   *
> > > > >   * Note that free_pgtables(), used after unmapping detached vmas=
, or when
> > > > > - * exiting the whole mm, does not take page table lock before fr=
eeing a page
> > > > > - * table, and may not use RCU at all: "outsiders" like khugepage=
d should avoid
> > > > > - * pte_offset_map() and co once the vma is detached from mm or m=
m_users is zero.
> > > > > + * exiting the whole mm, does not take the page table lock befor=
e freeing a
> > > > > + * table.
> > > > > + *
> > > > > + * However, the PMD entry is cleared first, and the table freed =
only after
> > > > > + * an RCU grace period, so a walker that mapped the table under
> > > > > + * rcu_read_lock() stays safe, and the pmd_same() recheck in
> > > > > + * pte_offset_map_lock() detects the teardown.
> > > > > + *
> > > > > + * Therefore it is safe for "outsiders" like khugepaged to use
> > > > > + * pte_offset_map() and co. for VMAs that might be undergoing pa=
ge table
> > > > > + * teardown.
> > > >
> > > > Is it strictly true?
> > > >
> > > > free_pte_range() clears the pmd without taking the PTL, so the
> > > > pmd_same() recheck in pte_offset_map_lock() can pass and the pmd ge=
ts
> > > > cleared right after.
> > > >
> > > > Readers are fine -- __pte_offset_map() holds rcu_read_lock() until
> > > > pte_unmap(), so the table cannot go away.
> > > >
> > > > khugepaged is an odd example here. collapse_pte_mapped_thp() and
> > > > retract_page_tables() don't rely on this recheck -- they take pmd_l=
ock()
> > > > plus the ptl and do their own pmd_same() under both.
> > > >
> > > > Can we say walks are safe and leave the write rule where it is?
> > >
> > > Hmm yeah, ah page tables, what a rabbit hole of horror :)
> > >
> > > I guess this is effectively a reflection of the 'write lock on write,=
 RCU load
> > > on read' pattern in RCU itself generally.
> > >
> > > So, maybe something like:
> > >
> > >  * Note that free_pgtables(), used after unampping detached vmas, or =
when
> > >  * exiting the whoel mm, does not take a page table lock before freei=
ng a page
> > >  * table.
> > >  *
> > >  * As page table freeing itself is RCU-safe, page table readers can s=
afely run
> > >  * concurrently with page table teardown. However, writers cannot, as=
 without
> > >  * a lock nothing prevents concurrent teardown.
> > >  */
> > >
> > > Instead? What do you think?
> >
> > s/whoel/whole/
>
> Haha yup the inevitable typo...

Also s/unampping/unmapping please.
>
> >
> > Otherwise, LGTM.
>
> Thanks! :)
>
> >
> > --
> >   Kiryl Shutsemau / Kirill A. Shutemov
>
> --
> Cheers, Lorenzo


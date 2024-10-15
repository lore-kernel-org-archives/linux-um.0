Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 224B7D18140
	for <linux-um@archiver.kernel.org>; Tue, 15 Oct 2024 03:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2LILJl12FRTprkZPDsnRty3i0K05AFLZzsWu9wwpXxI=; b=DXTH69sy2xwRfev5GyAae4FytD
	PNIPOjCLFsKM8O6rj+kOcIyv2VV3iQ4RZMrjVz2kCK944zIIRHGSzJxwGCZnzNW7ffYaTyCC5g/OG
	0VSSjyk1fdu++mV5CUltvdq115lN+3s4Lpu4VAkTSIQMH9y4HqmE0zazEE+CgX7p9x5NSdwgHYFei
	7LnOYedcS+NUGPDWyJdDYRFLsk8OpxLk7li1dGyd56G2/Vauvpu4y+ulwBE3caAUA0YeLY6H4YjE3
	UCacdDKw1fEygoWFfjTT85LI8BHJOrxCSFxqForg7xWiRtxbw2xNyTAZ8t/0l8Q+rgmrP1E3LxnZz
	PIApqShg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0XrW-00000006wsx-41FC;
	Tue, 15 Oct 2024 03:04:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0XrS-00000006wqe-2D9e
	for linux-um@lists.infradead.org;
	Tue, 15 Oct 2024 03:04:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728961474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2LILJl12FRTprkZPDsnRty3i0K05AFLZzsWu9wwpXxI=;
	b=Him/c0jsL8CUmV1MJxP6pba9WywmnC17cRbgZob/DKRUjJLioRs1rzGByjes37SgyCEBo4
	yHLjTcTjjVq0SoPOEdlK+EpG+DPEt5Za1V3BgUvO6szv3I6TmA1BUyqukJROjRlUrqgH3C
	X+NCdBRjxhPecXkXpzf5y3T3Keq8LAY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-xLEBz1FHPI2CYxPMD9_Yzw-1; Mon, 14 Oct 2024 23:04:32 -0400
X-MC-Unique: xLEBz1FHPI2CYxPMD9_Yzw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b111381632so940881585a.3
        for <linux-um@lists.infradead.org>; Mon, 14 Oct 2024 20:04:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728961472; x=1729566272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2LILJl12FRTprkZPDsnRty3i0K05AFLZzsWu9wwpXxI=;
        b=fQLsawKPhZGsu+wZKmDpzANpSXXcBfRSxoFmhPOscfl3+nYTMUxkvbudBVObO+jEJz
         ItcC3xQ4mi2FK3+FMlfKytIMHfAAyG8AhlbDX74EQNOQO72l2C1WVHaXqYKRVb+F9tA/
         doU1qY5W2yF/jI6CmpKOHvPazXLBb7b+7eNe4FDX/DadNtmsNt4TWF24JoGrm+npssmx
         9fAYxgh57RUxVJAOVotMJQvwdWade0F4KhYLbGPXwhpOXhTZ/rxSq1LNhIi/cWzX/TlU
         CxW+WIB8/aiSzPAxh9tdsQsENY/3uIsGE2FWGHnXdR/2EK0mkmGG49HPhnxKajDnGGXI
         ZFOg==
X-Forwarded-Encrypted: i=1; AJvYcCV31uqGbTV+qRSxDm4pzECi8kWQNOybm8SMBRaF4H7ihmx8WSaYCBGuniN3puI0ekPAez9P4n3ARg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw0z2kq5IM0SuIN2sXB3I48Zz4oKm3rWC8UC+8CkT0NdIMeoVZm
	F3C23lw4OqdwulIsOyMGaMMsrr/X6MsZ8GYjtMo1X54Za4GABAT4QxBHnpHwWjSfP6k1+MXcUI3
	j82b4wnmGLqqNtMVOzrO+g73yBNSFDCVneOpqya/cn7ID4jERsICjdenCuEYFphutKWTpLO0ZjS
	w6BKF8BL4doAX3X0TWvdxAm9MsrS1axwdSisd6
X-Received: by 2002:a05:6214:5347:b0:6cb:e9eb:1b24 with SMTP id 6a1803df08f44-6cbeff63948mr208010366d6.24.1728961472398;
        Mon, 14 Oct 2024 20:04:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGp3T4Yepy5h5DQueUeaIl2hWfHF7EpApBAxl9jBnWIq5Z+upYe1XYSqd8+UMzLGOwXgyDg2kobb+ggSdFvo7w=
X-Received: by 2002:a05:6214:5347:b0:6cb:e9eb:1b24 with SMTP id
 6a1803df08f44-6cbeff63948mr208010076d6.24.1728961472016; Mon, 14 Oct 2024
 20:04:32 -0700 (PDT)
MIME-Version: 1.0
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com> <Zw0iegwMp5ZVGypy@fedora> <9b7e4f65-a171-4574-bd53-580e79527fbc@arm.com>
In-Reply-To: <9b7e4f65-a171-4574-bd53-580e79527fbc@arm.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Tue, 15 Oct 2024 11:04:21 +0800
Message-ID: <CAF+s44QbdPBN-8EcPiWiZgYgZY4v8RK-wA0VEaVXbfnc9_HQ9Q@mail.gmail.com>
Subject: Re: [RFC PATCH v1 01/57] mm: Add macros ahead of supporting boot-time
 page size selection
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Andreas Larsson <andreas@gaisler.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Chris Zankel <chris@zankel.net>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, 
	Dinh Nguyen <dinguyen@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Greg Marsden <greg.marsden@oracle.com>, Helge Deller <deller@gmx.de>, 
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Ivan Ivanov <ivan.ivanov@suse.com>, Johannes Berg <johannes@sipsolutions.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Jonas Bonn <jonas@southpole.se>, 
	Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>, 
	Max Filippov <jcmvbkbc@gmail.com>, Miroslav Benes <mbenes@suse.cz>, Rich Felker <dalias@libc.org>, 
	Richard Weinberger <richard@nod.at>, Stafford Horne <shorne@gmail.com>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Will Deacon <will@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, x86@kernel.org, 
	linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-mm@kvack.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
	sparclinux@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_200438_657934_7A24C94A 
X-CRM114-Status: GOOD (  46.83  )
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

On Mon, Oct 14, 2024 at 10:07=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> On 14/10/2024 14:54, Pingfan Liu wrote:
> > Hello Ryan,
> >
> > On Mon, Oct 14, 2024 at 11:58:08AM +0100, Ryan Roberts wrote:
> >> arm64 can support multiple base page sizes. Instead of selecting a pag=
e
> >> size at compile time, as is done today, we will make it possible to
> >> select the desired page size on the command line.
> >>
> >> In this case PAGE_SHIFT and it's derivatives, PAGE_SIZE and PAGE_MASK
> >> (as well as a number of other macros related to or derived from
> >> PAGE_SHIFT, but I'm not worrying about those yet), are no longer
> >> compile-time constants. So the code base needs to cope with that.
> >>
> >> As a first step, introduce MIN and MAX variants of these macros, which
> >> express the range of possible page sizes. These are always compile-tim=
e
> >> constants and can be used in many places where PAGE_[SHIFT|SIZE|MASK]
> >> were previously used where a compile-time constant is required.
> >> (Subsequent patches will do that conversion work). When the arch/build
> >> doesn't support boot-time page size selection, the MIN and MAX variant=
s
> >> are equal and everything resolves as it did previously.
> >>
> >
> > MIN and MAX appear to construct a boundary, but it may be not enough.
> > Please see the following comment inline.
> >
> >> Additionally, introduce DEFINE_GLOBAL_PAGE_SIZE_VAR[_CONST]() which wr=
ap
> >> global variable defintions so that for boot-time page size selection
> >> builds, the variable being wrapped is initialized at boot-time, instea=
d
> >> of compile-time. This is done by defining a function to do the
> >> assignment, which has the "constructor" attribute. Constructor is
> >> preferred over initcall, because when compiling a module, the module i=
s
> >> limited to a single initcall but constructors are unlimited. For
> >> built-in code, constructors are now called earlier to guarrantee that
> >> the variables are initialized by the time they are used. Any arch that
> >> wants to enable boot-time page size selection will need to select
> >> CONFIG_CONSTRUCTORS.
> >>
> >> These new macros need to be available anywhere PAGE_SHIFT and friends
> >> are available. Those are defined via asm/page.h (although some arches
> >> have a sub-include that defines them). Unfortunately there is no
> >> reliable asm-generic header we can easily piggy-back on, so let's defi=
ne
> >> a new one, pgtable-geometry.h, which we include near where each arch
> >> defines PAGE_SHIFT. Ugh.
> >>
> >> -------
> >>
> >> Most of the problems that need to be solved over the next few patches
> >> fall into these broad categories, which are all solved with the help o=
f
> >> these new macros:
> >>
> >> 1. Assignment of values derived from PAGE_SIZE in global variables
> >>
> >>   For boot-time page size builds, we must defer the initialization of
> >>   these variables until boot-time, when the page size is known. See
> >>   DEFINE_GLOBAL_PAGE_SIZE_VAR[_CONST]() as described above.
> >>
> >> 2. Define static storage in units related to PAGE_SIZE
> >>
> >>   This static storage will be defined according to PAGE_SIZE_MAX.
> >>
> >> 3. Define size of struct so that it is related to PAGE_SIZE
> >>
> >>   The struct often contains an array that is sized to fill the page. I=
n
> >>   this case, use a flexible array with dynamic allocation. In other
> >>   cases, the struct fits exactly over a page, which is a header (e.g.
> >>   swap file header). In this case, remove the padding, and manually
> >>   determine the struct pointer within the page.
> >>
> >
> > About two years ago, I tried to do similar thing in your series, but ra=
n
> > into problem at this point, or maybe not exactly as the point you list
> > here. I consider this as the most challenged part.
> >
> > The scenario is
> > struct X {
> >       a[size_a];
> >       b[size_b];
> >       c;
> > };
> >
> > Where size_a =3D f(PAGE_SHIFT), size_b=3Dg(PAGE_SHIFT). One of f() and =
g()
> > is proportional to PAGE_SHIFT, the other is inversely proportional.
> >
> > How can you fix the reference of X.a and X.b?
>
> If you need to allocate static memory, then in this scenario, assuming f(=
) is
> proportional and g() is inversely-proportional, then I guess you need
> size_a=3Df(PAGE_SIZE_MAX) and size_b=3Dg(PAGE_SIZE_MIN). Or if you can al=
locate the

My point is that such stuff can not be handled by scripts
automatically and needs manual intervention.

> memory dynamically, then make a and b pointers to dynamically allocated b=
uffers.
>

This seems a better way out.

> Is there a specific place in the source where this pattern is used today?=
 It
> might be easier to discuss in the context of the code if so.
>

No such code at hand. Just throw out the potential issue and be
curious about it which frustrates me.
I hope people can reach an agreement on it and turn this useful series
into reality.

Thanks,

Pingfan



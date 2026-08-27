Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2790BC61DC2
	for <linux-um@archiver.kernel.org>; Thu, 27 Aug 2026 08:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9MKQBXQ2qiIPcch87en2gxSQXnqBJNIJwYDdb9qgoaA=; b=cfw2tOB18hiX/aKNHKdibXK377
	jaelk+7tguO0NLS9FEe/ryV0YIrbq37HJQVQiND1Ccn5jGGUhy0QW4CW7MG7bq1lv7tEaF0EMSM5G
	B5KqhugA+/KRXWMVkY0oZKClvBNEAzDDBmlnKsh+gaRrPu8oO8Ic/bxweUowDm5MY2//Ebp/fEViI
	WOd6M/8J+yziTq5m7y0QFLKcJ40XUHWv6dLm/S2BUiceW4R5Gby0OEljs8TjvPUB6v0Vb6y/3wX66
	DQMb4wN3WGzJ+/wHV1LCQOezIKFBJ6xCLViZsX353DpHS6+ZEoNMM2E9XKgrtd3zphNWM6Xxq3nN+
	QPkoZwcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzVkl-00000003g0a-1hGD;
	Thu, 27 Aug 2026 08:46:31 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzVki-00000003g06-1gFZ
	for linux-um@lists.infradead.org;
	Thu, 27 Aug 2026 08:46:30 +0000
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-3965d3d9ab8so1927445a91.3
        for <linux-um@lists.infradead.org>; Thu, 27 Aug 2026 01:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787820387; x=1788425187; darn=lists.infradead.org;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9MKQBXQ2qiIPcch87en2gxSQXnqBJNIJwYDdb9qgoaA=;
        b=c+DbNdWJcGj5jT4pmI6DFRk0ZVPAfgcp4mDonQRDRY/XfCKSe5JpX2QXgt+ScCehii
         ObfhZtPbCr6XSlr3etuH2ANHVcHsSyxe2u7vv3KCe+dk35jR2WyWC80kYoe8zxtIuk72
         FqY1S5TCZKpCzT5oRFLKH+/XccVnxU5fZ5IfuTyIEeZPOCGRXDYKFvbAhgJTfOZPgAJS
         2FTAPz1Alu7ZZyXs6TykC94tuensndKHLbI5Ab9AXetEfPoWKB3fX/FBXZUTTmFqxWsy
         kaJqJ7QCXT34iV+g592ddak6oBYB3zikvxOFVjMVM0qWUBoEDfuylRL4tOPWd8SRNqPB
         C8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787820387; x=1788425187;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9MKQBXQ2qiIPcch87en2gxSQXnqBJNIJwYDdb9qgoaA=;
        b=d5kvj3JkEVtGOywYWwOjvjG2xnW835Pd2o35opYuD9JOx0Ia79vO9+JbUsLJybTR7g
         H27Mmxg1DubUtRSsCLnU7PDDXKO5MMaW2fdKigGliFm6HAxa7H1rLIpPKn2qttiTAb9+
         u6T2gZKkQkZ4YJb1Km2EMc4s2aGoPDp7yy/DDn1tBl3FxyHojaGmP5HuVJcyJTdsydf5
         edQ0Vut3S/UbJCuN/F27ZRbh+rU/fBc+pxKuI6JVHlYZ8TR161RjD7Ur9oUprMzmOAyO
         uQ4V5NhLt4AezSVvuLu/ceWrGrNWhv/46dOmo/sNG9m26KGRh9MvWbl8hMYSHO7tPlIN
         y2Hw==
X-Forwarded-Encrypted: i=1; AHgh+Rpu5J20+4ggfbAKZ1HU4q6E2rDK9B8c4px4rfySIU5uR1OkdlI6dQMU7vPYcjtMuxGkQDbsiL2urA==@lists.infradead.org
X-Gm-Message-State: AFuF++nsKSXafRVIrr8S9nO8y3vd8HlA769LiFSwdc+m44ilLneMojWZ
	JfKblZzERliUfOmYK5cmjBxDgxImGEs45S9WVffrGci7MHV9pSEzNcDG
X-Gm-Gg: AR+sD12hNSkpDi02QE9xc2kTEwEp4MVxYcXV8RfsVRBPDd/3vTOvj08Nr5RTrIRlR5O
	ZZFl+THl1lU9UWfgzFRcuLn1jU5r9x2S9s2RmmL3Y5X0Azk6zTXL0z3urFledJ4cjcfNyj+Z6DV
	caEfbN5VKIXtGIX8GCwdbWcn3xzEBIe2YBN9RI7rWDWB2OrkrnVVemSn3J+etLBXcLvTuitD6uR
	VoI9C/1HiMX1bYgo5cakqRRj5954DrmtNMOKYTeOwj+BYrvf6XWKIR0vpZOUAKo/6+pxEDreWHk
	cDAJW5MVM+kAvP/AhFxlNVz5IRIF0Hdef/fdTdeOVX8X0snH8YG0QORReMwz7aoqzhAZX6y2int
	AIOH40zy8Qw2wNRw/V3GOoZI1Qm8Fo2IEhcgUwsTRBGvxf4QkKIGMmIHAbnUDVxnEi3hnpOlb/L
	yM6xhDYrcootfvFiq7/CMC6EBztQiVC4niyGzzZpLmARPAIAGMPm1ZbpPwlrZ4s1D9/9quebGiA
	XLTQP3FEteT0K3NydtJHZ7qIGV/kqGohDsb4pcCiuCZ7dti5/6SoA2pixf2loMIF0MXiwYG95fU
	XVWKBw==
X-Received: by 2002:a17:90b:1809:b0:38f:7f60:ba35 with SMTP id 98e67ed59e1d1-3966d199247mr26527608a91.5.1787820387338;
        Thu, 27 Aug 2026 01:46:27 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39675922253sm2042307a91.4.2026.08.27.01.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 01:46:26 -0700 (PDT)
Date: Thu, 27 Aug 2026 17:46:22 +0900
Message-ID: <m2y0dsuf1d.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: ljs@kernel.org
Cc: david@kernel.org,
	linux-mm@kvack.org,
	liam@infradead.org,
	rbm@suse.com,
	akpm@linux-foundation.org,
	luto@amacapital.net,
	brendan.jackman@linux.dev,
	liuhangbin@gmail.com,
	corbet@lwn.net,
	kees@kernel.org,
	broonie@kernel.org,
	mhocko@suse.com,
	rppt@kernel.org,
	shuah@kernel.org,
	surenb@google.com,
	vbabka@kernel.org,
	wad@chromium.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-um@lists.infradead.org,
	geert@linux-m68k.org,
	daniel@thingy.jp
Subject: Re: [PATCH v2 0/2] support kselftest on nommu platform
In-Reply-To: <ao2l9Ao7BQI6uRKC@gremlin>
References: <20260825015945.141739-1-thehajime@gmail.com>
	<f2ac9432-4fea-4007-aab0-ad80597b284c@kernel.org>
	<ao2Tl9CLL7WjHYun@gremlin>
	<bb9a3add-4849-4928-8b6a-0afc0c73b112@kernel.org>
	<ao2l9Ao7BQI6uRKC@gremlin>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260827_014628_470454_9088890B 
X-CRM114-Status: GOOD (  45.62  )
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


Hello David, Lorenzo,

On Tue, 25 Aug 2026 23:28:24 +0900,
Lorenzo Stoakes (ARM) wrote:
> 
> On Tue, Aug 25, 2026 at 04:17:54PM +0200, David Hildenbrand (Arm) wrote:
> > On 8/25/26 15:12, Lorenzo Stoakes (ARM) wrote:
> > > On Tue, Aug 25, 2026 at 10:37:41AM +0200, David Hildenbrand (Arm) wrote:
> > >> On 8/25/26 03:59, Hajime Tazaki wrote:
> > >>> We add an ability to execute kselftest on nommu platforms.
> > >>>
> > >>> Currently there are several issues if we wish to run kselftests on nommu
> > >>> targets:
> > >>>
> > >>> - it cannot compile/build test binaries because the current files mainly
> > >>>   assume to build with glibc,
> > >>> - some of the tests are not able to run on nommu targets as there are no
> > >>>   fork(2) syscall.
> > >>>
> > >>> The first issue can be avoided if we can build static PIE binaries (if
> > >>> targets support it), but in our case (build on ubuntu/glibc and run on
> > >>> alpine/musl-libc), it fails to invoke due to lack of the GNU ifunc
> > >>> mechanism.  Thus, we need to cross-compile with musl toolchain, which
> > >>> needs to be solved the first issue.
> > >>>
> > >>> The second issue is the lack of fork(2) syscall on those platforms.
> > >>> Especially the test harness helper (kselftest_harness.h) uses the
> > >>> syscall, which cannot be simply with vfork(2).  `timeout` command used
> > >>> in `runner.sh` never works for nommu platform as it uses fork(2).
> > >>>
> > >>> nommu component in the mm subsystem has several known issues and having
> > >>> test cases should help this situation, thus this patchset is very first
> > >>> step toward enriching test environment which has not been well tested
> > >>> for a while.  The test cases is implemented based on the document
> > >>> (Documentation/admin-guide/mm/nommu-mmap.rst).
> > >>>
> > >>> So, for the first step, nommu targets only support low-level API of
> > >>> kselftests (kselftest.h), and implement tests in a new target,
> > >>> TARGETS=mm/nommu.  Other targets are currently not even able to build
> > >>> due to toolchain issues but will be addressed once the initial
> > >>> introduction which mainly focuses on nommu test will be settled.
> > >>>
> > >>> The patch was initially combined with other patches but is decoupled to
> > >>> only focus on test framework and testcases.
> > >>>
> > >>> - rfc:
> > >>> https://lore.kernel.org/linux-mm/20260813063401.1786548-1-thehajime@gmail.com/
> > >>>
> > >>> Hajime Tazaki (2):
> > >>>   selftests: run tests on nommu architecture
> > >>>   selftests/mm: add nommu mmap and mremap behavior tests
> > >>>
> > >>>  Documentation/dev-tools/kselftest.rst         |  14 +
> > >>>  tools/testing/selftests/Makefile              |   1 +
> > >>>  tools/testing/selftests/kselftest/runner.sh   |   9 +-
> > >>>  tools/testing/selftests/kselftest_harness.h   |   4 +
> > >>>  tools/testing/selftests/lib.mk                |   8 +
> > >>>  tools/testing/selftests/mm/nommu/Makefile     |   7 +
> > >>>  .../selftests/mm/nommu/nommu_mmap_test.c      | 265 +++++++++++++
> > >>>  .../selftests/mm/nommu/nommu_mremap_test.c    | 353 ++++++++++++++++++
> > >>
> > >> That's odd.
> > >>
> > >> 	tools/testing/selftests/mm
> > >>
> > >> itself should know which tests can be built and ran on nommu. nommu-only tests
> > >> can be placed in mm/nommu, but I would expect tools/testing/selftests/mm's
> > >> Makefile and run script to compile and run only selftests that are supported on
> > >> the given platform.
> > >
> > > I mean I think at this point with mm/nommu/nommu_xxx.c it'd make more sense to
> > > simply have selftests/nommu/ + update the mm makefile to not build stuff that's
> > > broken on nommu there.
> > >
> > > That way positively nommu-stuff is put in its own place and what's broken on mm
> > > specific to nommu can be fixed there.
> > >
> > > I'd rather isolate them clearly rather than having them live in a subdirectory
> > > of mm.
> >
> > My understanding is that some MM tests could be enabled/changed in the future
> > that support both MMU and NOMMU. Not sure how to best handle that.
> 
> Well by default won't everything run? And it becomes a list of what doesn't
> work with nommu?
> 
> I really don't want to see any maintainership burden or extra work added
> for nommu as it's afaic deprecated.
> 
> >
> > So wiring up mm/nommu as a separate thing did sound wrong to me. So it should
> > either be integrated or the tests in fact completely moved out of mm/
> 
> Not integrated, because then it starts adding work for people. I'd rather
> have separate nommu tests, any mm tests that aren't compatible with nommu
> can just be somehow excluded.
> 
> Having a 'don't run on nommu' or even just some means of setting which
> tests to skip (I think Mark Brown suggested as much in reply to an earlier
> version of the series) seems a good idea.
> 
> But yeah, tools/testing/selftests/nommu seems the best place for the
> nommu-specific stuff.
> 
> Can maybe do some ../mm/ horror show thing for reducing duplication as
> needed...

As David mentioned my goal is to run all selftests/mm tests on nommu,
but as I explained situation to Lorenzo, it currently doesn't any
tests of mm/ on nommu platform (plus cannot build).

so I'd like to start as minimum as possible for this patchset, thus
creating different TARGET at mm/nommu, which I thought it should no
harm to the parent directory.

But I can move from selftests/mm/nommu to selftests/nommu for now, and
will propose to move into mm/nommu once it will be more meaningful to
do so.

# btw, I started to looking at code toward virtual mmu; I cannot tell
  how it'll be tho now.

-- Hajime



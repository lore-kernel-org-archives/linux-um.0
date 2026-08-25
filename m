Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7498C61DBE
	for <linux-um@archiver.kernel.org>; Tue, 25 Aug 2026 13:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y1ooUZqu3n0X6AHMc52e/9cK3btR11yvm1f2GPiErVs=; b=Ge4iSJTV09pFjbT9FKXVaXcmBD
	NkQXDsjlxq93XYOzbIPNhacOlSfkPY/cyDydozs/+UmerwVFCVxwsfG2MpnubM19vhHSJB4TL52oy
	cARS3r7AZv92mcXbSvPXSxwiBJIn3/qn+xKvdga+GPYFbjf4p0p/YLqryfytVevBOWrbL3SK+axpg
	7VH6qWvxviQlogyvcG+X69M5LccXGaDPHN1ZOKjhgfNWjl2YwwLl9LvE97hK4W38/+YyRL/J6L+c4
	0LMsyR96/pion5yQOmTTYz5NOX5/h2Q1At77sMhxqlFmwgRVnoB5R9GCen5KJfl3ui1FK5BHwpkls
	al9Vjlyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyqxc-00000000pnf-29At;
	Tue, 25 Aug 2026 13:13:04 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyqxa-00000000pnQ-1ElS
	for linux-um@lists.infradead.org;
	Tue, 25 Aug 2026 13:13:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 36D0460A6C;
	Tue, 25 Aug 2026 13:13:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FF81F00A3A;
	Tue, 25 Aug 2026 13:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787663580;
	bh=y1ooUZqu3n0X6AHMc52e/9cK3btR11yvm1f2GPiErVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=di+7PMDPHKJfCpsQmjVBUEbvXlQaZKb3l1YLxpWKXFvWrDrILEJQmo2eEwwMqWiQ8
	 3VtqnaEz0JXZZncs8PraIMpk3NIunXnWyDCqt//xeQu4IopzhXaHUWU6Xoy3GWVI+7
	 s9HuO+Xht7BpCV8TZf5SuXjSRTmpfgUPkO0aW21lYqDwX3vWR92tkUT1ywm9s6MVBj
	 4r7stbb/zFTi59pT0dBR3+NTuMEQQsX0avCLwwHTxxxqneTZxvVqHZjg+iV38KlDXS
	 HaF+XUuViD3b9+EpFbB1weCL89MBtsC7Hr25gFh6A02REt3u/GO5SxShPGCtPdBaW5
	 WHKXpUuewxP+g==
Date: Tue, 25 Aug 2026 14:12:52 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Hajime Tazaki <thehajime@gmail.com>, linux-mm@kvack.org, 
	liam@infradead.org, rbm@suse.com, akpm@linux-foundation.org, luto@amacapital.net, 
	brendan.jackman@linux.dev, liuhangbin@gmail.com, corbet@lwn.net, kees@kernel.org, 
	broonie@kernel.org, mhocko@suse.com, rppt@kernel.org, shuah@kernel.org, 
	surenb@google.com, vbabka@kernel.org, wad@chromium.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-um@lists.infradead.org, geert@linux-m68k.org, 
	daniel@thingy.jp
Subject: Re: [PATCH v2 0/2] support kselftest on nommu platform
Message-ID: <ao2Tl9CLL7WjHYun@gremlin>
References: <20260825015945.141739-1-thehajime@gmail.com>
 <f2ac9432-4fea-4007-aab0-ad80597b284c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2ac9432-4fea-4007-aab0-ad80597b284c@kernel.org>
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

On Tue, Aug 25, 2026 at 10:37:41AM +0200, David Hildenbrand (Arm) wrote:
> On 8/25/26 03:59, Hajime Tazaki wrote:
> > We add an ability to execute kselftest on nommu platforms.
> >
> > Currently there are several issues if we wish to run kselftests on nommu
> > targets:
> >
> > - it cannot compile/build test binaries because the current files mainly
> >   assume to build with glibc,
> > - some of the tests are not able to run on nommu targets as there are no
> >   fork(2) syscall.
> >
> > The first issue can be avoided if we can build static PIE binaries (if
> > targets support it), but in our case (build on ubuntu/glibc and run on
> > alpine/musl-libc), it fails to invoke due to lack of the GNU ifunc
> > mechanism.  Thus, we need to cross-compile with musl toolchain, which
> > needs to be solved the first issue.
> >
> > The second issue is the lack of fork(2) syscall on those platforms.
> > Especially the test harness helper (kselftest_harness.h) uses the
> > syscall, which cannot be simply with vfork(2).  `timeout` command used
> > in `runner.sh` never works for nommu platform as it uses fork(2).
> >
> > nommu component in the mm subsystem has several known issues and having
> > test cases should help this situation, thus this patchset is very first
> > step toward enriching test environment which has not been well tested
> > for a while.  The test cases is implemented based on the document
> > (Documentation/admin-guide/mm/nommu-mmap.rst).
> >
> > So, for the first step, nommu targets only support low-level API of
> > kselftests (kselftest.h), and implement tests in a new target,
> > TARGETS=mm/nommu.  Other targets are currently not even able to build
> > due to toolchain issues but will be addressed once the initial
> > introduction which mainly focuses on nommu test will be settled.
> >
> > The patch was initially combined with other patches but is decoupled to
> > only focus on test framework and testcases.
> >
> > - rfc:
> > https://lore.kernel.org/linux-mm/20260813063401.1786548-1-thehajime@gmail.com/
> >
> > Hajime Tazaki (2):
> >   selftests: run tests on nommu architecture
> >   selftests/mm: add nommu mmap and mremap behavior tests
> >
> >  Documentation/dev-tools/kselftest.rst         |  14 +
> >  tools/testing/selftests/Makefile              |   1 +
> >  tools/testing/selftests/kselftest/runner.sh   |   9 +-
> >  tools/testing/selftests/kselftest_harness.h   |   4 +
> >  tools/testing/selftests/lib.mk                |   8 +
> >  tools/testing/selftests/mm/nommu/Makefile     |   7 +
> >  .../selftests/mm/nommu/nommu_mmap_test.c      | 265 +++++++++++++
> >  .../selftests/mm/nommu/nommu_mremap_test.c    | 353 ++++++++++++++++++
>
> That's odd.
>
> 	tools/testing/selftests/mm
>
> itself should know which tests can be built and ran on nommu. nommu-only tests
> can be placed in mm/nommu, but I would expect tools/testing/selftests/mm's
> Makefile and run script to compile and run only selftests that are supported on
> the given platform.

I mean I think at this point with mm/nommu/nommu_xxx.c it'd make more sense to
simply have selftests/nommu/ + update the mm makefile to not build stuff that's
broken on nommu there.

That way positively nommu-stuff is put in its own place and what's broken on mm
specific to nommu can be fixed there.

I'd rather isolate them clearly rather than having them live in a subdirectory
of mm.

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo


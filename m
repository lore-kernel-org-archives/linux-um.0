Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41566C02183
	for <linux-um@archiver.kernel.org>; Wed, 15 Jan 2025 09:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E6HX8Sk+Dge+/vzMt9rQGoTMCdVcd7eWjUMA8f+M2KY=; b=dc2/HRwfCvX2rMoQduzJ3Q+i7C
	rFJioiWnuqv/2nWYHxF/BBs4cn5KlUzvujlLJbG/B2Ji0O6xQnmD65mBgP5GLdjx6fi6DnqxupQHq
	CtL43rj4VnA4SNy9/xUU1VO0/hkiUSQ4StBhT4yKcIOLSDE4NnseMGxLMD5yMQrLGYyNhNKPxRbga
	zanO4BMaNDh2lgllYOIZD/THgiHe6/2qvYkNCx77HFaIWjzJaXlHcELazimQ8NjJTq6cOKib0Gy0Q
	jEDVpp4p0Mj72sVMjK1IPe5k6IsuPBB6mLoqxLF+5DqpU0omqFbfK50pqrpt668TOO6FV7WN9/bEF
	3VtYuL+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXztD-0000000BNQu-0t5F;
	Wed, 15 Jan 2025 09:40:43 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXzjc-0000000BKcY-1yOS
	for linux-um@lists.infradead.org;
	Wed, 15 Jan 2025 09:30:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=E6HX8Sk+Dge+/vzMt9rQGoTMCdVcd7eWjUMA8f+M2KY=;
	t=1736933447; x=1738143047; b=Yu13S46ixE2NcvHXT2WzcjO23c9e76Ku53x1SPs4zTv26wi
	PWzl5pSiGV48i5/tf1xs7DXG1/JFRWxzpyQJ1fi9O3DG9GblLE+vxuBMlv2lMUXxMkPfV/l1rSS3Q
	+2w0JalNFe2XeG72Cb/CwMfo20tm2y3h0aGF/6KMAccOYJ1r1btdOYAFshoVvG2pLQ/8keIAFWPBp
	C2g80QSjT28NFNtGVwZI6tUQUieWb09adY3AZXy0Y9hgYkL4Zj0xD6dvGWnnAN4h3HpfkOEBGz8dd
	PBEsAGG37G/HKQGZ24vQLIL9wQCOi0nlmzpROarT/+ru1VV5VW3YrolLo4v9yDYA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1tXzjY-0000000FcxN-01al;
	Wed, 15 Jan 2025 10:30:44 +0100
Message-ID: <6060a0e25f2b7903002e55182230da09c702b0e4.camel@sipsolutions.net>
Subject: Re: [PATCH v6 00/13] nommu UML
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, ricarkol@google.com,
 Liam.Howlett@oracle.com
Date: Wed, 15 Jan 2025 10:30:41 +0100
In-Reply-To: <m2cygo6hyl.wl-thehajime@gmail.com>
References: <cover.1736853925.git.thehajime@gmail.com>
		<3db55c1586f66718c871b678ec10d6c2aa88fbb3.camel@sipsolutions.net>
	 <m2cygo6hyl.wl-thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250115_013048_525880_568A7549 
X-CRM114-Status: GOOD (  35.87  )
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

Hi,

On Wed, 2025-01-15 at 09:25 +0900, Hajime Tazaki wrote:
> On Wed, 15 Jan 2025 03:53:36 +0900,
> Benjamin Berg wrote:
> >=20
> > On Tue, 2025-01-14 at 20:30 +0900, Hajime Tazaki wrote:
> > > This patchset is another spin of nommu mode addition to UML.=C2=A0 It=
 doesn't
> > > change a lot since the last version (v5), but contain clean ups.=C2=
=A0 It would
> > > be nice to hear about your opinions on that.
> > >=20
> > > There are still several limitations/issues which we already found;
> > > here is the list of those issues.
> > >=20
> > > - memory mapped by loadable modules are not distinguished from
> > > =C2=A0 userspace memory.
> >=20
> > Maybe I am missing it, but I do not yet see proper FP register
> > handling. This will be needed for task/thread switches and also signal
> > emission/sigreturn. I am attaching the test program that I used to
> > verify the correct behaviour when dealing with the recent changes to FP
> > register handling in UML.
>=20
> thanks for the test program.
>=20
> I didn't address your comment on FP register handling as I couldn't
> see any reproducer that causes the issue you raised (and maybe didn't
> understand well the problem) so, the attached program helps a lot.

Note that it doesn't directly test task/thread switches which only
happen due to normal scheduling (i.e. via SIGALRM). So, it doesn't
cover everything, but syscalls and signals are quite important by
themselves. For normal UML both cases hit the same codepath, but I
think in your case the SIGALRM entry point differs and should be tested
separately.

> Though nommu code only works with musl-libc, which I cannot use that
> as-is, now I see what you meant with the first function, test_fp().
>=20
> (none):/# /root/test-signal-restore
> pre-signal: 0.5
> post-signal: 0.5
> floating point register was not manipulated
>=20
> Tests on task switch (test_fp_ptrace) might need more work for me as
> nommu only works with vfork(2) and vfork without exec(2) may not test
> well on the implementation.

Not sure you even have a working ptrace in nommu?

That reminds me. Please set arch_has_single_step to zero for nommu
mode. If you figure out how to set the appropriate bit in EFLAGS when
returning to userspace, then that would also work.

> and also I'm wishing to have this kind of useful tests as a reusable
> way; as now I'm going to add a new configuration for UML, you're also
> going for another SECCOMP mode over MMU, we may have at least 3
> running modes for UML, which I think we should share the test
> framework that we should pass.=C2=A0 Not sure how it should be but using
> Kunit is the first thing in my mind.

My problem was, that I didn't know of a good place to put it. We could
probably drop this test into tools/testing/selftests/x86, but how is it
run then?
As for kunit, that would be neat, but I it seems a bit more complicated
to run userspace code from within the kernel.

Benjamin

> I'd like to work on such things once I've done this initial part for
> nommu.
>=20
> thanks, will get back here once I could see the right way to fix it.
>=20
> -- Hajime
>=20
>=20



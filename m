Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA93E77188
	for <linux-um@archiver.kernel.org>; Fri, 10 Jan 2025 16:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+owCkyYqkx7/zl4LzbiMfRHfhkWz709mdyyYVC7llmM=; b=X6n52x8XJ+POVhN9h+zZhRvzmC
	YpTYEBZTXYCwqK3118SBoboODTkGnpfJXi1qTItBNmew7KkhXcIPJcxLdluEHPeSUQoPrTrh32Sry
	5i2IOP1ARxqgxqaS8Rby887fCswv1vOsfbFXW+KH01vTo/ZcS3Mic4VX5E2WS7FcG/lB487C1/dMe
	hVFj9KErjou9+y9+HeNN0417sC7mFPgm5pQKkfnTa06/aetQU7qGmDN01GnPQx/FhSo9Moh8+stER
	MpX8i0pqZcVNyJerjZOS9pTnHtuNHDiJLRY7uH6Qggp4OVqc7zdk91BwZZ53EJ7iEXRkFb2DMtWV7
	s3Fxd/ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWHhS-0000000GC4J-3o2n;
	Fri, 10 Jan 2025 16:17:30 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWHRJ-0000000G82i-0ZwE
	for linux-um@lists.infradead.org;
	Fri, 10 Jan 2025 16:00:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=+owCkyYqkx7/zl4LzbiMfRHfhkWz709mdyyYVC7llmM=;
	t=1736524846; x=1737734446; b=RFdeZNtuzul7ge2quv2r7jMAOUZhZoBFdMoqo8m8Qa8hbpH
	NxtibIQQ8BGnaLD/BENP5Xj5J+D9tV1w9NguYkDZRh0aU1dQ3lYHpZVAy5cEk2cTjAxoJzqJPPOj2
	jXDBUvpCnaLuZWkJFSip2SXFa1RQI87hAh1pXo4uZPri27LhltVAzPGaOUKgBz5/2mAcBFD/6eFxb
	LFjcplGKlZgwbAHpmZxo7KK2sJn5hB79SSU6aBIBcbS5ALuvIQ1buV4k6/nRtW/7iWfiEPEfodedX
	PM0PLerSygePpwAtFUo6Vsik7kumwaJWWKKBFAAwTF9vIQ8giOCNMDIaHXEOonNQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1tWHRC-0000000AhBU-0QaD;
	Fri, 10 Jan 2025 17:00:42 +0100
Message-ID: <14c48bbdccf61060ffdd2072d8fd412add9c56a5.camel@sipsolutions.net>
Subject: Re: close_range is not available on older systems, preventing the
 building of a UML kernel
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: development@efficientek.com, linux-um <linux-um@lists.infradead.org>, 
 Richard Weinberger
	 <richard@nod.at>, Johannes Berg <johannes@sipsolutions.net>, Anton Ivanov
	 <anton.ivanov@kot-begemot.co.uk>
Date: Fri, 10 Jan 2025 17:00:39 +0100
In-Reply-To: <CAMuHMdUU-=kVeOzWxZ8A2fFnMCFXdNEc=5Ndbdgb6UrwSzvmog@mail.gmail.com>
References: <20250108022404.05e0de1e@crass-HP-ZBook-15-G2>
	 <01be0810b37628a4f8cd6e4b64b68ff7bf9d4ace.camel@sipsolutions.net>
	 <CAMuHMdUU-=kVeOzWxZ8A2fFnMCFXdNEc=5Ndbdgb6UrwSzvmog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_080049_187029_A8EE2A4A 
X-CRM114-Status: GOOD (  29.38  )
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

On Wed, 2025-01-08 at 12:13 +0100, Geert Uytterhoeven wrote:
> Hi Benjamin,
>=20
> On Wed, Jan 8, 2025 at 11:58=E2=80=AFAM Benjamin Berg <benjamin@sipsoluti=
ons.net> wrote:
> > On Wed, 2025-01-08 at 02:24 -0600, Glenn Washburn wrote:
> > > I'm wanting to build a UML kernel on Debian bullseye, which is at
> > > kernel version 5.10, which does not support close_range(). It appears
> > > as though close_range() support is required on the host since commit
> > > 32e8eaf263d ("um: use execveat to create userspace MMs"). Was there a
> > > conscious decision to break support for kernels less than 5.11, when
> > > close_range() was added. What is the policy on support of the host
> > > kernel? Since 5.4 is still supported as a longterm release. I think i=
t
> > > would be nice to at least support 5.4. Is there any interest in
> > > removing this restriction?
> > >=20
> > > Also, this system is at glibc 2.31, which does not have execveat()
> > > support, which is required by that same commit above. Since execveat(=
)
> > > has been supported since 3.19, this kernel should support it. Perhaps
> > > the issue can be resolved by defining a syscall wrapper in the UM
> > > headers if support is not found in glibc.
> >=20
> > Yeah, we need the CLOSE_RANGE_CLOEXEC flag, which was added in 5.11.
> >=20
> > On the one hand, there is no real alternative. This is a relatively hot
> > path (fork/exec), so I wouldn't want to replace the call with a loop.
> >=20
> > On the other, this is "only" an extra safety measure. It is acceptable
> > for this to fail (the result is not even checked currently). As such,
> > the biggest issue seems to be that your libc does not yet have the
> > symbol.
> >=20
> > Said differently, we could just replace the call with:
> >=20
> > #ifndef CLOSE_RANGE_CLOEXEC
> > #define CLOSE_RANGE_CLOEXEC=C2=A0=C2=A0=C2=A0 (1U << 2)
> > #endif
>=20
> Would including include/uapi/linux/close_range.h help?

Well, I expect there is the chance that the system version of the
header is included indirectly and that would lead to redefines.

> > =C2=A0 syscall(__NR_close_range, 0, ~0U, CLOSE_RANGE_CLOEXEC);
> >=20
> > I am not sure whether we would want to do this in the upstream code.
>=20
> tools/testing/selftests/bpf/prog_tests/d_path.c does that, too.
> But that's not real upstream kernel code...

I'll submit a patch. I am a bit ambivalent about supporting kernels as
old as 5.4. But, it is simple here, so might as well do it.

Benjamin


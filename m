Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E4AC4828D
	for <linux-um@archiver.kernel.org>; Mon,  5 Feb 2024 19:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:To:Cc:From:Subject:
	References:In-Reply-To:Content-Transfer-Encoding:MIME-Version:Content-Type:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VnU+6e+ztuKtMqc5xqQmN4IiSdNFLhWSM/PUfT/+6bY=; b=upMUttdVAW/R1I2sFo0Qfqk0sk
	1FvDHFVlR+en3oBvCQ5f0rVLghADeuUwqejqfrwtrL9Zvat+w47/IZ2/ibEXr9kA8h+fyN2jJoL1V
	DOAhdmyHq3hYCGu3Hesil7FnoIU82q2pdHkFhrTAqOKiTklth9HRrzEEHbbgHR5eYcoyuqEDGa7nR
	UAluKdvLZwyVFm71KTvocYYrb1tGKF6vNxo36zb9MSOljdXgVqQ3Yq6AbUwq/L2gKC1wb2BA9zYc2
	0vfjAgoMUD8P33OXlccBDmqxPeg0bXMaGa3gxrHdQalfLn5pztYLdcG8c0rgwvSyqLXYmFLcfF7y8
	m6YrKGzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rX4Un-00000004YIY-0ZXJ;
	Mon, 05 Feb 2024 19:19:09 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rX4Uj-00000004YGn-29jh;
	Mon, 05 Feb 2024 19:19:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5C0AB6126C;
	Mon,  5 Feb 2024 19:19:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142AAC43394;
	Mon,  5 Feb 2024 19:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707160744;
	bh=rZHGOctIsEvjRWCOq7z4zGR9cZjW17vqL6xAeBZUzJU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=nd5zm0ncAhhGDHhu3rHoIDRrAqaTNw8VDmNRyF7/k2rLZw9pL2g1qLgkpjzHrbpuQ
	 4SUNIrj1K57a0eufKX4WDaOJYd2LqTN0drTYV7eX2+ZohOganiub6bAHoD/0Z/4rfO
	 NSxCZWMAqL+Jy4Ex8mh3c61U/hO+jFPZ6OEYrFIeh23wOvqhU82B8FrJDdBpk8Olsx
	 hujarPDCw/rDZp8FFWaHI222EDYGzFFC2kkFlyU9+awEUrMos5miE9hlMxBcZtlbBM
	 0TyUyQ+2l4P7bNKwrQF3wHuWDlJrPGsZtY5cfSAZRd3+TID5mWIq+GvelggU4mXlPr
	 nM9bn8GEhF6pw==
Message-ID: <89892ecd6b1b043db58258705c32b02b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABVgOS=A8BQ6HHpBKFqg-N10ckk2XYavaS-MPXvZ0wenrVm=1g@mail.gmail.com>
References: <20240202195909.3458162-1-sboyd@kernel.org> <20240202195909.3458162-8-sboyd@kernel.org> <CABVgOS=A8BQ6HHpBKFqg-N10ckk2XYavaS-MPXvZ0wenrVm=1g@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] of: Add KUnit test to confirm DTB is loaded
From: Stephen Boyd <sboyd@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, patches@lists.linux.dev, linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, Brendan Higgins <brendan.higgins@linux.dev>
To: David Gow <davidgow@google.com>
Date: Mon, 05 Feb 2024 11:19:01 -0800
User-Agent: alot/0.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_111905_655742_79423434 
X-CRM114-Status: GOOD (  23.63  )
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

Quoting David Gow (2024-02-02 20:10:17)
> On Sat, 3 Feb 2024 at 03:59, Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Add a KUnit test that confirms a DTB has been loaded, i.e. there is a
> > root node, and that the of_have_populated_dt() API works properly.
> >
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Frank Rowand <frowand.list@gmail.com>
> > Cc: David Gow <davidgow@google.com>
> > Cc: Brendan Higgins <brendan.higgins@linux.dev>
> > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > ---
>=20
> This looks pretty good to me test-wise, though it still fails on m68k.
> (Everything else I tried it on works, though I've definitely not tried
> _every_ architecture.)
>=20
> aarch64: PASSED
> i386: PASSED
> x86_64: PASSED
> x86_64 KASAN: PASSED
> powerpc64: PASSED
> UML: PASSED
> UML LLVM: PASSED
> m68k: FAILED
> > $ qemu-system-m68k -nodefaults -m 1024 -kernel .kunit-all-m68k/vmlinux =
-append 'kunit.enable=3D1 console=3Dhvc0 kunit_shutdown=3Dreboot' -no-reboo=
t -nographic -serial stdio -machine virt
> > [11:55:05] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D dtb (2 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > [11:55:05] # dtb_root_node_found_by_path: EXPECTATION FAILED at drivers=
/of/of_test.c:18
> > [11:55:05] Expected np is not null, but is
> > [11:55:05] [FAILED] dtb_root_node_found_by_path
> > [11:55:05] # dtb_root_node_populates_of_root: EXPECTATION FAILED at dri=
vers/of/of_test.c:28
> > [11:55:05] Expected of_root is not null, but is
> > [11:55:05] [FAILED] dtb_root_node_populates_of_root
> > [11:55:05]     # module: of_test
> > [11:55:05] # dtb: pass:0 fail:2 skip:0 total:2
> > [11:55:05] # Totals: pass:0 fail:2 skip:0 total:2
> > [11:55:05] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D [FAILED] dtb =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

Ah yeah I forgot to mention that. m68k fails because it doesn't call the
unflatten_(and_copy)?_device_tree() function, so we don't populate a
root node on that architecture. One solution would be to make CONFIG_OF
unavailable on m68k. Or we have to make sure DT works on any
architecture. Rob, what do you prefer here?

>=20
>=20
> My only other question is about the test names: the mix of 'of' and
> 'dtb' can be a bit confusing. As is, we have:
> kconfig name: OF_KUNIT_TEST
> module name: of_test
> suite name: dtb
> test names: all start with dtb_
>=20
> Given KUnit only really deals with the suite/test names directly, it's
> not trivial to see that 'dtb.dtb_*' is controlled by OF_KUNIT_TEST and
> in of_test if built as a module. (This is getting a bit easier now
> that we have the 'module' attribute in the output, but still.)
>=20
> Would 'of_dtb' work as a suite name if it's important to keep both
> 'of' and 'dtb'?

Sure, I can add of_ prefix to the tests.

>=20
> In general, though, this test looks good to me. Particularly if m68k
> can be fixed.
>=20
> Reviewed-by: David Gow <davidgow@google.com>
>=20

Thanks!


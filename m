Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96589C5DF9C
	for <linux-um@archiver.kernel.org>; Mon, 24 Aug 2026 10:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dLNIue6LBcWvdxKP8M6jQZTbwZKO04v0RDZAqcIK23g=; b=dWJ214RHrjuRTiZ5pUVT5GP8fP
	gNx/r8Zu6hMh+8RFrcjg4aOvoknrl8RfIl7+MhsQFfEbxKRLJkpeA5GeY2bcFPcm6oHzpflGG9AYW
	K88uUiHDFwVpAqP1vVbjGPdh3dljZVJm3X78XHrcdrnAYiptclluOssKaYxjATgYH65FUTFiaounz
	Y5757d8oshBFDxYPdUe1q/9Vep/5ZRvAVFkTpNbWiw3f/tt46d78UwjK2V0UqhaoP4Bbi6XIJR/yc
	mtS3EAkPjAnaP+o862U2gRiT9f9R//RDIRu3S+MOCiCZNLzpqcJefiCnnAk9DcTrAUDtEfFBi1twm
	wGuXwuMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyRpK-0000000GOFC-2rsE;
	Mon, 24 Aug 2026 10:22:50 +0000
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyRpH-0000000GOEd-2sxy
	for linux-um@lists.infradead.org;
	Mon, 24 Aug 2026 10:22:49 +0000
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-c15e2dab83eso616986966b.1
        for <linux-um@lists.infradead.org>; Mon, 24 Aug 2026 03:22:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787566966; cv=none;
        d=google.com; s=arc-20260327;
        b=NZr0CtKuWjMhyTZA2J8LP5M7qlxEDb71O06J0h4vxOrvfLPz5CzSRR+wQM3xj6zDGc
         PdztI3RdwgFKEKX0Vy6AMH2YC0VcbZq70FnfR/h1QOS9XyPRJ49YQC+VQn5oe4vxmT9T
         IDfgOqUXeZYaFpoE/ZtIsytxZk1e7fze+Bxj446Xrlj0+3GyM5r6NhQ5UAqMBSr0QEAO
         GxcyHWRRgz5DNXTX9H3G9IFhZsB7uLk/e23j2/hT1YvL+BBqKTK6Y+ux0erLtB1tLHwA
         69O7iwFcsm0Mei1erY26kDvZean2ngWbrZhGV8x6SXrKFnzUsnRheZrCSh6A35Fjkmr/
         CoMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dLNIue6LBcWvdxKP8M6jQZTbwZKO04v0RDZAqcIK23g=;
        fh=4teNChTMf1AgPqndCYwxsKsfqHxomnGijeBulsFzeeo=;
        b=h8SQzWD5x+RvgInm9qa2eqESyDJJlvtzHfgufw1csaw/+Q3x44IJcSruGSbBc6fnd8
         KsKnr1KgosMqVz7IeWDp/ZVWFXcGalhODoG0M1wJ9wgvAgX219jmo3QRyvbu9pV7XtxA
         6upQUHJDLu2p+3JxJszKv3SLH37FJXWBY8mFLavS+GR1IafB4A3aQPlIcUgstcPRuE4W
         6QCCDla9HUZKcJ1721ZGoaBpRalNv0FHlNnEpqG2Wns/66fJYH3nOrCNmd7qzZQ4yn2G
         eefJQTE+FhQMbHOhwTJcIq0i+Qvq0kTI0wojky/9KEwZeKzu/8Bl8FvkqZG5L37Zj99r
         cXdw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isomorphic-ai.com; s=google; t=1787566966; x=1788171766; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dLNIue6LBcWvdxKP8M6jQZTbwZKO04v0RDZAqcIK23g=;
        b=Q3kHHEaLnswv8gq07/TvuFkCWfi0azXE+9Ppz/I5re+mceIgxehpW3KWu1S+HMtlJ+
         hMJLzhQev8IcFCFFRahApE0MXGte4RU7dofZYsm621/QFVw5dYy6ngOnZd2LpE5GzfCC
         9vlX5t2mkvlzxv6HI4NysYtLINiWpT7XKrJEYL94aQHbADSvm486A2LabrX9TzGA1XMz
         2rIbCiprnxLnAwUZUYhX2VPfE8470psWyau27rm06G4Xu5VTLck4YvSk0qqM7hqgmESn
         QpMuer2u6JJNLB6ukxv1hoHLgOoNpjAOgb5V3j2PwQRAnysTg8m67t5kld0XPYUtFG76
         Ezjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787566966; x=1788171766;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dLNIue6LBcWvdxKP8M6jQZTbwZKO04v0RDZAqcIK23g=;
        b=ZyZdrXTT0YFyjyPWrKVNVN86EHpAI83oYzL70yFtzuYl5x+Hbnp6fjA3FJXmMux4RB
         lw836BQxsoYAC4vsRVaLwVly1Dlmve/YjWtxjaxuxv1v27SYKS/3vRsxkECX0ed/uLj3
         WbwGhgy6lTM4xOzuTi29cbF3wZv1DnHfXeJP35oNA+WWcbeCblxvGi2Ln92mZL58s6wZ
         s42u45TPBSroFopqwMf7a34Utyga8iVqirbVvxewzTZohlRvfOuwqBAuV0yqbh2XVffI
         GODbe5AI0IpajqBw6JxJIpy8H71NSisQv1sYsORYthmbC/HnTjOfhnltsLKR3xQ3fdKg
         +zSQ==
X-Forwarded-Encrypted: i=1; AHgh+RogwFXi6iP5tqPuPpQ8lWx/FV0EjDJ+0hd45l660dbG3arbM9BMz9sPmExn4wIKekh0GxRGBVenRg==@lists.infradead.org
X-Gm-Message-State: AFuF++k5602lRPfaKApqtWmks42aBu9O/s9F52fdvx+pMmM97UbHvFJ5
	X0Q4luUpjn2NoreC2vSqlPXX115+uK0sdJIWmSlzyFrmGt3ug1Gr1OAvPLBYASk32QepPASxhwp
	mPK5HLMeryisANJ0jyrbM6e2G/HAgxlnA+Puvmf6WYQ==
X-Gm-Gg: AR+sD13vsG2EocMQCyfVfyeLGAeS7Umkn4+YPnz8GcrVH6gnxzZw/58yVoK6BVQqClc
	ow4FnkJl0gMZ5ryiM6Lr8pTBkpwgzbEqPwqW13Q+cJF00DVJ+odaC2bUcd8OyA9KLNlkNhrT8v1
	uIkn7nSg9Gp5lim7TgnhIivLRHPAy7erRru4PH0eM7fBBZ9Yo3AaYmfs4L7aDX2hQKmyoeGtW0v
	ygrYkK3S9Zui//kQ2nK0ZD6Uj4CrpKWBLZ3gyjC27GLTavL+kxPn6LiFdpjmyBXZJV6nKjq5adu
	hyp753iD/c9LprNSfynvBIPE1DR8fXF0zGs6tG4HdjASbDA+LprJ77AWBhFTgDbx4xDYmi0j4QP
	oqO+gXlHZjegD5T8mHB/gn0EaqiXAGeT5puzZyOyLOcmJpJYEBu5ixGPw1YOSU/UridL9s1krG9
	CwvfzO8VAe+aqbFcpI+vf3tpPcEm0HK97ZIOEeFRrhIeU=
X-Received: by 2002:a17:906:fe03:b0:c16:242a:472f with SMTP id
 a640c23a62f3a-c246b4af7e1mr3239881966b.23.1787566965457; Mon, 24 Aug 2026
 03:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260823201521.2576344-1-fabian@isomorphic-ai.com>
 <a02b160a-874f-491c-987b-4d7eb0d35a9f@leemhuis.info> <20260824092300-3e9a9d58-b273-421b-a4bf-5609ccb9ab49@linutronix.de>
In-Reply-To: <20260824092300-3e9a9d58-b273-421b-a4bf-5609ccb9ab49@linutronix.de>
From: Fabian Franz <fabian@isomorphic-ai.com>
Date: Mon, 24 Aug 2026 11:22:33 +0100
X-Gm-Features: AcwNN1UVFKjEcez8IB5zIpYrL6ue944P2BsTb4hcS9g6xutOt-_NDFHFLV7W5QI
Message-ID: <CAKbYdNEK0TUy+W5g_yGuP-JCC9CQwmeO0q95rYhcebZYB9vLUw@mail.gmail.com>
Subject: Re: [PATCH REGRESSION] um: Fix cpu_feature_enabled() build breakage
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Nikolay Borisov <nik.borisov@suse.com>, "Xin Li (Intel)" <xin@zytor.com>, 
	Ingo Molnar <mingo@kernel.org>, Claude Fable 5 <noreply@anthropic.com>, linux-um@lists.infradead.org, 
	linux-kernel@vger.kernel.org, 
	Linux kernel regressions list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260824_032247_783242_39161CF3 
X-CRM114-Status: GOOD (  40.04  )
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

>
> Thanks for this pointer.
>
> > https://lore.kernel.org/all/20260819-uml-timex-fix-v1-1-f690b514fc9f@li=
nutronix.de/
>
> Indeed, both our fixes seem to be for the same breakage.
>
> Personally I prefer my patch, as it reverts the specific change which
> introduced the breakage into the tree. Franz' change does not look incorr=
ect
> but is a larger change and should go through a regular release cycle.

I also prefer your patch. It is much simpler and doesn't require
changing the cpu flags at all.

However, getting the minimal patch for um in ASAP would also be good,
as a broken master is not nice for development.

Thanks,
Fabian

>
> > Ciao, Thorsten
> > > Two independent breakages meet here:
> > >
> > >  1. cpu_feature_enabled() and this_cpu_has() still test
> > >     DISABLED_MASK_BIT_SET()/REQUIRED_MASK_BIT_SET().  Those used to
> > >     come from <asm/disabled-features.h>/<asm/required-features.h> via
> > >     <asm/cpufeatures.h>, but since commit 8f97566c8a81
> > >     ("x86/cpufeatures: Remove {disabled,required}-features.h") they
> > >     live in the generated <asm/cpufeaturemasks.h>, which only the
> > >     arch/x86 archprepare rule generates.  ARCH=3Dum never generates n=
or
> > >     includes it, so the references have been dangling since then.
> > >
> > >  2. The _static_cpu_has() macro expands to itself.  Commit
> > >     3eaa50e1e255 ("x86/cpu: Hide and rename static_cpu_has()") rename=
d
> > >     the inline function _static_cpu_has() -> __static_cpu_has() and
> > >     the macro static_cpu_has() -> _static_cpu_has(), but in the UML
> > >     header the macro's out-of-line branch kept calling
> > >     _static_cpu_has(), which now names the macro itself and is left
> > >     unexpanded by the preprocessor.
> > >
> > > Fix the macro to call __static_cpu_has(), as the x86 header does, and
> > > drop the mask based short-circuits from cpu_feature_enabled() and
> > > this_cpu_has().  UML has no compile-time feature masking to express:
> > > capabilities are copied from the host's CPUID at boot, see commit
> > > d8fb32f4790f ("um: Add support for host CPU flags and alignment"),
> > > and generating cpufeaturemasks.h from a UML .config would wrongly
> > > mark features disabled simply because the gating CONFIG_X86_* symbols
> > > do not exist for ARCH=3Dum.
> > >
> > > Fixes: 3eaa50e1e255 ("x86/cpu: Hide and rename static_cpu_has()")
> > > Fixes: 8f97566c8a81 ("x86/cpufeatures: Remove {disabled,required}-fea=
tures.h")
> > > Signed-off-by: Fabian Franz <fabian@isomorphic-ai.com>
> > > Assisted-By: Claude Fable 5 <noreply@anthropic.com>
> > > ---
> > >  arch/um/include/asm/cpufeature.h | 8 +++-----
> > >  1 file changed, 3 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/arch/um/include/asm/cpufeature.h b/arch/um/include/asm/c=
pufeature.h
> > > index f7770083c0a4..20b2c7ead62e 100644
> > > --- a/arch/um/include/asm/cpufeature.h
> > > +++ b/arch/um/include/asm/cpufeature.h
> > > @@ -37,8 +37,7 @@ extern const char * const x86_bug_flags[NBUGINTS*32=
];
> > >      test_cpu_cap(c, bit)
> > >
> > >  #define this_cpu_has(bit)                                          \
> > > -   (__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 :  \
> > > -    x86_this_cpu_test_bit(bit, cpu_info.x86_capability))
> > > +    x86_this_cpu_test_bit(bit, cpu_info.x86_capability)
> > >
> > >  /*
> > >   * This macro is for detection of features which need kernel
> > > @@ -48,8 +47,7 @@ extern const char * const x86_bug_flags[NBUGINTS*32=
];
> > >   * supporting a possible guest feature where host support for it
> > >   * is not relevant.
> > >   */
> > > -#define cpu_feature_enabled(bit)   \
> > > -   (__builtin_constant_p(bit) && DISABLED_MASK_BIT_SET(bit) ? 0 : _s=
tatic_cpu_has(bit))
> > > +#define cpu_feature_enabled(bit)   _static_cpu_has(bit)
> > >
> > >  #define boot_cpu_has(bit)  cpu_has(&boot_cpu_data, bit)
> > >
> > > @@ -112,7 +110,7 @@ static __always_inline bool __static_cpu_has(u16 =
bit)
> > >  (                                                          \
> > >     __builtin_constant_p(boot_cpu_has(bit)) ?               \
> > >             boot_cpu_has(bit) :                             \
> > > -           _static_cpu_has(bit)                            \
> > > +           __static_cpu_has(bit)                           \
> > >  )
> > >
> > >  #define cpu_has_bug(c, bit)                cpu_has(c, (bit))
> > >
> > > --
> > > 2.43.0
> > >
> > > Every ARCH=3Dum build has failed since the 7.3 merge window.
> > >
> > > #regzbot introduced: 3ed403bbc967
> > >
> > > Steps to reproduce on master:
> > >
> > > make ARCH=3Dum O=3D/tmp/um-build defconfig
> > > make ARCH=3Dum O=3D/tmp/um-build -j$(nproc)
> > >
> > > fails with:
> > >
> > > /home/ubuntu/projects/linux/arch/x86/include/asm/tsc.h: In function =
=E2=80=98get_cycles=E2=80=99:
> > > /home/ubuntu/projects/linux/arch/um/include/asm/cpufeature.h:52:39: e=
rror: implicit declaration of function =E2=80=98DISABLED_MASK_BIT_SET=E2=80=
=99 [-Werror=3Dimplicit-function-declaration]
> > >    52 |         (__builtin_constant_p(bit) && DISABLED_MASK_BIT_SET(b=
it) ? 0 : _static_cpu_has(bit))
> > >       |                                       ^~~~~~~~~~~~~~~~~~~~~
> > > /home/ubuntu/projects/linux/arch/x86/include/asm/tsc.h:79:14: note: i=
n expansion of macro =E2=80=98cpu_feature_enabled=E2=80=99
> > >    79 |         if (!cpu_feature_enabled(X86_FEATURE_TSC))
> > >       |              ^~~~~~~~~~~~~~~~~~~
> > > /home/ubuntu/projects/linux/arch/um/include/asm/cpufeature.h:115:17: =
error: implicit declaration of function =E2=80=98_static_cpu_has=E2=80=99; =
did you mean =E2=80=98__static_cpu_has=E2=80=99? [-Werror=3Dimplicit-functi=
on-declaration]
> > >   115 |                 _static_cpu_has(bit)                         =
   \
> > >       |                 ^~~~~~~~~~~~~~~
> > > /home/ubuntu/projects/linux/arch/um/include/asm/cpufeature.h:52:72: n=
ote: in expansion of macro =E2=80=98_static_cpu_has=E2=80=99
> > >    52 | builtin_constant_p(bit) && DISABLED_MASK_BIT_SET(bit) ? 0 : _=
static_cpu_has(bit))
> > >       |                                                             ^=
~~~~~~~~~~~~~~
> > >
> > > If this is known please disregard. I am also not 100% sure if this is=
 the right fix or if it's better to bring back the macros to um.
> > >
> > > In any case it would be good for um to build again on the master bran=
ch out of the box.
>


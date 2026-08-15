Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326FBC5DF67
	for <linux-um@archiver.kernel.org>; Sat, 15 Aug 2026 21:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zl3zbyHOUnx+7x+7DiqXwgLH8VDCbrevPogqZgNIfiA=; b=cB/ZkN2ywfHbUEcsFz8FCwTgwN
	PddLnysps8qQCz3A0atKgwxE6+IL/uXGXICUzkB2ELKbyy3Sd3UnSMZHgFne0eS/ZAKInoLYrzSxG
	XNhdWmW4djbZrZG4ddRpEdb/jUi2PEog3tTTSZ5ELvA+CtQeIU1DJrw5U6CpRr0TVfMKoMTya5vjq
	speCzZ3D+sCSpFSlk2aYsru6IBRCoRDt8Td+h3TpwKtBphHO+ucprIVWyP5GQd2uZKHWSmKjqWct1
	SZkFU+bUZVb92Rz5YN08h6nskK5VhXTRe8y+0UU2xVexvjEqO3kSAx2521StyScrPR23omvMV2rCL
	CsUPa+fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvMOI-00000004Dvl-2gxF;
	Sat, 15 Aug 2026 21:58:10 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvMOE-00000004Dv8-2scV
	for linux-um@lists.infradead.org;
	Sat, 15 Aug 2026 21:58:09 +0000
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-38f620399a0so1902349a91.2
        for <linux-um@lists.infradead.org>; Sat, 15 Aug 2026 14:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786831085; x=1787435885; darn=lists.infradead.org;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Zl3zbyHOUnx+7x+7DiqXwgLH8VDCbrevPogqZgNIfiA=;
        b=JUnI0B8lXpQ7V16ZRGhvYtfBl2P5czU+ze4GU4jqZBy+bQyHobG8aMFuOwYm0+LqRC
         JNdxh8feWtVEZ1fygU5beD3Fb9vgdouAR1c/AxZExwYia41UP6DUSALtdNAqE4PKEKuy
         Lll9cMRmbA2FghisgPUnmmgc8YUVgUWzEFyk4I/r04cyBr7TISI7b/Mdi4zRc1QESJaN
         hY3vIWGxVcf00tNEPYCBPtyEEeLmsZjlJTzxAP2GjXJ4QkFzIV50ghPRqP2jgc8hg7z7
         Lx/keu9YadGqab5LFvcNyPe5MqyNimlro0LCSzvmYwkBYetHlzrg6KRopMGYr/eYFx79
         6hYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786831085; x=1787435885;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Zl3zbyHOUnx+7x+7DiqXwgLH8VDCbrevPogqZgNIfiA=;
        b=ZG2VTo5Znewtos5+o1qcnV9PRRlSdkSgX8gp6oA9Apq/uWb0wNNjrf++gOQDW9NMm1
         VXa3fv89W2/9Mkh5YEzoes5G82fCgfrHhdVAlCHDUmlA+PfV3HcsgwgK3y6mlx+ICz/o
         FMreZ32PxGrTu3nFPGt1c2qxNUfF7bFihXdTLyI3Qep+NsoTJTg3IeEjgEa2+6lVDwzG
         x+A46nItlsBln7ZG0o4jXKGDVNK2m9WyujYg/ureYtAo2mSzkvFIqKcakO/Fctmmta2I
         duQNoqlnBsS13gyAdhsBZK8MuvYZtZY/Rk5/iOAAVhOHk4HRpa0eaBTapCdneF+f1Oud
         Gazw==
X-Forwarded-Encrypted: i=1; AHgh+RpA8AEKHTu50C+faegmZpPzJfxzbA0iU8ZDQumt29MclFLKAcLZiXWWNFtEmLgl5bUofr0dWkcCOw==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywdcipvq8zeHligPzY8NTECMvL5ySkcjOdD0edGAIa6Z2K0JLv4
	kboSjmc0+GjYjRzNiU/DmUVlYRthWtaXPUnd7KC8+7QBwwsOINfHzOkF
X-Gm-Gg: AR+sD10bmh5QyQkSOs3can6mQNp7ECyRgMgxqJoDfnkQcIqMofmCfPfVGBhD5n9tk1J
	wklLwKjGRar+LJioDNo6pjr994JZ3vG1aVeHO0UxDa2f9Ji0oPZ+xn0NKiEtHuPMU9K6OvQ0zu6
	7q66SU2IVw3/RylJ+bJR/1UI7iR1FixCL3ct0I2sxVcGyWNyqyEahxLAUXn4h4VP0MBccar39U8
	vpo1qwrWXJCBtzm4QcggS/xw4F4qkryTM47T8OnGcA2QqoWJ3ap6xLH8apRyt2nyAeLPhaOkxHH
	4tEwt7jxfI8zhpb9VEa9V82Xn/j++309gbLzOBNiAFU4YP+etgu+4CTb6i8VBGwwCq5GxMXTxhp
	t3RvwBdPj9K9sFz+imZvO2gWMdtXS1vq+poECndnc+8A3Nca12zasJ/EJPc6R3d+L5meZ8XHawD
	wUCQl97M3ZZQvZdHyCyh6TFdRRWeAT7WnPHfc+IMOhhhNKY3ygdyr9qVTwWlSz+RiKK0R1Kuehm
	Wb3m9mX3apspmuML8Oe+0lj0qQB37dXhyeIaR1oF7JYCQiSOsw4Tgqna/3VTIc7aixECPTbEmxX
	JLgf+A==
X-Received: by 2002:a17:90b:57cf:b0:390:8361:a532 with SMTP id 98e67ed59e1d1-3933b8072a0mr17420143a91.7.1786831085297;
        Sat, 15 Aug 2026 14:58:05 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394eb78f1a4sm7281618a91.17.2026.08.15.14.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 14:58:04 -0700 (PDT)
Date: Sun, 16 Aug 2026 06:58:01 +0900
Message-ID: <m2v79boxli.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: ljs@kernel.org
Cc: linux-mm@kvack.org,
	geert@linux-m68k.org,
	daniel@thingy.jp,
	shuah@kernel.org,
	kees@kernel.org,
	luto@amacapital.net,
	wad@chromium.org,
	broonie@kernel.org,
	jackmanb@google.com,
	liuhangbin@gmail.com,
	rbm@suse.com,
	linux-kselftest@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: Re: [RFC PATCH 5/6] selftests: run tests on nommu architecture
In-Reply-To: <an8MlE22U3586R42@lucifer>
References: <20260813063401.1786548-1-thehajime@gmail.com>
	<20260813063401.1786548-6-thehajime@gmail.com>
	<an8MlE22U3586R42@lucifer>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260815_145806_759004_45E887C9 
X-CRM114-Status: GOOD (  38.56  )
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


On Fri, 14 Aug 2026 21:50:50 +0900,
Lorenzo Stoakes (ARM) wrote:
> 
> Not really loving this as mentioned on the cover letter.
> 
> I'm sympathetic to making things work if it's not invasive, but now you've
> essentially asking new test authors be aware of this to some degree.

It is not intentional that new test authors should have to think about
NOMMU=1.  If there are no option specified it should be as what
the current kselftest is and it it's not, it's a design failure of mine.

> And making the harness - which is the defacto way of writing tests - now
> simply not work there is a bit crazy.
> 
> I'd ideally like to see _all_ tests use the harness.

I also think so but if NOMMU tests is implemented using the harness
test, this patchset would be invasive.  This one is very small patch
which tries to:

- add ability to run tests on nommu
- with minimum modifications and not breaking any existing usage of
  kselftest

which are, I guess, what you're suggesting.

> Also a bunch of the tests already do forking as part of the testing:
> 
> $ cd tools/testing/selftests/mm
> $ rg -l "fork\(" | wc -l
> 17
> 
> So at this point you're not really running much of the selftests at all,
> and are only happening to run those that don't do the very basic stuff
> nommu can't deal with.

the current situation is exactly what you described. `TARGETS=mm` is
able to only build with NOMMU=1, but onlyis runnable with nommu_*_test
(I need to specify `-t nommu_mmap_test -t nommu_mremap_test` to pass
tests from a run.

Now I'm thinking to create a different target (e.g., `TARGETS=mm/nommu`)
to make it more clear for this situation.

Existing tests even in selftests/mm should not involve these new tests
which has such limitation.

> I think an audit of existing tests to figure out what works with nommu vs
> what doesn't is really unreasonable again, given nobody tests or seemingly
> uses these arches.
> 
> So this patch might beget more nommu carve outs and exceptions and
> therefore nommu workload and maintenance, which isn't really sustainable.

I can understand but without tests we cannot easily detect regressions
in future.  Like when you applied broad changes into mm and try to
apply also to nommu.c, I believe these tests are also useful to verify
the extension, especially if the changes are not trivial.

# sorry, this might be too obvious for you..

> I know I complain about lack of testing on nommu, but at the same time I
> don't think running arbitrary tests that happen to work on it and who knows
> if they are valid asserts anyway really fixes things.

agree.
I think (current) nommu isn't ready to run arbitrary tests of mm.

> And given nobody really is doing testing, it's not really a great RoI
> here...

At least myself, for the moment, has an interest.

> ...OTOH I suppose it's a minimal change we can largely ignore as long as
> this doesn't lead to additional work/auditing from anybody but nommu
> enthusiasts.
> 
> But I'm just not sure that will be the case :(

again, this (not breaking existing model) is my intention so, this
should be the case, and if it's not it should be addressed in this
series.

> (I'm amazed we support a mode in linux that can't fork() in 2026 :)

I concur.

> > ---
> >  Documentation/dev-tools/kselftest.rst       | 12 ++++++++++++
> >  tools/testing/selftests/kselftest/runner.sh |  9 +++++++--
> >  tools/testing/selftests/kselftest_harness.h |  4 ++++
> >  tools/testing/selftests/lib.mk              |  8 ++++++++
> >  4 files changed, 31 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
> > index 64c0ec7428a2..800b2b688aff 100644
> > --- a/Documentation/dev-tools/kselftest.rst
> > +++ b/Documentation/dev-tools/kselftest.rst
> > @@ -230,6 +230,18 @@ section::
> >
> >  .. _tar's auto-compress: https://www.gnu.org/software/tar/manual/html_node/gzip.html#auto_002dcompress
> >
> > +Build and test on nommu target
> > +==============================
> > +
> > +If you (cross-)build kselftests for nommu targets, or run tests on nommu targets, use

-- Hajime


Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F8FC3ABC5
	for <linux-um@archiver.kernel.org>; Thu,  8 May 2025 23:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vVftmXWZSTFa0WcDMamix57/Frwyl8cY63IagUlGcj0=; b=hJikie+pkSK5KcPEVhOCca225i
	y5jdXkes+hl+Yqtjblbn3WZii0H2JzkiffSDNY2XL7plhJHLdjpd1JFU9CZrHD02jJyzdtgxSFp16
	cmAEw62S6zBzUKSEwG9aRKprOfGEvoyuYa8lrOcFOk1oj3KBcY8bZ40K5Wqau9kIPbMHFYyPkOmVK
	ApFJNw5qNw5/Tyn9Bnxxr9f7VAnq8oHzV+lI37fXQohBzEvwD8JXSste831Khn+2/xom7knhvq+Zj
	+UBu7CMZCGmMPoFGAAZPt3BT0VcbN/nUy4vx+BhmqUjnhmi+/ZQiHELus/kBNtX5nkvLYaKq6r48c
	cM5E1c1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDAuR-00000002127-3p5j;
	Thu, 08 May 2025 23:44:11 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDAuO-0000000211e-2zu3
	for linux-um@lists.infradead.org;
	Thu, 08 May 2025 23:44:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DAD3A5C64F7
	for <linux-um@lists.infradead.org>; Thu,  8 May 2025 23:41:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE345C4CEED
	for <linux-um@lists.infradead.org>; Thu,  8 May 2025 23:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746747847;
	bh=VD77Bm/Lw9PN11tTiagCuFPnT8sKVBvBCh2f/LHW71A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sspezmIoQW0IStetezr9LmZ2c20o6FiGyIZWDK/AZLoKzycg30MpJ7z4U91zeO7o6
	 BCA6EbE1i6RxXaqqoxnJCRk5FMY25ysTGN6o5Ed52GA8DZ519dBcWn1LP11SNIwA9S
	 Y6bwnSKnnbTey62iceOE9MHX54fVz25/qvvV3liMlLx0DRVrxuTaNI8Eugdn+faFS0
	 Xl7eRhtRr7t5NRv/+iuqHBIdOG7XtoArtwgY18iaTR6Kn/DYgAmqZCwn0K9qJeVrYQ
	 EbSgD63uPOFzLBcSYyhacopuIcQO/SxEvzeyR1RjSIOc2BaacH2SEVbpMrPQBUCtm9
	 osMvyZRPzcx3w==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54d6f93316dso1817317e87.2
        for <linux-um@lists.infradead.org>; Thu, 08 May 2025 16:44:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUG4AY3ZazXOlppTwV7jXLJHFwJhUxXlfJuGNUuWg6ULKIbt2KlBYTcD7CCZi+SyGFXpoiKNxYwkA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy0TkGZ1ArRur00iSdHWMn5x7L3IQsD9NmdNdC04iqeN1QoXCDJ
	GvREWB8fl4maH54fFOoOvqMmTMrr7vZpyI9yEwb66oOixayqvksKVdCkuYQdIredClJsh5lK5E/
	m62oBJayicAhE6mPlje/KWgA8NSU=
X-Google-Smtp-Source: AGHT+IGSLkr2J9fompKcX3UkbVBHJw3IyGmTwqs1lj0yAnIGW/lnpIbYYZKhnzxYzoAgzhJUWx+gqtg2q38ESpuszcU=
X-Received: by 2002:a05:6512:448a:b0:545:c7d:1796 with SMTP id
 2adb3069b0e04-54fc67e4c48mr386027e87.43.1746747846560; Thu, 08 May 2025
 16:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250507074936.486648-1-masahiroy@kernel.org> <9ec50ce0-f60b-4d87-bc44-adaf2a1a97a1@linuxfoundation.org>
 <CAK7LNARF=ANEEeENSwcWeayympi6Svci+ScWGpWQimyWm8xUzA@mail.gmail.com> <a4558815-f400-41c9-973d-90680ceb3ede@linuxfoundation.org>
In-Reply-To: <a4558815-f400-41c9-973d-90680ceb3ede@linuxfoundation.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 9 May 2025 08:43:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR7Mz8HgXQsiDenxydpFHdU2-Pu=wtq6CuPt9jCwtLDLg@mail.gmail.com>
X-Gm-Features: ATxdqUGcvJFpNkKPjx4dQLg6uzB7FzVYnlTTkLaD0ydKuhGbytFkqbHZ71svEic
Message-ID: <CAK7LNAR7Mz8HgXQsiDenxydpFHdU2-Pu=wtq6CuPt9jCwtLDLg@mail.gmail.com>
Subject: Re: [PATCH] um: let 'make clean' properly clean underlying SUBARCH as well
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org, 
	David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_164408_838507_4C70B667 
X-CRM114-Status: GOOD (  22.36  )
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

On Fri, May 9, 2025 at 7:14=E2=80=AFAM Shuah Khan <skhan@linuxfoundation.or=
g> wrote:
>
> On 5/7/25 17:49, Masahiro Yamada wrote:
> > On Thu, May 8, 2025 at 6:38=E2=80=AFAM Shuah Khan <skhan@linuxfoundatio=
n.org> wrote:
> >>
> >> On 5/7/25 01:49, Masahiro Yamada wrote:
> >>> Building the kernel with O=3D is affected by stale in-tree build arti=
facts.
> >>>
> >>> So, if the source tree is not clean, Kbuild displays the following:
> >>>
> >>>     $ make ARCH=3Dum O=3Dbuild defconfig
> >>>     make[1]: Entering directory '/.../linux/build'
> >>>     ***
> >>>     *** The source tree is not clean, please run 'make ARCH=3Dum mrpr=
oper'
> >>>     *** in /.../linux
> >>>     ***
> >>>     make[2]: *** [/.../linux/Makefile:673: outputmakefile] Error 1
> >>>     make[1]: *** [/.../linux/Makefile:248: __sub-make] Error 2
> >>>     make[1]: Leaving directory '/.../linux/build'
> >>>     make: *** [Makefile:248: __sub-make] Error 2
> >>>
> >>> Usually, running 'make mrproper' is sufficient for cleaning the sourc=
e
> >>> tree for out-of-tree builds.
> >>>
> >>> However, building UML generates build artifacts not only in arch/um/,
> >>> but also in the SUBARCH directory (i.e., arch/x86/). If in-tree stale
> >>> files remain under arch/x86/, Kbuild will reuse them instead of creat=
ing
> >>> new ones under the specified build directory.
> >>>
> >>> This commit makes 'make ARCH=3Dum clean' recurse into the SUBARCH dir=
ectory.
> >>>
> >>> Reported-by: Shuah Khan <skhan@linuxfoundation.org>
> >>> Closes: https://lore.kernel.org/lkml/20250502172459.14175-1-skhan@lin=
uxfoundation.org/
> >>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> >>
> >> It doesn't solve the problem. I still see arch/x86/realmode/rm/pasyms.=
h
> >> after running make ARCH=3Dum mrproper
> >
> >
> > Why not?
> >
> > This patch allows 'make ARCH=3Dum mrproper'
> > to clean up both arch/um and arch/x86/.
> >
> > It is really simple to test the behavior.
> >
> >
> > [Without this patch]
> >
> > masahiro@zoe:~/workspace/linux-kbuild(master)$ touch
> > arch/x86/realmode/rm/pasyms.h
> > masahiro@zoe:~/workspace/linux-kbuild(master)$ make ARCH=3Dum mrproper
> > masahiro@zoe:~/workspace/linux-kbuild(master)$ ls arch/x86/realmode/rm/=
pasyms.h
> > arch/x86/realmode/rm/pasyms.h
> >
> > [With this patch]
> >
> > masahiro@zoe:~/workspace/linux-kbuild(kbuild)$ touch
> > arch/x86/realmode/rm/pasyms.h
> > masahiro@zoe:~/workspace/linux-kbuild(kbuild)$ make ARCH=3Dum mrproper
> >    CLEAN   arch/x86/realmode/rm
> > masahiro@zoe:~/workspace/linux-kbuild(kbuild)$ ls arch/x86/realmode/rm/=
pasyms.h
> > ls: cannot access 'arch/x86/realmode/rm/pasyms.h': No such file or dire=
ctory
> >
>
> I ran another controlled test starting from a totally clean repo
> and the building - looks good to me.
>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
>
> thanks,
> -- Shuah
>

Applied to linux-kbuild.


--=20
Best Regards
Masahiro Yamada


Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F0B8C3ABBE
	for <linux-um@archiver.kernel.org>; Thu,  8 May 2025 08:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ow+3EqpCvuYbhqRJAc9aX8aHDpymXtE4VZzdnm2dvZE=; b=cGP0IaTr/5M58M7TXxahFaTeLt
	fCR07jOLNuNYWa/crIBhnWGJH8sXTPGLu2WxJPQVQeOvkUyWlbt/MXbn8JF0mQhaS9PuOsStQOeL4
	NskDzS/9jfeQ3J70PN0iEvO43lzpRcQ5XaUycNT8xVLKIKS3nFWsVaFCfgwsPPv+ij0h1aQ6mq2bJ
	RphyNZJszvZ+umMkIchD/xMF8FgPWqWCv2xJbCWIfOtMxG/v1oLQSR632FaAET3Jp7AQqJQK9wvgT
	mRDi74/NBPIZkz1DcYWrZny4FssjgOdzK3g9jm3EiWcaS+Se8GiqlH4cjuFhR062Ko20q+TGFVMLJ
	VXOz4FEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCwhI-00000000854-0EjU;
	Thu, 08 May 2025 08:33:40 +0000
Received: from mail-vs1-f53.google.com ([209.85.217.53])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCwRT-0000000055V-1Up5
	for linux-um@lists.infradead.org;
	Thu, 08 May 2025 08:17:20 +0000
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4c9cea30173so231555137.3
        for <linux-um@lists.infradead.org>; Thu, 08 May 2025 01:17:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746692237; x=1747297037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ow+3EqpCvuYbhqRJAc9aX8aHDpymXtE4VZzdnm2dvZE=;
        b=kzaKTfO1/tgKfqd8BBx0w/7j+Ru7cHQTgWNv/GBZit4NR0dyr/NCAKh1zTe+Dqa6Wx
         fUKtK0D9btQkdGYphRpd+Gk6ZSNnFH0IFKafJbOopietNhUSCCnYdLxx2nhxjVZ7SHi+
         Y67FZd/AZkoovldL0R66Kk9jHJpLEGBLp46CoCel4DeD0028ak7O1EjsNuPl2ynngOqD
         RE2w6gTgFbeY9M1uYdWu+EAbCAZBCP+49cS8QPsaf0ZvCRY/ewHslLapqv5bGe8MKAsn
         tCjfHh8QvugoQh/4yOkCRzyvw9s0VMsxvlw7RVHzaLE7rNnbQCxb5uf135Nc5GCwVR6a
         WvPg==
X-Forwarded-Encrypted: i=1; AJvYcCV0xEDINnbtHGYzip7uQbWge43KzOoR8iBVUOIg2D8N++pgEqgyGi0QJJ/yFC/V6wDP6X6jMzytlQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwkXjDKoZDv94gqb49blywwLr/XqYPZZHoxYYBh8+EQ3Kwho4Ny
	nAX5YzAHIxvM4Kl9mRuLOi1ocOhbxzmUaoTxqqV8hm+LzwXYs5yUS+AHy1NB
X-Gm-Gg: ASbGncuDdxr9gTud33s9njPw97kJNDiOA++b10Lp+5ZYolEZ5CBmhG+osqEDeRga6CW
	MEL76tc9gYT3rRxlxt0ZsO+nJy3DsbWxSmOFPqkU9ynVVNL7r3SmmeUQXXXLGFvblufpMnzAItf
	uLtLd8RtsFtRCkWckWf63v/2yIJFgLztnkVtV/pkI2xCXXjN3GSxPlmi846/ICtBPBemiXGLSFx
	Qauaj1l9YbYYBcf8VHFneYdYX669uy/h9cT/Kiuu1p4t4WYfds8l8D+AqtbDB+Y89qImT8vABMK
	0grm+huBpYUSTQyIiAsmwsZos3dGXMO/Z/zrpvVuBMgZhscGaGP6WJNsM40KFhAayeabeGvJDJj
	rq+4=
X-Google-Smtp-Source: AGHT+IH1lTmyzH752lqxpVcjN4eet3i99hFnVWdDrDOYuo6Wb57Um/WWDXaJcrlzxW4kKTPoXKdRWw==
X-Received: by 2002:a05:6102:2d04:b0:4db:e8f:cadf with SMTP id ada2fe7eead31-4dc73790b77mr6245044137.2.1746692237350;
        Thu, 08 May 2025 01:17:17 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8783eb34924sm968100241.33.2025.05.08.01.17.16
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 01:17:16 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4c9cea30173so231548137.3
        for <linux-um@lists.infradead.org>; Thu, 08 May 2025 01:17:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUzR/POpU97l30/dvNeKvBTAd3KKB3Wi+lw189Q6HHqrYkunywOl4HYAI5hpETGCGyAKKVoC/V4ng==@lists.infradead.org
X-Received: by 2002:a67:e9ca:0:b0:4dd:ad20:a337 with SMTP id
 ada2fe7eead31-4ddad20aba7mr1331118137.7.1746692236562; Thu, 08 May 2025
 01:17:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250507074936.486648-1-masahiroy@kernel.org> <9ec50ce0-f60b-4d87-bc44-adaf2a1a97a1@linuxfoundation.org>
 <b1e4e83c0965e10f2fe59826d19eaf131ec7aef9.camel@sipsolutions.net>
 <CAMuHMdUwE7btR+ebG8-gvPb8GPnxUGPWw3yKR4qM4Uc_mYcHhg@mail.gmail.com> <CAK7LNAT_m+R3Keyys2NpmQWRmZzHNv9FM_ALv=vn_WMzTSWhyw@mail.gmail.com>
In-Reply-To: <CAK7LNAT_m+R3Keyys2NpmQWRmZzHNv9FM_ALv=vn_WMzTSWhyw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 8 May 2025 10:17:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVuQNi02KTCKnsS6V=POsz9X=2003b+CWxwCc=23ULuYQ@mail.gmail.com>
X-Gm-Features: ATxdqUGI8nxoRV_vYCzmDMnRSJwD-zAQCeANtCnK3wswgqflfW4cB8GVMqBaQt0
Message-ID: <CAMuHMdVuQNi02KTCKnsS6V=POsz9X=2003b+CWxwCc=23ULuYQ@mail.gmail.com>
Subject: Re: [PATCH] um: let 'make clean' properly clean underlying SUBARCH as well
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Richard Weinberger <richard@nod.at>, 
	linux-um@lists.infradead.org, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_011719_394287_4F9518ED 
X-CRM114-Status: GOOD (  32.13  )
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

Hi Yamada-san,

On Thu, 8 May 2025 at 10:14, Masahiro Yamada <masahiroy@kernel.org> wrote:
> On Thu, May 8, 2025 at 4:38=E2=80=AFPM Geert Uytterhoeven <geert@linux-m6=
8k.org> wrote:
> > On Thu, 8 May 2025 at 07:29, Johannes Berg <johannes@sipsolutions.net> =
wrote:
> > > On Wed, 2025-05-07 at 15:38 -0600, Shuah Khan wrote:
> > > > My workflow:
> > > >
> > > > - Build kernel on x86_64 with CONFIG_AMD_MEM_ENCRYPT enabled
> > > >
> > > > - Check for arch/x86/realmode/rm/pasyms.h
> > > >    ls arch/x86/realmode/rm/pasyms.h
> > > >       arch/x86/realmode/rm/pasyms.h
> > > >
> > > > - make ARCH=3Dum O=3D/linux/build
> > > >
> > > >    This patch cleans the source tree, but doesn't remove
> > > >    arch/x86/realmode/rm/pasyms.h
> > > >
> > > > - ls arch/x86/realmode/rm/pasyms.h
> > > >       arch/x86/realmode/rm/pasyms.h
> > >
> > > Is that even _expected_ to work? If you have x86 built first, I'd alm=
ost
> > > expect you to have to do "make ARCH=3Dx86 mrproper" before building
> > > another ARCH. I don't see how ARCH=3Dum would know how to do a full c=
lean
> > > up of ARCH=3Dx86, unless this is somehow arch-independent?
> > >
> > > Or maybe that's not an issue with other architectures because UML is
> > > special in that it uses parts of x86?
> >
> > Probably.
> > I only use my linux-next source tree for fixing reported build issues o=
n
> > various architectures, and I never use make clean/mrproper.  Works fine=
.
> >
> > > Though I guess the patch here should make it do that, more or less, b=
ut
> > > it can't, likely because you're also switching from in-tree build to =
O=3D
> > > build?
> >
> > Yeah, mixing in-tree and out-of-tree builds causes issues.
> > Never build in-tree in a source tree you use with O=3D (except for
> > e.g. "make tags").
>
> I argue this.
>
> You can start out-of-tree builds after running 'make mrproper'
> for the architecture you want to build the kernel for.
>
> Hence, Kbuild suggests to do so when it determines
> the source tree is not clean enough.

Sorry, I meant "without mrproper" (which wipes my tags file).

> Unfortunately, "make mrproper ARCH=3Dum" did not clean the tree
> deeply enough.   Hence, this patch.

Thanks, fine!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds


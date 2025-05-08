Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BB8C3ABC0
	for <linux-um@archiver.kernel.org>; Thu,  8 May 2025 08:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EhicG+zDwTjtbgvp9ymJrsrykLr7B/xHGyK9X71DiB8=; b=3tWW2JaFBuav8gMIo9N1nH1bP8
	6eGuqFexjD2DTKxYRU2/PZ+O9DeHhokXzu2eOW+SCDBXWbb4cfanFs8k8qoFscfNT2PuATXNoiQRV
	XpWpr+iH+E1MCNh+0HJXrFFlbqLBPofBW60ilMdUynbJt8rcgSDEFQGyyigELyZghK1wVwGU+zohB
	5/7tMMAxw/2Hcbgj/6wGuL6m77sTBgBx3RMUH0jwjTj1ngJ/PDC2WJWgB8NhN+6xOETBDInBCwO6T
	axD72BIyo2nnRl27Q+MqGBV3ISwbPRON9fhSFU8P7NXIFtIbp+YfjxdJH+OK0TxPWjxWl7obgMSi2
	NIzqmm4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCwPB-000000004iE-2QHU;
	Thu, 08 May 2025 08:14:57 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCwP8-000000004hZ-1Bwe
	for linux-um@lists.infradead.org;
	Thu, 08 May 2025 08:14:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6A7314ABA3
	for <linux-um@lists.infradead.org>; Thu,  8 May 2025 08:14:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB16C4CEEE
	for <linux-um@lists.infradead.org>; Thu,  8 May 2025 08:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746692093;
	bh=a90R/RVtpbilNz7s62Jg8u91/OCcf1dJCeMzvHKzX2o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A52oFjrqemalMSdOL5Jmf+c40wj1sXuWYLl3QItkyf8Aqq/xG84ltalPNi2KEG/fq
	 ABli4aqrCKNLjztj/+3aUSi9l+2nt/WM6JzKW4nKCDdxi3YEPTXXrxPhPHVBjH68Ql
	 Ri2XOSRQxtmhtCmCLya0Hp11BXH8gJ/hZHf3u8a96PiTaJSp4JwsxXIZQkErTJ2E0g
	 Xy4LgLvC4i/ZOKRMlEdcvIRN5jBO/kNIaNBZ6DOcXfFkf7IOuSYm/K6GeoT/a8BO7T
	 aEG/E4OMKhoe3/ngc8pHwi5btrsjtQjEqJ8mkiuyn4PouIID1ct9uWjprupBP2SyG5
	 YvHfgMoFzbtNQ==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30de488cf81so6608551fa.1
        for <linux-um@lists.infradead.org>; Thu, 08 May 2025 01:14:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWuWGcaTH9FohNXgpWewzWuNKe85Yo12zR09yEn1UrW/PXynTCnHZeZkWlIcTwgHjqc9WCTRf1T+Q==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw+qerHDLfmlfLj3WZ75ssJkZMaFHxhVF/iQr8shCzj3VomtAfS
	9PPsM3S3IPffmblTq77ELy9e9HXlt+Y+oyBOYRo/D5CMU/Qbynu58wI6DwIPaPo4Qqrgu4iegIk
	nTIHadpljK1F//tAZ3nSZK1HmtrE=
X-Google-Smtp-Source: AGHT+IG5/r3K74rrgmP4jjN2TrL5tduvKzUd/NyUq1PVkJzbIiLe5Exi6qlai9lYrJkj3vGsc13NepVCII6zThmGhHQ=
X-Received: by 2002:a2e:a9ab:0:b0:31b:4770:4957 with SMTP id
 38308e7fff4ca-326ad15e61amr23735871fa.3.1746692091963; Thu, 08 May 2025
 01:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250507074936.486648-1-masahiroy@kernel.org> <9ec50ce0-f60b-4d87-bc44-adaf2a1a97a1@linuxfoundation.org>
 <b1e4e83c0965e10f2fe59826d19eaf131ec7aef9.camel@sipsolutions.net> <CAMuHMdUwE7btR+ebG8-gvPb8GPnxUGPWw3yKR4qM4Uc_mYcHhg@mail.gmail.com>
In-Reply-To: <CAMuHMdUwE7btR+ebG8-gvPb8GPnxUGPWw3yKR4qM4Uc_mYcHhg@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 8 May 2025 17:14:15 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT_m+R3Keyys2NpmQWRmZzHNv9FM_ALv=vn_WMzTSWhyw@mail.gmail.com>
X-Gm-Features: ATxdqUFvuCFG5NyS8UC8wsCetGd3jkgaQucz2-cP5mFw3Psg07oK3WaW20XowMg
Message-ID: <CAK7LNAT_m+R3Keyys2NpmQWRmZzHNv9FM_ALv=vn_WMzTSWhyw@mail.gmail.com>
Subject: Re: [PATCH] um: let 'make clean' properly clean underlying SUBARCH as well
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Richard Weinberger <richard@nod.at>, 
	linux-um@lists.infradead.org, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_011454_364182_36991590 
X-CRM114-Status: GOOD (  23.10  )
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

On Thu, May 8, 2025 at 4:38=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68k=
.org> wrote:
>
> Hi Johannes,
>
> On Thu, 8 May 2025 at 07:29, Johannes Berg <johannes@sipsolutions.net> wr=
ote:
> > On Wed, 2025-05-07 at 15:38 -0600, Shuah Khan wrote:
> > > My workflow:
> > >
> > > - Build kernel on x86_64 with CONFIG_AMD_MEM_ENCRYPT enabled
> > >
> > > - Check for arch/x86/realmode/rm/pasyms.h
> > >    ls arch/x86/realmode/rm/pasyms.h
> > >       arch/x86/realmode/rm/pasyms.h
> > >
> > > - make ARCH=3Dum O=3D/linux/build
> > >
> > >    This patch cleans the source tree, but doesn't remove
> > >    arch/x86/realmode/rm/pasyms.h
> > >
> > > - ls arch/x86/realmode/rm/pasyms.h
> > >       arch/x86/realmode/rm/pasyms.h
> >
> > Is that even _expected_ to work? If you have x86 built first, I'd almos=
t
> > expect you to have to do "make ARCH=3Dx86 mrproper" before building
> > another ARCH. I don't see how ARCH=3Dum would know how to do a full cle=
an
> > up of ARCH=3Dx86, unless this is somehow arch-independent?
> >
> > Or maybe that's not an issue with other architectures because UML is
> > special in that it uses parts of x86?
>
> Probably.
> I only use my linux-next source tree for fixing reported build issues on
> various architectures, and I never use make clean/mrproper.  Works fine.
>
> > Though I guess the patch here should make it do that, more or less, but
> > it can't, likely because you're also switching from in-tree build to O=
=3D
> > build?
>
> Yeah, mixing in-tree and out-of-tree builds causes issues.
> Never build in-tree in a source tree you use with O=3D (except for
> e.g. "make tags").
>

I argue this.

You can start out-of-tree builds after running 'make mrproper'
for the architecture you want to build the kernel for.

Hence, Kbuild suggests to do so when it determines
the source tree is not clean enough.

Unfortunately, "make mrproper ARCH=3Dum" did not clean the tree
deeply enough.   Hence, this patch.


--=20
Best Regards
Masahiro Yamada


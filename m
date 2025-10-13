Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED146CCD183
	for <linux-um@archiver.kernel.org>; Mon, 13 Oct 2025 20:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wzOImIU5Sg7fPH463qpRABsX+1TIC1s/D4sg5cVRqTo=; b=0+9vF4Mx3Fqe4JKDL53/ckMD0z
	z89kkt0/mX6XI6hbFSbVIr9sPfabDp6N52U3LYk/e0y7p/nwUGyHrFg+k+VJWmYC9DqWncBBCTsBN
	8hn+KbiX8GEt8fC4OwBiVpGk6Iqi6YHjYcxGeuapoVRQxSadSAuHBZduOD3PBSINMzoz4iBYAoiUa
	RTu/pjHtkEkYt6oxhHSAvOUTefGON0AreW/mURTestqVDgF/Mi+AMmH8InJh4gv/2brqCgQB+jb1/
	H36NKb0WlcfVOodxduEUu2SoNfKm+hXh2nGjeQOPGCDtxC8mBjzhwFET2e3y4V6T8shBWaOzbaHFz
	K1CcjrVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8PDr-0000000ENEm-2K6m;
	Mon, 13 Oct 2025 20:32:47 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8PDo-0000000ENAu-3iY5
	for linux-um@lists.infradead.org;
	Mon, 13 Oct 2025 20:32:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 522AA48BAF
	for <linux-um@lists.infradead.org>; Mon, 13 Oct 2025 20:32:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2610FC19425
	for <linux-um@lists.infradead.org>; Mon, 13 Oct 2025 20:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760387564;
	bh=EQamDqz1jKPoQmI1VU+7+EDF4P83/GJiuJy793deQ/E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=a0TGhUDGi+/iEdmyQcN7ciepwiJneRt84J2Q47Mg0Hfd4qYoV0nDT/VW7h0s2ry3Z
	 UVV00W9Ei/GJlG+rdKc6ZlPYFwTl+/bCLj16ev+4AU8/JDhlDu/JcXQTbJYciVtIBJ
	 cO3woUFa3/jybo72rgiF1rduIh3xpL/lHTEG4r7c4Fp9eLly+DErNgLe+27VBIJc1s
	 zdn8viiPJ1iye98izFeQmaI6k6oIq38bCfMoNBM+78rD+g+zSlHLdR0LScRisdtrZs
	 Paxcu7Y/ygZr5dqIHFp51TS2CjZ9WkewPvGMZvbHxkAdueG+YfnDLKCxr2gIievjdV
	 W25v0hLI2v1eg==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-57b8fc6097fso1604904e87.1
        for <linux-um@lists.infradead.org>; Mon, 13 Oct 2025 13:32:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWBMwfxr6OryCQwjDKBAkAYmZmOa35Mjj7QRIgiaj0+S9rvarSfkQKtMyKPG/cuAdf1V4CZWf9MiQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyQpVVXCzLf4q+oZi9mKbgUiCT0ZEQcxo3i3mNo2J/oVqEK2btK
	vffwc0Fr0KfiFYsTeJf2U647Vqc0xeYxmmyIwmTs5+ovKuVNYoXl+CQQNm4Dfp4Up92ji6KnIRM
	3Da91vtJosgKF9AmzE72RcmMUgEwn85FH+KWoyXu7
X-Google-Smtp-Source: AGHT+IFm/qhJPRKGc+a+TWhUwJHmseKnmX3UsC7EjJHnIC1kG1AUHBMR9nLxzbY5e9K0EIzQFCLgbzgnfLD4YXcOdbY=
X-Received: by 2002:a05:6512:3045:b0:58b:23e:253 with SMTP id
 2adb3069b0e04-5906db04028mr6538684e87.7.1760387562236; Mon, 13 Oct 2025
 13:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20251013-getcpu_cache-v2-1-880fbfa3b7cc@linutronix.de>
 <e95dc212-6fd3-43e3-aeb7-bf55917e0cd4@intel.com> <CALCETrV2W3cZEJ2yy7F-F9=e_8HLP84ZWrOJCzUYn_ASb0+M6A@mail.gmail.com>
 <494caf29-8755-4bc6-a2c3-b9d0b3e9b78d@zytor.com>
In-Reply-To: <494caf29-8755-4bc6-a2c3-b9d0b3e9b78d@zytor.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 13 Oct 2025 13:32:30 -0700
X-Gmail-Original-Message-ID: <CALCETrVuW_MmksnkprK5Ljm-5RBSS=FUA8R8fgGMhZ3BxW15Sw@mail.gmail.com>
X-Gm-Features: AS18NWDkjUWHXDVipeI6h9oFzsXdlHdU2eK-6BrfttbpUi-mL82DSNY6ulu9J34
Message-ID: <CALCETrVuW_MmksnkprK5Ljm-5RBSS=FUA8R8fgGMhZ3BxW15Sw@mail.gmail.com>
Subject: Re: [PATCH v2] vdso: Remove struct getcpu_cache
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@intel.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Shuah Khan <shuah@kernel.org>, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, 
	linux-api@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251013_133244_966541_EF7DE912 
X-CRM114-Status: GOOD (  14.34  )
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

On Mon, Oct 13, 2025 at 12:45=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wro=
te:
>
> On 2025-10-13 10:14, Andy Lutomirski wrote:
> >
> > I don't actually remember whether the kernel ever used this.  It's
> > possible that there are ancient kernels where passing a wild, non-null
> > pointer would blow up.  But it's certainly safe to pass null, and it's
> > certainly safe for the kernel to ignore the parameter.
> >
>
> One could imagine an architecture which would have to execute an actual s=
ystem
> call wanting to use this, but on x86 it is pointless -- even the LSL tric=
k is
> much faster than a system call, and once you account for whatever hassle =
you
> would have to deal with do make the cache make sense (probably having a g=
lobal
> generation number and/or a timestamp to expire it) it well and truly make=
s no
> sense.

The global timestamp would just be some field in the vvar area, which
we have plenty of anyway.

But I agree, accelerating getcpu is pointless.  In any case, anything
that historically thought it really really wanted accelerated getcpu
can, and probably does, use rseq these days.

--Andy


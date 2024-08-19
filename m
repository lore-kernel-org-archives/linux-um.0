Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D20C52D7C
	for <linux-um@archiver.kernel.org>; Mon, 19 Aug 2024 18:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y51dIf6Nc9jS2PsiVafQefSFQO48+Q7aOrp7xHNd1WU=; b=BIrseW6ZzvV/74kvmmxn1u9QYj
	qkQ/vX19eQ68i9pHRa0IsxM9y+CGA2wblmZNqbQEjou3qvhJzPpYtUsMvukLKImbmfLSaBCt11fYS
	D4PKnvakOvNm/vtXoeM3XF3zZaF4JWurIzL/I4Gt2dv8tdNOcUmmb+BHxTgVLKl1LrH5xd0UiNmPw
	fKU7/mL/CAiE8/WWJuxIUkmWI0u7yWkLWuey3SKjKvq3kHeL5f27CbhuxHcnMwJ2KE6rH96f1uzo7
	uExcSFT+cGCG/gV1swHm2aVBbAUtkWgm0vPhRrmncfyGxHkEIo+5J6wEBd0JUc+LfCSvLWjIM8wcj
	6Je6zvdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg7P2-00000002eC3-3JvT;
	Mon, 19 Aug 2024 18:46:52 +0000
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg7Oz-00000002eB3-2LHI
	for linux-um@lists.infradead.org;
	Mon, 19 Aug 2024 18:46:50 +0000
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5bebc830406so1475a12.0
        for <linux-um@lists.infradead.org>; Mon, 19 Aug 2024 11:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724093207; x=1724698007; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y51dIf6Nc9jS2PsiVafQefSFQO48+Q7aOrp7xHNd1WU=;
        b=okZdE1myiGr3/sSt3HzcKQ5/gg4MxaS6JikGYhha03c/3G/Q8Wwmg4ORIpKHh7+A4F
         cm4sJgyc9D7Ztumv3shkZtgnxgzUiqS1KGFksrvAyYFba/FmWCeFwFR9039CH1qWaq0Q
         Sn/5gWRhbfd5Zqx0/xdl++9rJEZfTZRcNXFGEkBRJd2D637e9A3+eScBGISoHbaGay1S
         har54+5yGCptZvsPvwkhthWC0pyYhPtzj4Vv+7SjTMqLzzvc4dNwbw7lgCsK4UYmzcaj
         NZNJBngFOrHj7tqB4xm7ciWtvD1ERC/55sHv4aIEQdnIym8Q5ZzIbcrQiELCSaR0ARY+
         d3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724093207; x=1724698007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y51dIf6Nc9jS2PsiVafQefSFQO48+Q7aOrp7xHNd1WU=;
        b=eJGZbd5zA22LCO0/s45gOjGrzunTd4b41EO+3uNIM/oBimpQMFomg+kDUYwdwUFAer
         JGrYmKDW5pX+rR4Kivz3A47w6IeE0h0afVvAg9t++hDr6wny+rzqAKq74+L5ixZCNNSQ
         0U+Llc9aP3uHjRuByY90o5DbHt2Jx8252pgJk2zlcoIfRssqEJPWdhRgckEUE96t2bGf
         AiMldiAvZeN9GZ/Fiyrpu0NxEp4uUpeT6uZTHAGzs7ElUfvOVY53xEdR5/ajcXqLYDk3
         JQnwzbaXSDb6KpfI11cR3WukBoA57SC+XtwtgTrcznx4HMdGAP04r2aFCi9NM1TsCJik
         S0sg==
X-Forwarded-Encrypted: i=1; AJvYcCXNBnCWy6nTlDUm7aQQZW7Ogcke5bGUG8CMAHc77znT+rVvT4cqOxzrrbkF6SvcuTtcpcLRY44qFQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxzkTFMOD7y9ETh/y6bZQV0aFNZh0nOgfduqIqEJLFs9SM6Ly/w
	iRxCyhQohCuSHWE3EHZXaTCs8ZFsBMkSYqpT+3QdhQqETkG1dNpHbz93oW3AmeLks6VfjtPvO4c
	+BD0E9Qc35iXwGWqUnaskLMEM4I4I3naUkahL
X-Google-Smtp-Source: AGHT+IHGyrw4ppuXQs+Ix4XJjG6GmLafWxNKCsWLnSoyTNB7TwMvjAoIf2VSsRB+F0laxTLGBLorjke5egWsMJdRpF4=
X-Received: by 2002:a05:6402:26c4:b0:5be:c28a:97cf with SMTP id
 4fb4d7f45d1cf-5bf0c5cf9bfmr6774a12.5.1724093206617; Mon, 19 Aug 2024 11:46:46
 -0700 (PDT)
MIME-Version: 1.0
References: <20240813234755.3615697-1-maze@google.com> <efbb6394805f11de27cace9817418744d8e69506.camel@sipsolutions.net>
In-Reply-To: <efbb6394805f11de27cace9817418744d8e69506.camel@sipsolutions.net>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Mon, 19 Aug 2024 11:46:31 -0700
Message-ID: <CANP3RGdxrKHsERYG+yW5fpRUrahkBJbHCKD24v182ZNKuJgfwg@mail.gmail.com>
Subject: Re: [PATCH] um: make personality(PER_LINUX32) work on x86_64
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240819_114649_617126_C038A0E9 
X-CRM114-Status: GOOD (  13.35  )
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

On Mon, Aug 19, 2024 at 5:23=E2=80=AFAM Johannes Berg <johannes@sipsolution=
s.net> wrote:
>
> On Tue, 2024-08-13 at 16:47 -0700, Maciej =C5=BBenczykowski wrote:
> > Without this patch:
> >   #!/usr/bin/python3
> >   import ctypes
> >   import os
> >   personality =3D ctypes.CDLL(None).personality
> >   personality.restype =3D ctypes.c_int
> >   personality.argtypes =3D [ctypes.c_ulong]
> >   PER_LINUX32=3D8
> >   personality(PER_LINUX32)
> >   print(os.uname().machine)
> > returns:
> >   x86_64
> > instead of the desired:
> >   i686
> >
>
> But ... why should it work? UML has no 32-bit compat support anyway.

Well, that's certainly a fair point.
On 'native' x86_64 this works even for 64-bit processes though.
I wonder if that, in itself, is a feature or a bug...

In my case I was writing some debug code (to print the environment
some test code is running in, since I think it was failing due to
running 32-bit code in PER_LINUX32 on 64-bit arm) and testing (the
test code) on x86_64 UML.  I was surprised to discover the difference
in UML vs my host desktop.

> johannes

--
Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google


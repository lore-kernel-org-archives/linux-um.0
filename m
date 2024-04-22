Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE193C4345F
	for <linux-um@archiver.kernel.org>; Mon, 22 Apr 2024 20:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zNWuH8R4KlmVwCmfi87OiHprzOdNZb+4awWRJihIuP4=; b=MOOXk5nAU01UroTcVETB/J5oDa
	IPFWwFymGPFSEpPOlEeUPRlJAyfN6yNE07TU4JcbyZn+W9ufMRQJnPzA7CVD8cQddBBT+/c1itceL
	K3kWor76+5izR2Gx+n3sJzvgSkiIV3z1bHG7jJ7wtzFbMUC11sN+g0AFrnPHCVvqgaHcHxao43skW
	UHFPvxXC+GyvnQ/OF7qKXelNtTsN4Tw+sJ9lhyTjZxiYqK9ZQrHNLo4tO+qopKIYqIxK1ZzgerJcR
	Bis0gM+uEi4kHwkel5AKDK7jQwgDi+fznuYLDENn8Vk0NXgNYTHiWun/Lbl2aEMMjGHPAD+/Ati1C
	QVtGRwtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rz08N-0000000ExjT-1waC;
	Mon, 22 Apr 2024 20:19:27 +0000
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rz08K-0000000ExgX-2jG3
	for linux-um@lists.infradead.org;
	Mon, 22 Apr 2024 20:19:26 +0000
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-dbed179f0faso3958646276.1
        for <linux-um@lists.infradead.org>; Mon, 22 Apr 2024 13:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713817159; x=1714421959; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNWuH8R4KlmVwCmfi87OiHprzOdNZb+4awWRJihIuP4=;
        b=h6N6OU051yHAE6Vl4IUS83uSM1Zcu5GY8DiwjYJcEnvAx0YVHk0YL5tifYdT2H2mXc
         mq0lZKlBANn21ss1exH3z07gImvqINy9t02PO613PB4xzS1VFzU+karLrFj5vdaIbi+Z
         JMBkx8v0aaKz2fjzpdzil0Lp/QsIk/P61S9W1g/Wj1nuhP40FEWE/KVZ2TozshShFQCS
         UyBQsWDYVPPm5g8LCkkAJv0g97BZIbnRIq+/GZhc/LSDga61FBvyqumDGOxAFRTJMJ+W
         Hxv4IclBE0APF+7pdhOgSX9kjW9AAM/5XALmOi1Kadi7Kh6nnxNaofnZu0eZ58fqbP2H
         TW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713817159; x=1714421959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNWuH8R4KlmVwCmfi87OiHprzOdNZb+4awWRJihIuP4=;
        b=QtdQKER3B4TzMxmHN/DTlMb9ZOT+C3aN5YWC03rDLc0ZXS9R7BWZEAckLSdDae+e4H
         XmyCW4yHbzmqHL1H/sGzYAMSJT5cxAd1uq9wAZRVpn9gStQz1v8M9Wh2Qh0DxJuDDsyG
         eeQMWny7YqPJCWmXkj+qLv6hUD61y68NzBzf8Vo85952+MOMWoTDwL4dB8za2/dsO0lm
         NZZ2qMg0z5PP+4ChYJowx4hUYKEMCiq7WngVrQAB5rFVLNsYgM4qZR5kh76idVKfY+Ub
         7ZsXyu4TAmL54F5639zlqEHe90Di7EihibHg2uM34NQDN6Vrm8K/wH6dq3EYHQ2JFjkZ
         YhPA==
X-Forwarded-Encrypted: i=1; AJvYcCUbzEdoVvclZZhvFSpDn3YTOmNYHS3GEXY1AF/hmAAtEd7ImfGh51krNnAnKb+7k4Zc44DN1g2kw4BS8Gn3sdFfsNJKiL31C/cTKVgc
X-Gm-Message-State: AOJu0YwOiHJW+4b9tVsRON0xjsZg/t9PT4h49XoSLfwUcGtdkJpRV0Pb
	5bJCs1MxHQMyMM7QCAvck2aIfnon18IOxjiuMeDRCAHBYMBOO8PTljAyg6c5ut/YuE+vGhbD95j
	MIxULyat2TwAt/F71r/0Ys2TyEGJwdVAieZMg
X-Google-Smtp-Source: AGHT+IFDf/KV08uUrm9iSVoHnb88dMjYX5diuW8U2bZNhzrCeCsD/JyIMFVC8xCr1jkbtwis9euVnDQlC8QaQtgXjxA=
X-Received: by 2002:a25:8691:0:b0:de4:5c34:b8d6 with SMTP id
 z17-20020a258691000000b00de45c34b8d6mr719194ybk.8.1713817158654; Mon, 22 Apr
 2024 13:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240326073750.726636-1-surenb@google.com> <95819052.15033.1713816660761.JavaMail.zimbra@nod.at>
In-Reply-To: <95819052.15033.1713816660761.JavaMail.zimbra@nod.at>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 22 Apr 2024 13:19:05 -0700
Message-ID: <CAJuCfpHnM6L-7s8cd90XKiawhw9LZaRfMfeDm54OshLQdV5YmA@mail.gmail.com>
Subject: Re: [PATCH 1/1] arch/um: fix forward declaration for vmalloc
To: Richard Weinberger <richard@nod.at>
Cc: Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	kent overstreet <kent.overstreet@linux.dev>, SeongJae Park <sj@kernel.org>, 
	anton ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-mm <linux-mm@kvack.org>, linux-um <linux-um@lists.infradead.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240422_131924_709682_74713F8E 
X-CRM114-Status: GOOD (  16.78  )
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

On Mon, Apr 22, 2024 at 1:11=E2=80=AFPM Richard Weinberger <richard@nod.at>=
 wrote:
>
> ----- Urspr=C3=BCngliche Mail -----
> > Von: "Suren Baghdasaryan" <surenb@google.com>
> > Betreff: [PATCH 1/1] arch/um: fix forward declaration for vmalloc
>
> > Patch [1] replaced vmalloc() function with a new definition but it did
> > not adjust the forward declaration used in UML architecture. Change it
> > to act as before.
> > Note that this prevents the vmalloc() allocations in __wrap_malloc()
> > from being accounted. If accounting here is critical, we will have
> > to remove this forward declaration and include vmalloc.h, however
> > that would pull in more dependencies and would require introducing more
> > architecture-specific headers, like asm/bug.h, asm/rwonce.h, etc.
> > This is likely the reason why this forward declaration was introduced
> > in the first place.
> >
> > [1] https://lore.kernel.org/all/20240321163705.3067592-31-surenb@google=
.com/
> >
> > Fixes: 576477564ede ("mm: vmalloc: enable memory allocation profiling")
>
> This commit id is not in Linus tree.
> Do I miss something?

It's in mm-unstable under dc26c7e79daf2fc11169b23c150862f0e878ee5a. I
think it just didn't reach Linus' tree yet.

>
> Thanks,
> //richard


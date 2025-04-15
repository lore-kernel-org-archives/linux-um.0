Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2CBC369AB
	for <linux-um@archiver.kernel.org>; Tue, 15 Apr 2025 21:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nHLGknYMoOLs5ngthTi5stcyq/0FFXNP8IkshpzhnfI=; b=KAv29kFw3QalMXJ1dUxV+q7e/3
	zNt0hn926xI3uR0oodO25GO9dD8vFxSJM869ES4B6aIocCnvCLYqm0vL/czfvfpzGnccoC+6xrXMF
	N6kQnygIU66iZfGjNWsfSqgUnVReEmo31V/xfZOmGTqpTkKETdTDdQyTmjyyiEJ2pJDk3djw5bY3c
	6JF1COyNhXSTm8YtERRbyC9qw8+O48+x8zfpgzDwu/QQW4d1LyYlNpeiw9nEkcJKeFP8Ixo6jmEeg
	RWOgbM03sKV+wpKVPXIyot6m4M1NivLbCBGXXAByL6J1ms4EPxYrcCFGq6ysXj36XTyNWECSSbYjQ
	H8QyJcaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4nar-000000079N5-0A7g;
	Tue, 15 Apr 2025 21:13:21 +0000
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4nao-000000079LU-047J
	for linux-um@lists.infradead.org;
	Tue, 15 Apr 2025 21:13:19 +0000
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-3054e2d13a7so1203640a91.2
        for <linux-um@lists.infradead.org>; Tue, 15 Apr 2025 14:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744751597; x=1745356397; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHLGknYMoOLs5ngthTi5stcyq/0FFXNP8IkshpzhnfI=;
        b=ejAxMs54UByNk7bIhX3767owzTi6m9Kf9d6stxSF+5HxoaKrh+s3f0yss4unh5ThwU
         YygnIFxnwOMSdZBHnB9Su5YLpsUqATHjK9AXG1GQqOFXwswX0hr6ajN9+20lfEgAtW1X
         cGqhXxaabF7d99PD+8R6LIflHsDNfn3vQDzVrfJtaOEC5i2cXX2TbrJkHby7+IAusTHz
         YfLyVkZhLQ52ZB0F6FoA0TF+HUEYG6bpKG6NH8hYSQpopfxwNgL6QcEKYXBZibyivjG0
         rVhyIyirCRXAQMAuAcL7RtDtMIhRSyG72GY1qDmqGhB7uLTAoW1N1JGIb6asgs/UAqlV
         zxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744751597; x=1745356397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nHLGknYMoOLs5ngthTi5stcyq/0FFXNP8IkshpzhnfI=;
        b=Ay5GeggGIdKewbgIl7pT8OSk/U4aKM6EmfooOdZJToOXFwF0yjrFwGDE61Peni86H8
         vB9+3A43g3FDQ5RASt7LeBirXjorZyJis8n4yEgXbS0LaBmo44M9HXVaYrikXHtIioqn
         4iKKBDOOHM80S2CXpdnI2R74sCoiH6+W5afILc0HbLwjJ5dBzbZJYfwgkr2hGZH5O+dX
         iDemFlo0eb4kz3EnaoObuqN3tFo7FTUPxEqCpBP7edXQYkAzRKJqYWOvjo5h1TuJIXny
         jGDEfu/VQg31JvK/q+IICj6F5ZEBzxAMfFuaWcKLradt2jl9EsGOltf76a0sPWgKxqxk
         9YPw==
X-Forwarded-Encrypted: i=1; AJvYcCWsDiZ3SkszUfEfjchN4zecvcWZ/vL7aS2ugJGdNTPHJkoUJ/eDVLrJ6oAwFAxP6GQndSXjO06HmQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz6ASvFt4abE1ZX8p/65/5Yj+wyzRwQ/NtxsiRDsfhUBAIfjKcX
	SA3IWt/wA+OF5o7sXUrD3seY54HXeXdYIrf+YD2QzlkHFUPIR9pIss4qGi6ec10BZNnvNuNOS2m
	zd6c0KHW669oymhyM+5KPuWiOYOU=
X-Gm-Gg: ASbGncsXkrkmHrCB/Px61d5Vi1t/Cu3xPi4IuO1NGmA4bviXlKPr3Wx59MVx3R2bq/N
	BXI/EIQaHplEGE9/ZoWP2Ajolbrk3QcnYTg/jyrTrPO8/HV+JrPZVGbULuSnNos6dMUnKJqrr3t
	3OGHzi0lyaLX288yhIbIa62LRNXMTDKs8f
X-Google-Smtp-Source: AGHT+IHM90piV4cTZFw7grUOXr4mCxJOuor423t5Vo/nYWbEHHrVHgW/kAzavfD3IYP+p75tnCKOJBCIaksLgjjYodw=
X-Received: by 2002:a17:90b:3b4b:b0:2fe:8fa0:e7a1 with SMTP id
 98e67ed59e1d1-3085ee80932mr368927a91.2.1744751596912; Tue, 15 Apr 2025
 14:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250412005341.157150-1-fujita.tomonori@gmail.com> <CANiq72kKhkVRAmg26DNG=Q8-s_+zkz8jVe5MZa__9RPjRs7f6A@mail.gmail.com>
In-Reply-To: <CANiq72kKhkVRAmg26DNG=Q8-s_+zkz8jVe5MZa__9RPjRs7f6A@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 15 Apr 2025 23:13:04 +0200
X-Gm-Features: ATxdqUE5FuiSo7mFKLS40NR5DavlskBpVFqdZjGjAtUfDvnKXNnrJ8TyXzkhVJc
Message-ID: <CANiq72m5uoCnhYR=8eHZ12O+D=A+sChAj7ZNTU8vcCTpAhayog@mail.gmail.com>
Subject: Re: [PATCH v2] rust: helpers: Remove volatile qualifier from io helpers
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org, richard@nod.at, anton.ivanov@cambridgegreys.com, 
	johannes@sipsolutions.net, geert@linux-m68k.org, logang@deltatee.com, 
	sbates@raithlin.com, dakr@kernel.org, dinguyen@kernel.org, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_141318_052683_6055D9EC 
X-CRM114-Status: GOOD (  11.39  )
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

On Tue, Apr 15, 2025 at 9:14=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Applied to `rust-fixes` -- thanks everyone!
>
>     [ Reworded for relative paths. - Miguel ]

Also:

    [ Arnd explains [1] that removing the qualifier is the way forward
      (thanks!):

        Rihgt, I tried this last week when it came up first, removing the
        'volatile' annotations in the asm-generic/io.h header and then
        all the ones that caused build regressions on arm/arm64/x86
        randconfig and allmodconfig builds.  This patch is a little
        longer than my original version as I did run into a few
        regressions later.

        As far as I can tell, none of these volatile annotations have
        any actual effect, and most of them date back to ancient kernels
        where this may have been required.

        Leaving it out of the rust interface is clearly the right way,
        and it shouldn't be too hard to upstream the changes below
        when we need to, but I also don't see any priority to send these.
        If anyone wants to help out, I can send them the whole patch.

      I created an issue [2] in case someone wants to help. - Miguel ]

Cheers,
Miguel


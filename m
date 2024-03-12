Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AAB3C54E5D
	for <linux-um@archiver.kernel.org>; Tue, 12 Mar 2024 14:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4YdHy//nTWN9K6sgwTweLyEZnjTzGOH6tr4kEOlMF6A=; b=On8ytysYk+rG1OYKMvA6YPVTUf
	K/stl7yrZAuBujHgxdiICLp5GWCKaTK5vLK0n0uipOkoKOsk7jLuVcuaIxDjow2/RIhbmIENWv7O+
	5cUan8+A6ztaG5WjgnM04OSLVRu5XhpM7IEKYznhxuXWgR9n++rnaLfByN1Q/qNHcPms5zn0QVbNM
	uvFgkvPZ/mzaeBYkgk2YDuejB5SmcpV9xZDYbYfOPF7EtcqsRUV4aX7N44BYw5dUWX2Y2UrJDLcj5
	OfzJG8xYBgZImEBRdS8FFRSC9+uV35f2aGHSEJ9T3eWAMUocx2rlrR0eM5Q4/OA6ftlrT0Yi45MMM
	j3AJ7p2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk3UW-00000006Ez8-1pkb;
	Tue, 12 Mar 2024 14:52:32 +0000
Received: from mail-yw1-f177.google.com ([209.85.128.177])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk3UT-00000006Ewv-28S6;
	Tue, 12 Mar 2024 14:52:30 +0000
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-60a068e26d8so46177027b3.3;
        Tue, 12 Mar 2024 07:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710255147; x=1710859947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4YdHy//nTWN9K6sgwTweLyEZnjTzGOH6tr4kEOlMF6A=;
        b=o6Y5ybfZF8eeaeXsO+jXurZuXH9nifMUrWWdwi6YA/NAPilkO/L6SrAYa306z5O4tH
         LPhblXaSdUWIeJIhaVWe5zguo7Ci1qjSDbW0QgS7Ikr7OVWyIjSfpmUMVcjoBEYRj1Uv
         qg/7Om7YL/J6h3BdEqOnng7C2aATc7soyM0hdA3QDIX3rOg88MFeIrcPadlBk25QzcG5
         SV0E6D5QwJTSgqDfG5vpzKOIYFcRYUfJFFd3JpdlEt4Njo4UnOkSzkXfXr90V+dO52Ii
         3pT3rfHZDwHnUHSIKWDgpytt3fkjRiD7nEC7UUCW79McbbBxr2PZZ1bG22JcTTMSMV28
         Xw5A==
X-Forwarded-Encrypted: i=1; AJvYcCWTuMJHHR3rOHspMpKhMrkwj0Uugo1EQDWkccImr+E25QQfMtWALFzuSJZ3FzsJnwKRB5xhpGIQPcXvCQoWJidNHiikVzHIsDCuyV0f1s5JfYNF6vDhN8aSDBRm81rK4ryusfHjwkTDMkBDXC9zd844F1k=
X-Gm-Message-State: AOJu0YzXLOCXELPKDysXHihLbzxoAg+qvZu5Uf//8kG5KY036fhBSauI
	RdB4cM6ayHPHqJk59ek98IHoWflMPvRjWnI824FJpX6lOZpqZhQVCdE6Aohs3ZE=
X-Google-Smtp-Source: AGHT+IEwOra9rFfXZQCfL7YlVT1OXeusZYY8w/HmLoFO0JGvA0mmMUqTBm3Kxf/jsYuwbrz129XwYA==
X-Received: by 2002:a81:c311:0:b0:609:fff2:3bbc with SMTP id r17-20020a81c311000000b00609fff23bbcmr8648743ywk.49.1710255147275;
        Tue, 12 Mar 2024 07:52:27 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id p195-20020a0de6cc000000b0060a08edc81dsm1962884ywe.4.2024.03.12.07.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 07:52:26 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcc80d6006aso4126780276.0;
        Tue, 12 Mar 2024 07:52:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVWDialz3aU2wUZBFJQCVPTMg+9GD3HX4ECpRCI5elxbcpf/6D7gA9HEUZxPG7p8CYMCm3N5JC3uouMiA8D3kACslA1r97oak4piCRjTgyvxgizPkOYniQ1AkygGjAzMt4294T2KxYFvboZpM+ogmgjz0U=
X-Received: by 2002:a25:26cd:0:b0:dcd:ef35:91d5 with SMTP id
 m196-20020a2526cd000000b00dcdef3591d5mr6727921ybm.2.1710255146517; Tue, 12
 Mar 2024 07:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240217060843.GA16460@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <CAL_Jsq+Feu9NnzTNx=XU5vgHhibGAQXvkuTeWbpu8gJ3rVrzcw@mail.gmail.com> <CAMuHMdUKa-KdWfYswEpFvj3RjQPM+ThhU85myfBGVkXxZqbHWw@mail.gmail.com>
In-Reply-To: <CAMuHMdUKa-KdWfYswEpFvj3RjQPM+ThhU85myfBGVkXxZqbHWw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 12 Mar 2024 15:52:14 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU83qwmO5swSQq79Zci7SP_xkNsjmQ4dYo-Pjw8d65fmg@mail.gmail.com>
Message-ID: <CAMuHMdU83qwmO5swSQq79Zci7SP_xkNsjmQ4dYo-Pjw8d65fmg@mail.gmail.com>
Subject: Re: [PATCH 2/7] of: Create of_root if no dtb provided by firmware
To: Rob Herring <robh+dt@kernel.org>
Cc: Saurabh Singh Sengar <ssengar@linux.microsoft.com>, Frank Rowand <frowand.list@gmail.com>, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	"Gabriel L. Somlo" <gsomlo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240312_075229_576439_29D259F7 
X-CRM114-Status: GOOD (  20.99  )
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

On Tue, Mar 12, 2024 at 3:41=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> On Wed, Feb 21, 2024 at 3:06=E2=80=AFPM Rob Herring <robh+dt@kernel.org> =
wrote:
> > On Fri, Feb 16, 2024 at 11:08=E2=80=AFPM Saurabh Singh Sengar
> > <ssengar@linux.microsoft.com> wrote:
> > > This adds the strict check for compatible which makes compatible
> > > to be mandatory for root nodes. So far, DeviceTree without compatible
> > > property in root nodes can work. Do we want to make this documented
> > > somewhere ?
> >
> > It already is in the DT spec and schemas.
>
> How many systems in the wild violate this?
>
> Apparently the DTS generated by LiteX does not have a root compatible
> (and model) property, hence of_have_populated_dt() returns false.
> While my gateware and DTS is quite old, a quick look at recent
> litex_json2dts_linux.py history shows this is still true for current Lite=
X.

https://github.com/enjoy-digital/litex/issues/1905

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


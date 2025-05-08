Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CF4C3ABC0
	for <linux-um@archiver.kernel.org>; Thu,  8 May 2025 07:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8TdWX9BvnLKIzglHQcO1riqJBcVy449ZX9JhxrNyGJc=; b=bIvUxDBjzJL/rKnyNwUROYqYgM
	lNJxKBnWyEvCfIrT7mR10z2DMHv7SxZDfFMGAhpRNGHUXNss3PdPHBZa8fqYs0Fm9JJtKKdpBdUDK
	MRIXL5fbWcnDYA58YZo4hkd2/SI09Pcs5Gxq2kqw23jARtFJUWvx1HnFSXfN0dVkAE4xswVqEvhbP
	XkuNzeT7BcWqr9Gy5BT7GKHUiOia4H5LrmubZdX41wHh1WxLe4ay/wBdrxJ9ibK4KIXziFOgO3tHQ
	HWClss0tUQp/GtGrElNic9yOprF+Xc8Zb9r0I05vem2m6QxN4Un8RJmB0zlMuVaCeo5Pqn7jlhMaO
	T0jJPa0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCvsa-000000001cs-3yHq;
	Thu, 08 May 2025 07:41:16 +0000
Received: from mail-vk1-f172.google.com ([209.85.221.172])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCvq6-000000001HN-3Aey
	for linux-um@lists.infradead.org;
	Thu, 08 May 2025 07:38:43 +0000
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-52403e39a23so453610e0c.2
        for <linux-um@lists.infradead.org>; Thu, 08 May 2025 00:38:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746689920; x=1747294720;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8TdWX9BvnLKIzglHQcO1riqJBcVy449ZX9JhxrNyGJc=;
        b=hUrxtMp6F2H1fJUlqgFmoAYkWjsSbrHqBbOPwHG4R41Ia3JCH5RjLyGBjjpqVKspnN
         IdYRNPS1sh1yazqbjtBYX2NjYLMpenCPqMDtuZsqxNPWBCT7NrTH04b4EHMZUXTGMYuS
         sjVGwnWoWB41z6d/bvjlsng+60GUWzuPEeilmKU93hDdd3scyCYackJGpzRrR/WMHfsQ
         0bBrPLoJvwU0ca+RGZpzvSlIGXZs66kl47y8I7/n7WMOw2hHmnHc7El47vwYMJPxjX7L
         Jj+I2hXUGrP20j50nOzr27k9wTfn5TB5V9Ut9kXpAIVX4fCMELvYdfLQspUHpqWtBOuj
         HvRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUM/weVxDznSyW1oN4NA353sKx8LM+/GgSiqktRi78mwP5/0hx51s+k6xbi5TSsO30IAB5YaFY3vw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwsjxA/72EzDt7sRVMgzWHUKrqAR+wZLbR/sbfzpmtWc8nwEXRo
	McC962duxVqyXdjGilYUwfZ5uIdoapIIBlkzdjvq9QSmeJ1cjct1/aP6z8R0
X-Gm-Gg: ASbGnct6H2knAIaEDkJAMyySVcSozKVxEdos+oYXRKfzowjIJm2gCUtSqovT/olq1HD
	Rcronu8zBi4tOvNiKZd7nq+IcnIUW/cREBdzCJOPfi1bkNJsatHaSdndNguMDvNYyWVDyqty/7G
	5Dl0gl4VnHNl7BvRIYcizKMiyVnIzRTNWXa8UV1hsbBM5QByOo0rsW8b1WltsHR2uAGw2HTdoDQ
	8hlfvJiZ9tqm6XkAWEM+62OpHiQrQY6gzRGaNybtS6NIyZnmls66hcUp5BhsO7k16kUFpXwtZ0r
	Ztf6FIw5rxP+MLIkk+MDB8OBexLBkZBJ2nJ0Fkwu4f51FODHTwiKl3e4l7yyIPPHfYMVUe0N/Ph
	OTv8=
X-Google-Smtp-Source: AGHT+IHusqfgp8ft2wDPT+W3cz9o7x/oHo6asIl/SWU5H1wQNeZiN8udhG4NOUbJ8caNAh38BUwOgA==
X-Received: by 2002:a05:6122:1e06:b0:529:1a6a:cc2f with SMTP id 71dfb90a1353d-52c37a8bcd2mr4986586e0c.7.1746689919970;
        Thu, 08 May 2025 00:38:39 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52b0a92eb27sm1979817e0c.14.2025.05.08.00.38.39
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 00:38:39 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4ddb7ddfb76so155401137.1
        for <linux-um@lists.infradead.org>; Thu, 08 May 2025 00:38:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWzHUGZr2YxmoNGT3eQHQBWIhuVp8i3/eoda1BlHz7YAy/TNXGvHkbZI4MFxO3donEnUSJqq//VTg==@lists.infradead.org
X-Received: by 2002:a05:6102:15a4:b0:4dd:b86a:dac1 with SMTP id
 ada2fe7eead31-4ddb86adb37mr323439137.3.1746689918794; Thu, 08 May 2025
 00:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250507074936.486648-1-masahiroy@kernel.org> <9ec50ce0-f60b-4d87-bc44-adaf2a1a97a1@linuxfoundation.org>
 <b1e4e83c0965e10f2fe59826d19eaf131ec7aef9.camel@sipsolutions.net>
In-Reply-To: <b1e4e83c0965e10f2fe59826d19eaf131ec7aef9.camel@sipsolutions.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 8 May 2025 09:38:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUwE7btR+ebG8-gvPb8GPnxUGPWw3yKR4qM4Uc_mYcHhg@mail.gmail.com>
X-Gm-Features: ATxdqUHSUZJrVPRt7puYinzwH0Sbp9Bizhx3T3hxY8yiAcyEWRrVX-9gdHKQkgI
Message-ID: <CAMuHMdUwE7btR+ebG8-gvPb8GPnxUGPWw3yKR4qM4Uc_mYcHhg@mail.gmail.com>
Subject: Re: [PATCH] um: let 'make clean' properly clean underlying SUBARCH as well
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Richard Weinberger <richard@nod.at>, 
	linux-um@lists.infradead.org, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_003842_791599_0F7ED0D0 
X-CRM114-Status: GOOD (  26.18  )
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

Hi Johannes,

On Thu, 8 May 2025 at 07:29, Johannes Berg <johannes@sipsolutions.net> wrote:
> On Wed, 2025-05-07 at 15:38 -0600, Shuah Khan wrote:
> > My workflow:
> >
> > - Build kernel on x86_64 with CONFIG_AMD_MEM_ENCRYPT enabled
> >
> > - Check for arch/x86/realmode/rm/pasyms.h
> >    ls arch/x86/realmode/rm/pasyms.h
> >       arch/x86/realmode/rm/pasyms.h
> >
> > - make ARCH=um O=/linux/build
> >
> >    This patch cleans the source tree, but doesn't remove
> >    arch/x86/realmode/rm/pasyms.h
> >
> > - ls arch/x86/realmode/rm/pasyms.h
> >       arch/x86/realmode/rm/pasyms.h
>
> Is that even _expected_ to work? If you have x86 built first, I'd almost
> expect you to have to do "make ARCH=x86 mrproper" before building
> another ARCH. I don't see how ARCH=um would know how to do a full clean
> up of ARCH=x86, unless this is somehow arch-independent?
>
> Or maybe that's not an issue with other architectures because UML is
> special in that it uses parts of x86?

Probably.
I only use my linux-next source tree for fixing reported build issues on
various architectures, and I never use make clean/mrproper.  Works fine.

> Though I guess the patch here should make it do that, more or less, but
> it can't, likely because you're also switching from in-tree build to O=
> build?

Yeah, mixing in-tree and out-of-tree builds causes issues.
Never build in-tree in a source tree you use with O= (except for
e.g. "make tags").

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds


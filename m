Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB92DCE8379
	for <linux-um@archiver.kernel.org>; Mon, 30 Sep 2024 17:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZoyzlnnLRNj4i2u5Dgn44nDbhn4MB5fS72eP0TVQdtc=; b=czqYmfpQyzmZL/TbSLr/dgAV7n
	kdtZsxPOUWZxWc6Ne8FrKNlCi/xH4cP3ox5HhL7V/xCcLnhanupaJH3ndqGyIqz695r6J6e7h38w4
	UnO43E1jsDtuBgnN0XWpCHVQt6tQf+EWcTKHRMG0M10MOoWlNTsjfxJmWiEZoXXU23FvvD0SKTnD6
	9aZ9VEJJzs4uSR7MEabmDfYS4oG2m4w5+Jype78MctgFJ85O4MgVGzYWnnrzE3bBHqazIb7/vzrJj
	YYFdrleAxfRl1MqJZAZl+oV3AeVp8CGxdsTe3v319saga7bq1F/TO0/BWl/m0nnar5eECwxAOd5lQ
	cL8PUefA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1svKb5-00000000QpB-2Gz5;
	Mon, 30 Sep 2024 17:54:11 +0000
Received: from mail-qk1-f175.google.com ([209.85.222.175])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1svKZs-00000000QhY-1wpG;
	Mon, 30 Sep 2024 17:52:57 +0000
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a9ab8e5f96so391956685a.1;
        Mon, 30 Sep 2024 10:52:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727718775; x=1728323575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZoyzlnnLRNj4i2u5Dgn44nDbhn4MB5fS72eP0TVQdtc=;
        b=XY2zUO0QsC3fZiOrzGDAbc7Y3yl/iGxnI3UNi+l6/SDbOsEDu0iEipK5CHuAFWZm4K
         yRyt+HxIado86FZ0/C+FabpsD1kkDAlpVW0RLvlRlD1HgC+0BdOJHZ68CKL4EeOF0Z8i
         k8T3GMspq9PkvoB7ICwmr9XMVRrtHtejT+tfXGWumzSPTpwjVVOVO7Z1tJsDagBoR8+F
         qtzDLA3vu6zMj6J702/s3Pc7WitZfmqdHNxdrTzRwXnvyZ1CNLVaqrKQptK+u2AVCFy8
         4gqIbOmxtm63ajrwLDjq/VN67fmUTPi77gzNDqNT8/EYu3N6UN43nb3LklxDAy67wUz1
         nU1g==
X-Forwarded-Encrypted: i=1; AJvYcCVfTNUdXxswjSaiMSZhMBwRcFYXHSRCA8Y+EaPIIOSde+umqfrj5aWcK3z0v+uTDxvWPB867sMplpY=@lists.infradead.org, AJvYcCXcn9kH+hNY+JpgXwVkilIYim8ucQuE/QZcKgWeagL4EHAYm8t1npLRxLlTUgqwuZIVxQCMjBqccCNwxderMF8V@lists.infradead.org
X-Gm-Message-State: AOJu0YzaVGQLTkfC4+C3xQUnwwERVlqtvVI/gpY0glsYhHyrASb20vHB
	Q50PtZdp8XaOfIhMWwohE78sqeFOZwi+hrE4nCAhiBY6pgLjAZJr5IQ5ZrWe
X-Google-Smtp-Source: AGHT+IFn5CMFbY6hKdk35IR/uaAiOiyGYrMU8aoSmcizg1frk4FVJ5YzH/BxfnLaK/xdRU2wmxSlFw==
X-Received: by 2002:a05:620a:2617:b0:7ac:a937:9364 with SMTP id af79cd13be357-7ae5427e7f6mr451748085a.32.1727718774909;
        Mon, 30 Sep 2024 10:52:54 -0700 (PDT)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com. [209.85.160.173])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae377d8a68sm434124185a.37.2024.09.30.10.52.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 10:52:54 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4585e250f9dso30637341cf.1;
        Mon, 30 Sep 2024 10:52:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1vob1ZWDc9ln6Txnlv29FEnNZM6LJcUdpVzyKQerY8BGwuyAaWD05pj+5/ksG3WyqJfNpteTsyvY=@lists.infradead.org, AJvYcCV2ENhDlHgXZMjsbV9zp9lO66mwkwqTL0E9pmiRl+y/5QeLBa5FuSTzM2k2VnEo5Fy4CpBIWakw15IcXLhyy0F4@lists.infradead.org
X-Received: by 2002:a05:690c:60c3:b0:6dd:bbb4:bcc7 with SMTP id
 00721157ae682-6e2476334f2mr105898897b3.44.1727718393293; Mon, 30 Sep 2024
 10:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240930132321.2785718-1-jvetter@kalrayinc.com> <20240930132321.2785718-6-jvetter@kalrayinc.com>
In-Reply-To: <20240930132321.2785718-6-jvetter@kalrayinc.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 30 Sep 2024 19:46:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVnb-fo2MP7ERwSj-sPNU3-QyikNinfhvgVa2DnR9jJrQ@mail.gmail.com>
Message-ID: <CAMuHMdVnb-fo2MP7ERwSj-sPNU3-QyikNinfhvgVa2DnR9jJrQ@mail.gmail.com>
Subject: Re: [PATCH v7 05/10] m68k: Align prototypes of IO memcpy/memset
To: Julian Vetter <jvetter@kalrayinc.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-csky@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-alpha@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, 
	Yann Sionneau <ysionneau@kalrayinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240930_105256_521683_15619912 
X-CRM114-Status: GOOD (  16.10  )
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

On Mon, Sep 30, 2024 at 3:25=E2=80=AFPM Julian Vetter <jvetter@kalrayinc.co=
m> wrote:
> Align the prototypes of the memcpy_{from,to}io and memset_io functions
> with the new ones from iomap_copy.c.
>
> Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
> Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
> ---
> Changes for v7:
> - New patch

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

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


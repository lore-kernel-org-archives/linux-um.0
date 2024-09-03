Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6300CD37B1
	for <linux-um@archiver.kernel.org>; Tue,  3 Sep 2024 23:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SlCnxIZL2Il1OI5y0fydGu2G23DBSVnD0BItXQgCoF0=; b=kVynWdIPrzXZBV48xk6Mp2jRwk
	NECoKbeyb/E7N9kDAgvYSEhCNajIFUraAHv3DXxiATmCboh4PbXQwJuFqREnKHkXFXqHAawEaHEH7
	wQs+UjxlB+M166OJsSyPbheJ7SgwrCFrSB+mjfbNh9l4tReA7cKyy6F0YiDcc/UZLFILODCxDmg5F
	YIzTlZvK2PYN4s84QpwSWEIKRPEenm9QEiJ9rvuOyaDQwuGDUdP/Ogcot+11yVVVucBo5d8XETei2
	Ej4l3+uCde+Ipm6ckZbgnatT1+ilNZFJaGaOpD+Dfk1Pb25jEE6Tn+IB9g7ybLA4jqAv/J1cnclVb
	i1lC3g7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sldBU-00000002JmX-2F2G;
	Tue, 03 Sep 2024 23:43:40 +0000
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sldBR-00000002Jld-3xXh
	for linux-um@lists.infradead.org;
	Tue, 03 Sep 2024 23:43:39 +0000
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-6bada443ffeso1503837b3.0
        for <linux-um@lists.infradead.org>; Tue, 03 Sep 2024 16:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1725407013; x=1726011813; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SlCnxIZL2Il1OI5y0fydGu2G23DBSVnD0BItXQgCoF0=;
        b=HfHksJVT/bI0SDjSlAm/L4YCOJA1SMoynH5K0fL8aWY8lT/uZmTzPW6cAxXHpE7bkA
         N85AJ58jNVI8T0L7wNppzoMGzBESQhKI3tl9tirioWHkifGkHOZyiUVSoZqHbJcyAgJR
         aB5cl3IDcrFGck7pBH3mYa9lZfmv3UTkgNCLdpBZCZs8e4A+P/j7dXEfAR4t4deji3Eu
         AbLqsAyz+ZdszOCQL4GMOrLzlOEYGu80QBogeUmwUP/OZvRQBz4DSersWJkM3Bj0I35H
         XgjXo/4gQ1dllzrTmY3dqnQ70SxP60abgHG++d40I7c/60YNxFqQvVwMjVMc7PTsVjY2
         NTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725407013; x=1726011813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SlCnxIZL2Il1OI5y0fydGu2G23DBSVnD0BItXQgCoF0=;
        b=KGG5H8PlQsKIAk/7I7VqMN1TDH56LASmxVN17tB3MLFQNWtguv8uqI39H92VyOt+yL
         NgQpBsQvgYKMtOiy2X/tsPyLuWaExPbIlbstURpQgvDxicBQQU3LJ513TgJKZtKnD/k5
         iFBMbibaEnnzhhUhYQVG8DrWsdJwWvKM8mvNNZK5oBr3IbGjpzevJ0R9zLR3lfVQ4rnm
         Zzz6ENc1cdiF4oef4gAd2BIrC/TvQwErOCxsAb72LpKAOR2GIy59t9cjWMyh6NsxC3kG
         O1MripK6wVSBOxdI36871/tfXZXJRMa8YMV+c3QUKCoF5A6OQROlClCkA2++jdkd+7tU
         /dJw==
X-Forwarded-Encrypted: i=1; AJvYcCVaOZyrkQTPUKf2qYax5b9UsgHuFhbYyad+jONfATxcfdGHoj2UEWbsso4dM1Wg8KilQrD8iUca+g==@lists.infradead.org
X-Gm-Message-State: AOJu0YwJIu4bybXYB4YlvuePlQSmgIQIel7Ael6YunEjy8uZq0XoH/3K
	iggNZm2xqRxKcdLWrZ9avrLZeejOuMV5WwYortQKY54UnUWuyEpRezmg5bj/fDA5hkoLpqKd+eD
	f/z67F2EqPxnp8hEsatzw59r8PrFQq44AqGBbZQ==
X-Google-Smtp-Source: AGHT+IFrQMIAF4flYNUpK76WrQSCNNRsT5DiFAql0jr+5EnBkw560S9E7XVDmYuoVKDvvbmn5wWUKdeul1GdgNXPNN4=
X-Received: by 2002:a05:690c:2891:b0:64a:445c:6 with SMTP id
 00721157ae682-6db25fcd975mr1453357b3.17.1725407012635; Tue, 03 Sep 2024
 16:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <62F5EEA0B866E9E0+20240903130606.292935-1-zig@iorw.io>
In-Reply-To: <62F5EEA0B866E9E0+20240903130606.292935-1-zig@iorw.io>
From: Trevor Gross <tmgross@umich.edu>
Date: Tue, 3 Sep 2024 19:43:21 -0400
Message-ID: <CALNs47s8Qzbckjf_f_-Cr2rVmAf4sbo1MaSBFagdhZS4KcpQNQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] rust: arch/um: Rust modules support for UML
To: Zigit Zo <zig@iorw.io>
Cc: ojeda@kernel.org, bjorn3_gh@protonmail.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, 
	tglx@linutronix.de, mingo@redhat.com, nathan@kernel.org, 
	ndesaulniers@google.com, gary@garyguo.net, rust-for-linux@vger.kernel.org, 
	linux-um@lists.infradead.org, llvm@lists.linux.dev, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240903_164338_062828_5D8A9C7A 
X-CRM114-Status: GOOD (  17.76  )
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

On Tue, Sep 3, 2024 at 9:10=E2=80=AFAM Zigit Zo <zig@iorw.io> wrote:
>
> The series make Rust modules running under x86_64 UML, as a supplement
> for the previous work:
> - https://lore.kernel.org/rust-for-linux/20221217044436.4138642-1-davidgo=
w@google.com/
>
> The previous work by David (many thanks!) has made the Rust UML compiles,
> and for the builtin modules, it works as expected. But for loadable
> modules, the UML will complain
>
>   'Unknown rela relocation: 9'
>
> when we try to 'insmod rust_print.ko'. That's because the modules are
> compiled against '-Crelocation-model=3Dpie', makes the LLVM treat the
> modules as PIE executables, but they are just static modules.
>
> Besides, the Rust's code model for x86_64 UML is still 'kernel', leading
> some relocations "overflowed", we keep it the same as 'KBUILD_CFLAGS'
> set in UML ('large' here) to address it.
>
> Now we can test our Rust modules in UML.
>
> Regards,
> -- Zigit
>
> Zigit Zo (2):
>   rust: arch/um: use 'static' relocation model for uml modules
>   rust: arch/um: use 'large' code model for uml

Hi Zigit,

Thanks for sending this. It looks like the patches may have gotten
split from the cover letter because the In-Reply-To header isn't exact
for whatever reason (the two patches reply to
<20240903130606.292935-1-zig@iorw.io>, but the original has ID
<62F5EEA0B866E9E0+20240903130606.292935-1-zig@iorw.io>).

No worries for this initial rev, but just double check this if there
is a v2 :) archive links of the individual patches for reference:

[1/2]: https://lore.kernel.org/lkml/FD7D773099A0C7EC+20240903130606.292935-=
2-zig@iorw.io/
[2/2]: https://lore.kernel.org/lkml/54FC087D02C52990+20240903130606.292935-=
3-zig@iorw.io/

- Trevor


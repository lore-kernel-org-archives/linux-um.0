Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14AFDD116F1
	for <linux-um@archiver.kernel.org>; Fri, 28 Nov 2025 12:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0aBIuYE4nd+BYCFFHUQwg9DXqTRyApw0XxRj/xzcbAQ=; b=46Gp3f53ttSngISEyyNDVkj0iw
	jzcEQlDW7tlrt7R5fRNWMjSJ0VRnUiAML5AmcaTapyOd+is6Oe53Yqm4ngAxPWXCqZ2qRMJX4Zy4b
	G9Vw5voIbZfLCetBiCEUTXDcmMOx4+dfRVTdDiLof28QezIVY+B96l0JF7xObCuL/jjRah+hhdu89
	23QC+4Kk2ewqNrelYTD3DFxwib/bTN7hbpBQEAUcw805HdxVtgzpKAXjCdXojZTFAnoo6BOViF7l5
	Tzc68r1ym8s8sbtt5ysRLeV1xbKr+zu/jeVDu4Z5PZZTTYAVwOXm9+yOg3IV7TQ3nYSdknkItiiZc
	Slab1X3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOy4X-00000000SKV-2A4w;
	Fri, 28 Nov 2025 12:59:37 +0000
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOy4U-00000000SJl-21eq
	for linux-um@lists.infradead.org;
	Fri, 28 Nov 2025 12:59:35 +0000
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-42bb288c17bso1215735f8f.2
        for <linux-um@lists.infradead.org>; Fri, 28 Nov 2025 04:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764334772; x=1764939572; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0aBIuYE4nd+BYCFFHUQwg9DXqTRyApw0XxRj/xzcbAQ=;
        b=L/qTC74TitmkFUqQLyeBOTN688Sd9FbqUMeoaWJR53Ub3pN0Z0DkqLmm5zqJXeCgA7
         Xpar59oZ5S+5Fd/QcrqheL7Qfz/Gl+UmYj68a7W7QBKiEVg9MS/D9TBZI2bXu9+3Tcw1
         W/3u5yGWrvM9IJym/jT4jR116JhURTKmp3+flBQw76hgKOMx4o0kWcxIgU1W4ypkbelM
         y6fEgnwWhLSkXRJDOd3pRg9xpQItNu8Z575AAyQKtE5YovB17gL+rLa0zZMOAUiWCkln
         Y+++ZnUmpkVjcPaTqfQYSlca/wiPvjd43QFr1Hqcu3U5l6N0qxYK32jY35lfREEmq5Uj
         yxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764334772; x=1764939572;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0aBIuYE4nd+BYCFFHUQwg9DXqTRyApw0XxRj/xzcbAQ=;
        b=nLPRzKRnpb60cjJnxlRcZCfCWdur5cqN7x7PWKowTE5tsup05sj2ASZxJT6Rzvh7jI
         WdMZgC0RsDA9MH4bwL3NQkBDb+V5FE47bZGU7q87LeQA6XpAx34U29K6Z6c7Zv6qJIYa
         waChvMmcmurrySB4goe3IrP2oJZKyxAQGPhR+OwJz5aZc/NIOSup9pQp05fZA1SdNkji
         prNdAtLBYAjXytH9WaA01TxiPJsGJ4WHGZR9y0yz8Gk4Px/DwjchQtG1jj80DsqFJ0TK
         upub9SAiDUOyEyg3eTqfIUxB5QJfFc6QejHswvXQ03JsUrc2HZKR+B165Cftnpf3Pfjx
         reHw==
X-Forwarded-Encrypted: i=1; AJvYcCXpXEhWKU39cG3SdiEwLg9jB1T/s0CMsEytNKOR0UG93IT9GVR0G/txlo/N4eSrLy7sDCviEQi6fQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwhDQHSXdxfauVVjtBAsoFMA9DxWgOFGL5T9ZqFs/CGI01ymOq4
	0Cm89edmWq0uyiqfbKyYTGJcyjzFuecskUFagzXSlu0bSDRIJ4fK+A4ZtpOjHb0Pj/Y=
X-Gm-Gg: ASbGncuK8bLj3UngcIg91Zjwk8h4Y7XOgckfVpsYhk1rKfmnslHEaj+UTQRyMPIZhXn
	EzoxPnQlHbAANAaYrFCaf+wVzSOrehjskeabTXnD69cQd7I6Rmb+2e06fDGzksHoO7i83xaBzkN
	TUHJfb+/SsKIzJPlPz77eHU9uVEbpErYa4zlBgMzTBgA7QEBqhDFa7++sv43/kYkjhyAx2HroWd
	ev49PUK7hyoUjYnxU/5I5R1mKQEnKrMl7Sgnrb41biPYIYqvBjsyzTWJpWvMO39pA1pYt+2/y3x
	sooDqJOHuR+H72tcVNm/1QuU/hmoMEzB5bdvY7f7Y3Wjl5bzh5rM5W4q2356a3hpT2A5jTePWTv
	BJmRqwx/H/b+khNHVVuyC8REBXI1vRdaOwpds2nfWUSAbAngSeg5BsZ/Cv7O0fKdB1xijaSTc06
	WSbiun3Nc6Bh2wQu8q+WApEFtp5XW6WaLcwpqaisA=
X-Google-Smtp-Source: AGHT+IFwsjx1VXfBjmNiHK7aZcDtaWRNmdnPkV/Hi/q/9IXbn+xyWp7WtryWuxt5fSFV2BCqurib+Q==
X-Received: by 2002:a5d:64c7:0:b0:429:edd0:29c with SMTP id ffacd0b85a97d-42cc1ac91edmr29116796f8f.19.1764334771958;
        Fri, 28 Nov 2025 04:59:31 -0800 (PST)
Received: from [192.168.3.33] (99.36.160.45.gramnet.com.br. [45.160.36.99])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5d613esm9859184f8f.11.2025.11.28.04.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 04:59:31 -0800 (PST)
Message-ID: <aa78f0418ca2f408cdc31b478963ddeab797faa7.camel@suse.com>
Subject: Re: [PATCH v2 0/4] printk cleanup - part 2
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Daniel Thompson <daniel@riscstar.com>, Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Ogness	
 <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>,
  Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Jason Wessel	 <jason.wessel@windriver.com>, Daniel
 Thompson <danielt@kernel.org>, Douglas Anderson <dianders@chromium.org>,
 Richard Weinberger <richard@nod.at>, Anton Ivanov	
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, 	linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, 	kgdb-bugreport@lists.sourceforge.net,
 linux-um@lists.infradead.org
Date: Fri, 28 Nov 2025 09:59:25 -0300
In-Reply-To: <aSlw2AHo_AWzjH-s@aspen.lan>
References: <20251121-printk-cleanup-part2-v2-0-57b8b78647f4@suse.com>
	 <aShr0DZRmpDnL0nz@pathway.suse.cz> <aSlw2AHo_AWzjH-s@aspen.lan>
Autocrypt: addr=mpdesouza@suse.com; prefer-encrypt=mutual;
 keydata=mDMEZ/0YqhYJKwYBBAHaRw8BAQdA4JZz0FED+JD5eKlhkNyjDrp6lAGmgR3LPTduPYGPT
 Km0Kk1hcmNvcyBQYXVsbyBkZSBTb3V6YSA8bXBkZXNvdXphQHN1c2UuY29tPoiTBBMWCgA7FiEE2g
 gC66iLbhUsCBoBemssEuRpLLUFAmf9GKoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 QemssEuRpLLWGxwD/S1I0bjp462FlKb81DikrOfWbeJ0FOJP44eRzmn20HmEBALBZIMrfIH2dJ5eM
 GO8seNG8sYiP6JfRjl7Hyqca6YsE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (by Flathub.org) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251128_045934_535927_C3D52661 
X-CRM114-Status: GOOD (  20.96  )
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

On Fri, 2025-11-28 at 09:52 +0000, Daniel Thompson wrote:
> On Thu, Nov 27, 2025 at 04:18:40PM +0100, Petr Mladek wrote:
> > On Fri 2025-11-21 15:50:32, Marcos Paulo de Souza wrote:
> > > The first part can be found here[1]. The proposed changes do not
> > > change the functionality of printk, but were suggestions made by
> > > Petr Mladek. I already have more patches for a part 3 ,but I
> > > would like
> > > to see these ones merged first.
> > >=20
> > > I did the testing with VMs, checking suspend and resume cycles,
> > > and it worked
> > > as expected.
> > >=20
> > > Thanks for reviewing!
> >=20
> > > Marcos Paulo de Souza (4):
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drivers: serial: kgdboc: Drop checks f=
or CON_ENABLED and
> > > CON_BOOT
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arch: um: kmsg_dump: Use console_is_us=
able
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printk: Use console_is_usable on conso=
le_unblank
> >=20
> > These three patches were simple, straightforward, and ready for
> > linux
> > next.
> >=20
> > I have comitted them into printk/linux.git, branch rework/nbcon-in-
> > kdb.
> > I am going to push them for 6.19.
>=20
> I pointed the kgdb test suite at this branch (as I did for the
> earlier
> part of the patchset, although I think I forgot to post about it).
>=20
> The console coverage is fairly modest (I think just 8250 and PL011
> drivers, with and without earlycon) and the suite exercises features
> rather than crash resilience. Nevertheless and FWIW, the tests didn't
> pick up any regressions. Yay!

Thanks Daniel! I remember that you said that you would run the
testsuite in the previous patchset, but didn't want to bother asking
you (I believe that if you found anything you would point it out either
way :) ).

>=20
>=20
> Daniel.


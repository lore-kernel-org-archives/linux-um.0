Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D89C61DB2
	for <linux-um@archiver.kernel.org>; Tue, 10 Jun 2025 22:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wGQrwjvbxP5TElWRzftoyq5VMQ1P3z0T9KV3nef+RkU=; b=P+HpNvFIM/EM4e8FgGrlpn6AtF
	cogsfYgwXSzLm9Lpe9KoxBLYHafVXedZaLPcC18zWo+nUgCHgKg4RW0jAwujnW7kmARCxABzL8YDU
	9tyc1eYa9PYZUEBYXoJCdGHYDsz/GlrbgPJ4ML3CFXp4u4FRo5gAGdl6BnJnpkhJxf4BE3BheLMaP
	UiApuUOaRS7LUc+YpZ3Fp3m/wWiXD2kEo/TaqpgR2V74HDHTTUOg0An1zkL+SgiZPoOfLg2nbEf87
	2NeM2WRfq0UjkXYt7hQwXDMqgTe9sUX+uX0sgqiPFgxr0nKFhyz6VNwZs5alDuWzJ3ZelePJ9UVgo
	/ngFvz1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uP7mi-00000008HNd-3Q3b;
	Tue, 10 Jun 2025 22:49:36 +0000
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uP5Bg-00000007zrS-1dEp
	for linux-um@lists.infradead.org;
	Tue, 10 Jun 2025 20:03:13 +0000
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3a52874d593so5649187f8f.0
        for <linux-um@lists.infradead.org>; Tue, 10 Jun 2025 13:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749585790; x=1750190590; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wGQrwjvbxP5TElWRzftoyq5VMQ1P3z0T9KV3nef+RkU=;
        b=VeX234RgsgyxVWQZ2x7d+zDhy1IF6K6qGGi4iApRhSRIO3VMmZu11/i2Og3/ZOYZgU
         qZvkwSlrPTZPUUJRjo4ImfM/bpok2HqIpEzWJde7o5aEDjeu0gczsJsaf40lqA6wGBJi
         sZ2HrW2py7WkVauDTAiuNQMsgUp8bGQGDZSZ99+bjQCV2IwJ3eC1UhRcICFRfbeXYJoC
         fcuYj4/G/Nm9HlVqU0QgrS6d/DkUyorJ/uyFC0BHTXalRHm3PIyIWpEBAFPh1itNlG/u
         5dCSqEJtYj6YgHO2nbMPfUY5hGWE1tPTfGweXwakqZ9sennSuwor7HzdN1rXIutAPJsz
         XhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749585790; x=1750190590;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wGQrwjvbxP5TElWRzftoyq5VMQ1P3z0T9KV3nef+RkU=;
        b=HSxdWAhR6LZTsrHoZKrrhmtywCu/grgLTcRlzCBoxaAY7lxhjJrldJFSQxWELTml6f
         mrWqEMPgZhrx++accZnicPH3DxAfolGR8PWuINZXp64VOe/XjjIv8itXgJ1P7+zQ6+Qo
         erEffiWLwIyN3/DKPtVrEyxAxQJMuGA/MJ6mde7ranCNo+niwJMcDVs7NTH2t7FguYdt
         s/yEsNQw22x4x3pcCJGLrNaIRQ6CPCxQRWRsb6WxmaopuXJak5w8U3l2e2kGCgg2TYpy
         GzlCVleYmLE7fgC3IemSl65XtaUFGTgNNNW8pWp/e0KOHg92PSqyK6DS8jXRymTPAmT/
         vACQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfJBrZLsR4PVL55w+kTPD2GlMAr1ZjU29YJFjENuxQ3u16l3zThvwVdA0HGKPM86oUZdvjPIEMSw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwhEt0bkohiIcoYBVItdImlwYcy4nXY4nWAFgww9RS1v7LwsnH8
	2nPBdIQ88/CFP0aJtN5HAIOV8k4thVDRfXZqQ3uCA+6vQGXbKJ+h5DkhaA31p3LKBjM=
X-Gm-Gg: ASbGncvsg8QQf0x2IJN/FRqDaUmK3zVotRLsGtwjTlCnFflub/bfPqoX1lmXXaLx0MB
	Q9X4rpSSz7Ros5LxJ5s9pVoG9U+j0OZXOS6fcKU+4X1tmtjJKChCszRjyG9sx23NLc8NEc5Lky4
	FiT7JcIKg7Fz9FpVmXwhy+WNnbRg+BHwBAvZaKmPxr+5XDeMaeNf3mc8O/8mJv9piVA8gaz0n/r
	NT6tMOgJ8tFxTQhiXz9WdGEJ2C+gyIcEKIFHgXzy3zBdMve7+QqOmkLFb3zYLI/h0C1GoFlkBh+
	au6QdlkUWZE5R6Q53sIgtBsJtSgdiETBXMkQT/9YeM/aPPZ2tcK0KMgVTs5ooUtqQu5qhCFTzHw
	3LOEUIQayogMFXquj
X-Google-Smtp-Source: AGHT+IEtm22Ya9JUV8ulYRQRT6vYHBjx+q7IOEDUr9BMoA+Edf/n/UDiFasL+UkKEL9+F1awgGEj8Q==
X-Received: by 2002:a05:6000:40d9:b0:3a4:d31e:4af3 with SMTP id ffacd0b85a97d-3a558ad6e98mr181211f8f.37.1749585790019;
        Tue, 10 Jun 2025 13:03:10 -0700 (PDT)
Received: from [192.168.3.33] (115.39.160.45.gramnet.com.br. [45.160.39.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53229de48sm13364311f8f.10.2025.06.10.13.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 13:03:09 -0700 (PDT)
Message-ID: <f962e9bab3dc8bf5cae1c7e187a54fb96a543d51.camel@suse.com>
Subject: Re: [PATCH 4/7] drivers: serial: kgdboc: Check CON_SUSPENDED
 instead of CON_ENABLED
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Doug Anderson <dianders@chromium.org>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Jason
 Wessel	 <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>,
 Richard Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg	
 <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, 
	linux-um@lists.infradead.org
Date: Tue, 10 Jun 2025 17:03:02 -0300
In-Reply-To: <CAD=FV=XXQyZLYKoszj68ZGFDY=9-cmEUp406WeOeSBVZOHyUHw@mail.gmail.com>
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
	 <20250606-printk-cleanup-part2-v1-4-f427c743dda0@suse.com>
	 <CAD=FV=XXQyZLYKoszj68ZGFDY=9-cmEUp406WeOeSBVZOHyUHw@mail.gmail.com>
Autocrypt: addr=mpdesouza@suse.com; prefer-encrypt=mutual;
 keydata=mDMEZ/0YqhYJKwYBBAHaRw8BAQdA4JZz0FED+JD5eKlhkNyjDrp6lAGmgR3LPTduPYGPT
 Km0Kk1hcmNvcyBQYXVsbyBkZSBTb3V6YSA8bXBkZXNvdXphQHN1c2UuY29tPoiTBBMWCgA7FiEE2g
 gC66iLbhUsCBoBemssEuRpLLUFAmf9GKoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 QemssEuRpLLWGxwD/S1I0bjp462FlKb81DikrOfWbeJ0FOJP44eRzmn20HmEBALBZIMrfIH2dJ5eM
 GO8seNG8sYiP6JfRjl7Hyqca6YsE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (by Flathub.org) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250610_130312_431800_2BACC61B 
X-CRM114-Status: GOOD (  26.57  )
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

On Mon, 2025-06-09 at 13:13 -0700, Doug Anderson wrote:
> Hi,
>=20
> On Fri, Jun 6, 2025 at 7:54=E2=80=AFPM Marcos Paulo de Souza
> <mpdesouza@suse.com> wrote:
> >=20
> > All consoles found on for_each_console are registered, meaning that
> > all of
> > them are CON_ENABLED. The code tries to find an active console, so
> > check if the
> > console is not suspended instead.
> >=20
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > ---
> > =C2=A0drivers/tty/serial/kgdboc.c | 3 ++-
> > =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/tty/serial/kgdboc.c
> > b/drivers/tty/serial/kgdboc.c
> > index
> > 85f6c5a76e0fff556f86f0d45ebc5aadf5b191e8..af6d2208b8ddb82d62f33292b
> > 006b2923583a0d2 100644
> > --- a/drivers/tty/serial/kgdboc.c
> > +++ b/drivers/tty/serial/kgdboc.c
> > @@ -577,7 +577,8 @@ static int __init kgdboc_earlycon_init(char
> > *opt)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 console_list_lock();
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for_each_console(con) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (con->write && con->read &&
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (con->flags & (CON_BOOT | CON_ENABL=
ED)) &&
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (con->flags & CON_BOOT) &&
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((con->flags & CON_SUSPENDED) =3D=
=3D 0) &&
>=20
> I haven't tried running the code, so I could easily be mistaken,
> but...
>=20
> ...the above doesn't seem like the correct conversion. The old
> expression was:
>=20
> (con->flags & (CON_BOOT | CON_ENABLED))
>=20
> That would evaluate to non-zero (true) if the console was _either_
> "boot" or "enabled".
>=20
> The new expression is is:
>=20
> (con->flags & CON_BOOT) && ((con->flags & CON_SUSPENDED) =3D=3D 0)
>=20
> That's only true if the console is _both_ "boot" and "not suspended".

My idea here was that the users of for_each_console would find the
first available console, and by available I would expect them to be
usable. In this case, is there any value for kgdboc to use a console
that is suspended? Would it work in this case?

I never really used kgdboc, but only checking if the console was
enabled (which it's always the case here) was something that needed to
be fixed.

Maybe I'm missing something here as well, so please let me know if I
should remove the new check.

>=20
> -Doug


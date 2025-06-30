Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1DB8C7EE39
	for <linux-um@archiver.kernel.org>; Mon, 30 Jun 2025 00:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rz7q/mLSazaciDJjcVPSYcL8l+KzHY3rbvo2kLwMng8=; b=vOeg71s8Iju/L6J1TfRjoFpb5m
	c0XpU3ZrcZfFGIMAE3bOVkHYuqQqvzWX20f3TLHPxDk/TwNkszkIPpT/VhNGySLTydoi/YA4UtKuo
	Tm5oW/93FdfdF2ijp1rEHz0ZQD2EaFBvyssUThcN4BT60RvE3ZvNUUooGs9Ks7fb+BhlJ70BwqSpR
	VM3I6xq4Et3E4StRSY3bPQMhDhjtAF94/nYtP0KTbjcUwq1EueoZ/8XWJAowtRgSk3wmlEIv6spxx
	0Z9qBurFmuIr7n2er+TXua7AshUdPlDOqHhfeco1OAWrleoPvr1uHzmNcrhiIwkGLVoivpKO1dxGG
	79LS4oxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW2RN-00000000tre-13tn;
	Mon, 30 Jun 2025 00:32:09 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW2RK-00000000trJ-0PE3
	for linux-um@lists.infradead.org;
	Mon, 30 Jun 2025 00:32:07 +0000
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3a6d1369d4eso2051608f8f.2
        for <linux-um@lists.infradead.org>; Sun, 29 Jun 2025 17:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751243524; x=1751848324; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rz7q/mLSazaciDJjcVPSYcL8l+KzHY3rbvo2kLwMng8=;
        b=N+1fNtPheMDHZhVWGouwEizlgMbavIaNAmeKxiR8srLiNJOdot87zlsMW8msyGBs3S
         2QkbY664/FTlc3+XeEO1YQBobLYOw76wfOBzNLPHzMwUNkQRNqUuzJEeoYRx0PB746Ml
         iQr84Lj+e4xtoHoZItB/NmhknHsy0siSbc/VOci2t8RJLLofRVVJcaM76zXkI8WN8CVE
         doTxfIOS+I01CAjmqrE7DNn1QDK8MkU98Nz3rkMPj+WvCBjTI4ygFKQrAYNfXYLLjco/
         O/75I66LHcjoy+iDt+CG6vftoS4PTwcEOmts6Pcjtl98G0mFaNchnkqN/BFNSyYyQrcA
         54iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751243524; x=1751848324;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rz7q/mLSazaciDJjcVPSYcL8l+KzHY3rbvo2kLwMng8=;
        b=YbTFNIlovXCyhlvOYXEgP9QbrszW+sgob5rHBtTu3SnHdVPuMsKmV7yHZkch3NHxIR
         nDnLuoVesyc3qI8gdCKFGZMQFS7fKv834QKeKpjbpAo6kPPttYAD5I1QXPe5CHkTiRL2
         /i47Q72cjeakkwEire7UKDHXdtqde6J9j0PJyStjklaM9VCqWBVswLWfdkyfo4AUGPSa
         txZAPPn9d2DdBHaKWB7Ot2oZnnuNde2LrosxJDdx+XpmsDkUaxDSQeLy6i8phqLaLKK8
         e4wgWSvPzSbC0kp/hs8O2jJ0mhHp/fJVa+n290MKrhRS0eKhxzmfYiv3vfT5kcE8OCrr
         UjPg==
X-Forwarded-Encrypted: i=1; AJvYcCXpJftDLuVkC/q3xKh4nvR/iu2nYzb5aOQaYAE6477k/iHbm+xUerb/OZpIfwrh9Q6Gd172IuOefQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyr85Osn0GLaWkDxEjcUiYUDv4/3Q+h31pHpc49oMDr7QzV8MG4
	8vTXkBZdod0z48I7ucHplnMQHaxt0w103dTOH/aujxTZUpYjavgmukxm/lw3t+1sqFk=
X-Gm-Gg: ASbGncu/M8AXbI+Zdk34bRPPUAzsV9AMqSkXDrwERYcAW0Sxok88YXOa72B3akzGu6Q
	dVZDdnPn+IEmWlPUuvNuBVRyLgK57DBqKVijWb8yFc4HaEVhZHGCXKKqPyGFOpRRND6VTJxZqK7
	KIYT+tFmlMNk3ewWCpCjGzYUyqEO+HUNCvPmS33E9K3vQvDSwQudF3I+lJDMTX+MIOPHG6EeHel
	2+MAiao/AvWF3vzkRUW5uQ2bebcxZXzM5te+r1y5Lp76rq1FTrIeF2XrbiQlk9kkcUrXh09vunE
	jSgZ4mWCaJ05aOiGQd2CrCzMiAVcvOsm28lHMtMq1mDXrYECKOKFXyR9GMrF+u5Opv1kkDHRlt9
	qquxLXqx2uP4FAmFWnlCc48pLB1jq9ui9JYs=
X-Google-Smtp-Source: AGHT+IHV8BL/WZwTciQ5tTsBYvp9HevklHMpopzWboeYBsH4XCwqK0uP1k7gV+5QrCOrwBU+rea1EA==
X-Received: by 2002:adf:c793:0:b0:3a5:2182:bd11 with SMTP id ffacd0b85a97d-3a8fe4bc774mr6503870f8f.20.1751243523771;
        Sun, 29 Jun 2025 17:32:03 -0700 (PDT)
Received: from ?IPv6:2804:5078:805:6b00:58f2:fc97:371f:2? ([2804:5078:805:6b00:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fc139713sm51320431cf.22.2025.06.29.17.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 17:32:03 -0700 (PDT)
Message-ID: <d8c2b6d6c992ae222413fd19c1b93360297903e8.camel@suse.com>
Subject: Re: [PATCH 6/7] debug: kgd_io: Don't check for CON_ENABLED
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Petr Mladek <pmladek@suse.com>
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
Date: Sun, 29 Jun 2025 21:31:57 -0300
In-Reply-To: <aFAiq3IEic8DuATR@pathway.suse.cz>
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
	 <20250606-printk-cleanup-part2-v1-6-f427c743dda0@suse.com>
	 <aFAiq3IEic8DuATR@pathway.suse.cz>
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
X-CRM114-CacheID: sfid-20250629_173206_162224_62FC6FA7 
X-CRM114-Status: GOOD (  30.65  )
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

On Mon, 2025-06-16 at 15:56 +0200, Petr Mladek wrote:
> On Fri 2025-06-06 23:53:48, Marcos Paulo de Souza wrote:
> > All consoles found on for_each_console_srcu are registered, meaning
> > that all of
> > them are CON_ENABLED. The code tries to find an active console, so
> > check if the
> > console is not suspended instead.
> >=20
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > ---
> > =C2=A0kernel/debug/kdb/kdb_io.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> > index
> > 9b11b10b120cf07e451a7a4d92ce50f9a6c066b2..cdc1ee81d7332a9a00b967af7
> > 19939f438f26cef 100644
> > --- a/kernel/debug/kdb/kdb_io.c
> > +++ b/kernel/debug/kdb/kdb_io.c
> > @@ -589,7 +589,7 @@ static void kdb_msg_write(const char *msg, int
> > msg_len)
> > =C2=A0	 */
> > =C2=A0	cookie =3D console_srcu_read_lock();
> > =C2=A0	for_each_console_srcu(c) {
> > -		if (!(console_srcu_read_flags(c) & CON_ENABLED))
> > +		if (console_srcu_read_flags(c) & CON_SUSPENDED)
> > =C2=A0			continue;
>=20
> I think that this is similar to the 5th patch. We should check
> here is_console_usable(con, console_srcu_read_flags(c), true)
> because it checks more conditions:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 + the global console_suspended flag. The console=
s drivers should
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 not be used when it is set...
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 + whether NBCON console driver has con->write_at=
omic
>=20

Makes sense, I'll work on it first then.

> and we should also fix kdb_msg_write() to actually use
> con->write_atomic() when it is a NBCON console driver.
> There is hard-coded con->write() at the moment.
>=20
> But it might get more complicated. It would be nice to do it
> correctly
> and use con->write_atomit() only when nbcon_context_try_acquire()
> succeeds. We probably should use a context with NBCON_PRIO_EMERGENCY.
>=20

I'll check how that can be done by looking at Docs.

> And this should be fixed at the beginning of the patchset because
> it actually fixes the support of the new NBCON console drivers.

I'll try to send patches for this case first, and then come back with
this series once this one is fixed, so I can start converting the other
places like you suggested later.

Thanks a lot for the suggestion!

>=20
> Best Regards,
> Petr
>=20
> > =C2=A0		if (c =3D=3D dbg_io_ops->cons)
> > =C2=A0			continue;
> >=20
> > --=20
> > 2.49.0


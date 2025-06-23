Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D7EC77B7C
	for <linux-um@archiver.kernel.org>; Tue, 24 Jun 2025 00:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kP3LfikwJoT5jZxTfYQ53BJecw5PNc+P0zrWLzEkXCM=; b=HjJH8MfJZbeU5ScJxm3bWenpqe
	uo1hCmb/JHxmIVu3j0dfDzCsRJD9EUz6W3vKxubPHUqkgX90YLVSPZZdrZYSqzQGBQNrhO6DYeBPQ
	k2fvqt6xPj/WlBS/2ZmYLcwMsDDGh28OCTv9J7tleAhgHQ3zklA+Q44Ruc1LoRBEx46DSflZrzzk0
	KCQf1G10ea7z3CUZLsBoy6qS4v3aFXtrfxVlhj5eo8Lsbue79W/LEOBTLbUQVH1gjGvpiVvXKtaAW
	82GSr7zvlvVrGbVNR6y3bxkzVy4nFh4XesYYNa3MDiyXU7oCPDPwANCP2w8YVeV5wL06WKV2DCLli
	BwzD1QJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTraT-00000004GbL-0ZcF;
	Tue, 24 Jun 2025 00:32:33 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTmIE-00000003kwD-0wx9
	for linux-um@lists.infradead.org;
	Mon, 23 Jun 2025 18:53:23 +0000
Received: by mail-wr1-x442.google.com with SMTP id ffacd0b85a97d-3a36748920cso3450017f8f.2
        for <linux-um@lists.infradead.org>; Mon, 23 Jun 2025 11:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750704801; x=1751309601; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kP3LfikwJoT5jZxTfYQ53BJecw5PNc+P0zrWLzEkXCM=;
        b=QXYHnGP+YGcvLVSVTde7Fbtx5eZkEPG/WGNSofn4fk/LVgeNCp9pel6vNrifuSw+6y
         dZxvCCfMOkfACtw1kGeWikoJJyNXZZfenfuta+cf9cpFAOJ497ac96XWkK7XwAElPb7X
         SGd1RwRb1RZAARFZOG/KQINPAo5hnbIkUhypNIJR+gXgKPblqX1U6rgq09xhh0uPmOh7
         8svgGqYbnY19U4ePwPFHRPym9dDlaLI8l+2c4VfdfrViW+EqPYnT+rDPlJEFSE5g20qm
         2JqW1yBiASdnv4X2jmE63PzG8bwJu9CE1W7DPw8768oLXa/vKkCPsJFCtpkTZXQajgDk
         uyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750704801; x=1751309601;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kP3LfikwJoT5jZxTfYQ53BJecw5PNc+P0zrWLzEkXCM=;
        b=fAtYHSs0OlDCvksDPAhvDVFcbRnB6kdo9APIIi4ZQ1XY5HqdMElQl4eJkgvGoNvOhf
         3z9ZosogtPiVPNzlINRYiI6tEcwJMFxCvV/D4O7QrmBnh15DuAYGp9jDv7E6ru5rxn4k
         B3EL8ebXF+D5nZbyIiYQZlFP7uieeDL8oh+VnB1++IfMhBeZSZDrvv7AWVlcL6aL1E7Z
         LcDRk2X1w7qWj4gvUtx6PrLufl3+cRJmNee/xflKpFioWnz9yjQFpu4QDMXQv4apygM/
         Rq3sdbc22tcNX371Ip5Lx2atFahBc18f2jCbVxJdas2xd1WGyVEXAxOZI8txoSA/jwDJ
         vm7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWVkWReptaZm2MkfJNjIUW1h2/HXX9dtVBE1pmLfNYVMwuYSyna6t3yA6dUZjHgJgMU9WdIegyZAg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwvJStLBl97gGfgQvrJrcgA3JKVaGujFUmMizfSp3+zUywAWtsj
	ELCzmpjNTHjWjVzwIlMgZClS3mSA0vRwQ52P5S1A/pdCeKlsm8vpy/mAKHfoJc9Lmag=
X-Gm-Gg: ASbGncvdYXYUKHinaZY05mST251IA9FddKN9Hl5WBRcin1+v1U220rkOR1601xzhkGn
	aWNXhVxYJf6uDrj8sUSHoUalkwQzp7DbrlP5dDemW7oxs5mB5TIE884oaLtlp9HdlSnZT+8lBba
	LLKQRNHUe5wszbXChFgGx7WopNbct0I8JDT9pXAVsLqGCTFo6I+c7ujZvZ5tZE8/Ee5/fozd8Jy
	GaNgyNnKbfwWihLxSeXSB3aRQjXsY1Pak78ovx2n7Vo/4kIHD6gNFPX0fzbsG+1xDcjnVm9ab9g
	c/q0k356mkWO3bTRYcEv++bDbA+sHTu/5fJ8RgRdV/YqBuqtwhx1PfKWOJbyhgfATbuQphFOPo5
	O/XDA24wpbkuiAl9/0Z5ST1LC
X-Google-Smtp-Source: AGHT+IHl7WUsTHsArXNJ7BBLS48xIuonfKG5DP3IbYFgDHwpfpJdrP3CunJHC4qeSAikuH/t9ORELQ==
X-Received: by 2002:a05:6000:1a8e:b0:3a4:eeb5:21cb with SMTP id ffacd0b85a97d-3a6d12e5b71mr11313647f8f.26.1750704800592;
        Mon, 23 Jun 2025 11:53:20 -0700 (PDT)
Received: from ?IPv6:2804:5078:805:6b00:58f2:fc97:371f:2? ([2804:5078:805:6b00:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f126a2aesm8483866a12.67.2025.06.23.11.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 11:53:19 -0700 (PDT)
Message-ID: <d4f7a4dd5bedf288d2011fc9817716b8af2ec032.camel@suse.com>
Subject: Re: [PATCH 2/7] printk: Use consoles_suspended flag when
 suspending/resuming all consoles
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
Date: Mon, 23 Jun 2025 15:53:14 -0300
In-Reply-To: <aExBo-8cVOy6GegR@pathway.suse.cz>
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
	 <20250606-printk-cleanup-part2-v1-2-f427c743dda0@suse.com>
	 <aExBo-8cVOy6GegR@pathway.suse.cz>
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
X-CRM114-CacheID: sfid-20250623_115322_291310_7197CD7D 
X-CRM114-Status: GOOD (  29.37  )
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

On Fri, 2025-06-13 at 17:20 +0200, Petr Mladek wrote:
> On Fri 2025-06-06 23:53:44, Marcos Paulo de Souza wrote:
>=20
>=20
> Variant C:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Remove even @flags parameter from console_is_usable() and read both
> values there directly.
>=20
> Many callers read @flags only because they call console_is_usable().
> The change would simplify the code.
>=20
> But there are few exceptions:
>=20
> =C2=A0 1. __nbcon_atomic_flush_pending(), console_flush_all(),
> =C2=A0=C2=A0=C2=A0=C2=A0 and legacy_kthread_should_wakeup() pass @flags t=
o
> =C2=A0=C2=A0=C2=A0=C2=A0 console_is_usable() and also check CON_NBCON fla=
g.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 But CON_NBCON flag is special. It is statically =
initialized
> =C2=A0=C2=A0=C2=A0=C2=A0 and never set/cleared at runtime. It can be chec=
ked without
> =C2=A0=C2=A0=C2=A0=C2=A0 READ_ONCE(). Well, we still might want to be sur=
e that
> =C2=A0=C2=A0=C2=A0=C2=A0 the struct console can't disappear.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 IMHO, this can be solved by a helper function:
>=20
> 	/**
> 	 * console_srcu_is_nbcon - Locklessly check whether the
> console is nbcon
> 	 * @con:	struct console pointer of console to check
> 	 *
> 	 * Requires console_srcu_read_lock to be held, which implies
> that @con might
> 	 * be a registered console. The purpose of holding
> console_srcu_read_lock is
> 	 * to guarantee that no exit/cleanup routines will run if
> the console
> 	 * is currently undergoing unregistration.
> 	 *
> 	 * If the caller is holding the console_list_lock or it is
> _certain_ that
> 	 * @con is not and will not become registered, the caller
> may read
> 	 * @con->flags directly instead.
> 	 *
> 	 * Context: Any context.
> 	 * Return: True when CON_NBCON flag is set.
> 	 */
> 	static inline bool console_is_nbcon(const struct console
> *con)
> 	{
> 		WARN_ON_ONCE(!console_srcu_read_lock_is_held());
>=20
> 		/*
> 		 * The CON_NBCON flag is statically initialized and
> is never
> 		 * set or cleared at runtime.
> 		return data_race(con->flags & CON_NBCON);
> 	}
>=20
>=20
> =C2=A0=C2=A0 2. Another exception is __pr_flush() where console_is_usable=
() is
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 called twice with @use_atomic set "true" a=
nd "false".
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 We would want to read "con->flags" only on=
ce here. A solution
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 would be to add a parameter to check both =
con->write_atomic
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and con->write_thread in a single call.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 But it might actually be enough to check i=
s with the "false"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value because "con->write_thread()" is man=
datory for nbcon
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 consoles. And legacy consoles do not disti=
nguish atomic mode.
>=20

I like this idea. Also, thanks a lot for explaining why the current
version won't work.

I also liked John's proposal to use a a bitmask on console_is_usable,
but I'll think a little on it once I restart working on it this week.

>=20
> My opinion:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> I personally prefer the variant C because:
>=20
> =C2=A0 + Removes one parameter from console_is_usable().
>=20
> =C2=A0 + The lockless synchronization of both global and per-console
> =C2=A0=C2=A0=C2=A0 flags is hidden in console_is_usable().
>=20
> =C2=A0 + The global console_suspended flag will be stored in global
> =C2=A0=C2=A0=C2=A0 variable (in compare with variant D).
>=20
> What do you think, please?

Much better, I'll adapt the code as you suggested.

>=20
> Best Regards,
> Petr
>=20
>=20
> PS: The commit message and the cover letter should better explain
> =C2=A0=C2=A0=C2=A0 the background of this change.
>=20
> =C2=A0=C2=A0=C2=A0 It would be great if the cover letter described the bi=
gger
> =C2=A0=C2=A0=C2=A0 picture, especially the history of the console_suspend=
ed,
> =C2=A0=C2=A0=C2=A0 CON_SUSPENDED, and CON_ENABLED flags. It might use inf=
o
> =C2=A0=C2=A0=C2=A0 from
> =C2=A0=C2=A0=C2=A0 https://lore.kernel.org/lkml/ZyoNZfLT6tlVAWjO@pathway.=
suse.cz/
> =C2=A0=C2=A0=C2=A0 and maybe even this link.
>=20
> =C2=A0=C2=A0=C2=A0 Also this commit message should mention that it partly=
 reverts
> =C2=A0=C2=A0=C2=A0 the commit 9e70a5e109a4a233678 ("printk: Add per-conso=
le
> =C2=A0=C2=A0=C2=A0 suspended state"). But it is not simple revert because
> =C2=A0=C2=A0=C2=A0 we need to preserve the synchronization using
> =C2=A0=C2=A0=C2=A0 the console_list_lock for writing and SRCU for reading=
.

I agree, such a context would even help the reviewers that would spend
some time reading the code and thinking themselves that some code is
being readded for some reason.



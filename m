Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AEB9D2D0E4
	for <linux-um@archiver.kernel.org>; Tue, 13 Jan 2026 12:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2dC4SplNK0CZduFW6/ZkQ29d/9pNlTULD+NHFTfquXY=; b=vyHXbYJa743fEzZ/3MWZG3vcnN
	sz1XxRVWBrdH4XFN8FHk1At4pCa7lOYaxmKG7G1bpVo/6yHV/7BmXB5eCiG2cIWDFKqm1ZivLqmFc
	z3I35262Rs7O0YbhPsMDZlYrj9edZwgBr8c8J7WBRLjShd6fA5WHVfU9CXkqfsfrQg+yso65liL2n
	6oJ1YiWN1c3SI8a+p4hZHZS3hP1pLzWBARAopiPoaB3cUeG01PjZoL/uWNLCkbdgHc8Y0V76LD93d
	XaUxDTboTkAAEt0zNEGhMLbZK7mrrD66NJoMU6MrV1wF4U/N51rghVNgUnp8ZO1e3NAcTW6SVV/bm
	Unhq/ibA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfdif-000000076HI-05Qa;
	Tue, 13 Jan 2026 12:41:57 +0000
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfdic-000000076FY-2v5M
	for linux-um@lists.infradead.org;
	Tue, 13 Jan 2026 12:41:56 +0000
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so63072035e9.2
        for <linux-um@lists.infradead.org>; Tue, 13 Jan 2026 04:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768308113; x=1768912913; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2dC4SplNK0CZduFW6/ZkQ29d/9pNlTULD+NHFTfquXY=;
        b=TErYOwHIPfCFuFFrW1/KDZ9f5K9ULFSajIr9W1i8IO8gNFRTM1i1kewIJsLWUdcQzn
         0h3//+q5vnZAR2EJkqqL9Nzhm5lNqr2IXSy2MNhq1MfcpBu6tBpyVVjNQMmLBptoVGgU
         LheZIJ/0jZGEXqC3GWO6F7VBd20jGahRgoIyVpenCkzQJJDvsxXZF9bEj5M9KDggtfwF
         NyTBQJjqeKtYzeY+JbjJm/ykt/H4QCCW7UKJpplmMggfvuebOUg8yw0WPf5LPw/WEn3y
         sfQYYaDAxkV/oFDrBNtXm8ZyItgCr7qtICDcTd4BdgygzwjThn1LQUj3/asYerdUwi3e
         lI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768308113; x=1768912913;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2dC4SplNK0CZduFW6/ZkQ29d/9pNlTULD+NHFTfquXY=;
        b=azDKEpPcBQ/oNJ0L5ZGX9a7r+xysr8FoOdpK5enGWHNtfRXId9382b9MYr1M3coh6o
         JUIQgnBdzILhUlBJCgGwx4hdY/F4C1ViEs89SM4kGGFAMtzo7DKe4QaVzVeFQkhWQsnX
         p15mNogDu6ktde2QkbklqWH4/7JSFOBf4GQvBm7dFO+hkRLJaUWd8s2yO3fcm8JU+5PN
         KJZ/npEhicHW/AVaPMON/mln2aueOgO9pLlmTgcz+GbIzNsJhdfZbHuKbLEPpqbF1tr1
         pWS/wyXjhWmVjJPLNm9HKeZXuXkSNZAMpDOfp/nCdHhuYDSUc7Fq7kGrrMo1L12audxY
         JALg==
X-Forwarded-Encrypted: i=1; AJvYcCWwrtns+JA3LsR7IwMnfcrry5J7CbkDsJFprTJdbT5HaQC/OFP3iSD+Lqmw9uIpnqSecpnMyjGdZA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz/oXRvkh8myFpTCLLS5RXG7dX6ABYwuEkWRZ0PCQQ59TgX+16E
	wkZa+PliKdxgnNAU9BD3mwwVk7mkNHNuWPxpQC8hx/WDbHmwPceOaLM6TO5e5PU6nw4=
X-Gm-Gg: AY/fxX7cDsnuqz8NGbfIPxien9yOzqfEzthEs8Ml/S2UPUogKgofkZbVk50je2ruLCU
	GZqHeQqDP15JiP0GYvdcLPFRCchQ8R77pBpLqUS6QMQHLkTYL6b18QXIxiVFAcx+BbzOKVl5JLt
	8iJ2fo7JnOdFrFJJKe3L0oZaWJbTz0/K7saernJ/6h6qDO7z/gFmb67vqt0gAlkKKcafxPsmVQi
	ihGys3mjgRL2CHuT1WS8l2hLRFE/FZR085ND9osAqkU4CYCPDnX1nmoOTdCAu533vyAUCQhnYFA
	to19/D1vvRnc0ilDurvc2fKN7nBrc101oAE7HNW6tqOdupOsySuQB9M/6OiAdHktdE1zdq9jrwK
	xirnrmbeGqpr7+cwkI38XP7tFFe/IpnMvWaF1YKUH+Q1AfWag/3I0gFPoFdYvrA8XAn+VOFn97o
	yFPut8MUQkdXhvdgUSrE3lYzsf928q1QxsS4bXdb0cYQ==
X-Google-Smtp-Source: AGHT+IFNQeuw9WMG2h1Davmi36cm1P3WLycSIMCVChnxdfpM9EbZrc4Y9nv7bv2r6hTzREDcGxTpbg==
X-Received: by 2002:a05:600c:a08:b0:477:79c7:8994 with SMTP id 5b1f17b1804b1-47d84b4900bmr279773315e9.30.1768308112530;
        Tue, 13 Jan 2026 04:41:52 -0800 (PST)
Received: from [192.168.3.33] (218.37.160.45.gramnet.com.br. [45.160.37.218])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5013bd680a1sm10831771cf.16.2026.01.13.04.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 04:41:51 -0800 (PST)
Message-ID: <a5d83903fe2d2c2eb21de1527007913ff00847c5.camel@suse.com>
Subject: Re: [PATCH 00/19] printk cleanup - part 3
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Daniel Thompson <daniel@riscstar.com>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov	
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson	 <danielt@kernel.org>, Douglas Anderson
 <dianders@chromium.org>, Petr Mladek	 <pmladek@suse.com>, Steven Rostedt
 <rostedt@goodmis.org>, John Ogness	 <john.ogness@linutronix.de>, Sergey
 Senozhatsky <senozhatsky@chromium.org>,  Jiri Slaby <jirislaby@kernel.org>,
 Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook	
 <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli"	
 <gpiccoli@igalia.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy	 <christophe.leroy@csgroup.eu>, Andreas Larsson
 <andreas@gaisler.com>,  Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue	
 <alexandre.torgue@foss.st.com>, Jacky Huang <ychuang3@nuvoton.com>, 
 Shan-Chun Hung <schung@nuvoton.com>, Laurentiu Tudor
 <laurentiu.tudor@nxp.com>, linux-um@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, 
	linux-serial@vger.kernel.org, netdev@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-hardening@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, 	linux-fsdevel@vger.kernel.org
Date: Tue, 13 Jan 2026 09:41:34 -0300
In-Reply-To: <aVvF2hivCm0vIlfE@aspen.lan>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
	 <aVuz_hpbrk8oSCVC@aspen.lan> <aVvF2hivCm0vIlfE@aspen.lan>
Autocrypt: addr=mpdesouza@suse.com; prefer-encrypt=mutual;
 keydata=mDMEZ/0YqhYJKwYBBAHaRw8BAQdA4JZz0FED+JD5eKlhkNyjDrp6lAGmgR3LPTduPYGPT
 Km0Kk1hcmNvcyBQYXVsbyBkZSBTb3V6YSA8bXBkZXNvdXphQHN1c2UuY29tPoiTBBMWCgA7FiEE2g
 gC66iLbhUsCBoBemssEuRpLLUFAmf9GKoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 QemssEuRpLLWGxwD/S1I0bjp462FlKb81DikrOfWbeJ0FOJP44eRzmn20HmEBALBZIMrfIH2dJ5eM
 GO8seNG8sYiP6JfRjl7Hyqca6YsE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (by Flathub.org) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260113_044154_761710_F3258032 
X-CRM114-Status: GOOD (  29.30  )
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

On Mon, 2026-01-05 at 14:08 +0000, Daniel Thompson wrote:
> On Mon, Jan 05, 2026 at 12:52:14PM +0000, Daniel Thompson wrote:
> > Hi Marcos
> >=20
> > On Sat, Dec 27, 2025 at 09:16:07AM -0300, Marcos Paulo de Souza
> > wrote:
> > > The parts 1 and 2 can be found here [1] and here[2].
> > >=20
> > > The changes proposed in this part 3 are mostly to clarify the
> > > usage of
> > > the interfaces for NBCON, and use the printk helpers more
> > > broadly.
> > > Besides it, it also introduces a new way to register consoles
> > > and drop thes the CON_ENABLED flag. It seems too much, but in
> > > reality
> > > the changes are not complex, and as the title says, it's
> > > basically a
> > > cleanup without changing the functional changes.
> >=20
> > I ran this patchset through the kgdb test suite and I'm afraid it
> > is
> > reporting functional changes.
> >=20
> > Specifically the earlycon support for kdb has regressed (FWIW the
> > problem bisects down to the final patch in the series where
> > CON_ENABLED
> > is removed).
> >=20
> > Reproduction on x86-64 KVM outside of the test suite should be
> > easy:
> >=20
> > =C2=A0=C2=A0=C2=A0 make defconfig
> > =C2=A0=C2=A0=C2=A0 scripts/config \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --enable DEBUG_INFO \
> > 	--enable DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT \
> > 	--enable DEBUG_FS \
> > 	--enable KALLSYMS_ALL \
> > 	--enable MAGIC_SYSRQ \
> > 	--enable KGDB \
> > 	--enable KGDB_TESTS \
> > 	--enable KGDB_KDB \
> > 	--enable KDB_KEYBOARD \
> > 	--enable LKDTM \
> > 	--enable SECURITY_LOCKDOWN_LSM
> > =C2=A0=C2=A0=C2=A0 make olddefconfig
> > =C2=A0=C2=A0=C2=A0 make -j$(nproc)
> > =C2=A0=C2=A0=C2=A0 qemu-system-x86_64 \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -m 1G -smp 2 -nographic \
> > 	-kernel arch/x86/boot/bzImage \
> > 	-append "console=3DttyS0,115200 kgdboc=3DttyS0
> > earlycon=3Duart8250,io,0x3f8 kgdboc_earlycon kgdbwait"
>=20
> Actually I realized there was a simpler reproduction (hinted at by
> the
> missing "printk: legacy bootconsole [uart8250] enabled" in the
> regressed
> case). It looks like the earlycon simply doesn't work and that means
> the
> reproduction doesn't require anything related to kgdb at all. Simply:
>=20
> =C2=A0=C2=A0=C2=A0 make defconfig
> =C2=A0=C2=A0=C2=A0 make -j$(nproc)
> =C2=A0=C2=A0=C2=A0 qemu-system-x86_64 -m 1G -smp 2 -nographic -kernel
> arch/x86/boot/bzImage \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -append "earlycon=3Duart8250,i=
o,0x3f8"
>=20
> With the part 3 patchset applied I get no output from the earlycon
> (without the patch set I get the early boot messages which, as
> expected,
> stop when tty0 comes up).

Hi Daniel, sorry for the late reply! Lots of things to check lately :)

Ok, I reproduced here, thanks a lot for testing kgdboc, it's a quick
way to check that the new register_console_force is not working. Let me
take a look to find what's wrong. Thanks a lot for finding this issue!

>=20
>=20
> Daniel.


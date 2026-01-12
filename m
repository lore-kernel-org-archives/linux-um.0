Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECD5CF45BC
	for <linux-um@archiver.kernel.org>; Mon, 12 Jan 2026 17:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y6BPssvuqQ/qH26ZtP7OKYRtO9FGOS74oztLC07SRNg=; b=iSHbQFX5HSw7ih3t2uJBxM+434
	pteg917avCT5rDL/re6Q2/+qtomAVNpDewVTHMi6SnbEzia3/vpd+a+ZDicIxmQEq0FR+rUMgVvap
	TGFxOk5clWoQ1BHYpIPFFoOqPrNT+H2CQCZvm4udA6vrPJnu5NAfsofdwZrEZlwBXRAA3HcCcUjw/
	aQR3wnZy3d21FcyrDlkUicmP7/tej4p6PgFnuD4lxUYF+1jwzMiPDLeT9g9IGbZKN1wKJLFnh4VkN
	u2/TkjF8UEL5pxFb0OyZq0nnqPO8v1ixnsjWrRiqSttLsR6iPOMcMLfQCAEk/94gWS8ZFPpiBufuN
	JuO2AktA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfM6i-00000005t2m-0ki7;
	Mon, 12 Jan 2026 17:53:36 +0000
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfM6f-00000005t26-0aEJ
	for linux-um@lists.infradead.org;
	Mon, 12 Jan 2026 17:53:34 +0000
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-47755de027eso38648585e9.0
        for <linux-um@lists.infradead.org>; Mon, 12 Jan 2026 09:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768240410; x=1768845210; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y6BPssvuqQ/qH26ZtP7OKYRtO9FGOS74oztLC07SRNg=;
        b=SUDbEYAbPVZZaHJ9rzt9TwXo8SOpViYRBZZMcNpv7P7S06hGMSVSDNrpLkig54mTCh
         2DlafObOOTxmHyca5C95jOnwUR0NmyOcZ+1JRngSknYFpIVWL+dlnYiN8Be1U709q8H+
         Xy09nzYrPzx2/hfu3+fTnk8wgfbqNIb419AkPioZTktue5ahgx6jO72MA5mwwla0xECO
         Nu0tFw7z/UwJy3YQpCb0uBhoagy2qbqK3XGaqiuHEbAOgCYne9EIXbf65RnRuDq7OZy2
         Zs3VFHZ7hfOabh7G76w26VxGYFp9l9U3+dWiFf7gvgBreJKs0+fqzQS8fqBbO+wIJ5n2
         tCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768240410; x=1768845210;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y6BPssvuqQ/qH26ZtP7OKYRtO9FGOS74oztLC07SRNg=;
        b=T5FjCtT/w1UyDNvjlRxxxPClhwXeA8HbxfcPIbYq6o1PnM1v7iXXfcBxpmtfYaz1Cl
         natLqjiUi5PqBLTpBAloHW9x2xdyhHZMSTBgXuCNxBMOdtwA0lnfkGkY2xRwDXvFgjzt
         asEyXegOapbsPmr+mit917WSRfv+zTITSHatevBSOAcb6aYYLzPcsgSYZ9eeQO8Iwc4/
         6YvSc2YGBwxOLgSWpEZPftyXrxZCc28GpLSx6kx2hPVyIvuTcG4PZUZm/TabTbrz9S7v
         gEBBi8mbHDek74M0m5LVvhbUILj4X133IFYFXvVrp0Vr8GwkPU1w2MTrOXmScFCqHDSD
         UbuQ==
X-Gm-Message-State: AOJu0YxIuOgD77Yw8NCIJvhfVSqoph+WbsV0BIpxWHvnT/0Im/++PT6O
	dLTJ/CAHTf4UqQ2dBn+4vQGLY0yDcFjGC4i3LwnL2tFQpW0cer2J33u07KIDdbmwSxE=
X-Gm-Gg: AY/fxX7KO6F/lP+sF3Ds7pi2KLIGcua1jtABYOinqHvkrUuhFW0JUtmYA+IChETGP0D
	NJjwBpnirx1Md7n1255Z4vTWTzU6ZstOmk9LzdAwGHP9P1YaAftk55JsWzVqv+ZSsffkZNWDeZy
	DCsr5vJwaWrdLrkcSX3D0I1qbyJSvi+BHEvlDPcT+Wiia359i9LBHvbPQGbsGRjiUAfKP6lQ6ai
	OTbqucbUPESNT7YENnzmgOnWHWZ6XG5LaoUkzmQLsE81lyIGxqI4ZW1PdtRbY7j2OLa3EyQQOYw
	7Wr1i3Y3mi07fgEjmsx331h1ueRiBgo5H0pRUaemRwBGLOaPXdIMuK0dg2gIxVm6qTTvKgL45K7
	vlI1GzrVzGkry8yyeljS1o0DcJpCxmjbl+CieDBV+Pk90xz5h/r8ijG7Ypl3KoNG/Uz5FFUFP8e
	tcJrX3VcnKFTAgEu74vVOvl2gAVkcuoLEjmJh0QFsxeA==
X-Google-Smtp-Source: AGHT+IGfCgsoYudB43gyY5VgiMyajRCyMKVvdA/K1TPc0FTW2J7Pqnzu3xNux2u9C7uenfxIM0LM/g==
X-Received: by 2002:a05:600c:4e8a:b0:479:1b0f:dfff with SMTP id 5b1f17b1804b1-47d84b170famr247229235e9.10.1768240410449;
        Mon, 12 Jan 2026 09:53:30 -0800 (PST)
Received: from [192.168.3.33] (218.37.160.45.gramnet.com.br. [45.160.37.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f69e13bsm368953115e9.7.2026.01.12.09.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 09:53:30 -0800 (PST)
Message-ID: <0585581cd2f19544c5e1565a9d241697d812b5f9.camel@suse.com>
Subject: Re: [PATCH 00/19] printk cleanup - part 3
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Andreas Larsson <andreas@gaisler.com>, Richard Weinberger
 <richard@nod.at>,  Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes
 Berg <johannes@sipsolutions.net>, Greg Kroah-Hartman
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
 Christophe Leroy	 <christophe.leroy@csgroup.eu>, Alexander Shishkin	
 <alexander.shishkin@linux.intel.com>, Maxime Coquelin	
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>,  Jacky Huang <ychuang3@nuvoton.com>,
 Shan-Chun Hung <schung@nuvoton.com>, Laurentiu Tudor	
 <laurentiu.tudor@nxp.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org, 
	netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	sparclinux@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Date: Mon, 12 Jan 2026 14:53:12 -0300
In-Reply-To: <836139d1-1425-4381-bb84-6c2654a4d239@gaisler.com>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
	 <836139d1-1425-4381-bb84-6c2654a4d239@gaisler.com>
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
X-CRM114-CacheID: sfid-20260112_095333_208518_8CB1D9FE 
X-CRM114-Status: GOOD (  14.38  )
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

On Wed, 2026-01-07 at 11:22 +0100, Andreas Larsson wrote:
> On 2025-12-27 13:16, Marcos Paulo de Souza wrote:
> > The parts 1 and 2 can be found here [1] and here[2].
> >=20
> > The changes proposed in this part 3 are mostly to clarify the usage
> > of
> > the interfaces for NBCON, and use the printk helpers more broadly.
> > Besides it, it also introduces a new way to register consoles
> > and drop thes the CON_ENABLED flag. It seems too much, but in
> > reality
> > the changes are not complex, and as the title says, it's basically
> > a
> > cleanup without changing the functional changes.
>=20
> Hi,
>=20
> Patches 7-17 all say "replacing the CON_ENABLE flag" in their
> descriptions, which should rather be "replacing the CON_ENABLED
> flag".

That's true, thanks for spotting!

>=20
> Cheers,
> Andreas


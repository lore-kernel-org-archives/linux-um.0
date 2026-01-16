Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4607FC2A06C
	for <linux-um@archiver.kernel.org>; Fri, 16 Jan 2026 13:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2Jyc4vjPWHQ8N29GFPPd4QPUxfDxmdAZddY3K56YrUM=; b=JxdewrecvXPzupOWJQaStmlcDG
	JFCLb2Z+9oTk/Pt3iGi/uqrVy9VpM6NHS6ocbW6SFXXg+AYUVIspLpcLrJZERjxpSZryRKh6V3OTW
	Mn2hmRmIodqYsyC+Lp8Z6UHw+mkWT8WJONB0T03WlPDvvQCHch7B6VztiuvA18JiCeqqfkyID5yaF
	RjbUBdTTujhxukq9MxHdehehI2khyw6fuOq6xWO+R+Z85CK3GuBomIibPMqUsYICCMqap1gGyYnKg
	DfFt+NwY50f6S255hFMlZ5VzHyTWM/5zWZqUbMVBfoN1V/i3oQRGx6y0zlo/XEOsPDoa6MSAMySZh
	SjR/AOpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgkHY-0000000EDJq-1b2h;
	Fri, 16 Jan 2026 13:54:32 +0000
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgkHV-0000000EDJC-3Zd8
	for linux-um@lists.infradead.org;
	Fri, 16 Jan 2026 13:54:31 +0000
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-42fb2314eb0so1644013f8f.2
        for <linux-um@lists.infradead.org>; Fri, 16 Jan 2026 05:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768571667; x=1769176467; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Jyc4vjPWHQ8N29GFPPd4QPUxfDxmdAZddY3K56YrUM=;
        b=MNXhCnAm3dFbco+cF4hYHNOWoWSDpyL7rHYxWrPy2rQp9M5Wjfd5cXgKUICdqrcm9j
         3T2KDI5AmU9HhYSRvCKvMXXRmKGjYz5x8oaw+yvUidJ7BGcnVmyWWWAVmBbo6b7DLVFa
         Z/ejbQeZLjhmSrrZVMANCmA6u4427yfw8GJIjzlhDxRZa7UjeSBhqHdcoP0f40Ff/UxX
         aECrPw/knRwH70m8oJHU0M4pSP+WYyoevHomqCilqAWnQJXIUuDfbkSzFKuoUl9YZVlc
         GF/BJ95hBz5Uiqg1kQjKotGM8VAur6ow16csbYXYuh3g1mVaSRG7UVnhNIzKs0K40Un3
         AJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768571667; x=1769176467;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Jyc4vjPWHQ8N29GFPPd4QPUxfDxmdAZddY3K56YrUM=;
        b=FyCcDgocBGZaosEXn95is3eFkelEurcb4zBtaIRbA/0R9l1f33DB+rDnd2TsBjjTf7
         YZivg1NmATY+xlGWGqU7cWxmZz5jSKl/ApJYL92TUf+mECd3BRyZ1focNMdYMheDHuIa
         ZU/Zhsfdt4TBNJkcjSntUDHi8mzs+YNLynhWYelm1zjEUUjUq67bd1YeYrxrCHvahKcm
         CSr/L+zJF2JsUeSoQRlIQxoQS93RjwBFxMlQRdFvJDPc/aiq8hyRuLQUizp73swRqdze
         2AyhPfPq8iQ6kSkKYyPQZV/+eIsRdjCASG5UkQdPby3foTqVxVvnrMbdIosgT9cwBvBJ
         OMRA==
X-Gm-Message-State: AOJu0YyWH5TcBUNdIMjYVmKjWbJil1QqzJrH/YSyZm2ETgUyeoQgNZAG
	lzB5ChHZIFhyG9IBlBpy6BM0uHEGplnLcS5ionJvPGDkJogx+kXzegbOL1n6AvMhJ48=
X-Gm-Gg: AY/fxX4jm52LL9ANXFlka7UkLZZBLM5vay2fEeFWarLyOZwH3BiK9MQhPZpTYn0W/gX
	xQFZsxYFbLg9AcZLCJ83yd9ZQ7UrRlCXizO8VhwWJBiF1IlBAShctiY6JCy+Hbf2o1N4ARs3ntu
	f1ezvouzi406eYE81qekvdbW5OjlK2f+tIIx1W2fP8XvbOescGQhRJYxoRpSkLrsWfcsrc2DlNI
	kIvhlBqNRpvzunUBnrG8Vyxt6oUTbwZ2v01hyKOCDPNcOof3Nk1fgcxnxwKgMnl4dJWzRnhNE3s
	+Yjf0ZEW56NqSPYIZr9R11DngV4vPXPsTRvl8PFhD1Q8BTPPxohhqZyMLh5+yx/APQOuMI/oZuZ
	Cu9866E/e+d09nb8oZsDo17bywGF6D8kMaKTN66HAjFdNBlAIIuvULb9NK4t7vqLyw4VN4YhDxX
	BhIFRkSGejSOUUDy5d7ITK111h/3Z6oT7owMtZ8TE=
X-Received: by 2002:a05:6000:4387:b0:431:1ae:a3d0 with SMTP id ffacd0b85a97d-435699810a1mr3695386f8f.25.1768571667158;
        Fri, 16 Jan 2026 05:54:27 -0800 (PST)
Received: from [192.168.3.33] (97.36.160.45.gramnet.com.br. [45.160.36.97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435696fbea8sm5433542f8f.0.2026.01.16.05.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 05:54:26 -0800 (PST)
Message-ID: <6168099632390068c8544b48f2e81bf737aa10d7.camel@suse.com>
Subject: Re: [PATCH 14/19] drivers: hwtracing: stm: console.c: Migrate to
 register_console_force helper
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>, Richard
 Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg	
 <johannes@sipsolutions.net>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>, Douglas Anderson	
 <dianders@chromium.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt	
 <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Jiri Slaby <jirislaby@kernel.org>,
 Breno Leitao <leitao@debian.org>,  Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet	
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni	
 <pabeni@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook	
 <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli"	
 <gpiccoli@igalia.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy	 <christophe.leroy@csgroup.eu>, Andreas Larsson
 <andreas@gaisler.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Jacky Huang	
 <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, Laurentiu
 Tudor	 <laurentiu.tudor@nxp.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org, 
	netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	sparclinux@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Date: Fri, 16 Jan 2026 10:54:14 -0300
In-Reply-To: <83zf6daetu.fsf@black.igk.intel.com>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
	 <20251227-printk-cleanup-part3-v1-14-21a291bcf197@suse.com>
	 <83zf6daetu.fsf@black.igk.intel.com>
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
X-CRM114-CacheID: sfid-20260116_055429_907005_C424D8D3 
X-CRM114-Status: GOOD (  11.18  )
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

On Fri, 2026-01-16 at 14:04 +0100, Alexander Shishkin wrote:
> Marcos Paulo de Souza <mpdesouza@suse.com> writes:
>=20
> > The register_console_force function was introduced to register
> > consoles
> > even on the presence of default consoles, replacing the CON_ENABLE
> > flag
> > that was forcing the same behavior.
> >=20
> > No functional changes.
> >=20
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
>=20
> Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>

Thanks Alexander!

>=20
> Should I pick this up or will you send this with the rest of the
> series?

I'll need a v2, since some things will also change in other parts of
the patchset, so I would wait for the next version.

>=20
> Cheers,
> --
> Alex


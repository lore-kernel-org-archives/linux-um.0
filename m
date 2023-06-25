Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8763AEB64DC
	for <linux-um@archiver.kernel.org>; Sun, 25 Jun 2023 21:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XNGcfSUS3uY+EE57b1H5Xw56RF3bGeiQY4Gy9h2Gm2Q=; b=uOvpHGL1MKzgVj
	0mR/qJgOfQ6UUMKAVU7QvPvBIobZ0nLVLz1bOE3D/6hQ10CE9Xkjl7g2PuQxEeIvMHJLFJ+7mT4qp
	6C3L/HRur4aY3kpD3ORJr+b/JmpnvQbH63PcG6PUwVufFqfooZ5AHOM2/WhkLSWjoyVuIRzF4GKZY
	ZiSWnXs1uLKPMcgIJUffbIqvtlbU8LOcj5OBUpxd3AJGuxxIUGQcsVCDuB+JzzN1g5ODM6h5SAE0s
	6X48R8in2KgzwJZc/5w/tTLDjxNTwRDmXibIezBzsCATiPpC2fZfj9MK2n/MFbVS3FcxDVKMHELO7
	+ogErqI3CQMhYutZHkwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qDXHW-008kgu-0G;
	Sun, 25 Jun 2023 21:28:26 +0000
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qDXHT-008kfd-1p
	for linux-um@lists.infradead.org;
	Sun, 25 Jun 2023 21:28:24 +0000
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-311099fac92so3761458f8f.0
        for <linux-um@lists.infradead.org>; Sun, 25 Jun 2023 14:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687728501; x=1690320501;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eMexNiIRy9oTUPu+gxyIQBAQ495HkmhaJAzybvKUJRI=;
        b=papCXwz4FQ+rLuJHibopRsi98zD0kIYG0DOxn6ywfikL/uYFQ+MfDBvWgm3cHnA/lP
         PVJwSnw++RjnC9pZJ36Kcb1Dn9tOT69N2tCEMwM7tVzBv88TXkhppogwCz1RY6W3YvVe
         Gl7K0nJEHXdJYQBVoi2pQGhTBgpoOZbDeMfs4/NiRUv9E7QznLGzWwRQ1Ou+X7tcblU3
         4yiO9GFqu44/QpUAKHHtYjvOXtdgm0yu4g3o2Om0KNrksywhZPAWiYW7FEm4elDyXv5o
         BMvkjoxmdvSA1ZNrWSkgQa2nxDlnouHPz6jy7JPoPIFmd50JN+jOycdowBFgMEw2UbUH
         X+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687728501; x=1690320501;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eMexNiIRy9oTUPu+gxyIQBAQ495HkmhaJAzybvKUJRI=;
        b=Jx2XgwCb2Ku8HmDvs/xf+XPgxhrqgHO3GrGNixoDKguK/bBT1iSDzTCKtkYYANbZED
         6g6wDvjWgN12hOxU1GtpHJO88obms2ZNXSufH6+t45Cal9DdDjIghniiyuvlnLxKoupE
         fM209u2YYXC8Lxw64F3LxtcA8qCuu1YqvvAdsoAufbiC/Egsrq1lSLmjT1a2K5/1eknQ
         9scL+fHOU1IBeyGesRvTuFzQNlOik/MaKWBNELA3Wiu8RT7/JkoGXv4T5GZoeFdJRxf9
         12fsvsKzpy2p+gvUNeRzotny4zMm5gJ38zkyMZ/IJmMGID+EvH1AuD9IetOyD/QEdWZI
         MXHQ==
X-Gm-Message-State: AC+VfDzbnb18bOoi8ogHebZ/RFBQ2LbKR2Y2jlQt9LwqG7/ARmO+ChFY
	Daxf98311HubLS1CYoSkTvPU1aWQpt/fPceIVr4=
X-Google-Smtp-Source: ACHHUZ773Gc1VRsoALOlLX+eTKJvNy9FMYEhjB0U9nB/aZKzSBP7vPbMNT7BTLVf01D/i+3QzXdclg==
X-Received: by 2002:a5d:6ad1:0:b0:30a:e69d:7219 with SMTP id u17-20020a5d6ad1000000b0030ae69d7219mr22239047wrw.65.1687728501664;
        Sun, 25 Jun 2023 14:28:21 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.212.184])
        by smtp.gmail.com with ESMTPSA id oz31-20020a170906cd1f00b0098860721959sm2459759ejb.198.2023.06.25.14.28.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 14:28:21 -0700 (PDT)
Message-ID: <a0eec475-cfc0-f298-d370-aae0c0a7a3da@linaro.org>
Date: Sun, 25 Jun 2023 23:28:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [patch 10/17] um/cpu: Switch to arch_cpu_finalize_init()
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 Nikolay Borisov <nik.borisov@suse.com>,
 "Ahmed S. Darwish" <darwi@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org,
 Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 linux-ia64@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org, Richard Henderson
 <richard.henderson@linaro.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Chris Zankel <chris@zankel.net>,
 Tom Lendacky <thomas.lendacky@amd.com>
References: <20230613223827.532680283@linutronix.de>
 <20230613224545.493148694@linutronix.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230613224545.493148694@linutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230625_142823_608964_975B4A67 
X-CRM114-Status: GOOD (  10.85  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

T24gMTQvNi8yMyAwMTozOSwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOgo+IGNoZWNrX2J1Z3MoKSBp
cyBhYm91dCB0byBiZSBwaGFzZWQgb3V0LiBTd2l0Y2ggb3ZlciB0byB0aGUgbmV3Cj4gYXJjaF9j
cHVfZmluYWxpemVfaW5pdCgpIGltcGxlbWVudGF0aW9uLgo+IAo+IE5vIGZ1bmN0aW9uYWwgY2hh
bmdlLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4
LmRlPgo+IENjOiBSaWNoYXJkIFdlaW5iZXJnZXIgPHJpY2hhcmRAbm9kLmF0Pgo+IENjOiBBbnRv
biBJdmFub3YgPGFudG9uLml2YW5vdkBjYW1icmlkZ2VncmV5cy5jb20+Cj4gQ2M6IEpvaGFubmVz
IEJlcmcgPGpvaGFubmVzQHNpcHNvbHV0aW9ucy5uZXQ+Cj4gQ2M6IGxpbnV4LXVtQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKPiAtLS0KPiAgIGFyY2gvdW0vS2NvbmZpZyAgICAgICAgICAgIHwgICAgMSAr
Cj4gICBhcmNoL3VtL2luY2x1ZGUvYXNtL2J1Z3MuaCB8ICAgIDcgLS0tLS0tLQo+ICAgYXJjaC91
bS9rZXJuZWwvdW1fYXJjaC5jICAgfCAgICAzICsrLQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCgpSZXZpZXdlZC1ieTogUGhpbGlwcGUgTWF0aGll
dS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtdW0K

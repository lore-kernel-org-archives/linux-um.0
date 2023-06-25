Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A33CEB64DC
	for <linux-um@archiver.kernel.org>; Sun, 25 Jun 2023 21:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6CaHBSwQ5cVnjH6qoWP4iso2Lt6hBt8V23j+1RjSv8o=; b=nI+Mr/6wXdqBss
	aHUyuwig5WJTPgAHyLReeXE4N4b9aLvNN7nqxYjuzgU8RNUt579UR1h3kTEVdCCZfBHeDEkBEkSUo
	OwmmiaygRoC8PBGGQbLRfKFOBpQnSQT3AiUiIR3IB4ee33VGi8eji3FSAU40XIL5F/SBrd3Qe9aO6
	57H4xjKjqk4d8G+TZohVaiBX233iVaHqbMRX217IEwVn2MLsLMAXBb3LH3FuVc9nN0JJ6ilOyMD+U
	qbjJ1vr5WXjWu6vwhq8TWMa0Fs219ZFaGsDf3VAc67onGHO4l1tc+VZlsxp5zePu9xbjF8HT3x2Zr
	L0qP7JnOFr7S4tw8tCrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qDXH1-008kaT-36;
	Sun, 25 Jun 2023 21:27:55 +0000
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qDXH0-008kYR-0I
	for linux-um@lists.infradead.org;
	Sun, 25 Jun 2023 21:27:55 +0000
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31126037f41so3183928f8f.2
        for <linux-um@lists.infradead.org>; Sun, 25 Jun 2023 14:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687728466; x=1690320466;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=75eDqtaV4HxjbOY0L3WJNiE0VV9dzyg9cgqtVXJznBY=;
        b=P4OMFY0E+kb5eR0W9Y6kEgLPJuc6u7faK0X1O+XQGbwqlajdF/jfFWAcx8BRjDqGzO
         mh6gHGoaEUDX+sh3nKQRSDJ7HA0jh2sHDYtRXrtRDSCN3zTIndInhtFLLYMRLTUVyOKS
         YpCq/XTlPUo+K6NWRXFBXfXuAiMnnc5n0pIhRCxDVLvmATOI8nFzSZ2lOhnffLdUEmwd
         VeArt9sQbwQphWxkK4kf1essGtLoTUS/ckhnahsuy5pt7r3o+oJjlr5xYi1q+x0YAcvy
         jUeA3jWRJo1IshymxkGUWJrB/2Mitej5Iu/x3GJN9KZtlWpfpaIlbv4Lf+DJiRh45Kkw
         WFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687728466; x=1690320466;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=75eDqtaV4HxjbOY0L3WJNiE0VV9dzyg9cgqtVXJznBY=;
        b=DZvi8vjIhlvZTFWSAgTtIetE7Bwv9xz0KCY+ODB1GnaBXc2uxHR/Zfbo0hk9zyiRh2
         nH7UhkGiAwozauvbtPdBG4o9IcWmIJNVg79gvxnvi+Fvv7fXT2A70hxQUJbl8omMMLtN
         jlG5jFZWOGUM4akKqz5G31CtPd1TsBVsjJhdzK2zbnFJHNT/sboi1rgzUU2dgR9dAz+m
         ZlDUoMA9GWti8J4yFRppUVtwfQ+m2MnK3soeHQFVUtgX++cLn3K2RG8V5BfF2a9FvoS0
         fXCKGWioA+JyKw8DF2oNCImhObaKmQsr7guuWyOgK1//0dtvKO+01PDX54SErYuh+HkT
         H7sQ==
X-Gm-Message-State: AC+VfDxIL3rFNHDDf6Nq8ZQMS7yCA1Otkt7Kd7P+F1clkE5zaEuJFvOS
	ROpDTElBqpC2u9w8LbseHTv5Pg==
X-Google-Smtp-Source: ACHHUZ6Hjasu9Lrk/CatQAEzcCmcG0JhA1BO0YkpChmI4xEA5JcA/nNpFTMJqb3YFVfr7dLSsRzufQ==
X-Received: by 2002:a5d:474f:0:b0:313:f07b:8027 with SMTP id o15-20020a5d474f000000b00313f07b8027mr1072096wrs.36.1687728466257;
        Sun, 25 Jun 2023 14:27:46 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.212.184])
        by smtp.gmail.com with ESMTPSA id r13-20020adfe68d000000b0030fb4b55c13sm5420254wrm.96.2023.06.25.14.27.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 14:27:45 -0700 (PDT)
Message-ID: <9c362e4f-ba40-02a6-fb22-aed6598ec536@linaro.org>
Date: Sun, 25 Jun 2023 23:27:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [patch 03/17] ARM: cpu: Switch to arch_cpu_finalize_init()
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 Nikolay Borisov <nik.borisov@suse.com>,
 "Ahmed S. Darwish" <darwi@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 linux-ia64@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org,
 Richard Henderson <richard.henderson@linaro.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Chris Zankel <chris@zankel.net>,
 Tom Lendacky <thomas.lendacky@amd.com>
References: <20230613223827.532680283@linutronix.de>
 <20230613224545.078124882@linutronix.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230613224545.078124882@linutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230625_142754_131111_072A7937 
X-CRM114-Status: GOOD (  11.05  )
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
LmRlPgo+IENjOiBSdXNzZWxsIEtpbmcgPGxpbnV4QGFybWxpbnV4Lm9yZy51az4KPiBDYzogQXJu
ZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4KPiBDYzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnCj4gLS0tCj4gICBhcmNoL2FybS9LY29uZmlnICAgICAgICAgICAgfCAgICAx
ICsKPiAgIGFyY2gvYXJtL2luY2x1ZGUvYXNtL2J1Z3MuaCB8ICAgIDQgLS0tLQo+ICAgYXJjaC9h
cm0va2VybmVsL2J1Z3MuYyAgICAgIHwgICAgMyArKy0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhp
ZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4KCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LXVtCg==

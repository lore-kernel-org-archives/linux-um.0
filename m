Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8126C0015E
	for <linux-um@archiver.kernel.org>; Sun, 25 Jun 2023 21:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ouEYnkzhZEwZmNT49LZimYDueYZUnYY1bpNaVsQsAns=; b=qiF1xJ9oftqvlv
	UvElqn7Zupb3GAtlYriszzyfcovOHVozqr0dygANKLKOcLo9GlljXJh8bot2fT6ZMxygaBLveXLcC
	yyo93S1YkqZq3CQp4jMOJe2Oi+BsbNwarI6mwx8ib6Ha9jgTxdWI3oHEFdZ9SG/ze1Crq/Td7ifGR
	HARfIHd6OfG7FBtwHdEiakyEWKLPvo7wMp/ANGxl7F+VJ6R53PSJYYm6l1WlgKuXlFpkV5rdMEwp/
	2vBRZyfH3f5fpsQ9e7yvR2XOsx6ynIWiwj/YSKguXmWlidOguEUZlGQUsZgT8CiVTalWaMTcAdN6S
	q37e4Sl5aDuWmAbVGTwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qDXEL-008kDy-1J;
	Sun, 25 Jun 2023 21:25:09 +0000
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qDXEI-008kCa-1S
	for linux-um@lists.infradead.org;
	Sun, 25 Jun 2023 21:25:07 +0000
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3112c11fdc9so2103565f8f.3
        for <linux-um@lists.infradead.org>; Sun, 25 Jun 2023 14:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687728304; x=1690320304;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vpEvNkmFhBPV/sgQmjmG/u9Az5tks6N1ix3FgBzMzh4=;
        b=XPi3AIP3sHw/BiO9+D1QLKVd26npdK3hmROeMnfMD+84Rh7ecz07cFV1swOBqXg2Jp
         0fYlEdumqqAmZnsD4c0N4E+xYKJGzbqinIAzjIRtEMYWWX8mGRqfd8h4ESKBkfPGFdq8
         YNwatYm5vad4u0IcrGPsfChk+hpNKBJX76sCWZaJEc4+kJuWrzixgLlp5Svn3tE4QbpK
         fXM+FXw1wkuFTFMHVyVo8pTDCh50D0x7kVjvYj6JmD68K8XJJPrAs39LDdbjhhokqL9d
         Rc2iUKAA9C58yEN2oWVJHYJnyuzWkmGbL5KMMDSfIEll9802O22bE8Tz3ElK+l0KZcPI
         247A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687728304; x=1690320304;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vpEvNkmFhBPV/sgQmjmG/u9Az5tks6N1ix3FgBzMzh4=;
        b=RcoWo7D39lpPqnjQ00VIyz6NfiZ9FjvqtF9hr+8eyv8YDP7bO5VQsDEwsXnpCj9Jxd
         wEibRIQJT8zKXdAPoHI4FYAdlAsys6CsQmTZITxmxwslyKuol/p+g8PQ+VD1EnfuDA9M
         vghZqZ1vvAxFgu2V8fmcQV8z4LUCVf7NDrB/mTUIjaBcXrqTtnCh8dnpqwN+SQ3cOf/H
         g5NWn0CFWi7AfhtXjPf8CgRIPYUYEGi9xPj7Za2J/jVQ/3Dvxh6mAgehMz5JpFwWa228
         X8tCS9rUinrPgsaLuGVUs38gAjXRqCjVQToXgtbbflEj7jqMuywIpc0J+ALB0/F9Qzqj
         mAow==
X-Gm-Message-State: AC+VfDwJ7pa9nGFclS4Ab9MiFzSYqkWgiCH7d1GO2GSeZzQlYb/QtdGl
	c2DxvYZa1eYfxeybrUeQ79OPDQ==
X-Google-Smtp-Source: ACHHUZ6w/KTem4en6DpoUOTRJpkCeba0iSA1Pbh0dhzDh23gdYN0n6DSJL7HItwPFWno5XUjveDcqg==
X-Received: by 2002:a05:6000:1962:b0:311:9a5:2d63 with SMTP id da2-20020a056000196200b0031109a52d63mr7485836wrb.42.1687728303983;
        Sun, 25 Jun 2023 14:25:03 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.212.184])
        by smtp.gmail.com with ESMTPSA id s25-20020a7bc399000000b003fa96fe2bebsm788890wmj.41.2023.06.25.14.24.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 14:25:03 -0700 (PDT)
Message-ID: <e8d8ee2b-1faa-1d60-d230-cbef8aecacef@linaro.org>
Date: Sun, 25 Jun 2023 23:24:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [patch 05/17] loongarch/cpu: Switch to arch_cpu_finalize_init()
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 Nikolay Borisov <nik.borisov@suse.com>,
 "Ahmed S. Darwish" <darwi@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 loongarch@lists.linux.dev, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
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
 <20230613224545.195288218@linutronix.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230613224545.195288218@linutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230625_142506_496323_4753AFB4 
X-CRM114-Status: GOOD (  10.31  )
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
LmRlPgo+IENjOiBIdWFjYWkgQ2hlbiA8Y2hlbmh1YWNhaUBrZXJuZWwub3JnPgo+IENjOiBXQU5H
IFh1ZXJ1aSA8a2VybmVsQHhlbjBuLm5hbWU+Cj4gQ2M6IGxvb25nYXJjaEBsaXN0cy5saW51eC5k
ZXYKPiAtLS0KPiAgIGFyY2gvbG9vbmdhcmNoL0tjb25maWcgICAgICAgICAgICB8ICAgIDEgKwo+
ICAgYXJjaC9sb29uZ2FyY2gvaW5jbHVkZS9hc20vYnVncy5oIHwgICAxNSAtLS0tLS0tLS0tLS0t
LS0KPiAgIGFyY2gvbG9vbmdhcmNoL2tlcm5lbC9zZXR1cC5jICAgICB8ICAgIDQgKystLQo+ICAg
MyBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQoKUmV2aWV3
ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4KCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWls
aW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==

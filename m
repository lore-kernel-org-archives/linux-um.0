Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40394C001DC
	for <linux-um@archiver.kernel.org>; Sun, 25 Jun 2023 21:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8dX5yHsbPB11E9RPYgc72SDReM2GbKOCoAotLl4rzjg=; b=b3/8G2og54U6Q2
	sNKM0/MwjPI6GsrqG+yXhx8V24Sg1LiWmaK7RPxoNQohwI1Ma0dbeeTIDJStnLRcCrkTX0j44NMo+
	9KiQAYIEC2MmX0n72uOQCEyZCvXYxKtDiJzHaq/Hf3SIdCFYgm0eRoLeaObso80NsrsRFseoHt/1Q
	mASYgj/Widr99AslnGcNH4J2byzHzpZbk22c6O+tDgNpBOAszbm0BLZkLTXgu971dsHOit50tqu06
	9yz68yPnQ4WB/NGNiHYc617s9lqd2ibWG/g/puQfz03We3QLkRUR1kzENjrHmN0IvEhLPt7oSeBwj
	0Q9vs/amMQF05biSYA4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qDXIb-008ks8-0N;
	Sun, 25 Jun 2023 21:29:33 +0000
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qDXIY-008kr4-10
	for linux-um@lists.infradead.org;
	Sun, 25 Jun 2023 21:29:31 +0000
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51d885b0256so2178789a12.2
        for <linux-um@lists.infradead.org>; Sun, 25 Jun 2023 14:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687728568; x=1690320568;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oTfH9M3OupFue5fNOr2kpTWCwfS7CIJdAlc3JsK0Z60=;
        b=WH/Pv0vC60dg5LQaXetqwdJJ6gjX7TusNMO/6iV4l0+yEMcucIdKzH16maZbw+gTE5
         bshBq+m3EagON7qXgXpaeY3Un14Jg16gEBw2eG4rUP20MyBy+A9q9mtRg8NoKwlY2OML
         TDDRBqeD9jmqc8UzGL0fFSAtFv4NlYyGxfShWltouCZTqRFI0WJHBKqdmCCdT1ygEajo
         5uUfdycgw8QO56TYvmSWQwVtkORbn27Fu+tszv/t2sVHdmnGBUoc8/oMvM4hempXllrh
         km1os10Um941Jb7ftk00Q23nOUsTQnvKjTHQr63vApUgH2LMz7AIepbPGoouhh6C8NYy
         QxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687728568; x=1690320568;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oTfH9M3OupFue5fNOr2kpTWCwfS7CIJdAlc3JsK0Z60=;
        b=kFcNWWRPicFOdBKSy3pKAVRJvpZCIFXcxYB1Yc9pza94acGgSLc95CdwHq13bkioce
         OL8uAxt9MX40UKz80arqjDg+1obRKZpxSdDYFAqwSOIO/36RVaMSZLBG2dLZoLoM0Q51
         86H5RxQy0pKjs5BvMiFcnOC/9FZLzb3S3y/QaHuaUWdDwJfqoG+2TZGwWLJjg7CVVP5a
         tbFBacigbYRvyMTcJouxKTCFV4nDcIMSLVB+yh0Zo5ooCrrN0QDF6z7gfTQ20NPWESKO
         ikf1tp7qG9yT6qTIamNE7HTeMFC9CPaqD1GX8ywhAfzlvLtPTeC/u4gxxeQNR9XE7yqR
         yr2Q==
X-Gm-Message-State: AC+VfDyDdC7gGsTA1uE0yv8r+qmweZWJARDX2aKXApCthcLoFa9RO45G
	emZGADVoJlKc8wWzzGB5445TUQ==
X-Google-Smtp-Source: ACHHUZ49hN41Iny38CX7JC8bw+Nt2eRb4muhVoX8pGYEOfz9mbYhziaAQCpgxSX5VcO2Bvt9aJ8PYw==
X-Received: by 2002:aa7:d697:0:b0:51d:9dae:a591 with SMTP id d23-20020aa7d697000000b0051d9daea591mr102645edr.21.1687728567863;
        Sun, 25 Jun 2023 14:29:27 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.212.184])
        by smtp.gmail.com with ESMTPSA id m5-20020aa7d345000000b0051495ce23absm2138387edr.10.2023.06.25.14.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 14:29:27 -0700 (PDT)
Message-ID: <9c97fcb7-bbb2-d792-6167-dc8faff0c76d@linaro.org>
Date: Sun, 25 Jun 2023 23:29:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [patch 08/17] sh/cpu: Switch to arch_cpu_finalize_init()
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 Nikolay Borisov <nik.borisov@suse.com>,
 "Ahmed S. Darwish" <darwi@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-sh@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 loongarch@lists.linux.dev, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-m68k@lists.linux-m68k.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org,
 Richard Henderson <richard.henderson@linaro.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Chris Zankel <chris@zankel.net>,
 Tom Lendacky <thomas.lendacky@amd.com>
References: <20230613223827.532680283@linutronix.de>
 <20230613224545.371697797@linutronix.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230613224545.371697797@linutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230625_142930_357308_A25B0E22 
X-CRM114-Status: UNSURE (   9.87  )
X-CRM114-Notice: Please train this message.
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
LmRlPgo+IENjOiBZb3NoaW5vcmkgU2F0byA8eXNhdG9AdXNlcnMuc291cmNlZm9yZ2UuanA+Cj4g
Q2M6IFJpY2ggRmVsa2VyIDxkYWxpYXNAbGliYy5vcmc+Cj4gQ2M6IEpvaG4gUGF1bCBBZHJpYW4g
R2xhdWJpdHogPGdsYXViaXR6QHBoeXNpay5mdS1iZXJsaW4uZGU+Cj4gQ2M6IGxpbnV4LXNoQHZn
ZXIua2VybmVsLm9yZwo+IC0tLQo+ICAgYXJjaC9zaC9LY29uZmlnICAgICAgICAgICAgICAgICB8
ICAgIDEKPiAgIGFyY2gvc2gvaW5jbHVkZS9hc20vYnVncy5oICAgICAgfCAgIDc0IC0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAgIGFyY2gvc2gvaW5jbHVkZS9hc20v
cHJvY2Vzc29yLmggfCAgICAyICsKPiAgIGFyY2gvc2gva2VybmVsL2lkbGUuYyAgICAgICAgICAg
fCAgICAxCj4gICBhcmNoL3NoL2tlcm5lbC9zZXR1cC5jICAgICAgICAgIHwgICA1NSArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKwo+ICAgNSBmaWxlcyBjaGFuZ2VkLCA1OSBpbnNlcnRpb25z
KCspLCA3NCBkZWxldGlvbnMoLSkKClJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSA8cGhpbG1kQGxpbmFyby5vcmc+CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC11bQo=

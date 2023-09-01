Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE8BCA0FF3
	for <linux-um@archiver.kernel.org>; Fri,  1 Sep 2023 18:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=93NSDdZaqaMxyi4ZbuyyCf6Mqc8g1NveGeL9ykXrIMo=; b=0AkSkoiHppnuEb
	4W7xr0AeejiZtKLqOHlXMGM6LkICf+4RdXIJHw4TbGNoqBYRJ8ATXVbPhuwZtjgVnXOJxWwo/CrTo
	reiVOielQLvYvYkwYzWXf2fYqxTWFQyMpOMA2oLQrr5U2fJA4sEwgMe6/fqZDNt0qVwRwTL9GwJBr
	OtjEzTmXvQ6lGDDKHNQr85o8kb3tHVgrZduLzaMPWnEw/eWicxSThTovP/ip446eE3IMWwHc68yfL
	IlSgDUOMjZY2ZDLiyEREmFsZlGBJV51iO1g/HGsvXHPdnrQap4+/79Cn8lo7x7t6I0EFkL7w3C0nk
	JMRgpGDPw5kP9wdUtRzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qc8lv-000HNB-1I;
	Fri, 01 Sep 2023 18:21:31 +0000
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qc8ls-000HMS-0V;
	Fri, 01 Sep 2023 18:21:29 +0000
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-79268f36c49so80148239f.2;
        Fri, 01 Sep 2023 11:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693592485; x=1694197285; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=AkxZWqWdmQ7F4OBr4vVbCBrNJyUi6XIXCKckh3E053I=;
        b=eCMEdsHAjR/GMtHIe2sY8qks4UYES9tTYdAIlUYD2F8gWthJ0ICqCRrqtql7gYjXg5
         qtwicgb68s7xSExsRT/Z2cOULixs0f2s2ljC9h3jrQ8amCqSnX/2RuyNTKmYWaSd/v1t
         XilZhBe6WLlhIanyWsa7u7A/cU7zI16EHK0vGNK8KJ/uBXskH0Q4fbFAhBHB31TLW1SQ
         6Xgtsxv9Z3sXZtuZz5LAFm2aEBsrsNxaGAwOvR/jqMjmxaXNwBzLztKBz1w3jYRoxpcb
         uo5FfoB2QvS6sZJkRiaWfGn19K2DrJk12zuotLoq4W53ex6G0yTgBxRy5+jrainbYGyE
         4s/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693592485; x=1694197285;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AkxZWqWdmQ7F4OBr4vVbCBrNJyUi6XIXCKckh3E053I=;
        b=T90mAHslbuwLm1yTHaukz7e4OmaR4m0ihyhPXI6//kICprDCfAqafsEYfkk8afhsBU
         xgzamstzTOQUw6NQTcUzsPCpEmUnAW35dlkwvngwEhr3WymToyOc4TJh/mcm4DbslsZs
         WW3pF99rYRRKj7PuJepyPq9IdgYyZT2glI2wshMfAr/bQHBR6so4oND2g+9zISsydM6e
         kISHcuco5MLQx8NqpcTirtzpOYJtdqtx1vJIBWNGUmwNYnHkB8OHVNKKe3+yqfwZDn80
         yNbT5C7VQqG5qBuwRZ71Az5nzXajlo7cLCOiZJYcWriK/ggOdRFUjIrRGU+1kmDccHi+
         KzcA==
X-Gm-Message-State: AOJu0YwMKPbFZxy8eYsImcxNUIeJLhwSIpetZv5BseztJJQxxSSmY7xe
	aFDYzxfiIa393IU3AQvLh+g=
X-Google-Smtp-Source: AGHT+IEbBMcZsXGlB1GUVHhi2Pihj+qc2rFLgCVuWcgWXsrzuhONf+cH6SWBxsrTojrGnCA9s4rMBQ==
X-Received: by 2002:a5e:9505:0:b0:791:6aa4:2d89 with SMTP id r5-20020a5e9505000000b007916aa42d89mr3489073ioj.21.1693592485543;
        Fri, 01 Sep 2023 11:21:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e2-20020a056638020200b0041e328a2084sm1168921jaq.79.2023.09.01.11.21.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 11:21:24 -0700 (PDT)
Message-ID: <11390a1e-932f-8979-1547-f4555920fb7a@roeck-us.net>
Date: Fri, 1 Sep 2023 11:21:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [patch 17/17] x86/fpu: Move FPU initialization into
 arch_cpu_finalize_init()
Content-Language: en-US
To: Nikolay Borisov <nik.borisov@suse.com>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
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
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Chris Zankel <chris@zankel.net>,
 Tom Lendacky <thomas.lendacky@amd.com>, semenzato@google.com
References: <20230613223827.532680283@linutronix.de>
 <20230613224545.902376621@linutronix.de>
 <ba1b11e5-b3f0-457b-8920-d57d470626c3@roeck-us.net>
 <20f025f9-35d9-1f35-f21e-38e1bb44b74c@suse.com>
From: Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20f025f9-35d9-1f35-f21e-38e1bb44b74c@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230901_112128_233625_39C9B2B2 
X-CRM114-Status: GOOD (  19.82  )
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

T24gOS8xLzIzIDExOjAwLCBOaWtvbGF5IEJvcmlzb3Ygd3JvdGU6Cj4gCj4gCj4gT24gMS4wOS4y
MyDQsy4gMjA6MzAg0YcuLCBHdWVudGVyIFJvZWNrIHdyb3RlOgo+PiBIaSwKPj4KPj4gT24gV2Vk
LCBKdW4gMTQsIDIwMjMgYXQgMDE6Mzk6NDZBTSArMDIwMCwgVGhvbWFzIEdsZWl4bmVyIHdyb3Rl
Ogo+Pj4gSW5pdGlhbGl6aW5nIHRoZSBGUFUgZHVyaW5nIHRoZSBlYXJseSBib290IHByb2Nlc3Mg
aXMgYSBwb2ludGxlc3MKPj4+IGV4ZXJjaXNlLiBFYXJseSBib290IGlzIGNvbnZvbHV0ZWQgYW5k
IGZyYWdpbGUgZW5vdWdoLgo+Pj4KPj4+IE5vdGhpbmcgcmVxdWlyZXMgdGhhdCB0aGUgRlBVIGlz
IHNldCB1cCBlYXJseS4gSXQgaGFzIHRvIGJlIGluaXRpYWxpemVkCj4+PiBiZWZvcmUgZm9ya19p
bml0KCkgYmVjYXVzZSB0aGUgdGFza19zdHJ1Y3Qgc2l6ZSBkZXBlbmRzIG9uIHRoZSBGUFUgcmVn
aXN0ZXIKPj4+IGJ1ZmZlciBzaXplLgo+Pj4KPj4+IE1vdmUgdGhlIGluaXRpYWxpemF0aW9uIHRv
IGFyY2hfY3B1X2ZpbmFsaXplX2luaXQoKSB3aGljaCBpcyB0aGUgcGVyZmVjdAo+Pj4gcGxhY2Ug
dG8gZG8gc28uCj4+Pgo+Pj4gTm8gZnVuY3Rpb25hbCBjaGFuZ2UuCj4+Pgo+Pj4gVGhpcyBhbGxv
d3MgdG8gcmVtb3ZlIHF1aXRlIHNvbWUgb2YgdGhlIGN1c3RvbSBlYXJseSBjb21tYW5kIGxpbmUg
cGFyc2luZywKPj4+IGJ1dCB0aGF0J3Mgc3ViamVjdCB0byB0aGUgbmV4dCBpbnN0YWxsbWVudC4K
Pj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5k
ZT4KPj4KPj4gVGhlIGJhY2twb3J0IG9mIHRoaXMgcGF0Y2ggaW50byBjaHJvbWVvcy01LjEwIGFu
ZCBjaHJvbWVvcy01LjE1IHZpYSBzdGFibGUKPj4gcmVsYXNlIG1lcmdlcyBpcyBjYXVzaW5nIHZh
cmlvdXMgQ2hyb21lYm9va3MgKG5vdCBhbGwgb2YgdGhlbSkgdG8gY3Jhc2gKPj4gZWFybHkgZHVy
aW5nIGJvb3QuIFN1YnNlcXVlbnQgZml4ZXMgaGF2ZSBub3QgYWRkcmVzc2VkIHRoZSBwcm9ibGVt
IGZvciB1cywKPj4gc28gd2UgYWxyZWFkeSByZXZlcnRlZCB0aGUgcGF0Y2ggZnJvbSBjaHJvbWVv
cy01LjE1IGFuZCB3aWxsIHJldmVydCBpdAo+PiBmcm9tIGNocm9tZW9zLTUuMTAgYXMgd2VsbC4K
Pj4KPj4gSSBkb24ndCBrbm93IGlmIHRoaXMgaXMgYSBDaHJvbWVib29rIHNwZWNpZmljIHByb2Js
ZW0sIG9yIGlmIGl0IGFmZmVjdHMKPj4gbWFpbmxpbmUsIHNvIHRoaXMgaXMganVzdCBhIGhlYWRz
LXVwIGluIGNhc2Ugb3RoZXJzIGV4cGVyaWVuY2Ugc2ltaWxhcgo+PiBwcm9ibGVtcy4KPiAKPiAK
PiBMb29raW5nIGF0IDUuMTUgdGhlIGZvbGxvd2luZyBwcmVyZXF1aXNpdGVzIGFyZSBsaWtlbHkg
bWlzc2luZzoKPiAKPiBhZjgwNjAyNzk5NjggKCJtbTogTW92ZSBtbV9jYWNoZXAgaW5pdGlhbGl6
YXRpb24gdG8gbW1faW5pdCgpIikKPiA1YjkzYTgzNjQ5YzcgKCJ4ODYvbW06IEluaXRpYWxpemUg
dGV4dCBwb2tpbmcgZWFybGllciIpCj4gCj4gCj4gQ2FuIHlvdSB0ZXN0IHdpdGggdGhvc2UgcGF0
Y2hlcyBiYWNrcG9ydGVkIHRvIDUuMTUueSBhbmQgc2VlIGlmIGl0IHdvcmtzPwoKQm90aCBwYXRj
aGVzIGFyZSBhbHJlYWR5IGluIHY1LjEwLnkgYW5kIDUuMTUueSwgc28gdW5mb3J0dW5hdGVseQp0
aGF0IGRvZXNuJ3QgaGVscC4KCkd1ZW50ZXIKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LXVtCg==

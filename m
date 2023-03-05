Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 279A7C678DB
	for <linux-um@archiver.kernel.org>; Sun,  5 Mar 2023 03:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PL3Ppb11eBlR394PrcaYyGie1sBzlAAITpgb3QFhRQc=; b=cGKmuTVQzF7Aek
	71BlCkpLay9UyOcFyI7Ij3/hhWGeUSEOakmVKhgL+bmhCuF82dCUkfzx+Nou8HU4bVbX/4kRcy2b6
	u9EB8Tbm+OUrakErD9NV48DbXrtrgOxUGoj1ysYK/bBx7ZUcVis1l1rc/uJy8zSM6N8zE2sM67gP+
	2BV/Lirx5o9+klj0ySLBV1jE6t3N+UnFqtxds+D9rUpN6t4dvqacLptVsAdDkyymrLbm/JdZYD2aV
	qobu7zoph8mO3fD/1OqDk7YqjJo0G6v3zgc81HSXTFEdUXFsDCul8OMIGWiL2dG5uyMutHtv23MDp
	ZJ7T/rlxknK85ZkXARsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pYf7S-009m1R-BV; Sun, 05 Mar 2023 03:33:06 +0000
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pYf7N-009m12-SB
	for linux-um@lists.infradead.org; Sun, 05 Mar 2023 03:33:03 +0000
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-17652f24da7so7774650fac.4
        for <linux-um@lists.infradead.org>; Sat, 04 Mar 2023 19:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677987180;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bolxzuks2JcSU3HwyBsAdbA4mZ0mTabc+KtDVeTfiCU=;
        b=diZowVieJrXW3f9z0gQ5C/xwfNog5urV/PlR4bjOvdhBcWaZmNGMxjLm7QT695jZDf
         Wlyv1+1wqFtQ6+Ny2J9ah3hskUhSdj0PzsyPtymcP/tpqTMtZJRERGinZ78vRC2YtEPx
         Z66LRwaQfVt/8tAjtqTIzIbqsxKdB63+/9qJoJmgg6vk/pnLCuNXxsIsELd6vf2h6f1p
         d2kR0HH3yQ9CucrxKNjyDjdcxaIU5bVv5ECaihxFGOMfqPiR5rMDfFsxlA4kCd3O25q7
         PoM+8UxbppBDsrHm23jAiHwqf5jwRY2/9UAI1eUzBeRJ/MX09e0J463SEvLEXjQ4sYJb
         xIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677987180;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bolxzuks2JcSU3HwyBsAdbA4mZ0mTabc+KtDVeTfiCU=;
        b=RLVmpIFtsuq+a/iXT6Ci9cz9Y+XjgdtFv1vVHzg+TebG1JUCVuCjGZaq1JwLtFaJma
         lnB37/baECVsGd4Y2tdG87URjobz5745tAlsxBEBKYvx1JQVX5hw5lcNH/zv896MkRPx
         lCVA5D/F3lpArboUae3+Kcve1g2Y0TAxomKAdMzkL6rVyje+4wxa64j2Zlknvyda7v5V
         Shy8aSCBHJuTowvGk0wb4tYyV54Je4X7uyXESdmOFtzHa+GcOVaVe/wYhkTcTmX02V0E
         5XXsWlgxgaarWh2cJHIvsvCcxSloF3Uwy8hVK5R1NH7udTr0L0QscHWmI+Oycp5kT7yG
         81rQ==
X-Gm-Message-State: AO0yUKUUVJM3GBglZ2H6vK6RFBWe4PnkT0hy7xdkvcdCaicdQJs4aJFM
	a6S+/AexmJ9X8rR1vUs+EaY=
X-Google-Smtp-Source: AK7set+bmqniPd5A8UuYoxpUYf2XWbLjw0+erhzxRCKZLD8QvB3a8go9x8K98NXKg/52znQ7oBsQuQ==
X-Received: by 2002:a05:6870:1116:b0:176:21a9:bf95 with SMTP id 22-20020a056870111600b0017621a9bf95mr3242193oaf.46.1677987179902;
        Sat, 04 Mar 2023 19:32:59 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:b008:9c28:aa1a:1293? ([2600:1700:2442:6db0:b008:9c28:aa1a:1293])
        by smtp.gmail.com with ESMTPSA id v2-20020a05687105c200b0017299192eb1sm2610374oan.25.2023.03.04.19.32.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 19:32:59 -0800 (PST)
Message-ID: <a2fdbd70-ca44-0d13-5b6f-4177761ecc18@gmail.com>
Date: Sat, 4 Mar 2023 21:32:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/8] clk: Add kunit tests for fixed rate and parent data
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>, Stephen Boyd <sboyd@kernel.org>
Cc: David Gow <davidgow@google.com>, Rob Herring <robh+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, patches@lists.linux.dev,
 Brendan Higgins <brendan.higgins@linux.dev>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Richard Weinberger
 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 devicetree@vger.kernel.org, linux-um@lists.infradead.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
References: <20230302013822.1808711-1-sboyd@kernel.org>
 <CABVgOSnpMNCtEEsJV28OzUoxdDuiT4a2T0avP0AYf9xFW1jxrw@mail.gmail.com>
 <CAL_JsqJMd3Fi0ZBObdyE1VDKTH1_+smuGDymHnKOkVH2HB3jJQ@mail.gmail.com>
 <3759b28cca7ab751296d4dd83f2dcc51.sboyd@kernel.org>
 <CAMuHMdXDx6ChRj4xvWbQgcdJd0CGFi-RXySXr=M8QhBkA7YiGw@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <CAMuHMdXDx6ChRj4xvWbQgcdJd0CGFi-RXySXr=M8QhBkA7YiGw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230304_193301_951169_4C51C8D9 
X-CRM114-Status: GOOD (  51.30  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

T24gMy8yLzIzIDEzOjQ3LCBHZWVydCBVeXR0ZXJob2V2ZW4gd3JvdGU6Cj4gSGkgU3RlcGhlbiwK
PiAKPiBPbiBUaHUsIE1hciAyLCAyMDIzIGF0IDg6MjjigK9QTSBTdGVwaGVuIEJveWQgPHNib3lk
QGtlcm5lbC5vcmc+IHdyb3RlOgo+PiBRdW90aW5nIFJvYiBIZXJyaW5nICgyMDIzLTAzLTAyIDA5
OjMyOjA5KQo+Pj4gT24gVGh1LCBNYXIgMiwgMjAyMyBhdCAyOjE04oCvQU0gRGF2aWQgR293IDxk
YXZpZGdvd0Bnb29nbGUuY29tPiB3cm90ZToKPj4+PiBPbiBUaHUsIDIgTWFyIDIwMjMgYXQgMDk6
MzgsIFN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVsLm9yZz4gd3JvdGU6Cj4+Pj4+IFRoaXMgcGF0
Y2ggc2VyaWVzIGFkZHMgdW5pdCB0ZXN0cyBmb3IgdGhlIGNsayBmaXhlZCByYXRlIGJhc2ljIHR5
cGUgYW5kCj4+Pj4+IHRoZSBjbGsgcmVnaXN0cmF0aW9uIGZ1bmN0aW9ucyB0aGF0IHVzZSBzdHJ1
Y3QgY2xrX3BhcmVudF9kYXRhLiBUbyBnZXQKPj4+Pj4gdGhlcmUsIHdlIGFkZCBzdXBwb3J0IGZv
ciBsb2FkaW5nIGEgRFRCIGludG8gdGhlIFVNTCBrZXJuZWwgdGhhdCdzCj4+Pj4+IHJ1bm5pbmcg
dGhlIHVuaXQgdGVzdHMgYWxvbmcgd2l0aCBwcm9iaW5nIHBsYXRmb3JtIGRyaXZlcnMgdG8gYmlu
ZCB0bwo+Pj4+PiBkZXZpY2Ugbm9kZXMgc3BlY2lmaWVkIGluIERULgo+Pj4+Pgo+Pj4+PiBXaXRo
IHRoaXMgc2VyaWVzLCB3ZSdyZSBhYmxlIHRvIGV4ZXJjaXNlIHNvbWUgb2YgdGhlIGNvZGUgaW4g
dGhlIGNvbW1vbgo+Pj4+PiBjbGsgZnJhbWV3b3JrIHRoYXQgdXNlcyBkZXZpY2V0cmVlIGxvb2t1
cHMgdG8gZmluZCBwYXJlbnRzIGFuZCB0aGUgZml4ZWQKPj4+Pj4gcmF0ZSBjbGsgY29kZSB0aGF0
IHNjYW5zIGRldmljZXRyZWUgZGlyZWN0bHkgYW5kIGNyZWF0ZXMgY2xrcy4gUGxlYXNlCj4+Pj4+
IHJldmlldy4KPj4+Pj4KPj4+Pgo+Pj4+IFRoYW5rcyBTdGVwaGVuIC0tIHRoaXMgaXMgcmVhbGx5
IG5lYXQhCj4+Pj4KPj4+PiBUaGlzIHdvcmtzIHdlbGwgaGVyZSwgYW5kIEkgbG92ZSBhbGwgb2Yg
dGhlIHRlc3RzIGZvciB0aGUKPj4+PiBLVW5pdC9kZXZpY2UtdHJlZSBpbnRlZ3JhdGlvbiBhcyB3
ZWxsLgo+Pj4+Cj4+Pj4gSSdtIHN0aWxsIGxvb2tpbmcgdGhyb3VnaCB0aGUgZGV0YWlscyBvZiBp
dCAoYWxhcywgSSd2ZSBtb3N0bHkgbGl2ZWQKPj4+PiBpbiB4ODYtbGFuZCwgc28gbXkgZGV2aWNl
LXRyZWUga25vd2xlZGdlIGlzLCB1aCwgc3BvdHR5IHRvIHNheSB0aGUKPj4+PiBsZWFzdCksIGJ1
dCBhcGFydCBmcm9tIHBvc3NpYmx5IHJlbmFtaW5nIHNvbWUgdGhpbmdzIG9yIHNpbWlsYXJseQo+
Pj4+IG1pbm9yIHR3ZWFrcywgSSd2ZSBub3QgZ290IGFueSByZWFsIHN1Z2dlc3Rpb25zIHRodXMg
ZmFyLgo+Pj4+Cj4+Pj4gSSBkbyB3b25kZXIgd2hldGhlciB3ZSdsbCB3YW50LCBvbiB0aGUgS1Vu
aXQgc2lkZSwgdG8gaGF2ZSBzb21lIHdheSBvZgo+Pj4+IHN1cHBvcnRpbmcgS1VuaXQgZGV2aWNl
IHRyZWVzIG9uIG5vbi1VTUwgYXJjaGl0ZWNjdHVyZXMgKGUuZy4sIGlmIHdlCj4+Pj4gbmVlZCB0
byB0ZXN0IHNvbWV0aGluZyBhcmNoaXRlY3R1cmUtc3BlY2lmaWMsIG9yIG9uIGEgYmlnLWVuZGlh
bgo+Pj4+IHBsYXRmb3JtLCBldGMpLCBidXQgSSB0aGluayB0aGF0J3MgYSBxdWVzdGlvbiBmb3Ig
dGhlIGZ1dHVyZSwgcmF0aGVyCj4+Pj4gdGhhbiBzb21ldGhpbmcgdGhhdCBhZmZlY3RzIHRoaXMg
c2VyaWVzLgo+Pj4KPj4+IEknbGwgc2F5IHRoYXQncyBhIHJlcXVpcmVtZW50LiBXZSBzaG91bGQg
YmUgYWJsZSB0byBzdHJ1Y3R1cmUgdGhlCj4+PiB0ZXN0cyB0byBub3QgaW50ZXJmZXJlIHdpdGgg
dGhlIHJ1bm5pbmcgc3lzdGVtJ3MgRFQuIFRoZSBEVCB1bml0dGVzdAo+Pj4gZG9lcyB0aGF0Lgo+
Pgo+PiBUaGF0IGNvdWxkIGJlIGFub3RoZXIgY2hvaWNlIGluIHRoZSB1bml0IHRlc3QgY2hvaWNl
IG1lbnUuCj4+IENPTkZJR19PRl9LVU5JVF9OT1RfVU1MIHRoYXQgaW5qZWN0cyBzb21lIGJ1aWx0
LWluIERUQiBvdmVybGF5IG9uIGFuCj4+IGFyY2hpdGVjdHVyZSB0aGF0IHdhbnRzIHRvIHJ1biB0
ZXN0cy4KPiAKPiBBcyBsb25nIGFzIHlvdSB1c2UgY29tcGF0aWJsZSB2YWx1ZXMgdGhhdCBkb24n
dCBleGlzdCBlbHNld2hlcmUsCj4gYW5kIGRvbid0IG92ZXJ3cml0ZSBhbnl0aGluZywgeW91IGNh
biBsb2FkIHlvdXIga3VuaXQgdGVzdCBvdmVybGF5cwo+IG9uIGFueSBydW5uaW5nIHN5c3RlbSB0
aGF0IGhhcyBEVCBzdXBwb3J0Lgo+IAo+Pj4gQXMgYSBzaWRlIHRvcGljLCBJcyBhbnlvbmUgbG9v
a2luZyBhdCBnZXR0aW5nIFVNTCB0byB3b3JrIG9uIGFybTY0Pwo+Pj4gSXQncyBzdXJwcmlzaW5n
IGhvdyBtdWNoIHg4NiBzdHVmZiB0aGVyZSBpcyB3aGljaCBpcyBJIGd1ZXNzIG9uZQo+Pj4gcmVh
c29uIGl0IGhhc24ndCBoYXBwZW5lZC4KPj4KPj4gSSd2ZSBubyBpZGVhIGJ1dCBpdCB3b3VsZCBi
ZSBuaWNlIGluZGVlZC4KPiAKPiBJIGJlbGlldmUgdGhhdCdzIG5vbi10cml2aWFsLiBBdCBsZWFz
dCBmb3IgYXJtMzIgKEkgZGlkbid0IGhhdmUgYW55IGFybTY0Cj4gc3lzdGVtcyBsYXN0IHRpbWUg
SSBhc2tlZCB0aGUgZXhwZXJ0cykuCj4gCj4+Pj4gU2ltaWxhcmx5LCBJIHdvbmRlciBpZiB0aGVy
ZSdzIHNvbWV0aGluZyB3ZSBjb3VsZCBkbyB3aXRoIGRldmljZSB0cmVlCj4+Pj4gb3ZlcmxheXMs
IGluIG9yZGVyIHRvIG1ha2UgaXQgcG9zc2libGUgZm9yIHRlc3RzIHRvIHN3YXAgbm9kZXMgaW4g
YW5kCj4+Pj4gb3V0IGZvciB0ZXN0aW5nLgo+Pj4KPj4+IFllcywgdGhhdCdzIGhvdyB0aGUgRFQg
dW5pdHRlc3Qgd29ya3MuIEJ1dCBpdCBpcyBwcmV0dHkgbXVjaCBvbmUgYmlnCj4+PiBvdmVybGF5
IChpZ25vcmluZyB0aGUgb3ZlcmxheSB0ZXN0cykuIEl0IGNvdWxkIHByb2JhYmx5IGJlIG1vcmUK
Pj4+IG1vZHVsYXIgd2hlcmUgaXQgaXMgYXBwbHkgb3ZlcmxheSwgdGVzdCwgcmVtb3ZlIG92ZXJs
YXksIHJlcGVhdC4KPj4KPj4gSSBkaWRuJ3Qgd2FudCB0byByZWx5IG9uIHRoZSBvdmVybGF5IGNv
ZGUgdG8gaW5qZWN0IERUIG5vZGVzLiBIYXZpbmcKPj4gdGVzdHMgd3JpdHRlbiBmb3IgdGhlIGZh
a2UgS1VuaXQgbWFjaGluZSBpcyBzaW1wbGUuIEl0IGNsb3NlbHkgbWF0Y2hlcwo+PiBob3cgY2xr
IGNvZGUgcHJvYmVzIHRoZSBEVEIgYW5kIGhvdyBub2RlcyBhcmUgY3JlYXRlZCBhbmQgcG9wdWxh
dGVkIG9uCj4+IHRoZSBwbGF0Zm9ybSBidXMgYXMgZGV2aWNlcy4gQ0xLX09GX0RFQ0xBUkUoKSB3
b3VsZCBuZWVkIHRoZSBvdmVybGF5IHRvCj4+IGJlIGFwcGxpZWQgZWFybHkgdG9vLCB3aGljaCBk
b2Vzbid0IGhhcHBlbiBvdGhlcndpc2UgYXMgZmFyIGFzIEkga25vdy4KPiAKPiBEb24ndCBhbGwg
Z2VuZXJpYyBjbG9jayBkcml2ZXJzIGFsc28gY3JlYXRlIGEgcGxhdGZvcm0gZHJpdmVyPwo+IEF0
IGxlYXN0IGRyaXZlcnMvY2xrL2Nsay1maXhlZC1mYWN0b3IuYyBkb2VzLgo+IAo+PiBCdXQgcGVy
aGFwcyB0aGlzIGRlc2lnbiBpcyB0b28gbXVjaCBvZiBhbiBlbmQtdG8tZW5kIHRlc3QgYW5kIG5v
dCBhIHVuaXQKPj4gdGVzdD8gSW4gdGhlIHNwaXJpdCBvZiB1bml0IHRlc3Rpbmcgd2Ugc2hvdWxk
bid0IGNhcmUgYWJvdXQgaG93IHRoZSBub2RlCj4+IGlzIGFkZGVkIHRvIHRoZSBsaXZlIGRldmlj
ZXRyZWUsIGp1c3QgdGhhdCB0aGVyZSBpcyBhIGRldmljZXRyZWUgYXQgYWxsLgo+Pgo+PiBTdXBw
b3J0aW5nIG92ZXJsYXlzIHRvIG1vcmUgZWFzaWx5IHRlc3QgY29tYmluYXRpb25zIHNvdW5kcyBs
aWtlIGEgZ29vZAo+PiBpZGVhLiBQcm9iYWJseSBzb21lIGt1bml0XyooKSBwcmVmaXhlZCBmdW5j
dGlvbnMgY291bGQgYmUgdXNlZCB0bwo+PiBhcHBseSBhIHRlc3QgbWFuYWdlZCBvdmVybGF5IGFu
ZCBhdXRvbWF0aWNhbGx5IHJlbW92ZSBpdCB3aGVuIHRoZSB0ZXN0Cj4+IGlzIG92ZXIgd291bGQg
d29yay4gVGhlIGNsayByZWdpc3RyYXRpb24gdGVzdHMgY291bGQgdXNlIHRoaXMgQVBJIHRvCj4+
IGluamVjdCBhbiBvdmVybGF5IGFuZCB0aGVuIG1hbnVhbGx5IGNhbGwgdGhlIG9mX3BsYXRmb3Jt
X3BvcHVsYXRlKCkKPj4gZnVuY3Rpb24gdG8gY3JlYXRlIHRoZSBwbGF0Zm9ybSBkZXZpY2Uocyku
IFRoZSBvdmVybGF5IGNvdWxkIGJlIGJ1aWx0IGluCj4+IGRyaXZlcnMvY2xrLyB0b28gYW5kIHRo
ZW4gcHJvYmFibHkgc29tZSBtYWNyb2lzaCBmdW5jdGlvbiBjYW4gZmluZCB0aGUKPj4gYmxvYiBh
bmQgYXBwbHkgaXQuCj4gCj4gTm8gbmVlZCB0byBtYW51YWxseSBjYWxsIG9mX3BsYXRmb3JtX3Bv
cHVsYXRlKCkgdG8gY3JlYXRlIHRoZQo+IHBsYXRmb3JtIGRldmljZXMuIFRoYXQgaXMgdGFrZW4g
Y2FyZSBvZiBhdXRvbWF0aWNhbGx5IHdoZW4gYXBwbHlpbmcKPiBhbiBvdmVybGF5Lgo+IAo+PiBJ
cyB0aGVyZSBzb21lIHdheSB0byBkZWxldGUgdGhlIHBsYXRmb3JtIGRldmljZXMgdGhhdCB3ZSBw
b3B1bGF0ZSBmcm9tCj4+IHRoZSBvdmVybGF5PyBJJ2QgbGlrZSB0aGUgdGVzdHMgdG8gYmUgaGVy
bWV0aWMuCj4gCgo+IFJlbW92aW5nIHRoZSBvdmVybGF5IHdpbGwgZGVsZXRlIHRoZSBwbGF0Zm9y
bSBkZXZpY2VzLgoKSSBfdGhpbmtfIHRoYXQgaXMgaW5jb3JyZWN0LiAgRG8geW91IGhhdmUgYSBw
b2ludGVyIHRvIHRoZSBvdmVybGF5IGNvZGUgdGhhdApkZWxldGVzIHRoZSBkZXZpY2U/ICAoSWYg
SSByZW1lbWJlciBjb3JyZWN0bHksIHRoZSBvdmVybGF5IHJlbW92ZSBjb2RlIGRvZXMgbm90CmV2
ZW4gY2hlY2sgd2hldGhlciB0aGUgZGV2aWNlIGV4aXN0cyBhbmQgd2hldGhlciBhIGRyaXZlciBp
cyBib3VuZCB0byBpdCAtLSBidXQKdGhpcyBpcyBvbiBteSB0b2RvIGxpc3QgdG8gbG9vayBpbnRv
LikKCi1GcmFuawoKPiAKPiBBbGwgb2YgdGhhdCB3b3JrcyBpZiB5b3UgaGF2ZSB5b3VyIG93biBj
b2RlIHRvIGFwcGx5IGEgRFQgb3ZlcmxheS4KPiBUaGUgcmVjZW50IGZ3X2RldmxpbmtzIHBhdGNo
ZXMgZGlkIGNhdXNlIHNvbWUgcmVncmVzc2lvbnMsIGNmci4KPiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9hbGwvQ0FNdUhNZFhFblNENHJSSi1vOTB4NE9wclVhY05fckpneW84eDY9OUY5clorLUt6
ak9nQG1haWwuZ21haWwuY29tCj4gCj4gUC5TLiBTaGFtZWxlc3MgcGx1ZzogZm9yIGxvYWRpbmcg
b3ZlcmxheXMgZnJvbSB1c2Vyc3BhY2UsIHRoZXJlIGFyZQo+ICAgICAgbXkgb3ZlcmxheSBicmFu
Y2hlcywgY2ZyLiBodHRwczovL2VsaW51eC5vcmcvUi1DYXIvRFQtT3ZlcmxheXMKPiAKPiBHcntv
ZXRqZSxlZXRpbmd9cywKPiAKPiAgICAgICAgICAgICAgICAgICAgICAgICBHZWVydAo+IAo+IAo+
IC0tCj4gR2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBMaW51eCBiZXlvbmQg
aWEzMiAtLSBnZWVydEBsaW51eC1tNjhrLm9yZwo+IAo+IEluIHBlcnNvbmFsIGNvbnZlcnNhdGlv
bnMgd2l0aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxmIGEgaGFja2VyLiBCdXQKPiB3
aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInByb2dyYW1tZXIiIG9y
IHNvbWV0aGluZyBsaWtlIHRoYXQuCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAt
LSBMaW51cyBUb3J2YWxkcwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K

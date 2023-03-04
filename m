Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 704B7C678DB
	for <linux-um@archiver.kernel.org>; Sat,  4 Mar 2023 15:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lbh8IUbmbjKc4NdzEGf85t3rXvUjfx24JmFJaF1HYtk=; b=PoTYXh1OWjUEgt
	IPHRGrgptNIXKlndldb/gWC6wW+X9QkPuE63JgNc72Y9mjNFpRxSMwi9dDXCI3qC81PoGhIe/iN0K
	UPTolwHWVoxtul4FzsK5iTHpFyyu3Xj+HXA0eApfaa+o2PztwpP4+IHRd+l9gpg23oA8/zcBW689y
	t57vkEHdMKkw3jAseeYvrE3MbG7+InV8XKd/79fpC0bk0E5OhV0u2h9ZJ59poTAiWyvq1DCzVpzGm
	G9jSsCeBLekbo0PpdQ/RvP/ipWl0OyPhxfWzUeWsYIqC8gPN15w/fvnZI0CmOG+7puUoi9Fqy8QTD
	ZTl7WwHX1KPmX0lORhlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pYTzM-009Bno-Mm; Sat, 04 Mar 2023 15:40:00 +0000
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pYTzI-009BnK-Mq
	for linux-um@lists.infradead.org; Sat, 04 Mar 2023 15:39:58 +0000
Received: by mail-qt1-x82e.google.com with SMTP id c19so6078165qtn.13
        for <linux-um@lists.infradead.org>; Sat, 04 Mar 2023 07:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677944393;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vvZM6A5QV3zdayH/S1bT6N5QCQ+HtUclZlnIwxMfu5Y=;
        b=Mu2Vrycmndn9hFrEsiCZNBjMKRHKo/+7PLhI3wnP7CKBoP6Cqtft+9thavbxmzCu1a
         iwvpl0E7qQrWUDNucm9v9/s85RmiMWifmCGhj48ceiIBpiorNx1OG5/dTY8y+olS8AsX
         86rwRTRJqgJ0XCgb0vwOsJwkCTlZFIdaLKpGe2kdZ/X7B9g69Sgzxd5J6ndnw78FCNq+
         kHo8MkPKzAsiwT302ar+t3cgbEzEvXoiN2dkNXLse5LWi4TkVWDtyxpvNfeddVnCi4Vk
         gngrnU1Y3jEV2r55+UyIG419NrTG2aKHRsKm8JWUoaVC04XjxuB5hvyeo5i7nMweG2ct
         REeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677944393;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vvZM6A5QV3zdayH/S1bT6N5QCQ+HtUclZlnIwxMfu5Y=;
        b=j+LLTZ/2hE9jzbA/8jcYliNYF+5GebtdwCQQXLqLQQZe3clXgsnlub/pP/AZRHkOGL
         V5rdaFEjBEc2IbphoFKA0UV8SS4NKN1/tzfWJNTNQ4Rmd346nOJ6H0Y+jy4SNZwijb2e
         s5saDcM7FJgVYEOehTKku+H+IXrR3lKe3knt/LpT+oKk4BruEgrzharFNTMA4gVCpzHc
         q+9d0YJCfeLaJ4iDEbayobvGOqpbghI0e1hpwukZKhILSmTkHYk1ASSyB1dHGoxhKkD4
         QaFyu4e9l586w03ElLwmmr5DgRaLHLFYUyQuzmChqsWj2dJudkKlmHbVYa3BvURRSAA0
         ws1A==
X-Gm-Message-State: AO0yUKUpIAhF81EHL2vVE7Haiy6UHLXoMW7Pl0D9umIwqSCGqrILlFrg
	shpkk66vcLO+Rzf7bfFh1g4=
X-Google-Smtp-Source: AK7set9yMsLrDslyIt4a/Hxzl/SiRN/pJYt8yXquPSQN+FZJEEWKVn8w/SLEjaP35h1OHtksDNGT3Q==
X-Received: by 2002:ac8:5f0d:0:b0:3b6:2bb3:fb53 with SMTP id x13-20020ac85f0d000000b003b62bb3fb53mr8661153qta.16.1677944393218;
        Sat, 04 Mar 2023 07:39:53 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:99e6:eec3:1daa:f163? ([2600:1700:2442:6db0:99e6:eec3:1daa:f163])
        by smtp.gmail.com with ESMTPSA id r136-20020a37a88e000000b0073b99d515e2sm3950827qke.44.2023.03.04.07.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 07:39:52 -0800 (PST)
Message-ID: <c81211fa-2836-fe21-637f-a5cca7237d43@gmail.com>
Date: Sat, 4 Mar 2023 09:39:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/8] clk: Add kunit tests for fixed rate and parent data
Content-Language: en-US
To: Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 patches@lists.linux.dev, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <davidgow@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J.Wysocki" <rafael@kernel.org>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 devicetree@vger.kernel.org, linux-um@lists.infradead.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
References: <20230302013822.1808711-1-sboyd@kernel.org>
 <CAL_JsqLVQVZhYTSZgrvA-V-xOUbiBdyDxqPOZk=89YS33EahBQ@mail.gmail.com>
 <093867df6137ad9e964b7dd90fb58f1a.sboyd@kernel.org>
 <CAL_JsqLdPWRLu8TNqCG+dw9Pz2cS798QwGX=C5X18KKqAXwjSQ@mail.gmail.com>
 <ecb5ede44d5bcc0430dad99e53d4477d.sboyd@kernel.org>
From: Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <ecb5ede44d5bcc0430dad99e53d4477d.sboyd@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230304_073956_886154_8F86F001 
X-CRM114-Status: GOOD (  27.85  )
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

T24gMy8yLzIzIDE3OjU3LCBTdGVwaGVuIEJveWQgd3JvdGU6Cj4gUXVvdGluZyBSb2IgSGVycmlu
ZyAoMjAyMy0wMy0wMiAxMjoxODozNCkKPj4gT24gVGh1LCBNYXIgMiwgMjAyMyBhdCAxOjQ04oCv
UE0gU3RlcGhlbiBCb3lkIDxzYm95ZEBrZXJuZWwub3JnPiB3cm90ZToKPj4+Cj4+PiBRdW90aW5n
IFJvYiBIZXJyaW5nICgyMDIzLTAzLTAyIDA5OjEzOjU5KQo+Pj4+Cj4+Pj4gR29vZCB0byBzZWUg
YmluZGluZ3MgZm9yIHRoaXMuIEkndmUgYmVlbiBtZWFuaW5nIHRvIGRvIHNvbWV0aGluZyBhYm91
dAo+Pj4+IHRoZSBEVCB1bml0dGVzdCBvbmVzIGJlaW5nIHVuZG9jdW1lbnRlZCwgYnV0IEkgaGFk
bid0IHJlYWxseSBkZWNpZGVkCj4+Pj4gd2hldGhlciBpdCB3YXMgd29ydGggd3JpdGluZyBzY2hl
bWFzIGZvciB0aGVtLiBUaGUgY29tcGF0aWJsZXMgYXQKPj4+PiBsZWFzdCBzaG93IHVwIHdpdGgg
J21ha2UgZHRfY29tcGF0aWJsZV9jaGVjaycuIFBlcmhhcHMgd2Ugd2FudCB0byBqdXN0Cj4+Pj4g
ZGVmaW5lIHNvbWUgdmVuZG9yIChub3QgJ2xpbnV4JykgdGhhdCdzIGFuIGV4Y2VwdGlvbiByYXRo
ZXIgdGhhbgo+Pj4+IHJlcXVpcmluZyBzY2hlbWFzIChhY3R1YWxseSwgdGhhdCBhbHJlYWR5IHdv
cmtzIGZvciAnZm9vJykuCj4+Pgo+Pj4gU3VyZS4gTWF5YmUgImt1bml0IiBzaG91bGQgYmUgdGhl
IHZlbmRvciBwcmVmaXg/IE9yICJkdGJ1bml0Ij8KPj4KPj4gV2UnZCB3YW50IHRvIHVzZSB0aGUg
c2FtZSB0aGluZyBvbiB0aGUgRFQgdW5pdHRlc3RzIG9yIGFueXRoaW5nIGVsc2UKPj4gcG90ZW50
aWFsbHkuIEhvdyBhYm91dCBqdXN0ICd0ZXN0Jz8KPiAKPiBTb3VuZHMgZ29vZC4KPiAKPj4KPj4+
PiBJdCdzCj4+Pj4gbGlrZWx5IHRoYXQgd2Ugd2FudCB0ZXN0IERUcyB0aGF0IGZhaWwgbm9ybWFs
IGNoZWNrcyBhbmQgc2NoZW1hcyBnZXQKPj4+PiBpbiB0aGUgd2F5IG9mIHRoYXQgYXMgd2UgZG9u
J3QgaGF2ZSBhIHdheSB0byB0dXJuIG9mZiBjaGVja3MuCj4+Pgo+Pj4gSGF2aW5nIHRoZSBzY2hl
bWFzIGlzIG5pY2UgdG8gbWFrZSBzdXJlIHRlc3RzIHRoYXQgYXJlIGV4cGVjdGluZyBzb21lCj4+
PiBiaW5kaW5nIGFyZSBhY3R1YWxseSBnZXR0aW5nIHRoYXQuIEJ1dCBzdXBwb3J0aW5nIGJyb2tl
biBiaW5kaW5ncyBpcwo+Pj4gYWxzbyBpbXBvcnRhbnQgdG8gdGVzdCBhbnkgZXJyb3IgcGF0aHMg
aW4gZnVuY3Rpb25zIHRoYXQgcGFyc2UKPj4+IHByb3BlcnRpZXMuIE1heWJlIHdlIGtlZXAgdGhl
IHNjaGVtYSBhbmQgaGF2ZSBpdCBlbmZvcmNlIHRoYXQgaW5jb3JyZWN0Cj4+PiBwcm9wZXJ0aWVz
IGFyZSBiZWluZyBzZXQ/Cj4+Cj4+IEkgd2Fzbid0IHN1Z2dlc3RpbmcgdGhyb3dpbmcgdGhlbSBv
dXQuIE1vcmUgd2h5IEkgaGFkbid0IHdyaXR0ZW4gYW55IEkgZ3Vlc3MuCj4+Cj4+PiBEbyB3ZSBy
ZWFsbHkgbmVlZCB0byB0ZXN0IGluY29ycmVjdCBiaW5kaW5ncz8gRG9lc24ndCB0aGUKPj4+IGR0
X2JpbmRpbmdzX2NoZWNrIGNhdGNoIHRoZXNlIHByb2JsZW1zIHNvIHdlIGRvbid0IGhhdmUgdG8g
d3JpdGUgRFRCCj4+PiB2ZXJpZmllcnMgaW4gdGhlIGtlcm5lbD8KPj4KPj4gRmFpciBlbm91Z2gu
IFVzaW5nIG15IGZyZXF1ZW50bHkgc3RhdGVkIHBvc2l0aW9uIGFnYWluc3QgbWUuIDopCj4+Cj4+
IEkgZG8gaGF2ZSBhIHNlY3JldCBwbGFuIHRvIGltcGxlbWVudCAoZGVidWcpIHR5cGUgY2hlY2tz
IGludG8gdGhlCj4+IG9mX3Byb3BlcnR5XyogQVBJcyBieSBleHRyYWN0aW5nIHRoZSB0eXBlIGlu
Zm9ybWF0aW9uIGZyb20gc2NoZW1hcwo+PiBpbnRvIEMuCj4+Cj4gCj4gT2suIEkgc3VzcGVjdCB3
ZSBtYXkgd2FudCB0byB0ZXN0IGVycm9yIHBhdGhzIHRob3VnaCBzbyBJIGRvbid0IGtub3cKClll
cywgZXhhY3RseS4KCj4gd2hhdCB0byBkbyBoZXJlLiBGb3Igbm93IEknbGwganVzdCBsZWF2ZSB0
aGUgYmluZGluZ3MgaW4gcGxhY2UgYW5kCj4gY2hhbmdlIHRoZSBwcmVmaXggdG8gInRlc3QiLgo+
IAo+Pgo+Pj4+IFdlIGFscmVhZHkgaGF2ZSBHUElPIHRlc3RzIGluIHRoZSBEVCB1bml0dGVzdHMs
IHNvIHdoeSBpcyBjbG9ja3MKPj4+PiBkaWZmZXJlbnQ/IE9yIHNob3VsZCB0aGUgR1BJTyB0ZXN0
cyBiZSBtb3ZlZCBvdXQgKHllcywgcGxlYXNlISk/Cj4+Pgo+Pj4gQWggSSBkaWRuJ3Qgbm90aWNl
IHRoZSBHUElPIHRlc3RzIGluIHRoZXJlLiBUaGVyZSBhcmUgaTJjIHRlc3RzIHRvbywKPj4+IHJp
Z2h0PyBBbGwgSSBjYW4gc2F5IGlzIGNsa3MgYXJlIHVzaW5nIGt1bml0LCB0aGF0J3MgdGhlIGRp
ZmZlcmVuY2UgOy0pCj4+Cj4+IFllYWgsIHRoZXkgc2hvdWxkIHBlcmhhcHMgYWxsIG1vdmUgdG8g
dGhlIHN1YnN5c3RlbXMuCj4gCj4gR290IGl0Lgo+IAo+Pgo+Pj4+IFdoYXQgaGFwcGVucyB3aGVu
L2lmIHRoZSBEVCB1bml0dGVzdCBpcyBjb252ZXJ0ZWQgdG8ga3VuaXQ/IEkgdGhpbmsKPj4+PiB0
aGF0IHdvdWxkIGxvb2sgY29uZnVzaW5nIGZyb20gdGhlIG5hbWluZy4gTXkgaW5pdGlhbCB0aG91
Z2h0IGlzCj4+Pj4gJ2t1bml0JyBzaG91bGQgYmUgZHJvcHBlZCBmcm9tIHRoZSBuYW1pbmcgb2Yg
YSBsb3Qgb2YgdGhpcy4gTm90ZSB0aGF0Cj4+Pj4gdGhlIG9yaWdpbmFsIGt1bml0IHN1Ym1pc3Np
b24gY29udmVydGVkIHRoZSBEVCB1bml0dGVzdHMuIEkgd291bGQKPj4+PiBzdGlsbCBsaWtlIHRv
IHNlZSB0aGF0IGhhcHBlbi4gRnJhbmsgZGlzYWdyZWVkIG92ZXIgd2hhdCdzIGEgdW5pdCB0ZXN0
Cj4+Pj4gb3Igbm90LCB0aGVuIGFncmVlZCwgdGhlbiBkaWRuJ3QuLi4gSSBkb24ndCByZWFsbHkg
Y2FyZS4gSWYgdGhlcmUncyBhCj4+Pj4gZnJhbWV3b3JrIHRvIHVzZSwgdGhlbiB3ZSBzaG91bGQg
dXNlIGl0IElNTy4KPj4+Cj4+PiBIb25lc3RseSBJIGRvbid0IHdhbnQgdG8gZ2V0IGludm9sdmVk
IGluIG1pZ3JhdGluZyB0aGUgZXhpc3RpbmcgRFQKPj4+IHVuaXR0ZXN0IGNvZGUgdG8ga3VuaXQu
IEknbSBhd2FyZSB0aGF0IGl0IHdhcyBhdHRlbXB0ZWQgeWVhcnMgYWdvIHdoZW4KPj4+IGt1bml0
IHdhcyBpbnRyb2R1Y2VkLiBNYXliZSBpZiB0aGUgb3ZlcmxheSByb3V0ZSB3b3JrcyB3ZWxsIGVu
b3VnaCBJIGNhbgo+Pj4gY29tcGxldGVseSBzaWRlc3RlcCBpbnRyb2R1Y2luZyBhbnkgY29kZSBp
biBkcml2ZXJzL29mLyBiZXNpZGVzIHNvbWUKPj4+IGt1bml0IHdyYXBwZXJzIGZvciB0aGlzLiBJ
J2xsIGNyb3NzIG15IGZpbmdlcnMhCj4+Cj4+IFllYWgsIEkgd2Fzbid0IGV4cGVjdGluZyB5b3Ug
dG8uIEkganVzdCB3YW50IHRvIG1ha2Ugc3VyZSB0aGlzIG1lc2hlcwo+PiB3aXRoIGFueSBmdXR1
cmUgY29udmVyc2lvbiB0byBrdW5pdC4KPiAKPiBQaGV3IQo+IAo+Pgo+PiBUaGVyZSdzIGFsc28g
c29tZSBwbGFucyB0byBhbHdheXMgcG9wdWxhdGUgdGhlIERUIHJvb3Qgbm9kZSBpZiBub3QKPj4g
cHJlc2VudC4gVGhhdCBtYXkgaGVscCBoZXJlLiBPciBub3QuIFRoZXJlJ3MgYmVlbiBhIGZldyB2
ZXJzaW9ucwo+PiBwb3N0ZWQgd2l0aCBGcmFuaydzIGluIHRoZSBsYXN0IHdlZWsgb3IgMi4KPj4K
PiAKPiBPay4gSSB0aGluayBJIGhhdmUgc29tZSB0aW1lIHRvIHRyeSB0aGlzIG92ZXJsYXkgYXBw
cm9hY2ggc28gbGV0IG1lIHNlZQo+IHdoYXQgaXMgbmVlZGVkLgoKUGxlYXNlIGF2b2lkIG92ZXJs
YXlzLiAgU2VlIG15IG90aGVyIHJlcGxpZXMgaW4gdGhpcyB0aHJlYWQgZm9yIHdoeS4KCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWls
aW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==

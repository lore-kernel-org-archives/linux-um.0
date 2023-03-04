Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B91C678DB
	for <linux-um@archiver.kernel.org>; Sat,  4 Mar 2023 15:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2lYd6/jOqYVfdZT4hR8gRxxR64I5y5+3/bdimnn6YsY=; b=1mOVjLA2la2rYX
	fb3S3BBFDPUrUrCj0n1O4tFJ1YpoFTfIqSE6bs78UeleeMN/QH3KLkQ89bbGlDmRsgH48bAuggVUk
	H1UDfVlo7px71RS+IJu4PuKVygxa+AlJvSzfQPwl2K1XdpWFFWeBPiB78zk1HK15WqTHbF/716+dn
	hUaWzWLOtAENezdlG8WseX4xu/alufnEay4I+ETLuJFn3u6srS7h8jaoqs18rKff5encUJ21ClOEY
	FYEMuI2gX5HapAEgQBSbSbYB4y9T9shCiHDoWzODIqhNAMZj8YFvTJk+U1rgTnE0pHXQfkUXTrrpx
	cTVcMWPFJCr6ZwzC6WGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pYTxW-009Bfm-8i; Sat, 04 Mar 2023 15:38:06 +0000
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pYTxT-009Bf8-7Y
	for linux-um@lists.infradead.org; Sat, 04 Mar 2023 15:38:04 +0000
Received: by mail-qv1-xf35.google.com with SMTP id o3so3791591qvr.1
        for <linux-um@lists.infradead.org>; Sat, 04 Mar 2023 07:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677944280;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VizVUnHy9GSB0o/qHsH2eVXk1dA97D3zuZ6sfMVEQ08=;
        b=OLpQQIM6IppE0q6bJwA0zghclJLru6TiCk4cxrUE2HeLwXI3Y0lfhBt2oKEVKaMkxN
         SAN4518ZjZW+r4m1zcFaF/+JKg4rZvLB67tyXztAVDehjjOwrNdBmr3HuS/og2W16WdB
         dRQJrFIszSvEbeBKC238aIZdfKyPOrnFgJekuzpGutvei5ZVJHoXMUZTHzOR8/ICrcIq
         wSufNYsWZieix1VpBeCDCDnOpKYbUD3o6HdfukNQcfQ/jI9kXncX2CKX/tNsSit6ZXcM
         CAVRrGuad67xir+vNzdcoDTYj923el2tw+B3CzUjxdtK1pRgpXGglxvygiLrxschU50x
         QKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677944280;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VizVUnHy9GSB0o/qHsH2eVXk1dA97D3zuZ6sfMVEQ08=;
        b=o9JeCxTHB8WgPMqaw5Xsa0NUeUDfvowr6xUIZ4zo775+R2S4pMX883vRClry76Phj3
         EihUn7sweVwdgbnovQhJTskIPPWX7pscRzuqG8U1s3/QNs4aao9Mv4pz+6SMjRS1bJlg
         MrASrkVkKQ0OTNtt14vLfZ6PmnO6Ct2QNRYEhCV4ItuozRLqOWsDqoO0rtpfIrq4TQsp
         Xe5oCL7U46etZjzxgQ3kypFt88vJ2a64TKeUNDPD+QsNAx/mNnZB/U2uNui7cDHMdZBp
         SzrS9NesfgF+wciOACqNC1PeZr0dhUHlMO4pKniC2CGsU65bIH1Cys5KbBA0vZKrrwx8
         KROg==
X-Gm-Message-State: AO0yUKWMf35eZTHG1+M9ceAgegTiGAPRSroCJJ6ISrp7VH9QAoPgmeso
	78u6KAcEijqxuZL5Jacv8Fg=
X-Google-Smtp-Source: AK7set+qQgKSMP4NFWBDNjqXo0pT4avb0WAev4EM931qCyVUY6MUqDZMlOJe7V1UH/KLvAA2qNBD8w==
X-Received: by 2002:a05:6214:d6c:b0:570:bf45:d6f7 with SMTP id 12-20020a0562140d6c00b00570bf45d6f7mr10349131qvs.45.1677944280234;
        Sat, 04 Mar 2023 07:38:00 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:99e6:eec3:1daa:f163? ([2600:1700:2442:6db0:99e6:eec3:1daa:f163])
        by smtp.gmail.com with ESMTPSA id bn2-20020a05620a2ac200b0073bad2f9380sm3956127qkb.14.2023.03.04.07.37.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 07:37:59 -0800 (PST)
Message-ID: <0dcf26a8-7d33-37cf-8365-2428ecd6d7cf@gmail.com>
Date: Sat, 4 Mar 2023 09:37:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/8] clk: Add kunit tests for fixed rate and parent data
Content-Language: en-US
To: Rob Herring <robh+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 patches@lists.linux.dev, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <davidgow@google.com>,
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
 <CAL_JsqLVQVZhYTSZgrvA-V-xOUbiBdyDxqPOZk=89YS33EahBQ@mail.gmail.com>
 <093867df6137ad9e964b7dd90fb58f1a.sboyd@kernel.org>
 <CAL_JsqLdPWRLu8TNqCG+dw9Pz2cS798QwGX=C5X18KKqAXwjSQ@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <CAL_JsqLdPWRLu8TNqCG+dw9Pz2cS798QwGX=C5X18KKqAXwjSQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230304_073803_332346_1719DC8F 
X-CRM114-Status: GOOD (  37.01  )
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

T24gMy8yLzIzIDE0OjE4LCBSb2IgSGVycmluZyB3cm90ZToKPiBPbiBUaHUsIE1hciAyLCAyMDIz
IGF0IDE6NDTigK9QTSBTdGVwaGVuIEJveWQgPHNib3lkQGtlcm5lbC5vcmc+IHdyb3RlOgo+Pgo+
PiBRdW90aW5nIFJvYiBIZXJyaW5nICgyMDIzLTAzLTAyIDA5OjEzOjU5KQo+Pj4gT24gV2VkLCBN
YXIgMSwgMjAyMyBhdCA3OjM44oCvUE0gU3RlcGhlbiBCb3lkIDxzYm95ZEBrZXJuZWwub3JnPiB3
cm90ZToKPj4+Pgo+Pj4+IFRoaXMgcGF0Y2ggc2VyaWVzIGFkZHMgdW5pdCB0ZXN0cyBmb3IgdGhl
IGNsayBmaXhlZCByYXRlIGJhc2ljIHR5cGUgYW5kCj4+Pj4gdGhlIGNsayByZWdpc3RyYXRpb24g
ZnVuY3Rpb25zIHRoYXQgdXNlIHN0cnVjdCBjbGtfcGFyZW50X2RhdGEuIFRvIGdldAo+Pj4+IHRo
ZXJlLCB3ZSBhZGQgc3VwcG9ydCBmb3IgbG9hZGluZyBhIERUQiBpbnRvIHRoZSBVTUwga2VybmVs
IHRoYXQncwo+Pj4+IHJ1bm5pbmcgdGhlIHVuaXQgdGVzdHMgYWxvbmcgd2l0aCBwcm9iaW5nIHBs
YXRmb3JtIGRyaXZlcnMgdG8gYmluZCB0bwo+Pj4+IGRldmljZSBub2RlcyBzcGVjaWZpZWQgaW4g
RFQuCj4+Pj4KPj4+PiBXaXRoIHRoaXMgc2VyaWVzLCB3ZSdyZSBhYmxlIHRvIGV4ZXJjaXNlIHNv
bWUgb2YgdGhlIGNvZGUgaW4gdGhlIGNvbW1vbgo+Pj4+IGNsayBmcmFtZXdvcmsgdGhhdCB1c2Vz
IGRldmljZXRyZWUgbG9va3VwcyB0byBmaW5kIHBhcmVudHMgYW5kIHRoZSBmaXhlZAo+Pj4+IHJh
dGUgY2xrIGNvZGUgdGhhdCBzY2FucyBkZXZpY2V0cmVlIGRpcmVjdGx5IGFuZCBjcmVhdGVzIGNs
a3MuIFBsZWFzZQo+Pj4+IHJldmlldy4KPj4+Pgo+Pj4+IEkgQ2NlZCBldmVyeW9uZSB0byBhbGwg
dGhlIHBhdGNoZXMgc28gdGhleSBnZXQgdGhlIGZ1bGwgY29udGV4dC4gSSdtCj4+Pj4gaG9waW5n
IEkgY2FuIHRha2UgdGhlIHdob2xlIHBpbGUgdGhyb3VnaCB0aGUgY2xrIHRyZWUgYXMgdGhleSBh
bG1vc3QgYWxsCj4+Pj4gZGVwZW5kIG9uIGVhY2ggb3RoZXIuIEluIHRoZSBmdXR1cmUgSSBpbWFn
aW5lIGl0IHdpbGwgYmUgZWFzeSB0byBhZGQKPj4+PiBtb3JlIHRlc3Qgbm9kZXMgdG8gdGhlIGNs
ay5kdHNpIGZpbGUgYW5kIG5vdCBuZWVkIHRvIGdvIGFjcm9zcyB2YXJpb3VzCj4+Pj4gbWFpbnRh
aW5lciB0cmVlcyBsaWtlIHRoaXMgc2VyaWVzIGRvZXMuCj4+Pj4KPj4+PiBTdGVwaGVuIEJveWQg
KDgpOgo+Pj4+ICAgZHQtYmluZGluZ3M6IEFkZCBsaW51eCxrdW5pdCBiaW5kaW5nCj4+Pj4gICBv
ZjogRW5hYmxlIERUQiBsb2FkaW5nIG9uIFVNTCBmb3IgS1VuaXQgdGVzdHMKPj4+PiAgIGt1bml0
OiBBZGQgdGVzdCBtYW5hZ2VkIHBsYXRmb3JtX2RldmljZS9kcml2ZXIgQVBJcwo+Pj4+ICAgY2xr
OiBBZGQgdGVzdCBtYW5hZ2VkIGNsayBwcm92aWRlci9jb25zdW1lciBBUElzCj4+Pj4gICBkdC1i
aW5kaW5nczoga3VuaXQ6IEFkZCBmaXhlZCByYXRlIGNsayBjb25zdW1lciB0ZXN0Cj4+Pj4gICBj
bGs6IEFkZCBLVW5pdCB0ZXN0cyBmb3IgY2xrIGZpeGVkIHJhdGUgYmFzaWMgdHlwZQo+Pj4+ICAg
ZHQtYmluZGluZ3M6IGNsazogQWRkIEtVbml0IGNsa19wYXJlbnRfZGF0YSB0ZXN0Cj4+Pj4gICBj
bGs6IEFkZCBLVW5pdCB0ZXN0cyBmb3IgY2xrcyByZWdpc3RlcmVkIHdpdGggc3RydWN0IGNsa19w
YXJlbnRfZGF0YQo+Pj4KPj4+IEdvb2QgdG8gc2VlIGJpbmRpbmdzIGZvciB0aGlzLiBJJ3ZlIGJl
ZW4gbWVhbmluZyB0byBkbyBzb21ldGhpbmcgYWJvdXQKPj4+IHRoZSBEVCB1bml0dGVzdCBvbmVz
IGJlaW5nIHVuZG9jdW1lbnRlZCwgYnV0IEkgaGFkbid0IHJlYWxseSBkZWNpZGVkCj4+PiB3aGV0
aGVyIGl0IHdhcyB3b3J0aCB3cml0aW5nIHNjaGVtYXMgZm9yIHRoZW0uIFRoZSBjb21wYXRpYmxl
cyBhdAo+Pj4gbGVhc3Qgc2hvdyB1cCB3aXRoICdtYWtlIGR0X2NvbXBhdGlibGVfY2hlY2snLiBQ
ZXJoYXBzIHdlIHdhbnQgdG8ganVzdAo+Pj4gZGVmaW5lIHNvbWUgdmVuZG9yIChub3QgJ2xpbnV4
JykgdGhhdCdzIGFuIGV4Y2VwdGlvbiByYXRoZXIgdGhhbgo+Pj4gcmVxdWlyaW5nIHNjaGVtYXMg
KGFjdHVhbGx5LCB0aGF0IGFscmVhZHkgd29ya3MgZm9yICdmb28nKS4KPj4KPj4gU3VyZS4gTWF5
YmUgImt1bml0IiBzaG91bGQgYmUgdGhlIHZlbmRvciBwcmVmaXg/IE9yICJkdGJ1bml0Ij8KPiAK
PiBXZSdkIHdhbnQgdG8gdXNlIHRoZSBzYW1lIHRoaW5nIG9uIHRoZSBEVCB1bml0dGVzdHMgb3Ig
YW55dGhpbmcgZWxzZQo+IHBvdGVudGlhbGx5LiBIb3cgYWJvdXQganVzdCAndGVzdCc/Cj4gCj4+
PiBJdCdzCj4+PiBsaWtlbHkgdGhhdCB3ZSB3YW50IHRlc3QgRFRzIHRoYXQgZmFpbCBub3JtYWwg
Y2hlY2tzIGFuZCBzY2hlbWFzIGdldAo+Pj4gaW4gdGhlIHdheSBvZiB0aGF0IGFzIHdlIGRvbid0
IGhhdmUgYSB3YXkgdG8gdHVybiBvZmYgY2hlY2tzLgo+Pgo+PiBIYXZpbmcgdGhlIHNjaGVtYXMg
aXMgbmljZSB0byBtYWtlIHN1cmUgdGVzdHMgdGhhdCBhcmUgZXhwZWN0aW5nIHNvbWUKPj4gYmlu
ZGluZyBhcmUgYWN0dWFsbHkgZ2V0dGluZyB0aGF0LiBCdXQgc3VwcG9ydGluZyBicm9rZW4gYmlu
ZGluZ3MgaXMKPj4gYWxzbyBpbXBvcnRhbnQgdG8gdGVzdCBhbnkgZXJyb3IgcGF0aHMgaW4gZnVu
Y3Rpb25zIHRoYXQgcGFyc2UKPj4gcHJvcGVydGllcy4gTWF5YmUgd2Uga2VlcCB0aGUgc2NoZW1h
IGFuZCBoYXZlIGl0IGVuZm9yY2UgdGhhdCBpbmNvcnJlY3QKPj4gcHJvcGVydGllcyBhcmUgYmVp
bmcgc2V0Pwo+IAo+IEkgd2Fzbid0IHN1Z2dlc3RpbmcgdGhyb3dpbmcgdGhlbSBvdXQuIE1vcmUg
d2h5IEkgaGFkbid0IHdyaXR0ZW4gYW55IEkgZ3Vlc3MuCj4gCj4+IERvIHdlIHJlYWxseSBuZWVk
IHRvIHRlc3QgaW5jb3JyZWN0IGJpbmRpbmdzPyBEb2Vzbid0IHRoZQo+PiBkdF9iaW5kaW5nc19j
aGVjayBjYXRjaCB0aGVzZSBwcm9ibGVtcyBzbyB3ZSBkb24ndCBoYXZlIHRvIHdyaXRlIERUQgo+
PiB2ZXJpZmllcnMgaW4gdGhlIGtlcm5lbD8KPiAKPiBGYWlyIGVub3VnaC4gVXNpbmcgbXkgZnJl
cXVlbnRseSBzdGF0ZWQgcG9zaXRpb24gYWdhaW5zdCBtZS4gOikKPiAKPiBJIGRvIGhhdmUgYSBz
ZWNyZXQgcGxhbiB0byBpbXBsZW1lbnQgKGRlYnVnKSB0eXBlIGNoZWNrcyBpbnRvIHRoZQo+IG9m
X3Byb3BlcnR5XyogQVBJcyBieSBleHRyYWN0aW5nIHRoZSB0eXBlIGluZm9ybWF0aW9uIGZyb20g
c2NoZW1hcwo+IGludG8gQy4KPiAKPiAKPj4+IFdlIGFscmVhZHkgaGF2ZSBHUElPIHRlc3RzIGlu
IHRoZSBEVCB1bml0dGVzdHMsIHNvIHdoeSBpcyBjbG9ja3MKPj4+IGRpZmZlcmVudD8gT3Igc2hv
dWxkIHRoZSBHUElPIHRlc3RzIGJlIG1vdmVkIG91dCAoeWVzLCBwbGVhc2UhKT8KPj4KPj4gQWgg
SSBkaWRuJ3Qgbm90aWNlIHRoZSBHUElPIHRlc3RzIGluIHRoZXJlLiBUaGVyZSBhcmUgaTJjIHRl
c3RzIHRvbywKPj4gcmlnaHQ/IEFsbCBJIGNhbiBzYXkgaXMgY2xrcyBhcmUgdXNpbmcga3VuaXQs
IHRoYXQncyB0aGUgZGlmZmVyZW5jZSA7LSkKPiAKPiBZZWFoLCB0aGV5IHNob3VsZCBwZXJoYXBz
IGFsbCBtb3ZlIHRvIHRoZSBzdWJzeXN0ZW1zLgo+IAo+Pj4gV2hhdCBoYXBwZW5zIHdoZW4vaWYg
dGhlIERUIHVuaXR0ZXN0IGlzIGNvbnZlcnRlZCB0byBrdW5pdD8gSSB0aGluawo+Pj4gdGhhdCB3
b3VsZCBsb29rIGNvbmZ1c2luZyBmcm9tIHRoZSBuYW1pbmcuIE15IGluaXRpYWwgdGhvdWdodCBp
cwo+Pj4gJ2t1bml0JyBzaG91bGQgYmUgZHJvcHBlZCBmcm9tIHRoZSBuYW1pbmcgb2YgYSBsb3Qg
b2YgdGhpcy4gTm90ZSB0aGF0Cj4+PiB0aGUgb3JpZ2luYWwga3VuaXQgc3VibWlzc2lvbiBjb252
ZXJ0ZWQgdGhlIERUIHVuaXR0ZXN0cy4gSSB3b3VsZAo+Pj4gc3RpbGwgbGlrZSB0byBzZWUgdGhh
dCBoYXBwZW4uIEZyYW5rIGRpc2FncmVlZCBvdmVyIHdoYXQncyBhIHVuaXQgdGVzdAo+Pj4gb3Ig
bm90LCB0aGVuIGFncmVlZCwgdGhlbiBkaWRuJ3QuLi4gSSBkb24ndCByZWFsbHkgY2FyZS4gSWYg
dGhlcmUncyBhCj4+PiBmcmFtZXdvcmsgdG8gdXNlLCB0aGVuIHdlIHNob3VsZCB1c2UgaXQgSU1P
Lgo+Pgo+PiBIb25lc3RseSBJIGRvbid0IHdhbnQgdG8gZ2V0IGludm9sdmVkIGluIG1pZ3JhdGlu
ZyB0aGUgZXhpc3RpbmcgRFQKPj4gdW5pdHRlc3QgY29kZSB0byBrdW5pdC4gSSdtIGF3YXJlIHRo
YXQgaXQgd2FzIGF0dGVtcHRlZCB5ZWFycyBhZ28gd2hlbgo+PiBrdW5pdCB3YXMgaW50cm9kdWNl
ZC4gTWF5YmUgaWYgdGhlIG92ZXJsYXkgcm91dGUgd29ya3Mgd2VsbCBlbm91Z2ggSSBjYW4KPj4g
Y29tcGxldGVseSBzaWRlc3RlcCBpbnRyb2R1Y2luZyBhbnkgY29kZSBpbiBkcml2ZXJzL29mLyBi
ZXNpZGVzIHNvbWUKPj4ga3VuaXQgd3JhcHBlcnMgZm9yIHRoaXMuIEknbGwgY3Jvc3MgbXkgZmlu
Z2VycyEKPiAKPiBZZWFoLCBJIHdhc24ndCBleHBlY3RpbmcgeW91IHRvLiBJIGp1c3Qgd2FudCB0
byBtYWtlIHN1cmUgdGhpcyBtZXNoZXMKPiB3aXRoIGFueSBmdXR1cmUgY29udmVyc2lvbiB0byBr
dW5pdC4KPiAKPiBUaGVyZSdzIGFsc28gc29tZSBwbGFucyB0byBhbHdheXMgcG9wdWxhdGUgdGhl
IERUIHJvb3Qgbm9kZSBpZiBub3QKPiBwcmVzZW50LiBUaGF0IG1heSBoZWxwIGhlcmUuIE9yIG5v
dC4gVGhlcmUncyBiZWVuIGEgZmV3IHZlcnNpb25zCj4gcG9zdGVkIHdpdGggRnJhbmsncyBpbiB0
aGUgbGFzdCB3ZWVrIG9yIDIuCgpBcyBub3RlZCBpbiB0aGF0IHRocmVhZCwgYnkgY29kZSBpbnNw
ZWN0aW9uIChub3QgYWN0dWFsIHRlc3RpbmcpIEkKdGhpbmsgdGhhdCB0aGUgcGF0Y2ggc2VyaWVz
IGJyZWFrcyBEVCB1bml0dGVzdCBmb3IgVU1MLiAgSXQgc2hvdWxkIGJlCmEgdHJpdmlhbCBjaGFu
Z2UgaW4gdGhlIG5leHQgcGF0Y2ggdmVyc2lvbiB0byBmaXguCgo+IAo+IFJvYgoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcg
bGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K

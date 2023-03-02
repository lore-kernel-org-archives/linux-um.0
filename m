Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37179C6FA8E
	for <linux-um@archiver.kernel.org>; Thu,  2 Mar 2023 17:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y/y5VJGP6NEQKW5WiGsKYi4NTu0uMsUWMPjKVnfQPDY=; b=eN2x8JENLcHgjS
	nEUp6VDCtYBi+fSoZF8FKbxFvIX+8oi69+OoxsH3HaLimneKI/MyMMDsnKzBlAL6iDyrCi2lGG8GS
	4LuBOJA+OKBk9d8pA0h59woTLDJHFQRWwdVaDlwq0hTit8xlCvjR/GjbR9JjzY9oMe7woX5ZT6gI0
	/ZEA35bxMJvd8J/YeiEV3SNvE2ychL7EiI/jtQRjmDtMKNYf4/rNBX97htgHA5b5OND2UD7hap78e
	5y8GWH8clgBdE7jHQg0FS8CFuVfiFB59Wm6v+Sqf/36Ww/Hg6zHG2bXJ/P7LbxhtX52OBeEbGQOjS
	7aGBYcXP/L9U74Mb8Mwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXmVU-002wY2-Sk; Thu, 02 Mar 2023 17:14:16 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXmVR-002wXP-Sh
	for linux-um@lists.infradead.org; Thu, 02 Mar 2023 17:14:15 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 40EF1615C7
	for <linux-um@lists.infradead.org>; Thu,  2 Mar 2023 17:14:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB8AC433A8
	for <linux-um@lists.infradead.org>; Thu,  2 Mar 2023 17:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1677777252;
	bh=sxh36iZQRth6PcbEK8rBaNdhPJuIjt084P0tIKyNndg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TAJj++imQypJWlswGfOoct5GpNWCJQsD7oCXqgQ+ZDG8uNTAaoEaYgHDCMmVXcK2X
	 jB2C7tAJYpWiuL6YafBBMtsMVUYOCQrRTkfpoH2WH0W3qjbUP53Vj0Fw8x928o5+H0
	 B3X0tkSkIQsoJKkhoOAQNwr3MaqnneespIRdTZKbtUtbpCq3wtLWfzBYaQCGuJznp5
	 +2+jmuUHw6CUofbdurXFfoqeC+3fpZ523uvG5P3p8jI8KoD8MZuo1DwBAtxlhXwW0M
	 i1AGLygTd9avSKC1IuYZNT7A91xL/Q075a1GwO/YFePebxenzP5rnDD7KFjGYoXuyQ
	 w+gk9vEAOiauQ==
Received: by mail-ua1-f49.google.com with SMTP id s13so6654383uac.8
        for <linux-um@lists.infradead.org>; Thu, 02 Mar 2023 09:14:12 -0800 (PST)
X-Gm-Message-State: AO0yUKUZ/tLrTGGhMeGo22mHAIw1iSRtJU72R3+JcC1AEyHD1vzqIPEG
	FraDVvHveD2zadHAE+pN8W4gRgNK8bPWrzOukQ==
X-Google-Smtp-Source: AK7set/cWK8giFKY8fRLWeGOHTziXVw5azzC2FP84wrmvxubHnP5GVl40pOdsWrs8+z15dRYvJSehk78bGu43zZqZQU=
X-Received: by 2002:a05:6122:b55:b0:40f:2033:6994 with SMTP id
 21-20020a0561220b5500b0040f20336994mr6152564vko.2.1677777250943; Thu, 02 Mar
 2023 09:14:10 -0800 (PST)
MIME-Version: 1.0
References: <20230302013822.1808711-1-sboyd@kernel.org>
In-Reply-To: <20230302013822.1808711-1-sboyd@kernel.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 2 Mar 2023 11:13:59 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLVQVZhYTSZgrvA-V-xOUbiBdyDxqPOZk=89YS33EahBQ@mail.gmail.com>
Message-ID: <CAL_JsqLVQVZhYTSZgrvA-V-xOUbiBdyDxqPOZk=89YS33EahBQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] clk: Add kunit tests for fixed rate and parent data
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, patches@lists.linux.dev, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, Frank Rowand <frowand.list@gmail.com>, 
	Christian Marangi <ansuelsmth@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, devicetree@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230302_091414_043417_C2D03DF3 
X-CRM114-Status: GOOD (  30.81  )
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

T24gV2VkLCBNYXIgMSwgMjAyMyBhdCA3OjM44oCvUE0gU3RlcGhlbiBCb3lkIDxzYm95ZEBrZXJu
ZWwub3JnPiB3cm90ZToKPgo+IFRoaXMgcGF0Y2ggc2VyaWVzIGFkZHMgdW5pdCB0ZXN0cyBmb3Ig
dGhlIGNsayBmaXhlZCByYXRlIGJhc2ljIHR5cGUgYW5kCj4gdGhlIGNsayByZWdpc3RyYXRpb24g
ZnVuY3Rpb25zIHRoYXQgdXNlIHN0cnVjdCBjbGtfcGFyZW50X2RhdGEuIFRvIGdldAo+IHRoZXJl
LCB3ZSBhZGQgc3VwcG9ydCBmb3IgbG9hZGluZyBhIERUQiBpbnRvIHRoZSBVTUwga2VybmVsIHRo
YXQncwo+IHJ1bm5pbmcgdGhlIHVuaXQgdGVzdHMgYWxvbmcgd2l0aCBwcm9iaW5nIHBsYXRmb3Jt
IGRyaXZlcnMgdG8gYmluZCB0bwo+IGRldmljZSBub2RlcyBzcGVjaWZpZWQgaW4gRFQuCj4KPiBX
aXRoIHRoaXMgc2VyaWVzLCB3ZSdyZSBhYmxlIHRvIGV4ZXJjaXNlIHNvbWUgb2YgdGhlIGNvZGUg
aW4gdGhlIGNvbW1vbgo+IGNsayBmcmFtZXdvcmsgdGhhdCB1c2VzIGRldmljZXRyZWUgbG9va3Vw
cyB0byBmaW5kIHBhcmVudHMgYW5kIHRoZSBmaXhlZAo+IHJhdGUgY2xrIGNvZGUgdGhhdCBzY2Fu
cyBkZXZpY2V0cmVlIGRpcmVjdGx5IGFuZCBjcmVhdGVzIGNsa3MuIFBsZWFzZQo+IHJldmlldy4K
Pgo+IEkgQ2NlZCBldmVyeW9uZSB0byBhbGwgdGhlIHBhdGNoZXMgc28gdGhleSBnZXQgdGhlIGZ1
bGwgY29udGV4dC4gSSdtCj4gaG9waW5nIEkgY2FuIHRha2UgdGhlIHdob2xlIHBpbGUgdGhyb3Vn
aCB0aGUgY2xrIHRyZWUgYXMgdGhleSBhbG1vc3QgYWxsCj4gZGVwZW5kIG9uIGVhY2ggb3RoZXIu
IEluIHRoZSBmdXR1cmUgSSBpbWFnaW5lIGl0IHdpbGwgYmUgZWFzeSB0byBhZGQKPiBtb3JlIHRl
c3Qgbm9kZXMgdG8gdGhlIGNsay5kdHNpIGZpbGUgYW5kIG5vdCBuZWVkIHRvIGdvIGFjcm9zcyB2
YXJpb3VzCj4gbWFpbnRhaW5lciB0cmVlcyBsaWtlIHRoaXMgc2VyaWVzIGRvZXMuCj4KPiBTdGVw
aGVuIEJveWQgKDgpOgo+ICAgZHQtYmluZGluZ3M6IEFkZCBsaW51eCxrdW5pdCBiaW5kaW5nCj4g
ICBvZjogRW5hYmxlIERUQiBsb2FkaW5nIG9uIFVNTCBmb3IgS1VuaXQgdGVzdHMKPiAgIGt1bml0
OiBBZGQgdGVzdCBtYW5hZ2VkIHBsYXRmb3JtX2RldmljZS9kcml2ZXIgQVBJcwo+ICAgY2xrOiBB
ZGQgdGVzdCBtYW5hZ2VkIGNsayBwcm92aWRlci9jb25zdW1lciBBUElzCj4gICBkdC1iaW5kaW5n
czoga3VuaXQ6IEFkZCBmaXhlZCByYXRlIGNsayBjb25zdW1lciB0ZXN0Cj4gICBjbGs6IEFkZCBL
VW5pdCB0ZXN0cyBmb3IgY2xrIGZpeGVkIHJhdGUgYmFzaWMgdHlwZQo+ICAgZHQtYmluZGluZ3M6
IGNsazogQWRkIEtVbml0IGNsa19wYXJlbnRfZGF0YSB0ZXN0Cj4gICBjbGs6IEFkZCBLVW5pdCB0
ZXN0cyBmb3IgY2xrcyByZWdpc3RlcmVkIHdpdGggc3RydWN0IGNsa19wYXJlbnRfZGF0YQoKR29v
ZCB0byBzZWUgYmluZGluZ3MgZm9yIHRoaXMuIEkndmUgYmVlbiBtZWFuaW5nIHRvIGRvIHNvbWV0
aGluZyBhYm91dAp0aGUgRFQgdW5pdHRlc3Qgb25lcyBiZWluZyB1bmRvY3VtZW50ZWQsIGJ1dCBJ
IGhhZG4ndCByZWFsbHkgZGVjaWRlZAp3aGV0aGVyIGl0IHdhcyB3b3J0aCB3cml0aW5nIHNjaGVt
YXMgZm9yIHRoZW0uIFRoZSBjb21wYXRpYmxlcyBhdApsZWFzdCBzaG93IHVwIHdpdGggJ21ha2Ug
ZHRfY29tcGF0aWJsZV9jaGVjaycuIFBlcmhhcHMgd2Ugd2FudCB0byBqdXN0CmRlZmluZSBzb21l
IHZlbmRvciAobm90ICdsaW51eCcpIHRoYXQncyBhbiBleGNlcHRpb24gcmF0aGVyIHRoYW4KcmVx
dWlyaW5nIHNjaGVtYXMgKGFjdHVhbGx5LCB0aGF0IGFscmVhZHkgd29ya3MgZm9yICdmb28nKS4g
SXQncwpsaWtlbHkgdGhhdCB3ZSB3YW50IHRlc3QgRFRzIHRoYXQgZmFpbCBub3JtYWwgY2hlY2tz
IGFuZCBzY2hlbWFzIGdldAppbiB0aGUgd2F5IG9mIHRoYXQgYXMgd2UgZG9uJ3QgaGF2ZSBhIHdh
eSB0byB0dXJuIG9mZiBjaGVja3MuCgpXZSBhbHJlYWR5IGhhdmUgR1BJTyB0ZXN0cyBpbiB0aGUg
RFQgdW5pdHRlc3RzLCBzbyB3aHkgaXMgY2xvY2tzCmRpZmZlcmVudD8gT3Igc2hvdWxkIHRoZSBH
UElPIHRlc3RzIGJlIG1vdmVkIG91dCAoeWVzLCBwbGVhc2UhKT8KCldoYXQgaGFwcGVucyB3aGVu
L2lmIHRoZSBEVCB1bml0dGVzdCBpcyBjb252ZXJ0ZWQgdG8ga3VuaXQ/IEkgdGhpbmsKdGhhdCB3
b3VsZCBsb29rIGNvbmZ1c2luZyBmcm9tIHRoZSBuYW1pbmcuIE15IGluaXRpYWwgdGhvdWdodCBp
cwona3VuaXQnIHNob3VsZCBiZSBkcm9wcGVkIGZyb20gdGhlIG5hbWluZyBvZiBhIGxvdCBvZiB0
aGlzLiBOb3RlIHRoYXQKdGhlIG9yaWdpbmFsIGt1bml0IHN1Ym1pc3Npb24gY29udmVydGVkIHRo
ZSBEVCB1bml0dGVzdHMuIEkgd291bGQKc3RpbGwgbGlrZSB0byBzZWUgdGhhdCBoYXBwZW4uIEZy
YW5rIGRpc2FncmVlZCBvdmVyIHdoYXQncyBhIHVuaXQgdGVzdApvciBub3QsIHRoZW4gYWdyZWVk
LCB0aGVuIGRpZG4ndC4uLiBJIGRvbid0IHJlYWxseSBjYXJlLiBJZiB0aGVyZSdzIGEKZnJhbWV3
b3JrIHRvIHVzZSwgdGhlbiB3ZSBzaG91bGQgdXNlIGl0IElNTy4KCj4KPiAgLi4uL2Nsb2NrL2xp
bnV4LGNsay1rdW5pdC1wYXJlbnQtZGF0YS55YW1sICAgIHwgIDQ3ICsrCj4gIC4uLi9rdW5pdC9s
aW51eCxjbGsta3VuaXQtZml4ZWQtcmF0ZS55YW1sICAgICB8ICAzNSArKwo+ICAuLi4vYmluZGlu
Z3Mva3VuaXQvbGludXgsa3VuaXQueWFtbCAgICAgICAgICAgfCAgMjQgKwo+ICBhcmNoL3VtL2tl
cm5lbC9kdGIuYyAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMjkgKy0KPiAgZHJpdmVycy9j
bGsvLmt1bml0Y29uZmlnICAgICAgICAgICAgICAgICAgICAgIHwgICAzICsKPiAgZHJpdmVycy9j
bGsvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA3ICsKPiAgZHJpdmVycy9j
bGsvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA2ICsKPiAgZHJpdmVycy9j
bGsvY2xrLWZpeGVkLXJhdGVfdGVzdC5jICAgICAgICAgICAgIHwgMjk2ICsrKysrKysrKysrKwo+
ICBkcml2ZXJzL2Nsay9jbGsta3VuaXQuYyAgICAgICAgICAgICAgICAgICAgICAgfCAyMDQgKysr
KysrKysKPiAgZHJpdmVycy9jbGsvY2xrLWt1bml0LmggICAgICAgICAgICAgICAgICAgICAgIHwg
IDI4ICsrCj4gIGRyaXZlcnMvY2xrL2Nsa190ZXN0LmMgICAgICAgICAgICAgICAgICAgICAgICB8
IDQ1NiArKysrKysrKysrKysrKysrKy0KPiAgZHJpdmVycy9vZi9LY29uZmlnICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgIDI2ICsKPiAgZHJpdmVycy9vZi9NYWtlZmlsZSAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgICAxICsKPiAgZHJpdmVycy9vZi9rdW5pdC8ua3VuaXRjb25maWcg
ICAgICAgICAgICAgICAgIHwgICA0ICsKPiAgZHJpdmVycy9vZi9rdW5pdC9NYWtlZmlsZSAgICAg
ICAgICAgICAgICAgICAgIHwgICA0ICsKPiAgZHJpdmVycy9vZi9rdW5pdC9jbGsuZHRzaSAgICAg
ICAgICAgICAgICAgICAgIHwgIDMwICsrCj4gIGRyaXZlcnMvb2Yva3VuaXQva3VuaXQuZHRzaSAg
ICAgICAgICAgICAgICAgICB8ICAgOSArCj4gIGRyaXZlcnMvb2Yva3VuaXQva3VuaXQuZHRzbyAg
ICAgICAgICAgICAgICAgICB8ICAgNCArCj4gIGRyaXZlcnMvb2Yva3VuaXQvdW1sX2R0Yl90ZXN0
LmMgICAgICAgICAgICAgICB8ICA1NSArKysKPiAgaW5jbHVkZS9rdW5pdC9wbGF0Zm9ybV9kcml2
ZXIuaCAgICAgICAgICAgICAgIHwgIDE1ICsKPiAgbGliL2t1bml0L01ha2VmaWxlICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgICA2ICsKPiAgbGliL2t1bml0L3BsYXRmb3JtX2RyaXZlci10
ZXN0LmMgICAgICAgICAgICAgIHwgMTA3ICsrKysKPiAgbGliL2t1bml0L3BsYXRmb3JtX2RyaXZl
ci5jICAgICAgICAgICAgICAgICAgIHwgMjA3ICsrKysrKysrCgpIdW1tLCB3ZSBoYXZlIERUIHBs
YXRmb3JtIGRyaXZlciB1bml0dGVzdHMgdG9vLiBXaGF0J3MgdGhlIGRpZmZlcmVuY2U/CgpBbnl3
YXlzLCB0aGF0J3MgYWxsIGp1c3QgbXkgaW5pdGlhbCByZWFjdGlvbiBmcm9tIG9ubHkgaGFsZndh
eSBsb29raW5nCmF0IHRoaXMuIDopCgpSb2IKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtdW0K

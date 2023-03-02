Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 793D6C6FA8E
	for <linux-um@archiver.kernel.org>; Thu,  2 Mar 2023 19:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dTyoJq9ReOB6vcWI12JMWpEA8BRGWHT79IgX2ijrnGo=; b=ox30eImHZ3okmb
	kNYvgYLx7iCsRvOPt2pjnuM1SQ616uMXwGm4QPAGrcHpncdwQtbTwEhxoXguLwL08FJRnlXFwFBKE
	8Y/eRzRroUKmSkfEWzy2Viv5+q9Ms/nprbUdzfCQSMPzwQu4Nu90SXi1Kar8Pju+XBDzYzmJiSins
	S+x2XhYODakUYYtPtrhsPoPTmWkVlKgSWp13aF0aYHhN2pKYmYTevwOOUxHQhBXBIw1gDDegx9Eke
	fDnrjj5Lz7g90FncMpgbudD8Oi5s0f4vsFCj/1moRzta7SqbveuIEBuQ0lBgfNiuJxu9MO8Uy47yr
	JVovQMUx9kUQyI7SCclQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXou7-003Bhl-47; Thu, 02 Mar 2023 19:47:51 +0000
Received: from mail-qt1-f180.google.com ([209.85.160.180])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXou3-003BgJ-3p
	for linux-um@lists.infradead.org; Thu, 02 Mar 2023 19:47:49 +0000
Received: by mail-qt1-f180.google.com with SMTP id h19so498520qtk.7
        for <linux-um@lists.infradead.org>; Thu, 02 Mar 2023 11:47:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f95O1774ZoBykD/usZaosY+efoKseNjJy4cpA8XSzCQ=;
        b=C9D2qc1ccD0RS0CiKxS4lJX6YKfEgASXuXwuhY0anhyTwN+QPpr5QMlBRcrC6G13ip
         TRSIbBIJvnW+b6tmRzmvvU/B2mOHPz30L4PNW/bqYT4F4KXRUG0vsKftrDdL83+gWRfT
         59InLviqDKYYCPWQFUVDfLvfeH7LILjWXEfPh8Z314PEpwW3FtGGqYGLG0d7L10jVt3B
         +zNLfOxu6kI00xBfaI8W0CG3HApUc9Ty1ukG1hhUQzOME6pqsdJLWuzYEDn/0eMr95tz
         0uIaJL5owotOQxYPLhQyGuVnI1u+bQY0okr+wlytWF3CbMrSOlmIFlLesUKqut9NKUOq
         KuVg==
X-Gm-Message-State: AO0yUKWLeHCBwp5/mo8vVUkGejv/+hfovUEjyX3rcXrx34HGTJYZnzKS
	76i9SC6vISrSfrQFOCeRi7ZXbY4842KuiA==
X-Google-Smtp-Source: AK7set+0MgShyrSZdki4WHjLlsOEY36MtEIQqkr2bveMOHG/BS8BCsb01fEoODCDMKUjLTg5X4hYNg==
X-Received: by 2002:ac8:4e4a:0:b0:3b8:6c4d:488a with SMTP id e10-20020ac84e4a000000b003b86c4d488amr17560435qtw.37.1677786464758;
        Thu, 02 Mar 2023 11:47:44 -0800 (PST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id x13-20020ac8120d000000b003bffe7fdc38sm323853qti.9.2023.03.02.11.47.43
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 11:47:44 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-53852143afcso2179627b3.3
        for <linux-um@lists.infradead.org>; Thu, 02 Mar 2023 11:47:43 -0800 (PST)
X-Received: by 2002:a81:ad1b:0:b0:52f:1c23:ef1 with SMTP id
 l27-20020a81ad1b000000b0052f1c230ef1mr7066170ywh.5.1677786463634; Thu, 02 Mar
 2023 11:47:43 -0800 (PST)
MIME-Version: 1.0
References: <20230302013822.1808711-1-sboyd@kernel.org> <CABVgOSnpMNCtEEsJV28OzUoxdDuiT4a2T0avP0AYf9xFW1jxrw@mail.gmail.com>
 <CAL_JsqJMd3Fi0ZBObdyE1VDKTH1_+smuGDymHnKOkVH2HB3jJQ@mail.gmail.com> <3759b28cca7ab751296d4dd83f2dcc51.sboyd@kernel.org>
In-Reply-To: <3759b28cca7ab751296d4dd83f2dcc51.sboyd@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 2 Mar 2023 20:47:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXDx6ChRj4xvWbQgcdJd0CGFi-RXySXr=M8QhBkA7YiGw@mail.gmail.com>
Message-ID: <CAMuHMdXDx6ChRj4xvWbQgcdJd0CGFi-RXySXr=M8QhBkA7YiGw@mail.gmail.com>
Subject: Re: [PATCH 0/8] clk: Add kunit tests for fixed rate and parent data
To: Stephen Boyd <sboyd@kernel.org>
Cc: David Gow <davidgow@google.com>, Rob Herring <robh+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, patches@lists.linux.dev, 
	Brendan Higgins <brendan.higgins@linux.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, Frank Rowand <frowand.list@gmail.com>, 
	Christian Marangi <ansuelsmth@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, devicetree@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230302_114747_202557_26FC1DCF 
X-CRM114-Status: GOOD (  56.58  )
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

SGkgU3RlcGhlbiwKCk9uIFRodSwgTWFyIDIsIDIwMjMgYXQgODoyOOKAr1BNIFN0ZXBoZW4gQm95
ZCA8c2JveWRAa2VybmVsLm9yZz4gd3JvdGU6Cj4gUXVvdGluZyBSb2IgSGVycmluZyAoMjAyMy0w
My0wMiAwOTozMjowOSkKPiA+IE9uIFRodSwgTWFyIDIsIDIwMjMgYXQgMjoxNOKAr0FNIERhdmlk
IEdvdyA8ZGF2aWRnb3dAZ29vZ2xlLmNvbT4gd3JvdGU6Cj4gPiA+IE9uIFRodSwgMiBNYXIgMjAy
MyBhdCAwOTozOCwgU3RlcGhlbiBCb3lkIDxzYm95ZEBrZXJuZWwub3JnPiB3cm90ZToKPiA+ID4g
PiBUaGlzIHBhdGNoIHNlcmllcyBhZGRzIHVuaXQgdGVzdHMgZm9yIHRoZSBjbGsgZml4ZWQgcmF0
ZSBiYXNpYyB0eXBlIGFuZAo+ID4gPiA+IHRoZSBjbGsgcmVnaXN0cmF0aW9uIGZ1bmN0aW9ucyB0
aGF0IHVzZSBzdHJ1Y3QgY2xrX3BhcmVudF9kYXRhLiBUbyBnZXQKPiA+ID4gPiB0aGVyZSwgd2Ug
YWRkIHN1cHBvcnQgZm9yIGxvYWRpbmcgYSBEVEIgaW50byB0aGUgVU1MIGtlcm5lbCB0aGF0J3MK
PiA+ID4gPiBydW5uaW5nIHRoZSB1bml0IHRlc3RzIGFsb25nIHdpdGggcHJvYmluZyBwbGF0Zm9y
bSBkcml2ZXJzIHRvIGJpbmQgdG8KPiA+ID4gPiBkZXZpY2Ugbm9kZXMgc3BlY2lmaWVkIGluIERU
Lgo+ID4gPiA+Cj4gPiA+ID4gV2l0aCB0aGlzIHNlcmllcywgd2UncmUgYWJsZSB0byBleGVyY2lz
ZSBzb21lIG9mIHRoZSBjb2RlIGluIHRoZSBjb21tb24KPiA+ID4gPiBjbGsgZnJhbWV3b3JrIHRo
YXQgdXNlcyBkZXZpY2V0cmVlIGxvb2t1cHMgdG8gZmluZCBwYXJlbnRzIGFuZCB0aGUgZml4ZWQK
PiA+ID4gPiByYXRlIGNsayBjb2RlIHRoYXQgc2NhbnMgZGV2aWNldHJlZSBkaXJlY3RseSBhbmQg
Y3JlYXRlcyBjbGtzLiBQbGVhc2UKPiA+ID4gPiByZXZpZXcuCj4gPiA+ID4KPiA+ID4KPiA+ID4g
VGhhbmtzIFN0ZXBoZW4gLS0gdGhpcyBpcyByZWFsbHkgbmVhdCEKPiA+ID4KPiA+ID4gVGhpcyB3
b3JrcyB3ZWxsIGhlcmUsIGFuZCBJIGxvdmUgYWxsIG9mIHRoZSB0ZXN0cyBmb3IgdGhlCj4gPiA+
IEtVbml0L2RldmljZS10cmVlIGludGVncmF0aW9uIGFzIHdlbGwuCj4gPiA+Cj4gPiA+IEknbSBz
dGlsbCBsb29raW5nIHRocm91Z2ggdGhlIGRldGFpbHMgb2YgaXQgKGFsYXMsIEkndmUgbW9zdGx5
IGxpdmVkCj4gPiA+IGluIHg4Ni1sYW5kLCBzbyBteSBkZXZpY2UtdHJlZSBrbm93bGVkZ2UgaXMs
IHVoLCBzcG90dHkgdG8gc2F5IHRoZQo+ID4gPiBsZWFzdCksIGJ1dCBhcGFydCBmcm9tIHBvc3Np
Ymx5IHJlbmFtaW5nIHNvbWUgdGhpbmdzIG9yIHNpbWlsYXJseQo+ID4gPiBtaW5vciB0d2Vha3Ms
IEkndmUgbm90IGdvdCBhbnkgcmVhbCBzdWdnZXN0aW9ucyB0aHVzIGZhci4KPiA+ID4KPiA+ID4g
SSBkbyB3b25kZXIgd2hldGhlciB3ZSdsbCB3YW50LCBvbiB0aGUgS1VuaXQgc2lkZSwgdG8gaGF2
ZSBzb21lIHdheSBvZgo+ID4gPiBzdXBwb3J0aW5nIEtVbml0IGRldmljZSB0cmVlcyBvbiBub24t
VU1MIGFyY2hpdGVjY3R1cmVzIChlLmcuLCBpZiB3ZQo+ID4gPiBuZWVkIHRvIHRlc3Qgc29tZXRo
aW5nIGFyY2hpdGVjdHVyZS1zcGVjaWZpYywgb3Igb24gYSBiaWctZW5kaWFuCj4gPiA+IHBsYXRm
b3JtLCBldGMpLCBidXQgSSB0aGluayB0aGF0J3MgYSBxdWVzdGlvbiBmb3IgdGhlIGZ1dHVyZSwg
cmF0aGVyCj4gPiA+IHRoYW4gc29tZXRoaW5nIHRoYXQgYWZmZWN0cyB0aGlzIHNlcmllcy4KPiA+
Cj4gPiBJJ2xsIHNheSB0aGF0J3MgYSByZXF1aXJlbWVudC4gV2Ugc2hvdWxkIGJlIGFibGUgdG8g
c3RydWN0dXJlIHRoZQo+ID4gdGVzdHMgdG8gbm90IGludGVyZmVyZSB3aXRoIHRoZSBydW5uaW5n
IHN5c3RlbSdzIERULiBUaGUgRFQgdW5pdHRlc3QKPiA+IGRvZXMgdGhhdC4KPgo+IFRoYXQgY291
bGQgYmUgYW5vdGhlciBjaG9pY2UgaW4gdGhlIHVuaXQgdGVzdCBjaG9pY2UgbWVudS4KPiBDT05G
SUdfT0ZfS1VOSVRfTk9UX1VNTCB0aGF0IGluamVjdHMgc29tZSBidWlsdC1pbiBEVEIgb3Zlcmxh
eSBvbiBhbgo+IGFyY2hpdGVjdHVyZSB0aGF0IHdhbnRzIHRvIHJ1biB0ZXN0cy4KCkFzIGxvbmcg
YXMgeW91IHVzZSBjb21wYXRpYmxlIHZhbHVlcyB0aGF0IGRvbid0IGV4aXN0IGVsc2V3aGVyZSwK
YW5kIGRvbid0IG92ZXJ3cml0ZSBhbnl0aGluZywgeW91IGNhbiBsb2FkIHlvdXIga3VuaXQgdGVz
dCBvdmVybGF5cwpvbiBhbnkgcnVubmluZyBzeXN0ZW0gdGhhdCBoYXMgRFQgc3VwcG9ydC4KCj4g
PiBBcyBhIHNpZGUgdG9waWMsIElzIGFueW9uZSBsb29raW5nIGF0IGdldHRpbmcgVU1MIHRvIHdv
cmsgb24gYXJtNjQ/Cj4gPiBJdCdzIHN1cnByaXNpbmcgaG93IG11Y2ggeDg2IHN0dWZmIHRoZXJl
IGlzIHdoaWNoIGlzIEkgZ3Vlc3Mgb25lCj4gPiByZWFzb24gaXQgaGFzbid0IGhhcHBlbmVkLgo+
Cj4gSSd2ZSBubyBpZGVhIGJ1dCBpdCB3b3VsZCBiZSBuaWNlIGluZGVlZC4KCkkgYmVsaWV2ZSB0
aGF0J3Mgbm9uLXRyaXZpYWwuIEF0IGxlYXN0IGZvciBhcm0zMiAoSSBkaWRuJ3QgaGF2ZSBhbnkg
YXJtNjQKc3lzdGVtcyBsYXN0IHRpbWUgSSBhc2tlZCB0aGUgZXhwZXJ0cykuCgo+ID4gPiBTaW1p
bGFybHksIEkgd29uZGVyIGlmIHRoZXJlJ3Mgc29tZXRoaW5nIHdlIGNvdWxkIGRvIHdpdGggZGV2
aWNlIHRyZWUKPiA+ID4gb3ZlcmxheXMsIGluIG9yZGVyIHRvIG1ha2UgaXQgcG9zc2libGUgZm9y
IHRlc3RzIHRvIHN3YXAgbm9kZXMgaW4gYW5kCj4gPiA+IG91dCBmb3IgdGVzdGluZy4KPiA+Cj4g
PiBZZXMsIHRoYXQncyBob3cgdGhlIERUIHVuaXR0ZXN0IHdvcmtzLiBCdXQgaXQgaXMgcHJldHR5
IG11Y2ggb25lIGJpZwo+ID4gb3ZlcmxheSAoaWdub3JpbmcgdGhlIG92ZXJsYXkgdGVzdHMpLiBJ
dCBjb3VsZCBwcm9iYWJseSBiZSBtb3JlCj4gPiBtb2R1bGFyIHdoZXJlIGl0IGlzIGFwcGx5IG92
ZXJsYXksIHRlc3QsIHJlbW92ZSBvdmVybGF5LCByZXBlYXQuCj4KPiBJIGRpZG4ndCB3YW50IHRv
IHJlbHkgb24gdGhlIG92ZXJsYXkgY29kZSB0byBpbmplY3QgRFQgbm9kZXMuIEhhdmluZwo+IHRl
c3RzIHdyaXR0ZW4gZm9yIHRoZSBmYWtlIEtVbml0IG1hY2hpbmUgaXMgc2ltcGxlLiBJdCBjbG9z
ZWx5IG1hdGNoZXMKPiBob3cgY2xrIGNvZGUgcHJvYmVzIHRoZSBEVEIgYW5kIGhvdyBub2RlcyBh
cmUgY3JlYXRlZCBhbmQgcG9wdWxhdGVkIG9uCj4gdGhlIHBsYXRmb3JtIGJ1cyBhcyBkZXZpY2Vz
LiBDTEtfT0ZfREVDTEFSRSgpIHdvdWxkIG5lZWQgdGhlIG92ZXJsYXkgdG8KPiBiZSBhcHBsaWVk
IGVhcmx5IHRvbywgd2hpY2ggZG9lc24ndCBoYXBwZW4gb3RoZXJ3aXNlIGFzIGZhciBhcyBJIGtu
b3cuCgpEb24ndCBhbGwgZ2VuZXJpYyBjbG9jayBkcml2ZXJzIGFsc28gY3JlYXRlIGEgcGxhdGZv
cm0gZHJpdmVyPwpBdCBsZWFzdCBkcml2ZXJzL2Nsay9jbGstZml4ZWQtZmFjdG9yLmMgZG9lcy4K
Cj4gQnV0IHBlcmhhcHMgdGhpcyBkZXNpZ24gaXMgdG9vIG11Y2ggb2YgYW4gZW5kLXRvLWVuZCB0
ZXN0IGFuZCBub3QgYSB1bml0Cj4gdGVzdD8gSW4gdGhlIHNwaXJpdCBvZiB1bml0IHRlc3Rpbmcg
d2Ugc2hvdWxkbid0IGNhcmUgYWJvdXQgaG93IHRoZSBub2RlCj4gaXMgYWRkZWQgdG8gdGhlIGxp
dmUgZGV2aWNldHJlZSwganVzdCB0aGF0IHRoZXJlIGlzIGEgZGV2aWNldHJlZSBhdCBhbGwuCj4K
PiBTdXBwb3J0aW5nIG92ZXJsYXlzIHRvIG1vcmUgZWFzaWx5IHRlc3QgY29tYmluYXRpb25zIHNv
dW5kcyBsaWtlIGEgZ29vZAo+IGlkZWEuIFByb2JhYmx5IHNvbWUga3VuaXRfKigpIHByZWZpeGVk
IGZ1bmN0aW9ucyBjb3VsZCBiZSB1c2VkIHRvCj4gYXBwbHkgYSB0ZXN0IG1hbmFnZWQgb3Zlcmxh
eSBhbmQgYXV0b21hdGljYWxseSByZW1vdmUgaXQgd2hlbiB0aGUgdGVzdAo+IGlzIG92ZXIgd291
bGQgd29yay4gVGhlIGNsayByZWdpc3RyYXRpb24gdGVzdHMgY291bGQgdXNlIHRoaXMgQVBJIHRv
Cj4gaW5qZWN0IGFuIG92ZXJsYXkgYW5kIHRoZW4gbWFudWFsbHkgY2FsbCB0aGUgb2ZfcGxhdGZv
cm1fcG9wdWxhdGUoKQo+IGZ1bmN0aW9uIHRvIGNyZWF0ZSB0aGUgcGxhdGZvcm0gZGV2aWNlKHMp
LiBUaGUgb3ZlcmxheSBjb3VsZCBiZSBidWlsdCBpbgo+IGRyaXZlcnMvY2xrLyB0b28gYW5kIHRo
ZW4gcHJvYmFibHkgc29tZSBtYWNyb2lzaCBmdW5jdGlvbiBjYW4gZmluZCB0aGUKPiBibG9iIGFu
ZCBhcHBseSBpdC4KCk5vIG5lZWQgdG8gbWFudWFsbHkgY2FsbCBvZl9wbGF0Zm9ybV9wb3B1bGF0
ZSgpIHRvIGNyZWF0ZSB0aGUKcGxhdGZvcm0gZGV2aWNlcy4gVGhhdCBpcyB0YWtlbiBjYXJlIG9m
IGF1dG9tYXRpY2FsbHkgd2hlbiBhcHBseWluZwphbiBvdmVybGF5LgoKPiBJcyB0aGVyZSBzb21l
IHdheSB0byBkZWxldGUgdGhlIHBsYXRmb3JtIGRldmljZXMgdGhhdCB3ZSBwb3B1bGF0ZSBmcm9t
Cj4gdGhlIG92ZXJsYXk/IEknZCBsaWtlIHRoZSB0ZXN0cyB0byBiZSBoZXJtZXRpYy4KClJlbW92
aW5nIHRoZSBvdmVybGF5IHdpbGwgZGVsZXRlIHRoZSBwbGF0Zm9ybSBkZXZpY2VzLgoKQWxsIG9m
IHRoYXQgd29ya3MgaWYgeW91IGhhdmUgeW91ciBvd24gY29kZSB0byBhcHBseSBhIERUIG92ZXJs
YXkuClRoZSByZWNlbnQgZndfZGV2bGlua3MgcGF0Y2hlcyBkaWQgY2F1c2Ugc29tZSByZWdyZXNz
aW9ucywgY2ZyLgpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvQ0FNdUhNZFhFblNENHJSSi1v
OTB4NE9wclVhY05fckpneW84eDY9OUY5clorLUt6ak9nQG1haWwuZ21haWwuY29tCgpQLlMuIFNo
YW1lbGVzcyBwbHVnOiBmb3IgbG9hZGluZyBvdmVybGF5cyBmcm9tIHVzZXJzcGFjZSwgdGhlcmUg
YXJlCiAgICAgbXkgb3ZlcmxheSBicmFuY2hlcywgY2ZyLiBodHRwczovL2VsaW51eC5vcmcvUi1D
YXIvRFQtT3ZlcmxheXMKCkdye29ldGplLGVldGluZ31zLAoKICAgICAgICAgICAgICAgICAgICAg
ICAgR2VlcnQKCgotLQpHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4
IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsub3JnCgpJbiBwZXJzb25hbCBjb252ZXJz
YXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0
CndoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIg
b3Igc29tZXRoaW5nIGxpa2UgdGhhdC4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAt
LSBMaW51cyBUb3J2YWxkcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=

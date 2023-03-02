Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E331C6FA8E
	for <linux-um@archiver.kernel.org>; Thu,  2 Mar 2023 17:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MwwXZATN/xwKmSVKjkjMnEx7z/IYZPAisPS2tQ/GtO0=; b=24Qzc++1ZTlq5w
	dq8T7CHSLZRESraltDgoy/kQPoYo4IdQ1eA5D4sWQTUKJc/B+jvI5SNDrJnT/aRQRfXV9ii+mkmQf
	Txd8FXvAOgi4hIA8F0wEQVN858Cev8cQBmX/XtWwRhIJ+c24U5zIiVngnAX2SC3Q9rH5QzkQ3OC5Z
	gsPbCbfiyhj3EuzLEXIPyksr2CAe4DhOTIcXqESo2wb1CN+q5SPTR8LHqBNPUlV0jRQ0qvZ7KdKyp
	mEFLDIzIcRkbyEzXSVjV6oPZJ0gC0wxQOS0T3n4RWmWiiKdYRr7iaihUptS0/LxvJdKr10feabCvN
	K791rpoUQudDIGdPLMWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXmn5-002yf0-BU; Thu, 02 Mar 2023 17:32:27 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXmn1-002yeY-Ny
	for linux-um@lists.infradead.org; Thu, 02 Mar 2023 17:32:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id EFAEB61626
	for <linux-um@lists.infradead.org>; Thu,  2 Mar 2023 17:32:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCAEC433AA
	for <linux-um@lists.infradead.org>; Thu,  2 Mar 2023 17:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1677778341;
	bh=GTJ2aQ3riMffZdwM0TI7yU15Vojy5MM+NJ9vt/TT/F8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xl/Kb/AiIzIGvNjcW8Mpe7/u31VvlNm0hQniH3f0qe/1BtDnJJQP+MWebtnBbn/bd
	 gy5xMHBVpioacbJsLxW6YKNfizW0exBkhXw0IlBODB/uue1wzkeZ0zUmPAU1uzGvMb
	 CCV/jsE+X4GFcS8sBnC1CWEbnFBkKYaur1xgdLLVBvtNd49AGpRJdREIh3S2h0/t4r
	 pS+Bs1Og6RR3jISL3snLEVZ1j1YeOs+LVpaQKepeCFUXq0/iET29fJO/XpMrbQfqnq
	 szfunjHE5lTWgLRhV5GmqnaUJGg5ocRvxw3VeQLqcfqOfqa4V6pMCsw7l5dmZA8pHO
	 VIAhPAzzKHfAg==
Received: by mail-ua1-f45.google.com with SMTP id m5so6682673uae.11
        for <linux-um@lists.infradead.org>; Thu, 02 Mar 2023 09:32:21 -0800 (PST)
X-Gm-Message-State: AO0yUKVXh6JkrwuyrKtOsA2ju0KjQH+VzNSyW42qnDWj2+wRi9wh2xEB
	lLt6SrnVcU+qKgT6lVfsPRlNuIZ3gPaDaH5C2w==
X-Google-Smtp-Source: AK7set9cJNTLFs7vnxVEO6Bi3x0FdUJU0jGThLV7OqyoaC6mAU8o5RUYHWKZMVbAQOB16m3naYT+V+2VGB6kWOMhcf4=
X-Received: by 2002:a1f:a3d7:0:b0:40d:526d:5633 with SMTP id
 m206-20020a1fa3d7000000b0040d526d5633mr6082295vke.2.1677778340294; Thu, 02
 Mar 2023 09:32:20 -0800 (PST)
MIME-Version: 1.0
References: <20230302013822.1808711-1-sboyd@kernel.org> <CABVgOSnpMNCtEEsJV28OzUoxdDuiT4a2T0avP0AYf9xFW1jxrw@mail.gmail.com>
In-Reply-To: <CABVgOSnpMNCtEEsJV28OzUoxdDuiT4a2T0avP0AYf9xFW1jxrw@mail.gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 2 Mar 2023 11:32:09 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJMd3Fi0ZBObdyE1VDKTH1_+smuGDymHnKOkVH2HB3jJQ@mail.gmail.com>
Message-ID: <CAL_JsqJMd3Fi0ZBObdyE1VDKTH1_+smuGDymHnKOkVH2HB3jJQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] clk: Add kunit tests for fixed rate and parent data
To: David Gow <davidgow@google.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, 
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
X-CRM114-CacheID: sfid-20230302_093223_902030_952AE58E 
X-CRM114-Status: GOOD (  31.01  )
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

T24gVGh1LCBNYXIgMiwgMjAyMyBhdCAyOjE04oCvQU0gRGF2aWQgR293IDxkYXZpZGdvd0Bnb29n
bGUuY29tPiB3cm90ZToKPgo+IE9uIFRodSwgMiBNYXIgMjAyMyBhdCAwOTozOCwgU3RlcGhlbiBC
b3lkIDxzYm95ZEBrZXJuZWwub3JnPiB3cm90ZToKPiA+Cj4gPiBUaGlzIHBhdGNoIHNlcmllcyBh
ZGRzIHVuaXQgdGVzdHMgZm9yIHRoZSBjbGsgZml4ZWQgcmF0ZSBiYXNpYyB0eXBlIGFuZAo+ID4g
dGhlIGNsayByZWdpc3RyYXRpb24gZnVuY3Rpb25zIHRoYXQgdXNlIHN0cnVjdCBjbGtfcGFyZW50
X2RhdGEuIFRvIGdldAo+ID4gdGhlcmUsIHdlIGFkZCBzdXBwb3J0IGZvciBsb2FkaW5nIGEgRFRC
IGludG8gdGhlIFVNTCBrZXJuZWwgdGhhdCdzCj4gPiBydW5uaW5nIHRoZSB1bml0IHRlc3RzIGFs
b25nIHdpdGggcHJvYmluZyBwbGF0Zm9ybSBkcml2ZXJzIHRvIGJpbmQgdG8KPiA+IGRldmljZSBu
b2RlcyBzcGVjaWZpZWQgaW4gRFQuCj4gPgo+ID4gV2l0aCB0aGlzIHNlcmllcywgd2UncmUgYWJs
ZSB0byBleGVyY2lzZSBzb21lIG9mIHRoZSBjb2RlIGluIHRoZSBjb21tb24KPiA+IGNsayBmcmFt
ZXdvcmsgdGhhdCB1c2VzIGRldmljZXRyZWUgbG9va3VwcyB0byBmaW5kIHBhcmVudHMgYW5kIHRo
ZSBmaXhlZAo+ID4gcmF0ZSBjbGsgY29kZSB0aGF0IHNjYW5zIGRldmljZXRyZWUgZGlyZWN0bHkg
YW5kIGNyZWF0ZXMgY2xrcy4gUGxlYXNlCj4gPiByZXZpZXcuCj4gPgo+Cj4gVGhhbmtzIFN0ZXBo
ZW4gLS0gdGhpcyBpcyByZWFsbHkgbmVhdCEKPgo+IFRoaXMgd29ya3Mgd2VsbCBoZXJlLCBhbmQg
SSBsb3ZlIGFsbCBvZiB0aGUgdGVzdHMgZm9yIHRoZQo+IEtVbml0L2RldmljZS10cmVlIGludGVn
cmF0aW9uIGFzIHdlbGwuCj4KPiBJJ20gc3RpbGwgbG9va2luZyB0aHJvdWdoIHRoZSBkZXRhaWxz
IG9mIGl0IChhbGFzLCBJJ3ZlIG1vc3RseSBsaXZlZAo+IGluIHg4Ni1sYW5kLCBzbyBteSBkZXZp
Y2UtdHJlZSBrbm93bGVkZ2UgaXMsIHVoLCBzcG90dHkgdG8gc2F5IHRoZQo+IGxlYXN0KSwgYnV0
IGFwYXJ0IGZyb20gcG9zc2libHkgcmVuYW1pbmcgc29tZSB0aGluZ3Mgb3Igc2ltaWxhcmx5Cj4g
bWlub3IgdHdlYWtzLCBJJ3ZlIG5vdCBnb3QgYW55IHJlYWwgc3VnZ2VzdGlvbnMgdGh1cyBmYXIu
Cj4KPiBJIGRvIHdvbmRlciB3aGV0aGVyIHdlJ2xsIHdhbnQsIG9uIHRoZSBLVW5pdCBzaWRlLCB0
byBoYXZlIHNvbWUgd2F5IG9mCj4gc3VwcG9ydGluZyBLVW5pdCBkZXZpY2UgdHJlZXMgb24gbm9u
LVVNTCBhcmNoaXRlY2N0dXJlcyAoZS5nLiwgaWYgd2UKPiBuZWVkIHRvIHRlc3Qgc29tZXRoaW5n
IGFyY2hpdGVjdHVyZS1zcGVjaWZpYywgb3Igb24gYSBiaWctZW5kaWFuCj4gcGxhdGZvcm0sIGV0
YyksIGJ1dCBJIHRoaW5rIHRoYXQncyBhIHF1ZXN0aW9uIGZvciB0aGUgZnV0dXJlLCByYXRoZXIK
PiB0aGFuIHNvbWV0aGluZyB0aGF0IGFmZmVjdHMgdGhpcyBzZXJpZXMuCgpJJ2xsIHNheSB0aGF0
J3MgYSByZXF1aXJlbWVudC4gV2Ugc2hvdWxkIGJlIGFibGUgdG8gc3RydWN0dXJlIHRoZQp0ZXN0
cyB0byBub3QgaW50ZXJmZXJlIHdpdGggdGhlIHJ1bm5pbmcgc3lzdGVtJ3MgRFQuIFRoZSBEVCB1
bml0dGVzdApkb2VzIHRoYXQuCgpBcyBhIHNpZGUgdG9waWMsIElzIGFueW9uZSBsb29raW5nIGF0
IGdldHRpbmcgVU1MIHRvIHdvcmsgb24gYXJtNjQ/Ckl0J3Mgc3VycHJpc2luZyBob3cgbXVjaCB4
ODYgc3R1ZmYgdGhlcmUgaXMgd2hpY2ggaXMgSSBndWVzcyBvbmUKcmVhc29uIGl0IGhhc24ndCBo
YXBwZW5lZC4KCj4gU2ltaWxhcmx5LCBJIHdvbmRlciBpZiB0aGVyZSdzIHNvbWV0aGluZyB3ZSBj
b3VsZCBkbyB3aXRoIGRldmljZSB0cmVlCj4gb3ZlcmxheXMsIGluIG9yZGVyIHRvIG1ha2UgaXQg
cG9zc2libGUgZm9yIHRlc3RzIHRvIHN3YXAgbm9kZXMgaW4gYW5kCj4gb3V0IGZvciB0ZXN0aW5n
LgoKWWVzLCB0aGF0J3MgaG93IHRoZSBEVCB1bml0dGVzdCB3b3Jrcy4gQnV0IGl0IGlzIHByZXR0
eSBtdWNoIG9uZSBiaWcKb3ZlcmxheSAoaWdub3JpbmcgdGhlIG92ZXJsYXkgdGVzdHMpLiBJdCBj
b3VsZCBwcm9iYWJseSBiZSBtb3JlCm1vZHVsYXIgd2hlcmUgaXQgaXMgYXBwbHkgb3ZlcmxheSwg
dGVzdCwgcmVtb3ZlIG92ZXJsYXksIHJlcGVhdC4KClJvYgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVt
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC11bQo=

Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C55F9C6FA8E
	for <linux-um@archiver.kernel.org>; Sun,  5 Mar 2023 09:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mmCQo0VkWfNmxqtWO0e/VVXPmpOCyoGCH2fSTZb63vg=; b=B9Qvzs4WhcsIAK
	mePKlPxZqCRBd+T0djfvacOgAldeoUhySGtYlhhbrihc/O/H47GPWlrh7B8/TQT/0XWDBnFSV9jU1
	LvrOsYYGaxQBOTdP61kSFQ/KCrTTpLhO50ds/TXFQO7y1rIXCmGQJAs0BBJ9RdoXU2oWBTX7XJcCc
	U/Symv9uEK4jdGMb35CO4TM/K9j2fSk3Jr4JF2kBR3VP5hXFvtFUVrvgksd+M+9biOlhdM+Zicn4p
	9nafNOakAkipH8m7qQ65r/qB8D0sLY7YXNQQHUt7abPilQedfMwRJp/D4iZmm8mErwj653BCm4+7G
	86Ph5KmjkUFxdgdyvqyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pYkdw-00A1Dx-RZ; Sun, 05 Mar 2023 09:27:00 +0000
Received: from mail-qt1-f169.google.com ([209.85.160.169])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pYkdt-00A1DY-6d
	for linux-um@lists.infradead.org; Sun, 05 Mar 2023 09:26:59 +0000
Received: by mail-qt1-f169.google.com with SMTP id c3so7549103qtc.8
        for <linux-um@lists.infradead.org>; Sun, 05 Mar 2023 01:26:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678008415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqH/fUNw1v+IeKE/kiXgUEg5Js8jhAM4t/LI9qQb7pQ=;
        b=ssHJ6LV2SFsGcfFkpxM7dHr+IB4+I778Oqupi/RwUDenn2YBFCJadg7ifNoa41awB5
         P22rkUfCL6hijTTlw0JedpdWRpibeojy97eC/bydvsQL4zfUGJhvowX2QN4V7RoGJiCg
         HTKLKpJTnMHiIV4VAthgnksWYfIZfmD8UzoTdefs+lsViq2cJcLYrdGEdt/GAUJb22jO
         d4+l/ncc9S2AoZhPyYD8b4CRuNV8lWVvm93uwMIYuw5Ox7Sk8YGxqgfPm61OJZkrdnCc
         GEbowbuc5iaDqfUOTJsBuZ2OQLW4fK4U343zUU6wkrPI/q9Iz0OHoUQd3KPg13eO7vg4
         HuQg==
X-Gm-Message-State: AO0yUKWAlFzCJtIDWe9AutiisK4rLTA54cFbEWdwen1AmJYz+fOnSw/W
	6E6GUh/bGaa1xBHG/S+L/mn9gVw74fRqcw==
X-Google-Smtp-Source: AK7set/MNdS5Ikk+E/DlGcXJg0vmeulE0HLCqC6cLz1n6q7AgaaaiC1vwPwgxvfMr7RtRjaE4Dx1HQ==
X-Received: by 2002:ac8:57c4:0:b0:3bf:c7ac:37e4 with SMTP id w4-20020ac857c4000000b003bfc7ac37e4mr14280439qta.53.1678008414983;
        Sun, 05 Mar 2023 01:26:54 -0800 (PST)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id f13-20020ac87f0d000000b003b9b48cdbe8sm1755844qtk.58.2023.03.05.01.26.53
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 01:26:54 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id x199so5451511ybg.5
        for <linux-um@lists.infradead.org>; Sun, 05 Mar 2023 01:26:53 -0800 (PST)
X-Received: by 2002:a5b:c42:0:b0:a43:52fe:c36f with SMTP id
 d2-20020a5b0c42000000b00a4352fec36fmr3381016ybr.7.1678008413630; Sun, 05 Mar
 2023 01:26:53 -0800 (PST)
MIME-Version: 1.0
References: <20230302013822.1808711-1-sboyd@kernel.org> <CABVgOSnpMNCtEEsJV28OzUoxdDuiT4a2T0avP0AYf9xFW1jxrw@mail.gmail.com>
 <CAL_JsqJMd3Fi0ZBObdyE1VDKTH1_+smuGDymHnKOkVH2HB3jJQ@mail.gmail.com>
 <3759b28cca7ab751296d4dd83f2dcc51.sboyd@kernel.org> <CAMuHMdXDx6ChRj4xvWbQgcdJd0CGFi-RXySXr=M8QhBkA7YiGw@mail.gmail.com>
 <a2fdbd70-ca44-0d13-5b6f-4177761ecc18@gmail.com>
In-Reply-To: <a2fdbd70-ca44-0d13-5b6f-4177761ecc18@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 5 Mar 2023 10:26:41 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUMrG9yuXDhDRd+mAUGo5_A6ONjAXXZkJTPXQsO_0C41A@mail.gmail.com>
Message-ID: <CAMuHMdUMrG9yuXDhDRd+mAUGo5_A6ONjAXXZkJTPXQsO_0C41A@mail.gmail.com>
Subject: Re: [PATCH 0/8] clk: Add kunit tests for fixed rate and parent data
To: Frank Rowand <frowand.list@gmail.com>
Cc: Stephen Boyd <sboyd@kernel.org>, David Gow <davidgow@google.com>, 
	Rob Herring <robh+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	patches@lists.linux.dev, Brendan Higgins <brendan.higgins@linux.dev>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, Christian Marangi <ansuelsmth@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, devicetree@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230305_012657_270778_A38B3431 
X-CRM114-Status: GOOD (  59.50  )
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

SGkgRnJhbmssCgpPbiBTdW4sIE1hciA1LCAyMDIzIGF0IDQ6MzPigK9BTSBGcmFuayBSb3dhbmQg
PGZyb3dhbmQubGlzdEBnbWFpbC5jb20+IHdyb3RlOgo+IE9uIDMvMi8yMyAxMzo0NywgR2VlcnQg
VXl0dGVyaG9ldmVuIHdyb3RlOgo+ID4gT24gVGh1LCBNYXIgMiwgMjAyMyBhdCA4OjI44oCvUE0g
U3RlcGhlbiBCb3lkIDxzYm95ZEBrZXJuZWwub3JnPiB3cm90ZToKPiA+PiBRdW90aW5nIFJvYiBI
ZXJyaW5nICgyMDIzLTAzLTAyIDA5OjMyOjA5KQo+ID4+PiBPbiBUaHUsIE1hciAyLCAyMDIzIGF0
IDI6MTTigK9BTSBEYXZpZCBHb3cgPGRhdmlkZ293QGdvb2dsZS5jb20+IHdyb3RlOgo+ID4+Pj4g
T24gVGh1LCAyIE1hciAyMDIzIGF0IDA5OjM4LCBTdGVwaGVuIEJveWQgPHNib3lkQGtlcm5lbC5v
cmc+IHdyb3RlOgo+ID4+Pj4+IFRoaXMgcGF0Y2ggc2VyaWVzIGFkZHMgdW5pdCB0ZXN0cyBmb3Ig
dGhlIGNsayBmaXhlZCByYXRlIGJhc2ljIHR5cGUgYW5kCj4gPj4+Pj4gdGhlIGNsayByZWdpc3Ry
YXRpb24gZnVuY3Rpb25zIHRoYXQgdXNlIHN0cnVjdCBjbGtfcGFyZW50X2RhdGEuIFRvIGdldAo+
ID4+Pj4+IHRoZXJlLCB3ZSBhZGQgc3VwcG9ydCBmb3IgbG9hZGluZyBhIERUQiBpbnRvIHRoZSBV
TUwga2VybmVsIHRoYXQncwo+ID4+Pj4+IHJ1bm5pbmcgdGhlIHVuaXQgdGVzdHMgYWxvbmcgd2l0
aCBwcm9iaW5nIHBsYXRmb3JtIGRyaXZlcnMgdG8gYmluZCB0bwo+ID4+Pj4+IGRldmljZSBub2Rl
cyBzcGVjaWZpZWQgaW4gRFQuCj4gPj4+Pj4KPiA+Pj4+PiBXaXRoIHRoaXMgc2VyaWVzLCB3ZSdy
ZSBhYmxlIHRvIGV4ZXJjaXNlIHNvbWUgb2YgdGhlIGNvZGUgaW4gdGhlIGNvbW1vbgo+ID4+Pj4+
IGNsayBmcmFtZXdvcmsgdGhhdCB1c2VzIGRldmljZXRyZWUgbG9va3VwcyB0byBmaW5kIHBhcmVu
dHMgYW5kIHRoZSBmaXhlZAo+ID4+Pj4+IHJhdGUgY2xrIGNvZGUgdGhhdCBzY2FucyBkZXZpY2V0
cmVlIGRpcmVjdGx5IGFuZCBjcmVhdGVzIGNsa3MuIFBsZWFzZQo+ID4+Pj4+IHJldmlldy4KPiA+
Pj4+Pgo+ID4+Pj4KPiA+Pj4+IFRoYW5rcyBTdGVwaGVuIC0tIHRoaXMgaXMgcmVhbGx5IG5lYXQh
Cj4gPj4+Pgo+ID4+Pj4gVGhpcyB3b3JrcyB3ZWxsIGhlcmUsIGFuZCBJIGxvdmUgYWxsIG9mIHRo
ZSB0ZXN0cyBmb3IgdGhlCj4gPj4+PiBLVW5pdC9kZXZpY2UtdHJlZSBpbnRlZ3JhdGlvbiBhcyB3
ZWxsLgo+ID4+Pj4KPiA+Pj4+IEknbSBzdGlsbCBsb29raW5nIHRocm91Z2ggdGhlIGRldGFpbHMg
b2YgaXQgKGFsYXMsIEkndmUgbW9zdGx5IGxpdmVkCj4gPj4+PiBpbiB4ODYtbGFuZCwgc28gbXkg
ZGV2aWNlLXRyZWUga25vd2xlZGdlIGlzLCB1aCwgc3BvdHR5IHRvIHNheSB0aGUKPiA+Pj4+IGxl
YXN0KSwgYnV0IGFwYXJ0IGZyb20gcG9zc2libHkgcmVuYW1pbmcgc29tZSB0aGluZ3Mgb3Igc2lt
aWxhcmx5Cj4gPj4+PiBtaW5vciB0d2Vha3MsIEkndmUgbm90IGdvdCBhbnkgcmVhbCBzdWdnZXN0
aW9ucyB0aHVzIGZhci4KPiA+Pj4+Cj4gPj4+PiBJIGRvIHdvbmRlciB3aGV0aGVyIHdlJ2xsIHdh
bnQsIG9uIHRoZSBLVW5pdCBzaWRlLCB0byBoYXZlIHNvbWUgd2F5IG9mCj4gPj4+PiBzdXBwb3J0
aW5nIEtVbml0IGRldmljZSB0cmVlcyBvbiBub24tVU1MIGFyY2hpdGVjY3R1cmVzIChlLmcuLCBp
ZiB3ZQo+ID4+Pj4gbmVlZCB0byB0ZXN0IHNvbWV0aGluZyBhcmNoaXRlY3R1cmUtc3BlY2lmaWMs
IG9yIG9uIGEgYmlnLWVuZGlhbgo+ID4+Pj4gcGxhdGZvcm0sIGV0YyksIGJ1dCBJIHRoaW5rIHRo
YXQncyBhIHF1ZXN0aW9uIGZvciB0aGUgZnV0dXJlLCByYXRoZXIKPiA+Pj4+IHRoYW4gc29tZXRo
aW5nIHRoYXQgYWZmZWN0cyB0aGlzIHNlcmllcy4KPiA+Pj4KPiA+Pj4gSSdsbCBzYXkgdGhhdCdz
IGEgcmVxdWlyZW1lbnQuIFdlIHNob3VsZCBiZSBhYmxlIHRvIHN0cnVjdHVyZSB0aGUKPiA+Pj4g
dGVzdHMgdG8gbm90IGludGVyZmVyZSB3aXRoIHRoZSBydW5uaW5nIHN5c3RlbSdzIERULiBUaGUg
RFQgdW5pdHRlc3QKPiA+Pj4gZG9lcyB0aGF0Lgo+ID4+Cj4gPj4gVGhhdCBjb3VsZCBiZSBhbm90
aGVyIGNob2ljZSBpbiB0aGUgdW5pdCB0ZXN0IGNob2ljZSBtZW51Lgo+ID4+IENPTkZJR19PRl9L
VU5JVF9OT1RfVU1MIHRoYXQgaW5qZWN0cyBzb21lIGJ1aWx0LWluIERUQiBvdmVybGF5IG9uIGFu
Cj4gPj4gYXJjaGl0ZWN0dXJlIHRoYXQgd2FudHMgdG8gcnVuIHRlc3RzLgo+ID4KPiA+IEFzIGxv
bmcgYXMgeW91IHVzZSBjb21wYXRpYmxlIHZhbHVlcyB0aGF0IGRvbid0IGV4aXN0IGVsc2V3aGVy
ZSwKPiA+IGFuZCBkb24ndCBvdmVyd3JpdGUgYW55dGhpbmcsIHlvdSBjYW4gbG9hZCB5b3VyIGt1
bml0IHRlc3Qgb3ZlcmxheXMKPiA+IG9uIGFueSBydW5uaW5nIHN5c3RlbSB0aGF0IGhhcyBEVCBz
dXBwb3J0Lgo+ID4KPiA+Pj4gQXMgYSBzaWRlIHRvcGljLCBJcyBhbnlvbmUgbG9va2luZyBhdCBn
ZXR0aW5nIFVNTCB0byB3b3JrIG9uIGFybTY0Pwo+ID4+PiBJdCdzIHN1cnByaXNpbmcgaG93IG11
Y2ggeDg2IHN0dWZmIHRoZXJlIGlzIHdoaWNoIGlzIEkgZ3Vlc3Mgb25lCj4gPj4+IHJlYXNvbiBp
dCBoYXNuJ3QgaGFwcGVuZWQuCj4gPj4KPiA+PiBJJ3ZlIG5vIGlkZWEgYnV0IGl0IHdvdWxkIGJl
IG5pY2UgaW5kZWVkLgo+ID4KPiA+IEkgYmVsaWV2ZSB0aGF0J3Mgbm9uLXRyaXZpYWwuIEF0IGxl
YXN0IGZvciBhcm0zMiAoSSBkaWRuJ3QgaGF2ZSBhbnkgYXJtNjQKPiA+IHN5c3RlbXMgbGFzdCB0
aW1lIEkgYXNrZWQgdGhlIGV4cGVydHMpLgo+ID4KPiA+Pj4+IFNpbWlsYXJseSwgSSB3b25kZXIg
aWYgdGhlcmUncyBzb21ldGhpbmcgd2UgY291bGQgZG8gd2l0aCBkZXZpY2UgdHJlZQo+ID4+Pj4g
b3ZlcmxheXMsIGluIG9yZGVyIHRvIG1ha2UgaXQgcG9zc2libGUgZm9yIHRlc3RzIHRvIHN3YXAg
bm9kZXMgaW4gYW5kCj4gPj4+PiBvdXQgZm9yIHRlc3RpbmcuCj4gPj4+Cj4gPj4+IFllcywgdGhh
dCdzIGhvdyB0aGUgRFQgdW5pdHRlc3Qgd29ya3MuIEJ1dCBpdCBpcyBwcmV0dHkgbXVjaCBvbmUg
YmlnCj4gPj4+IG92ZXJsYXkgKGlnbm9yaW5nIHRoZSBvdmVybGF5IHRlc3RzKS4gSXQgY291bGQg
cHJvYmFibHkgYmUgbW9yZQo+ID4+PiBtb2R1bGFyIHdoZXJlIGl0IGlzIGFwcGx5IG92ZXJsYXks
IHRlc3QsIHJlbW92ZSBvdmVybGF5LCByZXBlYXQuCj4gPj4KPiA+PiBJIGRpZG4ndCB3YW50IHRv
IHJlbHkgb24gdGhlIG92ZXJsYXkgY29kZSB0byBpbmplY3QgRFQgbm9kZXMuIEhhdmluZwo+ID4+
IHRlc3RzIHdyaXR0ZW4gZm9yIHRoZSBmYWtlIEtVbml0IG1hY2hpbmUgaXMgc2ltcGxlLiBJdCBj
bG9zZWx5IG1hdGNoZXMKPiA+PiBob3cgY2xrIGNvZGUgcHJvYmVzIHRoZSBEVEIgYW5kIGhvdyBu
b2RlcyBhcmUgY3JlYXRlZCBhbmQgcG9wdWxhdGVkIG9uCj4gPj4gdGhlIHBsYXRmb3JtIGJ1cyBh
cyBkZXZpY2VzLiBDTEtfT0ZfREVDTEFSRSgpIHdvdWxkIG5lZWQgdGhlIG92ZXJsYXkgdG8KPiA+
PiBiZSBhcHBsaWVkIGVhcmx5IHRvbywgd2hpY2ggZG9lc24ndCBoYXBwZW4gb3RoZXJ3aXNlIGFz
IGZhciBhcyBJIGtub3cuCj4gPgo+ID4gRG9uJ3QgYWxsIGdlbmVyaWMgY2xvY2sgZHJpdmVycyBh
bHNvIGNyZWF0ZSBhIHBsYXRmb3JtIGRyaXZlcj8KPiA+IEF0IGxlYXN0IGRyaXZlcnMvY2xrL2Ns
ay1maXhlZC1mYWN0b3IuYyBkb2VzLgo+ID4KPiA+PiBCdXQgcGVyaGFwcyB0aGlzIGRlc2lnbiBp
cyB0b28gbXVjaCBvZiBhbiBlbmQtdG8tZW5kIHRlc3QgYW5kIG5vdCBhIHVuaXQKPiA+PiB0ZXN0
PyBJbiB0aGUgc3Bpcml0IG9mIHVuaXQgdGVzdGluZyB3ZSBzaG91bGRuJ3QgY2FyZSBhYm91dCBo
b3cgdGhlIG5vZGUKPiA+PiBpcyBhZGRlZCB0byB0aGUgbGl2ZSBkZXZpY2V0cmVlLCBqdXN0IHRo
YXQgdGhlcmUgaXMgYSBkZXZpY2V0cmVlIGF0IGFsbC4KPiA+Pgo+ID4+IFN1cHBvcnRpbmcgb3Zl
cmxheXMgdG8gbW9yZSBlYXNpbHkgdGVzdCBjb21iaW5hdGlvbnMgc291bmRzIGxpa2UgYSBnb29k
Cj4gPj4gaWRlYS4gUHJvYmFibHkgc29tZSBrdW5pdF8qKCkgcHJlZml4ZWQgZnVuY3Rpb25zIGNv
dWxkIGJlIHVzZWQgdG8KPiA+PiBhcHBseSBhIHRlc3QgbWFuYWdlZCBvdmVybGF5IGFuZCBhdXRv
bWF0aWNhbGx5IHJlbW92ZSBpdCB3aGVuIHRoZSB0ZXN0Cj4gPj4gaXMgb3ZlciB3b3VsZCB3b3Jr
LiBUaGUgY2xrIHJlZ2lzdHJhdGlvbiB0ZXN0cyBjb3VsZCB1c2UgdGhpcyBBUEkgdG8KPiA+PiBp
bmplY3QgYW4gb3ZlcmxheSBhbmQgdGhlbiBtYW51YWxseSBjYWxsIHRoZSBvZl9wbGF0Zm9ybV9w
b3B1bGF0ZSgpCj4gPj4gZnVuY3Rpb24gdG8gY3JlYXRlIHRoZSBwbGF0Zm9ybSBkZXZpY2Uocyku
IFRoZSBvdmVybGF5IGNvdWxkIGJlIGJ1aWx0IGluCj4gPj4gZHJpdmVycy9jbGsvIHRvbyBhbmQg
dGhlbiBwcm9iYWJseSBzb21lIG1hY3JvaXNoIGZ1bmN0aW9uIGNhbiBmaW5kIHRoZQo+ID4+IGJs
b2IgYW5kIGFwcGx5IGl0Lgo+ID4KPiA+IE5vIG5lZWQgdG8gbWFudWFsbHkgY2FsbCBvZl9wbGF0
Zm9ybV9wb3B1bGF0ZSgpIHRvIGNyZWF0ZSB0aGUKPiA+IHBsYXRmb3JtIGRldmljZXMuIFRoYXQg
aXMgdGFrZW4gY2FyZSBvZiBhdXRvbWF0aWNhbGx5IHdoZW4gYXBwbHlpbmcKPiA+IGFuIG92ZXJs
YXkuCj4gPgo+ID4+IElzIHRoZXJlIHNvbWUgd2F5IHRvIGRlbGV0ZSB0aGUgcGxhdGZvcm0gZGV2
aWNlcyB0aGF0IHdlIHBvcHVsYXRlIGZyb20KPiA+PiB0aGUgb3ZlcmxheT8gSSdkIGxpa2UgdGhl
IHRlc3RzIHRvIGJlIGhlcm1ldGljLgo+Cj4gPiBSZW1vdmluZyB0aGUgb3ZlcmxheSB3aWxsIGRl
bGV0ZSB0aGUgcGxhdGZvcm0gZGV2aWNlcy4KPgo+IEkgX3RoaW5rXyB0aGF0IGlzIGluY29ycmVj
dC4gIERvIHlvdSBoYXZlIGEgcG9pbnRlciB0byB0aGUgb3ZlcmxheSBjb2RlIHRoYXQKPiBkZWxl
dGVzIHRoZSBkZXZpY2U/ICAoSWYgSSByZW1lbWJlciBjb3JyZWN0bHksIHRoZSBvdmVybGF5IHJl
bW92ZSBjb2RlIGRvZXMgbm90Cj4gZXZlbiBjaGVjayB3aGV0aGVyIHRoZSBkZXZpY2UgZXhpc3Rz
IGFuZCB3aGV0aGVyIGEgZHJpdmVyIGlzIGJvdW5kIHRvIGl0IC0tIGJ1dAo+IHRoaXMgaXMgb24g
bXkgdG9kbyBsaXN0IHRvIGxvb2sgaW50by4pCgpodHRwczovL2VsaXhpci5ib290bGluLmNvbS9s
aW51eC9sYXRlc3Qvc291cmNlL2RyaXZlcnMvb2YvcGxhdGZvcm0uYyNMNzY5Cgo+ID4gQWxsIG9m
IHRoYXQgd29ya3MgaWYgeW91IGhhdmUgeW91ciBvd24gY29kZSB0byBhcHBseSBhIERUIG92ZXJs
YXkuCj4gPiBUaGUgcmVjZW50IGZ3X2RldmxpbmtzIHBhdGNoZXMgZGlkIGNhdXNlIHNvbWUgcmVn
cmVzc2lvbnMsIGNmci4KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9DQU11SE1kWEVu
U0Q0clJKLW85MHg0T3ByVWFjTl9ySmd5bzh4Nj05RjlyWistS3pqT2dAbWFpbC5nbWFpbC5jb20K
Ckdye29ldGplLGVldGluZ31zLAoKICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQKCi0tIApH
ZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0t
IGdlZXJ0QGxpbnV4LW02OGsub3JnCgpJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVj
aG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0CndoZW4gSSdtIHRhbGtp
bmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxp
a2UgdGhhdC4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxk
cwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
dW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=

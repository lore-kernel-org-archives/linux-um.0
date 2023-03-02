Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45584C6FA8E
	for <linux-um@archiver.kernel.org>; Thu,  2 Mar 2023 19:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:Cc:From:Subject:References:
	In-Reply-To:MIME-Version:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jM9DClUyQxB45/i8WMBucGKvaHcxsjVGHYM1lXpdfKg=; b=JHpRjjRA3/3Vpe
	BtMdPR6WNtfiG+Eokxrr3f7Ap8l77OiSjnCQ9KNZEHgCS8Hfe8m8dDhqeVnXpOBDRs+v8eiUQsC/j
	jKhSqLhsl/51vE9jfUxCrnznok5lqSWJQZqqByRDYQpTnwXpyVSUn5zhRxH8HZgoukBakweL7fvY8
	3mbyzxTJHZMQ1yWFZlxyJUF9xXr9IzevCsJZvvYmb6fl01fMxa55p80Bq48cRRiIVLIRo0k+AwJsL
	noCeACZPKusOwVz9OlWS2Owbegi8zZhRbhfJ2+8noqx2XDOIwjRzktLvg9IAx73oKPRvuJDlyELvE
	kYqXh7ibIMjD3ncPw3BA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXoas-003A8B-Fu; Thu, 02 Mar 2023 19:27:58 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXoap-003A7d-Ci
	for linux-um@lists.infradead.org; Thu, 02 Mar 2023 19:27:57 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 94238B81366;
	Thu,  2 Mar 2023 19:27:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50ADDC433EF;
	Thu,  2 Mar 2023 19:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1677785270;
	bh=iyC6HQCgrOqOU/tJPSjqESyv0i0TAnEqDuPtF5qLScE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=W9TNNc2hTd4FfQi8Ddf7VRg4q9X17FRXQ1898GO5FUvD2bd28NR27DJ1myYkTzBKN
	 9V2tyGYTRzxeOlswmx6LWYMbwER3XYJAAYj49fmRlpfgCD7WlZskD7Y9vu/U31T1zy
	 CnM8J8sfsNRH62Bap5KDqBKrwWy2jDa2Rh2C7gIOuD0aS1bSrvWVb+I74A2GFt81UY
	 yL4Ivqvg+NfgKDHjTLbWTZninZRMAi1VbMf/fzfScjB28WwnCgCnmm+8eDKcqAxz+4
	 w+CvbQaPcO6SCy+Ro7KByP5uVlCJtznjqBlSrs9Nb7ZMNxSFGWyzOYLaZbCts7Llba
	 h0u9TcCnz8zkw==
Message-ID: <3759b28cca7ab751296d4dd83f2dcc51.sboyd@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJMd3Fi0ZBObdyE1VDKTH1_+smuGDymHnKOkVH2HB3jJQ@mail.gmail.com>
References: <20230302013822.1808711-1-sboyd@kernel.org> <CABVgOSnpMNCtEEsJV28OzUoxdDuiT4a2T0avP0AYf9xFW1jxrw@mail.gmail.com> <CAL_JsqJMd3Fi0ZBObdyE1VDKTH1_+smuGDymHnKOkVH2HB3jJQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] clk: Add kunit tests for fixed rate and parent data
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, Brendan Higgins <brendan.higgins@linux.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Vincent Whitchurch <vincent.whitchurch@axis.com>, Frank Rowand <frowand.list@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, devicetree@vger.kernel.org, linux-um@lists.infradead.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
To: David Gow <davidgow@google.com>, Rob Herring <robh+dt@kernel.org>
Date: Thu, 02 Mar 2023 11:27:47 -0800
User-Agent: alot/0.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230302_112755_766149_D4E517CE 
X-CRM114-Status: GOOD (  43.69  )
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

UXVvdGluZyBSb2IgSGVycmluZyAoMjAyMy0wMy0wMiAwOTozMjowOSkKPiBPbiBUaHUsIE1hciAy
LCAyMDIzIGF0IDI6MTTigK9BTSBEYXZpZCBHb3cgPGRhdmlkZ293QGdvb2dsZS5jb20+IHdyb3Rl
Ogo+ID4KPiA+IE9uIFRodSwgMiBNYXIgMjAyMyBhdCAwOTozOCwgU3RlcGhlbiBCb3lkIDxzYm95
ZEBrZXJuZWwub3JnPiB3cm90ZToKPiA+ID4KPiA+ID4gVGhpcyBwYXRjaCBzZXJpZXMgYWRkcyB1
bml0IHRlc3RzIGZvciB0aGUgY2xrIGZpeGVkIHJhdGUgYmFzaWMgdHlwZSBhbmQKPiA+ID4gdGhl
IGNsayByZWdpc3RyYXRpb24gZnVuY3Rpb25zIHRoYXQgdXNlIHN0cnVjdCBjbGtfcGFyZW50X2Rh
dGEuIFRvIGdldAo+ID4gPiB0aGVyZSwgd2UgYWRkIHN1cHBvcnQgZm9yIGxvYWRpbmcgYSBEVEIg
aW50byB0aGUgVU1MIGtlcm5lbCB0aGF0J3MKPiA+ID4gcnVubmluZyB0aGUgdW5pdCB0ZXN0cyBh
bG9uZyB3aXRoIHByb2JpbmcgcGxhdGZvcm0gZHJpdmVycyB0byBiaW5kIHRvCj4gPiA+IGRldmlj
ZSBub2RlcyBzcGVjaWZpZWQgaW4gRFQuCj4gPiA+Cj4gPiA+IFdpdGggdGhpcyBzZXJpZXMsIHdl
J3JlIGFibGUgdG8gZXhlcmNpc2Ugc29tZSBvZiB0aGUgY29kZSBpbiB0aGUgY29tbW9uCj4gPiA+
IGNsayBmcmFtZXdvcmsgdGhhdCB1c2VzIGRldmljZXRyZWUgbG9va3VwcyB0byBmaW5kIHBhcmVu
dHMgYW5kIHRoZSBmaXhlZAo+ID4gPiByYXRlIGNsayBjb2RlIHRoYXQgc2NhbnMgZGV2aWNldHJl
ZSBkaXJlY3RseSBhbmQgY3JlYXRlcyBjbGtzLiBQbGVhc2UKPiA+ID4gcmV2aWV3Lgo+ID4gPgo+
ID4KPiA+IFRoYW5rcyBTdGVwaGVuIC0tIHRoaXMgaXMgcmVhbGx5IG5lYXQhCj4gPgo+ID4gVGhp
cyB3b3JrcyB3ZWxsIGhlcmUsIGFuZCBJIGxvdmUgYWxsIG9mIHRoZSB0ZXN0cyBmb3IgdGhlCj4g
PiBLVW5pdC9kZXZpY2UtdHJlZSBpbnRlZ3JhdGlvbiBhcyB3ZWxsLgo+ID4KPiA+IEknbSBzdGls
bCBsb29raW5nIHRocm91Z2ggdGhlIGRldGFpbHMgb2YgaXQgKGFsYXMsIEkndmUgbW9zdGx5IGxp
dmVkCj4gPiBpbiB4ODYtbGFuZCwgc28gbXkgZGV2aWNlLXRyZWUga25vd2xlZGdlIGlzLCB1aCwg
c3BvdHR5IHRvIHNheSB0aGUKPiA+IGxlYXN0KSwgYnV0IGFwYXJ0IGZyb20gcG9zc2libHkgcmVu
YW1pbmcgc29tZSB0aGluZ3Mgb3Igc2ltaWxhcmx5Cj4gPiBtaW5vciB0d2Vha3MsIEkndmUgbm90
IGdvdCBhbnkgcmVhbCBzdWdnZXN0aW9ucyB0aHVzIGZhci4KPiA+Cj4gPiBJIGRvIHdvbmRlciB3
aGV0aGVyIHdlJ2xsIHdhbnQsIG9uIHRoZSBLVW5pdCBzaWRlLCB0byBoYXZlIHNvbWUgd2F5IG9m
Cj4gPiBzdXBwb3J0aW5nIEtVbml0IGRldmljZSB0cmVlcyBvbiBub24tVU1MIGFyY2hpdGVjY3R1
cmVzIChlLmcuLCBpZiB3ZQo+ID4gbmVlZCB0byB0ZXN0IHNvbWV0aGluZyBhcmNoaXRlY3R1cmUt
c3BlY2lmaWMsIG9yIG9uIGEgYmlnLWVuZGlhbgo+ID4gcGxhdGZvcm0sIGV0YyksIGJ1dCBJIHRo
aW5rIHRoYXQncyBhIHF1ZXN0aW9uIGZvciB0aGUgZnV0dXJlLCByYXRoZXIKPiA+IHRoYW4gc29t
ZXRoaW5nIHRoYXQgYWZmZWN0cyB0aGlzIHNlcmllcy4KPiAKPiBJJ2xsIHNheSB0aGF0J3MgYSBy
ZXF1aXJlbWVudC4gV2Ugc2hvdWxkIGJlIGFibGUgdG8gc3RydWN0dXJlIHRoZQo+IHRlc3RzIHRv
IG5vdCBpbnRlcmZlcmUgd2l0aCB0aGUgcnVubmluZyBzeXN0ZW0ncyBEVC4gVGhlIERUIHVuaXR0
ZXN0Cj4gZG9lcyB0aGF0LgoKVGhhdCBjb3VsZCBiZSBhbm90aGVyIGNob2ljZSBpbiB0aGUgdW5p
dCB0ZXN0IGNob2ljZSBtZW51LgpDT05GSUdfT0ZfS1VOSVRfTk9UX1VNTCB0aGF0IGluamVjdHMg
c29tZSBidWlsdC1pbiBEVEIgb3ZlcmxheSBvbiBhbgphcmNoaXRlY3R1cmUgdGhhdCB3YW50cyB0
byBydW4gdGVzdHMuCgo+IAo+IEFzIGEgc2lkZSB0b3BpYywgSXMgYW55b25lIGxvb2tpbmcgYXQg
Z2V0dGluZyBVTUwgdG8gd29yayBvbiBhcm02ND8KPiBJdCdzIHN1cnByaXNpbmcgaG93IG11Y2gg
eDg2IHN0dWZmIHRoZXJlIGlzIHdoaWNoIGlzIEkgZ3Vlc3Mgb25lCj4gcmVhc29uIGl0IGhhc24n
dCBoYXBwZW5lZC4KCkkndmUgbm8gaWRlYSBidXQgaXQgd291bGQgYmUgbmljZSBpbmRlZWQuCgo+
IAo+ID4gU2ltaWxhcmx5LCBJIHdvbmRlciBpZiB0aGVyZSdzIHNvbWV0aGluZyB3ZSBjb3VsZCBk
byB3aXRoIGRldmljZSB0cmVlCj4gPiBvdmVybGF5cywgaW4gb3JkZXIgdG8gbWFrZSBpdCBwb3Nz
aWJsZSBmb3IgdGVzdHMgdG8gc3dhcCBub2RlcyBpbiBhbmQKPiA+IG91dCBmb3IgdGVzdGluZy4K
PiAKPiBZZXMsIHRoYXQncyBob3cgdGhlIERUIHVuaXR0ZXN0IHdvcmtzLiBCdXQgaXQgaXMgcHJl
dHR5IG11Y2ggb25lIGJpZwo+IG92ZXJsYXkgKGlnbm9yaW5nIHRoZSBvdmVybGF5IHRlc3RzKS4g
SXQgY291bGQgcHJvYmFibHkgYmUgbW9yZQo+IG1vZHVsYXIgd2hlcmUgaXQgaXMgYXBwbHkgb3Zl
cmxheSwgdGVzdCwgcmVtb3ZlIG92ZXJsYXksIHJlcGVhdC4KPiAKCkkgZGlkbid0IHdhbnQgdG8g
cmVseSBvbiB0aGUgb3ZlcmxheSBjb2RlIHRvIGluamVjdCBEVCBub2Rlcy4gSGF2aW5nCnRlc3Rz
IHdyaXR0ZW4gZm9yIHRoZSBmYWtlIEtVbml0IG1hY2hpbmUgaXMgc2ltcGxlLiBJdCBjbG9zZWx5
IG1hdGNoZXMKaG93IGNsayBjb2RlIHByb2JlcyB0aGUgRFRCIGFuZCBob3cgbm9kZXMgYXJlIGNy
ZWF0ZWQgYW5kIHBvcHVsYXRlZCBvbgp0aGUgcGxhdGZvcm0gYnVzIGFzIGRldmljZXMuIENMS19P
Rl9ERUNMQVJFKCkgd291bGQgbmVlZCB0aGUgb3ZlcmxheSB0bwpiZSBhcHBsaWVkIGVhcmx5IHRv
bywgd2hpY2ggZG9lc24ndCBoYXBwZW4gb3RoZXJ3aXNlIGFzIGZhciBhcyBJIGtub3cuCgpCdXQg
cGVyaGFwcyB0aGlzIGRlc2lnbiBpcyB0b28gbXVjaCBvZiBhbiBlbmQtdG8tZW5kIHRlc3QgYW5k
IG5vdCBhIHVuaXQKdGVzdD8gSW4gdGhlIHNwaXJpdCBvZiB1bml0IHRlc3Rpbmcgd2Ugc2hvdWxk
bid0IGNhcmUgYWJvdXQgaG93IHRoZSBub2RlCmlzIGFkZGVkIHRvIHRoZSBsaXZlIGRldmljZXRy
ZWUsIGp1c3QgdGhhdCB0aGVyZSBpcyBhIGRldmljZXRyZWUgYXQgYWxsLgoKU3VwcG9ydGluZyBv
dmVybGF5cyB0byBtb3JlIGVhc2lseSB0ZXN0IGNvbWJpbmF0aW9ucyBzb3VuZHMgbGlrZSBhIGdv
b2QKaWRlYS4gUHJvYmFibHkgc29tZSBrdW5pdF8qKCkgcHJlZml4ZWQgZnVuY3Rpb25zIGNvdWxk
IGJlIHVzZWQgdG8KYXBwbHkgYSB0ZXN0IG1hbmFnZWQgb3ZlcmxheSBhbmQgYXV0b21hdGljYWxs
eSByZW1vdmUgaXQgd2hlbiB0aGUgdGVzdAppcyBvdmVyIHdvdWxkIHdvcmsuIFRoZSBjbGsgcmVn
aXN0cmF0aW9uIHRlc3RzIGNvdWxkIHVzZSB0aGlzIEFQSSB0bwppbmplY3QgYW4gb3ZlcmxheSBh
bmQgdGhlbiBtYW51YWxseSBjYWxsIHRoZSBvZl9wbGF0Zm9ybV9wb3B1bGF0ZSgpCmZ1bmN0aW9u
IHRvIGNyZWF0ZSB0aGUgcGxhdGZvcm0gZGV2aWNlKHMpLiBUaGUgb3ZlcmxheSBjb3VsZCBiZSBi
dWlsdCBpbgpkcml2ZXJzL2Nsay8gdG9vIGFuZCB0aGVuIHByb2JhYmx5IHNvbWUgbWFjcm9pc2gg
ZnVuY3Rpb24gY2FuIGZpbmQgdGhlCmJsb2IgYW5kIGFwcGx5IGl0LgoKSXMgdGhlcmUgc29tZSB3
YXkgdG8gZGVsZXRlIHRoZSBwbGF0Zm9ybSBkZXZpY2VzIHRoYXQgd2UgcG9wdWxhdGUgZnJvbQp0
aGUgb3ZlcmxheT8gSSdkIGxpa2UgdGhlIHRlc3RzIHRvIGJlIGhlcm1ldGljLgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBs
aXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=

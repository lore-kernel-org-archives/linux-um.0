Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C259DC6FA8E
	for <linux-um@archiver.kernel.org>; Thu,  2 Mar 2023 23:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:Cc:From:Subject:References:
	In-Reply-To:MIME-Version:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yrDK60MChfEKAJQpS1AoBxW/g780LfpQzqFJZFbQb2o=; b=jBAths0obMsBYh
	9wOcTEXOYBv3TGJToLyDFNpChMQIdWg39Vw4scMcsVdIjTs3uZChpBwfZ1YpzNf5E36HvQBLPaEBa
	/CIQBki5lMs5hi6wdEC8nQCD9/bh5VOjTzlJDpnG3ycb/KGTWFodtfxnrQxnbfQUL/Ydh4WoqkVCa
	2aEdwBnk7NzqIzBG9qBsyjIXa0eB59vQZBND4tB+r/c9frANH13y2NkNku6bkud3FJ5NE4AnEVSgh
	UXD+sbfatCqDxN2ENNHr/OjK6SOD+tUlfHB7pAAvPV6jfLJEUJVfPn9GYv8WboGljAZu8tOguA3/c
	V+iarixv6hzm2av4N2Sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXso9-003my2-Ni; Thu, 02 Mar 2023 23:57:57 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXso6-003mxL-Vs
	for linux-um@lists.infradead.org; Thu, 02 Mar 2023 23:57:56 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 92803616C6;
	Thu,  2 Mar 2023 23:57:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85E0C433EF;
	Thu,  2 Mar 2023 23:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1677801473;
	bh=rP97/gxcUgIzVw2/zflmEvcxaTNRmSxPr4nvJj5LxFc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=VU4ED0833nbbikLiSfmCfXKKPc3yRM7uf0lPta6lzW85yw4lWn6Zl15oa4VALjSIh
	 b06mkplVYY8SBUQREkQCVvsmcqTRdSkEbw09VTYyC1vJWuY5AHI+l7JzI8tkpiUkoi
	 LgGE/ysSU5cv8HobDFRZMP6veq5LkFZKkCDWukP8hWIO5FLBMgegGFzNO4rSpUw+7v
	 V+FYvfMzAJa2N2gNY0cKVlJ8p7y+9YN0pLP9UdcpKHAQFwCWTsRvNzwGLSS9/q59tj
	 VDXNEImpMm9uw8x1jvRev8oGlHBUnKZe87YiUVjgWWRwD61eOzfujPEJfwCf9CkFHw
	 7cxPHmGrPcxZA==
Message-ID: <ecb5ede44d5bcc0430dad99e53d4477d.sboyd@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLdPWRLu8TNqCG+dw9Pz2cS798QwGX=C5X18KKqAXwjSQ@mail.gmail.com>
References: <20230302013822.1808711-1-sboyd@kernel.org> <CAL_JsqLVQVZhYTSZgrvA-V-xOUbiBdyDxqPOZk=89YS33EahBQ@mail.gmail.com> <093867df6137ad9e964b7dd90fb58f1a.sboyd@kernel.org> <CAL_JsqLdPWRLu8TNqCG+dw9Pz2cS798QwGX=C5X18KKqAXwjSQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] clk: Add kunit tests for fixed rate and parent data
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Vincent Whitchurch <vincent.whitchurch@axis.com>, Frank Rowand <frowand.list@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, devicetree@vger.kernel.org, linux-um@lists.infradead.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
To: Rob Herring <robh+dt@kernel.org>
Date: Thu, 02 Mar 2023 15:57:50 -0800
User-Agent: alot/0.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230302_155755_147265_46F3D84D 
X-CRM114-Status: GOOD (  40.07  )
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

UXVvdGluZyBSb2IgSGVycmluZyAoMjAyMy0wMy0wMiAxMjoxODozNCkKPiBPbiBUaHUsIE1hciAy
LCAyMDIzIGF0IDE6NDTigK9QTSBTdGVwaGVuIEJveWQgPHNib3lkQGtlcm5lbC5vcmc+IHdyb3Rl
Ogo+ID4KPiA+IFF1b3RpbmcgUm9iIEhlcnJpbmcgKDIwMjMtMDMtMDIgMDk6MTM6NTkpCj4gPiA+
Cj4gPiA+IEdvb2QgdG8gc2VlIGJpbmRpbmdzIGZvciB0aGlzLiBJJ3ZlIGJlZW4gbWVhbmluZyB0
byBkbyBzb21ldGhpbmcgYWJvdXQKPiA+ID4gdGhlIERUIHVuaXR0ZXN0IG9uZXMgYmVpbmcgdW5k
b2N1bWVudGVkLCBidXQgSSBoYWRuJ3QgcmVhbGx5IGRlY2lkZWQKPiA+ID4gd2hldGhlciBpdCB3
YXMgd29ydGggd3JpdGluZyBzY2hlbWFzIGZvciB0aGVtLiBUaGUgY29tcGF0aWJsZXMgYXQKPiA+
ID4gbGVhc3Qgc2hvdyB1cCB3aXRoICdtYWtlIGR0X2NvbXBhdGlibGVfY2hlY2snLiBQZXJoYXBz
IHdlIHdhbnQgdG8ganVzdAo+ID4gPiBkZWZpbmUgc29tZSB2ZW5kb3IgKG5vdCAnbGludXgnKSB0
aGF0J3MgYW4gZXhjZXB0aW9uIHJhdGhlciB0aGFuCj4gPiA+IHJlcXVpcmluZyBzY2hlbWFzIChh
Y3R1YWxseSwgdGhhdCBhbHJlYWR5IHdvcmtzIGZvciAnZm9vJykuCj4gPgo+ID4gU3VyZS4gTWF5
YmUgImt1bml0IiBzaG91bGQgYmUgdGhlIHZlbmRvciBwcmVmaXg/IE9yICJkdGJ1bml0Ij8KPiAK
PiBXZSdkIHdhbnQgdG8gdXNlIHRoZSBzYW1lIHRoaW5nIG9uIHRoZSBEVCB1bml0dGVzdHMgb3Ig
YW55dGhpbmcgZWxzZQo+IHBvdGVudGlhbGx5LiBIb3cgYWJvdXQganVzdCAndGVzdCc/CgpTb3Vu
ZHMgZ29vZC4KCj4gCj4gPiA+IEl0J3MKPiA+ID4gbGlrZWx5IHRoYXQgd2Ugd2FudCB0ZXN0IERU
cyB0aGF0IGZhaWwgbm9ybWFsIGNoZWNrcyBhbmQgc2NoZW1hcyBnZXQKPiA+ID4gaW4gdGhlIHdh
eSBvZiB0aGF0IGFzIHdlIGRvbid0IGhhdmUgYSB3YXkgdG8gdHVybiBvZmYgY2hlY2tzLgo+ID4K
PiA+IEhhdmluZyB0aGUgc2NoZW1hcyBpcyBuaWNlIHRvIG1ha2Ugc3VyZSB0ZXN0cyB0aGF0IGFy
ZSBleHBlY3Rpbmcgc29tZQo+ID4gYmluZGluZyBhcmUgYWN0dWFsbHkgZ2V0dGluZyB0aGF0LiBC
dXQgc3VwcG9ydGluZyBicm9rZW4gYmluZGluZ3MgaXMKPiA+IGFsc28gaW1wb3J0YW50IHRvIHRl
c3QgYW55IGVycm9yIHBhdGhzIGluIGZ1bmN0aW9ucyB0aGF0IHBhcnNlCj4gPiBwcm9wZXJ0aWVz
LiBNYXliZSB3ZSBrZWVwIHRoZSBzY2hlbWEgYW5kIGhhdmUgaXQgZW5mb3JjZSB0aGF0IGluY29y
cmVjdAo+ID4gcHJvcGVydGllcyBhcmUgYmVpbmcgc2V0Pwo+IAo+IEkgd2Fzbid0IHN1Z2dlc3Rp
bmcgdGhyb3dpbmcgdGhlbSBvdXQuIE1vcmUgd2h5IEkgaGFkbid0IHdyaXR0ZW4gYW55IEkgZ3Vl
c3MuCj4gCj4gPiBEbyB3ZSByZWFsbHkgbmVlZCB0byB0ZXN0IGluY29ycmVjdCBiaW5kaW5ncz8g
RG9lc24ndCB0aGUKPiA+IGR0X2JpbmRpbmdzX2NoZWNrIGNhdGNoIHRoZXNlIHByb2JsZW1zIHNv
IHdlIGRvbid0IGhhdmUgdG8gd3JpdGUgRFRCCj4gPiB2ZXJpZmllcnMgaW4gdGhlIGtlcm5lbD8K
PiAKPiBGYWlyIGVub3VnaC4gVXNpbmcgbXkgZnJlcXVlbnRseSBzdGF0ZWQgcG9zaXRpb24gYWdh
aW5zdCBtZS4gOikKPiAKPiBJIGRvIGhhdmUgYSBzZWNyZXQgcGxhbiB0byBpbXBsZW1lbnQgKGRl
YnVnKSB0eXBlIGNoZWNrcyBpbnRvIHRoZQo+IG9mX3Byb3BlcnR5XyogQVBJcyBieSBleHRyYWN0
aW5nIHRoZSB0eXBlIGluZm9ybWF0aW9uIGZyb20gc2NoZW1hcwo+IGludG8gQy4KPiAKCk9rLiBJ
IHN1c3BlY3Qgd2UgbWF5IHdhbnQgdG8gdGVzdCBlcnJvciBwYXRocyB0aG91Z2ggc28gSSBkb24n
dCBrbm93CndoYXQgdG8gZG8gaGVyZS4gRm9yIG5vdyBJJ2xsIGp1c3QgbGVhdmUgdGhlIGJpbmRp
bmdzIGluIHBsYWNlIGFuZApjaGFuZ2UgdGhlIHByZWZpeCB0byAidGVzdCIuCgo+IAo+ID4gPiBX
ZSBhbHJlYWR5IGhhdmUgR1BJTyB0ZXN0cyBpbiB0aGUgRFQgdW5pdHRlc3RzLCBzbyB3aHkgaXMg
Y2xvY2tzCj4gPiA+IGRpZmZlcmVudD8gT3Igc2hvdWxkIHRoZSBHUElPIHRlc3RzIGJlIG1vdmVk
IG91dCAoeWVzLCBwbGVhc2UhKT8KPiA+Cj4gPiBBaCBJIGRpZG4ndCBub3RpY2UgdGhlIEdQSU8g
dGVzdHMgaW4gdGhlcmUuIFRoZXJlIGFyZSBpMmMgdGVzdHMgdG9vLAo+ID4gcmlnaHQ/IEFsbCBJ
IGNhbiBzYXkgaXMgY2xrcyBhcmUgdXNpbmcga3VuaXQsIHRoYXQncyB0aGUgZGlmZmVyZW5jZSA7
LSkKPiAKPiBZZWFoLCB0aGV5IHNob3VsZCBwZXJoYXBzIGFsbCBtb3ZlIHRvIHRoZSBzdWJzeXN0
ZW1zLgoKR290IGl0LgoKPiAKPiA+ID4gV2hhdCBoYXBwZW5zIHdoZW4vaWYgdGhlIERUIHVuaXR0
ZXN0IGlzIGNvbnZlcnRlZCB0byBrdW5pdD8gSSB0aGluawo+ID4gPiB0aGF0IHdvdWxkIGxvb2sg
Y29uZnVzaW5nIGZyb20gdGhlIG5hbWluZy4gTXkgaW5pdGlhbCB0aG91Z2h0IGlzCj4gPiA+ICdr
dW5pdCcgc2hvdWxkIGJlIGRyb3BwZWQgZnJvbSB0aGUgbmFtaW5nIG9mIGEgbG90IG9mIHRoaXMu
IE5vdGUgdGhhdAo+ID4gPiB0aGUgb3JpZ2luYWwga3VuaXQgc3VibWlzc2lvbiBjb252ZXJ0ZWQg
dGhlIERUIHVuaXR0ZXN0cy4gSSB3b3VsZAo+ID4gPiBzdGlsbCBsaWtlIHRvIHNlZSB0aGF0IGhh
cHBlbi4gRnJhbmsgZGlzYWdyZWVkIG92ZXIgd2hhdCdzIGEgdW5pdCB0ZXN0Cj4gPiA+IG9yIG5v
dCwgdGhlbiBhZ3JlZWQsIHRoZW4gZGlkbid0Li4uIEkgZG9uJ3QgcmVhbGx5IGNhcmUuIElmIHRo
ZXJlJ3MgYQo+ID4gPiBmcmFtZXdvcmsgdG8gdXNlLCB0aGVuIHdlIHNob3VsZCB1c2UgaXQgSU1P
Lgo+ID4KPiA+IEhvbmVzdGx5IEkgZG9uJ3Qgd2FudCB0byBnZXQgaW52b2x2ZWQgaW4gbWlncmF0
aW5nIHRoZSBleGlzdGluZyBEVAo+ID4gdW5pdHRlc3QgY29kZSB0byBrdW5pdC4gSSdtIGF3YXJl
IHRoYXQgaXQgd2FzIGF0dGVtcHRlZCB5ZWFycyBhZ28gd2hlbgo+ID4ga3VuaXQgd2FzIGludHJv
ZHVjZWQuIE1heWJlIGlmIHRoZSBvdmVybGF5IHJvdXRlIHdvcmtzIHdlbGwgZW5vdWdoIEkgY2Fu
Cj4gPiBjb21wbGV0ZWx5IHNpZGVzdGVwIGludHJvZHVjaW5nIGFueSBjb2RlIGluIGRyaXZlcnMv
b2YvIGJlc2lkZXMgc29tZQo+ID4ga3VuaXQgd3JhcHBlcnMgZm9yIHRoaXMuIEknbGwgY3Jvc3Mg
bXkgZmluZ2VycyEKPiAKPiBZZWFoLCBJIHdhc24ndCBleHBlY3RpbmcgeW91IHRvLiBJIGp1c3Qg
d2FudCB0byBtYWtlIHN1cmUgdGhpcyBtZXNoZXMKPiB3aXRoIGFueSBmdXR1cmUgY29udmVyc2lv
biB0byBrdW5pdC4KClBoZXchCgo+IAo+IFRoZXJlJ3MgYWxzbyBzb21lIHBsYW5zIHRvIGFsd2F5
cyBwb3B1bGF0ZSB0aGUgRFQgcm9vdCBub2RlIGlmIG5vdAo+IHByZXNlbnQuIFRoYXQgbWF5IGhl
bHAgaGVyZS4gT3Igbm90LiBUaGVyZSdzIGJlZW4gYSBmZXcgdmVyc2lvbnMKPiBwb3N0ZWQgd2l0
aCBGcmFuaydzIGluIHRoZSBsYXN0IHdlZWsgb3IgMi4KPiAKCk9rLiBJIHRoaW5rIEkgaGF2ZSBz
b21lIHRpbWUgdG8gdHJ5IHRoaXMgb3ZlcmxheSBhcHByb2FjaCBzbyBsZXQgbWUgc2VlCndoYXQg
aXMgbmVlZGVkLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=

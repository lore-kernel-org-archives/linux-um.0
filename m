Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD33C6FD1D
	for <linux-um@archiver.kernel.org>; Fri, 17 Mar 2023 16:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0pJ+T06wkgTyyrQ+i9bz0/JjNiNFNzNiXTI4cd1SUHQ=; b=tkDv9r/eWkEvsl
	zEtUJFkkBX8BrNyHLuJr4OBZiUh7RCMOhED7IZfB/MQSbPR4c34pczmH6sJIjdM3ibGzACyuxymzy
	CfwhH0rFB2ftnT5rR4Y769ahLHujD54ldPuo6uJ85i3wZKX/gwaIuj2/YfxJiJOA+IzMbkaK0/iRN
	f74AWlWB4Wfz/e5KyEljT8orG+5jI9umHnmYIIDn7xYzNzlhKj1XLtaKYcPeznMxiK/Rxy20XO03t
	3RWPN9gNn+jsZ4l7eOdWQrUnhRCKZ+/SoC3x05QQMuvZdDWNvrGGD6bdG0vbcvI4a1ejwvGUWPNe6
	F3w6cu3pF9/f3sv5OgFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pdDPV-002peg-0I;
	Fri, 17 Mar 2023 16:58:33 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pdDPR-002pdC-0r
	for linux-um@lists.infradead.org;
	Fri, 17 Mar 2023 16:58:31 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id C08B3CE20DE;
	Fri, 17 Mar 2023 16:58:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79013C433EF;
	Fri, 17 Mar 2023 16:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679072301;
	bh=HkZYRS1AYP6lP6lCE1m81d51ONq9tmt3boQniQPqiSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nVMcuR2UDIQuii6iDxqmLrIN8w9eQ4JRh36wMbijOW51PIvDNBLtftFmgGv+W92yU
	 NIbhasIjS0qlCH5jaRs+niPZbiO+Seo00vit4CxHtTfnltvA/Hf6GMWkFfiJ1niW2o
	 69neeWp+bSY1+kaXobtvYB3jbR4+hXKKn7v6qF4XxeDHHAlmgbtUpnvOwlTB+klfiL
	 Y+2NYppAI9n8YSL8VIQn6x2AcCAb6U6tNyoid6sdzHiElQn0VXev/sVF8sQjmsGA9c
	 2QNN44m63dw/o9e1bfHQEFDU5gzcbNA9ASlH8DuD4brk8Ho8dmy3w8FofzWaa3vo9I
	 iKK5U9OFwWxrA==
From: SeongJae Park <sj@kernel.org>
To: David Gow <davidgow@google.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
	linux-um@lists.infradead.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	SeongJae Park <sj@kernel.org>
Subject: Re: Cannot compile UML in Ubuntu 20.04.5 anymore
Date: Fri, 17 Mar 2023 16:58:18 +0000
Message-Id: <20230317165818.69713-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CABVgOSm1t3_mcUUu0A8eG-zAA4q0d-dmi6Ceb3TFtoUt1i3gTQ@mail.gmail.com>
References: 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230317_095829_771861_90D9745F 
X-CRM114-Status: GOOD (  23.89  )
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

T24gU2F0LCA0IE1hciAyMDIzIDEyOjM1OjI0ICswODAwIERhdmlkIEdvdyA8ZGF2aWRnb3dAZ29v
Z2xlLmNvbT4gd3JvdGU6Cgo+IAo+IFstLSBBdHRhY2htZW50ICMxLjE6IFR5cGU6IHRleHQvcGxh
aW4sIFNpemU6IDIxNTkgYnl0ZXMgLS1dCj4gCj4gT24gRnJpLCAzIE1hciAyMDIzIGF0IDE2OjM3
LCBSb2JlcnRvIFNhc3N1Cj4gPHJvYmVydG8uc2Fzc3VAaHVhd2VpY2xvdWQuY29tPiB3cm90ZToK
PiA+Cj4gPiBIaQo+ID4KPiA+IGl0IGxvb2tzIGxpa2Ugb25lIHJlY2VudCBjb21taXQgY2F1c2Vz
IHRoZSBrZXJuZWwgYnVpbGQgdG8gYnJlYWsuCj4gPgo+ID4gICBHRU4gICAgIHNjcmlwdHMvZ2Ri
L2xpbnV4L2NvbnN0YW50cy5weQo+ID4gSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC91c3IvaW5jbHVk
ZS9zdGRsaWIuaDoxMDEzLAo+ID4gICAgICAgICAgICAgICAgICBmcm9tIGFyY2gvdW0vb3MtTGlu
dXgvaGVscGVyLmM6NjoKPiA+IC91c3IvaW5jbHVkZS94ODZfNjQtbGludXgtZ251L2JpdHMvc3Rk
bGliLWZsb2F0Lmg6IEluIGZ1bmN0aW9uIOKAmGF0b2bigJk6Cj4gPiAvdXNyL2luY2x1ZGUveDg2
XzY0LWxpbnV4LWdudS9iaXRzL3N0ZGxpYi1mbG9hdC5oOjI2OjE6IGVycm9yOiBTU0UgcmVnaXN0
ZXIgcmV0dXJuIHdpdGggU1NFIGRpc2FibGVkCj4gPiAgICAyNiB8IHsKPiA+ICAgICAgIHwgXgo+
ID4gICBDQyAgICAgIGluaXQvbm9pbml0cmFtZnMubwo+ID4KPiA+IEl0IHdvcmtzIGFnYWluIGJ5
IHJldmVydGluZyBjb21taXQgODg0OTgxODY3OTQ3ICgicnVzdDogYXJjaC91bToKPiA+IERpc2Fi
bGUgRlAvU0lNRCBpbnN0cnVjdGlvbiB0byBtYXRjaCB4ODYiKS4KPiA+Cj4gPiAkIGNhdCAvcHJv
Yy9jcHVpbmZvCj4gPgo+ID4gWy4uLl0KPiA+Cj4gPiBwcm9jZXNzb3IgICAgICAgOiAzMQo+ID4g
dmVuZG9yX2lkICAgICAgIDogQXV0aGVudGljQU1ECj4gPiBjcHUgZmFtaWx5ICAgICAgOiAyMwo+
ID4gbW9kZWwgICAgICAgICAgIDogNDkKPiA+IG1vZGVsIG5hbWUgICAgICA6IEFNRCBSeXplbiBU
aHJlYWRyaXBwZXIgUFJPIDM5NTVXWCAxNi1Db3Jlcwo+ID4KPiA+IFRoYW5rcwo+ID4KPiA+IFJv
YmVydG8KPiA+Cj4gCj4gWXVwLCB0aGlzIGlzIGRlZmluaXRlbHkgY2F1c2VkIGJ5IDg4NDk4MTg2
Nzk0NyAoInJ1c3Q6IGFyY2gvdW06Cj4gRGlzYWJsZSBGUC9TSU1EIGluc3RydWN0aW9uIHRvIG1h
dGNoIHg4NiIpLgo+IAo+IEl0IGxvb2tzIGxpa2UgR0NDIGZpeGVkIHRoaXMgdXBzdHJlYW0gaW4g
R0NDIDExOgo+IGh0dHBzOi8vZ2NjLmdudS5vcmcvYnVnemlsbGEvc2hvd19idWcuY2dpP2lkPTk5
NjUyCj4gCj4gRXF1YWxseSB0aG91Z2gsIG5vdCBoYXZpbmcgdGhpcyBjaGFuZ2UgYnJlYWtzIG9s
ZGVyIHZlcnNpb25zIG9mIExMVk0sCj4gc28gSSB0aGluayBpdCdzIGJlc3QgdG8gbm90IHRvdGFs
bHkgcmV2ZXJ0IGl0Lgo+IAo+IFNvbWV0aGluZyBsaWtlIHRoaXMgc2hvdWxkIHdvcms6Cj4gLS0t
Cj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L01ha2VmaWxlLnVtIGIvYXJjaC94ODYvTWFrZWZpbGUu
dW0KPiBpbmRleCBkMmU5NWQxZDRkYjcuLjFhYTY0ODQ2ZTUzOSAxMDA2NDQKPiAtLS0gYS9hcmNo
L3g4Ni9NYWtlZmlsZS51bQo+ICsrKyBiL2FyY2gveDg2L01ha2VmaWxlLnVtCj4gQEAgLTMsOSAr
MywxNCBAQCBjb3JlLXkgKz0gYXJjaC94ODYvY3J5cHRvLwo+IAo+ICMKPiAjIERpc2FibGUgU1NF
IGFuZCBvdGhlciBGUC9TSU1EIGluc3RydWN0aW9ucyB0byBtYXRjaCBub3JtYWwgeDg2Cj4gKyMg
VGhpcyBpcyByZXF1aXJlZCB0byB3b3JrIGFyb3VuZCBpc3N1ZXMgaW4gb2xkZXIgTExWTSB2ZXJz
aW9ucywgYnV0IGJyZWFrcwo+ICsjIEdDQyB2ZXJzaW9ucyA8IDExLiBTZWU6Cj4gKyMgaHR0cHM6
Ly9nY2MuZ251Lm9yZy9idWd6aWxsYS9zaG93X2J1Zy5jZ2k/aWQ9OTk2NTIKPiAjCj4gK2lmZXEg
KCQoQ09ORklHX0NDX0lTX0NMQU5HKSx5KQo+IEtCVUlMRF9DRkxBR1MgKz0gLW1uby1zc2UgLW1u
by1tbXggLW1uby1zc2UyIC1tbm8tM2Rub3cgLW1uby1hdngKPiBLQlVJTERfUlVTVEZMQUdTICs9
Cj4gLUN0YXJnZXQtZmVhdHVyZT0tc3NlLC1zc2UyLC1zc2UzLC1zc3NlMywtc3NlNC4xLC1zc2U0
LjIsLWF2eCwtYXZ4Mgo+ICtlbmRpZgo+IAo+IGlmZXEgKCQoQ09ORklHX1g4Nl8zMikseSkKPiBT
VEFSVCA6PSAweDgwNDgwMDAKPiAtLS0KCkkgYWxzbyBlbmNvdW50ZXJlZCB0aGUgc2FtZSBpc3N1
ZSwgYW5kIGNvbmZpcm1lZCB0aGlzIGZpeGVzIHRoZSBpc3N1ZSBvbiBteQptYWNoaW5lLgoKVGVz
dGVkLWJ5OiBTZW9uZ0phZSBQYXJrIDxzakBrZXJuZWwub3JnPgoKClRoYW5rcywKU0oKCj4gCj4g
VGhvdWdoIHRoZSBtb3JlIGNvcnJlY3Qgc29sdXRpb24gd291bGQgYmUgdG8ganVzdCBjaGVjawo+
IGdjYy1taW4tdmVyc2lvbiB8fCBjbGFuZy4gVGhhdCBwcm9iYWJseSByZXF1aXJlcyBhIGJpdCBt
b3JlCj4gbWFrZWZpbGUtZnUgdG8gZG8gY2xlYW5seSwgdGhvdWdoLgo+IAo+IENoZWVycywKPiAt
LSBEYXZpZAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=

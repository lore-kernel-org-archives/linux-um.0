Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862D0CE79AA
	for <linux-um@archiver.kernel.org>; Tue, 19 Sep 2023 16:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:From:To:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UgJLX7XIWwEDQ0oBBtwrSW2bPmg6vHNYRdxPTnJ2RLk=; b=3Sv4mo6FQvUwds
	2O+aKRVP8pwb37XyFEWQP6XEaF0WiOKGgzWJ7h13T4gCLTr206Wn/TxnJRYs6seOeUqpQzm9Y/cF3
	05BhPsJE1W2WzMMFHN+PnUy17aKeMpKkqyGxh5pAldxzXnvWY86mPEVhswAqXEORcW+WQAx3bdars
	eWR24Y4PAcAf3u8qmtFwUfSIltYqehNmCNZV5Xsh73OxyttUUd7GgsMaVOiWP8hn7N/9MRm47Kf/c
	Ni4+/cEhXEsn4qHeyy5nI8iOiLZQnu7HXAafe74cG6m59CyX048wsC3N3AqkXTiRD97r4xzLs0lGf
	eqEPZ8nx37bT7H6Q3qWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qidOV-000qK9-26;
	Tue, 19 Sep 2023 16:16:11 +0000
Received: from mail-4323.proton.ch ([185.70.43.23])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qidOP-000qIq-0T;
	Tue, 19 Sep 2023 16:16:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n8pjl.ca;
	s=protonmail2; t=1695140160; x=1695399360;
	bh=k2QmhXn3FHpsD31Ag66sjWvY57vLi94vGdI9Jg32c2Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=VjPOUfr+BDKot6jNtzfiNQUBn+0rrhZJiA59iRWy30aLqarcEfUbJl13WNuPnXIoW
	 NywHiVkOkN0sAhAj5HVCpUg5MCHPnoVtVm3uKwvnlLQz2bUOxdLprD9u+w4LbKTPgA
	 bnBfsyBEq3NfeW6N9NlCpqkwDvrEgdVVXns49DKnopvogQCzzy0NJzr2/B+6TZ37p2
	 pBG3Imgo+IjObhl+GtscMyMDCDfzeNnzpCBmxFsxt25WKmx+xpxmqyJ0hqsjVZLW+n
	 JXFusuE18XA6ozPVKnAkxmiePcriJHUHal7GefK+IYNNYtydrpkBO7Z/E7Jw9j+Yfj
	 +4CaTlaacEEcQ==
Date: Tue, 19 Sep 2023 16:15:41 +0000
To: geert@linux-m68k.org
From: Peter Lafreniere <peter@n8pjl.ca>
Cc: anton.ivanov@cambridgegreys.com, ink@jurassic.park.msu.ru, jack@suse.cz, johannes@sipsolutions.net, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org, linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, linux-um@lists.infradead.org, linux@armlinux.org.uk, linuxppc-dev@lists.ozlabs.org, peter@n8pjl.ca, reiserfs-devel@vger.kernel.org, richard.henderson@linaro.org, richard@nod.at, segher@kernel.crashing.org, tsbogend@alpha.franken.de
Subject: Re: [PATCH 0/7] arch/*: config: Remove ReiserFS from defconfig
Message-ID: <20230919161535.4774-1-peter@n8pjl.ca>
In-Reply-To: <CAMuHMdXQ=xpeY3tmLXe1kgJbRtmVAn62rEhvzO+VB7GCgy4F8w@mail.gmail.com>
References: <20230918175529.19011-1-peter@n8pjl.ca> <20230918234108.GN19790@gate.crashing.org> <20230919000026.7409-1-peter@n8pjl.ca> <20230919151630.GO19790@gate.crashing.org> <20230919155832.4179-1-peter@n8pjl.ca> <CAMuHMdXQ=xpeY3tmLXe1kgJbRtmVAn62rEhvzO+VB7GCgy4F8w@mail.gmail.com>
Feedback-ID: 53133685:user:proton
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230919_091605_359968_8E793207 
X-CRM114-Status: GOOD (  10.57  )
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

SGkgR2VlcnQsCgpPbiBUdWUsIFNlcCAxOSwgMjAyMyBhdCAxMjowMiwgR2VlcnQgVXl0dGVyaG9l
dmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4gd3JvdGU6Cj4gCj4gSGkgUGV0ZXIsCj4gCj4gT24g
VHVlLCBTZXAgMTksIDIwMjMgYXQgNTo1OOKAr1BNIFBldGVyIExhZnJlbmllcmUgcGV0ZXJAbjhw
amwuY2Egd3JvdGU6Cj4gCj4gPiAyKSBTdG9wcyBidWlsZGluZyBhbiBvYnNvbGV0ZSBhbmQgbGFy
Z2VseS11bnVzZWQgZmlsZXN5c3RlbSB1bm5lY2Vzc2FyaWx5Lgo+ID4gU29tZSBob2JieWlzdCB0
YXJnZXRzIGxpa2UgbTY4ayBhbmQgYWxwaGEgbWF5IHByZWZlciB0byBrZWVwIGFsbCBmaWxlc3lz
dGVtcwo+ID4gYXZhaWxhYmxlIHVudGlsIHRvdGFsIHJlbW92YWwsIGJ1dCBvdGhlcnMgbGlrZSBh
cm0gYW5kIFVNTCBoYXZlIG5vIG5lZWQgZm9yCj4gPiBSZWlzZXJGUyB0byBiZSBidWlsdCB1bmxl
c3Mgc3BlY2lmaWNhbGx5IGNvbmZpZ3VyZWQuCj4gCj4gCj4gQXMgVU1MIGlzIHVzZWQgYSBsb3Qg
Zm9yIHRlc3RpbmcsIGlzbid0IGl0IGFjdHVhbGx5IGNvdW50ZXItcHJvZHVjdGl2ZQo+IHRvIHJl
bW92ZSBSZWlzZXJGUyBmcm9tIHRoZSBVTUwgZGVmY29uZmlnPyBUaGUgbGVzcyB0ZXN0aW5nIGl0
Cj4gcmVjZWl2ZXMsIHRoZSBoaWdoZXIgdGhlIGNoYW5jZSBvZiBpbnRyb2R1Y2luZyByZWdyZXNz
aW9ucy4KClVNTCBpcyB1c2VkIGZvciB0ZXN0aW5nLCBidXQgaW4gbXkgdmlldyB0aGF0IG1ha2Vz
IHRoZSBpbmNsdXNpb24gb2YKUmVpc2VyRlMgaW4gaXRzIGRlZmNvbmZpZyBldmVuIHdvcnNlLiBV
c2VycyBvZiBVTUwgYXJlIHRyeWluZyB0byB0ZXN0IGEKcGFydGljdWxhciBmdW5jdGlvbiwgYW5k
IHNvIHRlbmQgdG8gdXNlIGV4dFsyLTRdLCBhcyB0aG9zZSBhcmUgaW5jbHVkZWQgaW4KdGhlIGRl
ZmNvbmZpZyBhbmQgYXJlIHdlbGwgdGVzdGVkIGFuZCBzdGFibGUuIFNvIHRoZXJlIGlzIG5vIGV4
dHJhIHRlc3RpbmcKYmVpbmcgZG9uZSBvbiBSZWlzZXJGUyBkdWUgdG8gaXRzIGluY2x1c2lvbiBp
biB0aGUgZGVmY29uZmlnLgoKS2VlcGluZyBVTUwncyBkZWZjb25maWcgYXMgc2xpbSBhcyBwb3Nz
aWJsZSBpbXByb3ZlcyBidWlsZCB0aW1lcywgd2hpY2ggaXMKcGFydGljdWxhcmx5IGltcG9ydGFu
dCBmb3Iga2VybmVsIHRlc3RpbmcgYW5kIGRldmVsb3BtZW50LgoKPiAKPiBHcntvZXRqZSxlZXRp
bmd9cywKPiAKPiBHZWVydAo+CgpDaGVlcnMsClBldGVyIExhZnJlbmllcmUgCgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBs
aXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=

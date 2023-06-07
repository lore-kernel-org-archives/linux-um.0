Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC548C77B7A
	for <linux-um@archiver.kernel.org>; Wed,  7 Jun 2023 04:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zSIIknZwTohLSh9terer6+toFwGDBP8SqkIFw78dutk=; b=QLw16ZnNTmOOec
	qr1Bod4Bv26lqkKU1tQQqAVsHg74TRcwLEFE+brUa6LRVF6hnzO+CK9AUwHwgiIhf4xPBDyeKtmzy
	0IGBzIlme0CkgAwnAdSQ6+WOoAjwN12+gVlJTpnP436UeT48GTxZSAtRo3XxCgowHvT+gYcMNbzlf
	WO4l8Uput1WHovXCYkm4JqGralxbNsejv2uOyFT51YK7FwohqnJ4GwryvMwvPPbvVMUybFsHXdRwz
	Z8oFDER4IWQelT3MvgXnkXJM+Z4zVGTSQP6zV29nsiBQx9sZ3KntKCVRsrHEDVFJSkz09yHC9vOhv
	Kx/z55jelZYlKqzPg5zA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6ki5-004Hgc-0z;
	Wed, 07 Jun 2023 04:23:49 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6ki2-004HfT-1s
	for linux-um@lists.infradead.org;
	Wed, 07 Jun 2023 04:23:48 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 01CBE634FD;
	Wed,  7 Jun 2023 04:23:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE47C433EF;
	Wed,  7 Jun 2023 04:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686111822;
	bh=7sP96yW6yc29Ckr2GzZEmGrtPlO4yW5CLupbhWesCjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DiIynji1RhG+2QeeyvmhHbOno6Sf1ehLKKPh4D68VDruy2w3ooysdrKASf+z6UGoU
	 Ojcfzah5qzg6fTfj3JKiSHkpBgxECJS0H9XspVRQ77a+KwZVoc84jTBQP2kxI7EJdq
	 8UIprPkCU5ZKZeeZ2RvJ9Nwl+R7k78kMMerb+DOyIKtJG4ugllMGFmA6XTyKIh+35W
	 OO+BIePAbHh3N29muyQJwGaMCacx3VnomE3Gw+ABC5fR3F/lt8JoAg9Aeyn2sJqLC0
	 9b7IQsKlGBz9cYbtOL6X+ogSl8dnU+1Eeqw3cd0bh2vjps9Z/C7CWk5k0UZOWPqDfW
	 3pnOpfnstswPA==
Date: Tue, 6 Jun 2023 21:23:40 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Azeem Shaikh <azeemshaikh38@gmail.com>
Cc: Richard Weinberger <richard@nod.at>,
	Maxim Krasnyansky <maxk@qti.qualcomm.com>,
	anton ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-hardening <linux-hardening@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-um <linux-um@lists.infradead.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] uml: Replace strlcpy with strscpy
Message-ID: <20230607042340.GA941@sol.localdomain>
References: <20230606182410.3976487-1-azeemshaikh38@gmail.com>
 <1833651082.3690424.1686084717406.JavaMail.zimbra@nod.at>
 <CADmuW3WzC61-si1j61kzwfx5EcsvSt4QBaY9VHiybBRWAN3yyA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADmuW3WzC61-si1j61kzwfx5EcsvSt4QBaY9VHiybBRWAN3yyA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230606_212346_681178_6693EE3E 
X-CRM114-Status: GOOD (  19.63  )
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

T24gVHVlLCBKdW4gMDYsIDIwMjMgYXQgMDU6MDg6MjdQTSAtMDQwMCwgQXplZW0gU2hhaWtoIHdy
b3RlOgo+IE9uIFR1ZSwgSnVuIDYsIDIwMjMgYXQgNDo1MeKAr1BNIFJpY2hhcmQgV2VpbmJlcmdl
ciA8cmljaGFyZEBub2QuYXQ+IHdyb3RlOgo+ID4KPiA+IC0tLS0tIFVyc3Byw7xuZ2xpY2hlIE1h
aWwgLS0tLS0KPiA+ID4gVm9uOiAiQXplZW0gU2hhaWtoIiA8YXplZW1zaGFpa2gzOEBnbWFpbC5j
b20+Cj4gPiA+IHN0cmxjcHkoKSByZWFkcyB0aGUgZW50aXJlIHNvdXJjZSBidWZmZXIgZmlyc3Qu
Cj4gPiA+IFRoaXMgcmVhZCBtYXkgZXhjZWVkIHRoZSBkZXN0aW5hdGlvbiBzaXplIGxpbWl0Lgo+
ID4gPiBUaGlzIGlzIGJvdGggaW5lZmZpY2llbnQgYW5kIGNhbiBsZWFkIHRvIGxpbmVhciByZWFk
Cj4gPiA+IG92ZXJmbG93cyBpZiBhIHNvdXJjZSBzdHJpbmcgaXMgbm90IE5VTC10ZXJtaW5hdGVk
IFsxXS4KPiA+ID4gSW4gYW4gZWZmb3J0IHRvIHJlbW92ZSBzdHJsY3B5KCkgY29tcGxldGVseSBb
Ml0sIHJlcGxhY2UKPiA+ID4gc3RybGNweSgpIGhlcmUgd2l0aCBzdHJzY3B5KCkuCj4gPiA+IE5v
IHJldHVybiB2YWx1ZXMgd2VyZSB1c2VkLCBzbyBkaXJlY3QgcmVwbGFjZW1lbnQgaXMgc2FmZS4K
PiA+ID4KPiA+ID4gWzFdIGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwvbGF0ZXN0L3By
b2Nlc3MvZGVwcmVjYXRlZC5odG1sI3N0cmxjcHkKPiA+ID4gWzJdIGh0dHBzOi8vZ2l0aHViLmNv
bS9LU1BQL2xpbnV4L2lzc3Vlcy84OQo+ID4gPgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBemVlbSBT
aGFpa2ggPGF6ZWVtc2hhaWtoMzhAZ21haWwuY29tPgo+ID4gPiBSZXBvcnRlZC1ieToga2VybmVs
IHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+Cj4gPiA+IENsb3NlczoKPiA+ID4gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvb2Uta2J1aWxkLWFsbC8yMDIzMDUzMTExMzUuekdNVDFnWVItbGtwQGlu
dGVsLmNvbS8KPiA+Cj4gPiBBcmUgeW91IHN1cmUgUmVwb3J0ZWQtYnkgYW5kIENsb3NlcyBtYWtl
IHNlbnNlPwo+ID4gQUZBSUsgdGhlIHJlcG9ydCB3YXMgb25seSBvbiB5b3VyIGZpcnN0IHBhdGNo
IGFuZCBub3RoaW5nIGFnYWluc3QgdXBzdHJlYW0uCj4gPiBTbyBzdGF0aW5nIHRoaXMgaW4gdGhl
IHVwZGF0ZWQgcGF0Y2ggaXMgaW4gdmFpbi4KPiAKPiBJIGxlZnQgdGhlIG1ldGFkYXRhIGluIG9u
bHkgZm9yIHRoZSBzYWtlIG9mIHBvc3Rlcml0eS4gSWYgaXQncyBub3QKPiBoZWxwZnVsLCBJJ20g
b2sgd2l0aCByZW1vdmluZyBpdC4KPiAKCklNTyB1c2luZyBSZXBvcnRlZC1ieSBpbiBjYXNlcyBs
aWtlIHRoaXMgaXMgaGFybWZ1bCwgYXMgaXQgbWFrZXMgY29tbWl0cyBzZWVtCmxpa2UgYnVnIGZp
eGVzIHdoZW4gdGhleSBhcmUgbm90LgoKLSBFcmljCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LXVtCg==

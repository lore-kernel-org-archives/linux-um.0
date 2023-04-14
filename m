Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F0DC77B6E
	for <linux-um@archiver.kernel.org>; Fri, 14 Apr 2023 07:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=64hh61DuKGXdN7J7oP8KOVB1AtuPJlMgC9Dr221xVzs=; b=dOoghRtcWMqrOy
	jGcfwuPJQG9j7RMzgqSKSc0yab+r2m3F+XzTBf2RlyhNsrMgg+NBBh7yNq6i2pEnoPseuINEsnv2c
	JL54xfgD+ZzNpWUCwFLWpjPrvjuJKWVyyFUbFZfRdEK43641WnTC4qN0rOX4wRuxKsjMq6xjy/Gku
	YAHmilr0jX+Tce6Ti/+pJK8q5gi/G0J35k/lD0IAYBailSCUARIL+Ei2OtD4FiViIcIjlRkSHk718
	P5bdpS3qzN/CxRMLllQqJWwf7maOvLk5aYfk50qLfii0wv+5TjZNKQ2k4kmg8eVfAERmdoonNfwub
	V0PlZZH33c3uyUXyqnOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pnDgr-008Wnw-1q;
	Fri, 14 Apr 2023 07:17:49 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pnDgn-008Wn8-1I
	for linux-um@lists.infradead.org;
	Fri, 14 Apr 2023 07:17:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ENxsgM879ct62LSmf2mQMD/bps2hF+12KfmM8TUdy4E=;
	t=1681456662; x=1682666262; b=cknj/Vd6Y2YH/N1BR4yi2668VbUO1ohTTnKTmwQPTITv4RT
	ilnXAiC3n7XRIkRwgP1vORp16hqfntUTSgYVDarf0aQgMsq13GCmhKWx7wH2L1+ff4fyoY838DQwC
	3EDRN5bmS85ltSu4vpFCTkMWPWyuACpT5J9NmQB1ntkilbeOBKxSBGEsZ/e35E0iu2BzIKqrjZurH
	7m5xbJqDtj0UXoYAwpBsn5trUpQG4a+iEJ+RGRySoNzpo2BsUIjik/vM/K2QGAkswshuY5WzNfqjX
	gkyoigI8SkOnTRerA+jCLTlo+jKENUZy6xc6LcgjG9+rj4IHIEmsMvaelVyhcysw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1pnDgi-00FUhZ-1O;
	Fri, 14 Apr 2023 09:17:40 +0200
Message-ID: <6a67eb9db322d2afd165615bb6fe4e1d6a34ffa0.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] Document new xattrperm flag
From: Johannes Berg <johannes@sipsolutions.net>
To: Marko =?UTF-8?Q?Petrovi=C4=87?= <petrovicmarko2006@gmail.com>, 
	linux-um@lists.infradead.org
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com
Date: Fri, 14 Apr 2023 09:17:39 +0200
In-Reply-To: <20230413223024.11513-2-petrovicmarko2006@gmail.com>
References: <20230413223024.11513-1-petrovicmarko2006@gmail.com>
	 <20230413223024.11513-2-petrovicmarko2006@gmail.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230414_001746_319651_93BEB4D6 
X-CRM114-Status: GOOD (  20.18  )
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

SGksCgpOaWNlLiBJIHRoaW5rIHlvdSBjYW4gc3F1YXNoIHRoaXMgaW50byBhIHNpbmdsZSBwYXRj
aCBldmVudHVhbGx5LiBDb3VwbGUKb2YgY29tbWVudHMgYmVsb3c6CgpPbiBGcmksIDIwMjMtMDQt
MTQgYXQgMDA6MzAgKzAyMDAsIE1hcmtvIFBldHJvdmnEhyB3cm90ZToKPiBTaWduZWQtb2ZmLWJ5
OiBNYXJrbyBQZXRyb3ZpxIcgPHBldHJvdmljbWFya28yMDA2QGdtYWlsLmNvbT4KPiAtLS0KPiAg
Li4udG9fdjIucnN0ID0+IHVzZXJfbW9kZV9saW51eF9ob3d0b192My5yc3R9IHwgMjAgKysrKysr
KysrLS0tLS0tLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxMSBkZWxl
dGlvbnMoLSkKPiAgcmVuYW1lIERvY3VtZW50YXRpb24vdmlydC91bWwve3VzZXJfbW9kZV9saW51
eF9ob3d0b192Mi5yc3QgPT4gdXNlcl9tb2RlX2xpbnV4X2hvd3RvX3YzLnJzdH0gKDk5JSkKCkkg
ZG9uJ3QgdGhpbmsgeW91IHNob3VsZCByZW5hbWUgdGhpcywgaXQncyBub3QgYSBkb2N1bWVudCB2
ZXJzaW9uLCBpdCdzCm1vcmUgb2YgYSBoaXN0b3JpYyBhcnRpZmFjdCB0aGF0IGl0J3MgY2FsbGVk
IHYyIG5vdy4gV2Ugc2hvdWxkIHByb2JhYmx5CnJlbW92ZSB0aGF0IGFueXdheS4KCj4gKysrIGIv
RG9jdW1lbnRhdGlvbi92aXJ0L3VtbC91c2VyX21vZGVfbGludXhfaG93dG9fdjMucnN0Cj4gQEAg
LTEwMDcsMjMgKzEwMDcsMjEgQEAgYW4gZXhpc3Rpbmcgcm9vdF9mcyBmaWxlOjoKPiAgCj4gICAg
ICMgIG1vdW50IHJvb3RfZnMgdW1sX3Jvb3RfZGlyIC1vIGxvb3AKPiAgCj4gLQo+IC1Zb3UgbmVl
ZCB0byBjaGFuZ2UgdGhlIGZpbGVzeXN0ZW0gdHlwZSBvZiBgYC9gYCBpbiBgYGV0Yy9mc3RhYmBg
IHRvIGJlCj4gLSdob3N0ZnMnLCBzbyB0aGF0IGxpbmUgbG9va3MgbGlrZSB0aGlzOjoKPiAtCj4g
LSAgIC9kZXYvdWJkLzAgICAgICAgLyAgICAgICAgaG9zdGZzICAgICAgZGVmYXVsdHMgICAgICAg
ICAgMSAgIDEKPiAtCgpJIHdhcyBnb2luZyB0byBhc2sgd2h5IHlvdSByZW1vdmVkIHRoaXMsIGJ1
dCB5ZWFoLCBjbGVhbmluZyB0aGlzIHVwIHRvCm5vdCB1c2UgdWJkMCBmb3IgaG9zdGZzIGlzIHBy
b2JhYmx5IGEgZ29vZCBpZGVhLiBBdCBsZWFzdCBkb2N1bWVudGF0aW9uCihyZWNvbW1lbmRhdGlv
bikgd2lzZSAuLi4KCj4gIFRoZW4geW91IG5lZWQgdG8gY2hvd24gdG8geW91cnNlbGYgYWxsIHRo
ZSBmaWxlcyBpbiB0aGF0IGRpcmVjdG9yeQo+IC10aGF0IGFyZSBvd25lZCBieSByb290LiAgVGhp
cyB3b3JrZWQgZm9yIG1lOjoKPiArdGhhdCBhcmUgb3duZWQgYnkgcm9vdCBzbyB0aGF0IHRoZSBr
ZXJuZWwgY2FuIGFjY2VzcyB0aGVtLgo+ICtUaGlzIHdvcmtlZCBmb3IgbWU6Ogo+ICAKPiAtICAg
IyAgZmluZCAuIC11aWQgMCAtZXhlYyBjaG93biBqZGlrZSB7fSBcOwo+ICsgICAjICBmaW5kIHVt
bF9yb290X2RpciAtdWlkIDAgLW5vdCAtdHlwZSBsIC1leGVjIGNob3duIGpkaWtlIHt9IFw7Cj4g
IAo+ICBOZXh0LCBtYWtlIHN1cmUgdGhhdCB5b3VyIFVNTCBrZXJuZWwgaGFzIGhvc3RmcyBjb21w
aWxlZCBpbiwgbm90IGFzIGEKPiAtbW9kdWxlLiAgVGhlbiBydW4gVU1MIHdpdGggdGhlIGJvb3Qg
ZGV2aWNlIHBvaW50aW5nIGF0IHRoYXQgZGlyZWN0b3J5OjoKPiArbW9kdWxlLiAgVGhlbiBydW4g
VU1MIHdpdGggdGhlIGFwcHJvcHJpYXRlIGtlcm5lbCBjb21tYW5kIGxpbmUKPiArcGFyYW1ldGVy
czo6Cj4gIAo+IC0gICB1YmQwPS9wYXRoL3RvL3VtbC9yb290L2RpcmVjdG9yeQo+ICsgICByb290
ZnN0eXBlPWhvc3RmcyBydyBob3N0ZnM9dW1sX3Jvb3RfZGlyLHhhdHRycGVybQo+ICAKPiAtVU1M
IHNob3VsZCB0aGVuIGJvb3QgYXMgaXQgZG9lcyBub3JtYWxseS4KPiArWW91IHNob3VsZCBoYXZl
IGV4dGVuZGVkIGF0dHJpYnV0ZXMgc3VwcG9ydGVkIGFuZCBlbmFibGVkIG9uCj4gK3lvdXIgaG9z
dCBmaWxlc3lzdGVtIHNpbmNlIFVNTCB1c2VzIHRoZW0gdG8gc3RvcmUgY29ycmVjdCBmaWxlCj4g
K3Blcm1pc3Npb25zLgoKSSdtIG5vdCByZWFsbHkgc3VyZSB3ZSBzaG91bGQgYmFzaWNhbGx5IHNh
eSBpbiB0aGUgZG9jdW1lbnRhdGlvbiB0aGF0CiJ0aGUgd2F5IiB0byBydW4gaXQgaXMgd2l0aCB4
YXR0cnBlcm0/IElPVywgd2h5IG5vdCBqdXN0IGFkZCBhIG5ldwpwYXJhZ3JhcGggdGhhdCBleHBs
YWlucyB0aGF0IChhbmQgaG93KSB5b3UgY2FuIGFkZCB4YXR0cnBlcm0sIGFuZCB3aGF0Cml0IGRv
ZXM/Cgpqb2hhbm5lcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=

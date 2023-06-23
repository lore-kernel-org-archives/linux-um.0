Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BF1EB64D7
	for <linux-um@archiver.kernel.org>; Fri, 23 Jun 2023 08:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sytVD5i094GhXKWBjQdj4YcGLKYJOBeOKQRgMjEU11s=; b=RWG4XiXMCx5F0P
	6fjesTvfn7Ukla8GVrqt4icSCUbWr+NmNavbqNKvay2JVE6R8U0InZAKD6LfrWKQY39Q8yzr8FcL9
	ZkzTCJjbICAU6WRp2ir1JdygCYd6dONPou9ysF/UAAMBIv1Sm+ep/8sWYVRUPGPJO6FF/wBcDdbbU
	QSFx6clOclrYD7vs9rDIkGKuvG65OEk+Dsiv1YA3HH90dFL60UNa/vm7o98D66EDMvIiLr40WreMR
	n0PaGSHivIvdkD9fwnBAICo4oltmr4KugBKNBsNd+UQamRTaL8CX2TmJnMCq53UlsNUE8HS9waLVt
	fAZCqyXudk+HAWddaFMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qCc9h-002vH6-10;
	Fri, 23 Jun 2023 08:28:33 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCc9d-002vG1-2P
	for linux-um@lists.infradead.org;
	Fri, 23 Jun 2023 08:28:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=AjZZPIghCxIqXCKtuZnmkAJSIMTkuJoOr0lRMEsH48E=;
	t=1687508908; x=1688718508; b=igrSuIz1u8ITQo01q3IDcaGGE9kZaP73lUlTTuj34h5486M
	wpSXn7nIH8kPVJIy612XQSL5YjKWwlIvcZyTscZ1VFLHS0tRMaqG3rEi4cZvwp9EC6txatFV1wx3L
	mtYZkr0exCVKBFGu6iLhk9LBUqbJNJFTx/zG/Bt1+Rs7P6LDJD3dpu/gYiSDUtX7bGK4Y9hBoFM5k
	/cnWr37OlUCLGsHEasJ8h0gtJYGjQP7zJDVegBPXZ0qQZuhKD3masG9DmRdYCgan5RFoUzLjzne+e
	hbqLsNlki/bIOBctIFecKmwIHJjLBUiJ7D4DtmAy26lSx6K7v8+pahRLLloGv01w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1qCc9W-00FdjL-1m;
	Fri, 23 Jun 2023 10:28:22 +0200
Message-ID: <6f9200439992d70628412e73cbde79d05220e638.camel@sipsolutions.net>
Subject: Re: UML for arm64
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Richard Weinberger <richard@nod.at>
Cc: Johannes Berg <johannes@sipsolutions.net>, robh <robh@kernel.org>, anton
 ivanov <anton.ivanov@cambridgegreys.com>, linux-um
 <linux-um@lists.infradead.org>, Al Viro <viro@zeniv.linux.org.uk>
Date: Fri, 23 Jun 2023 10:28:20 +0200
In-Reply-To: <889626017.12829920.1687465410834.JavaMail.zimbra@nod.at>
References: <20230622192247.GA2278576-robh@kernel.org>
	 <dc5704a5d452f7432313170ed900975b2b72354f.camel@sipsolutions.net>
	 <69707b721698594f96899c050871bcbb3594a9a1.camel@sipsolutions.net>
	 <889626017.12829920.1687465410834.JavaMail.zimbra@nod.at>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230623_012829_988233_E9DAF355 
X-CRM114-Status: GOOD (  19.70  )
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

SEksCgpPbiBUaHUsIDIwMjMtMDYtMjIgYXQgMjI6MjMgKzAyMDAsIFJpY2hhcmQgV2VpbmJlcmdl
ciB3cm90ZToKPiBbU05JUF0KPiDCoAo+ID4gQXQgbGVhc3QgYSBsb3Qgb2YgdGhlIHJlZ2lzdGVy
IGhhbmRsaW5nLCBidXQgdGhhdCB3aWxsIGFsd2F5cyBiZQo+ID4gc29tZXdoYXQgYXJjaGl0ZWN0
dXJlIHNwZWNpZmljLgo+ID4gCj4gPiA+IC4uLiAsIHNvIHBlcmhhcHMgaXQnZCBiZSBlYXNpZXIg
dG8gc3RhcnQgd2l0aCB0aGUgc2VjY29tcC1iYXNlZCBtb2RlbDoKPiA+ID4gCj4gPiA+IGh0dHBz
Oi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC9saW51eC11bS9saXN0Lz9zZXJpZXM9MzI5
NDY2Cj4gPiA+IAo+ID4gPiBCdXQgdGhhdCdzIG5vdCByZWFsbHkgZG9uZSB5ZXQgZWl0aGVyLgo+
ID4gCj4gPiBZZXMsIHRob3VnaCBJIGhhdmUgcXVpdGUgc29tZSB1cGRhdGVzIGxvY2FsbHkgdGhh
dCBzb2x2ZSB0aGUgc2VjdXJpdHkKPiA+IGlzc3VlcyAoaS5lLiBwcmV2ZW50IGhvc3Qgc3lzY2Fs
bHMgZnJvbSB1c2Vyc3BhY2UpLiBTbywgaXQgZG9lcyBuZWVkCj4gPiByZWJhc2luZyBhbmQgSSBh
bSBzdXJlIGJ1Z2ZpeGVzLCBidXQgSSB0aGluayBpdCBpcyBnZXR0aW5nIGludG8gYQo+ID4gcHJl
dHR5IGdvb2Qgc2hhcGUgb3ZlcmFsbC4KPiA+IAo+ID4gRWl0aGVyIHdheSwgdGhlIG9sZCBwYXRj
aHNldCB3aWxsIGdpdmUgeW91IGEgZ29vZCBpZGVhIGFib3V0IGhvdyBpdCBhbGwKPiA+IHdvcmtz
LCB0aGUgY2hhbmdlcyBhcmUgbW9zdGx5IGluIHRoZSBkZXRhaWxzLiBJIGFtIGhhcHB5IHRvIHB1
c2ggb3V0IGEKPiA+IG5ldyB2ZXJzaW9uIHNvb25lciByYXRoZXIgdGhhbiBsYXRlciBpZiBpdCBt
aWdodCBoZWxwIHdpdGggYW55IGVmZm9ydHMKPiA+IG9uIHlvdXIgc2lkZS4KPiAKPiBJIHRoaW5r
IHJldml2aW5nIHRoZSBzZWNjb21wIHBhdGNoIHNldCBpcyBhIGdvb2QgaWRlYSBpbiBhbnkgY2Fz
ZS4KPiBNYXliZSBpdCBpcyBldmVuIGEgd2F5IHRvIGFsbG93IFNNUCBzdXBwb3J0LgoKT0ssIEkn
bGwgc2VlIGFib3V0IHJlc3VibWl0dGluZyB0aGUgU0VDQ09NUCBwYXRjaHNldC4KCkFib3V0IFNN
UCBzdXBwb3J0LCBpdCBpcyB0cmlja3kgaWYgb25lIHdhbnRzIHRvIGRvIGl0IHNhZmVseS4gRG9p
bmcgaXQKaW4gYW4gdW5zYWZlIHdheSBpcyBwcm9iYWJseSByZWFzb25hYmx5IHN0cmFpZ2h0IGZv
cndhcmQgYXMgeW91IGNhbgpzaW1wbHkgbWFwIG11bHRpcGxlIHN0dWItZGF0YSBhcmVhcyBpbnRv
IHRoZSBzYW1lIHByb2Nlc3MuIEhvd2V2ZXIsIHRoZQpvdGhlciB0aHJlYWRzIGNhbiByZWFkL3dy
aXRlIG1lbW9yeSBhdCB0aGUgc2FtZSB0aW1lLCB3aGljaCBicmVha3MgdGhlCmVudGlyZSBtZW1v
cnkgc2VjdXJpdHkgbW9kZWwgdGhhdCBJIGhhZCBpbiBtaW5kIGZvciBTRUNDT01QIG1vZGUuIE15
CmFwcHJvYWNoIHRoZXJlIGhlYXZpbHkgcmVsaWVzIG9uIGtpbGxpbmcgdGhlIHByb2Nlc3MgKmFm
dGVyKiBpdCBtYXBwZWQKbWVtb3J5IHdpdGhvdXQgcGVybWlzc2lvbiwgYnV0IGJlZm9yZSB0aGlz
IGNhbiBiZSBleHBsb2l0ZWQuCgpTbywgSSBmZWFyIG5vIHNpbXBsZSBhbmQgc2VjdXJlIFNNUCBz
dXBwb3J0LiBIYXZpbmcgdG8gZG8gaG9zdCBzeXNjYWxscwpmcm9tIHRoZSB1c2Vyc3BhY2UgcHJv
Y2VzcyBtZWFucyB0aGF0IHlvdSBqdXN0IGNhbm5vdCBoYXZlIGFub3RoZXIKdGhyZWFkIHJ1bm5p
bmcuIEFuZCB0aGVuLCB5b3UgYXJlIHN0dWNrIHdpdGggbXVsdGlwbGUgcHJvY2Vzc2VzIGFuZCB0
aGUKaGVhZGFjaGUgYW5kIG92ZXJoZWFkIG9mIGtlZXBpbmcgdGhlaXIgbWVtb3J5IGluIHN5bmMu
CgpJIHRoaW5rIHNlY3VyZSBTTVAgd2Ugd291bGQgbmVlZCBzb21lIG90aGVyIG5ldyBhbmQgZXhj
aXRpbmcgYXBwcm9hY2gKZm9yIGhhbmRsaW5nIHByb2Nlc3MgbWVtb3J5LiBBbiBleGFtcGxlIGNv
dWxkIGJlIGEgc3BlY2lhbCAobWVtb3J5KQpmaWxlIHN5c3RlbSBvbiB0aGUgaG9zdCB0aGF0IGV4
cGxpY2l0bHkgYWxsb3dzIHNldHRpbmcgdXAgcGFnZSByYW5nZXMKdG8gYmUgdHJhbnNwYXJlbnRs
eSBzaGFyZWQgYmV0d2VlbiBmaWxlcy4KCkJlbmphbWluCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1A
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LXVtCg==

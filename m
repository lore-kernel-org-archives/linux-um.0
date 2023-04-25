Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB416C6FD18
	for <linux-um@archiver.kernel.org>; Tue, 25 Apr 2023 17:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SdOaxNlaPwncKfE2zDXYl/wEJ9PBme+tB9PxKSRb66U=; b=vWleoRZ3nvLDHf
	C5vmlYqp/IixHWkM0Dqa8aSDXe4HTada3LjDQpHj9OMKcNv+vA6KsCH7/o4qkdGUQvzQZUIbx1qwI
	eEfdm9SxlLVLdBFZnYgTBeorh7N5sWsUHYEmSwv4oyma6h8fEs5b98hTOCpMp2fa0jA9c5t+bWjgc
	ddiWCn38BiI0Arv78M5Pt+esH7zM3tbkZ1zPucBc8UeCEYNBPlv6VtZG6bJMwyQwUGXisCmjr3bF1
	ipMnszgug0HBk37ZzQikxhfpBD+O2NK0EJI9wGd7oIQeGAJ4AFfWPxQGF7J3r0Jn0fmadCXxJxEcw
	pohv5ShK+4WtPmIOmRvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prMCU-001mQh-30;
	Tue, 25 Apr 2023 17:11:34 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prMCR-001mPR-2W
	for linux-um@lists.infradead.org;
	Tue, 25 Apr 2023 17:11:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HjWKh5yCzEaCAQ/4n3XrQJGtZdmCC06AI516E17j7Q8=;
	t=1682442688; x=1683652288; b=HT3rIFlClNML7MeFBZDpfekZMD89ExTGSF/NIFig7OUvTwI
	fIPdm3xXEigUOf53MUOXaPrlSt2xiBJkZMz33UjCol3bbeG58ltjDoY0bBetYC0SuMjmwV3QGBooP
	Fv5STW/Ci/YD8//0sK5wct2PG36pOyH/8HtLZ1NjSmuM7cv+6tIFaSyS91FNgMKlcO56/HTj+80dT
	fSR4cAZgrEIE35XyovRYETfT6O/oAwHiyQa4ppovGlLhWJ2/Zsbak0o7sfI73uG74R0XK7Rak2+xG
	4nN3T0RtcLI9dET/XCahY6hA+auxF0I5+e1Fp4BGUb6XznSR60gVNKkGNB2mwjKg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1prMCM-008Hft-1F;
	Tue, 25 Apr 2023 19:11:26 +0200
Message-ID: <921ccb8824c350bcc63bf97d3fe53bbbe8907cc5.camel@sipsolutions.net>
Subject: Re: [PATCH v3 2/2] hostfs: store permissions in extended attributes
From: Johannes Berg <johannes@sipsolutions.net>
To: Marko =?UTF-8?Q?Petrovi=C4=87?= <petrovicmarko2006@gmail.com>, 
	linux-um@lists.infradead.org
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com
Date: Tue, 25 Apr 2023 19:11:25 +0200
In-Reply-To: <CS5ZE898WMR0.153HXDH3AHACG@laptop-fedora>
References: <20230413223024.11513-1-petrovicmarko2006@gmail.com>
	 <20230415164821.166606-1-petrovicmarko2006@gmail.com>
	 <CRYCSOJIMYCY.3UJQ3W04LGKK7@laptop-fedora>
	 <9811ef569aac8a2f2ff5a9f2d1039b5d041f6377.camel@sipsolutions.net>
	 <CS5ZE898WMR0.153HXDH3AHACG@laptop-fedora>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230425_101131_818905_A5AAD27F 
X-CRM114-Status: GOOD (  28.00  )
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

T24gVHVlLCAyMDIzLTA0LTI1IGF0IDE4OjM1ICswMjAwLCBNYXJrbyBQZXRyb3ZpxIcgd3JvdGU6
Cj4gPiBJdCBzZWVtcyB0aGF0IF9tYXliZV8sIHNpbWlsYXIgdG8gdGhlICdob3N0ZnMnIGtlcm5l
bCBhcmd1bWVudCwgdGhlcmUKPiA+IHNob3VsZCBiZSBhIHdheSB0byBjb250YWluIHRoZSBzZXQg
b2Ygb3B0aW9ucz8KPiA+IAo+ID4gV2hhdCBkbyBJIG1lYW4gYnkgdGhhdD8gSSBtZWFuIHRoYXQg
dG9kYXksIHRoZSBpbnNpZGUgb2YgdGhlIHZpcnR1YWwKPiA+IG1hY2hpbmUgKGZvciBsYWNrIG9m
IGEgYmV0dGVyIHdvcmQpIGNhbiBvbmx5IG1vdW50IG91dHNpZGUgZm9sZGVycyB0aGF0Cj4gPiBh
cmUgY29udGFpbmVkIGluIHRoZSBmb2xkZXIgaW5kaWNhdGVkIGJ5IHRoZSAnaG9zdGZzJyBhcmd1
bWVudC4KPiA+IFNpbWlsYXJseSwgcGVyaGFwcyB0aGUgIm91dHNpZGUgYWRtaW5pc3RyYXRvciIg
c2hvdWxkIGJlIGFibGUgdG8KPiA+IGluZGljYXRlIHRoYXQgeGF0dHIgcGVybWlzc2lvbnMgX211
c3RfIGJlIHVzZWQsIG9yIF9tdXN0IG5vdF8gYmUgdXNlZD8KPiBOaWNlIG9ic2VydmF0aW9uLiBJ
dCBzaG91bGRuJ3QgYmUgaGFyZCB0byBkbyB0aGlzLCBJIGNhbiBqdXN0IGNoYW5nZQo+IHRoZSBp
bnRlcnByZXRlZCBtZWFuaW5nIG9mIG1udF91c2VfeGF0dHIgYW5kIGhvc3Rmc19mc19pbmZvLT51
c2VfeGF0dHIKPiB0byBjb21wbHkgd2l0aCB0aGlzIGJlaGF2aW9yLiBUaGFua3MgZm9yIGJyaW5n
aW5nIHRoaXMgdG8gYXR0ZW50aW9uLgo+ID4gCj4gPiBXaGljaCB3b3VsZCBpbXBseSBhIG5ldyBr
ZXJuZWwgYXJndW1lbnQgdGhhdCBjYW4gYmUgY29uZmlndXJlZCB0byAiZm9yY2UKPiA+IHVzZSIs
ICJmb3JjZSBkb24ndCB1c2UiIGFuZCAiZG9uJ3QgY2FyZSIsIHdpdGggcGVyaGFwcyBldmVuIGZv
ciBiYWNrd2FyZAo+ID4gY29tcGF0aWJpbGl0eSB0aGUgZGVmYXVsdCBiZWluZyAiZm9yY2UgZG9u
J3QgdXNlIj8KPiA+IAo+ID4gTm90IHN1cmUuIEFudG9uPyBSaWNoYXJkPyBBbnkgb3BpbmlvbnM/
Cgo+IE1heWJlIHhhdHRycGVybSBhbmQgbm94YXR0cnBlcm0gY2FuIGJlIGtlcm5lbCBjb21tYW5k
IGxpbmUgYXJndW1lbnRzCj4gdXNlZCBmb3IgImZvcmNlIHVzZSIgYW5kICJmb3JjZSBkb24ndCB1
c2UiIGFuZCB3aGVuIG5vbmUgaXMgc3BlY2lmaWVkLAo+IHRoZSBiZWhhdmlvciBjb3VsZCBiZSAi
ZG9uJ3QgY2FyZSIgd2hpY2ggd291bGQgdGh1cyBiZSB0aGUgZGVmYXVsdC4KClJpZ2h0LiBBY3R1
YWxseSBub3cgbG9va2luZyBhdCB0aGlzIGFnYWluLCB0aGV5IHNob3VsZCBwcm9iYWJseSBiZSBm
bGFncwppbnNpZGUgdGhlIGhvc3Rmcz0gYXJndW1lbnQ/IExpa2UgdGhlICJhcHBlbmQiIGZsYWcg
bm93LgoKTm90IHJlYWxseSBzdXJlIHdoYXQgdGhlIGRlZmF1bHQgc2hvdWxkIGJlLCBwZXJoYXBz
IGl0IG1ha2VzIHNlbnNlIHRvCm5vdCBhbGxvdyBpdCBieSBkZWZhdWx0IHNvIGl0J3MgdGhlIHNh
bWUgYXMgbm93PyBCdXQgSSBkb24ndCBrbm93IGhvdwpzdHJpY3Qgd2UgbmVlZCB0byBiZSBhYm91
dCB0aGlzLgoKPiBUaGF0IG1heSBhbHNvIGJlIHJlYXNvbmFibGUgZm9yIHRoZSBwdXJwb3NlIG9m
IGJhY2t3YXJkIGNvbXBhdGliaWxpdHkKPiBzaW5jZSB0aGUgdXNhZ2Ugb2YgZXh0ZW5kZWQgYXR0
cmlidXRlcyB3b3VsZCB0aGVuIGJlIHNwZWNpZmllZCBhcyBhbiBtb3VudAo+IG9wdGlvbiBhbmQg
YXBwbGljYXRpb25zIG5vdCBhd2FyZSBvZiBpdCB3b3VsZCBqdXN0IHVzZSB0aGUgb2xkIGJlaGF2
aW9yCj4gKHNpbmNlIHRoZSBleHRlbmRlZCBhdHRyaWJ1dGVzIHdvdWxkIGJlIHVzZWQgb25seSB3
aGVuIHNwZWNpZmllZCBpbgo+IG1vdW50IG9wdGlvbnMpLgoKUmlnaHQuIEkgd2FzIG1vcmUgdGhp
bmtpbmcgb2YgdGhlIGlzb2xhdGlvbiBhc3BlY3RzIG9mIHRoaXMuCgo+IE9uIHRoZSBvdGhlciBo
YW5kLCB0aGF0IHdvdWxkIHJlcXVpcmUgYSBsaXR0bGUgZGlmZmVyZW50IG1vdW50aW5nIG9mCj4g
cm9vdCBmaWxlc3lzdGVtLiBNYXliZSBhZGRpbmcgcm9vdHhhdHRycGVybSBhcyBhIG5ldyBrZXJu
ZWwgY29tbWFuZCBsaW5lCj4gYXJndW1lbnQgZm9yIG1vdW50aW5nIHJvb3Qgd2l0aCAicm9vdGZz
dHlwZT1ob3N0ZnMgaG9zdGZzPXJvb3R4YXR0cnBlcm0iCj4gY291bGQgYmUgdGhlIHNvbHV0aW9u
IChmb3Igd2hlbiByb290IHNob3VsZCB1c2UgZXh0ZW5kZWQgYXR0cmlidXRlcywgYnV0Cj4gdGhl
IGdlbmVyYWwgYmVoYXZpb3Igc2hvdWxkIHN0aWxsIGJlICJkb24ndCBjYXJlIik/Cj4gV2hhdCBh
cmUgeW91ciBvcGluaW9ucz8KCk9oLCB0aGF0J3MgYSBnb29kIHBvaW50IHRvby4gSSBkb24ndCB0
aGluayBJIGhhdmUgbXVjaCBvZiBhbiBvcGluaW9uIG9uCml0IHRob3VnaC4gQnV0IHllYWgsIHdo
eSBub3QgaGF2ZSBhbm90aGVyIGZsYWcgInJvb3R4YXR0cnBlcm0iIGZvciB0aGUKaG9zdGZzPSBv
cHRpb24sIGFsb25nIHdpdGggeGF0dHJwZXJtIGFuZCBub3hhdHRycGVybSAob3IgYWxsb3d4YXR0
cnBlcm0KYW5kIGZvcmNleGF0dHJwZXJtIGlmIHdlIG5lZWQgbm94YXR0cnBlcm0gdG8gYmUgdGhl
IGRlZmF1bHQgcGVyIGFib3ZlLikKCmpvaGFubmVzCgpQUzogTm90ZSB0aGF0IGluIHVtbC9uZXh0
IG15IHBhdGNoZXMgd2l0aCB0aGUgc3BsaXQgYXJlIG1lcmdlZCwgc28gd2hlbgp5b3UgcmViYXNl
IHBsZWFzZSByZWJhc2Ugb24gdGhhdCBhbmQgYWRqdXN0IGFjY29yZGluZ2x5IHdpdGggdGhlCmV4
cG9ydGVkIHN5bWJvbCB3ZSBkaXNjdXNzZWQuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LXVtCg==

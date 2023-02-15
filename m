Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4AE1C636CC
	for <linux-um@archiver.kernel.org>; Wed, 15 Feb 2023 08:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DBGrFyQune74kQuiB1Hgr9vIj//1p9Ox2qR5644jKQg=; b=p1JPftd82Fc9YU
	NJ9zSs2U3gAImIhFtz9+gyHoAOG4k+fgyMzZ6vIq0EI6bNiZbX4mP/2yrjurcIFmf12V6ReCBzT5j
	AX/jV3tdvNbJANV9/vPewj6BPat7Opa3AC55M9mfDM8inO+aVAUimAmLdPLnXSCCT61y7BnFx1RMn
	pPi1QQJnif24vMv0TaSNgGhGp78B+euXzU9hKxs5htYXMNfTqvomBOiIaLcULZ0F2m2uvE6repfqt
	ElVy2v3Jg/Py1iRkVIaWBbnwaJaz7XuhU7zQw8KTBv0ewcKrMBxNvZXjYlQbdVMgw71GfKAo4jP36
	k+mtLyLD97MwkaIWQfAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSCvM-0059IG-8K; Wed, 15 Feb 2023 08:13:56 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSCvJ-0059GN-4d
	for linux-um@lists.infradead.org; Wed, 15 Feb 2023 08:13:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=mo1cLpGdKDY4uulgiNcnFm0Ec2uXKdttKXI4poEPOf8=;
	t=1676448831; x=1677658431; b=sGZObCeGMMj356MQWltPgZXv8y97iNBp+d0MYA/JEBOcJKY
	8gfn5FkghydB1X46t1GTFeAqMqoGxMkO2dL8bD9HJtvNmLNOhCoIe6W4IKPzyNAckLnVzmEV73K1a
	kSDoRY+trFSqG6Tiow/L3Mo1zMViKxoXn/4d9gWWZ3fIZdkmUweDK0e423DxBSjeoRSJTGaq3cc+g
	9n977/vVkumyA3JCOVQC1MOtW0ZvuymnJrilFUwuPdIHOfoAh8YDVn63F5MLRL3euuNjCBXEByW6Y
	fbsfA0AygR8EkeUSUGwsZsj5Uq9GT+wJCEjajGB2HFCF+DdvXK17Gnd1hcBHkP6g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1pSCv9-00CypS-0k;
	Wed, 15 Feb 2023 09:13:43 +0100
Message-ID: <b4bacb46e3a18c1f8d66d25f946dae09ccfcdc4f.camel@sipsolutions.net>
Subject: Re: [PATCH V1] um: Fix compilation warnings
From: Johannes Berg <johannes@sipsolutions.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Srinivasarao Pathipati
	 <quic_c_spathi@quicinc.com>
Cc: Richard Weinberger <richard@nod.at>, anton ivanov
 <anton.ivanov@cambridgegreys.com>, linux-um <linux-um@lists.infradead.org>,
  linux-kernel <linux-kernel@vger.kernel.org>
Date: Wed, 15 Feb 2023 09:13:36 +0100
In-Reply-To: <CAMuHMdUb9cduEae2vzX8LeVG7z0nRrKHrQN6UGJ_YLuWOBbKOg@mail.gmail.com>
References: <1676410243-10566-1-git-send-email-quic_c_spathi@quicinc.com>
	 <1950127775.130646.1676411821807.JavaMail.zimbra@nod.at>
	 <913fea79-09f9-b976-ff1a-cd833784abb6@quicinc.com>
	 <CAMuHMdUb9cduEae2vzX8LeVG7z0nRrKHrQN6UGJ_YLuWOBbKOg@mail.gmail.com>
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230215_001353_203204_33DCDD20 
X-CRM114-Status: GOOD (  20.82  )
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

T24gV2VkLCAyMDIzLTAyLTE1IGF0IDA5OjA3ICswMTAwLCBHZWVydCBVeXR0ZXJob2V2ZW4gd3Jv
dGU6Cj4gSGkgU3Jpbml2YXNhcmFvLAo+IAo+IE9uIFdlZCwgRmViIDE1LCAyMDIzIGF0IDY6MzYg
QU0gU3Jpbml2YXNhcmFvIFBhdGhpcGF0aQo+IDxxdWljX2Nfc3BhdGhpQHF1aWNpbmMuY29tPiB3
cm90ZToKPiA+IE9uIDIvMTUvMjAyMyAzOjI3IEFNLCBSaWNoYXJkIFdlaW5iZXJnZXIgd3JvdGU6
Cj4gPiA+IC0tLS0tIFVyc3Byw7xuZ2xpY2hlIE1haWwgLS0tLS0KPiA+ID4gPiBWb246ICJTcmlu
aXZhc2FyYW8gUGF0aGlwYXRpIiA8cXVpY19jX3NwYXRoaUBxdWljaW5jLmNvbT4KPiA+ID4gPiBz
dGF0aWMgdm9pZCBzaWdfaGFuZGxlcl9jb21tb24oaW50IHNpZywgc3RydWN0IHNpZ2luZm8gKnNp
LCBtY29udGV4dF90ICptYykKPiA+ID4gPiB7Cj4gPiA+ID4gLSAgICBzdHJ1Y3QgdW1sX3B0X3Jl
Z3MgcjsKPiA+ID4gPiArICAgIHN0cnVjdCB1bWxfcHRfcmVncyAqcjsKPiA+ID4gPiAgICAgIGlu
dCBzYXZlX2Vycm5vID0gZXJybm87Cj4gPiA+ID4gCj4gPiA+ID4gLSAgICByLmlzX3VzZXIgPSAw
Owo+ID4gPiA+ICsgICAgciA9IG1hbGxvYyhzaXplb2Yoc3RydWN0IHVtbF9wdF9yZWdzKSk7Cj4g
PiA+IEkgZmVhciB0aGlzIGlzIG5vdCBjb3JyZWN0IHNpbmNlIG1hbGxvYygpIGlzIG5vdCBhc3lu
Yy1zaWduYWwgc2FmZS4KPiA+IAo+ID4gVGhhbmtzIFJpY2hhcmQgZm9yIHF1aWNrIHJlc3BvbnNl
LiBDb3VsZCB5b3UgcGxlYXNlIHN1Z2dlc3QgYWx0ZXJuYXRpdmUKPiA+IGZ1bmN0aW9uIG9mIG1h
bGxvYygpIHdpdGggYXN5bmMtc2lnbmFsIHNhZmUuCj4gPiAKPiA+IGlmIHRoYXQgaXMgbm90IHBv
c3NpYmxlIElzIHRoZXJlIGFueSBvdGhlciB3YXkgdG8gZml4IHRoaXMgd2FybmluZz8gT1IKPiA+
IGRvIHdlIG5lZWQgdG8gbGl2ZSB3aXRoIHRoYXQgd2FybmluZz8KPiAKPiBEb2VzIHRoaXMgbGlt
aXQgYWN0dWFsbHkgYXBwbHkgdG8gdGhpcyBmaWxlLCB3aGljaCBjYWxscyBpbnRvIHRoZSBob3N0
IE9TPwoKTm90IHJlYWxseS4gQWxzbywgd2Uga25vdyB3ZSBoYXZlIGEgc2lnbmFsIHN0YWNrIHRo
YXQncyBsYXJnZSBlbm91Z2gsCnNpbmNlIHdlIHNldCBpdCB1cCBvdXJzZWx2ZXM6CgogICAgICAg
ICAgICAgICAgc2V0X3NpZ3N0YWNrKCh2b2lkICopIFNUVUJfREFUQSwgVU1fS0VSTl9QQUdFX1NJ
WkUpOwoKYW5kIGl0J3MgYSBmdWxsIHBhZ2UsIHNvIGV2ZW4gdGhlIE9TIGVhdGluZyB1cCBzb21l
IG9mIHRoYXQgd29uJ3QgY2F1c2UKdXMgYW55IHRyb3VibGUuIFdlIGRvIGhhdmUgc29tZXdoYXQg
ZGVlcCBjYWxscyBpbnRvIGRvX0lSUSgpIGJ1dCB0aG9zZQpyZWFsbHkgc2hvdWxkbid0IHVzZSBt
dWNoIHN0YWNrIHNwYWNlIHNpbmNlIHRoZXkgY2FuIChpbiBub24tVU0ga2VybmVscykKYmUgY2Fs
bGVkIG9uIHRvcCBvZiBhcmJpdHJhcnkga2VybmVsIHN0YWNrcyBhbHJlYWR5LgoKPiBIb3cgY29t
ZSB5b3UgZXZlbiBzZWUgdGhpcyB3YXJuaW5nLCBhcyB3ZSBoYXZlCj4gCj4gICAgIENGTEFHU19z
aWduYWwubyArPSAtV2ZyYW1lLWxhcmdlci10aGFuPTQwOTYKPiAKPiBzaW5jZSBjb21taXQgNTE3
ZjYwMjA2ZWU1ZDVmNyAoInVtOiBJbmNyZWFzZSBzdGFjayBmcmFtZSBzaXplIHRocmVzaG9sZAo+
IGZvciBzaWduYWwuYyIpIGluIHY1LjExPwo+IAoKR29vZCBxdWVzdGlvbiwgSSBkb24ndCBzZWUg
aXQuIEhvd2V2ZXIgd2UgcHJvYmFibHkgc2hvdWxkIG1ha2UgdGhhdCBhCl9iaXRfIHNtYWxsZXIg
c2luY2Ugd2Ugb25seSBoYXZlIGEgcGFnZSBhbmQgc3RpbGwgbmVlZCB0byBjYWxsIGRvX0lSUSgp
CmFuZCBhbGwuCgpqb2hhbm5lcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11
bQo=

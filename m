Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E5CC7EE29
	for <linux-um@archiver.kernel.org>; Wed,  7 Jun 2023 09:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ewwlTrpNwHjhjEi0PXpvbD3h6Fih4pky2vT+LwsyZwg=; b=CBtwNrCD1GNuSh
	dhziCvKo1FzKY6nBlrB8sEH0SGPwXGkmsxd9i9YIL+E4clcsG1ssgc8SZp5Rm1N6Cq4llfPZ8aXvk
	VYwAHVqN0QaVv9/mrz/3x256Wg40O9ZTY4aYqRYWEY4F9wWJ5tp9tZx00s7Ss912bGYTCqzf9U0fz
	4HtaxSYm7a4KL8pg7RvyrIfj/buBufh7tJqwgWvh8xAcAbRNzEADV6aGKVH6oMWGH+q+e+/fsAxbq
	1ldNqZkzyMTYI08xzno0FiUnnBtX+KpKempS6LvtUpkzIgrU64O/5y+z8bvNLKOvcTycjhK+/YH0Z
	vujQokVelYTqnjKNTegg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6pIx-005CSB-38;
	Wed, 07 Jun 2023 09:18:11 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6pIu-005CRb-2B
	for linux-um@lists.infradead.org;
	Wed, 07 Jun 2023 09:18:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=/N4iQQzhKXwMLpsqAX/ldRXHvjdWxI/sMibJLHmuUyE=;
	t=1686129488; x=1687339088; b=cvq9qUz4YUvcDRsp/48uqKlimpmLL4HVZwFQf1NRS1+/OXl
	ShjxxZp6MESNLDwvFrOMOGWqD++scXwSioBMUOLxLZ6rLO3GvgZINxCPOeHFmck6DVOh6rN4Xuqx0
	kmeTAXH29TI/W/ocXcJLdea7lCn/NvR3qLJoNzuQn8FA+yZNZ1SJb9iggLQh6n6uCentKeW4Mc2HM
	eXnr+Hs3kgr0v0lylMTApb+qd6llVp8oXF56nqq3WwP1gdfWWZdK8z2uQtvSRTOeEw8YZG4RP5C6A
	KpuGMYYXwqVwvkUif7ySZMnMj/hjiDB334TFuqlNzu0yRZ04tWBIV8I66neHIZHg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1q6pIh-00GUej-1M;
	Wed, 07 Jun 2023 11:17:55 +0200
Message-ID: <a953b19efca20b470759b1d53beb957a11062ba1.camel@sipsolutions.net>
Subject: Re: Reported-by/Closes tag for uncommitted issues (was: Re: [PATCH
 v2] uml: Replace strlcpy with strscpy)
From: Johannes Berg <johannes@sipsolutions.net>
To: Philip Li <philip.li@intel.com>, Richard Weinberger <richard@nod.at>
Cc: Eric Biggers <ebiggers@kernel.org>, Azeem Shaikh
 <azeemshaikh38@gmail.com>,  Maxim Krasnyansky <maxk@qti.qualcomm.com>,
 anton ivanov <anton.ivanov@cambridgegreys.com>, linux-hardening
 <linux-hardening@vger.kernel.org>, linux-kernel
 <linux-kernel@vger.kernel.org>,  linux-um <linux-um@lists.infradead.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, kernel test robot <lkp@intel.com>
Date: Wed, 07 Jun 2023 11:17:54 +0200
In-Reply-To: <ZIBJadzmheKWCErq@rli9-mobl>
References: <20230606182410.3976487-1-azeemshaikh38@gmail.com>
	 <1833651082.3690424.1686084717406.JavaMail.zimbra@nod.at>
	 <CADmuW3WzC61-si1j61kzwfx5EcsvSt4QBaY9VHiybBRWAN3yyA@mail.gmail.com>
	 <20230607042340.GA941@sol.localdomain>
	 <57443d420183b7a0bcab8041c2dfe3ba44e054f4.camel@sipsolutions.net>
	 <2092891129.3692555.1686126895090.JavaMail.zimbra@nod.at>
	 <ZIBJadzmheKWCErq@rli9-mobl>
User-Agent: Evolution 3.48.2 (3.48.2-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_021808_719804_8133F486 
X-CRM114-Status: GOOD (  22.43  )
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

T24gV2VkLCAyMDIzLTA2LTA3IGF0IDE3OjEwICswODAwLCBQaGlsaXAgTGkgd3JvdGU6Cj4gPiA+
IFNvIGl0IHNlZW1zIHdlIHNob3VsZCBhc2sgdGhlIHJvYm90IG1haW50YWluZXJzIHRvIGp1c3Qg
c3RvcCBzdWdnZXN0aW5nCj4gPiA+IHRob3NlIHRhZ3M/Cj4gPiAKPiA+IEFncmVlZC4KPiAKPiBU
aGFua3MgYWxsIGZvciB0aGUgZmVlZGJhY2suIFdlIHdpbGwgY2FyZWZ1bGx5IGNvbnNpZGVyIGhv
dyB0byBwcmVzZW50IHRoZQo+IHN1Z2dlc3Rpb24gY2xlYXJseS4KPiAKPiBGb3Igbm93LCBiZWNh
dXNlIHRoZSBib3QgY292ZXJzIGJvdGggdXBzdHJlYW0gYW5kIGRldmVsb3BlciByZXBvcywgdGhl
cmUKPiBjYW4gYmUgdmFyaW91cyBzaXR1YXRpb25zLCBzdWNoIGFzIHRoZSBidWcgaXMgZm91bmQg
aW4gdXBzdHJlYW0uwqAKCkFoIHllcywgdGhhdCB3YXMgYWN0dWFsbHkgaW4gbXkgbWluZCwgYnV0
IEkgZm9yZ290IHRvIHdyaXRlIGFib3V0IGl0LApzb3JyeS4KCkkgYWdyZWUgY29tcGxldGVseSwg
aW4gY2FzZSB0aGF0IHlvdSBmaW5kIGEgYnVnIGluIGFuIGFscmVhZHkgY29tbWl0dGVkCnRyZWUs
IGFuZCB0aGVyZSB3aWxsIGJlIGEgc2VwYXJhdGUgY29tbWl0IHRvIGZpeCBpdCwgaXQncyBjb21w
bGV0ZWx5CnJlYXNvbmFibGUgYW5kIHVzZWZ1bCB0byBoYXZlIHRob3NlIHRhZ3MuCgo+IFNvIHRo
ZSBib3QKPiB0cmllcyB0byBsZXQgYXV0aG9yIGRlY2lkZSBob3cgdG8gYXBwbHkgdGhlIHRhZ3Mg
aW4gYXBwcm9wcmlhdGUgd2F5IHRoYXQKPiB0aGV5IGZlZWwgY29tZm9ydGFibGUuCgpSaWdodC4g
SXQganVzdCBzZWVtcyB0aGF0IG1hbnkgYXV0aG9ycyBhcmVuJ3QgcmVhbGx5IGFsbCB0aGF0IGZh
bWlsaWFyCndpdGggdGhlIHByb2Nlc3NlcyB5ZXQsIGFuZCB0YWtlIHRoZSBzdWdnZXN0aW9uIGF0
IGZhY2UgdmFsdWUuCgo+IEluIHRoZSByZXBvcnQsIHdlIG5vdyB1c2VzIHBocmFzZXMgbGlrZSBi
ZWxvdwo+IAo+IAlJZiB5b3UgZml4IHRoZSBpc3N1ZSwga2luZGx5IGFkZCBmb2xsb3dpbmcgdGFn
IHdoZXJlIGFwcGxpY2FibGUKPiAJfCBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxr
cEBpbnRlbC5jb20+Cj4gCXwgQ2xvc2VzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9vZS1rYnVp
bGQtYWxsLzIwMjMwNTMxMTEzNS56R01UMWdZUi1sa3BAaW50ZWwuY29tLwo+IAo+IEJ1dCB0aGlz
IG1heSBiZSBub3QgY2xlYXIgZW5vdWdoIG9yIG5vdCB0aGUgYmVzdCB3YXkgdG8gc3VnZ2VzdC4g
V2Ugd2lsbAo+IGNvbnNpZGVyIHdoZXRoZXIgd2UgY2FuIGRldGVjdCBzb21lIHNpdHVhdGlvbnMg
KGxpa2UgUkZDIHBhdGNoKSB3aGljaCBpcwo+IG5vIG5lZWQgZm9yIHN1Y2ggdGFncyB0byBhdm9p
ZCBjb25mdXNpb24uCj4gCgpSaWdodC4gTWF5YmUgdGhlIG9ubHkgdGhpbmcgcmVhbGx5IG5lZWRl
ZCB3b3VsZCBiZSB0byBzYXkgc29tZXRoaW5nIGxpa2UKCiJJZiB5b3UgZml4IHRoZSBpc3N1ZSBp
biBhIHNlcGFyYXRlIHBhdGNoL2NvbW1pdCAoaS5lLiBub3QganVzdCBhIG5ldwp2ZXJzaW9uIG9m
IHRoZSBzYW1lIHBhdGNoL2NvbW1pdCksIGtpbmRseSBhZGQgLi4uIgoKb3IgZXZlbiBqdXN0Cgoi
SWYgeW91IGZpeCB0aGUgaXNzdWUgaW4gYSBzZXBhcmF0ZSBjb21taXQsIGtpbmRseSBhZGQgLi4u
IgoKc28gaXQncyBjbGVhciB0aGF0IGlmIHlvdSdyZSBjaGFuZ2luZyB0aGUgY29tbWl0LCBpdCdz
IG5vdCByZWFsbHkKc29tZXRoaW5nIHRoYXQgc2hvdWxkIGJlIGRvbmU/IEluIHdoaWNoIGNhc2Ug
cHJvYmFibHkgZXZlbiBhIEZpeGVzIHRhZwpzaG91bGQgYmUgdGhlcmUsIGJ1dCBJIHdvdWxkbid0
IHdhbnQgdG8gcmVjb21tZW5kIGFkZGluZyB0aGF0IHNpbmNlIHRoZQpjb21taXRzIG1heSBzdGls
bCBjaGFuZ2UgZXRjLgoKSSBkb24ndCBrbm93IGFsbCB0aGUgcHJvY2Vzc2VzIGJlaGluZCBpdCwg
YnV0IEknbSB0aGlua2luZyB0aGF0IGV2ZW4gaWYKdGhlIGJvdCBwaWNrZWQgdXAgYSBwYXRjaCBm
cm9tIHRoZSBsaXN0LCBpdCBjb3VsZCBnZXQgY29tbWl0dGVkIGJlZm9yZQphbmQgdGhlbiBmaXhl
ZCBpbiBhIHNlcGFyYXRlIGNvbW1pdC4KCmpvaGFubmVzCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1A
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LXVtCg==

Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED3F1C7EE31
	for <linux-um@archiver.kernel.org>; Tue, 23 May 2023 09:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5iFYzcQ4uMd3WJvPL+8gJtjxuXMQ+BHvcUy75GjMkIM=; b=P5sdKwv9+nIRBF
	jcHrVajZH8EiTPpMTye3b0Nus5ukcDWd5NsPn3pFUTUnlCIigl4htXTZGYUuigW0DUwIhzNY3hcDS
	92+JAhFRD7ymdE0o49X/P99R1XRfznM0AvBPU3BTdVAXcPfV6k3SZ0BzWPXvLQvAPs+5+ShAYwNGD
	oCRPsJrpBblWiDtlEmfGSkkC2A8ePlaPmGwDBiCqOHsLcfFHnET1zyBOhHRJ/4s3XaU9ob23K110/
	nI2eG6bQ5aZD+q0wfdGiAIa7bdwiMGtrVi3ebiwlOWzXWungE+jEMchKCW5LII0eOM7evlu6S8yOA
	z8CzCZY+mMPvTGqfGU+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q1OI5-009bwA-1E;
	Tue, 23 May 2023 09:26:49 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q1OI0-009buG-0c;
	Tue, 23 May 2023 09:26:46 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CB4FE2046A;
	Tue, 23 May 2023 09:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1684833998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VeeF7P+KGwlI3A5FT4CrZ0MRM4bqCgyOhKvZ384U0bw=;
	b=fmBOz2XQkJ4XHhSdGh/HXGxJtyCnKClPp4X6MRT6VR5eXrTQZK9h5N6Toqfk+0GeD98iT3
	ZDhHKznDkq0Y5mKvraQucwn+Wh9FeAeuFGHWgkercVl2rETq+mQKxe64zKr8IJWHxFZCKE
	O8heNaNMsvS9Ka+Y0g3mOKcA0+3rNN0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1684833998;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VeeF7P+KGwlI3A5FT4CrZ0MRM4bqCgyOhKvZ384U0bw=;
	b=zajPamxtH/5SGH5Qq9H7t7b5zBY3QOo+hV3Vqv/J4endm7d1fvc5Ztsv4d+st0dbhUYOxx
	LgejBO7uUF0wFbCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4FA5A13588;
	Tue, 23 May 2023 09:26:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id HfC5Es6GbGTEVAAAMHmgww
	(envelope-from <vbabka@suse.cz>); Tue, 23 May 2023 09:26:38 +0000
Message-ID: <c63dc769-e020-5a82-335e-11c992543a3a@suse.cz>
Date: Tue, 23 May 2023 11:26:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] mm/slab: rename CONFIG_SLAB to CONFIG_SLAB_DEPRECATED
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Vladimir Zapolskiy <vz@mleia.com>,
 Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Tony Lindgren <tony@atomide.com>, Qin Jian <qinjian@cqplus1.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Dinh Nguyen <dinguyen@kernel.org>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "David S . Miller" <davem@davemloft.net>, Richard Weinberger
 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
References: <20230523091139.21449-1-vbabka@suse.cz>
 <CAMuHMdWRZmA1iEG2aXdKZ+wWgSTgg-P7KY7pTTJx9EmvuEa58A@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAMuHMdWRZmA1iEG2aXdKZ+wWgSTgg-P7KY7pTTJx9EmvuEa58A@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230523_022644_523331_F9B93DCB 
X-CRM114-Status: GOOD (  16.88  )
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

T24gNS8yMy8yMyAxMToyMiwgR2VlcnQgVXl0dGVyaG9ldmVuIHdyb3RlOgo+IEhpIFZsYXN0aW1p
bCwKPiAKPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2ghCj4gCj4gT24gVHVlLCBNYXkgMjMsIDIwMjMg
YXQgMTE6MTLigK9BTSBWbGFzdGltaWwgQmFia2EgPHZiYWJrYUBzdXNlLmN6PiB3cm90ZToKPj4g
QXMgZGlzY3Vzc2VkIGF0IExTRi9NTSBbMV0gWzJdIGFuZCB3aXRoIG5vIG9iamVjdGlvbnMgcmFp
c2VkIHRoZXJlLAo+PiBkZXByZWNhdGUgdGhlIFNMQUIgYWxsb2NhdG9yLiBSZW5hbWUgdGhlIHVz
ZXItdmlzaWJsZSBvcHRpb24gc28gdGhhdAo+PiB1c2VycyB3aXRoIENPTkZJR19TTEFCPXkgZ2V0
IGEgbmV3IHByb21wdCB3aXRoIGV4cGxhbmF0aW9uIGR1cmluZyBtYWtlCj4+IG9sZGNvbmZpZywg
d2hpbGUgbWFrZSBvbGRkZWZjb25maWcgd2lsbCBqdXN0IHN3aXRjaCB0byBTTFVCLgo+Pgo+PiBJ
biBhbGwgZGVmY29uZmlncyB3aXRoIENPTkZJR19TTEFCPXkgcmVtb3ZlIHRoZSBsaW5lIHNvIHRo
b3NlIGFsc28KPj4gc3dpdGNoIHRvIFNMVUIuIFJlZ3Jlc3Npb25zIGR1ZSB0byB0aGUgc3dpdGNo
IHNob3VsZCBiZSByZXBvcnRlZCB0bwo+PiBsaW51eC1tbSBhbmQgc2xhYiBtYWludGFpbmVycy4K
PiAKPiBUZWNobmljYWxseSwgcmVtb3ZpbmcgdGhlc2UgbGluZXMgZnJvbSB0aGUgZGVmY29uZmln
IGZpbGVzIGRvZXMgbm90Cj4gaGF2ZSBhbnkgaW1wYWN0LCByaWdodD8KCldlbGwsIGl0IGRvZXNu
J3QsIGJ1dCBJIHRob3VnaHQgaXQncyBhdCBsZWFzdCBhIHVzZWZ1bCBoZWFkcy11cCBmb3IgdGhl
Cm1haW50YWluZXJzIGluIGNhc2Ugc29tZSBoYXZlIHNwZWNpZmljIHJlYXNvbnMgZm9yIGtlZXBp
bmcgU0xBQiB0aGVyZS4KCj4gQW5kIGl0IHJlbW92ZXMgb25lIG1vcmUgc3luYyBwb2ludCBpbmRp
Y2F0aW5nIHRoZSBsYXN0IHRpbWUgc29tZQo+IGRlZmNvbmZpZyBmaWxlcyB3ZXJlIChub3QpIHVw
ZGF0ZWQgYnkgdGhlaXIgbWFpbnRhaW5lcnMgOy0pCgpTdXJlLCBJIGNhbiBleGNsdWRlIHlvdXJz
IChhbmQgYW55b25lIGVsc2Ugd2hvJ2QgcHJlZmVyIHRoYXQpLCB0aGUgYWNrIG9uCnRoZSBkZXBy
ZWNhdGlvbiBpdHNlbGYgaXMgc3VmZmljaWVudC4KCj4+IFsxXSBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9hbGwvNGI5ZmM5YzYtYjQ4Yy0xOThmLTVmODAtODExYTQ0NzM3ZTVmQHN1c2UuY3ovCj4+
IFsyXSBodHRwczovL2x3bi5uZXQvQXJ0aWNsZXMvOTMyMjAxLwo+Pgo+PiBTaWduZWQtb2ZmLWJ5
OiBWbGFzdGltaWwgQmFia2EgPHZiYWJrYUBzdXNlLmN6Pgo+IAo+PiAgYXJjaC9tNjhrL2NvbmZp
Z3MvYW1pZ2FfZGVmY29uZmlnICAgICAgICAgICAgICAgfCAgMSAtCj4+ICBhcmNoL202OGsvY29u
Zmlncy9hcG9sbG9fZGVmY29uZmlnICAgICAgICAgICAgICB8ICAxIC0KPj4gIGFyY2gvbTY4ay9j
b25maWdzL2F0YXJpX2RlZmNvbmZpZyAgICAgICAgICAgICAgIHwgIDEgLQo+PiAgYXJjaC9tNjhr
L2NvbmZpZ3MvYnZtZTYwMDBfZGVmY29uZmlnICAgICAgICAgICAgfCAgMSAtCj4+ICBhcmNoL202
OGsvY29uZmlncy9ocDMwMF9kZWZjb25maWcgICAgICAgICAgICAgICB8ICAxIC0KPj4gIGFyY2gv
bTY4ay9jb25maWdzL21hY19kZWZjb25maWcgICAgICAgICAgICAgICAgIHwgIDEgLQo+PiAgYXJj
aC9tNjhrL2NvbmZpZ3MvbXVsdGlfZGVmY29uZmlnICAgICAgICAgICAgICAgfCAgMSAtCj4+ICBh
cmNoL202OGsvY29uZmlncy9tdm1lMTQ3X2RlZmNvbmZpZyAgICAgICAgICAgICB8ICAxIC0KPj4g
IGFyY2gvbTY4ay9jb25maWdzL212bWUxNnhfZGVmY29uZmlnICAgICAgICAgICAgIHwgIDEgLQo+
PiAgYXJjaC9tNjhrL2NvbmZpZ3MvcTQwX2RlZmNvbmZpZyAgICAgICAgICAgICAgICAgfCAgMSAt
Cj4+ICBhcmNoL202OGsvY29uZmlncy9zdW4zX2RlZmNvbmZpZyAgICAgICAgICAgICAgICB8ICAx
IC0KPj4gIGFyY2gvbTY4ay9jb25maWdzL3N1bjN4X2RlZmNvbmZpZyAgICAgICAgICAgICAgIHwg
IDEgLQo+IAo+IFJlZ2FyZGxlc3MsCj4gQWNrZWQtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2Vl
cnRAbGludXgtbTY4ay5vcmc+CgpUaGFua3MhCgo+IEdye29ldGplLGVldGluZ31zLAo+IAo+ICAg
ICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0Cj4gCgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC11bQo=

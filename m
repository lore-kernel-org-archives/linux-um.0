Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6BCC77B71
	for <linux-um@archiver.kernel.org>; Tue, 18 Apr 2023 08:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gmSe2v6vmbiCaDqnUBDuPxfpYKWqGfgtaP7B4+UKexs=; b=SLcaM5ff1KHIvY
	AdTkrCvQsQpkfu4if9LNusiAt1CUySwJyOqkSGlBngTT8biaHg1scACQENtjfWvd44AqTPK3Uqsxs
	UvHLqrpjYhAMuO9/WwbR82RAu+jVc+MF2iPTyFQ0kYaC12CLQ84k1A7w3AwEQCklCzbfKvGInX9ME
	w4TwWKoKNhmNrpwavhuVx1TTscGtNxlAFuCN7PRyCvgFmICAe1SkHsk4T3JWyC9Z8K/HL+RHqUOe2
	ZuAb/V+5D3SONBEsvbj/QhTfVgBktOdyVQh4kmuMqPahc81qVjDZzBPQxPdzJemiYG+G1qSuAkHpF
	I2OBYw/T3G5Ym4PG+T7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pogkY-001JZS-1P;
	Tue, 18 Apr 2023 08:31:42 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pogkV-001JYo-2I
	for linux-um@lists.infradead.org;
	Tue, 18 Apr 2023 08:31:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=XGHVrmYIBjg9iTNUm66OlNCrgX02TBMyPdqFJlzaS1g=;
	t=1681806699; x=1683016299; b=JZucMr9cVujwLJqwswX046oL1QZ/e0TR4IekrEcIpK7z2QB
	KQIgQAN2J4hASCKzI8W6rRJ5TOYcyXI2eKummiNopWaGjzM27hdcb1w5D58Rx1tOg+Ue75X28j6at
	Kidf8//tkTW2dt+7BPUUQq9QwQHWNFRLYnm3fL+ncBTvDvQID1VgI6O2sU51s3B+qN/r4CfM46Mdq
	jhrwBikzS6ZYO+FJ/sIB/FmBQABd3T7nbVmoj+EALKrGtrf1nPN7cR8URbXReOwIbkmR8Oo5Rb9/0
	bzD5Xzn+RLL6XRtxPL3qRAEQNzWn90xVDttzJtu0a1p4+nkoCbQL3e7P0jI3JurA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1pogkU-001Xpe-0P;
	Tue, 18 Apr 2023 10:31:38 +0200
Message-ID: <9811ef569aac8a2f2ff5a9f2d1039b5d041f6377.camel@sipsolutions.net>
Subject: Re: [PATCH v3 2/2] hostfs: store permissions in extended attributes
From: Johannes Berg <johannes@sipsolutions.net>
To: Marko =?UTF-8?Q?Petrovi=C4=87?= <petrovicmarko2006@gmail.com>, 
	linux-um@lists.infradead.org
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com
Date: Tue, 18 Apr 2023 10:31:37 +0200
In-Reply-To: <CRYCSOJIMYCY.3UJQ3W04LGKK7@laptop-fedora>
References: <20230413223024.11513-1-petrovicmarko2006@gmail.com>
	 <20230415164821.166606-1-petrovicmarko2006@gmail.com>
	 <CRYCSOJIMYCY.3UJQ3W04LGKK7@laptop-fedora>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230418_013139_745479_8C155D14 
X-CRM114-Status: GOOD (  19.00  )
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

SGksCgpPbiBTdW4sIDIwMjMtMDQtMTYgYXQgMTk6MjQgKzAyMDAsIE1hcmtvIFBldHJvdmnEhyB3
cm90ZToKPiAKPiBJIGhhdmUgd3JpdHRlbiB0aGUgdGhpcmQgdmVyc2lvbiBvZiB0aGUgcGF0Y2gu
IFRoYW5rIHlvdSBmb3IgYWxsIG9mIHlvdXIKPiByZWNvbW1lbmRhdGlvbnMuCj4gCj4gV2hpbGUg
d3JpdGluZyB0aGUgdGhpcmQgcGF0Y2ggdmVyc2lvbiwgSSBub3RpY2VkIHRoYXQgdGhlcmUgd2Fz
IGEKPiBzZXJpb3VzIGxpbWl0YXRpb24gb2YgdGhlIGNvZGUgaW4gc2Vjb25kIHBhdGNoLCBuYW1l
bHkgdGhlIHdob2xlCj4geGF0dHJwZXJtIGZlYXR1cmUgd2FzIGF2YWlsYWJsZSBvbmx5IGFuZCBv
bmx5IGFzIGJvb3QgdGltZSBmbGFnIHNvIGl0Cj4gY291bGQgbm90IGJlIHVzZWQgd2hlbiBob3N0
ZnMgd2FzIGJ1aWx0IGFzIG1vZHVsZSBzaW5jZSBtb2R1bGVzIGRvbid0Cj4gaGF2ZSBob3N0ZnNf
YXJncygpIGZ1bmN0aW9uLgo+IAo+IFRvIG92ZXJjb21lIHRoYXQgaXNzdWUsIEkgaGF2ZSBjaGFu
Z2VkIHRoZSBjb250ZW50IG9mCj4gc3RydWN0IHN1cGVyX2Jsb2NrIC0+IHNfZnNfaW5mbyB0byBw
b2ludCB0byBhIHN0cnVjdCBob3N0ZnNfZnNfaW5mbwo+IGNvbnRhaW5pbmcgdGhlIHN0cmluZyB0
aGF0IHdhcyBwcmV2aW91c2x5IHRoZXJlICh0byBiZSB1c2VkIGJ5IG9sZAo+IGZ1bmN0aW9ucykg
YW5kIHRoZSBwZXItbW91bnRwb2ludCB1c2VfeGF0dHIgZmxhZy4KPiBUaGlzIGFsbG93cyBlYXN5
IGV4dGVuZGluZyBvZiBtb3VudCBvcHRpb25zIGluIHRoZSBmdXR1cmUgYW5kIHRodXMKPiBwcm92
aWRpbmcgbW9yZSBmbGV4aWJpbGl0eSB0byB1c2Vyc3BhY2UgdG8gY29uZmlndXJlIHRoZSBmaWxl
c3lzdGVtLgo+IEZvciBleGFtcGxlLCBob3N0ZnNfYXR0ciwgYWNsIGFuZCBub2FjbCBjb3VsZCBi
ZSB0aGUgbW91bnQgb3B0aW9ucyBhZGRlZAo+IGZvciBQT1NJWCBBQ0xzIGFuZCBleHRlbmRlZCBh
dHRyaWJ1dGVzIGluIHRoZSBmdXR1cmUgYW5kIGlmIHRoZXJlIGlzIGEKPiBkZXNpcmUgZm9yIHRo
YXQsIGFwcGVuZCBjb3VsZCBiZWNvbWUgYSBtb3VudCBvcHRpb24gbm93IHRvby4KPiAKPiBSZWdh
cmRpbmcgeGF0dHJwZXJtIGFzIHRoZSBrZXJuZWwgYm9vdCBwYXJhbWV0ZXIsIEkgbGVmdCBpdCBh
dmFpbGFibGUgYW5kCj4gaXQgZGVmaW5lcyB0aGUgZGVmYXVsdCBiZWhhdmlvciB3aGVuIG1vdW50
aW5nIHRoZSBmaWxlc3lzdGVtICh3aGVuCj4gbmVpdGhlciB4YXR0cnBlcm0gbm9yIG5veGF0dHJw
ZXJtIGlzIHNwZWNpZmllZCBpbiBtb3VudCBvcHRpb25zKS4KCkl0IHNlZW1zIHRoYXQgX21heWJl
Xywgc2ltaWxhciB0byB0aGUgJ2hvc3Rmcycga2VybmVsIGFyZ3VtZW50LCB0aGVyZQpzaG91bGQg
YmUgYSB3YXkgdG8gY29udGFpbiB0aGUgc2V0IG9mIG9wdGlvbnM/CgpXaGF0IGRvIEkgbWVhbiBi
eSB0aGF0PyBJIG1lYW4gdGhhdCB0b2RheSwgdGhlIGluc2lkZSBvZiB0aGUgdmlydHVhbAptYWNo
aW5lIChmb3IgbGFjayBvZiBhIGJldHRlciB3b3JkKSBjYW4gb25seSBtb3VudCBvdXRzaWRlIGZv
bGRlcnMgdGhhdAphcmUgY29udGFpbmVkIGluIHRoZSBmb2xkZXIgaW5kaWNhdGVkIGJ5IHRoZSAn
aG9zdGZzJyBhcmd1bWVudC4KU2ltaWxhcmx5LCBwZXJoYXBzIHRoZSAib3V0c2lkZSBhZG1pbmlz
dHJhdG9yIiBzaG91bGQgYmUgYWJsZSB0bwppbmRpY2F0ZSB0aGF0IHhhdHRyIHBlcm1pc3Npb25z
IF9tdXN0XyBiZSB1c2VkLCBvciBfbXVzdCBub3RfIGJlIHVzZWQ/CgpXaGljaCB3b3VsZCBpbXBs
eSBhIG5ldyBrZXJuZWwgYXJndW1lbnQgdGhhdCBjYW4gYmUgY29uZmlndXJlZCB0byAiZm9yY2UK
dXNlIiwgImZvcmNlIGRvbid0IHVzZSIgYW5kICJkb24ndCBjYXJlIiwgd2l0aCBwZXJoYXBzIGV2
ZW4gZm9yIGJhY2t3YXJkCmNvbXBhdGliaWxpdHkgdGhlIGRlZmF1bHQgYmVpbmcgImZvcmNlIGRv
bid0IHVzZSI/CgpOb3Qgc3VyZS4gQW50b24/IFJpY2hhcmQ/IEFueSBvcGluaW9ucz8KCmpvaGFu
bmVzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==

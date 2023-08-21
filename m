Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A575EE4993
	for <linux-um@archiver.kernel.org>; Mon, 21 Aug 2023 08:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ouBxYZla657SuxaDwp1jKh0rDRPIfXhgzi8pXWmgb3k=; b=e3Bd3ghViLIqao
	32G5CUSgbVu+3JFc0+ko1l88tzQWG/6vfcM14E6iqA4Kn5X7JO0QFQ42ioHIhv66DjCXHaKAV0Z10
	aQjtScFLL8d/8GuGZTDzCAkJum64qdczh1UpTzbgRpqdRIi+fTRuv/c50CyL+JIZhQ6F0JZOJGUXv
	YOHkRsa6KpvkV1Gy5eDVpqppky0M/lbDO9PhxZkDKvXEooCmDNtCQApJa+0fym+fHbt3i0+GVLqs6
	yHwjCC0ZapF0oWYERs/EvTiADbU3QkNW4DK0OT+wivcCsvF274HoPUjPlmt9Jm/Dr1AJ5NwQim0Kt
	QWLXRUqqWBOkfMHGSQPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qY09K-00DTLJ-0a;
	Mon, 21 Aug 2023 08:20:34 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qY09H-00DTKP-08
	for linux-um@lists.infradead.org;
	Mon, 21 Aug 2023 08:20:32 +0000
Received: from 212-39-89-85.ip.btc-net.bg ([212.39.89.85] helo=[192.168.14.227])
	by www.kot-begemot.co.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qXzJj-001Ag5-3l; Mon, 21 Aug 2023 07:27:15 +0000
Message-ID: <02404242-ab8a-5300-ec76-fb13dc3fb403@cambridgegreys.com>
Date: Mon, 21 Aug 2023 08:27:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4] um: vector: Fix exception handling in
 vector_eth_configure()
Content-Language: en-US
To: Richard Weinberger <richard@nod.at>, Minjie Du <duminjie@vivo.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-um <linux-um@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 opensource kernel <opensource.kernel@vivo.com>
References: <20230706013911.695-1-duminjie@vivo.com>
 <888265629.6490567.1692478887611.JavaMail.zimbra@nod.at>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <888265629.6490567.1692478887611.JavaMail.zimbra@nod.at>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230821_012031_080502_140B2950 
X-CRM114-Status: GOOD (  22.89  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

CgpPbiAxOS8wOC8yMDIzIDIyOjAxLCBSaWNoYXJkIFdlaW5iZXJnZXIgd3JvdGU6Cj4gLS0tLS0g
VXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+PiBUaGUgcmVzb3VyY2UgY2xlYW51cCB3YXMgaW5j
b21wbGV0ZSBpbiB0aGUgaW1wbGVtZW50YXRpb24KPj4gb2YgdGhlIGZ1bmN0aW9uICJ2ZWN0b3Jf
ZXRoX2NvbmZpZ3VyZSIuCj4+IFRodXMgcmVwbGFjZSB0aGUganVtcCB0YXJnZXQKPj4gIm91dF91
bmRvX3VzZXJfaW5pdCIgYnkgIm91dF9mcmVlX25ldGRldiIuCj4+IERlbGF0ZSB0aGUgb3JwaGFu
IGZ1bmN0aW9uICJvdXRfdW5kb191c2VyX2luaXQiCj4+Cj4+IFBBVENIIHYxLXYzOiBNb2RpZnkg
dGhlIHBhdGNoIGZvcm1hdC4KPj4KPj4gU2lnbmVkLW9mZi1ieTogTWluamllIER1IDxkdW1pbmpp
ZUB2aXZvLmNvbT4KPj4gLS0tCj4+IGFyY2gvdW0vZHJpdmVycy92ZWN0b3Jfa2Vybi5jIHwgNCAr
LS0tCj4+IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMyBkZWxldGlvbnMoLSkKPj4K
Pj4gZGlmZiAtLWdpdCBhL2FyY2gvdW0vZHJpdmVycy92ZWN0b3Jfa2Vybi5jIGIvYXJjaC91bS9k
cml2ZXJzL3ZlY3Rvcl9rZXJuLmMKPj4gaW5kZXggMTMxYjdjYjI5Li43YWU2YWI4ZGYgMTAwNjQ0
Cj4+IC0tLSBhL2FyY2gvdW0vZHJpdmVycy92ZWN0b3Jfa2Vybi5jCj4+ICsrKyBiL2FyY2gvdW0v
ZHJpdmVycy92ZWN0b3Jfa2Vybi5jCj4+IEBAIC0xNjQ2LDcgKzE2NDYsNyBAQCBzdGF0aWMgdm9p
ZCB2ZWN0b3JfZXRoX2NvbmZpZ3VyZSgKPj4gCWVyciA9IHJlZ2lzdGVyX25ldGRldmljZShkZXYp
Owo+PiAJcnRubF91bmxvY2soKTsKPj4gCWlmIChlcnIpCj4+IC0JCWdvdG8gb3V0X3VuZG9fdXNl
cl9pbml0Owo+PiArCQlnb3RvIG91dF9mcmVlX25ldGRldjsKPj4KPj4gCXNwaW5fbG9jaygmdmVj
dG9yX2RldmljZXNfbG9jayk7Cj4+IAlsaXN0X2FkZCgmZGV2aWNlLT5saXN0LCAmdmVjdG9yX2Rl
dmljZXMpOwo+PiBAQCAtMTY1NCw4ICsxNjU0LDYgQEAgc3RhdGljIHZvaWQgdmVjdG9yX2V0aF9j
b25maWd1cmUoCj4+Cj4+IAlyZXR1cm47Cj4+Cj4+IC1vdXRfdW5kb191c2VyX2luaXQ6Cj4+IC0J
cmV0dXJuOwo+IAo+IEkgZG9uJ3QgdGhpbmsgdGhpcyBpcyBjb3JyZWN0Lgo+IHZlY3Rvcl9ldGhf
Y29uZmlndXJlKCkgY2Fubm90IGNvbW11bmljYXRlIHRoZSBmYWlsdXJlIHNpbmNlIGl0IGlzIG9m
IHR5cGUgdm9pZC4KPiBTbywgdmVjdG9yX3JlbW92ZSgpIHdpbGwgcnVuIGFuZCB3aWxsIGNhbGwg
dW5yZWdpc3Rlcl9uZXRkZXYoKS4gVGhhdCBjYW4gY2F1c2UgYSBkb3VibGUtZnJlZS4KCnZlY3Rv
cl9yZW1vdmUoKSB3aWxsIGJlIGNhbGxlZCBvbmx5IG9uY2UgcGVyIGRldmljZS4gSXQgY2hlY2tz
IGlmIHRoZSAKZGV2aWNlIGlzIGluIHRoZSBkZXZpY2UgbGlzdCBhbmQgaWYgaXQgaXMgbm90IC0g
YmFpbHMuIElmIGl0IGlzIGluIHRoZSAKbGlzdCBpdCByZW1vdmVzIGl0IGZyb20gdGhlcmUgYW5k
IGNhbGxzIHVucmVnaXN0ZXJfbmV0ZGV2KCkgYWZ0ZXIgdGhhdC4KClNvLCB1bmxlc3MgSSBhbSBt
aXNzaW5nIHNvbWV0aGluZywgdGhlcmUgaXMgbm8gaGFybSBoZXJlIC0gdW5yZWdpc3RlciAKd2ls
bCBub3QgYmUgY2FsbGVkIGZvciBhIGRldmljZSB0aGF0IGZhaWxlZCB0byByZWdpc3RlciwgYmVj
YXVzZSB0aGUgCmxpc3QgaXMgdXBkYXRlZCBvbmx5IGlmIHRoZSBkZXZpY2UgaGFzIHJlZ2lzdGVy
ZWQgc3VjY2Vzc2Z1bGx5LgoKSG93ZXZlciwgb24gc2Vjb25kIHJlYWQgLSBpZiByZWdpc3RlciBm
YWlscywgdGhlIGN1cnJlbnQgY29kZSBsZWFrcyBhIAoqZGV2aWNlIHdoaWNoIHdhcyBhbGxvYy1l
ZCBpbiB0aGUgYmVnaW5uaW5nIG9mIGNvbmZpZ3VyZS4gU28gZXZlbiBpZiB3ZSAKc2tpcCBmcmVl
X25ldGRldiwgd2hpY2ggaW52b2tlcyByZW1vdmUgd2Ugc3RpbGwgbmVlZCB0byBmcmVlIHRoYXQg
KmRldmljZS4KCj4gCj4gVGhhbmtzLAo+IC8vcmljaGFyZAo+IAoKLS0gCkFudG9uIFIuIEl2YW5v
dgpDYW1icmlkZ2VncmV5cyBMaW1pdGVkLiBSZWdpc3RlcmVkIGluIEVuZ2xhbmQuIENvbXBhbnkg
TnVtYmVyIDEwMjczNjYxCmh0dHBzOi8vd3d3LmNhbWJyaWRnZWdyZXlzLmNvbS8KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcg
bGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K

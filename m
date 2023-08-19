Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0D5EE49A5
	for <linux-um@archiver.kernel.org>; Sat, 19 Aug 2023 21:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:Cc:To:From:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=sA+ly1UWGhNIIZBOx8J8VEXPduaFzYv4XYGhn4LPnQM=; b=yl0p3e/qccuEyeuRGke33gASqQ
	V63UVSJadaX9gdrzRM35OTzfH/5czE03Qof9GdaemcXUsoyOdecHW4v2IxWl7ou4FxYbV2ZPOegxY
	TOAkgPgQy/nP5x7wwb71uXZYChLSixuRr6GUjRmp+ImQobcRKF964zVm6K/dQfVjqk+XS1PPHixCc
	04OPj6l6e0vGXfaGroG1yEQeglOnRve8cvAATgW/NPO7IuKYFmIRblaRaURmDdSliRlFNzudLw6Nw
	1e4Y5B+QPRZOQ26DpkQh4kMUILQFIIwvTmoG9/lcj8QYzeew6QqnGwsk+fF87Z7UdnNZfCD0DnQ+d
	DLBWEIeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qXT4r-00BBG1-0C;
	Sat, 19 Aug 2023 21:01:45 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qXT4n-00BBFJ-23
	for linux-um@lists.infradead.org;
	Sat, 19 Aug 2023 21:01:43 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 81DC4616B2CF;
	Sat, 19 Aug 2023 23:01:28 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id R-xTUNX53BfU; Sat, 19 Aug 2023 23:01:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id DC29761989EF;
	Sat, 19 Aug 2023 23:01:27 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XlOXJxBLBgRp; Sat, 19 Aug 2023 23:01:27 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id B585963DB7EA;
	Sat, 19 Aug 2023 23:01:27 +0200 (CEST)
Date: Sat, 19 Aug 2023 23:01:27 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Minjie Du <duminjie@vivo.com>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, 
	linux-um <linux-um@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	opensource kernel <opensource.kernel@vivo.com>
Message-ID: <888265629.6490567.1692478887611.JavaMail.zimbra@nod.at>
In-Reply-To: <20230706013911.695-1-duminjie@vivo.com>
References: <20230706013911.695-1-duminjie@vivo.com>
Subject: Re: [PATCH v4] um: vector: Fix exception handling in
 vector_eth_configure()
MIME-Version: 1.0
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: vector: Fix exception handling in vector_eth_configure()
Thread-Index: 4vytQNC34nzS2LWCFohj3c7c7cYvzA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230819_140141_842440_8F22B903 
X-CRM114-Status: GOOD (  10.93  )
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

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IFRoZSByZXNvdXJjZSBjbGVhbnVwIHdh
cyBpbmNvbXBsZXRlIGluIHRoZSBpbXBsZW1lbnRhdGlvbgo+IG9mIHRoZSBmdW5jdGlvbiAidmVj
dG9yX2V0aF9jb25maWd1cmUiLgo+IFRodXMgcmVwbGFjZSB0aGUganVtcCB0YXJnZXQKPiAib3V0
X3VuZG9fdXNlcl9pbml0IiBieSAib3V0X2ZyZWVfbmV0ZGV2Ii4KPiBEZWxhdGUgdGhlIG9ycGhh
biBmdW5jdGlvbiAib3V0X3VuZG9fdXNlcl9pbml0Igo+IAo+IFBBVENIIHYxLXYzOiBNb2RpZnkg
dGhlIHBhdGNoIGZvcm1hdC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBNaW5qaWUgRHUgPGR1bWluamll
QHZpdm8uY29tPgo+IC0tLQo+IGFyY2gvdW0vZHJpdmVycy92ZWN0b3Jfa2Vybi5jIHwgNCArLS0t
Cj4gMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAzIGRlbGV0aW9ucygtKQo+IAo+IGRp
ZmYgLS1naXQgYS9hcmNoL3VtL2RyaXZlcnMvdmVjdG9yX2tlcm4uYyBiL2FyY2gvdW0vZHJpdmVy
cy92ZWN0b3Jfa2Vybi5jCj4gaW5kZXggMTMxYjdjYjI5Li43YWU2YWI4ZGYgMTAwNjQ0Cj4gLS0t
IGEvYXJjaC91bS9kcml2ZXJzL3ZlY3Rvcl9rZXJuLmMKPiArKysgYi9hcmNoL3VtL2RyaXZlcnMv
dmVjdG9yX2tlcm4uYwo+IEBAIC0xNjQ2LDcgKzE2NDYsNyBAQCBzdGF0aWMgdm9pZCB2ZWN0b3Jf
ZXRoX2NvbmZpZ3VyZSgKPiAJZXJyID0gcmVnaXN0ZXJfbmV0ZGV2aWNlKGRldik7Cj4gCXJ0bmxf
dW5sb2NrKCk7Cj4gCWlmIChlcnIpCj4gLQkJZ290byBvdXRfdW5kb191c2VyX2luaXQ7Cj4gKwkJ
Z290byBvdXRfZnJlZV9uZXRkZXY7Cj4gCj4gCXNwaW5fbG9jaygmdmVjdG9yX2RldmljZXNfbG9j
ayk7Cj4gCWxpc3RfYWRkKCZkZXZpY2UtPmxpc3QsICZ2ZWN0b3JfZGV2aWNlcyk7Cj4gQEAgLTE2
NTQsOCArMTY1NCw2IEBAIHN0YXRpYyB2b2lkIHZlY3Rvcl9ldGhfY29uZmlndXJlKAo+IAo+IAly
ZXR1cm47Cj4gCj4gLW91dF91bmRvX3VzZXJfaW5pdDoKPiAtCXJldHVybjsKCkkgZG9uJ3QgdGhp
bmsgdGhpcyBpcyBjb3JyZWN0Lgp2ZWN0b3JfZXRoX2NvbmZpZ3VyZSgpIGNhbm5vdCBjb21tdW5p
Y2F0ZSB0aGUgZmFpbHVyZSBzaW5jZSBpdCBpcyBvZiB0eXBlIHZvaWQuClNvLCB2ZWN0b3JfcmVt
b3ZlKCkgd2lsbCBydW4gYW5kIHdpbGwgY2FsbCB1bnJlZ2lzdGVyX25ldGRldigpLiBUaGF0IGNh
biBjYXVzZSBhIGRvdWJsZS1mcmVlLgoKVGhhbmtzLAovL3JpY2hhcmQKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdAps
aW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtdW0K

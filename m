Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F84C77B72
	for <linux-um@archiver.kernel.org>; Fri, 14 Apr 2023 17:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:Cc:To:From:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=oIm9Bv8hqbF4pMLMwAJwrt5ZdvCcqjMThCLutJ4EOrs=; b=tJS1Um2XVWyTk+U0ZpP3uVGUzq
	glHr0oEceVFE9XD0ro8SJBEIm7bj6cICC01Z8jBE8iT9YjJMGIJqrIngryCuRwu1Tx0qxYSKWp1e4
	mPltQz3w5TZT0axDhhfQaXTBSxCe46XPn6TE0BGkT9yJVUkcsEgRFgINQgoGw0wjNEf6mTZa+iNAp
	XXMyXthUJ1VHhrr22rgcdYlJ2na19A7CjaSDsnKWfPYE1Ze8SM38VUCratuaGdKgnChf6+cvyMLkt
	Z0NCFmemZufKPnngxtocyfQRyZ0DLCUDFkv8LwJGiMu1p6B08E2fOP6jTaBxQeLn89/pEkqKV9XKc
	wH4ZyMow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pnNhc-00AJBa-0E;
	Fri, 14 Apr 2023 17:59:16 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pnNhY-00AJAu-2l
	for linux-um@lists.infradead.org;
	Fri, 14 Apr 2023 17:59:14 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 79A3664551D9;
	Fri, 14 Apr 2023 19:59:06 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id kZ0PDiEvqz7k; Fri, 14 Apr 2023 19:59:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 2130364551BD;
	Fri, 14 Apr 2023 19:59:06 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Ls5GuQwmlqoT; Fri, 14 Apr 2023 19:59:06 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id EF55C64551D9;
	Fri, 14 Apr 2023 19:59:05 +0200 (CEST)
Date: Fri, 14 Apr 2023 19:59:05 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Marko =?utf-8?Q?Petrovi=C4=87?= <petrovicmarko2006@gmail.com>
Cc: linux-um <linux-um@lists.infradead.org>, 
	anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>
Message-ID: <1727651667.63467.1681495145812.JavaMail.zimbra@nod.at>
In-Reply-To: <CRWO54DLBZE8.1F6QOOS3VHSNI@laptop-fedora>
References: <20230413223024.11513-3-petrovicmarko2006@gmail.com> <20230414023357.63722-1-petrovicmarko2006@gmail.com> <1668890621.62421.1681469691730.JavaMail.zimbra@nod.at> <CRWO54DLBZE8.1F6QOOS3VHSNI@laptop-fedora>
Subject: Re: [PATCH v2 2/2] hostfs: store permissions in extended attributes
MIME-Version: 1.0
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: hostfs: store permissions in extended attributes
Thread-Index: Y996KeaD7kq1UcF2bgxCP2ylxwUpeQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230414_105913_067835_E8A9781F 
X-CRM114-Status: GOOD (  10.37  )
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

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IFZvbjogIk1hcmtvIFBldHJvdmnEhyIg
PHBldHJvdmljbWFya28yMDA2QGdtYWlsLmNvbT4KPiBBYm91dCB1c2luZyAtMSBmb3IgdWlkIGFu
ZCBnaWQsIGluIGRvY3VtZW50YXRpb24gZm9yIGNob3duIGl0IGlzIHN0YXRlZAo+IHRoYXQgLTEg
c2hhbGwgYmUgdXNlZCBpZiB0aGUgZGVzaXJlZCB2YWx1ZSBzaG91bGQgbm90IGJlIGNoYW5nZWQs
IHNpbmNlCj4gbm9ybWFsbHkgY2hvd24oMikgYWNjZXB0cyBib3RoIHVpZCBhbmQgZ2lkIGZvciBj
aGFuZ2luZyBpbiBvbmUgc3lzdGVtCj4gY2FsbC4KPiBJbiB0aGUgY29uY3JldGUgaW1wbGVtZW50
YXRpb24sIHNpbmNlIHRoZSB1bmRlcmx5aW5nIHR5cGUgaXMgdW5zaWduZWQKPiBpbnQsIHRoZSAt
MSB3aWxsIGJlIHdyaXR0ZW4gaW4gMidzIGNvbXBsZW1lbnQgYW5kIHRoZW4gdHJlYXRlZCBhcyBh
bgo+IHVuc2lnbmVkIHBvc2l0aXZlIG51bWJlci4gRm9yIHRoZSBzaXplIG9mIDQgYnl0ZXMgZm9y
IHVuc2lnbmVkIGludCwgdGhlCj4gcmVzdWx0aW5nIG51bWJlciBpcyA0Mjk0OTY3Mjk1LiBUaGF0
IGlzIGFsc28gdGhlIG1heGltdW0gcG9zc2libGUgbnVtYmVyCj4gb2YgdXNlcnMgb24gTGludXgs
IGJ1dCBMaW51eCB1c2VyIElEcyBnbyBmcm9tIDAgdG8gNDI5NDk2NzI5NCBzbyB0aGF0Cj4gbGFz
dCBvbmUgaXMgb3V0c2lkZSBVSUQgc3BhY2UgYW5kIHJlc2VydmVkIGFzICJkb24ndCBjaGFuZ2Ui
IGZsYWcgZm9yCj4gY2hvd24oMikuCgpZb3UncmUgdG90YWxseSByaWdodC4gSSBzaG91bGQgaGF2
ZSBjaGVja2VkIHRoZSBtYW5wYWdlIGJlZm9yZS4KIAo+IEluIHJlZ2FyZCB0byB0aGUgc3RvcmUg
b2YgdmFsdWVzIGluIHBsYXRmb3JtIGluZGVwZW5kZW50IHdheSwgaW4gbXkKPiBodW1ibGUgb3Bp
bmlvbiwgSm9oYW5uZXMnIHJlY29tbWVuZGF0aW9uIG1heSBiZSBwcmVmZXJyZWQgKHN0b3Jpbmcg
YWxsCj4gcGVybWlzc2lvbnMgaW4gb25lIHN0cmluZykgYmVjYXVzZSBiZXNpZGVzIHRoaXMgaXQg
YWxzbyBzb2x2ZXMgdGhlCj4gcHJvYmxlbSBvZiBvbmUgc2V0eGF0dHIoKSBzdWNjZWRpbmcgYW5k
IG90aGVyIGZhaWxpbmcgKGZvciB3aGF0ZXZlcgo+IHJlYXNvbiBtYXkgdGhhdCBoYXBwZW4pIGlu
IHVtbF9jaG93bigpLgoKU3RvcmluZyB0aGVtIGFzIHN0cmluZyBpcyBhbHNvIGZpbmUgYnkgbWUu
IDotKQoKVGhhbmtzLAovL3JpY2hhcmQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtdW0K

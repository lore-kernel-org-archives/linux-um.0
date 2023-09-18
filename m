Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F05FC46CA1
	for <linux-um@archiver.kernel.org>; Mon, 18 Sep 2023 13:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:Cc:To:From:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=lKO47h7s3eRy0kQTMzcTRkrKzLenqAGVHCW2wiwhoGE=; b=EE/lthTTjMN+PFrvDlP0pmGEnX
	HNbjlilvkKGQK0stF83gR2Pqc6QmhSk6jLGXigxMh6tUDIVOofbJPNjpV1rrjvEPIr0ZFXof2+T2j
	bw8bINCo/t9rLENO8GUokM0qK03Bkyd2nah5gLOYi0M6ROg5Wei2z1XoTR3IZ2cpkaPMTnHIWuaaE
	x50XA+a5auXaiHx/v8lg2e3NZvVYeAVLndtvjzZEde3N3fUnaJORTGI8rqDJI8qG9Bt2O7tjfocrV
	JV0hoevS0z0SJFqP3sMMctzL1i9g/qW7Qf7R8BiUlG93HJAwFJWgNg7XtFAlnF+ErOhcuXyxeLjR7
	DfuL/TqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiEly-00Fbyl-0p;
	Mon, 18 Sep 2023 13:58:46 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiElu-00Fbxr-1h
	for linux-um@lists.infradead.org;
	Mon, 18 Sep 2023 13:58:44 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id E9AD862348B3;
	Mon, 18 Sep 2023 15:58:28 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id vDhG-KsmSMfP; Mon, 18 Sep 2023 15:58:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 5C6516418DB1;
	Mon, 18 Sep 2023 15:58:28 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id tdtM0oZv5-6J; Mon, 18 Sep 2023 15:58:28 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 38E346418DAD;
	Mon, 18 Sep 2023 15:58:28 +0200 (CEST)
Date: Mon, 18 Sep 2023 15:58:28 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Jan Kara <jack@suse.cz>
Cc: Peter Lafreniere <peter@n8pjl.ca>, linux-um <linux-um@lists.infradead.org>, 
	anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	reiserfs-devel@vger.kernel.org
Message-ID: <1673328726.54148.1695045508095.JavaMail.zimbra@nod.at>
In-Reply-To: <20230918132614.zmmuc72purc2psik@quack3>
References: <20230910232640.113938-1-peter@n8pjl.ca> <20230918125744.4342-1-peter@n8pjl.ca> <20230918132614.zmmuc72purc2psik@quack3>
Subject: Re: [PATCH RESEND] um: Remove CONFIG_REISERFS_FS from defconfig
MIME-Version: 1.0
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Remove CONFIG_REISERFS_FS from defconfig
Thread-Index: k6PfwRWfei8ynhM8ygGzkHIfTtkrDg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230918_065842_737407_AF37757C 
X-CRM114-Status: UNSURE (   7.71  )
X-CRM114-Notice: Please train this message.
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

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IE9uIE1vbiAxOC0wOS0yMyAxMjo1ODoy
NiwgUGV0ZXIgTGFmcmVuaWVyZSB3cm90ZToKPj4gUmVpc2VyRlMgaGFzIGJlZW4gZGVwcmVjYXRl
ZCBmb3IgYSB5ZWFyIGFuZCBhIGhhbGYsIHlldCBpcyBzdGlsbCBidWlsdAo+PiBhcyBwYXJ0IG9m
IGEgZGVmY29uZmlnIFVNTCBrZXJuZWwuCj4+IAo+PiBBY2NvcmRpbmcgdG8gY29tbWl0IGViMTAz
YTUxNjQwZSAoInJlaXNlcmZzOiBEZXByZWNhdGUgcmVpc2VyZnMiKSwgdGhlCj4+IGZpbGVzeXN0
ZW0gaXMgc2xhdGVkIHRvIGJlIHJlbW92ZWQgaW4gMjAyNS4gUmVtb3ZlIGl0IGZyb20gdGhlIGRl
ZmNvbmZpZwo+PiBwcm9maWxlIG5vdywgYXMgcGFydCBvZiBpdHMgZGVwcmVjYXRpb24gcHJvY2Vz
cy4KPj4gCj4+IFNpZ25lZC1vZmYtYnk6IFBldGVyIExhZnJlbmllcmUgPHBldGVyQG44cGpsLmNh
Pgo+IAo+IE1ha2VzIHNlbnNlIGJ1dCBJJ3ZlIG5vdGljZWQgdGhlcmUgYXJlIG1hbnkgbW9yZSBh
cmNoaXRlY3R1cmVzIHRoYXQgZGVmaW5lCj4gQ09ORklHX1JFSVNFUkZTX0ZTIGluIHRoZWlyIGRl
ZmNvbmZpZyAoc2gsIHBvd2VycGMsIG1pcHMsIG02OGssIGlhNjQsIGFybSwKPiBhbHBoYSkuIFNv
IHBlcmhhcHMgd2Ugc2hvdWxkIGRvIHRoaXMgZm9yIGFsbCBvZiB0aGVtIHdoZW4gd2UgYXJlIGF0
IGl0PwoKWWVzLCBhIGNvbWJpbmVkIHBhdGNoIG1ha2VzIGluIHRoaXMgY2FzZSBtb3JlIHNlbnNl
LgoKPj4gCj4+ICBhcmNoL3VtL2NvbmZpZ3MvaTM4Nl9kZWZjb25maWcgICB8IDEgLQo+PiAgYXJj
aC91bS9jb25maWdzL3g4Nl82NF9kZWZjb25maWcgfCAxIC0KPj4gIDIgZmlsZXMgY2hhbmdlZCwg
MiBkZWxldGlvbnMoLSkKCkZvciBVTUw6CkFja2VkLWJ5OiBSaWNoYXJkIFdlaW5iZXJnZXIgPHJp
Y2hhcmRAbm9kLmF0PgoKVGhhbmtzLAovL3JpY2hhcmQKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtdW0K

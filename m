Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83352C7EE24
	for <linux-um@archiver.kernel.org>; Tue,  6 Jun 2023 08:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:Cc:To:From:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=zb3I2g2IQB47B6IoOGc8mVurpOkEJso0r94mGL29aZE=; b=oXNdzpQSsssGqoXW7N+a7fvOlZ
	2Ys+tDoOHk/1UliPL+nNrEug0HjX3nUKrjZNJ8RG05+6Wslvc+9Tj0qQOJiXwhhUiSO1don6kT6sh
	H9OdB+680Yc2WKx8pV8flwlRoo+o50IWl4qs7SrOeYkCHIv0TyMs+qGJXmrf0ctc7tslof8BUmr/A
	VJG3vxw3956zjPiRhbZEOaMHrTMWB8/xOVsXzLEC0tCJhfA7LgA62gaScRCs0CZrIiajgYkGItjaY
	Bn3kica8YUBWNoD6RZCz8Z777XjcJ/rpucDnTaLCPStlI4884n3G04cWgMW/RyWnqu8yLQelPwqJa
	7CGUVihw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6Rzh-000nAk-0l;
	Tue, 06 Jun 2023 08:24:45 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6Rzd-000n86-0f;
	Tue, 06 Jun 2023 08:24:42 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id A2DC56081100;
	Tue,  6 Jun 2023 10:24:39 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id siZzZpJorNJf; Tue,  6 Jun 2023 10:24:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 34240616B2CF;
	Tue,  6 Jun 2023 10:24:39 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YeogKuuY1hxw; Tue,  6 Jun 2023 10:24:39 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id E97466081100;
	Tue,  6 Jun 2023 10:24:38 +0200 (CEST)
Date: Tue, 6 Jun 2023 10:24:38 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: hch <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>, 
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>, 
	Jack Wang <jinpu.wang@ionos.com>, 
	Phillip Potter <phil@philpotter.co.uk>, Coly Li <colyli@suse.de>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, 
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	dm-devel <dm-devel@redhat.com>, 
	linux-block <linux-block@vger.kernel.org>, 
	linux-um <linux-um@lists.infradead.org>, 
	linux-scsi <linux-scsi@vger.kernel.org>, 
	linux-bcache <linux-bcache@vger.kernel.org>, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	linux-nvme <linux-nvme@lists.infradead.org>, 
	linux-btrfs <linux-btrfs@vger.kernel.org>, 
	linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>, 
	linux-nilfs <linux-nilfs@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-pm <linux-pm@vger.kernel.org>
Message-ID: <318049918.3687133.1686039878761.JavaMail.zimbra@nod.at>
In-Reply-To: <20230606073950.225178-24-hch@lst.de>
References: <20230606073950.225178-1-hch@lst.de> <20230606073950.225178-24-hch@lst.de>
Subject: Re: [PATCH 23/31] mtd: block: use a simple bool to track open for
 write
MIME-Version: 1.0
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: block: use a simple bool to track open for write
Thread-Index: X/xlpyhSf8bloXE5HNEoh3ox5Q1J9Q==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230606_012441_546787_ED789AB4 
X-CRM114-Status: GOOD (  14.83  )
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

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IFZvbjogImhjaCIgPGhjaEBsc3QuZGU+
Cj4gSW5zdGVhZCBvZiBwcm9wYWdhdGluZyB0aGUgZm1vZGVfdCwganVzdCB1c2UgYSBib29sIHRv
IHRyYWNrIGlmIGEgbXRkCj4gYmxvY2sgZGV2aWNlIHdhcyBvcGVuZWQgZm9yIHdyaXRpbmcuCj4g
Cj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+Cj4gLS0tCj4g
ZHJpdmVycy9tdGQvbXRkX2Jsa2RldnMuYyAgICB8IDIgKy0KPiBkcml2ZXJzL210ZC9tdGRibG9j
ay5jICAgICAgIHwgMiArLQo+IGluY2x1ZGUvbGludXgvbXRkL2Jsa3RyYW5zLmggfCAyICstCj4g
MyBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4gCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbXRkL210ZF9ibGtkZXZzLmMgYi9kcml2ZXJzL210ZC9tdGRfYmxr
ZGV2cy5jCj4gaW5kZXggZjBiYjA5ZmRlOTVlM2EuLmJkMGI3NTQ1MzY0MzQ5IDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvbXRkL210ZF9ibGtkZXZzLmMKPiArKysgYi9kcml2ZXJzL210ZC9tdGRfYmxr
ZGV2cy5jCj4gQEAgLTIwOCw3ICsyMDgsNyBAQCBzdGF0aWMgaW50IGJsa3RyYW5zX29wZW4oc3Ry
dWN0IGdlbmRpc2sgKmRpc2ssIGZtb2RlX3QgbW9kZSkKPiAJcmV0ID0gX19nZXRfbXRkX2Rldmlj
ZShkZXYtPm10ZCk7Cj4gCWlmIChyZXQpCj4gCQlnb3RvIGVycm9yX3JlbGVhc2U7Cj4gLQlkZXYt
PmZpbGVfbW9kZSA9IG1vZGU7Cj4gKwlkZXYtPndyaXRhYmxlID0gbW9kZSAmIEZNT0RFX1dSSVRF
Owo+IAo+IHVubG9jazoKPiAJZGV2LT5vcGVuKys7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRk
L210ZGJsb2NrLmMgYi9kcml2ZXJzL210ZC9tdGRibG9jay5jCj4gaW5kZXggYTBhMTE5NGRjMWQ5
MDIuLmZhNDc2ZmI0ZGZmYjZjIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbXRkL210ZGJsb2NrLmMK
PiArKysgYi9kcml2ZXJzL210ZC9tdGRibG9jay5jCj4gQEAgLTI5NCw3ICsyOTQsNyBAQCBzdGF0
aWMgdm9pZCBtdGRibG9ja19yZWxlYXNlKHN0cnVjdCBtdGRfYmxrdHJhbnNfZGV2ICptYmQpCj4g
CQkgKiBJdCB3YXMgdGhlIGxhc3QgdXNhZ2UuIEZyZWUgdGhlIGNhY2hlLCBidXQgb25seSBzeW5j
IGlmCj4gCQkgKiBvcGVuZWQgZm9yIHdyaXRpbmcuCj4gCQkgKi8KPiAtCQlpZiAobWJkLT5maWxl
X21vZGUgJiBGTU9ERV9XUklURSkKPiArCQlpZiAobWJkLT53cml0YWJsZSkKPiAJCQltdGRfc3lu
YyhtYmQtPm10ZCk7Cj4gCQl2ZnJlZShtdGRibGstPmNhY2hlX2RhdGEpOwo+IAl9Cj4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvbGludXgvbXRkL2Jsa3RyYW5zLmggYi9pbmNsdWRlL2xpbnV4L210ZC9i
bGt0cmFucy5oCj4gaW5kZXggMTVjYzliOTVlMzJiNTIuLjZlNDcxNDM2YmJhNTU2IDEwMDY0NAo+
IC0tLSBhL2luY2x1ZGUvbGludXgvbXRkL2Jsa3RyYW5zLmgKPiArKysgYi9pbmNsdWRlL2xpbnV4
L210ZC9ibGt0cmFucy5oCj4gQEAgLTM0LDcgKzM0LDcgQEAgc3RydWN0IG10ZF9ibGt0cmFuc19k
ZXYgewo+IAlzdHJ1Y3QgYmxrX21xX3RhZ19zZXQgKnRhZ19zZXQ7Cj4gCXNwaW5sb2NrX3QgcXVl
dWVfbG9jazsKPiAJdm9pZCAqcHJpdjsKPiAtCWZtb2RlX3QgZmlsZV9tb2RlOwo+ICsJYm9vbCB3
cml0YWJsZTsKPiB9OwoKQWNrZWQtYnk6IFJpY2hhcmQgV2VpbmJlcmdlciA8cmljaGFyZEBub2Qu
YXQ+CgpUaGFua3MsCi8vcmljaGFyZAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC11bQo=

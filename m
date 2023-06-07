Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B46C7EE23
	for <linux-um@archiver.kernel.org>; Wed,  7 Jun 2023 12:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hDqPYIcdvBNkszC+AF5kg4t0P6aZzPoceFm/DZmmY+E=; b=tuD/xskKrhcHM+
	Ru+2UZ3HUKo5bx5Y/y2dIuKa09mzHFUhxksVFZW6NKjL9nlOXZCsRE/H0KuNGHG2Y7YyKLx4+Tzat
	VzMNEYGkxvdUOrK+yZtBfXvju4RJt0WqSltSEkfar6SckW3GktX6ALCC6X5KWFDF7iqC6rkGQa1HK
	CHRO/8HpYFNAXsZ4zecKoEoIGkMYH6K6PizKKx7i/Whnwf0TdZNSc0UXAuJJzpUz0XTuzGPlMfG3G
	bDJb7fe9HTLtZ3F3d+RrLggsJMlzrL/kiCBMvgaYyLJzRSoqMtwnJ+86e4JTuhAgrrEUjjC+YOq3h
	unQKHajrbh96G7ezIw6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6s6B-005pG0-0q;
	Wed, 07 Jun 2023 12:17:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6s66-005pCh-2Y;
	Wed, 07 Jun 2023 12:17:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 52B4E6732D; Wed,  7 Jun 2023 14:16:58 +0200 (CEST)
Date: Wed, 7 Jun 2023 14:16:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Richard Weinberger <richard@nod.at>,
	Josef Bacik <josef@toxicpanda.com>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Phillip Potter <phil@philpotter.co.uk>, Coly Li <colyli@suse.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
	linux-block@vger.kernel.org, linux-um@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 28/31] block: replace fmode_t with a block-specific
 type for block open flags
Message-ID: <20230607121658.GA13632@lst.de>
References: <20230606073950.225178-1-hch@lst.de> <20230606073950.225178-29-hch@lst.de> <20230607-kocht-kornfeld-a249c6740e38@brauner>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230607-kocht-kornfeld-a249c6740e38@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_051706_969516_A3D4937D 
X-CRM114-Status: GOOD (  23.78  )
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

T24gV2VkLCBKdW4gMDcsIDIwMjMgYXQgMTE6MjE6MTRBTSArMDIwMCwgQ2hyaXN0aWFuIEJyYXVu
ZXIgd3JvdGU6Cj4gT24gVHVlLCBKdW4gMDYsIDIwMjMgYXQgMDk6Mzk6NDdBTSArMDIwMCwgQ2hy
aXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gPiBUaGUgb25seSBvdmVybGFwIGJldHdlZW4gdGhlIGJs
b2NrIG9wZW4gZmxhZ3MgbWFwcGVkIGludG8gdGhlIGZtb2RlX3QgYW5kCj4gPiBvdGhlciB1c2Vz
IG9mIGZtb2RlX3QgYXJlIEZNT0RFX1JFQUQgYW5kIEZNT0RFX1dSSVRFLiAgRGVmaW5lIGEgbmV3
Cj4gCj4gYW5kIEZNT0RFX0VYQ0wgYWZhaWN0CgpGTU9ERV9FWENMIGlzbid0IHVzZWQgb3V0c2lk
ZSB0aGUgYmxvY2sgbGF5ZXIgYW5kIHJlbW92ZWQgaW4gdGhlIGxhc3QKcGF0Y2guCgo+ID4gK2Js
a19tb2RlX3QgZmlsZV90b19ibGtfbW9kZShzdHJ1Y3QgZmlsZSAqZmlsZSkKPiA+ICt7Cj4gPiAr
CWJsa19tb2RlX3QgbW9kZSA9IDA7Cj4gPiArCj4gPiArCWlmIChmaWxlLT5mX21vZGUgJiBGTU9E
RV9SRUFEKQo+ID4gKwkJbW9kZSB8PSBCTEtfT1BFTl9SRUFEOwo+ID4gKwlpZiAoZmlsZS0+Zl9t
b2RlICYgRk1PREVfV1JJVEUpCj4gPiArCQltb2RlIHw9IEJMS19PUEVOX1dSSVRFOwo+ID4gKwlp
ZiAoZmlsZS0+Zl9tb2RlICYgRk1PREVfRVhDTCkKPiA+ICsJCW1vZGUgfD0gQkxLX09QRU5fRVhD
TDsKPiA+ICsJaWYgKChmaWxlLT5mX2ZsYWdzICYgT19BQ0NNT0RFKSA9PSAzKQo+IAo+IEkgcmVh
bGx5IGRvbid0IGxpa2UgbWFnaWMgbnVtYmVycyBsaWtlIHRoaXMuCgpJIGRvbid0IGxpa2UgdGhl
bSBlaXRoZXIsIGJ1dCB0aGlzIGlzIGp1c3QgbW92ZWQgYXJvdW5kIGFuZCBub3QgbmV3LgoKPiBH
cm9hbiwgT19SRE9OTFkgYmVpbmcgZGVmaW5lZCBhcyAwIHN0cmlrZXMgYWdhaW4uLi4KPiBCZWN1
YXNlIG9mIHRoaXMgcXVpcmsgd2UgaW50ZXJuYWxseSBtYXAKPiAKPiBPX1JET05MWSgwKSAtPiBG
TU9ERV9SRUFEKDEpCj4gT19XUk9OTFkoMSkgLT4gRk1PREVfV1JJVEUoMikKPiBPX1JEV1IoMykg
ICAtPiAoRk1PREVfUkVBRCB8IEZNT0RFX1dSSVRFKQoKT19SRFdSIGlzIDIuCgo+IHNvIGNoZWNr
aW5nIGZvciB0aGUgcmF3IDMgaGVyZSBpcyBjb25mdXNpbmcgaW4gYWRkaXRpb24gdG8gYmVpbmcg
YSBtYWdpYwo+IG51bWJlciBhcyBpdCBjb3VsZCBnaXZlIHRoZSBpbXByZXNzaW9uIHRoYXQgd2hh
dCdzIGNoZWNrZWQgaGVyZSBpcwo+IChPX1dST05MWSB8IE9fUkRXUikgd2hpY2ggZG9lc24ndCBt
YWtlIHNlbnNlLi4uCgpXZWxsLCB0aGF0IGlzIGV4YWN0bHkgd2hhdCB3ZSBjaGVjayBmb3IuICBU
aGlzIGlzIGEgMzAtaXNoIHllYXIgb2xkCnF1aXJrIG9ubHkgdXNlZCBpbiB0aGUgZmxvcHB5IGRy
aXZlci4KCj4gU28gbXkgcGVyZmVyZW5jZSB3b3VsZCBiZSBpbiBkZXNjZW5kaW5nIG9yZGVyIG9m
IHByZWZlcmVuY2U6Cj4gCj4gKGZpbGUtPmZfZmxhZ3MgJiBPX0FDQ01PREUpID09IChGTU9ERV9S
RUFEIHwgRk1PREVfV1JJVEUpCj4gCj4gb3Igd2hpbGUgYSBsaXR0bGUgbGVzcyBjbGVhciBidXQg
aW5mb3JtYXRpdmUgZW5vdWdoIGZvciBwZW9wbGUgZmFtaWxpYXIKPiB3aXRoIHRoZSBPX1JET05M
WSBxdWlyazoKPiAKPiBpZiAoKGZpbGUtPmZfZmxhZ3MgJiBPX0FDQ01PREUpID09IE9fQUNDTU9E
RSkKCkkgZG9uJ3QgdW5kZXJzdGFuZCB0aGlzIHBhcnQuICBFc3BlY2lhbGx5IHRoZSBhYm92ZSBk
b2Vzbid0IG1ha2UKYW55IHNlbnNlIGFzIEZNT0RFX1JFQUQgYW5kIEZNT0RFX1dSSVRFIGFyZSBp
biBhIGNvbXBsZXRlbHkgZGlmZmVyZW50CnN5bWJvbCBzcGFjZSB0byBPXyosIGFuZCBub3QgYSBV
QVDQhiBidXQgYSBrZXJuZWwgaW50ZXJuYWwgdGhpbmcgdGhhdApjb3VsZCBiZSByZW51bWJlcmVk
IGFueSB0aW1lLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=

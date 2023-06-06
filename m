Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26758C7EE2A
	for <linux-um@archiver.kernel.org>; Tue,  6 Jun 2023 08:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:Cc:To:From:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=QhDukPysvjWDAY2I6ev/wi9sfx5T+pUe/iF0MwwGl2U=; b=AFOO5r7kbBr2rYvEG2Z5L1k73P
	l5L7OjwrH8xeK8s+zxXZfnm4SkDVdEa+pQRDSZkiYOGFWBblJ4E/lCyo5rmJyhC4DQaLYBjrpW8fU
	iqd80cYIBp+fdmT9SG2+s7Im7SzmjhrfYFthxUBsBvtyZaBgxOz/dCj6eFMAFnegfkLjQXoj48ZFw
	baZiPVTw4FuOARlMU/mWEnZaEMBW8uXDrFZMEnHdlHiZijUhO1X4FIet5o8WQmVgn15q3lnzQiGgJ
	DCqFNxn+MUGFVumcF1j/HOSTR/V9yBSRWVgzklt4QRp3uK7iKLTIjtbTJgX5Qo6iQOCes39QWyQdE
	XO9f9UeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6Rw1-000lz8-2J;
	Tue, 06 Jun 2023 08:20:57 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6Rvu-000lw3-1w;
	Tue, 06 Jun 2023 08:20:54 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 89E7C63CC135;
	Tue,  6 Jun 2023 10:20:47 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id w2bdPD93IvhE; Tue,  6 Jun 2023 10:20:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 14A1D616B2CD;
	Tue,  6 Jun 2023 10:20:47 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id X5LSD106M-YC; Tue,  6 Jun 2023 10:20:46 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id D62D563CC135;
	Tue,  6 Jun 2023 10:20:46 +0200 (CEST)
Date: Tue, 6 Jun 2023 10:20:46 +0200 (CEST)
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
	linux-um <linux-um@lists.infradead.org>, linux-scsi@vger.kernel.org, 
	linux-bcache@vger.kernel.org, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	linux-nvme@lists.infradead.org, 
	linux-btrfs <linux-btrfs@vger.kernel.org>, 
	linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>, 
	linux-nilfs@vger.kernel.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-pm <linux-pm@vger.kernel.org>
Message-ID: <766259639.3687124.1686039646763.JavaMail.zimbra@nod.at>
In-Reply-To: <20230606073950.225178-26-hch@lst.de>
References: <20230606073950.225178-1-hch@lst.de> <20230606073950.225178-26-hch@lst.de>
Subject: Re: [PATCH 25/31] ubd: remove commented out code in ubd_open
MIME-Version: 1.0
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: remove commented out code in ubd_open
Thread-Index: XkjrL/wptcQ24bQlPJHDQOJLYTpcmQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230606_012053_094379_38B8F9AB 
X-CRM114-Status: GOOD (  11.92  )
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
Cj4gVGhpcyBjb2RlIGhhcyBiZWVuIGRlYWQgZm9yZXZlciwgbWFrZSBzdXJlIGl0IGRvZXNuJ3Qg
c2hvdyB1cCBpbiBjb2RlCj4gc2VhcmNoZXMuCj4gCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3Bo
IEhlbGx3aWcgPGhjaEBsc3QuZGU+Cj4gLS0tCj4gYXJjaC91bS9kcml2ZXJzL3ViZF9rZXJuLmMg
fCA3IC0tLS0tLS0KPiAxIGZpbGUgY2hhbmdlZCwgNyBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0t
Z2l0IGEvYXJjaC91bS9kcml2ZXJzL3ViZF9rZXJuLmMgYi9hcmNoL3VtL2RyaXZlcnMvdWJkX2tl
cm4uYwo+IGluZGV4IDhiNzk1NTQ5NjhhZGRiLi4yMGMxYTE2MTk5YzUwMyAxMDA2NDQKPiAtLS0g
YS9hcmNoL3VtL2RyaXZlcnMvdWJkX2tlcm4uYwo+ICsrKyBiL2FyY2gvdW0vZHJpdmVycy91YmRf
a2Vybi5jCj4gQEAgLTExNzAsMTMgKzExNzAsNiBAQCBzdGF0aWMgaW50IHViZF9vcGVuKHN0cnVj
dCBnZW5kaXNrICpkaXNrLCBmbW9kZV90IG1vZGUpCj4gCX0KPiAJdWJkX2Rldi0+Y291bnQrKzsK
PiAJc2V0X2Rpc2tfcm8oZGlzaywgIXViZF9kZXYtPm9wZW5mbGFncy53KTsKPiAtCj4gLQkvKiBU
aGlzIHNob3VsZCBubyBtb3JlIGJlIG5lZWRlZC4gQW5kIGl0IGRpZG4ndCB3b3JrIGFueXdheSB0
byBleGNsdWRlCj4gLQkgKiByZWFkLXdyaXRlIHJlbW91bnRpbmcgb2YgZmlsZXN5c3RlbXMuKi8K
PiAtCS8qaWYoKG1vZGUgJiBGTU9ERV9XUklURSkgJiYgIXViZF9kZXYtPm9wZW5mbGFncy53KXsK
PiAtCSAgICAgICAgaWYoLS11YmRfZGV2LT5jb3VudCA9PSAwKSB1YmRfY2xvc2VfZGV2KHViZF9k
ZXYpOwo+IC0JICAgICAgICBlcnIgPSAtRVJPRlM7Cj4gLQl9Ki8KCkFja2VkLWJ5OiBSaWNoYXJk
IFdlaW5iZXJnZXIgPHJpY2hhcmRAbm9kLmF0PgoKVGhhbmtzLAovL3JpY2hhcmQKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcg
bGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K

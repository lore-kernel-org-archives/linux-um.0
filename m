Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEFBC7EE25
	for <linux-um@archiver.kernel.org>; Fri,  9 Jun 2023 06:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XhjgcbV316hYmVFhY4pLZgPnnc7p9bm5NQ2tUxU1YCw=; b=bizhBRIjCvVHbm
	K5ey967rx867V1D4/8BvaRakJuQlhpW5sYZXIEiTJXAItq0hOdQY/gfGDWps9pAbAdiwZm8i4F5XZ
	mFP2fx5BtNdJDvRDz1cOHt2mO4HyLmLYZDKu//vPumtZ9+Ujlzq/K41IEfox+YKDU2PRcQ6cQ2KWF
	7yWdnQPq8tEAVRor76101+YxzCAU5bYh/ugDNMTGy6My3z8+2uSN4M7u91UD34E2gHxcBiHf+xo8J
	/tvdFtGc2thInbFB+M1a5q/AZWe468n5aAktKnA3fRWcUGGDryjw5BPvi3lCV86oSeWZJxB1+AdmC
	7SBfFCYGmFNtcWnCGr9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7Vko-00Btbn-0o;
	Fri, 09 Jun 2023 06:37:46 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7Vkk-00Btab-2d;
	Fri, 09 Jun 2023 06:37:44 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C5AB621A53;
	Fri,  9 Jun 2023 06:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1686292659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AuLuFfaUhqZIlvqsrBqFCILQNfB9NBh4XQJqJuwBaak=;
	b=DfWcezE02xLifKYApRh/Add62cFaOcxnW3wNSvzD8w9yj5YaSZ2IJzFtcqTHWC93xEcGoZ
	5DIcDvnUzc7+rHwW+tvz398fOf28mmIhzoloOpuJ13hG/Af4ypuqo9UbqAddu8da4BuPJ6
	Ej17itybE9m84CucOtrfNyhxobciHic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1686292659;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AuLuFfaUhqZIlvqsrBqFCILQNfB9NBh4XQJqJuwBaak=;
	b=+5Awe/+aCoJv+pwVztOJIiCyAnb6pTZHwYvv7sP4i5Gc34IqAOSTrhZJJYJOAhtGbr6s8I
	YS3t00UaYTmcZuDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2374A139C8;
	Fri,  9 Jun 2023 06:37:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Jna4BrPIgmRfNwAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 09 Jun 2023 06:37:39 +0000
Message-ID: <f398627e-f69f-de42-d55d-2d497d208ae5@suse.de>
Date: Fri, 9 Jun 2023 08:37:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 05/30] cdrom: track if a cdrom_device_info was opened for
 data
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Richard Weinberger <richard@nod.at>, Josef Bacik <josef@toxicpanda.com>,
 "Md. Haris Iqbal" <haris.iqbal@ionos.com>, Jack Wang <jinpu.wang@ionos.com>,
 Phillip Potter <phil@philpotter.co.uk>, Coly Li <colyli@suse.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
 linux-block@vger.kernel.org, linux-um@lists.infradead.org,
 linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20230608110258.189493-1-hch@lst.de>
 <20230608110258.189493-6-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230608110258.189493-6-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230608_233743_042535_24069AE8 
X-CRM114-Status: GOOD (  13.39  )
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

T24gNi84LzIzIDEzOjAyLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBTZXQgYSBmbGFnIHdo
ZW4gYSBjZHJvbV9kZXZpY2VfaW5mbyBpcyBvcGVuZWQgZm9yIHdyaXRpbmcsIGluc3RlYWQgb2YK
PiB0cnlpbmcgdG8gZmlndXJlIG91dCB0aGlzIGF0IHJlbGVhc2UgdGltZS4gIFRoaXMgd2lsbCBh
bGxvdyB0byBldmVudHVhbGx5Cj4gcmVtb3ZlIHRoZSBtb2RlIGFyZ3VtZW50IHRvIHRoZSAtPnJl
bGVhc2UgYmxvY2tfZGV2aWNlX29wZXJhdGlvbiBhcwo+IG5vdGhpbmcgYnV0IHRoZSBDRFJPTSBk
cml2ZXJzIHVzZXMgdGhhdCBhcmd1bWVudC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGgg
SGVsbHdpZyA8aGNoQGxzdC5kZT4KPiBSZXZpZXdlZC1ieTogUGhpbGxpcCBQb3R0ZXIgPHBoaWxA
cGhpbHBvdHRlci5jby51az4KPiBBY2tlZC1ieTogQ2hyaXN0aWFuIEJyYXVuZXIgPGJyYXVuZXJA
a2VybmVsLm9yZz4KPiAtLS0KPiAgIGRyaXZlcnMvY2Ryb20vY2Ryb20uYyB8IDEyICsrKysrLS0t
LS0tLQo+ICAgaW5jbHVkZS9saW51eC9jZHJvbS5oIHwgIDEgKwo+ICAgMiBmaWxlcyBjaGFuZ2Vk
LCA2IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCj4gClJldmlld2VkLWJ5OiBIYW5uZXMg
UmVpbmVja2UgPGhhcmVAc3VzZS5kZT4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBS
ZWluZWNrZSAgICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNl
LmRlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBT
b2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhS
QiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEl2byBUb3RldiwgQW5k
cmV3Ck15ZXJzLCBBbmRyZXcgTWNEb25hbGQsIE1hcnRqZSBCb3VkaWVuIE1vZXJtYW4KCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWls
aW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==

Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87820C7EE25
	for <linux-um@archiver.kernel.org>; Fri,  9 Jun 2023 06:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0YkCiAux+jbBx/v7AVj4Z2TUYcuLpfnk8fzyguT9szc=; b=pHpzw4hRh+62Y9
	r6UuJidWWqZyev+iwZtIOCwyGdcQEp84h7a5pdJMrk9MddYYR/qXffJj22wWQz2O7gNKvGk7x6tjf
	aDkB9syvgfRTpdVRpaDFDRH4NUof+oUaE4O4F3lw7yTGOuWygmcJ1qRnGDt0sqTWtWzSxyhG046gN
	IIemdMmWySV/w6qf10DzUZb6mn7phDWZvTB8HdMkD27lJRx10KlAwryh5BTF9O7TDXA0JDM4LCQLF
	9ZaneCFMxKTGyMsfLc7PVh3J03IBnvFmv3yiWIoUjsoUP6BjMxLZMU08TpC8Xs6EsxzsdS9zsbHhl
	65xx1KyOCHCeDhJ/YbIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7Vo3-00BuR1-0a;
	Fri, 09 Jun 2023 06:41:07 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7Vny-00BuOL-2o;
	Fri, 09 Jun 2023 06:41:04 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 87DF021A01;
	Fri,  9 Jun 2023 06:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1686292861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fwirhtabGvCDuiR1jxZAiR7OdtCbwijcduPp+mqjcaE=;
	b=ehZ0672Jmg/d0MyG6AB71GZgF+CyZ7aCz0fEPEWeIM2+pQ9Yx7bDj7sHuPrhdKIDHah+B4
	x1845pdOYRa2De2VoQdmA0KAKObSWeKv9fEnhF1iOao6dTuYXRa5ZfsQfydIP8CefTEFZO
	h1zXrLjKHTLXFAO3wTXo8ujyMLb7Ym8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1686292861;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fwirhtabGvCDuiR1jxZAiR7OdtCbwijcduPp+mqjcaE=;
	b=tO7zUW+BGSFLyYxsGBGSKkQs6Pyd8vG0aztlZWiq/wA+rE6rLQYQ4enb0147Vn3wZhl3U9
	epRQIH1KZsrj8BAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 69262139C8;
	Fri,  9 Jun 2023 06:41:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id mrFJGHzJgmR1OAAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 09 Jun 2023 06:41:00 +0000
Message-ID: <61eab396-8424-ba7c-3ea1-7973330e0c57@suse.de>
Date: Fri, 9 Jun 2023 08:40:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [dm-devel] [PATCH 27/30] block: replace fmode_t with a
 block-specific type for block open flags
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-nvme@lists.infradead.org,
 Phillip Potter <phil@philpotter.co.uk>, Chris Mason <clm@fb.com>,
 dm-devel@redhat.com, "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
 Pavel Machek <pavel@ucw.cz>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Jack Wang <jinpu.wang@ionos.com>, linux-nilfs@vger.kernel.org,
 linux-scsi@vger.kernel.org, Richard Weinberger <richard@nod.at>,
 linux-pm@vger.kernel.org, linux-um@lists.infradead.org,
 Josef Bacik <josef@toxicpanda.com>, Coly Li <colyli@suse.de>,
 linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>,
 Christian Brauner <brauner@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-btrfs@vger.kernel.org
References: <20230608110258.189493-1-hch@lst.de>
 <20230608110258.189493-28-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230608110258.189493-28-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230608_234103_060408_C896150E 
X-CRM114-Status: GOOD (  13.81  )
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

T24gNi84LzIzIDEzOjAyLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBUaGUgb25seSBvdmVy
bGFwIGJldHdlZW4gdGhlIGJsb2NrIG9wZW4gZmxhZ3MgbWFwcGVkIGludG8gdGhlIGZtb2RlX3Qg
YW5kCj4gb3RoZXIgdXNlcyBvZiBmbW9kZV90IGFyZSBGTU9ERV9SRUFEIGFuZCBGTU9ERV9XUklU
RS4gIERlZmluZSBhIG5ldwo+IGJsa19tb2RlX3QgaW5zdGVhZCBmb3IgdXNlIGluIGJsa2Rldl9n
ZXRfYnlfe2RldixwYXRofSwgLT5vcGVuIGFuZAo+IC0+aW9jdGwgYW5kIHN0b3AgYWJ1c2luZyBm
bW9kZV90Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRl
Pgo+IEFja2VkLWJ5OiBKYWNrIFdhbmcgPGppbnB1LndhbmdAaW9ub3MuY29tPgkJW3JuYmRdCj4g
LS0tCj4gICBhcmNoL3VtL2RyaXZlcnMvdWJkX2tlcm4uYyAgICAgICAgICB8ICA4ICsrKy0tLQo+
ICAgYXJjaC94dGVuc2EvcGxhdGZvcm1zL2lzcy9zaW1kaXNrLmMgfCAgMiArLQo+ICAgYmxvY2sv
YmRldi5jICAgICAgICAgICAgICAgICAgICAgICAgfCAzMiArKysrKysrKysrKy0tLS0tLS0tLS0t
Cj4gICBibG9jay9ibGstem9uZWQuYyAgICAgICAgICAgICAgICAgICB8ICA4ICsrKy0tLQo+ICAg
YmxvY2svYmxrLmggICAgICAgICAgICAgICAgICAgICAgICAgfCAxMSArKysrLS0tLQo+ICAgYmxv
Y2svZm9wcy5jICAgICAgICAgICAgICAgICAgICAgICAgfCAzMiArKysrKysrKysrKysrKysrKy0t
LS0tCj4gICBibG9jay9nZW5oZC5jICAgICAgICAgICAgICAgICAgICAgICB8ICA4ICsrKy0tLQo+
ICAgYmxvY2svaW9jdGwuYyAgICAgICAgICAgICAgICAgICAgICAgfCA0MiArKysrKysrKystLS0t
LS0tLS0tLS0tLS0tLS0tLQo+ICAgZHJpdmVycy9ibG9jay9hbWlmbG9wLmMgICAgICAgICAgICAg
fCAxMiArKysrLS0tLS0KPiAgIGRyaXZlcnMvYmxvY2svYW9lL2FvZWJsay5jICAgICAgICAgIHwg
IDQgKy0tCj4gICBkcml2ZXJzL2Jsb2NrL2F0YWZsb3AuYyAgICAgICAgICAgICB8IDI1ICsrKysr
KysrKy0tLS0tLS0tCj4gICBkcml2ZXJzL2Jsb2NrL2RyYmQvZHJiZF9tYWluLmMgICAgICB8ICA3
ICsrLS0tCj4gICBkcml2ZXJzL2Jsb2NrL2RyYmQvZHJiZF9ubC5jICAgICAgICB8ICAyICstCj4g
ICBkcml2ZXJzL2Jsb2NrL2Zsb3BweS5jICAgICAgICAgICAgICB8IDI4ICsrKysrKysrKy0tLS0t
LS0tLS0KPiAgIGRyaXZlcnMvYmxvY2svbG9vcC5jICAgICAgICAgICAgICAgIHwgMjIgKysrKysr
Ky0tLS0tLS0tCj4gICBkcml2ZXJzL2Jsb2NrL210aXAzMnh4L210aXAzMnh4LmMgICB8ICA0ICst
LQo+ICAgZHJpdmVycy9ibG9jay9uYmQuYyAgICAgICAgICAgICAgICAgfCAgNCArLS0KPiAgIGRy
aXZlcnMvYmxvY2svcGt0Y2R2ZC5jICAgICAgICAgICAgIHwgMTcgKysrKysrLS0tLS0tCj4gICBk
cml2ZXJzL2Jsb2NrL3JiZC5jICAgICAgICAgICAgICAgICB8ICAyICstCj4gICBkcml2ZXJzL2Js
b2NrL3JuYmQvcm5iZC1jbHQuYyAgICAgICB8ICA0ICstLQo+ICAgZHJpdmVycy9ibG9jay9ybmJk
L3JuYmQtc3J2LmMgICAgICAgfCAgNCArLS0KPiAgIGRyaXZlcnMvYmxvY2svc3VudmRjLmMgICAg
ICAgICAgICAgIHwgIDIgKy0KPiAgIGRyaXZlcnMvYmxvY2svc3dpbS5jICAgICAgICAgICAgICAg
IHwgMTYgKysrKystLS0tLS0KPiAgIGRyaXZlcnMvYmxvY2svc3dpbTMuYyAgICAgICAgICAgICAg
IHwgMjQgKysrKysrKystLS0tLS0tLS0KPiAgIGRyaXZlcnMvYmxvY2svdWJsa19kcnYuYyAgICAg
ICAgICAgIHwgIDIgKy0KPiAgIGRyaXZlcnMvYmxvY2sveGVuLWJsa2JhY2sveGVuYnVzLmMgIHwg
IDIgKy0KPiAgIGRyaXZlcnMvYmxvY2sveGVuLWJsa2Zyb250LmMgICAgICAgIHwgIDIgKy0KPiAg
IGRyaXZlcnMvYmxvY2svejJyYW0uYyAgICAgICAgICAgICAgIHwgIDIgKy0KPiAgIGRyaXZlcnMv
YmxvY2svenJhbS96cmFtX2Rydi5jICAgICAgIHwgIDYgKystLS0KPiAgIGRyaXZlcnMvY2Ryb20v
Y2Ryb20uYyAgICAgICAgICAgICAgIHwgIDYgKystLS0KPiAgIGRyaXZlcnMvY2Ryb20vZ2Ryb20u
YyAgICAgICAgICAgICAgIHwgIDQgKy0tCj4gICBkcml2ZXJzL21kL2JjYWNoZS9iY2FjaGUuaCAg
ICAgICAgICB8ICAyICstCj4gICBkcml2ZXJzL21kL2JjYWNoZS9yZXF1ZXN0LmMgICAgICAgICB8
ICA0ICstLQo+ICAgZHJpdmVycy9tZC9iY2FjaGUvc3VwZXIuYyAgICAgICAgICAgfCAgNiArKy0t
LQo+ICAgZHJpdmVycy9tZC9kbS1jYWNoZS10YXJnZXQuYyAgICAgICAgfCAxMiArKysrLS0tLS0K
PiAgIGRyaXZlcnMvbWQvZG0tY2xvbmUtdGFyZ2V0LmMgICAgICAgIHwgMTAgKysrLS0tLQo+ICAg
ZHJpdmVycy9tZC9kbS1jb3JlLmggICAgICAgICAgICAgICAgfCAgNyArKystLQo+ICAgZHJpdmVy
cy9tZC9kbS1lcmEtdGFyZ2V0LmMgICAgICAgICAgfCAgNiArKystLQo+ICAgZHJpdmVycy9tZC9k
bS1pb2N0bC5jICAgICAgICAgICAgICAgfCAxMCArKystLS0tCj4gICBkcml2ZXJzL21kL2RtLXNu
YXAuYyAgICAgICAgICAgICAgICB8ICA0ICstLQo+ICAgZHJpdmVycy9tZC9kbS10YWJsZS5jICAg
ICAgICAgICAgICAgfCAxMSArKysrLS0tLQo+ICAgZHJpdmVycy9tZC9kbS10aGluLmMgICAgICAg
ICAgICAgICAgfCAgOSArKysrLS0tCj4gICBkcml2ZXJzL21kL2RtLXZlcml0eS1mZWMuYyAgICAg
ICAgICB8ICAyICstCj4gICBkcml2ZXJzL21kL2RtLXZlcml0eS10YXJnZXQuYyAgICAgICB8ICA2
ICsrLS0tCj4gICBkcml2ZXJzL21kL2RtLmMgICAgICAgICAgICAgICAgICAgICB8IDEwICsrKy0t
LS0KPiAgIGRyaXZlcnMvbWQvZG0uaCAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0KPiAgIGRy
aXZlcnMvbWQvbWQuYyAgICAgICAgICAgICAgICAgICAgIHwgIDggKysrLS0tCj4gICBkcml2ZXJz
L21tYy9jb3JlL2Jsb2NrLmMgICAgICAgICAgICB8ICA4ICsrKy0tLQo+ICAgZHJpdmVycy9tdGQv
ZGV2aWNlcy9ibG9jazJtdGQuYyAgICAgfCAgNCArLS0KPiAgIGRyaXZlcnMvbXRkL210ZF9ibGtk
ZXZzLmMgICAgICAgICAgIHwgIDQgKy0tCj4gICBkcml2ZXJzL210ZC91YmkvYmxvY2suYyAgICAg
ICAgICAgICB8ICA1ICsrLS0KPiAgIGRyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyAgICAgICAgICAg
IHwgIDIgKy0KPiAgIGRyaXZlcnMvbnZtZS9ob3N0L2lvY3RsLmMgICAgICAgICAgIHwgIDggKysr
LS0tCj4gICBkcml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYyAgICAgICB8ICAyICstCj4gICBk
cml2ZXJzL252bWUvaG9zdC9udm1lLmggICAgICAgICAgICB8ICA0ICstLQo+ICAgZHJpdmVycy9u
dm1lL3RhcmdldC9pby1jbWQtYmRldi5jICAgfCAgMiArLQo+ICAgZHJpdmVycy9zMzkwL2Jsb2Nr
L2Rhc2QuYyAgICAgICAgICAgfCAgNiArKy0tLQo+ICAgZHJpdmVycy9zMzkwL2Jsb2NrL2Rhc2Rf
Z2VuaGQuYyAgICAgfCAgMyArKy0KPiAgIGRyaXZlcnMvczM5MC9ibG9jay9kYXNkX2ludC5oICAg
ICAgIHwgIDMgKystCj4gICBkcml2ZXJzL3MzOTAvYmxvY2svZGFzZF9pb2N0bC5jICAgICB8ICAy
ICstCj4gICBkcml2ZXJzL3MzOTAvYmxvY2svZGNzc2Jsay5jICAgICAgICB8ICA0ICstLQo+ICAg
ZHJpdmVycy9zY3NpL3NkLmMgICAgICAgICAgICAgICAgICAgfCAxOSArKysrKystLS0tLS0tCj4g
ICBkcml2ZXJzL3Njc2kvc3IuYyAgICAgICAgICAgICAgICAgICB8IDEwICsrKy0tLS0KPiAgIGRy
aXZlcnMvdGFyZ2V0L3RhcmdldF9jb3JlX2libG9jay5jIHwgIDUgKystLQo+ICAgZHJpdmVycy90
YXJnZXQvdGFyZ2V0X2NvcmVfcHNjc2kuYyAgfCAgNCArLS0KPiAgIGZzL2J0cmZzL2Rldi1yZXBs
YWNlLmMgICAgICAgICAgICAgIHwgIDIgKy0KPiAgIGZzL2J0cmZzL3N1cGVyLmMgICAgICAgICAg
ICAgICAgICAgIHwgIDggKysrLS0tCj4gICBmcy9idHJmcy92b2x1bWVzLmMgICAgICAgICAgICAg
ICAgICB8IDE2ICsrKysrLS0tLS0tCj4gICBmcy9idHJmcy92b2x1bWVzLmggICAgICAgICAgICAg
ICAgICB8ICA0ICstLQo+ICAgZnMvZXJvZnMvc3VwZXIuYyAgICAgICAgICAgICAgICAgICAgfCAg
MiArLQo+ICAgZnMvZXh0NC9zdXBlci5jICAgICAgICAgICAgICAgICAgICAgfCAgMiArLQo+ICAg
ZnMvZjJmcy9zdXBlci5jICAgICAgICAgICAgICAgICAgICAgfCAgMiArLQo+ICAgZnMvamZzL2pm
c19sb2dtZ3IuYyAgICAgICAgICAgICAgICAgfCAgMiArLQo+ICAgZnMvbmZzL2Jsb2NrbGF5b3V0
L2Rldi5jICAgICAgICAgICAgfCAgNSArKy0tCj4gICBmcy9vY2ZzMi9jbHVzdGVyL2hlYXJ0YmVh
dC5jICAgICAgICB8ICAzICsrLQo+ICAgZnMvcmVpc2VyZnMvam91cm5hbC5jICAgICAgICAgICAg
ICAgfCAgNCArLS0KPiAgIGZzL3hmcy94ZnNfc3VwZXIuYyAgICAgICAgICAgICAgICAgIHwgIDIg
Ky0KPiAgIGluY2x1ZGUvbGludXgvYmxrZGV2LmggICAgICAgICAgICAgIHwgMzAgKysrKysrKysr
KysrKysrKy0tLS0tCj4gICBpbmNsdWRlL2xpbnV4L2Nkcm9tLmggICAgICAgICAgICAgICB8ICAz
ICsrLQo+ICAgaW5jbHVkZS9saW51eC9kZXZpY2UtbWFwcGVyLmggICAgICAgfCAgOCArKystLS0K
PiAgIGtlcm5lbC9wb3dlci9zd2FwLmMgICAgICAgICAgICAgICAgIHwgIDYgKystLS0KPiAgIG1t
L3N3YXBmaWxlLmMgICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0KPiAgIDgyIGZpbGVzIGNo
YW5nZWQsIDMzNCBpbnNlcnRpb25zKCspLCAzMTUgZGVsZXRpb25zKC0pCj4gClJldmlld2VkLWJ5
OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIu
IEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QK
aGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2
ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8
cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEl2byBU
b3RldiwgQW5kcmV3Ck15ZXJzLCBBbmRyZXcgTWNEb25hbGQsIE1hcnRqZSBCb3VkaWVuIE1vZXJt
YW4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==

Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44580E706E3
	for <linux-um@archiver.kernel.org>; Thu, 21 Sep 2023 08:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YyCyGQe3S6fn3A6qJG5F+OaDzOnWm0sZ5zYkgwYlglM=; b=PFnnkAqZ1ydTLz
	YGXMXgwpub5Nzr/uXuNS9N4cfk/vyWei/mAfvvBaGPUpgIj25G3D7hOfIMrvx/9ILv9kyWkX7VGYy
	vEnBtFSQTuHbTgJ2VsqvFOyo52yllrFwIL96uhTtjxvxcdUzbk8Muoq8RZ7BAlgBQGTPxgRZscXkc
	HP/ixhbR+tfodkCYWE9dq9pEgP9W4DV3D0QZhp9kteTTZVv1A3N9G6roNbGYW2VvNWCUpmXe7qzGV
	NvkT4CVOG2Eaf5DTSPUBWxZ3nRKcrV8JiaeTGF2yQKdLUAgT3W/oyvrjateQ09a4/DY2J1k9tlfu2
	u+Xg4ptxN63p9fmXaMHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjEbz-005QnI-0Z;
	Thu, 21 Sep 2023 08:00:35 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjEbw-005QmL-1X
	for linux-um@lists.infradead.org;
	Thu, 21 Sep 2023 08:00:34 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qjEbs-002YDB-DM; Thu, 21 Sep 2023 08:00:28 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qjEbp-000iMk-OG; Thu, 21 Sep 2023 09:00:27 +0100
Message-ID: <f30a2744-4a0d-910c-39da-771520d3f8e2@cambridgegreys.com>
Date: Thu, 21 Sep 2023 09:00:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] um: Enable preemption in UML
Content-Language: en-US
To: Richard Weinberger <richard@nod.at>
Cc: Peter Lafreniere <peter@n8pjl.ca>,
 Johannes Berg <johannes@sipsolutions.net>,
 linux-um <linux-um@lists.infradead.org>
References: <20230920123115.4106721-1-anton.ivanov@cambridgegreys.com>
 <20230920144943.19271-1-peter@n8pjl.ca>
 <a52c2c87-87d9-d93b-3089-976ffbcb089b@cambridgegreys.com>
 <1267632977.64055.1695281421091.JavaMail.zimbra@nod.at>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <1267632977.64055.1695281421091.JavaMail.zimbra@nod.at>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230921_010032_512522_6F793701 
X-CRM114-Status: GOOD (  10.60  )
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

Ck9uIDIxLzA5LzIwMjMgMDg6MzAsIFJpY2hhcmQgV2VpbmJlcmdlciB3cm90ZToKPiAtLS0tLSBV
cnNwcsO8bmdsaWNoZSBNYWlsIC0tLS0tCj4+IFZvbjogImFudG9uIGl2YW5vdiIgPGFudG9uLml2
YW5vdkBjYW1icmlkZ2VncmV5cy5jb20+Cj4+IEFuOiAiUGV0ZXIgTGFmcmVuaWVyZSIgPHBldGVy
QG44cGpsLmNhPgo+PiBDQzogIkpvaGFubmVzIEJlcmciIDxqb2hhbm5lc0BzaXBzb2x1dGlvbnMu
bmV0PiwgImxpbnV4LXVtIiA8bGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZz4sICJyaWNoYXJk
IiA8cmljaGFyZEBub2QuYXQ+Cj4+IEdlc2VuZGV0OiBEb25uZXJzdGFnLCAyMS4gU2VwdGVtYmVy
IDIwMjMgMDk6MTI6MzMKPj4gQmV0cmVmZjogUmU6IFtQQVRDSF0gdW06IEVuYWJsZSBwcmVlbXB0
aW9uIGluIFVNTAo+PiBPbiAyMC8wOS8yMDIzIDE1OjQ5LCBQZXRlciBMYWZyZW5pZXJlIHdyb3Rl
Ogo+Pj4gT24gV2VkLCBTZXAgMjAsIDIwMjMgYXQgMDg6MzEsIGFudG9uLml2YW5vdkBjYW1icmlk
Z2VncmV5cy5jb20gd3JvdGU6Cj4+Pj4gRnJvbTogQW50b24gSXZhbm92IGFudG9uLml2YW5vdkBj
YW1icmlkZ2VncmV5cy5jb20KPj4+Pgo+Pj4+Cj4+Pj4gUHJlZW1wdGlvbiByZXF1aXJlcyBzYXZp
bmcvcmVzdG9yaW5nIEZQVSBzdGF0ZS4gVGhpcyBwYXRjaAo+Pj4+IGFkZHMgc3VwcG9ydCBmb3Ig
aXQgdXNpbmcgR0NDIGludHJpbnNpY3MuCj4+Pj4KPj4+PiBTaWduZWQtb2ZmLWJ5OiBBbnRvbiBJ
dmFub3YgYW50b24uaXZhbm92QGNhbWJyaWRnZWdyZXlzLmNvbQo+IEknbSBub3Qgc28gc3VyZSB3
aGV0aGVyIHdlIHNob3VsZCByZWFsbHkgZGlyZWN0bHkgc3RhcnQgd2l0aCBDT05GSUdfUFJFRU1Q
VC4KCkkgaGF2ZSBtYW5hZ2VkIHRvIG1ha2UgaXQgd29yayBleGNlcHQgdGhlIElSUSByZXR1cm4g
Yml0IHN1Z2dlc3RlZCBieSBQZXRlci4gV2UgYXJlIHF1aXRlIHBhcmFub2lkIHJlZ2FyZGluZyBs
b2NraW5nIGFuZCB3ZSBhcmUgVVAgc28gbmVhcmx5IGFsbCBvZiBpdCB3b3JrZWQgb3V0IG9mIHRo
ZSBib3guCgo+IEhvdyBhYm91dCBpbXBsZW1lbnRpbmcgQ09ORklHX1BSRUVNUFRfQ09VTlQgZmly
c3Q/CgpTdXJlLiBXaWxsIHRyeSB0aGF0IHRvZGF5LgoKPgo+IFRoYW5rcywKPiAvL3JpY2hhcmQK
PgotLSAKQW50b24gUi4gSXZhbm92CkNhbWJyaWRnZWdyZXlzIExpbWl0ZWQuIFJlZ2lzdGVyZWQg
aW4gRW5nbGFuZC4gQ29tcGFueSBOdW1iZXIgMTAyNzM2NjEKaHR0cHM6Ly93d3cuY2FtYnJpZGdl
Z3JleXMuY29tLwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K

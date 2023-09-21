Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B43CD5BD5
	for <linux-um@archiver.kernel.org>; Thu, 21 Sep 2023 07:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:Cc:To:From:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=XqjifYK0pcaWntjVPa1QfAloPAP4Aedv46yyb3+RWvQ=; b=H20XcxZz2EvLnhH1Pkj2bgGIBn
	BBerqUSyAbhti4bWGQxSrc/zr2PNrsvXbheduBH4yzK/Jq0nXtOuMWR5Vyh9yanh87KVlADfqy5hM
	hCUf5vKMoaBWzt7ECXTBaf29ogwE86ETW1An0XBO1AuKptzcr9VEIZoNk1LHfJpLXcCe0OgApEDHl
	qX2i23Uf6RP/LLit6uzUjPD2zv+6iYK4BbalmJWmbPByUPeImFbNtE9MaaCzGR9kFJCWY5EAnuzHE
	XpGYlFL58Rio0vQSw91d8ejuI+MGpG5VBmP18Bn2Bc4gkUKM6yiTYCeIaS9gSZS6j3JpqF/WQz7JU
	zXeV1RmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjE8r-005N52-22;
	Thu, 21 Sep 2023 07:30:29 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjE8o-005N3K-2o
	for linux-um@lists.infradead.org;
	Thu, 21 Sep 2023 07:30:28 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 03853635DB4D;
	Thu, 21 Sep 2023 09:30:22 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id DhqprUd1DJ6z; Thu, 21 Sep 2023 09:30:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 69EEE6234894;
	Thu, 21 Sep 2023 09:30:21 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZV62u1ISTiM7; Thu, 21 Sep 2023 09:30:21 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 3C1BA635DB4D;
	Thu, 21 Sep 2023 09:30:21 +0200 (CEST)
Date: Thu, 21 Sep 2023 09:30:21 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: anton ivanov <anton.ivanov@cambridgegreys.com>
Cc: Peter Lafreniere <peter@n8pjl.ca>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-um <linux-um@lists.infradead.org>
Message-ID: <1267632977.64055.1695281421091.JavaMail.zimbra@nod.at>
In-Reply-To: <a52c2c87-87d9-d93b-3089-976ffbcb089b@cambridgegreys.com>
References: <20230920123115.4106721-1-anton.ivanov@cambridgegreys.com> <20230920144943.19271-1-peter@n8pjl.ca> <a52c2c87-87d9-d93b-3089-976ffbcb089b@cambridgegreys.com>
Subject: Re: [PATCH] um: Enable preemption in UML
MIME-Version: 1.0
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Enable preemption in UML
Thread-Index: 1mJuC8CkB8tajiG2KA40s6cq4c/DKA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230921_003027_085423_D22EABB2 
X-CRM114-Status: UNSURE (   4.84  )
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

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IFZvbjogImFudG9uIGl2YW5vdiIgPGFu
dG9uLml2YW5vdkBjYW1icmlkZ2VncmV5cy5jb20+Cj4gQW46ICJQZXRlciBMYWZyZW5pZXJlIiA8
cGV0ZXJAbjhwamwuY2E+Cj4gQ0M6ICJKb2hhbm5lcyBCZXJnIiA8am9oYW5uZXNAc2lwc29sdXRp
b25zLm5ldD4sICJsaW51eC11bSIgPGxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmc+LCAicmlj
aGFyZCIgPHJpY2hhcmRAbm9kLmF0Pgo+IEdlc2VuZGV0OiBEb25uZXJzdGFnLCAyMS4gU2VwdGVt
YmVyIDIwMjMgMDk6MTI6MzMKPiBCZXRyZWZmOiBSZTogW1BBVENIXSB1bTogRW5hYmxlIHByZWVt
cHRpb24gaW4gVU1MCgo+IE9uIDIwLzA5LzIwMjMgMTU6NDksIFBldGVyIExhZnJlbmllcmUgd3Jv
dGU6Cj4+IE9uIFdlZCwgU2VwIDIwLCAyMDIzIGF0IDA4OjMxLCBhbnRvbi5pdmFub3ZAY2FtYnJp
ZGdlZ3JleXMuY29tIHdyb3RlOgo+Pj4gRnJvbTogQW50b24gSXZhbm92IGFudG9uLml2YW5vdkBj
YW1icmlkZ2VncmV5cy5jb20KPj4+Cj4+Pgo+Pj4gUHJlZW1wdGlvbiByZXF1aXJlcyBzYXZpbmcv
cmVzdG9yaW5nIEZQVSBzdGF0ZS4gVGhpcyBwYXRjaAo+Pj4gYWRkcyBzdXBwb3J0IGZvciBpdCB1
c2luZyBHQ0MgaW50cmluc2ljcy4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBBbnRvbiBJdmFub3Yg
YW50b24uaXZhbm92QGNhbWJyaWRnZWdyZXlzLmNvbQoKSSdtIG5vdCBzbyBzdXJlIHdoZXRoZXIg
d2Ugc2hvdWxkIHJlYWxseSBkaXJlY3RseSBzdGFydCB3aXRoIENPTkZJR19QUkVFTVBULgpIb3cg
YWJvdXQgaW1wbGVtZW50aW5nIENPTkZJR19QUkVFTVBUX0NPVU5UIGZpcnN0PwoKVGhhbmtzLAov
L3JpY2hhcmQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K

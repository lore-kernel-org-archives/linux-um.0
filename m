Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC5FC38142
	for <linux-um@archiver.kernel.org>; Tue, 31 Jan 2023 07:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:Cc:To:From:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=nZdsgk/gm/1jOUd9AAibHx3Ts+19G1q5ylvDMp3LDiI=; b=XMEvbNFWwiz0C5Fm08uoDLnpFM
	88WXz+4yUUMfR+nh1qQQ/qq/NQMhLF3eX3lnUtDa7w9ZB8jZW+mZOGyW/k7I9RP8AsBpqaWz55fDa
	qu3ha5VGUSsL/yC5HniR30/1cZtTaX2jY7QYEoopFCNCBTgrdO8X7N6Tik8RPZVYJyKYajt3h44Nb
	CPEZyWzsUUVO6Y6hWG8xZSf9KZntrFlDbnmoWOp3sfoJtSh9nVHv3sbnZ44uQrXYCERXetYV2r6tT
	7DULx598Zqc2ksjsMLwGbSM749JFPTvrjzgLX7rgYpaJ4V2i6xdtlbpBx6lW3FSLBv3C9ljfQjHql
	HqjccJww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMkys-006Yxk-Lr; Tue, 31 Jan 2023 07:23:02 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMkyp-006Yvr-Lg
	for linux-um@lists.infradead.org; Tue, 31 Jan 2023 07:23:01 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id EEAA6622623A;
	Tue, 31 Jan 2023 08:22:45 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Vrka5epifJMK; Tue, 31 Jan 2023 08:22:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 91D596399237;
	Tue, 31 Jan 2023 08:22:45 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FIQUPW8xperW; Tue, 31 Jan 2023 08:22:45 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 71500622623A;
	Tue, 31 Jan 2023 08:22:45 +0100 (CET)
Date: Tue, 31 Jan 2023 08:22:45 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Cc: Glenn Washburn <development@efficientek.com>, 
	linux-um <linux-um@lists.infradead.org>, 
	Johannes Berg <johannes@sipsolutions.net>
Message-ID: <1215849138.84344.1675149765214.JavaMail.zimbra@nod.at>
In-Reply-To: <aa957c80-1aeb-8fde-440e-6e4408c59559@kot-begemot.co.uk>
References: <20230130221748.5c472da5@crass-HP-ZBook-15-G2> <aa957c80-1aeb-8fde-440e-6e4408c59559@kot-begemot.co.uk>
Subject: Re: Using ftrace
MIME-Version: 1.0
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Using ftrace
Thread-Index: Kt3tdRZa2IRKl1d6pRQid7ZHX4g4pw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230130_232259_896692_099267BE 
X-CRM114-Status: UNSURE (   7.09  )
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

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IFZvbjogIkFudG9uIEl2YW5vdiIgPGFu
dG9uLml2YW5vdkBrb3QtYmVnZW1vdC5jby51az4KPiBPbiAzMS8wMS8yMDIzIDA0OjE3LCBHbGVu
biBXYXNoYnVybiB3cm90ZToKPj4gSSdtIHRyeWluZyB0byB1c2UgdGhlIGZ0cmFjZSBmYWNpbGl0
eSB3aXRoaW4gVU1MLiBJdCBhcHBlYXJzIGFzIHRob3VnaAo+PiBpdCBleGlzdHMgaW4gdGhlIG1l
bnVjb25maWcsIGJ1dCBJIGNhbid0IHNlZW0gdG8gZ2V0IHRoZSBrZXJuZWwgdG8KPj4gcmVjb2du
aXplIHRoZSB0cmFjZWZzIGZpbGVzeXN0ZW0uIEknbSB3b25kZXJpbmcgaWYgc29tZW9uZSBjYW4g
Y29uZmlybQo+PiB0aGF0IGVpdGhlciBmdHJhY2UgZG9lcyBvciBkb2VzIG5vdCB3b3JrIGluIFVN
TC4KPiAKPiBJIGhhdmUgbm90IHVzZWQgaXQuIFdlIGhhdmUgbm90IGhhZCBhbnkgcmVxdWVzdHMg
cmVsYXRlZCB0byBpdCBlaXRoZXIKPiAKPiBJIHdpbGwgbG9vayBpbnRvIGl0LgoKVHJhY2luZyBp
dHNlbGYgc2hvdWxkIHdvcmsuIEJ1dCBmdW5jdGlvbiB0cmFjaW5nIGlzIG5vdCBzdXBwb3J0ZWQu
CllvdSdsbCBnZXQgdHJhY2VmcyBhcyBzb29uIHlvdSBzZWxlY3Qgb25lIHRyYWNlciAoc3VjaCBh
cyBDT05GSUdfSVJRU09GRl9UUkFDRVIpLgoKQWRkaW5nIGZ1bmN0aW9uIChhbmQgZnVuY3Rpb24g
Z3JhcGgpIHRyYWNpbmcgdG8gVU1MIGlzIHBvc3NpYmxlIGJ1dCBhIGJpdCBvZiB3b3JrLgpZb3Ug
bmVlZCB0byBmaW5kIGEgd2F5IHRvIGltcGxlbWVudCBhbGwgb2YgZnRyYWNlcyBtY291bnQgaG9v
a3MgZm9yIFVNTC4KClRoYW5rcywKLy9yaWNoYXJkCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LXVtCg==

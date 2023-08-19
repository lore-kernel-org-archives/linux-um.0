Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1CD9EE49A5
	for <linux-um@archiver.kernel.org>; Sat, 19 Aug 2023 21:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:Cc:To:From:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=4+Vqsu0/i4XEstWKDAqj7nipgNam1T1ZlD6C/eJ+wUE=; b=Fb8OYs9FMkLfdHbayre+pqOefr
	wxtJ9i1b48nQXScMoqWmQikxpF2Xf5xWVIzQP5stso2rweqq+GM/G45KR2cOxinY8qJF7V5SUExE/
	qWa3B1JcICFWzCJm1Lsl5XFeqFoiOCxgVxjJqx5U1f4DZJKExSQRpqg2j8DPSVGg+LAyPXXjhKbaH
	vfKaNK0ejZ4Ha+hWS7mx+yQd0nbTJbMW6/tc2+f52Y1H9m7A2JPE5gTj6PtNzd/SofF4YQ9uuag54
	dX/Fo/x/ryxIEvmvBaEWBAMT/paoTQJ0gNwLf3tn6ZgVg7vYNni/ygSkEFZPdXsoIF/u1W20EoK1N
	NX9dx88w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qXTBA-00BBRG-2C;
	Sat, 19 Aug 2023 21:08:16 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qXTB7-00BBQv-1P
	for linux-um@lists.infradead.org;
	Sat, 19 Aug 2023 21:08:14 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id D724463DB803;
	Sat, 19 Aug 2023 23:08:11 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id kHl1OPWAh-P7; Sat, 19 Aug 2023 23:08:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 7AB6963DB801;
	Sat, 19 Aug 2023 23:08:11 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 5W9G0FvcbqQr; Sat, 19 Aug 2023 23:08:11 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 3B78E63DB7E5;
	Sat, 19 Aug 2023 23:08:11 +0200 (CEST)
Date: Sat, 19 Aug 2023 23:08:11 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: masahiroy <masahiroy@kernel.org>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	linux-um <linux-um@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-kbuild <linux-kbuild@vger.kernel.org>, 
	Jiri Slaby <jirislaby@kernel.org>, bp <bp@alien8.de>, 
	dave hansen <dave.hansen@linux.intel.com>, hpa <hpa@zytor.com>, 
	mingo <mingo@redhat.com>, tglx <tglx@linutronix.de>, 
	x86 <x86@kernel.org>
Message-ID: <707999896.6490583.1692479291135.JavaMail.zimbra@nod.at>
In-Reply-To: <20230721171857.3612639-1-masahiroy@kernel.org>
References: <20230721171857.3612639-1-masahiroy@kernel.org>
Subject: Re: [PATCH v2 1/2] UML: hard-code the result of 'uname -s'
MIME-Version: 1.0
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: hard-code the result of 'uname -s'
Thread-Index: QAVkLQ/mIgPHvNavgfzggSVolfSknw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230819_140813_632788_28C5F9F9 
X-CRM114-Status: UNSURE (   4.00  )
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

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IFZvbjogIm1hc2FoaXJveSIgPG1hc2Fo
aXJveUBrZXJuZWwub3JnPgo+IFdlIHJlbHkgb24gJ3VuYW1lIC1zJyByZXR1cm5pbmcgJ0xpbnV4
JyBiZWNhdXNlIHRoZXJlIGFyZSBvcy1MaW51eC8KPiBkaXJlY3RvcmllcywgYnV0IG5vIG90aGVy
IG9zLSovLgo+IAo+IFN1cHBvcnRpbmcgYSBub24tTGludXggaG9zdCBpcyB1bmxpa2VseSB0byBo
YXBwZW4uCj4gCj4gTGV0J3MgaGFyZC1jb2RlICdMaW51eCcuCgpXaGlsZSBJIGFncmVlIHRoYXQg
YSBub24tTGludXggdmVyc2lvbiBpcyB1bmxpa2VseSBJJ2QgbGlrZSB0bwprbm93IHdoeSB3ZSBj
YW4ndCBrZWVwIHRoZSB1bmFtZSAtcyBjaGVjaz8KSSBndWVzcyB0byBhdm9pZCB1bm5lY2Vzc2Fy
eSBjb21tYW5kIGV4ZWN1dGlvbj8KClRoYW5rcywKLy9yaWNoYXJkCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGlu
dXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==

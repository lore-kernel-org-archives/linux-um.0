Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35752C77B73
	for <linux-um@archiver.kernel.org>; Wed, 31 May 2023 06:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:Cc:To:From:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=C+xXZR36cbiW3wTQjszJMx2Kf2M2ujnJqXR8GsyrO6U=; b=wUqTU9hb7lXvkZ+vHi9DLq6y+U
	X/KvAS9VQov9j4mW9ijU4hB5TH3EKc0dtl3MXHiPDlmQtgNIuL0UC8GW6ThpIxHpVQSvh4fwS6tf7
	l0lmnZK5G6tf+X4dXShcTefh5vW9FEy7XKI2pEhVMgDx+kLUOPbxF5+50d/FX4dRNDoNcMMyPS4lo
	WRo0foVIw7O03dUAPfGBmAhg/HQKzNK3o8SQfvfBa4kEmcQ73caREDMhOYVOt/yznBNoSpS4RgDd0
	TTosB3XZHgrT9LWBB1h0HLXMaavE+78zPS8b8J/fdmqAo34kDtbQTlYMM+meD2S9moKdUcqcrdX2O
	xmB7gJbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4FI0-00GHXp-0a;
	Wed, 31 May 2023 06:26:32 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4FHx-00GHXB-0Q
	for linux-um@lists.infradead.org;
	Wed, 31 May 2023 06:26:30 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 6F1F661CECF8;
	Wed, 31 May 2023 08:26:27 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id OMHGyQ5Lvv4L; Wed, 31 May 2023 08:26:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 21F3561A7038;
	Wed, 31 May 2023 08:26:27 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6iJ5euobrcBa; Wed, 31 May 2023 08:26:27 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id E70AC616B2CF;
	Wed, 31 May 2023 08:26:26 +0200 (CEST)
Date: Wed, 31 May 2023 08:26:26 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Johannes Berg <johannes@sipsolutions.net>, 
	Azeem Shaikh <azeemshaikh38@gmail.com>
Cc: Kees Cook <kees@kernel.org>, kernel test robot <lkp@intel.com>, 
	Maxim Krasnyansky <maxk@qti.qualcomm.com>, 
	oe-kbuild-all <oe-kbuild-all@lists.linux.dev>, 
	linux-hardening <linux-hardening@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	anton ivanov <anton.ivanov@cambridgegreys.com>, 
	linux-um <linux-um@lists.infradead.org>
Message-ID: <959209724.158062.1685514386841.JavaMail.zimbra@nod.at>
In-Reply-To: <8033fb8f9677cf9aae411e97eb554d251ca03011.camel@sipsolutions.net>
References: <20230530164004.986750-1-azeemshaikh38@gmail.com> <202305311135.zGMT1gYR-lkp@intel.com> <09A0C6FA-669F-4B73-9620-43AEA17E5D0C@kernel.org> <8033fb8f9677cf9aae411e97eb554d251ca03011.camel@sipsolutions.net>
Subject: Re: [PATCH] uml: Replace all non-returning strlcpy with strscpy
MIME-Version: 1.0
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Replace all non-returning strlcpy with strscpy
Thread-Index: hWem4mJ9JdjGKB725Dk79ubQ3raPHg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230530_232629_342168_3864F28F 
X-CRM114-Status: UNSURE (   6.64  )
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

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+PiBBaCwgeWVhaCwgdGhpcyBpcyBhbm90
aGVyICJub3QgYWN0dWFsbHkgaW4gdGhlIGtlcm5lbCIgY2FzZXMuIExldCdzIGlnbm9yZSB0aGlz
Cj4+IHN0cmxjcHkgZm9yIG5vdy4KPj4gCj4gCj4gV2VsbCwgc3RybGNweSgpIGlzbid0IHBhcnQg
b2YgbGliYyBlaXRoZXIsIHNvIGFsbCB0aGlzIHdvdWxkIG5lZWQgaXMgdG8KPiBhZGQgaXQgdG8g
dXNlci5oIGp1c3QgbGlrZSBzdHJsY3B5KCkgaXMgbm93PwoKSSB0aGluayBzby4KQXplZW0sIGNh
biB5b3UgcGxlYXNlIHRlc3QgeW91ciBjaGFuZ2VzIHdpdGggdGhpcyBmaXh1cCBhcHBsaWVkPwoK
ZGlmZiAtLWdpdCBhL2FyY2gvdW0vaW5jbHVkZS9zaGFyZWQvdXNlci5oIGIvYXJjaC91bS9pbmNs
dWRlL3NoYXJlZC91c2VyLmgKaW5kZXggYmRhNjZlNWE5ZDRlMy4uZTVkM2ZiYmFmZTRkMiAxMDA2
NDQKLS0tIGEvYXJjaC91bS9pbmNsdWRlL3NoYXJlZC91c2VyLmgKKysrIGIvYXJjaC91bS9pbmNs
dWRlL3NoYXJlZC91c2VyLmgKQEAgLTUyLDYgKzUyLDcgQEAgc3RhdGljIGlubGluZSBpbnQgcHJp
bnRrKGNvbnN0IGNoYXIgKmZtdCwgLi4uKQogZXh0ZXJuIGludCBpbl9hdG9uKGNoYXIgKnN0cik7
CiBleHRlcm4gc2l6ZV90IHN0cmxjcHkoY2hhciAqLCBjb25zdCBjaGFyICosIHNpemVfdCk7CiBl
eHRlcm4gc2l6ZV90IHN0cmxjYXQoY2hhciAqLCBjb25zdCBjaGFyICosIHNpemVfdCk7CitleHRl
cm4gc3NpemVfdCBzdHJzY3B5KGNoYXIgKiwgY29uc3QgY2hhciAqLCBzaXplX3QpOwogCiAvKiBD
b3BpZWQgZnJvbSBsaW51eC9jb21waWxlci1nY2MuaCBzaW5jZSB3ZSBjYW4ndCBpbmNsdWRlIGl0
IGRpcmVjdGx5ICovCiAjZGVmaW5lIGJhcnJpZXIoKSBfX2FzbV9fIF9fdm9sYXRpbGVfXygiIjog
OiA6Im1lbW9yeSIpCgpUaGFua3MsCi8vcmljaGFyZAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC11bQo=

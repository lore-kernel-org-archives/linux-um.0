Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC37C7EE37
	for <linux-um@archiver.kernel.org>; Tue,  6 Jun 2023 20:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:Cc:To:From:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=6l8nbp3gI7+zKU0vPvjophYraV/adMGzLiZKZP5Brcg=; b=KuUR3qVLCYGlLWEx4qXvTO6LuB
	ExwJBv6b39D3CtHWBuzJCGBCQj3m4yzXbKTVWfx+b6HRIsZbBbofBy8sL1qIsNFD3HKPfmSmgiEWt
	4Yeugk1kpqlvQMoMQLdb1soxTekiqSA+3h6zv6q58UAgVKJ88z288bhKQ+Mx9WW9h7W1ZYHiT+KG9
	DX1xr7U7cac7RWidRb0C7ZHKHn0XAwbR/9ip7E9T0zuLEwC4vjqGq5E2IltaKsyP+BEmS+HpDAp+w
	9dtZKqN9bWxIuOKyIrf+rX17D31LjJ7bGOpJnSLoYWGWhycNKeXWhxhoHEbOPLkWadeuXeRnzAWKB
	skgsMdyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6df6-003Deu-0F;
	Tue, 06 Jun 2023 20:52:16 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6df2-003DYt-1a
	for linux-um@lists.infradead.org;
	Tue, 06 Jun 2023 20:52:14 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 8F00B63CC103;
	Tue,  6 Jun 2023 22:51:58 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id PHgZNUdjvgcB; Tue,  6 Jun 2023 22:51:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id BE5DF608F44F;
	Tue,  6 Jun 2023 22:51:57 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id aN1OkdMjbyuq; Tue,  6 Jun 2023 22:51:57 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 940C063CC103;
	Tue,  6 Jun 2023 22:51:57 +0200 (CEST)
Date: Tue, 6 Jun 2023 22:51:57 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Azeem Shaikh <azeemshaikh38@gmail.com>
Cc: Maxim Krasnyansky <maxk@qti.qualcomm.com>, 
	anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	linux-hardening <linux-hardening@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-um <linux-um@lists.infradead.org>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, 
	kernel test robot <lkp@intel.com>
Message-ID: <1833651082.3690424.1686084717406.JavaMail.zimbra@nod.at>
In-Reply-To: <20230606182410.3976487-1-azeemshaikh38@gmail.com>
References: <20230606182410.3976487-1-azeemshaikh38@gmail.com>
Subject: Re: [PATCH v2] uml: Replace strlcpy with strscpy
MIME-Version: 1.0
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Replace strlcpy with strscpy
Thread-Index: kDC0hXVrB1XbeTt1tCVxurpE9ug2qA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230606_135212_700771_C9258905 
X-CRM114-Status: UNSURE (   8.79  )
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

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IFZvbjogIkF6ZWVtIFNoYWlraCIgPGF6
ZWVtc2hhaWtoMzhAZ21haWwuY29tPgo+IHN0cmxjcHkoKSByZWFkcyB0aGUgZW50aXJlIHNvdXJj
ZSBidWZmZXIgZmlyc3QuCj4gVGhpcyByZWFkIG1heSBleGNlZWQgdGhlIGRlc3RpbmF0aW9uIHNp
emUgbGltaXQuCj4gVGhpcyBpcyBib3RoIGluZWZmaWNpZW50IGFuZCBjYW4gbGVhZCB0byBsaW5l
YXIgcmVhZAo+IG92ZXJmbG93cyBpZiBhIHNvdXJjZSBzdHJpbmcgaXMgbm90IE5VTC10ZXJtaW5h
dGVkIFsxXS4KPiBJbiBhbiBlZmZvcnQgdG8gcmVtb3ZlIHN0cmxjcHkoKSBjb21wbGV0ZWx5IFsy
XSwgcmVwbGFjZQo+IHN0cmxjcHkoKSBoZXJlIHdpdGggc3Ryc2NweSgpLgo+IE5vIHJldHVybiB2
YWx1ZXMgd2VyZSB1c2VkLCBzbyBkaXJlY3QgcmVwbGFjZW1lbnQgaXMgc2FmZS4KPiAKPiBbMV0g
aHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRlc3QvcHJvY2Vzcy9kZXByZWNhdGVk
Lmh0bWwjc3RybGNweQo+IFsyXSBodHRwczovL2dpdGh1Yi5jb20vS1NQUC9saW51eC9pc3N1ZXMv
ODkKPiAKPiBTaWduZWQtb2ZmLWJ5OiBBemVlbSBTaGFpa2ggPGF6ZWVtc2hhaWtoMzhAZ21haWwu
Y29tPgo+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4KPiBD
bG9zZXM6Cj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvb2Uta2J1aWxkLWFsbC8yMDIzMDUzMTEx
MzUuekdNVDFnWVItbGtwQGludGVsLmNvbS8KCkFyZSB5b3Ugc3VyZSBSZXBvcnRlZC1ieSBhbmQg
Q2xvc2VzIG1ha2Ugc2Vuc2U/CkFGQUlLIHRoZSByZXBvcnQgd2FzIG9ubHkgb24geW91ciBmaXJz
dCBwYXRjaCBhbmQgbm90aGluZyBhZ2FpbnN0IHVwc3RyZWFtLgpTbyBzdGF0aW5nIHRoaXMgaW4g
dGhlIHVwZGF0ZWQgcGF0Y2ggaXMgaW4gdmFpbi4KCk90aGVyIHRoYW4gdGhhdCwKQWNrZWQtYnk6
IFJpY2hhcmQgV2VpbmJlcmdlciA8cmljaGFyZEBub2QuYXQ+CgpUaGFua3MsCi8vcmljaGFyZAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0g
bWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=

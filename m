Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28486C77B7E
	for <linux-um@archiver.kernel.org>; Thu,  1 Jun 2023 07:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3Bo7A6ujXBTUoN1PoC+wR1DeFpgftI6PauWvF9wO2ow=; b=1hRBSm+6ndZt2C
	vSzrjEHaZJc4/ng9bFZZPgwBODXTleN8XHMqdMogV/lqY3JyIiPSE348iAo+wCPyTYTroebSL1XmK
	v+IuSYnNE44+M6IiPA1xRfuDgeG+74HHiXNyjRTANhz7OBH1rOoOdinvfULnpBiiDo8W7sU4ypB/Z
	hauUVnsh6Q7X823iokC99XW1Bynt0qz0+O851C75lrHDDbRpPZQxJWYVvmjaXMEMt9zIh25J2wfJX
	K886rwM/rJu0q+DoM1Xmiqdg3VI9YNMm33bJ8/i7FJ22H9/FqtHQbS3Q6qNoP482ehAslsZ2dvNy5
	pgF9bPEqbfYqZhCLzuKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4ckC-002MSN-2C;
	Thu, 01 Jun 2023 07:29:12 +0000
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4ck8-002MNI-2r;
	Thu, 01 Jun 2023 07:29:10 +0000
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1q4cjY-001s7N-3r; Thu, 01 Jun 2023 09:28:32 +0200
Received: from p57bd9d78.dip0.t-ipconnect.de ([87.189.157.120] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1q4cjX-002tZZ-RO; Thu, 01 Jun 2023 09:28:32 +0200
Message-ID: <025fc34a24e1a1c26b187f15dba86d382d9617eb.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v3 30/34] sh: Convert pte_free_tlb() to use ptdescs
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>, "Vishal Moola (Oracle)"
	 <vishal.moola@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox
	 <willy@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, 
	kvm@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Thu, 01 Jun 2023 09:28:30 +0200
In-Reply-To: <CAMuHMdU4t4ac_eCH0UaX9F+GQ5-9kYjB_=e+pSfTkxG=3b8DsA@mail.gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
	 <20230531213032.25338-31-vishal.moola@gmail.com>
	 <CAMuHMdU4t4ac_eCH0UaX9F+GQ5-9kYjB_=e+pSfTkxG=3b8DsA@mail.gmail.com>
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.157.120
X-ZEDAT-Hint: PO
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230601_002909_087076_3640447E 
X-CRM114-Status: UNSURE (   9.10  )
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

SGkgR2VlcnQhCgpPbiBUaHUsIDIwMjMtMDYtMDEgYXQgMDk6MjAgKzAyMDAsIEdlZXJ0IFV5dHRl
cmhvZXZlbiB3cm90ZToKPiBPbiBXZWQsIE1heSAzMSwgMjAyMyBhdCAxMTozM+KAr1BNIFZpc2hh
bCBNb29sYSAoT3JhY2xlKQo+IDx2aXNoYWwubW9vbGFAZ21haWwuY29tPiB3cm90ZToKPiA+IFBh
cnQgb2YgdGhlIGNvbnZlcnNpb25zIHRvIHJlcGxhY2UgcGd0YWJsZSBjb25zdHJ1Y3Rvci9kZXN0
cnVjdG9ycyB3aXRoCj4gPiBwdGRlc2MgZXF1aXZhbGVudHMuIEFsc28gY2xlYW5zIHVwIHNvbWUg
c3BhY2luZyBpc3N1ZXMuCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IFZpc2hhbCBNb29sYSAoT3Jh
Y2xlKSA8dmlzaGFsLm1vb2xhQGdtYWlsLmNvbT4KPiAKPiBMR1RNLCBzbwo+IFJldmlld2VkLWJ5
OiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPgoKSSBhc3N1bWUg
dGhpcyBzZXJpZXMgaXMgc3VwcG9zZWQgdG8gZ28gdGhyb3VnaCBzb21lIG1tIHRyZWU/CgpBZHJp
YW4KCi0tIAogLicnYC4gIEpvaG4gUGF1bCBBZHJpYW4gR2xhdWJpdHoKOiA6JyA6ICBEZWJpYW4g
RGV2ZWxvcGVyCmAuIGAnICAgUGh5c2ljaXN0CiAgYC0gICAgR1BHOiA2MkZGIDhBNzUgODRFMCAy
OTU2IDk1NDYgIDAwMDYgNzQyNiAzQjM3IEY1QjUgRjkxMwoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVt
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC11bQo=

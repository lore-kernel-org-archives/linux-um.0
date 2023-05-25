Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B0BC77B7E
	for <linux-um@archiver.kernel.org>; Thu, 25 May 2023 20:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WHBa4tfnPxHKKR+8CVFtTt19gHRHXgixvEelsga3FNo=; b=o2D0CYtN/6GInu
	STUddycP3gvcUtlTeYfTii+zNTQZjmM1yw7AdOBIEVrk37xj214L1ksgexOnrzM+kbI9Ae7kPhQCB
	jrQdnY42OFuAvdBiS00cxtL5ytcmbHtzXIRYq0wYaL0N0xqVsdnQR2uTGghGDg5vESNPP1ZTwWXzR
	IUJ4zwcPEBwPDqOm1uN3WUFRMOIJg/OJL5MPbu9p7Kjd3X3a9neamJPCzDCUNqQvvPxHdZvtFhwuO
	uPU/Q6raUruwACFNGZ7r6keTQoQCJkGGEAI9OKhdhD55ceWsXvlBqTFgKdDYoRWssBsYsoijCp4ID
	Ly/vONNQ4mj6CaZ83KTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2HXG-0005KA-0o;
	Thu, 25 May 2023 20:26:10 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2HX9-0005Hw-1m;
	Thu, 25 May 2023 20:26:07 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id EBF4A600BE;
	Thu, 25 May 2023 20:26:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185ECC433D2;
	Thu, 25 May 2023 20:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685046362;
	bh=q0CSXKuNpY/cOn/THS8/5Wy4aJR83TTmgU6zxWwJSXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SQE8oA8lQRwEus253i9PgXAYxS+1hfEWgxQkG8dNMuK5+C2MzFWHC2gCVa/sCTaIh
	 mINB5DgFECw+pGenAIWbq/ant+MDQxcFaxJeNamZqmWfH2SE50ljnoCt5WDkZMFN/y
	 zSsFGUWBnPo7WzVzFj57OnJKTLZv8v06II8J4E2+FMu/J0lzw0cg8/Um5wKRhTuiBz
	 M1a9kePx9hC6/XnF66pTT3tDmfydVWOZ+PUuN61Pd1nQtUDi8l6wozX8HGFWMhSLig
	 QS2F5MDwxfui88OZl1d4xhMuIeMffwSLM7NnRPkICdlmFaTyYVH5nOaWhDuFI01iqL
	 PEjExdKRm1jxQ==
Date: Thu, 25 May 2023 23:25:37 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Vishal Moola <vishal.moola@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	xen-devel@lists.xenproject.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 05/34] mm: add utility functions for ptdesc
Message-ID: <20230525202537.GA4967@kernel.org>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
 <20230501192829.17086-6-vishal.moola@gmail.com>
 <20230525090956.GX4967@kernel.org>
 <CAOzc2pxSH6GhBnAoSOjvYJk2VdMDFZi3H_1qGC5Cdyp3j4AzPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOzc2pxSH6GhBnAoSOjvYJk2VdMDFZi3H_1qGC5Cdyp3j4AzPQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_132603_635156_F1426FE1 
X-CRM114-Status: GOOD (  15.18  )
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

T24gVGh1LCBNYXkgMjUsIDIwMjMgYXQgMTE6MDQ6MjhBTSAtMDcwMCwgVmlzaGFsIE1vb2xhIHdy
b3RlOgo+IE9uIFRodSwgTWF5IDI1LCAyMDIzIGF0IDI6MTDigK9BTSBNaWtlIFJhcG9wb3J0IDxy
cHB0QGtlcm5lbC5vcmc+IHdyb3RlOgo+ID4gPiArCj4gPiA+ICtzdGF0aWMgaW5saW5lIHN0cnVj
dCBwdGRlc2MgKnB0ZGVzY19hbGxvYyhnZnBfdCBnZnAsIHVuc2lnbmVkIGludCBvcmRlcikKPiA+
ID4gK3sKPiA+ID4gKyAgICAgc3RydWN0IHBhZ2UgKnBhZ2UgPSBhbGxvY19wYWdlcyhnZnAgfCBf
X0dGUF9DT01QLCBvcmRlcik7Cj4gPiA+ICsKPiA+ID4gKyAgICAgcmV0dXJuIHBhZ2VfcHRkZXNj
KHBhZ2UpOwo+ID4gPiArfQo+ID4gPiArCj4gPiA+ICtzdGF0aWMgaW5saW5lIHZvaWQgcHRkZXNj
X2ZyZWUoc3RydWN0IHB0ZGVzYyAqcHQpCj4gPiA+ICt7Cj4gPiA+ICsgICAgIHN0cnVjdCBwYWdl
ICpwYWdlID0gcHRkZXNjX3BhZ2UocHQpOwo+ID4gPiArCj4gPiA+ICsgICAgIF9fZnJlZV9wYWdl
cyhwYWdlLCBjb21wb3VuZF9vcmRlcihwYWdlKSk7Cj4gPiA+ICt9Cj4gPgo+ID4gVGhlIHB0ZGVz
Y197YWxsb2MsZnJlZX0gQVBJIGRvZXMgbm90IHNvdW5kIHJpZ2h0IHRvIG1lLiBUaGUgbmFtZQo+
ID4gcHRkZXNjX2FsbG9jKCkgaW1wbGllcyB0aGUgYWxsb2NhdGlvbiBvZiB0aGUgcHRkZXNjIGl0
c2VsZiwgcmF0aGVyIHRoYW4KPiA+IGFsbG9jYXRpb24gb2YgcGFnZSB0YWJsZSBwYWdlLiBUaGUg
c2FtZSBnb2VzIGZvciBmcmVlLgo+IAo+IEknbSBub3Qgc3VyZSBJIHNlZSB0aGUgZGlmZmVyZW5j
ZS4gQ291bGQgeW91IGVsYWJvcmF0ZT8KCkkgcmVhZCBwdGRlc2NfYWxsb2MoKSBhcyAiYWxsb2Nh
dGUgYSBwdGRlc2MiIHJhdGhlciB0aGFuIGFzICJhbGxvY2F0ZSBhCnBhZ2UgZm9yIHBhZ2UgdGFi
bGUgYW5kIHJldHVybiBwdGRlc2MgcG9pbnRpbmcgdG8gdGhhdCBwYWdlIi4gU2VlbXMgdmVyeQpj
b25mdXNpbmcgdG8gbWUgYWxyZWFkeSBhbmQgaXQgd2lsbCBiZSBldmVuIG1vcmUgY29uZnVzaW9u
IHdoZW4gd2UnbGwgc3RhcnQKYWxsb2NhdGluZyBhY3R1YWwgcHRkZXNjcy4KIAotLSAKU2luY2Vy
ZWx5IHlvdXJzLApNaWtlLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=

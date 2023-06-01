Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A5BC7EE23
	for <linux-um@archiver.kernel.org>; Thu,  1 Jun 2023 07:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CkX+nIeasKqpwQeuFEZlhN4skL071BSU0pptlw3n/E4=; b=Yd9nWv1jkDKT/S
	gPzSJFj1qKdhoWwlr0bFYcK1jsz5QerCmrc/bhPYHZ38Kh9haB44dYbUwulks/u0OOvwA407iHm5Q
	8wyqqJ/uJsCXiNKlAIYbKha8qcXgdvpH83jqgjabskjY5Aeh2xz6cQ+IMQ/ldfrE5kVFRCnaUQB3n
	rCYdUARvz9sUkdqK8ak+YqUHXxCDJeF8gvbmW35pNuKYlgPXJ2g5UO0fbUVIcQZGl7doQUF12++CC
	nXoPaQ7bmdfsuSj1YTrSrOoV7t4+G1NbOxq7ZVq1KFc2Kdb2OHOwsGXBmDO6qzyckdJq7V2dgF9vy
	FRzCl+9Yct2ohZZsw6Qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4d0k-002Pkv-34;
	Thu, 01 Jun 2023 07:46:18 +0000
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4d0h-002PjJ-0I;
	Thu, 01 Jun 2023 07:46:16 +0000
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1q4d0a-001zrK-5A; Thu, 01 Jun 2023 09:46:08 +0200
Received: from p57bd9d78.dip0.t-ipconnect.de ([87.189.157.120] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1q4d0Z-002wPt-St; Thu, 01 Jun 2023 09:46:08 +0200
Message-ID: <d0ab5473947004ab9f26a07784a2f122574b7a60.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v3 30/34] sh: Convert pte_free_tlb() to use ptdescs
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Andrew Morton
	 <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	linux-mm@kvack.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, 
	kvm@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Thu, 01 Jun 2023 09:46:06 +0200
In-Reply-To: <CAMuHMdVx_0Dhz1fOsCr3aYAVpk1HypoPJwbdNDj3h08x4esu0g@mail.gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
	 <20230531213032.25338-31-vishal.moola@gmail.com>
	 <CAMuHMdU4t4ac_eCH0UaX9F+GQ5-9kYjB_=e+pSfTkxG=3b8DsA@mail.gmail.com>
	 <025fc34a24e1a1c26b187f15dba86d382d9617eb.camel@physik.fu-berlin.de>
	 <CAMuHMdVx_0Dhz1fOsCr3aYAVpk1HypoPJwbdNDj3h08x4esu0g@mail.gmail.com>
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.157.120
X-ZEDAT-Hint: PO
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230601_004615_276067_88543B3A 
X-CRM114-Status: GOOD (  15.07  )
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

T24gVGh1LCAyMDIzLTA2LTAxIGF0IDA5OjQyICswMjAwLCBHZWVydCBVeXR0ZXJob2V2ZW4gd3Jv
dGU6Cj4gSGkgQWRyaWFuLAo+IAo+IE9uIFRodSwgSnVuIDEsIDIwMjMgYXQgOToyOOKAr0FNIEpv
aG4gUGF1bCBBZHJpYW4gR2xhdWJpdHoKPiA8Z2xhdWJpdHpAcGh5c2lrLmZ1LWJlcmxpbi5kZT4g
d3JvdGU6Cj4gPiBPbiBUaHUsIDIwMjMtMDYtMDEgYXQgMDk6MjAgKzAyMDAsIEdlZXJ0IFV5dHRl
cmhvZXZlbiB3cm90ZToKPiA+ID4gT24gV2VkLCBNYXkgMzEsIDIwMjMgYXQgMTE6MzPigK9QTSBW
aXNoYWwgTW9vbGEgKE9yYWNsZSkKPiA+ID4gPHZpc2hhbC5tb29sYUBnbWFpbC5jb20+IHdyb3Rl
Ogo+ID4gPiA+IFBhcnQgb2YgdGhlIGNvbnZlcnNpb25zIHRvIHJlcGxhY2UgcGd0YWJsZSBjb25z
dHJ1Y3Rvci9kZXN0cnVjdG9ycyB3aXRoCj4gPiA+ID4gcHRkZXNjIGVxdWl2YWxlbnRzLiBBbHNv
IGNsZWFucyB1cCBzb21lIHNwYWNpbmcgaXNzdWVzLgo+ID4gPiA+IAo+ID4gPiA+IFNpZ25lZC1v
ZmYtYnk6IFZpc2hhbCBNb29sYSAoT3JhY2xlKSA8dmlzaGFsLm1vb2xhQGdtYWlsLmNvbT4KPiA+
ID4gCj4gPiA+IExHVE0sIHNvCj4gPiA+IFJldmlld2VkLWJ5OiBHZWVydCBVeXR0ZXJob2V2ZW4g
PGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPgo+ID4gCj4gPiBJIGFzc3VtZSB0aGlzIHNlcmllcyBp
cyBzdXBwb3NlZCB0byBnbyB0aHJvdWdoIHNvbWUgbW0gdHJlZT8KPiAKPiBJIHRoaW5rIHNvLCBz
byB5b3VyIEFja2VkLWJ5IHdvdWxkIGJlIGFwcHJlY2lhdGVkLi4uCgpPSywgSSB3aWxsIGhhdmUg
YSBsb29rLiBCdHcsIGNhbiB5b3UgaGF2ZSBhIGxvb2sgYXQgdGhlIHNlY29uZCBzZXJpZXMgYnkK
QXJ0dXIgKCJTdXBlckggRE1BQyBmaXhlcyIpPyBJIGhhdmVuJ3QgaGFkIHRoZSB0aW1lIGZvciB0
aGVzZSB5ZXQsIGJ1dApJIHdpbGwgaGF2ZSB0aW1lIGluIHRoZSB3ZWVrZW5kLgoKQWRyaWFuCgot
LSAKIC4nJ2AuICBKb2huIFBhdWwgQWRyaWFuIEdsYXViaXR6CjogOicgOiAgRGViaWFuIERldmVs
b3BlcgpgLiBgJyAgIFBoeXNpY2lzdAogIGAtICAgIEdQRzogNjJGRiA4QTc1IDg0RTAgMjk1NiA5
NTQ2ICAwMDA2IDc0MjYgM0IzNyBGNUI1IEY5MTMKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtdW0K

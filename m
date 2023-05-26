Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74BEBC77B7A
	for <linux-um@archiver.kernel.org>; Fri, 26 May 2023 05:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+QLJIEjZO3ToOBmYZ6Yx2fKlk+hE5cl0zYq0oS46ITA=; b=yQlBPBMSQzuCLR
	TemDWtw8w1QDl1QtLNKuY5diR9LQo12ae5l38rCTIkf2u0SjqxyyoKIPSLdOENATFpvI8dGhlwknZ
	WhrFadpND0SnW26XKPOdV7H/++p9MxG6BaS5XKoRH4MINM3XtfTgg9NpFpJxBg/QeKKRbSSe1VR5R
	39CX293Jk67zEnMo+MSnDAkPGevVIetx1arVGFuEl50jhps7e6KhSjxcq8Btyrw+5Nw2Fz3OvccWF
	ysEYB2uQjxkQeHm1+8EvbkasNYMUIlYz53a6pfb8bkkiuakboUPmP+IbrkSFEVqo1TDU0DvN6wqOd
	d7vRaqyUnSvrs35KBnug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2Q79-0017tt-1X;
	Fri, 26 May 2023 05:35:47 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2Q76-0017sY-1D;
	Fri, 26 May 2023 05:35:45 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id BFF6C64BF1;
	Fri, 26 May 2023 05:35:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD15C433EF;
	Fri, 26 May 2023 05:35:38 +0000 (UTC)
Date: Fri, 26 May 2023 01:35:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nadav Amit <nadav.amit@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
 linux-ia64@vger.kernel.org, linux-um@lists.infradead.org, Linux-Arch
 <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Andy
 Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Borislav Petkov <bp@alien8.de>, X86 ML
 <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 2/3] compiler: inline does not imply notrace
Message-ID: <20230526013534.76e5b613@rorschach.local.home>
In-Reply-To: <D4B1FB24-C351-411B-8A40-4DAFE95FA921@gmail.com>
References: <20230525210040.3637-1-namit@vmware.com>
	<20230525210040.3637-3-namit@vmware.com>
	<20230525222844.6a0d84f8@rorschach.local.home>
	<D4B1FB24-C351-411B-8A40-4DAFE95FA921@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_223544_455271_BB79EC3F 
X-CRM114-Status: GOOD (  16.52  )
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

T24gVGh1LCAyNSBNYXkgMjAyMyAyMjoxNzozMyAtMDcwMApOYWRhdiBBbWl0IDxuYWRhdi5hbWl0
QGdtYWlsLmNvbT4gd3JvdGU6CgoKPiA+IEZZSSwgSSBoYXZlIGEgcGF0Y2ggcXVldWVkIChzdGls
bCBuZWVkcyB0byBnbyB0aHJvdWdoIHRlc3RpbmcpIHRoYXQKPiA+IGFscmVhZHkgZG9lcyB0aGlz
IDstKQo+ID4gCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzA1MDIxNjQxMDIu
MWE1MWNkYjRAZ2FuZGFsZi5sb2NhbC5ob21lLyAgCj4gCj4gVWdoLiBJZiB5b3UgY2PigJlkIG1l
LCBJIHdvdWxkbuKAmXQgYm90aGVyIHlvdSBkdXJpbmcgeW91ciB2YWNhdGlvbi4gOikKCkknbSBj
dXJyZW50bHkgcGFzc2VkIHRoZSB2YWNhdGlvbiBwYXJ0IGFuZCBub3cgaW4gVGFpd2FuIGZvciB3
b3JrLgoKPiAKPiBJIHRoaW5rIHlvdSBtYXkgbGlrZSB0aGUgZmlyc3QgcGF0Y2ggaW4gbXkgc2Vy
aWVzIHRvIHByZWNlZGUgdGhpcyBwYXRjaAo+IHRob3VnaCBhcyBzb21lIG9mIHRoZSBmdW5jdGlv
biBJIG1hcmtlZCBhcyDigJxub3RyYWNlIiBhcmUgY3VycmVudGx5IOKAnGlubGluZeKAnS4KPiAK
PiBMZXQgbWUga25vdyBob3cgeW91IHdhbnQgdG8gcHJvY2VlZCwgc28gSSB3b3VsZCBrbm93IGhv
dyB0byBicmVhayB0aGlzCj4gc2VyaWVzLgoKQ3VycmVudGx5IHRoZXJlJ3MgYSBuYXN0eSBidWcg
aW4gdjYuNC1yYzMgSSdtIGZpZ2h0aW5nIHdoZXJlIEkgY2FuJ3QKcHJvY2VlZCBvbiBhbnl0aGlu
ZyB1bnRpbCBpdCdzIHJlc29sdmVkLiBCdXQgSSBjb3VsZCBhbHNvIGp1c3QgcHVsbAp5b3VyIGZp
cnN0IGFuZCB0aGlyZCBwYXRjaCB0b28uIEknbGwgbGV0IHlvdSBrbm93IHdoZW4gSSdtIGZpbmlz
aGVkCmRlYnVnZ2luZy4KCi0tIFN0ZXZlCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LXVtCg==

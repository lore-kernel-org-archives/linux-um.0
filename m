Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42AEEEB64D9
	for <linux-um@archiver.kernel.org>; Tue, 27 Jun 2023 21:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NwH1T/mJA8JFmbgHsgCKN9bq3r/DUScXuu0KlIOndn4=; b=yzAanxdxKyeaWZ
	RlLYW1U4Um0jFVR8At9F6IuYvbJcWNuYuWoV80zsUfyji6ScE/LzvfA4OizxZjDznjVXalQB9G1rh
	Fc5PTJbFpSHYQb0qpl5LjkHa9SM0C3IebaeJz/Yu+QgCB3F3LgGa/aSilrMf1EoRH3nPgtSlEAmbR
	XSVlEXB55q86l8IO+MpG+9HJGKzj6P8+56LqgVaqOA2ujijoVqtQhkJrwRdSmRTfADlw4/yAWyKUJ
	76pt/diB18AFa7QKpuGcP/NiOs2eYj8fLpr7HmnBv/BD/wNiyJFQ2AWGJFya+EFAGP0lmc+ZB2Y/i
	AzDLZlQCokDZrOPd4S4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEGVt-00EEX2-1g;
	Tue, 27 Jun 2023 21:46:17 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEGVp-00EEVJ-1k;
	Tue, 27 Jun 2023 21:46:14 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 8C06861230;
	Tue, 27 Jun 2023 21:46:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B828C433C0;
	Tue, 27 Jun 2023 21:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687902371;
	bh=kNRWvXJ4xm/ToNiiufH10E8eFH/kz2M9O+MlUTHu8xs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dCRVJo7cFQXZ8fu18KEwzUAM8G0H5FyGdPaG2Z+qvBFFcyKeAxATUHfslPZ9gYM65
	 fUBiDpVsOz7s37BrDNtKQR45m2YXiVV1qCXDc7/IqTUyGPp94swp1hVlVD46GBE2I6
	 ROQnI6XrB6lpqjS5yIx1Y45Syzn50mAuAt/l6x8z9hM8jKvnyg9/ULLIdryM37oYq/
	 Yh/pcTOLxD63zBFcAF7ckd4qr+sAF7rCAPraQ9w49bcBc1D8+6l9awCNsC+QptysIi
	 WJeJrxhrcTPAEZJCX0+/n8roXYpzomEdplofCwlGlHS3mGUetW7sVNo6hPwc3Lqpw5
	 gb3eeXBRWUy2g==
Message-ID: <70776142-a778-9c20-5594-835ed6f7e7a2@kernel.org>
Date: Tue, 27 Jun 2023 16:46:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 26/33] nios2: Convert __pte_free_tlb() to use ptdescs
Content-Language: en-US
To: Guenter Roeck <linux@roeck-us.net>, Vishal Moola <vishal.moola@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Hugh Dickins <hughd@google.com>, Mike Rapoport <rppt@kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
References: <20230622205745.79707-1-vishal.moola@gmail.com>
 <20230622205745.79707-27-vishal.moola@gmail.com>
 <13bab37c-0f0a-431a-8b67-4379bf4dc541@roeck-us.net>
 <CAOzc2px6VutRkMUTn+M5LFLf1YbRVZFgJ=q7StaApwYRxUWqQA@mail.gmail.com>
 <cc954b15-63ab-9d9f-2d37-1aea78b7f65f@roeck-us.net>
 <b6a5753b-8874-6465-f690-094ee753e038@roeck-us.net>
 <CAOzc2pxdqeaRjYLfOqvMW-AEobTzD9xOP+MyP9nxgEbi1T2r7Q@mail.gmail.com>
 <c3751051-7fc7-7129-b9a7-ead71c576ace@kernel.org>
 <2b7e8b1d-1697-6a25-434d-352f95e6fff2@roeck-us.net>
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <2b7e8b1d-1697-6a25-434d-352f95e6fff2@roeck-us.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230627_144613_653570_50967E00 
X-CRM114-Status: GOOD (  20.64  )
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

CgpPbiA2LzI3LzIzIDE2OjAxLCBHdWVudGVyIFJvZWNrIHdyb3RlOgo+IE9uIDYvMjcvMjMgMTM6
MDUsIERpbmggTmd1eWVuIHdyb3RlOgo+Pgo+Pgo+PiBPbiA2LzI3LzIzIDE0OjU2LCBWaXNoYWwg
TW9vbGEgd3JvdGU6Cj4+PiBPbiBUdWUsIEp1biAyNywgMjAyMyBhdCAxMjoxNOKAr1BNIEd1ZW50
ZXIgUm9lY2sgPGxpbnV4QHJvZWNrLXVzLm5ldD4gCj4+PiB3cm90ZToKPj4+Pgo+Pj4+IE9uIDYv
MjcvMjMgMTI6MTAsIEd1ZW50ZXIgUm9lY2sgd3JvdGU6Cj4+Pj4+IE9uIDYvMjcvMjMgMTA6NDIs
IFZpc2hhbCBNb29sYSB3cm90ZToKPj4+Pj4+IE9uIE1vbiwgSnVuIDI2LCAyMDIzIGF0IDEwOjQ3
4oCvUE0gR3VlbnRlciBSb2VjayAKPj4+Pj4+IDxsaW51eEByb2Vjay11cy5uZXQ+IHdyb3RlOgo+
Pj4+Pj4+Cj4+Pj4+Pj4gT24gVGh1LCBKdW4gMjIsIDIwMjMgYXQgMDE6NTc6MzhQTSAtMDcwMCwg
VmlzaGFsIE1vb2xhIChPcmFjbGUpIAo+Pj4+Pj4+IHdyb3RlOgo+Pj4+Pj4+PiBQYXJ0IG9mIHRo
ZSBjb252ZXJzaW9ucyB0byByZXBsYWNlIHBndGFibGUgCj4+Pj4+Pj4+IGNvbnN0cnVjdG9yL2Rl
c3RydWN0b3JzIHdpdGgKPj4+Pj4+Pj4gcHRkZXNjIGVxdWl2YWxlbnRzLgo+Pj4+Pj4+Pgo+Pj4+
Pj4+PiBTaWduZWQtb2ZmLWJ5OiBWaXNoYWwgTW9vbGEgKE9yYWNsZSkgPHZpc2hhbC5tb29sYUBn
bWFpbC5jb20+Cj4+Pj4+Pj4+IEFja2VkLWJ5OiBNaWtlIFJhcG9wb3J0IChJQk0pIDxycHB0QGtl
cm5lbC5vcmc+Cj4+Pj4+Pj4KPj4+Pj4+PiBUaGlzIHBhdGNoIGNhdXNlcyBhbGwgbmlvczIgYnVp
bGRzIHRvIGZhaWwuCj4+Pj4+Pgo+Pj4+Pj4gSXQgbG9va3MgbGlrZSB5b3UgdHJpZWQgdG8gYXBw
bHkgdGhpcyBwYXRjaCBvbiBpdHMgb3duLiBUaGlzIHBhdGNoIAo+Pj4+Pj4gZGVwZW5kcwo+Pj4+
Pj4gb24gcGF0Y2hlcyAwMS0xMiBvZiB0aGlzIHBhdGNoc2V0IHRvIGNvbXBpbGUgcHJvcGVybHku
IEkndmUgCj4+Pj4+PiBjcm9zcy1jb21waWxlZAo+Pj4+Pj4gdGhpcyBhcmNoaXRlY3R1cmUgYW5k
IGl0IHdvcmtlZCwgYnV0IGxldCBtZSBrbm93IGlmIHNvbWV0aGluZyBmYWlscwo+Pj4+Pj4gd2hl
biBpdHMgYXBwbGllZCBvbiB0b3Agb2YgdGhvc2UgcGF0Y2hlcyAob3IgdGhlIHJlc3Qgb2YgdGhl
IAo+Pj4+Pj4gcGF0Y2hzZXQpLgo+Pj4+Pgo+Pj4+Pgo+Pj4+PiBObywgSSBkaWQgbm90IHRyeSB0
byBhcHBseSB0aGlzIHBhdGNoIG9uIGl0cyBvd24uIEkgdHJpZWQgdG8gYnVpbGQgCj4+Pj4+IHll
c3RlcmRheSdzCj4+Pj4+IHBlbmRpbmctZml4ZXMgYnJhbmNoIG9mIGxpbnV4LW5leHQuCj4+Pj4+
Cj4+Pj4KPj4+PiBBIHF1aWNrIGNoZWNrIHNob3dzIHRoYXQgdGhlIGJ1aWxkIGZhaWxzIHdpdGgg
bmV4dC0yMDIzMDYyNy4gU2VlIGxvZyAKPj4+PiBiZWxvdy4KPj4+Cj4+PiBBaCBpdCBsb29rcyBs
aWtlIHRoaXMgb25lIHNsaXBwZWQgaW50byAtbmV4dCBvbiBpdHMgb3duIHNvbWVob3c/IAo+Pj4g
U3RlcGhlbiwgcGxlYXNlCj4+PiBkcm9wIHRoaXMgcGF0Y2ggZnJvbSAtbmV4dDsgaXQgc2hvdWxk
bid0IGJlIGluIHdpdGhvdXQgdGhlIHJlc3Qgb2YgdGhlCj4+PiBwYXRjaHNldCB3aGljaAo+Pj4g
SSBpbnRlbmQgdG8gaGF2ZSBBbmRyZXcgdGFrZSB0aHJvdWdoIHRoZSBtbSB0cmVlLgo+Pj4KPj4K
Pj4gSSBhcG9sb2dpemUsIGJ1dCBJIHF1ZXVlIHRoaXMgcGF0Y2ggdXAgZm9yIExpbnVzIGFuZCBp
dCdzIGJlZW4gcHVsbGVkIAo+PiBmb3IgdGhpcyBtZXJnZSB3aW5kb3cuIEkgZGlkbid0IHJlYWxp
emUgeW91IHdlcmUgZ29pbmcgdG8gdGFrZSB0aGlzIAo+PiBwYXRjaHNldCB0aHJvdWdoIGFub3Ro
ZXIgdHJlZS4KPj4KPj4gU29ycnkgYWJvdXQgdGhhdC4KPj4KPiAKPiBZZXMsIGluZGVlZCwgSSBq
dXN0IGNvbmZpcm1lZCB0aGF0IGFsbCBuaW9zMiBidWlsZHMgaW4gdGhlIG1haW5saW5lIGtlcm5l
bAo+IGFyZSBub3cgYnJva2VuLgo+IAoKUGxlYXNlIGxldCBtZSBrbm93IGlmIHlvdSBuZWVkIHRv
IGRvIGFueXRoaW5nLiBJJ20gZ29pbmcgdG8gb3V0IGZvciBhIAp3ZWVrIHN0YXJ0aW5nIHRvbW9y
cm93LgoKRGluaAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=

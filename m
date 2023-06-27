Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7738DC0015E
	for <linux-um@archiver.kernel.org>; Tue, 27 Jun 2023 20:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6h/1TYOIC1duemkMLtv0o/E5lTiJMKiOOV55GkSjvoI=; b=zdLOVRPruLHQFa
	3bJLg01x3yAesWsG1wJhJF6h31BI7c6Pe0iEF9vlk5iLNYjAxm3IdhJob5lXK8QjWySWeGL6s73wH
	azCN8sGwWBoElKH2/e0Jy/tn7n73q5lc01Yv6ZiiUt5gVDr4BMoWSOcY7QUphNsFEKhwqw/oek6BR
	lD9MEPD57JGKczgVtbaaKlkPTCtEV3HIxTYI4WuZBKPdGSO8lWSOgYkYGycAuP1uEX1S450w1zNy1
	Ba9TPKbNe5OSeDzw1JKT7ngT0WMzPsXlx33+QQtU4ekW9lkrTakiqwU0wvH1C+xYNBtEvhtvtnQpW
	Eqzt8jkQtcYvHqbjyyLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEEwc-00E1bN-24;
	Tue, 27 Jun 2023 20:05:46 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEEwY-00E1Tz-0G;
	Tue, 27 Jun 2023 20:05:43 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6B06F61187;
	Tue, 27 Jun 2023 20:05:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7059C433C8;
	Tue, 27 Jun 2023 20:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687896331;
	bh=nxdHwM18qWYe/olgwzu19FISC5RuQmNbEVvkLxl2VBY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZjE+m6TsP7/JcneLIcHUQel0hil1iUviVqfTyM+RmrZXtI/kbVQFRNoD4ArZJbLU5
	 4zXDW9VUtIBpTBpsYvBq5PnpEDQDOlXJKhHy+sm7jtZkBQvoQSE1wSsOzbpudlC+Pd
	 sL4Mh0jQneg4s31yTcnwH46d5iOXHuw/38OyZqmz/LfqWaBAbJU7kwNjDJPcPN9MhY
	 5TVIOZI5hoLTyoGuAsXGQTmXmS3NexTmFkWRmRChTwd7DACRyJXRXzGHrpU99Dq1ux
	 qzo4guCFMo24k0Ik6ctKYSpdIkJqigF4j5lDwN6AneeMBgw/flE/ruM58JFYwrciDp
	 T1OMj/Q26nvmA==
Message-ID: <c3751051-7fc7-7129-b9a7-ead71c576ace@kernel.org>
Date: Tue, 27 Jun 2023 15:05:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 26/33] nios2: Convert __pte_free_tlb() to use ptdescs
Content-Language: en-US
To: Vishal Moola <vishal.moola@gmail.com>, Guenter Roeck <linux@roeck-us.net>
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
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <CAOzc2pxdqeaRjYLfOqvMW-AEobTzD9xOP+MyP9nxgEbi1T2r7Q@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230627_130542_222668_DAE8BF20 
X-CRM114-Status: GOOD (  18.18  )
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

CgpPbiA2LzI3LzIzIDE0OjU2LCBWaXNoYWwgTW9vbGEgd3JvdGU6Cj4gT24gVHVlLCBKdW4gMjcs
IDIwMjMgYXQgMTI6MTTigK9QTSBHdWVudGVyIFJvZWNrIDxsaW51eEByb2Vjay11cy5uZXQ+IHdy
b3RlOgo+Pgo+PiBPbiA2LzI3LzIzIDEyOjEwLCBHdWVudGVyIFJvZWNrIHdyb3RlOgo+Pj4gT24g
Ni8yNy8yMyAxMDo0MiwgVmlzaGFsIE1vb2xhIHdyb3RlOgo+Pj4+IE9uIE1vbiwgSnVuIDI2LCAy
MDIzIGF0IDEwOjQ34oCvUE0gR3VlbnRlciBSb2VjayA8bGludXhAcm9lY2stdXMubmV0PiB3cm90
ZToKPj4+Pj4KPj4+Pj4gT24gVGh1LCBKdW4gMjIsIDIwMjMgYXQgMDE6NTc6MzhQTSAtMDcwMCwg
VmlzaGFsIE1vb2xhIChPcmFjbGUpIHdyb3RlOgo+Pj4+Pj4gUGFydCBvZiB0aGUgY29udmVyc2lv
bnMgdG8gcmVwbGFjZSBwZ3RhYmxlIGNvbnN0cnVjdG9yL2Rlc3RydWN0b3JzIHdpdGgKPj4+Pj4+
IHB0ZGVzYyBlcXVpdmFsZW50cy4KPj4+Pj4+Cj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBWaXNoYWwg
TW9vbGEgKE9yYWNsZSkgPHZpc2hhbC5tb29sYUBnbWFpbC5jb20+Cj4+Pj4+PiBBY2tlZC1ieTog
TWlrZSBSYXBvcG9ydCAoSUJNKSA8cnBwdEBrZXJuZWwub3JnPgo+Pj4+Pgo+Pj4+PiBUaGlzIHBh
dGNoIGNhdXNlcyBhbGwgbmlvczIgYnVpbGRzIHRvIGZhaWwuCj4+Pj4KPj4+PiBJdCBsb29rcyBs
aWtlIHlvdSB0cmllZCB0byBhcHBseSB0aGlzIHBhdGNoIG9uIGl0cyBvd24uIFRoaXMgcGF0Y2gg
ZGVwZW5kcwo+Pj4+IG9uIHBhdGNoZXMgMDEtMTIgb2YgdGhpcyBwYXRjaHNldCB0byBjb21waWxl
IHByb3Blcmx5LiBJJ3ZlIGNyb3NzLWNvbXBpbGVkCj4+Pj4gdGhpcyBhcmNoaXRlY3R1cmUgYW5k
IGl0IHdvcmtlZCwgYnV0IGxldCBtZSBrbm93IGlmIHNvbWV0aGluZyBmYWlscwo+Pj4+IHdoZW4g
aXRzIGFwcGxpZWQgb24gdG9wIG9mIHRob3NlIHBhdGNoZXMgKG9yIHRoZSByZXN0IG9mIHRoZSBw
YXRjaHNldCkuCj4+Pgo+Pj4KPj4+IE5vLCBJIGRpZCBub3QgdHJ5IHRvIGFwcGx5IHRoaXMgcGF0
Y2ggb24gaXRzIG93bi4gSSB0cmllZCB0byBidWlsZCB5ZXN0ZXJkYXkncwo+Pj4gcGVuZGluZy1m
aXhlcyBicmFuY2ggb2YgbGludXgtbmV4dC4KPj4+Cj4+Cj4+IEEgcXVpY2sgY2hlY2sgc2hvd3Mg
dGhhdCB0aGUgYnVpbGQgZmFpbHMgd2l0aCBuZXh0LTIwMjMwNjI3LiBTZWUgbG9nIGJlbG93Lgo+
IAo+IEFoIGl0IGxvb2tzIGxpa2UgdGhpcyBvbmUgc2xpcHBlZCBpbnRvIC1uZXh0IG9uIGl0cyBv
d24gc29tZWhvdz8gU3RlcGhlbiwgcGxlYXNlCj4gZHJvcCB0aGlzIHBhdGNoIGZyb20gLW5leHQ7
IGl0IHNob3VsZG4ndCBiZSBpbiB3aXRob3V0IHRoZSByZXN0IG9mIHRoZQo+IHBhdGNoc2V0IHdo
aWNoCj4gSSBpbnRlbmQgdG8gaGF2ZSBBbmRyZXcgdGFrZSB0aHJvdWdoIHRoZSBtbSB0cmVlLgo+
IAoKSSBhcG9sb2dpemUsIGJ1dCBJIHF1ZXVlIHRoaXMgcGF0Y2ggdXAgZm9yIExpbnVzIGFuZCBp
dCdzIGJlZW4gcHVsbGVkIApmb3IgdGhpcyBtZXJnZSB3aW5kb3cuIEkgZGlkbid0IHJlYWxpemUg
eW91IHdlcmUgZ29pbmcgdG8gdGFrZSB0aGlzIApwYXRjaHNldCB0aHJvdWdoIGFub3RoZXIgdHJl
ZS4KClNvcnJ5IGFib3V0IHRoYXQuCgpEaW5oCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LXVtCg==

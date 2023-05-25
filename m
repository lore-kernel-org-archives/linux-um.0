Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8823BC7EE2C
	for <linux-um@archiver.kernel.org>; Thu, 25 May 2023 20:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NYQn7aFUXlsBknYgR12R2wDRVSad+EO1q74d2bGkaeU=; b=A9DNDaZM2UfZRW
	W25H6WtH9Cp9xqk3s9FvdwMer2a8Xtc9aq8zt6GchPh/c5a6EbzCmiqEIVjEUL071eOZuZ962XmdB
	3iKehzaj00cAaPyKljmc8X9ttPvkUi1WA6b0kumtLC9klon32KnqxymTHVV+FvxTR4DwyYLO023NS
	9SunSOAJHVnEwBku/ANJKkqtWgeJnf2gxrew9b9BEP0r5mc6+jyu6lNRDrzbeKPvdxg4Pb+LE98aF
	cXvBLTrisNEgT/1h5neBJNhxH0kG9YNUclRYx3MHEy2X6qsLgrZZv6ERVezoNZT9fptmwLe0YzvU6
	LrHzB50Td5xOII+/3VUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2HRy-0004lu-2O;
	Thu, 25 May 2023 20:20:42 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2HRu-0004jx-0M;
	Thu, 25 May 2023 20:20:39 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id DE92864A34;
	Thu, 25 May 2023 20:20:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D613BC433D2;
	Thu, 25 May 2023 20:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685046036;
	bh=TRdhRXxXUIYfs640uIn+I4Rf6UAXCv8idpkcYdsSebM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oiC2XGhNWUAmWE7pr8r3QtJ9JQsEo/jXvve3lXs2r5Y+W4R2mTSVXer6rhbIqd0H3
	 uoSQkJ728HLdXkJmf2eWWiJHTRm/fGQOsi2eZMGN8iMwau2U+ioJb0W4RoKYGYtykh
	 z9scTeHJfdOUnqeX313qP2xIMkwidI5DxymtOtruiJkZ/HiGGdvi3+NdefCU8HC/4L
	 yVF6ukcziPPo5ghUZkvreoJAGRzTQdLIctyd1RS1O+YIm3/yAJVKFl1SAT+U6nvVPE
	 TUmcZj1oUZgh7b4Odb9/HzteZyqvh1+JrTl0ADJm08qL98dpyZZ8OeR78PQJMngFPN
	 0x/EvMWBkU0Qw==
Date: Thu, 25 May 2023 23:20:11 +0300
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
Subject: Re: [PATCH v2 01/34] mm: Add PAGE_TYPE_OP folio functions
Message-ID: <20230525202011.GZ4967@kernel.org>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
 <20230501192829.17086-2-vishal.moola@gmail.com>
 <20230525085555.GV4967@kernel.org>
 <CAOzc2pxx489C26NnS9NHkUQY9PYiagzt-nYK6LnkJ1N3NYQWzg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOzc2pxx489C26NnS9NHkUQY9PYiagzt-nYK6LnkJ1N3NYQWzg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_132038_212507_BD26E63E 
X-CRM114-Status: GOOD (  14.92  )
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

T24gVGh1LCBNYXkgMjUsIDIwMjMgYXQgMTA6MDA6MjNBTSAtMDcwMCwgVmlzaGFsIE1vb2xhIHdy
b3RlOgo+IE9uIFRodSwgTWF5IDI1LCAyMDIzIGF0IDE6NTbigK9BTSBNaWtlIFJhcG9wb3J0IDxy
cHB0QGtlcm5lbC5vcmc+IHdyb3RlOgo+ID4KPiA+IEhpLAo+ID4KPiA+IE9uIE1vbiwgTWF5IDAx
LCAyMDIzIGF0IDEyOjI3OjU2UE0gLTA3MDAsIFZpc2hhbCBNb29sYSAoT3JhY2xlKSB3cm90ZToK
PiA+ID4gTm8gZm9saW8gZXF1aXZhbGVudHMgZm9yIHBhZ2UgdHlwZSBvcGVyYXRpb25zIGhhdmUg
YmVlbiBkZWZpbmVkLCBzbwo+ID4gPiBkZWZpbmUgdGhlbSBmb3IgbGF0ZXIgZm9saW8gY29udmVy
c2lvbnMuCj4gPgo+ID4gQ2FuIHlvdSBwbGVhc2UgZWxhYm9yYXRlIHdoeSB3b3VsZCB3ZSBuZWVk
IGZvbGlvcyBmb3IgcGFnZSB0YWJsZSBkZXNjcmlwdG9ycz8KPiAKPiBUaGFua3MgZm9yIHRoZSBy
ZXZpZXchCj4gCj4gVGhlc2UgbWFjcm9zIGFyZSBmb3IgY2FsbGVycyB0aGF0IGNhcmUgYWJvdXQg
dGhlIHBhZ2UgdHlwZSwgaS5lLiBUYWJsZSBhbmQKPiBCdWRkeS4gQXNpZGUgZnJvbSBhY2NvdW50
aW5nIGZvciB0aG9zZSBjYXNlcywgdGhlIHBhZ2UgdGFibGVzIGRvbid0IHVzZSBmb2xpb3MuCj4g
VGhlc2UgYXJlIG1vcmUgZm9yIHRoZSBjbGVhbmxpbmVzcyBvZiB0aG9zZSBjYWxsZXJzLgoKQnV0
IHdoeSB1c2luZyBmb2xpbyBBUElzIGZvciBQYWdlVHlwZSB3aWxsIGJlIGNsZWFuZXIgdGhhbiB1
c2luZyBwYWdlIEFQSXM/CkRvIHlvdSBoYXZlIGFuIGV4YW1wbGU/CgotLSAKU2luY2VyZWx5IHlv
dXJzLApNaWtlLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=

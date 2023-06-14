Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65BDC001B3
	for <linux-um@archiver.kernel.org>; Wed, 14 Jun 2023 21:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gOYjQvDSDpyta+8J2G1au9EB63nOHGS5UEdBqW6UuY0=; b=AQcipvMwdfIGGk
	JpZKQyClgydU2njpE8CieCeXt4XHlsNTs0wlO/j25dZQ1rnqf3AGv3b/jHx8VtgKqrmhBuWPEfZxd
	kW2C7np+BHZ6GmIa228fznzAhzHpZT8qjlYOWNksDbLfYmmDI9p1eQ8j3AfLKog1G9WP4aLuKyIYW
	J4AiT4SWn0je7FLrL2FI4UR0+s5V7ACC0Ovkd3wOnUiZGBfrkTaR35rlsl+neUM6ChgdzaoW4o9JP
	FjqX0P16+Dkt3GAhuWnVN8U6EYC8QTv/7kcjoXauZnuQdJCVJt3GGnmiRE1fFB7OQxQUfSdGmHbQ1
	Z8QKerKofmdZNkXraSkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9XxZ-00Ck32-1S;
	Wed, 14 Jun 2023 21:23:21 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9XxU-00Ck0w-2V;
	Wed, 14 Jun 2023 21:23:18 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 34A296257E;
	Wed, 14 Jun 2023 21:23:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E219C433C8;
	Wed, 14 Jun 2023 21:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686777794;
	bh=sfZlQC0KRiU3VFMaS6H5djLiaDuaR3UyKKAHotXoEC4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JSy2cjQ3EfZqDH+GRmJ+mjVAAcseGIvPUq3lquiQxXqEjjGqwU+HemD7F3wiC1btN
	 oSofDjGtfqLFUZE6+eF26LaNmlZ0XJSVLI8h3M4XLmim/HM29Na3QWm9DVPo2aVCXI
	 K79BAGLxK+0MfFwKGWozB9O2gr9yZd3Cu5CIDwhRjdpR3tn5b309NHjtR2IQGAy5FI
	 ii48Ct/zrPJGlO6GMB0nxU3tTn8XzvIvT2D58R4sk2Mn4rxTjXdkRPrgiKhp+20BR7
	 UEwrTSQZ099UBshJbATcCyWw+lXzjKCSDECSlkjbQFiwFpFsJU9nBH5UIC1JXPi4An
	 txkWeQKuOaEyQ==
Message-ID: <5729b45b-6a19-2aa8-8722-c50e6a1fceea@kernel.org>
Date: Wed, 14 Jun 2023 16:23:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 27/34] nios2: Convert __pte_free_tlb() to use ptdescs
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Hugh Dickins <hughd@google.com>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-28-vishal.moola@gmail.com>
 <e52c7a74-da68-08d2-54e2-f95a8c5b52e7@kernel.org>
 <CAMuHMdXPASfLM8St_JZOW3Wke+ickJoo1oDr+orRbTERy=Zgwg@mail.gmail.com>
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <CAMuHMdXPASfLM8St_JZOW3Wke+ickJoo1oDr+orRbTERy=Zgwg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230614_142316_914364_9BCEB3AE 
X-CRM114-Status: GOOD (  15.66  )
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

CgpPbiA2LzE0LzIzIDA0OjMwLCBHZWVydCBVeXR0ZXJob2V2ZW4gd3JvdGU6Cj4gSGkgRGluaCwK
PiAKPiBPbiBXZWQsIEp1biAxNCwgMjAyMyBhdCAxMjoxN+KAr0FNIERpbmggTmd1eWVuIDxkaW5n
dXllbkBrZXJuZWwub3JnPiB3cm90ZToKPj4gT24gNi8xMi8yMyAxNjowNCwgVmlzaGFsIE1vb2xh
IChPcmFjbGUpIHdyb3RlOgo+Pj4gUGFydCBvZiB0aGUgY29udmVyc2lvbnMgdG8gcmVwbGFjZSBw
Z3RhYmxlIGNvbnN0cnVjdG9yL2Rlc3RydWN0b3JzIHdpdGgKPj4+IHB0ZGVzYyBlcXVpdmFsZW50
cy4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBWaXNoYWwgTW9vbGEgKE9yYWNsZSkgPHZpc2hhbC5t
b29sYUBnbWFpbC5jb20+Cj4+PiAtLS0KPj4+ICAgIGFyY2gvbmlvczIvaW5jbHVkZS9hc20vcGdh
bGxvYy5oIHwgOCArKysrLS0tLQo+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgNCBkZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9uaW9zMi9pbmNsdWRl
L2FzbS9wZ2FsbG9jLmggYi9hcmNoL25pb3MyL2luY2x1ZGUvYXNtL3BnYWxsb2MuaAo+Pj4gaW5k
ZXggZWNkMTY1N2JiMmNlLi5jZTZiYjhlNzQyNzEgMTAwNjQ0Cj4+PiAtLS0gYS9hcmNoL25pb3My
L2luY2x1ZGUvYXNtL3BnYWxsb2MuaAo+Pj4gKysrIGIvYXJjaC9uaW9zMi9pbmNsdWRlL2FzbS9w
Z2FsbG9jLmgKPj4+IEBAIC0yOCwxMCArMjgsMTAgQEAgc3RhdGljIGlubGluZSB2b2lkIHBtZF9w
b3B1bGF0ZShzdHJ1Y3QgbW1fc3RydWN0ICptbSwgcG1kX3QgKnBtZCwKPj4+Cj4+PiAgICBleHRl
cm4gcGdkX3QgKnBnZF9hbGxvYyhzdHJ1Y3QgbW1fc3RydWN0ICptbSk7Cj4+Pgo+Pj4gLSNkZWZp
bmUgX19wdGVfZnJlZV90bGIodGxiLCBwdGUsIGFkZHIpICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFwKPj4+IC0gICAgIGRvIHsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXAo+Pj4gLSAgICAgICAgICAgICBwZ3RhYmxlX3B0ZV9wYWdlX2R0
b3IocHRlKTsgICAgICAgICAgICAgICAgICAgICBcCj4+PiAtICAgICAgICAgICAgIHRsYl9yZW1v
dmVfcGFnZSgodGxiKSwgKHB0ZSkpOyAgICAgICAgICAgICAgICAgIFwKPj4+ICsjZGVmaW5lIF9f
cHRlX2ZyZWVfdGxiKHRsYiwgcHRlLCBhZGRyKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFwKPj4+ICsgICAgIGRvIHsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCj4+PiArICAgICAgICAgICAgIHBhZ2V0YWJs
ZV9wdGVfZHRvcihwYWdlX3B0ZGVzYyhwdGUpKTsgICAgICAgICAgICAgICAgICAgXAo+Pj4gKyAg
ICAgICAgICAgICB0bGJfcmVtb3ZlX3BhZ2VfcHRkZXNjKCh0bGIpLCAocGFnZV9wdGRlc2MocHRl
KSkpOyAgICAgIFwKPj4+ICAgICAgICB9IHdoaWxlICgwKQo+Pj4KPj4+ICAgICNlbmRpZiAvKiBf
QVNNX05JT1MyX1BHQUxMT0NfSCAqLwo+Pgo+PiBBcHBsaWVkIQo+IAo+IEkgZG9uJ3QgdGhpbmsg
eW91IGNhbiBqdXN0IGFwcGx5IHRoaXMgcGF0Y2gsIGFzIHRoZSBuZXcgZnVuY3Rpb25zCj4gd2Vy
ZSBvbmx5IGludHJvZHVjZWQgaW4gW1BBVENIIHY0IDA1LzM0XSBvZiB0aGlzIHNlcmllcy4KPiAK
CkFoLCB0aGFua3MgZm9yIHRoZSBwb2ludGVyIQoKRGluaAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVt
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC11bQo=

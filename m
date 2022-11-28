Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C749C433FE
	for <linux-um@archiver.kernel.org>; Mon, 28 Nov 2022 08:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gVb/arngimftsKXPN5luRudLELMOMRSFCEtRJNNnVTM=; b=Ax2AEKYBmlZfB4
	pHnonHa0Kw2UhUzLTEXq8WiDFTkWD/87jFFFBHXOAbCeIrbR5q3lBlkNq7wzJtVoSelWZaRjezwZn
	fDDsneB7ZcBMQRJXow7nmqE8O3yeO8Wcs7ImIlNLwwpbr0eLwOWqgCOvcptSQQE8ZbEv2SzyIqKTW
	Ax5jYFZIUuxN+o9i876kDc/PFuCo5Rmob8+s//vE0FFjc3fQ+buQrQ0FmZKnkBZu/w4bTzdnVRqCM
	R4tgPlMB4Nv0mW/Ck21p9W5qhMTP61uhGIYC0Or3iAIOZXrNxb5UpnrDou1oCVeE+64EFv5zkzNRQ
	QynmWMpLxFIbBNM7IUeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozZTG-000CyH-4J; Mon, 28 Nov 2022 08:26:34 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozZSv-000Co7-Vh; Mon, 28 Nov 2022 08:26:15 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7A51260F9E;
	Mon, 28 Nov 2022 08:26:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F8BC433D6;
	Mon, 28 Nov 2022 08:26:05 +0000 (UTC)
Message-ID: <0a52ed02-cf9d-eb67-8d68-e3d9dbe4e7b2@xs4all.nl>
Date: Mon, 28 Nov 2022 09:26:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH mm-unstable v1 16/20] mm/frame-vector: remove FOLL_FORCE
 usage
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>
Cc: x86@kernel.org, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
 etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-samsung-soc@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-media@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Andrea Arcangeli <aarcange@redhat.com>,
 Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>,
 Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 Muchun Song <songmuchun@bytedance.com>, Shuah Khan <shuah@kernel.org>,
 Lucas Stach <l.stach@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Oded Gabbay <ogabbay@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Christoph Hellwig <hch@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Tomasz Figa
 <tfiga@chromium.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20221116102659.70287-1-david@redhat.com>
 <20221116102659.70287-17-david@redhat.com>
 <81fb0fa3-2e06-b765-56ac-a7d981194e59@redhat.com>
 <08b65ac6-6786-1080-18f8-d2be109c85fc@xs4all.nl>
 <9d0bf98a-3d6a-1082-e992-1338e1525935@redhat.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <9d0bf98a-3d6a-1082-e992-1338e1525935@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221128_002614_139890_751E70CB 
X-CRM114-Status: GOOD (  23.96  )
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

T24gMjgvMTEvMjAyMiAwOToxOCwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6Cj4gT24gMjguMTEu
MjIgMDk6MTcsIEhhbnMgVmVya3VpbCB3cm90ZToKPj4gSGkgRGF2aWQsCj4+Cj4+IE9uIDI3LzEx
LzIwMjIgMTE6MzUsIERhdmlkIEhpbGRlbmJyYW5kIHdyb3RlOgo+Pj4gT24gMTYuMTEuMjIgMTE6
MjYsIERhdmlkIEhpbGRlbmJyYW5kIHdyb3RlOgo+Pj4+IEZPTExfRk9SQ0UgaXMgcmVhbGx5IG9u
bHkgZm9yIHB0cmFjZSBhY2Nlc3MuIEFjY29yZGluZyB0byBjb21taXQKPj4+PiA3MDc5NDcyNDdl
OTUgKCJtZWRpYTogdmlkZW9idWYyLXZtYWxsb2M6IGdldF91c2VycHRyOiBidWZmZXJzIGFyZSBh
bHdheXMKPj4+PiB3cml0YWJsZSIpLCBnZXRfdmFkZHJfZnJhbWVzKCkgY3VycmVudGx5IHBpbnMg
YWxsIHBhZ2VzIHdyaXRhYmxlIGFzIGEKPj4+PiB3b3JrYXJvdW5kIGZvciBpc3N1ZXMgd2l0aCBy
ZWFkLW9ubHkgYnVmZmVycy4KPj4+Pgo+Pj4+IEZPTExfRk9SQ0UsIGhvd2V2ZXIsIHNlZW1zIHRv
IGJlIGEgbGVnYWN5IGxlZnRvdmVyIGFzIGl0IHByZWRhdGVzCj4+Pj4gY29tbWl0IDcwNzk0NzI0
N2U5NSAoIm1lZGlhOiB2aWRlb2J1ZjItdm1hbGxvYzogZ2V0X3VzZXJwdHI6IGJ1ZmZlcnMgYXJl
Cj4+Pj4gYWx3YXlzIHdyaXRhYmxlIikuIExldCdzIGp1c3QgcmVtb3ZlIGl0Lgo+Pj4+Cj4+Pj4g
T25jZSB0aGUgcmVhZC1vbmx5IGJ1ZmZlciBpc3N1ZSBoYXMgYmVlbiByZXNvbHZlZCwgRk9MTF9X
UklURSBjb3VsZAo+Pj4+IGFnYWluIGJlIHNldCBkZXBlbmRpbmcgb24gdGhlIERNQSBkaXJlY3Rp
b24uCj4+Pj4KPj4+PiBDYzogSGFucyBWZXJrdWlsIDxodmVya3VpbEB4czRhbGwubmw+Cj4+Pj4g
Q2M6IE1hcmVrIFN6eXByb3dza2kgPG0uc3p5cHJvd3NraUBzYW1zdW5nLmNvbT4KPj4+PiBDYzog
VG9tYXN6IEZpZ2EgPHRmaWdhQGNocm9taXVtLm9yZz4KPj4+PiBDYzogTWFyZWsgU3p5cHJvd3Nr
aSA8bS5zenlwcm93c2tpQHNhbXN1bmcuY29tPgo+Pj4+IENjOiBNYXVybyBDYXJ2YWxobyBDaGVo
YWIgPG1jaGVoYWJAa2VybmVsLm9yZz4KPj4+PiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBIaWxkZW5i
cmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4KPj4+PiAtLS0KPj4+PiDCoMKgIGRyaXZlcnMvbWVkaWEv
Y29tbW9uL3ZpZGVvYnVmMi9mcmFtZV92ZWN0b3IuYyB8IDIgKy0KPj4+PiDCoMKgIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Pj4+Cj4+Pj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbWVkaWEvY29tbW9uL3ZpZGVvYnVmMi9mcmFtZV92ZWN0b3IuYyBiL2RyaXZl
cnMvbWVkaWEvY29tbW9uL3ZpZGVvYnVmMi9mcmFtZV92ZWN0b3IuYwo+Pj4+IGluZGV4IDU0MmRk
ZTlkMjYwOS4uMDYyZTk4MTQ4YzUzIDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvbWVkaWEvY29t
bW9uL3ZpZGVvYnVmMi9mcmFtZV92ZWN0b3IuYwo+Pj4+ICsrKyBiL2RyaXZlcnMvbWVkaWEvY29t
bW9uL3ZpZGVvYnVmMi9mcmFtZV92ZWN0b3IuYwo+Pj4+IEBAIC01MCw3ICs1MCw3IEBAIGludCBn
ZXRfdmFkZHJfZnJhbWVzKHVuc2lnbmVkIGxvbmcgc3RhcnQsIHVuc2lnbmVkIGludCBucl9mcmFt
ZXMsCj4+Pj4gwqDCoMKgwqDCoMKgIHN0YXJ0ID0gdW50YWdnZWRfYWRkcihzdGFydCk7Cj4+Pj4g
wqDCoCDCoMKgwqDCoMKgIHJldCA9IHBpbl91c2VyX3BhZ2VzX2Zhc3Qoc3RhcnQsIG5yX2ZyYW1l
cywKPj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBGT0xMX0ZPUkNFIHwg
Rk9MTF9XUklURSB8IEZPTExfTE9OR1RFUk0sCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgRk9MTF9XUklURSB8IEZPTExfTE9OR1RFUk0sCj4+Pj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoc3RydWN0IHBhZ2UgKiopKHZlYy0+cHRycykp
Owo+Pj4+IMKgwqDCoMKgwqDCoCBpZiAocmV0ID4gMCkgewo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHZlYy0+Z290X3JlZiA9IHRydWU7Cj4+Pgo+Pj4KPj4+IEhpIEFuZHJldywKPj4+Cj4+PiBz
ZWUgdGhlIGRpc2N1c3Npb24gYXQgWzFdIHJlZ2FyZGluZyBhIGNvbmZsaWN0IGFuZCBob3cgdG8g
cHJvY2VlZCB3aXRoCj4+PiB1cHN0cmVhbWluZy4gVGhlIGNvbmZsaWN0IHdvdWxkIGJlIGVhc3kg
dG8gcmVzb2x2ZSwgaG93ZXZlciwgYWxzbwo+Pj4gdGhlIHBhdGNoIGRlc2NyaXB0aW9uIGRvZXNu
J3QgbWFrZSBzZW5zZSBhbnltb3JlIHdpdGggWzFdLgo+Pgo+PiBNaWdodCBpdCBiZSBlYXNpZXIg
YW5kIGxlc3MgY29uZnVzaW5nIGlmIHlvdSBwb3N0IGEgdjIgb2YgdGhpcyBzZXJpZXMKPj4gd2l0
aCBteSBwYXRjaCBmaXJzdD8gVGhhdCB3YXkgaXQgaXMgY2xlYXIgdGhhdCAxKSBteSBwYXRjaCBo
YXMgdG8gY29tZQo+PiBmaXJzdCwgYW5kIDIpIHRoYXQgaXQgaXMgcGFydCBvZiBhIHNpbmdsZSBz
ZXJpZXMgYW5kIHNob3VsZCBiZSBtZXJnZWQKPj4gYnkgdGhlIG1tIHN1YnN5c3RlbS4KPj4KPj4g
TGVzcyBjaGFuY2VzIG9mIHRoaW5ncyBnb2luZyB3cm9uZyB0aGF0IHdheS4KPj4KPj4gSnVzdCBt
ZW50aW9uIGluIHRoZSB2MiBjb3ZlciBsZXR0ZXIgdGhhdCB0aGUgZmlyc3QgcGF0Y2ggd2FzIGFk
ZGVkIHRvCj4+IG1ha2UgaXQgZWFzeSB0byBiYWNrcG9ydCB0aGF0IGZpeCB3aXRob3V0IGJlaW5n
IGhhbXBlcmVkIGJ5IG1lcmdlCj4+IGNvbmZsaWN0cyBpZiBpdCB3YXMgYWRkZWQgYWZ0ZXIgeW91
ciBmcmFtZV92ZWN0b3IuYyBwYXRjaC4KPiAKPiBZZXMsIHRoYXQncyB0aGUgd2F5IEkgd291bGQg
bmF0dXJhbGx5IGRvLCBpdCwgaG93ZXZlciwgQW5kcmV3IHByZWZlcnMgZGVsdGEgdXBkYXRlcyBm
b3IgbWlub3IgY2hhbmdlcy4KPiAKPiBAQW5kcmV3LCB3aGF0ZXZlciB5b3UgcHJlZmVyIQoKQW5k
cmV3LCBJJ3ZlIHJlc2VudCBteSBwYXRjaCwgdGhpcyB0aW1lIHdpdGggeW91IENDZWQgYXMgd2Vs
bC4KClJlZ2FyZHMsCgoJSGFucwoKPiAKPiBUaGFua3MhCj4gCgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4
LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC11bQo=

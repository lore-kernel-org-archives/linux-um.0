Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03927C4332F
	for <linux-um@archiver.kernel.org>; Mon, 28 Nov 2022 08:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Subject:From:References:Cc:
	To:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3mHMJj/sW9Xw6DcAImnSaNKI6GPHtkTNwPRHA8qAPz4=; b=NhuQ8CrGZmImzm
	G7u+Yxp87BeMHS3EzGFR09bb5ocfSHQ/9uYsngwEhQYPRDFeyFzRVd71uE7YhrpnIuSxUuY4QgHgS
	t4ek55zIeeJiwQykRdmEShuWsYoUpA6UZg9Ca49BxhsFMf3Al2EOdmRuJUiI8aLF/y6XAV/NMKWNN
	x2oTIBGIdxw8UAfe3xm6y3knOE6VFYQOBH9kjvBB6CGbBU9G7SRCYbT6TFiMeFijpRrLGGUN4sv6j
	CaLdn6y2glcLyxEzJyGNcVTuZiIzWpksYkYXWcaRIN6XY+ClzwgQ9zQHz1NZclzYFoD1tN+6EQipO
	wBzciAof9/FY72DJGI9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozZKh-0008KJ-AB; Mon, 28 Nov 2022 08:17:43 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozZKE-0007x1-CU; Mon, 28 Nov 2022 08:17:16 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 7EBFBB80C81;
	Mon, 28 Nov 2022 08:17:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF774C433D6;
	Mon, 28 Nov 2022 08:17:01 +0000 (UTC)
Message-ID: <08b65ac6-6786-1080-18f8-d2be109c85fc@xs4all.nl>
Date: Mon, 28 Nov 2022 09:17:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
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
From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH mm-unstable v1 16/20] mm/frame-vector: remove FOLL_FORCE
 usage
In-Reply-To: <81fb0fa3-2e06-b765-56ac-a7d981194e59@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221128_001714_770420_D3749370 
X-CRM114-Status: GOOD (  35.09  )
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

SGkgRGF2aWQsCgpPbiAyNy8xMS8yMDIyIDExOjM1LCBEYXZpZCBIaWxkZW5icmFuZCB3cm90ZToK
PiBPbiAxNi4xMS4yMiAxMToyNiwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6Cj4+IEZPTExfRk9S
Q0UgaXMgcmVhbGx5IG9ubHkgZm9yIHB0cmFjZSBhY2Nlc3MuIEFjY29yZGluZyB0byBjb21taXQK
Pj4gNzA3OTQ3MjQ3ZTk1ICgibWVkaWE6IHZpZGVvYnVmMi12bWFsbG9jOiBnZXRfdXNlcnB0cjog
YnVmZmVycyBhcmUgYWx3YXlzCj4+IHdyaXRhYmxlIiksIGdldF92YWRkcl9mcmFtZXMoKSBjdXJy
ZW50bHkgcGlucyBhbGwgcGFnZXMgd3JpdGFibGUgYXMgYQo+PiB3b3JrYXJvdW5kIGZvciBpc3N1
ZXMgd2l0aCByZWFkLW9ubHkgYnVmZmVycy4KPj4KPj4gRk9MTF9GT1JDRSwgaG93ZXZlciwgc2Vl
bXMgdG8gYmUgYSBsZWdhY3kgbGVmdG92ZXIgYXMgaXQgcHJlZGF0ZXMKPj4gY29tbWl0IDcwNzk0
NzI0N2U5NSAoIm1lZGlhOiB2aWRlb2J1ZjItdm1hbGxvYzogZ2V0X3VzZXJwdHI6IGJ1ZmZlcnMg
YXJlCj4+IGFsd2F5cyB3cml0YWJsZSIpLiBMZXQncyBqdXN0IHJlbW92ZSBpdC4KPj4KPj4gT25j
ZSB0aGUgcmVhZC1vbmx5IGJ1ZmZlciBpc3N1ZSBoYXMgYmVlbiByZXNvbHZlZCwgRk9MTF9XUklU
RSBjb3VsZAo+PiBhZ2FpbiBiZSBzZXQgZGVwZW5kaW5nIG9uIHRoZSBETUEgZGlyZWN0aW9uLgo+
Pgo+PiBDYzogSGFucyBWZXJrdWlsIDxodmVya3VpbEB4czRhbGwubmw+Cj4+IENjOiBNYXJlayBT
enlwcm93c2tpIDxtLnN6eXByb3dza2lAc2Ftc3VuZy5jb20+Cj4+IENjOiBUb21hc3ogRmlnYSA8
dGZpZ2FAY2hyb21pdW0ub3JnPgo+PiBDYzogTWFyZWsgU3p5cHJvd3NraSA8bS5zenlwcm93c2tp
QHNhbXN1bmcuY29tPgo+PiBDYzogTWF1cm8gQ2FydmFsaG8gQ2hlaGFiIDxtY2hlaGFiQGtlcm5l
bC5vcmc+Cj4+IFNpZ25lZC1vZmYtYnk6IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQu
Y29tPgo+PiAtLS0KPj4gwqAgZHJpdmVycy9tZWRpYS9jb21tb24vdmlkZW9idWYyL2ZyYW1lX3Zl
Y3Rvci5jIHwgMiArLQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvY29tbW9uL3ZpZGVvYnVm
Mi9mcmFtZV92ZWN0b3IuYyBiL2RyaXZlcnMvbWVkaWEvY29tbW9uL3ZpZGVvYnVmMi9mcmFtZV92
ZWN0b3IuYwo+PiBpbmRleCA1NDJkZGU5ZDI2MDkuLjA2MmU5ODE0OGM1MyAxMDA2NDQKPj4gLS0t
IGEvZHJpdmVycy9tZWRpYS9jb21tb24vdmlkZW9idWYyL2ZyYW1lX3ZlY3Rvci5jCj4+ICsrKyBi
L2RyaXZlcnMvbWVkaWEvY29tbW9uL3ZpZGVvYnVmMi9mcmFtZV92ZWN0b3IuYwo+PiBAQCAtNTAs
NyArNTAsNyBAQCBpbnQgZ2V0X3ZhZGRyX2ZyYW1lcyh1bnNpZ25lZCBsb25nIHN0YXJ0LCB1bnNp
Z25lZCBpbnQgbnJfZnJhbWVzLAo+PiDCoMKgwqDCoMKgIHN0YXJ0ID0gdW50YWdnZWRfYWRkcihz
dGFydCk7Cj4+IMKgIMKgwqDCoMKgwqAgcmV0ID0gcGluX3VzZXJfcGFnZXNfZmFzdChzdGFydCwg
bnJfZnJhbWVzLAo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBGT0xMX0ZP
UkNFIHwgRk9MTF9XUklURSB8IEZPTExfTE9OR1RFUk0sCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIEZPTExfV1JJVEUgfCBGT0xMX0xPTkdURVJNLAo+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoc3RydWN0IHBhZ2UgKiopKHZlYy0+cHRycykp
Owo+PiDCoMKgwqDCoMKgIGlmIChyZXQgPiAwKSB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB2ZWMt
PmdvdF9yZWYgPSB0cnVlOwo+IAo+IAo+IEhpIEFuZHJldywKPiAKPiBzZWUgdGhlIGRpc2N1c3Np
b24gYXQgWzFdIHJlZ2FyZGluZyBhIGNvbmZsaWN0IGFuZCBob3cgdG8gcHJvY2VlZCB3aXRoCj4g
dXBzdHJlYW1pbmcuIFRoZSBjb25mbGljdCB3b3VsZCBiZSBlYXN5IHRvIHJlc29sdmUsIGhvd2V2
ZXIsIGFsc28KPiB0aGUgcGF0Y2ggZGVzY3JpcHRpb24gZG9lc24ndCBtYWtlIHNlbnNlIGFueW1v
cmUgd2l0aCBbMV0uCgpNaWdodCBpdCBiZSBlYXNpZXIgYW5kIGxlc3MgY29uZnVzaW5nIGlmIHlv
dSBwb3N0IGEgdjIgb2YgdGhpcyBzZXJpZXMKd2l0aCBteSBwYXRjaCBmaXJzdD8gVGhhdCB3YXkg
aXQgaXMgY2xlYXIgdGhhdCAxKSBteSBwYXRjaCBoYXMgdG8gY29tZQpmaXJzdCwgYW5kIDIpIHRo
YXQgaXQgaXMgcGFydCBvZiBhIHNpbmdsZSBzZXJpZXMgYW5kIHNob3VsZCBiZSBtZXJnZWQKYnkg
dGhlIG1tIHN1YnN5c3RlbS4KCkxlc3MgY2hhbmNlcyBvZiB0aGluZ3MgZ29pbmcgd3JvbmcgdGhh
dCB3YXkuCgpKdXN0IG1lbnRpb24gaW4gdGhlIHYyIGNvdmVyIGxldHRlciB0aGF0IHRoZSBmaXJz
dCBwYXRjaCB3YXMgYWRkZWQgdG8KbWFrZSBpdCBlYXN5IHRvIGJhY2twb3J0IHRoYXQgZml4IHdp
dGhvdXQgYmVpbmcgaGFtcGVyZWQgYnkgbWVyZ2UKY29uZmxpY3RzIGlmIGl0IHdhcyBhZGRlZCBh
ZnRlciB5b3VyIGZyYW1lX3ZlY3Rvci5jIHBhdGNoLgoKUmVnYXJkcywKCglIYW5zCgo+IAo+IAo+
IE9uIHRvcCBvZiBtbS11bnN0YWJsZSwgcmV2ZXJ0aW5nIHRoaXMgcGF0Y2ggYW5kIGFwcGx5aW5n
IFsxXSBnaXZlcyBtZQo+IGFuIHVwZGF0ZWQgcGF0Y2g6Cj4gCj4gCj4gRnJvbSAxZTY2YzI1ZjE0
NjdjMWYxZTVmMjc1MzEyZjJjNmRmMjkzMDhkNGRmIE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQo+
IEZyb206IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQuY29tPgo+IERhdGU6IFdlZCwg
MTYgTm92IDIwMjIgMTE6MjY6NTUgKzAxMDAKPiBTdWJqZWN0OiBbUEFUQ0hdIG1tL2ZyYW1lLXZl
Y3RvcjogcmVtb3ZlIEZPTExfRk9SQ0UgdXNhZ2UKPiAKPiBHVVAgbm93IHN1cHBvcnRzIHJlbGlh
YmxlIFIvTyBsb25nLXRlcm0gcGlubmluZyBpbiBDT1cgbWFwcGluZ3MsIHN1Y2gKPiB0aGF0IHdl
IGJyZWFrIENPVyBlYXJseS4gTUFQX1NIQVJFRCBWTUFzIG9ubHkgdXNlIHRoZSBzaGFyZWQgemVy
b3BhZ2Ugc28KPiBmYXIgaW4gb25lIGNvcm5lciBjYXNlIChEQVhGUyBmaWxlIHdpdGggaG9sZXMp
LCB3aGljaCBjYW4gYmUgaWdub3JlZAo+IGJlY2F1c2UgR1VQIGRvZXMgbm90IHN1cHBvcnQgbG9u
Zy10ZXJtIHBpbm5pbmcgaW4gZnNkYXggKHNlZQo+IGNoZWNrX3ZtYV9mbGFncygpKS4KPiAKPiBD
b25zZXF1ZW50bHksIEZPTExfRk9SQ0UgfCBGT0xMX1dSSVRFIHwgRk9MTF9MT05HVEVSTSBpcyBu
byBsb25nZXIgcmVxdWlyZWQKPiBmb3IgcmVsaWFibGUgUi9PIGxvbmctdGVybSBwaW5uaW5nOiBG
T0xMX0xPTkdURVJNIGlzIHN1ZmZpY2llbnQuIFNvIHN0b3AKPiB1c2luZyBGT0xMX0ZPUkNFLCB3
aGljaCBpcyByZWFsbHkgb25seSBmb3IgcHRyYWNlIGFjY2Vzcy4KPiAKPiBSZXZpZXdlZC1ieTog
RGFuaWVsIFZldHRlciA8ZGFuaWVsLnZldHRlckBmZndsbC5jaD4KPiBBY2tlZC1ieTogSGFucyBW
ZXJrdWlsIDxodmVya3VpbC1jaXNjb0B4czRhbGwubmw+Cj4gQ2M6IEhhbnMgVmVya3VpbCA8aHZl
cmt1aWxAeHM0YWxsLm5sPgo+IENjOiBNYXJlayBTenlwcm93c2tpIDxtLnN6eXByb3dza2lAc2Ft
c3VuZy5jb20+Cj4gQ2M6IFRvbWFzeiBGaWdhIDx0ZmlnYUBjaHJvbWl1bS5vcmc+Cj4gQ2M6IE1h
cmVrIFN6eXByb3dza2kgPG0uc3p5cHJvd3NraUBzYW1zdW5nLmNvbT4KPiBDYzogTWF1cm8gQ2Fy
dmFsaG8gQ2hlaGFiIDxtY2hlaGFiQGtlcm5lbC5vcmc+Cj4gU2lnbmVkLW9mZi1ieTogRGF2aWQg
SGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+Cj4gLS0tCj4gwqBkcml2ZXJzL21lZGlhL2Nv
bW1vbi92aWRlb2J1ZjIvZnJhbWVfdmVjdG9yLmMgfCAyICstCj4gwqAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
ZWRpYS9jb21tb24vdmlkZW9idWYyL2ZyYW1lX3ZlY3Rvci5jIGIvZHJpdmVycy9tZWRpYS9jb21t
b24vdmlkZW9idWYyL2ZyYW1lX3ZlY3Rvci5jCj4gaW5kZXggYWFkNzI2NDBmMDU1Li44NjA2ZmRh
Y2Y1YjggMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9tZWRpYS9jb21tb24vdmlkZW9idWYyL2ZyYW1l
X3ZlY3Rvci5jCj4gKysrIGIvZHJpdmVycy9tZWRpYS9jb21tb24vdmlkZW9idWYyL2ZyYW1lX3Zl
Y3Rvci5jCj4gQEAgLTQxLDcgKzQxLDcgQEAgaW50IGdldF92YWRkcl9mcmFtZXModW5zaWduZWQg
bG9uZyBzdGFydCwgdW5zaWduZWQgaW50IG5yX2ZyYW1lcywgYm9vbCB3cml0ZSwKPiDCoMKgwqDC
oCBpbnQgcmV0X3Bpbl91c2VyX3BhZ2VzX2Zhc3QgPSAwOwo+IMKgwqDCoMKgIGludCByZXQgPSAw
Owo+IMKgwqDCoMKgIGludCBlcnI7Cj4gLcKgwqDCoCB1bnNpZ25lZCBpbnQgZ3VwX2ZsYWdzID0g
Rk9MTF9GT1JDRSB8IEZPTExfTE9OR1RFUk07Cj4gK8KgwqDCoCB1bnNpZ25lZCBpbnQgZ3VwX2Zs
YWdzID0gRk9MTF9MT05HVEVSTTsKPiDCoAo+IMKgwqDCoMKgIGlmIChucl9mcmFtZXMgPT0gMCkK
PiDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAwOwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtdW0K

Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A5BCE79CE
	for <linux-um@archiver.kernel.org>; Wed, 20 Sep 2023 13:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:MIME-Version:
	Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pKoBQ8Rc4XZ4kW8KWMsWpJ6f6fBu32LX1S9B8Wyt+Yw=; b=VDbAnWT0/InfdcrpdciwKTO9Il
	hY3ahfROGS43GFE9SDVcev5n7GYj6k606qwxDM0k5oBKcecVLSO3tmWrQSYmYTl9GUK/H61qGHBfC
	fFtqN1p15UwwEV5Ko3hJVL2V26aamT7MpIFkzhlNgodt4/cLDs01uFqCJaglS6a69Lb3xz3Dt+26X
	s7Xa4hztx2Sm4ApuZTOQqnwmubKG2YjSsgvJ2+a0ASl0/K8aa3Knw+4tzE6bSaeyp7O5DLzpF/w0a
	EDC0CAt8n0+iqTifxH6yodm8U8hc9yXy+EbYmPz0/T7JHiZ/xYffWt5NzNrXl0gFolCZwQwz/Q+W6
	eS6ZFyRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiwqP-0037QR-1d;
	Wed, 20 Sep 2023 13:02:17 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiwqM-0037PF-1D
	for linux-um@lists.infradead.org;
	Wed, 20 Sep 2023 13:02:16 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1qiwqK-002Vu8-Az
	for linux-um@lists.infradead.org; Wed, 20 Sep 2023 13:02:12 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1qiwqH-00HHB5-MK
	for linux-um@lists.infradead.org; Wed, 20 Sep 2023 14:02:11 +0100
Message-ID: <8d7d9d49-aada-dc61-940f-a38a03bbfecf@kot-begemot.co.uk>
Date: Wed, 20 Sep 2023 14:02:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Boots and seems to work with PREEMPT enabled
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
To: User Mode Linux <linux-um@lists.infradead.org>
References: <6eb21cc7-05d5-c9be-6abd-07bdda64dcb6@kot-begemot.co.uk>
 <d1d9054e-197c-18b1-bb2d-ef7f5737495f@kot-begemot.co.uk>
In-Reply-To: <d1d9054e-197c-18b1-bb2d-ef7f5737495f@kot-begemot.co.uk>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230920_060214_512327_6E8652FB 
X-CRM114-Status: GOOD (  19.12  )
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

CgpPbiAyMC8wOS8yMDIzIDEzOjMwLCBBbnRvbiBJdmFub3Ygd3JvdGU6Cj4gCj4gCj4gT24gMjAv
MDkvMjAyMyAxMjoxNCwgQW50b24gSXZhbm92IHdyb3RlOgo+PiBBZGRlZCBzdXBwb3J0IGZvciBr
ZXJuZWwgc2lkZSBmcHUgc3RvcmUvcmVzdG9yZSBhbmQgcmVhbCBrZXJuZWxfZnB1X2JlZ2luL2tl
cm5lbF9mcHVfZW5kIHVzaW5nIGdjYyBpbnRyaW5zaWNzLiBFbmFibGVkIFBSRUVNUFQuCj4+Cj4+
IEl0IGJvb3RzIGFuZCBzZWVtcyB0byBiZSBhbGl2ZSBhbmQga2lja2luZy4gSSBkbyBub3Qgbm90
aWNlIGFueSBzaWduaWZpY2FudCBlZmZlY3Qgb24gcGVyZm9ybWFuY2UgZWl0aGVyLgo+Pgo+IAo+
IEkgdGFrZSBteSB3b3JkcyBiYWNrIC0gSSB3YXMgdGVzdGluZyB3aXRoIFZPTFVOVEFSWSB3aGlj
aCBzZWVtcyB0byBwcm92aWRlIGEgZGlmZmVyZW5jZSB3aXRoaW5nIHRoZSBtYXJnaW4gb2YgZXJy
b3IuCj4gCj4gRW5hYmxpbmcgZm9yY2VkIHByZWVtcHRpb24gZHJvcHMgdGhlIHRpbWUgZm9yCj4g
Cj4gZmluZCAvdXNyIC10eXBlIGYgLWV4ZWMgY2F0IHt9ID4gL2Rldi9udWxsIFw7Cj4gCj4gZnJv
bQo+IAo+IHJlYWzCoMKgwqAgMTltMTEuMjA3cwo+IHVzZXLCoMKgwqAgMG0wLjE4MHMKPiBzeXPC
oMKgwqAgMm00MS4xNjBzCj4gCj4gdG8KPiAKPiByZWFswqDCoMKgIDNtMTMuNjQ3cwo+IHVzZXLC
oMKgwqAgMG0wLjAwMHMKPiBzeXPCoMKgwqAgMm01OC4yNzBzCj4gCj4gQW5kIGJvb3QgdGltZSBm
cm9tIDExLjVzIHRvIDZzLgo+IAo+IEl0IGRpZCBjb21wbGFpbiBvbiBzaHV0ZG93biB0aG91Z2gg
d2l0aCBzb21lIHRyYWNlcy4gTm90aGluZyB3aGlsZSBydW5uaW5nLgoKVGhlIGNvbXBsYWludCBJ
IGdldCBpcyBmcm9tIGhlcmU6IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjYt
cmMyL3NvdXJjZS9rZXJuZWwvc2NoZWQvY29yZS5jI0w1MjI5CgpUaGlzIGxvb2tzIGJyb2tlbiBm
b3IgVVAuIE9uIFVQIHRoZSBwcmVlbXB0IGNvdW50IGlzIG5vdCBpbmMtZWQgdHdpY2UsIGJlY2F1
c2UgdGhlIFVQIHZlcnNpb24gb2YgX3Jhd19zcGluX2xvY2tfaXJxIGRvZXMgbm90IHRvdWNoIGl0
LCBoZW5jZSBpdCBpcyBvZGQsIG5vdCBldmVuLgoKT3RoZXIgdGhhbiB0aGF0IGl0IGFsbCB3b3Jr
cy4gU29tZSBkZWNyZWFzZSBpbiB0b3RhbCBuZXR3b3JrIHRocm91Z2hwdXQgKGV4cGVjdGVkKSwg
c2VyaW91cyBpbmNyZWFzZSBpbiB1c2Vyc3BhY2UgcmVzcG9uc2l2ZW5lc3MgKG1vcmUgdGhhbiBl
eHBlY3RlZCkuIE5vIGNyYXNoZXMuCgpUaGlzIGxlYXZlcyBvcGVuZWQgdHdvIHF1ZXN0aW9uczoK
CjEuIERvIHdlIGRvIGFueXRoaW5nIGFib3V0IHRoaXMgb25lCjIuIEhvdyBkbyB3ZSBlbmFibGUg
cHJlZW1wdGlvbiBmb3Igdm9sdW50YXJ5LgoKPiAKPiBUaGUgcGF0Y2ggd2lsbCBoaXQgdGhlIG1h
aWxpbmcgbGlzdCBzaG9ydGx5Lgo+IAo+IAo+PiBIb3cgZG8gSSB0ZXN0IGl0IGZyb20gaGVyZSBv
bndhcmRzPwo+IAo+IFRoZSBxdWVzdGlvbiBzdGlsbCBzdGFuZHMuIENhbiB3ZSB1c2UgYW55dGhp
bmcgYXMgYSBzcGVjaWZpYyB0ZXN0IHN1aXRlPyBJdCBpcyBub3QgYW4gYXJlYSBJIGFtIGZhbWls
aWFyIHdpdGgsIHNvIGFueSBwb2ludGVycyB3aWxsIGJlIHdlbGNvbWUuCj4gCj4+Cj4+IEkgYW0g
aGFwcHkgdG8gdGhyb3cgdGhlIHBhdGNoZXMgb24gdGhlIGxpc3QgYXMgYW4gUkZDLCB0aG91Z2gg
SSB3b3VsZCBwcmVmZXIgdG8gdGVzdCBmaXJzdCA6KQo+Pgo+IAoKLS0gCkFudG9uIFIuIEl2YW5v
dgpodHRwczovL3d3dy5rb3QtYmVnZW1vdC5jby51ay8KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtdW0K

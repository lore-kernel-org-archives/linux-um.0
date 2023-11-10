Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B7EC4332F
	for <linux-um@archiver.kernel.org>; Fri, 10 Nov 2023 15:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8UJYRVZwWg9XoAKKNNDawNPjjIDDbATZihzljyYIZX0=; b=FNWrDSHFFJ2v1k
	8WQZtGohK1rpFzXnE7SXvapY2+mXas5wyjyOsJ0MepKZMJ0Z9icsnDLQExnVDFJr4aXiS/JY1Niph
	99+9Lz5mAk0D1lbNPHt8hQG+rJ1iJwFWhksruY0sAmCS4bH+AnPq0k35ZJdacbZjqkGWKNRpuZiF0
	eeLFwyL1Muwu+HsvgyO+PqOeUSSqeqXhozlsf/5zB8oj8dx5HTcqEuupBjTqexk1umwaXySUMkIP5
	9zT6zzoI84qKccYNeCLJCP1GfB1unC3bBe4zLKvBvgpCf2txbi8B29FLc5fls5DGRLSTeivJV8Yxa
	ZcRsgJOF69qep02d8JMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r1Tpv-0093HN-1M;
	Fri, 10 Nov 2023 15:54:23 +0000
Received: from mx2.uni-rostock.de ([139.30.22.72])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r1Tpp-0093Gd-0D
	for linux-um@lists.infradead.org;
	Fri, 10 Nov 2023 15:54:21 +0000
Received: from 139.30.22.84 by mx2.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Fri, 10 Nov 2023 15:54:03 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1699631643; bh=mCmeKY8Q0XhZ70+IoSsW8pj7Z4H993SSCyr32MXeyyI=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=ed25519-sha256; b=
 Lii1e9qLALc1o/GGoa2S2fo9G3S4tZTRNqL/k4TavL5rQOWwkJZ+/xCU9Hfe1Qi/NpMPYrejNoxajO61o1sdBA==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1699631643; bh=mCmeKY8Q0XhZ70+IoSsW8pj7Z4H993SSCyr32MXeyyI=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 VujyRxvDQ8ZHI8VybR0r7hEwIEwd07HPEJOJ/VjUW3DMbXgSy35dR5/tLRyzZPj4tckvltoT3kMmw9DLf+SKUzyynJl3K+D4N5G9+2RfRPodbQp1yxxNfXmHUxn5eL8bsmM00uJ4ldO7US+9M1kJymztfBQU1AIn3MIkn6tM1NQ=
Received: from [139.30.201.32] (139.30.201.32) by mail1.uni-rostock.de
 (139.30.22.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 10 Nov
 2023 16:54:02 +0100
Message-ID: <867df5dc-8e78-48de-aa1a-da7c8fedb5e6@uni-rostock.de>
Date: Fri, 10 Nov 2023 16:54:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 10/11] um: Delay timer_read only in possible busy
 loops in TT-mode
Content-Language: de-DE
To: Johannes Berg <johannes@sipsolutions.net>, Richard Weinberger
	<richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
CC: <linux-um@lists.infradead.org>
References: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
 <20231103-bb-timetravel-patches-v1-10-e2c68efcf664@uni-rostock.de>
 <7daf6651289bd6b48e069f4d0dd7751244177a44.camel@sipsolutions.net>
From: Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>
Organization: =?UTF-8?Q?Universit=C3=A4t_Rostock?=
In-Reply-To: <7daf6651289bd6b48e069f4d0dd7751244177a44.camel@sipsolutions.net>
X-Originating-IP: [139.30.201.32]
X-ClientProxiedBy: EMAIL2.uni-rostock.de (139.30.22.82) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: 867EC086C451FBAAF9DA3F7714D42FC083C2821ECF48A78F267D08B9271928DB2000:8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231110_075419_192957_350716D7 
X-CRM114-Status: GOOD (  24.50  )
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

QW0gMDYuMTEuMjAyMyB1bSAyMTo1MSBzY2hyaWViIEpvaGFubmVzIEJlcmc6Cj4gT24gRnJpLCAy
MDIzLTExLTAzIGF0IDE2OjQxICswMDAwLCBCZW5qYW1pbiBCZWljaGxlciB3cm90ZToKPj4gVGhp
cyBzbG93cyBkb3duIGV4dGVybmFsIFRULW1vZGUgYXMgbW9yZSBzaW11bGF0aW9uIHJvdW5kdHJp
cHMgYXJlCj4+IHJlcXVpcmVkLCBhbmQgaXQgdW5uZWNlc3NhcmlseSBhZmZlY3RzIHRoZSBkZXRl
cm1pbmlzbSBhbmQgYWNjdXJhY3kgb2YKPj4gdGhlIHNpbXVsYXRpb24uCj4gSSBzdGlsbCBkb24n
dCB0aGluayB0aGlzIGlzIHJlYWxseSB0cnVlLCBpdCBkb2Vzbid0IHJlYWxseSBhZmZlY3QKPiBk
ZXRlcm1pbmlzbT8gSXQgbWFrZXMgaXQgLi4uIGRpZmZlcmVudCwgc3VyZSwgYnV0IG5vdCBub24t
ZGV0ZXJtaW5pc3RpYz8KSSBpbnRlbnRpb25hbGx5IGtlcHQgaXQgdmFndWUsIGJ1dCB3aGF0IEkg
bWVhbnQgaXMgdGhhdCBpdCdzIAp1bm5lY2Vzc2FyaWx5IGNoYWxsZW5naW5nIHRvIGRldGVybWlu
ZS4KClBlcmhhcHMgSSBzaG91bGQgbWVudGlvbiB0aGF0IEknbSBydW5uaW5nIGFuIHVubW9kaWZp
ZWQgVWJ1bnR1IHJvb3RmcyAKd2l0aCBzeXN0ZW1kLCB3aGljaCBzdGFydHMgbWFueSBkYWVtb25z
IGFuZCBvdGhlciBwcm9jZXNzZXMuCgpUbyBtZSwgaXQgc2VlbXMgaWxsb2dpY2FsIHRvIGRlbGF5
IGV2ZXJ5dGhpbmcganVzdCBiZWNhdXNlIG9uZSBwcm9jZXNzIAppcyB3YWl0aW5nIGZvciBhIHRp
bWVzdGFtcC4KCkF0IHRoZSBtb21lbnQsIHdlIGhhdmVuJ3QgcGF0Y2hlZCB0aGUgcmFuZG9tIGRl
dmljZSB0aGF0IGZldGNoZXMgcmFuZG9tIApieXRlcyBmcm9tIHRoZSBob3N0IChkbyB5b3UgYWxy
ZWFkeSBoYXZlIGEgcGF0Y2ggZm9yIHRoaXM/KSwKc28gY29tcGxldGUgcmVwZWF0YWJpbGl0eSBp
c24ndCBndWFyYW50ZWVkIGF0IHRoZSBtb21lbnQuIEhvd2V2ZXIsIHRoYXQgCmNvdWxkIGJlIGEg
bG9naWNhbCBuZXh0IHN0ZXAuCj4+ICtzdGF0aWMgY29uc3QgaW50IHN1c3BpY2lvdXNfYnVzeV9s
b29wX3N5c2NhbGxzW10gPSB7Cj4+ICsgICAgIDM2LCAvL3N5c19nZXRpdGltZXIKPj4gKyAgICAg
OTYsIC8vc3lzX2dldHRpbWVvZmRheQo+PiArICAgICAyMDEsIC8vc3lzX3RpbWUKPj4gKyAgICAg
MjI0LCAvL3N5c190aW1lcl9nZXR0aW1lCj4+ICsgICAgIDIyOCwgLy9zeXNfY2xvY2tfZ2V0dGlt
ZQo+PiArICAgICAyODcsIC8vc3lzX3RpbWVyZmRfZ2V0dGltZQo+PiArfTsKPiBUaGF0J3Mga2lu
ZCBvZiBhd2Z1bC4gU3VyZWx5IHdlIGNhbiB1c2UgX19OUl90aW1lcl9nZXR0aW1lIGV0Yy4gaGVy
ZSBhdAo+IGxlYXN0PwpBY3R1YWxseSwgdGhpcyB3YXMgYSBxdWljayBhdHRlbXB0IHRvIGFkZHJl
c3MgdGhlIGlzc3VlLCBhbmQgZHVyaW5nIHRoYXQgCnBlcmlvZCwgSSBjb3VsZG4ndCBsb2NhdGUg
dGhlIGFwcHJvcHJpYXRlIG1hY3Jvcy4KClRoZXNlIG51bWJlcnMgYXJlIGdlbmVyYXRlZCBmcm9t
IGFyY2gveDg2L2VudHJ5L3N5c2NhbGxzL3N5c2NhbGxfNjQudGJsIAoob3IgMzIgaWYgY29uZmln
dXJlZCBpbiB0aGF0IG1hbm5lcikuCgpJIG1pZ2h0IGJlIG92ZXJsb29raW5nIHNvbWV0aGluZywg
YnV0IGl0IHNlZW1zIHRoYXQgX19OUl90aW1lcl9nZXR0aW1lIAppc24ndCBkZWZpbmVkIGluIHRo
ZSBrZXJuZWwuIElmIHlvdSBoYXZlIGEgYmV0dGVyIHJlZmVyZW5jZSBmb3IgdGhpcyAKdHJhbnNs
YXRpb24sIEknZCBhcHByZWNpYXRlIGl0LgoKSSBjb3VsZCB2ZXJpZnkgaWYgdGhlIGN1cnJlbnQg
c3lzY2FsbCB0cmFuc2xhdGVzIGludG8gdGhlIGNvcnJlc3BvbmRpbmcgCmZ1bmN0aW9uIHN5bWJv
bCBpbiB0aGUgdW0tc3lzY2FsbCB0YWJsZS4KPj4gK3N0YXRpYyBib29sIHN1c3BpY2lvdXNfYnVz
eV9sb29wKHZvaWQpCj4+ICt7Cj4+ICsgICAgIGludCBpOwo+PiArICAgICBpbnQgc3lzY2FsbCA9
IHN5c2NhbGxfZ2V0X25yKGN1cnJlbnQsIHRhc2tfcHRfcmVncyhjdXJyZW50KSk7Cj4+ICsKPj4g
KyAgICAgZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUoc3VzcGljaW91c19idXN5X2xvb3Bfc3lz
Y2FsbHMpOyBpKyspIHsKPj4gKyAgICAgICAgICAgICBpZiAoc3VzcGljaW91c19idXN5X2xvb3Bf
c3lzY2FsbHNbaV0gPT0gc3lzY2FsbCkKPj4gKyAgICAgICAgICAgICAgICAgICAgIHJldHVybiB0
cnVlOwo+PiArICAgICB9Cj4gTWlnaHQgYWxzbyBiZSBmYXN0ZXIgdG8gaGF2ZSBhIGJpdG1hcD8g
QnV0IC4uLiBhbHNvIGtpbmQgb2YgYXdrd2FyZCBJCj4gZ3Vlc3MuCkFjdHVhbGx5LCBhIHNob3J0
IGZpeGVkIHNpemUgYXJyYXkgc2hvdWxkIGJlIG9wdGltaXplZCBxdWl0ZSB3ZWxsIHdpdGggCmxv
b3AgdW5yb2xsaW5nIG9yIG90aGVyIHN0dWZmLCBpc24ndCBpdD8gSSBjb3VsZCBhbHNvIGRvIGEg
c3dpdGNoIHdpdGggCmFsbCBjYWxscywgYnV0IHRoaXMgbG9vcCBzZWVtcyBmb3IgbWUgdGhlIGVh
c2llc3QuCj4gSSBkdW5uby4gSSdtIG5vdCBldmVuIHN1cmUgd2hhdCB5b3UncmUgdHJ5aW5nIHRv
IGFjaGlldmUgLSBhcGFydCBmcm9tCj4gImRldGVybWluaXNtIiB3aGljaCBzZWVtcyBvZGQgb3Ig
ZXZlbiB3cm9uZywgYW5kIHNwZWVkLCB3aGljaCBpcwo+IHByb2JhYmx5IGVhc2llciBkb25lIHdp
dGggYSBiZXR0ZXIgZnJlZS11bnRpbCBhbmQgdGhlIHNoYXJlZCBtZW1vcnkKPiBjYWxlbmRhciB3
ZSBoYXZlIGJlZW4gd29ya2luZyBvbi4KSW4gbXkgcGVyc3BlY3RpdmUsIGRlbGF5aW5nIGdldF90
aW1lciBvbmx5IHNlcnZlcyBhcyBhIHRpZS1icmVha2VyIGZvciAKcG9vcmx5IGJlaGF2aW5nIHNv
ZnR3YXJlIHRoYXQgcmVzb3J0cyB0byBhIGJ1c3ktbG9vcCB3aGlsZSB3YWl0aW5nIGZvciAKdGlt
ZSB0byBhZHZhbmNlLgoKV2hpbGUgdGhpcyBiZWhhdmlvciBtaWdodCBub3QgYmUgdW5jb21tb24s
IHdoeSBwZW5hbGl6ZSBhbGwgcHJvY2Vzc2VzIApmb3IgaXQ/CgpDb25zaWRlciBhbiBleHBlcmlt
ZW50IHdoZXJlIEkgYWltIHRvIG1lYXN1cmUgdGhlIGltcGFjdCBvZiBuZXR3b3JrIApsYXRlbmN5
IG9uIHNvZnR3YXJlLiBTb21ldGltZXMsIHRoZSByZXNwb25zZSBsYXRlbmN5IGZsdWN0dWF0ZXMK
YmVjYXVzZSBhIGJhY2tncm91bmQgdGFzayB3YXMgc2NoZWR1bGVkIHJhbmRvbWx5IGJ1dCBkZXRl
cm1pbmlzdGljYWxseSAKYXQgdGhlIHNhbWUgdGltZSwgb2J0YWluaW5nIGEgdGltZXN0YW1wIHRo
YXQgYmxvY2tzIGFsbCBvdGhlcgpwcm9jZXNzZXMgYW5kIGFkdmFuY2VzIHNpbXVsYXRpb24gdGlt
ZS4gVGhpcyBhY3Rpb24gc2ltcGx5IHVuZGVybWluZXMgCnRoZSB1dGlsaXR5IG9mIHRoZSB0aW1l
IHRyYXZlbCBtb2RlIHVubmVjZXNzYXJpbHkuCgpIb3dldmVyLCBzb2Z0d2FyZSBhY3RpdmVseSB3
YWl0aW5nIGZvciB0aW1lIGFkdmFuY2VtZW50IGluIGEgYnVzeSBsb29wIAphY2hpZXZlcyBpdHMg
Z29hbC4gSXTigJlzIGFsbW9zdCBhIHdpbi13aW4gc2l0dWF0aW9uLCBpc24ndCBpdD8KCkJlbmph
bWluCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGlu
dXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=

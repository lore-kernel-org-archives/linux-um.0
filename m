Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWa35-007Zl2-WE
 for linux-um@lists.infradead.org; Wed, 14 Apr 2021 07:34:57 +0000
Message-ID: <9f8280540bbc6f3c857ac5749eeafcd145577da3.camel@sipsolutions.net>
Subject: Re: [PATCH 0/4 POC] Allow executing code and syscalls in another
 address space
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 14 Apr 2021 09:34:40 +0200
In-Reply-To: <78cdee11-1923-595f-90d2-e236efbafa6a@cambridgegreys.com>
References: <20210414055217.543246-1-avagin@gmail.com>
 <78cdee11-1923-595f-90d2-e236efbafa6a@cambridgegreys.com>
MIME-Version: 1.0
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
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, criu@openvz.org, avagin@google.com, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Christian Brauner <christian.brauner@ubuntu.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>

T24gV2VkLCAyMDIxLTA0LTE0IGF0IDA4OjIyICswMTAwLCBBbnRvbiBJdmFub3Ygd3JvdGU6Cj4g
T24gMTQvMDQvMjAyMSAwNjo1MiwgQW5kcmVpIFZhZ2luIHdyb3RlOgo+ID4gV2UgYWxyZWFkeSBo
YXZlIHByb2Nlc3Nfdm1fcmVhZHYgYW5kIHByb2Nlc3Nfdm1fd3JpdGV2IHRvIHJlYWQgYW5kIHdy
aXRlCj4gPiB0byBhIHByb2Nlc3MgbWVtb3J5IGZhc3RlciB0aGFuIHdlIGNhbiBkbyB0aGlzIHdp
dGggcHRyYWNlLiBBbmQgbm93IGl0Cj4gPiBpcyB0aW1lIGZvciBwcm9jZXNzX3ZtX2V4ZWMgdGhh
dCBhbGxvd3MgZXhlY3V0aW5nIGNvZGUgaW4gYW4gYWRkcmVzcwo+ID4gc3BhY2Ugb2YgYW5vdGhl
ciBwcm9jZXNzLiBXZSBjYW4gZG8gdGhpcyB3aXRoIHB0cmFjZSBidXQgaXQgaXMgbXVjaAo+ID4g
c2xvd2VyLgo+ID4gCj4gPiA9IFVzZS1jYXNlcyA9Cj4gPiAKPiA+IEhlcmUgYXJlIHR3byBrbm93
biB1c2UtY2FzZXMuIFRoZSBmaXJzdCBvbmUgaXMg4oCcYXBwbGljYXRpb24ga2VybmVs4oCdCj4g
PiBzYW5kYm94ZXMgbGlrZSBVc2VyLW1vZGUgTGludXggYW5kIGdWaXNvci4gSW4gdGhpcyBjYXNl
LCB3ZSBoYXZlIGEKPiA+IHByb2Nlc3MgdGhhdCBydW5zIHRoZSBzYW5kYm94IGtlcm5lbCBhbmQg
YSBzZXQgb2Ygc3R1YiBwcm9jZXNzZXMgdGhhdAo+ID4gYXJlIHVzZWQgdG8gbWFuYWdlIGd1ZXN0
IGFkZHJlc3Mgc3BhY2VzLiBHdWVzdCBjb2RlIGlzIGV4ZWN1dGVkIGluIHRoZQo+ID4gY29udGV4
dCBvZiBzdHViIHByb2Nlc3NlcyBidXQgYWxsIHN5c3RlbSBjYWxscyBhcmUgaW50ZXJjZXB0ZWQg
YW5kCj4gPiBoYW5kbGVkIGluIHRoZSBzYW5kYm94IGtlcm5lbC4gUmlnaHQgbm93LCB0aGVzZSBz
b3J0IG9mIHNhbmRib3hlcyB1c2UKPiA+IFBUUkFDRV9TWVNFTVUgdG8gdHJhcCBzeXN0ZW0gY2Fs
bHMsIGJ1dCB0aGUgcHJvY2Vzc192bV9leGVjIGNhbgo+ID4gc2lnbmlmaWNhbnRseSBzcGVlZCB0
aGVtIHVwLgo+IAo+IENlcnRhaW5seSBpbnRlcmVzdGluZywgYnV0IHdpbGwgcmVxdWlyZSB1bSB0
byByZXdvcmsgbW9zdCBvZiBpdHMgbWVtb3J5IAo+IG1hbmFnZW1lbnQgYW5kIHdlIHdpbGwgbW9z
dCBsaWtlbHkgbmVlZCBleHRyYSBtbSBzdXBwb3J0IHRvIG1ha2UgdXNlIG9mIAo+IGl0IGluIFVN
TC4gV2UgYXJlIG5vdCBsaWtlbHkgdG8gZ2V0IGF3YXkganVzdCB3aXRoIG9uZSBzeXNjYWxsIHRo
ZXJlLgoKTWlnaHQgaGVscCB0aGUgc2VjY29tcCBtb2RlIHRob3VnaDoKCmh0dHBzOi8vcGF0Y2h3
b3JrLm96bGFicy5vcmcvcHJvamVjdC9saW51eC11bS9saXN0Lz9zZXJpZXM9MjMxOTgwCgpqb2hh
bm5lcwoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
aW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==


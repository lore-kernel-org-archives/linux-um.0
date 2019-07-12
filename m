Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hlrlP-0003eb-4Q
 for linux-um@lists.infradead.org; Fri, 12 Jul 2019 09:22:48 +0000
Subject: Re: [PATCH] User mode linux bump maximum MTU tuntap interface [RESAND]
References: <54cee375-f1c3-a2b3-ea89-919b0af60433@yandex.ru>
 <fc526c78-2d3f-90ca-8317-a89eb653cbf9@yandex.ru>
 <CAFLxGvytDC1TFdT0m9vvijz_93B8TziWURcR-3mskWB-7TzFag@mail.gmail.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <1fb36224-81c0-0c4c-72c4-5a60dfe207ef@cambridgegreys.com>
Date: Fri, 12 Jul 2019 10:22:41 +0100
MIME-Version: 1.0
In-Reply-To: <CAFLxGvytDC1TFdT0m9vvijz_93B8TziWURcR-3mskWB-7TzFag@mail.gmail.com>
Content-Language: en-US
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
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Richard Weinberger <richard.weinberger@gmail.com>, =?UTF-8?B?0JDQu9C10LrRgdC10Lk=?= <ne-vlezay80@yandex.ru>
Cc: netdev@vger.kernel.org, linux-um@lists.infradead.org

T24gMDIvMDcvMjAxOSAxNTo0MCwgUmljaGFyZCBXZWluYmVyZ2VyIHdyb3RlOgo+IENDJ2luZyB1
bSBmb2xrcy4KPiAKPiBPbiBUdWUsIEp1bCAyLCAyMDE5IGF0IDM6MDEgUE0g0JDQu9C10LrRgdC1
0LkgPG5lLXZsZXpheTgwQHlhbmRleC5ydT4gd3JvdGU6Cj4+Cj4+IEhlbGxvLCB0aGUgcGFyYW1l
dGVyICBFVEhfTUFYX1BBQ0tFVCBsaW1pdGVkIHRvIDE1MDAgYnl0ZXMgaXMgdGhlIG5vdAo+PiBz
dXBwb3J0IGp1bWJvIGZyYW1lcy4KPj4KPj4gVGhpcyBwYXRjaCBjaGFuZ2UgRVRIX01BWF9QQUNL
RVQgdGhlIDY1NTM1IGJ5dGVzIHRvIGp1bWJvIGZyYW1lIHN1cHBvcnQKPj4gd2l0aCB1c2VyIG1v
ZGUgbGludXggdHVudGFwIGRyaXZlci4KPj4KPj4KPj4gUEFUQ0g6Cj4+Cj4+IC0tLS0tLS0tLS0t
LS0tLS0tLS0KPj4KPj4KPj4gZGlmZiAtcnVOUCAuLi9saW51eF9vcmlnL2xpbnV4LTUuMS9hcmNo
L3VtL2luY2x1ZGUvc2hhcmVkL25ldF91c2VyLmgKPj4gLi9hcmNoL3VtL2luY2x1ZGUvc2hhcmVk
L25ldF91c2VyLmgKPj4gLS0tIGEvYXJjaC91bS9pbmNsdWRlL3NoYXJlZC9uZXRfdXNlci5oICAg
IDIwMTktMDUtMDYgMDA6NDI6NTguMDAwMDAwMDAwCj4+ICswMDAwCj4+ICsrKyBiL2FyY2gvdW0v
aW5jbHVkZS9zaGFyZWQvbmV0X3VzZXIuaCAgICAyMDE5LTA3LTAyIDA3OjE0OjEzLjU5MzMzMzM1
Ngo+PiArMDAwMAo+PiBAQCAtOSw3ICs5LDcgQEAKPj4gICAjZGVmaW5lIEVUSF9BRERSX0xFTiAo
NikKPj4gICAjZGVmaW5lIEVUSF9IRUFERVJfRVRIRVJUQVAgKDE2KQo+PiAgICNkZWZpbmUgRVRI
X0hFQURFUl9PVEhFUiAoMjYpIC8qIDE0IGZvciBldGhlcm5ldCArIFZMQU4gKyBNUExTIGZvcgo+
PiBjcmF6eSBwZW9wbGUgKi8KPj4gLSNkZWZpbmUgRVRIX01BWF9QQUNLRVQgKDE1MDApCj4+ICsj
ZGVmaW5lIEVUSF9NQVhfUEFDS0VUICg2NTUzNSkKPj4KPj4gICAjZGVmaW5lIFVNTF9ORVRfVkVS
U0lPTiAoNCkKPj4KPj4gLS0tLS0tLS0tLS0tLS0tLS0tLQo+Pgo+Pgo+IAo+IAoKVGhpcyBkb2Vz
IG5vdCBxdWl0ZSB3b3JrIGJlY2F1c2UgaW4gc29tZSBvZiB0aGUgZHJpdmVycyB5b3UgZ2V0IGV4
dHJhIAphZGRlZCBvbiB0b3Agb2YgdGhpcyBjb25zdGFudC4KCkkgYW0gZ29pbmcgdG8gc2VlIHdo
YXQgY2FuIGJlIGRvbmUgdG8gZml4IHRoZSBvbGQgbmV0KiBkcml2ZXJzLCBpbWhvIHdlIApzaG91
bGQgc3RhcnQgcGhhc2luZyB0aGVtIG91dCBpbiBmYXZvciBvZiB0aGUgdmVjdG9yIG9uZXMuCgot
LSAKQW50b24gUi4gSXZhbm92CkNhbWJyaWRnZWdyZXlzIExpbWl0ZWQuIFJlZ2lzdGVyZWQgaW4g
RW5nbGFuZC4gQ29tcGFueSBOdW1iZXIgMTAyNzM2NjEKaHR0cHM6Ly93d3cuY2FtYnJpZGdlZ3Jl
eXMuY29tLwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=


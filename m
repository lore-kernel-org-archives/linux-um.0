Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hiKhN-0000li-Ln
 for linux-um@lists.infradead.org; Tue, 02 Jul 2019 15:28:04 +0000
Subject: Re: [PATCH] User mode linux bump maximum MTU tuntap interface [RESAND]
References: <54cee375-f1c3-a2b3-ea89-919b0af60433@yandex.ru>
 <fc526c78-2d3f-90ca-8317-a89eb653cbf9@yandex.ru>
 <CAFLxGvytDC1TFdT0m9vvijz_93B8TziWURcR-3mskWB-7TzFag@mail.gmail.com>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <86215743-4340-7d54-6657-19546de2377a@kot-begemot.co.uk>
Date: Tue, 2 Jul 2019 15:47:13 +0100
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

CgpPbiAwMi8wNy8yMDE5IDE1OjQwLCBSaWNoYXJkIFdlaW5iZXJnZXIgd3JvdGU6Cj4gQ0MnaW5n
IHVtIGZvbGtzLgo+IAo+IE9uIFR1ZSwgSnVsIDIsIDIwMTkgYXQgMzowMSBQTSDQkNC70LXQutGB
0LXQuSA8bmUtdmxlemF5ODBAeWFuZGV4LnJ1PiB3cm90ZToKPj4KPj4gSGVsbG8sIHRoZSBwYXJh
bWV0ZXIgIEVUSF9NQVhfUEFDS0VUIGxpbWl0ZWQgdG8gMTUwMCBieXRlcyBpcyB0aGUgbm90Cj4+
IHN1cHBvcnQganVtYm8gZnJhbWVzLgo+Pgo+PiBUaGlzIHBhdGNoIGNoYW5nZSBFVEhfTUFYX1BB
Q0tFVCB0aGUgNjU1MzUgYnl0ZXMgdG8ganVtYm8gZnJhbWUgc3VwcG9ydAo+PiB3aXRoIHVzZXIg
bW9kZSBsaW51eCB0dW50YXAgZHJpdmVyLgo+Pgo+Pgo+PiBQQVRDSDoKPj4KPj4gLS0tLS0tLS0t
LS0tLS0tLS0tLQo+Pgo+Pgo+PiBkaWZmIC1ydU5QIC4uL2xpbnV4X29yaWcvbGludXgtNS4xL2Fy
Y2gvdW0vaW5jbHVkZS9zaGFyZWQvbmV0X3VzZXIuaAo+PiAuL2FyY2gvdW0vaW5jbHVkZS9zaGFy
ZWQvbmV0X3VzZXIuaAo+PiAtLS0gYS9hcmNoL3VtL2luY2x1ZGUvc2hhcmVkL25ldF91c2VyLmgg
ICAgMjAxOS0wNS0wNiAwMDo0Mjo1OC4wMDAwMDAwMDAKPj4gKzAwMDAKPj4gKysrIGIvYXJjaC91
bS9pbmNsdWRlL3NoYXJlZC9uZXRfdXNlci5oICAgIDIwMTktMDctMDIgMDc6MTQ6MTMuNTkzMzMz
MzU2Cj4+ICswMDAwCj4+IEBAIC05LDcgKzksNyBAQAo+PiAgICNkZWZpbmUgRVRIX0FERFJfTEVO
ICg2KQo+PiAgICNkZWZpbmUgRVRIX0hFQURFUl9FVEhFUlRBUCAoMTYpCj4+ICAgI2RlZmluZSBF
VEhfSEVBREVSX09USEVSICgyNikgLyogMTQgZm9yIGV0aGVybmV0ICsgVkxBTiArIE1QTFMgZm9y
Cj4+IGNyYXp5IHBlb3BsZSAqLwo+PiAtI2RlZmluZSBFVEhfTUFYX1BBQ0tFVCAoMTUwMCkKPj4g
KyNkZWZpbmUgRVRIX01BWF9QQUNLRVQgKDY1NTM1KQo+Pgo+PiAgICNkZWZpbmUgVU1MX05FVF9W
RVJTSU9OICg0KQo+Pgo+PiAtLS0tLS0tLS0tLS0tLS0tLS0tCj4+Cj4+Cj4gCj4gCgpUaGUgdmVj
dG9yIHZlcnNpb24gZm9yIHRhcCBhbHJlYWR5IGFsbG93cyBtdHUgPiAxNTAwLiBJdCBkb2VzIG5v
dCBoYXZlIGEgCmNoZWNrIHRvIGxpbWl0IGl0IHRvIDY1NTM1IG1heCB0aG91Z2ggYW5kIGl0IHNo
b3VsZC4KCkkgd2lsbCBhZGQgdGhpcyBvbmUgdG8gdGhlIHF1ZXVlIG9mIHN0dWZmIGZvciB0aGUg
bmV0d29yayBkcml2ZXJzLiBJTUhPIAp3ZSBzaG91bGQgc3RhcnQgbWlncmF0aW5nIHNvbWUgb2Yg
dGhlIG9sZGVyIG9uZXMgdG8gdmVjdG9yIElPLgoKLS0gCkFudG9uIFIuIEl2YW5vdgpodHRwczov
L3d3dy5rb3QtYmVnZW1vdC5jby51ay8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtdW0K


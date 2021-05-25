Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Subject: Re: [PATCH] LOCKDEP: use depends on LOCKDEP_SUPPORT instead of $ARCH
 list
References: <20210517034430.9569-1-rdunlap@infradead.org>
 <YKIXBpxyvhzdb1uv@gmail.com>
 <1284b997-b9da-769f-2d36-4d4232c7df88@redhat.com>
 <bfb11ab2-d606-b96e-1979-3bcc3c3adc96@infradead.org>
 <8a4ee5be-ad5c-ca06-dd1a-aa13ccc94906@redhat.com>
 <c8698ce3-4995-efd6-9d1d-095dcac70dc2@infradead.org>
 <09243238-94ba-caca-441e-3fdac0154822@infradead.org>
 <3a0fb04c-c640-25db-7e7a-fbdd3b4defb5@redhat.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0213cd4e-e832-f768-106a-345e77ce2665@infradead.org>
Date: Mon, 24 May 2021 21:18:26 -0700
MIME-Version: 1.0
In-Reply-To: <3a0fb04c-c640-25db-7e7a-fbdd3b4defb5@redhat.com>
Content-Language: en-US
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
To: Waiman Long <llong@redhat.com>, Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Johannes Berg <johannes@sipsolutions.net>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org

T24gNS8yNC8yMSA1OjA1IFBNLCBXYWltYW4gTG9uZyB3cm90ZToKPiBPbiA1LzI0LzIxIDU6NDEg
UE0sIFJhbmR5IER1bmxhcCB3cm90ZToKPj4gT24gNS8yNC8yMSAyOjMxIFBNLCBSYW5keSBEdW5s
YXAgd3JvdGU6Cj4+PiBPbiA1LzI0LzIxIDI6MDQgUE0sIFdhaW1hbiBMb25nIHdyb3RlOgo+Pj4K
Pj4+PiBJcyBpdCBwb3NzaWJsZSB0byBqdXN0IGdldCByaWQgb2YgdGhlIDJuZCBkZXBlbmRzLW9u
IHN0YXRlbWVudD8KPj4+Pgo+Pj4+IFRoZSAybmQgZGVwZW5kcy1vbiBsaW5lIHdhcyBpbnRyb2R1
Y2VkIGJ5IGNvbW1pdCA3ZDM3Y2IyYzkxMmQgKCJsaWI6IGZpeCBrY29uZmlnIGRlcGVuZGVuY3kg
b24gQVJDSF9XQU5UX0ZSQU1FX1BPSU5URVIiKToKPj4+IGFuZCBJIHNob3VsZCBoYXZlIGxvb2tl
ZCBhdCB0aGF0IGhpc3RvcnkgdG9vLiBUaGFua3MuCj4+Pgo+Pj4gWWVzLCBJIGFncmVlLCB3ZSBj
YW4ganVzdCBkZWxldGUgdGhhdCBsaW5lLi4uCj4+Pgo+Pj4gSSdsbCBzZW5kIGEgdjIgYW5kIGNv
cHkgdGhlIGF1dGhvciBvZiBjb21taXQgN2QzN2NiMmM5MTJkIGFzIHdlbGwuCj4+IEhtLCBhcyBJ
IHJldmlldyB0aGF0IGNvbW1pdCwgSSBoYXZlIHRvIHdvbmRlciBpZiB0aGUgcHJldmlvdXMgJ3Nl
bGVjdCcKPj4gd2FzIGNvcnJlY3QgKGlmIHdlIGRpc3JlZ2FyZCB0aGUgS2NvbmZpZyB3YXJuaW5n
KS7CoCBJZiBzbywgdGhlbgo+PiBGUkFNRV9QT0lOVEVSIGlzIHN0aWxsIHdhbnRlZC9uZWVkZWQg
Zm9yIHNvbWUgYXJjaC1lcy4KPj4KPj4gZGlmZiAtLWdpdCBhL2xpYi9LY29uZmlnLmRlYnVnIGIv
bGliL0tjb25maWcuZGVidWcKPj4gaW5kZXggMjc3OWMyOWQ5OTgxLi40MTdjM2QzZTUyMWIgMTAw
NjQ0Cj4+IC0tLSBhL2xpYi9LY29uZmlnLmRlYnVnCj4+ICsrKyBiL2xpYi9LY29uZmlnLmRlYnVn
Cj4+IEBAIC0xMzYzLDcgKzEzNjMsNyBAQCBjb25maWcgTE9DS0RFUAo+PiDCoMKgwqDCoMKgwqDC
oMKgIGJvb2wKPj4gwqDCoMKgwqDCoMKgwqDCoCBkZXBlbmRzIG9uIERFQlVHX0tFUk5FTCAmJiBM
T0NLX0RFQlVHR0lOR19TVVBQT1JUCj4+IMKgwqDCoMKgwqDCoMKgwqAgc2VsZWN0IFNUQUNLVFJB
Q0UKPj4gLcKgwqDCoMKgwqDCoCBzZWxlY3QgRlJBTUVfUE9JTlRFUiBpZiAhTUlQUyAmJiAhUFBD
ICYmICFBUk0gJiYgIVMzOTAgJiYgIU1JQ1JPQkxBWkUgJiYgIUFSQyAmJiAhWDg2IDw8PDw8PDw8
PDw8Cj4+Cj4gQUZBSUNTLCBlbmFibGluZyBGUkFNRV9QT0lOVEVSIGlzIGEgZGVidWdnaW5nIGFp
ZCBhcyBpdCBlbmFibGUgbW9yZSBwcmVjaXNlIHN0YWNrdHJhY2UuIEhvd2V2ZXIsIG5vdCBhbGwg
YXJjaHMgd2FudCB0byBlbmFibGUgRlJBTUVfUE9JTlRFUiBiZWNhdXNlIG9mIExPQ0tERVAuIE5v
dyB5b3UgYXJlIGp1c3QgbGV0dGluZyB1c2VycyBkZWNpZGUgaWYgdGhleSB3YW50IEZSQU1FX1BP
SU5URVIgb3Igbm90LiBNYXliZSB5b3UgY2FuIG1vZGlmeSB0aGUgaGVscCB0ZXh0IHRvIG1lbnRp
b24gdGhhdC4KCkxPQ0tERVAgZG9lc24ndCBoYXZlIGFueSB1c2VyIGhlbHAgdGV4dC4KCkZvciBG
UkFNRV9QT0lOVEVSLCB3aGVuIEFSQ0hfV0FOVF9GUkFNRV9QT0lOVEVSUyArIGEgZmV3IG90aGVy
IGNvbmRpdGlvbnMKaXMgbWV0LCBpdCBzZWVtcyB0aGF0IHRoZSBGUkFNRV9QT0lOVEVSIGhlbHAg
dGV4dCBpcyBnb29kIGVub3VnaCBJTU8uCgoJaGVscAoJICBJZiB5b3Ugc2F5IFkgaGVyZSB0aGUg
cmVzdWx0aW5nIGtlcm5lbCBpbWFnZSB3aWxsIGJlIHNsaWdodGx5CgkgIGxhcmdlciBhbmQgc2xv
d2VyLCBidXQgaXQgZ2l2ZXMgdmVyeSB1c2VmdWwgZGVidWdnaW5nIGluZm9ybWF0aW9uCgkgIGlu
IGNhc2Ugb2Yga2VybmVsIGJ1Z3MuIChwcmVjaXNlIG9vcHNlcy9zdGFja3RyYWNlcy93YXJuaW5n
cykKCi0tIAp+UmFuZHkKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==


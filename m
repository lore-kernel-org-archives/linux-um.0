Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llXqf-005alz-8Y
 for linux-um@lists.infradead.org; Tue, 25 May 2021 14:15:58 +0000
Received: by mail-qt1-f198.google.com with SMTP id
 h7-20020ac846c70000b0290231af0e7829so32372qto.7
 for <linux-um@lists.infradead.org>; Tue, 25 May 2021 07:15:50 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
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
 <0213cd4e-e832-f768-106a-345e77ce2665@infradead.org>
Message-ID: <38797295-8c65-814a-c550-298da324b988@redhat.com>
Date: Tue, 25 May 2021 10:15:47 -0400
MIME-Version: 1.0
In-Reply-To: <0213cd4e-e832-f768-106a-345e77ce2665@infradead.org>
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
To: Randy Dunlap <rdunlap@infradead.org>, Waiman Long <llong@redhat.com>, Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Johannes Berg <johannes@sipsolutions.net>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org

T24gNS8yNS8yMSAxMjoxOCBBTSwgUmFuZHkgRHVubGFwIHdyb3RlOgo+IE9uIDUvMjQvMjEgNTow
NSBQTSwgV2FpbWFuIExvbmcgd3JvdGU6Cj4+IE9uIDUvMjQvMjEgNTo0MSBQTSwgUmFuZHkgRHVu
bGFwIHdyb3RlOgo+Pj4gT24gNS8yNC8yMSAyOjMxIFBNLCBSYW5keSBEdW5sYXAgd3JvdGU6Cj4+
Pj4gT24gNS8yNC8yMSAyOjA0IFBNLCBXYWltYW4gTG9uZyB3cm90ZToKPj4+Pgo+Pj4+PiBJcyBp
dCBwb3NzaWJsZSB0byBqdXN0IGdldCByaWQgb2YgdGhlIDJuZCBkZXBlbmRzLW9uIHN0YXRlbWVu
dD8KPj4+Pj4KPj4+Pj4gVGhlIDJuZCBkZXBlbmRzLW9uIGxpbmUgd2FzIGludHJvZHVjZWQgYnkg
Y29tbWl0IDdkMzdjYjJjOTEyZCAoImxpYjogZml4IGtjb25maWcgZGVwZW5kZW5jeSBvbiBBUkNI
X1dBTlRfRlJBTUVfUE9JTlRFUiIpOgo+Pj4+IGFuZCBJIHNob3VsZCBoYXZlIGxvb2tlZCBhdCB0
aGF0IGhpc3RvcnkgdG9vLiBUaGFua3MuCj4+Pj4KPj4+PiBZZXMsIEkgYWdyZWUsIHdlIGNhbiBq
dXN0IGRlbGV0ZSB0aGF0IGxpbmUuLi4KPj4+Pgo+Pj4+IEknbGwgc2VuZCBhIHYyIGFuZCBjb3B5
IHRoZSBhdXRob3Igb2YgY29tbWl0IDdkMzdjYjJjOTEyZCBhcyB3ZWxsLgo+Pj4gSG0sIGFzIEkg
cmV2aWV3IHRoYXQgY29tbWl0LCBJIGhhdmUgdG8gd29uZGVyIGlmIHRoZSBwcmV2aW91cyAnc2Vs
ZWN0Jwo+Pj4gd2FzIGNvcnJlY3QgKGlmIHdlIGRpc3JlZ2FyZCB0aGUgS2NvbmZpZyB3YXJuaW5n
KS7CoCBJZiBzbywgdGhlbgo+Pj4gRlJBTUVfUE9JTlRFUiBpcyBzdGlsbCB3YW50ZWQvbmVlZGVk
IGZvciBzb21lIGFyY2gtZXMuCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2xpYi9LY29uZmlnLmRlYnVn
IGIvbGliL0tjb25maWcuZGVidWcKPj4+IGluZGV4IDI3NzljMjlkOTk4MS4uNDE3YzNkM2U1MjFi
IDEwMDY0NAo+Pj4gLS0tIGEvbGliL0tjb25maWcuZGVidWcKPj4+ICsrKyBiL2xpYi9LY29uZmln
LmRlYnVnCj4+PiBAQCAtMTM2Myw3ICsxMzYzLDcgQEAgY29uZmlnIExPQ0tERVAKPj4+ICDCoMKg
wqDCoMKgwqDCoMKgIGJvb2wKPj4+ICDCoMKgwqDCoMKgwqDCoMKgIGRlcGVuZHMgb24gREVCVUdf
S0VSTkVMICYmIExPQ0tfREVCVUdHSU5HX1NVUFBPUlQKPj4+ICDCoMKgwqDCoMKgwqDCoMKgIHNl
bGVjdCBTVEFDS1RSQUNFCj4+PiAtwqDCoMKgwqDCoMKgIHNlbGVjdCBGUkFNRV9QT0lOVEVSIGlm
ICFNSVBTICYmICFQUEMgJiYgIUFSTSAmJiAhUzM5MCAmJiAhTUlDUk9CTEFaRSAmJiAhQVJDICYm
ICFYODYgPDw8PDw8PDw8PDwKPj4+Cj4+IEFGQUlDUywgZW5hYmxpbmcgRlJBTUVfUE9JTlRFUiBp
cyBhIGRlYnVnZ2luZyBhaWQgYXMgaXQgZW5hYmxlIG1vcmUgcHJlY2lzZSBzdGFja3RyYWNlLiBI
b3dldmVyLCBub3QgYWxsIGFyY2hzIHdhbnQgdG8gZW5hYmxlIEZSQU1FX1BPSU5URVIgYmVjYXVz
ZSBvZiBMT0NLREVQLiBOb3cgeW91IGFyZSBqdXN0IGxldHRpbmcgdXNlcnMgZGVjaWRlIGlmIHRo
ZXkgd2FudCBGUkFNRV9QT0lOVEVSIG9yIG5vdC4gTWF5YmUgeW91IGNhbiBtb2RpZnkgdGhlIGhl
bHAgdGV4dCB0byBtZW50aW9uIHRoYXQuCj4gTE9DS0RFUCBkb2Vzbid0IGhhdmUgYW55IHVzZXIg
aGVscCB0ZXh0Lgo+Cj4gRm9yIEZSQU1FX1BPSU5URVIsIHdoZW4gQVJDSF9XQU5UX0ZSQU1FX1BP
SU5URVJTICsgYSBmZXcgb3RoZXIgY29uZGl0aW9ucwo+IGlzIG1ldCwgaXQgc2VlbXMgdGhhdCB0
aGUgRlJBTUVfUE9JTlRFUiBoZWxwIHRleHQgaXMgZ29vZCBlbm91Z2ggSU1PLgo+Cj4gCWhlbHAK
PiAJICBJZiB5b3Ugc2F5IFkgaGVyZSB0aGUgcmVzdWx0aW5nIGtlcm5lbCBpbWFnZSB3aWxsIGJl
IHNsaWdodGx5Cj4gCSAgbGFyZ2VyIGFuZCBzbG93ZXIsIGJ1dCBpdCBnaXZlcyB2ZXJ5IHVzZWZ1
bCBkZWJ1Z2dpbmcgaW5mb3JtYXRpb24KPiAJICBpbiBjYXNlIG9mIGtlcm5lbCBidWdzLiAocHJl
Y2lzZSBvb3BzZXMvc3RhY2t0cmFjZXMvd2FybmluZ3MpCj4KUmlnaHQuIEkgYW0gZmluZSB3aXRo
IHRoYXQuCgpUaGFua3MsCkxvbmdtYW4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LXVtCg==


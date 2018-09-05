Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fxQot-00027i-Oz
 for linux-um@lists.infradead.org; Wed, 05 Sep 2018 05:57:41 +0000
Received: by mail-wm0-f67.google.com with SMTP id t25-v6so6337161wmi.3
 for <linux-um@lists.infradead.org>; Tue, 04 Sep 2018 22:57:28 -0700 (PDT)
Subject: Re: [PATCH 01/25] tty: Change return type to void
References: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
 <1536029091-4426-2-git-send-email-climbbb.kim@gmail.com>
 <3b5cce6a-b4c3-edf9-51c8-0a16f156e128@cogentembedded.com>
 <CAL6iAaKzDPe7CMGR8VOBZRsJqZuNB1=zek_YVvwcKnjimbox2g@mail.gmail.com>
From: Jiri Slaby <jslaby@suse.cz>
Message-ID: <d3d5df26-4678-2539-e579-1c48bc726163@suse.cz>
Date: Wed, 5 Sep 2018 07:57:25 +0200
MIME-Version: 1.0
In-Reply-To: <CAL6iAaKzDPe7CMGR8VOBZRsJqZuNB1=zek_YVvwcKnjimbox2g@mail.gmail.com>
Content-Language: en-GB
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
To: Jaejoong Kim <climbbb.kim@gmail.com>, sergei.shtylyov@cogentembedded.com
Cc: devel@driverdev.osuosl.org, linux-s390@vger.kernel.org, greybus-dev@lists.linaro.org, Greg KH <gregkh@linuxfoundation.org>, USB list <linux-usb@vger.kernel.org>, linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, netdev@vger.kernel.org, sparclinux@vger.kernel.org, linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

T24gMDkvMDUvMjAxOCwgMDM6MDggQU0sIEphZWpvb25nIEtpbSB3cm90ZToKPiAgICAgPiBAQCAt
Njg4LDcgKzY4OCw3IEBAIGV4dGVybiBpbnQgdHR5X3BvcnRfY2xvc2Vfc3RhcnQoc3RydWN0Cj4g
ICAgIHR0eV9wb3J0ICpwb3J0LAo+ICAgICA+wqAgwqBleHRlcm4gdm9pZCB0dHlfcG9ydF9jbG9z
ZV9lbmQoc3RydWN0IHR0eV9wb3J0ICpwb3J0LCBzdHJ1Y3QKPiAgICAgdHR5X3N0cnVjdCAqdHR5
KTsKPiAgICAgPsKgIMKgZXh0ZXJuIHZvaWQgdHR5X3BvcnRfY2xvc2Uoc3RydWN0IHR0eV9wb3J0
ICpwb3J0LAo+ICAgICA+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBzdHJ1Y3QgdHR5X3N0cnVjdCAqdHR5LCBzdHJ1Y3QgZmlsZQo+ICAgICAqZmlscCk7Cj4g
ICAgID4gLWV4dGVybiBpbnQgdHR5X3BvcnRfaW5zdGFsbChzdHJ1Y3QgdHR5X3BvcnQgKnBvcnQs
IHN0cnVjdAo+ICAgICB0dHlfZHJpdmVyICpkcml2ZXIsCj4gICAgID4gK2V4dGVybiB2b2lkIHR0
eV9wb3J0X2luc3RhbGwoc3RydWN0IHR0eV9wb3J0ICpwb3J0LCBzdHJ1Y3QKPiAgICAgdHR5X2Ry
aXZlciAqZHJpdmVyLAo+ICAgICA+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBzdHJ1Y3QgdHR5X3N0cnVjdCAqdHR5KTsKPiAKPiAgICAgwqAgwqAgWW91IG5l
ZWQgdG8gdXBkYXRlIGFsbCB0aGUgY2FsbGVycyBpbiB0aGUgc2FtZSBwYXRjaCAtLSB0aGUKPiAg
ICAga2VybmVsIG11c3QKPiAgICAgcmVtYWluIGJ1aWxkYWJsZSBhZnRlciBlYWNoIHBhdGNoIGJ1
dCB5b3Ugc2VlbSB0byBoYXZlIHNwcmVhZCB0aGF0Cj4gICAgIHVwZGF0ZQo+ICAgICBhbW9uZyBh
IGxvdCBvZiBwYXRjaGVzLi4KPiAKPiAKPiBPSy4gSSB3aWxsIG1ha2Ugc2V2ZXJhbCBwYXRjaGVz
IGFzIG9uZSBwYXRjaC4KCllvdSBkb24ndCBoYXZlIHRvLiBKdXN0IHJlb3JkZXIgdGhlIHBhdGNo
ZXMgYXMgc3VnZ2VzdGVkIGJ5IFNhbS4gKEZpcnN0LAptYWtlIGV2ZXJ5Ym9keSBpZ25vcmUgdGhl
IHJldHVybiB2YWx1ZSwgdGhlbiBjaGFuZ2UgdGhlc2UgcmV0dXJuIHR5cGVzCnRvIHZvaWQuKQoK
QlRXIHlvdSBjYW4gbWVudGlvbiBpbiB0aGlzIGNvbW1pdCBsb2csIHRoYXQgdGhpcyBjaGFuZ2Ug
aXMgcG9zc2libGUKYWZ0ZXIgYTMxMjNmZDBhNGE1LiBUaGF0IGNvbW1pdCBtYWRlIHR0eV9zdGFu
ZGFyZF9pbnN0YWxsIHRvIGFsd2F5cwpyZXR1cm4gMC4KCnRoYW5rcywKLS0gCmpzCnN1c2UgbGFi
cwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
dW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=


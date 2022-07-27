Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGXTP-008C4z-Kx
	for linux-um@lists.infradead.org; Wed, 27 Jul 2022 03:12:36 +0000
Received: by mail-pj1-f71.google.com with SMTP id oo11-20020a17090b1c8b00b001f285a3bdf0so459577pjb.5
        for <linux-um@lists.infradead.org>; Tue, 26 Jul 2022 20:12:32 -0700 (PDT)
Message-ID: <15aa26f2-f8af-5dbd-f2b2-9270ad873412@redhat.com>
Date: Wed, 27 Jul 2022 11:12:19 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v13 16/42] virtio_ring: split: introduce
 virtqueue_resize_split()
References: <20220726072225.19884-1-xuanzhuo@linux.alibaba.com>
 <20220726072225.19884-17-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220726072225.19884-17-xuanzhuo@linux.alibaba.com>
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
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux-foundation.org
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, "Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>, Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, linux-um@lists.infradead.org, netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, kangjie.xu@linux.alibaba.com

CuWcqCAyMDIyLzcvMjYgMTU6MjEsIFh1YW4gWmh1byDlhpnpgZM6Cj4gdmlydGlvIHJpbmcgc3Bs
aXQgc3VwcG9ydHMgcmVzaXplLgo+Cj4gT25seSBhZnRlciB0aGUgbmV3IHZyaW5nIGlzIHN1Y2Nl
c3NmdWxseSBhbGxvY2F0ZWQgYmFzZWQgb24gdGhlIG5ldyBudW0sCj4gd2Ugd2lsbCByZWxlYXNl
IHRoZSBvbGQgdnJpbmcuIEluIGFueSBjYXNlLCBhbiBlcnJvciBpcyByZXR1cm5lZCwKPiBpbmRp
Y2F0aW5nIHRoYXQgdGhlIHZyaW5nIHN0aWxsIHBvaW50cyB0byB0aGUgb2xkIHZyaW5nLgo+Cj4g
SW4gdGhlIGNhc2Ugb2YgYW4gZXJyb3IsIHJlLWluaXRpYWxpemUodmlydHF1ZXVlX3JlaW5pdF9z
cGxpdCgpKSB0aGUKPiB2aXJ0cXVldWUgdG8gZW5zdXJlIHRoYXQgdGhlIHZyaW5nIGNhbiBiZSB1
c2VkLgo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJh
LmNvbT4KPiBBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPiAtLS0K
PiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCAzNCArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrCj4gICAxIGZpbGUgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKQo+Cj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcmluZy5jCj4gaW5kZXggYjZmZGE5MWM4MDU5Li41ODM1NWUxYWM3ZDcgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ICsrKyBiL2RyaXZlcnMvdmly
dGlvL3ZpcnRpb19yaW5nLmMKPiBAQCAtMjIwLDYgKzIyMCw3IEBAIHN0YXRpYyBzdHJ1Y3Qgdmly
dHF1ZXVlICpfX3ZyaW5nX25ld192aXJ0cXVldWUodW5zaWduZWQgaW50IGluZGV4LAo+ICAgCQkJ
CQkgICAgICAgdm9pZCAoKmNhbGxiYWNrKShzdHJ1Y3QgdmlydHF1ZXVlICopLAo+ICAgCQkJCQkg
ICAgICAgY29uc3QgY2hhciAqbmFtZSk7Cj4gICBzdGF0aWMgc3RydWN0IHZyaW5nX2Rlc2NfZXh0
cmEgKnZyaW5nX2FsbG9jX2Rlc2NfZXh0cmEodW5zaWduZWQgaW50IG51bSk7Cj4gK3N0YXRpYyB2
b2lkIHZyaW5nX2ZyZWUoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxKTsKPiAgIAo+ICAgLyoKPiAgICAq
IEhlbHBlcnMuCj4gQEAgLTExMTcsNiArMTExOCwzOSBAQCBzdGF0aWMgc3RydWN0IHZpcnRxdWV1
ZSAqdnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZV9zcGxpdCgKPiAgIAlyZXR1cm4gdnE7Cj4gICB9Cj4g
ICAKPiArc3RhdGljIGludCB2aXJ0cXVldWVfcmVzaXplX3NwbGl0KHN0cnVjdCB2aXJ0cXVldWUg
Kl92cSwgdTMyIG51bSkKPiArewo+ICsJc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZV9zcGxpdCB2cmlu
Z19zcGxpdCA9IHt9Owo+ICsJc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEgPSB0b192dnEoX3Zx
KTsKPiArCXN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2ID0gX3ZxLT52ZGV2Owo+ICsJaW50IGVy
cjsKPiArCj4gKwllcnIgPSB2cmluZ19hbGxvY19xdWV1ZV9zcGxpdCgmdnJpbmdfc3BsaXQsIHZk
ZXYsIG51bSwKPiArCQkJCSAgICAgIHZxLT5zcGxpdC52cmluZ19hbGlnbiwKPiArCQkJCSAgICAg
IHZxLT5zcGxpdC5tYXlfcmVkdWNlX251bSk7Cj4gKwlpZiAoZXJyKQo+ICsJCWdvdG8gZXJyOwoK
CkkgdGhpbmsgd2UgZG9uJ3QgbmVlZCB0byBkbyBhbnl0aGluZyBoZXJlPwoKCj4gKwo+ICsJZXJy
ID0gdnJpbmdfYWxsb2Nfc3RhdGVfZXh0cmFfc3BsaXQoJnZyaW5nX3NwbGl0KTsKPiArCWlmIChl
cnIpIHsKPiArCQl2cmluZ19mcmVlX3NwbGl0KCZ2cmluZ19zcGxpdCwgdmRldik7Cj4gKwkJZ290
byBlcnI7CgoKSSBzdWdnZXN0IHRvIG1vdmUgdnJpbmdfZnJlZV9zcGxpdCgpIGludG8gYSBkZWRp
Y2F0ZWQgZXJyb3IgbGFiZWwuCgpUaGFua3MKCgo+ICsJfQo+ICsKPiArCXZyaW5nX2ZyZWUoJnZx
LT52cSk7Cj4gKwo+ICsJdmlydHF1ZXVlX3ZyaW5nX2luaXRfc3BsaXQoJnZyaW5nX3NwbGl0LCB2
cSk7Cj4gKwo+ICsJdmlydHF1ZXVlX2luaXQodnEsIHZyaW5nX3NwbGl0LnZyaW5nLm51bSk7Cj4g
Kwl2aXJ0cXVldWVfdnJpbmdfYXR0YWNoX3NwbGl0KHZxLCAmdnJpbmdfc3BsaXQpOwo+ICsKPiAr
CXJldHVybiAwOwo+ICsKPiArZXJyOgo+ICsJdmlydHF1ZXVlX3JlaW5pdF9zcGxpdCh2cSk7Cj4g
KwlyZXR1cm4gLUVOT01FTTsKPiArfQo+ICsKPiAgIAo+ICAgLyoKPiAgICAqIFBhY2tlZCByaW5n
IHNwZWNpZmljIGZ1bmN0aW9ucyAtICpfcGFja2VkKCkuCgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVt
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC11bQo=


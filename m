Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o7CeZ-003myu-9q
	for linux-um@lists.infradead.org; Fri, 01 Jul 2022 09:09:32 +0000
Received: by mail-pg1-f199.google.com with SMTP id g34-20020a635662000000b0040d1da6ada4so1028944pgm.1
        for <linux-um@lists.infradead.org>; Fri, 01 Jul 2022 02:09:28 -0700 (PDT)
Message-ID: <6256ad45-1606-f805-3427-ecee360c011f@redhat.com>
Date: Fri, 1 Jul 2022 17:09:13 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v11 14/40] virtio_ring: split: introduce
 virtqueue_resize_split()
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-15-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220629065656.54420-15-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzYvMjkgMTQ6NTYsIFh1YW4gWmh1byDlhpnpgZM6Cj4gdmlydGlvIHJpbmcgc3Bs
aXQgc3VwcG9ydHMgcmVzaXplLgo+Cj4gT25seSBhZnRlciB0aGUgbmV3IHZyaW5nIGlzIHN1Y2Nl
c3NmdWxseSBhbGxvY2F0ZWQgYmFzZWQgb24gdGhlIG5ldyBudW0sCj4gd2Ugd2lsbCByZWxlYXNl
IHRoZSBvbGQgdnJpbmcuIEluIGFueSBjYXNlLCBhbiBlcnJvciBpcyByZXR1cm5lZCwKPiBpbmRp
Y2F0aW5nIHRoYXQgdGhlIHZyaW5nIHN0aWxsIHBvaW50cyB0byB0aGUgb2xkIHZyaW5nLgo+Cj4g
SW4gdGhlIGNhc2Ugb2YgYW4gZXJyb3IsIHJlLWluaXRpYWxpemUodmlydHF1ZXVlX3JlaW5pdF9z
cGxpdCgpKSB0aGUKPiB2aXJ0cXVldWUgdG8gZW5zdXJlIHRoYXQgdGhlIHZyaW5nIGNhbiBiZSB1
c2VkLgo+Cj4gSW4gYWRkaXRpb24sIHZyaW5nX2FsaWduLCBtYXlfcmVkdWNlX251bSBhcmUgbmVj
ZXNzYXJ5IGZvciByZWFsbG9jYXRpbmcKPiB2cmluZywgc28gdGhleSBhcmUgcmV0YWluZWQgZm9y
IGNyZWF0aW5nIHZxLgo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51
eC5hbGliYWJhLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCAz
MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDMy
IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmlu
Zy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IGluZGV4IDljODNjNWU2ZDVhOS4u
MWFhYTFlNWY5OTkxIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMK
PiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gQEAgLTIxMiw2ICsyMTIsNyBA
QCBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlIHsKPiAgIH07Cj4gICAKPiAgIHN0YXRpYyBzdHJ1Y3Qg
dnJpbmdfZGVzY19leHRyYSAqdnJpbmdfYWxsb2NfZGVzY19leHRyYSh1bnNpZ25lZCBpbnQgbnVt
KTsKPiArc3RhdGljIHZvaWQgdnJpbmdfZnJlZShzdHJ1Y3QgdmlydHF1ZXVlICpfdnEpOwo+ICAg
Cj4gICAvKgo+ICAgICogSGVscGVycy4KPiBAQCAtMTExNCw2ICsxMTE1LDM3IEBAIHN0YXRpYyBz
dHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVlX3NwbGl0KAo+ICAgCXJldHVy
biB2cTsKPiAgIH0KPiAgIAo+ICtzdGF0aWMgaW50IHZpcnRxdWV1ZV9yZXNpemVfc3BsaXQoc3Ry
dWN0IHZpcnRxdWV1ZSAqX3ZxLCB1MzIgbnVtKQo+ICt7Cj4gKwlzdHJ1Y3QgdnJpbmdfdmlydHF1
ZXVlICp2cSA9IHRvX3Z2cShfdnEpOwo+ICsJc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZV9zcGxpdCB2
cmluZyA9IHt9Owo+ICsJc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYgPSBfdnEtPnZkZXY7Cj4g
KwlpbnQgZXJyOwo+ICsKPiArCWVyciA9IHZyaW5nX2FsbG9jX3F1ZXVlX3NwbGl0KCZ2cmluZywg
dmRldiwgbnVtLCB2cS0+c3BsaXQudnJpbmdfYWxpZ24sCj4gKwkJCQkgICAgICB2cS0+c3BsaXQu
bWF5X3JlZHVjZV9udW0pOwo+ICsJaWYgKGVycikKPiArCQlnb3RvIGVycjsKCgpJdCdzIGJldHRl
ciB0byBoYXZlIGRlY291cGxlIHRoZSBhbGxvY2F0aW9uIGZ1dHVyZSBtb3JlIHRvIGF2b2lkIGFu
eSAKcmV3aW5kIGhlcmUgaW4gdGhlIGZ1dHVyZS4KCkJ1dCB0aGUgcGF0Y2ggc2hvdWxkIGJlIGZp
bmUuCgpTbwoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKPiAr
Cj4gKwllcnIgPSB2cmluZ19hbGxvY19zdGF0ZV9leHRyYV9zcGxpdCgmdnJpbmcpOwo+ICsJaWYg
KGVycikgewo+ICsJCXZyaW5nX2ZyZWVfc3BsaXQoJnZyaW5nLCB2ZGV2KTsKPiArCQlnb3RvIGVy
cjsKPiArCX0KPiArCj4gKwl2cmluZ19mcmVlKCZ2cS0+dnEpOwo+ICsKPiArCXZpcnRxdWV1ZV9p
bml0KHZxLCB2cmluZy52cmluZy5udW0pOwo+ICsJdmlydHF1ZXVlX3ZyaW5nX2F0dGFjaF9zcGxp
dCh2cSwgJnZyaW5nKTsKPiArCXZpcnRxdWV1ZV92cmluZ19pbml0X3NwbGl0KHZxKTsKPiArCj4g
KwlyZXR1cm4gMDsKPiArCj4gK2VycjoKPiArCXZpcnRxdWV1ZV9yZWluaXRfc3BsaXQodnEpOwo+
ICsJcmV0dXJuIC1FTk9NRU07Cj4gK30KPiArCj4gICAKPiAgIC8qCj4gICAgKiBQYWNrZWQgcmlu
ZyBzcGVjaWZpYyBmdW5jdGlvbnMgLSAqX3BhY2tlZCgpLgoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11
bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtdW0K


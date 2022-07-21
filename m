Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oESVz-003Ku6-65
	for linux-um@lists.infradead.org; Thu, 21 Jul 2022 09:30:41 +0000
Received: by mail-pf1-f198.google.com with SMTP id s22-20020a056a001c5600b0052ad646de49so623773pfw.7
        for <linux-um@lists.infradead.org>; Thu, 21 Jul 2022 02:30:31 -0700 (PDT)
Message-ID: <cbc59d60-f3b3-465d-185b-5b83f893be63@redhat.com>
Date: Thu, 21 Jul 2022 17:30:18 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v12 39/40] virtio_net: support tx queue resize
References: <20220720030436.79520-1-xuanzhuo@linux.alibaba.com>
 <20220720030436.79520-40-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220720030436.79520-40-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzcvMjAgMTE6MDQsIFh1YW4gWmh1byDlhpnpgZM6Cj4gVGhpcyBwYXRjaCBpbXBs
ZW1lbnRzIHRoZSByZXNpemUgZnVuY3Rpb24gb2YgdGhlIHR4IHF1ZXVlcy4KPiBCYXNlZCBvbiB0
aGlzIGZ1bmN0aW9uLCBpdCBpcyBwb3NzaWJsZSB0byBtb2RpZnkgdGhlIHJpbmcgbnVtIG9mIHRo
ZQo+IHF1ZXVlLgo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5h
bGliYWJhLmNvbT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4K
Cgo+IC0tLQo+ICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgNDcgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDQ3IGluc2VydGlv
bnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJz
L25ldC92aXJ0aW9fbmV0LmMKPiBpbmRleCAxMTE1YThiNTlhMDguLmQxZTY5NDBiNDZkOCAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiArKysgYi9kcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMKPiBAQCAtMTM1LDYgKzEzNSw5IEBAIHN0cnVjdCBzZW5kX3F1ZXVlIHsKPiAg
IAlzdHJ1Y3QgdmlydG5ldF9zcV9zdGF0cyBzdGF0czsKPiAgIAo+ICAgCXN0cnVjdCBuYXBpX3N0
cnVjdCBuYXBpOwo+ICsKPiArCS8qIFJlY29yZCB3aGV0aGVyIHNxIGlzIGluIHJlc2V0IHN0YXRl
LiAqLwo+ICsJYm9vbCByZXNldDsKPiAgIH07Cj4gICAKPiAgIC8qIEludGVybmFsIHJlcHJlc2Vu
dGF0aW9uIG9mIGEgcmVjZWl2ZSB2aXJ0cXVldWUgKi8KPiBAQCAtMjc5LDYgKzI4Miw3IEBAIHN0
cnVjdCBwYWRkZWRfdm5ldF9oZHIgewo+ICAgfTsKPiAgIAo+ICAgc3RhdGljIHZvaWQgdmlydG5l
dF9ycV9mcmVlX3VudXNlZF9idWYoc3RydWN0IHZpcnRxdWV1ZSAqdnEsIHZvaWQgKmJ1Zik7Cj4g
K3N0YXRpYyB2b2lkIHZpcnRuZXRfc3FfZnJlZV91bnVzZWRfYnVmKHN0cnVjdCB2aXJ0cXVldWUg
KnZxLCB2b2lkICpidWYpOwo+ICAgCj4gICBzdGF0aWMgYm9vbCBpc194ZHBfZnJhbWUodm9pZCAq
cHRyKQo+ICAgewo+IEBAIC0xNjAzLDYgKzE2MDcsMTEgQEAgc3RhdGljIHZvaWQgdmlydG5ldF9w
b2xsX2NsZWFudHgoc3RydWN0IHJlY2VpdmVfcXVldWUgKnJxKQo+ICAgCQlyZXR1cm47Cj4gICAK
PiAgIAlpZiAoX19uZXRpZl90eF90cnlsb2NrKHR4cSkpIHsKPiArCQlpZiAoc3EtPnJlc2V0KSB7
Cj4gKwkJCV9fbmV0aWZfdHhfdW5sb2NrKHR4cSk7Cj4gKwkJCXJldHVybjsKPiArCQl9Cj4gKwo+
ICAgCQlkbyB7Cj4gICAJCQl2aXJ0cXVldWVfZGlzYWJsZV9jYihzcS0+dnEpOwo+ICAgCQkJZnJl
ZV9vbGRfeG1pdF9za2JzKHNxLCB0cnVlKTsKPiBAQCAtMTg2OCw2ICsxODc3LDQ0IEBAIHN0YXRp
YyBpbnQgdmlydG5ldF9yeF9yZXNpemUoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksCj4gICAJcmV0
dXJuIGVycjsKPiAgIH0KPiAgIAo+ICtzdGF0aWMgaW50IHZpcnRuZXRfdHhfcmVzaXplKHN0cnVj
dCB2aXJ0bmV0X2luZm8gKnZpLAo+ICsJCQkgICAgIHN0cnVjdCBzZW5kX3F1ZXVlICpzcSwgdTMy
IHJpbmdfbnVtKQo+ICt7Cj4gKwlzdHJ1Y3QgbmV0ZGV2X3F1ZXVlICp0eHE7Cj4gKwlpbnQgZXJy
LCBxaW5kZXg7Cj4gKwo+ICsJcWluZGV4ID0gc3EgLSB2aS0+c3E7Cj4gKwo+ICsJdmlydG5ldF9u
YXBpX3R4X2Rpc2FibGUoJnNxLT5uYXBpKTsKPiArCj4gKwl0eHEgPSBuZXRkZXZfZ2V0X3R4X3F1
ZXVlKHZpLT5kZXYsIHFpbmRleCk7Cj4gKwo+ICsJLyogMS4gd2FpdCBhbGwgeGltdCBjb21wbGV0
ZQo+ICsJICogMi4gZml4IHRoZSByYWNlIG9mIG5ldGlmX3N0b3Bfc3VicXVldWUoKSB2cyBuZXRp
Zl9zdGFydF9zdWJxdWV1ZSgpCj4gKwkgKi8KPiArCV9fbmV0aWZfdHhfbG9ja19iaCh0eHEpOwo+
ICsKPiArCS8qIFByZXZlbnQgcnggcG9sbCBmcm9tIGFjY2Vzc2luZyBzcS4gKi8KPiArCXNxLT5y
ZXNldCA9IHRydWU7Cj4gKwo+ICsJLyogUHJldmVudCB0aGUgdXBwZXIgbGF5ZXIgZnJvbSB0cnlp
bmcgdG8gc2VuZCBwYWNrZXRzLiAqLwo+ICsJbmV0aWZfc3RvcF9zdWJxdWV1ZSh2aS0+ZGV2LCBx
aW5kZXgpOwo+ICsKPiArCV9fbmV0aWZfdHhfdW5sb2NrX2JoKHR4cSk7Cj4gKwo+ICsJZXJyID0g
dmlydHF1ZXVlX3Jlc2l6ZShzcS0+dnEsIHJpbmdfbnVtLCB2aXJ0bmV0X3NxX2ZyZWVfdW51c2Vk
X2J1Zik7Cj4gKwlpZiAoZXJyKQo+ICsJCW5ldGRldl9lcnIodmktPmRldiwgInJlc2l6ZSB0eCBm
YWlsOiB0eCBxdWV1ZSBpbmRleDogJWQgZXJyOiAlZFxuIiwgcWluZGV4LCBlcnIpOwo+ICsKPiAr
CV9fbmV0aWZfdHhfbG9ja19iaCh0eHEpOwo+ICsJc3EtPnJlc2V0ID0gZmFsc2U7Cj4gKwluZXRp
Zl90eF93YWtlX3F1ZXVlKHR4cSk7Cj4gKwlfX25ldGlmX3R4X3VubG9ja19iaCh0eHEpOwo+ICsK
PiArCXZpcnRuZXRfbmFwaV90eF9lbmFibGUodmksIHNxLT52cSwgJnNxLT5uYXBpKTsKPiArCXJl
dHVybiBlcnI7Cj4gK30KPiArCj4gICAvKgo+ICAgICogU2VuZCBjb21tYW5kIHZpYSB0aGUgY29u
dHJvbCB2aXJ0cXVldWUgYW5kIGNoZWNrIHN0YXR1cy4gIENvbW1hbmRzCj4gICAgKiBzdXBwb3J0
ZWQgYnkgdGhlIGh5cGVydmlzb3IsIGFzIGluZGljYXRlZCBieSBmZWF0dXJlIGJpdHMsIHNob3Vs
ZAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4
LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K


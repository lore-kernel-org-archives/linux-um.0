Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8D2H-004EYT-CE
	for linux-um@lists.infradead.org; Mon, 04 Jul 2022 03:46:10 +0000
Received: by mail-pl1-f197.google.com with SMTP id i5-20020a170902c94500b0016a644a6008so4399775pla.1
        for <linux-um@lists.infradead.org>; Sun, 03 Jul 2022 20:46:07 -0700 (PDT)
Message-ID: <102d3b83-1ae9-a59a-16ce-251c22b7afb0@redhat.com>
Date: Mon, 4 Jul 2022 11:45:52 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v11 39/40] virtio_net: support tx queue resize
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-40-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220629065656.54420-40-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzYvMjkgMTQ6NTYsIFh1YW4gWmh1byDlhpnpgZM6Cj4gVGhpcyBwYXRjaCBpbXBs
ZW1lbnRzIHRoZSByZXNpemUgZnVuY3Rpb24gb2YgdGhlIHR4IHF1ZXVlcy4KPiBCYXNlZCBvbiB0
aGlzIGZ1bmN0aW9uLCBpdCBpcyBwb3NzaWJsZSB0byBtb2RpZnkgdGhlIHJpbmcgbnVtIG9mIHRo
ZQo+IHF1ZXVlLgo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5h
bGliYWJhLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDQ4ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCA0
OCBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5j
IGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gaW5kZXggNmFiMTZmZDE5M2U1Li5mZDM1ODQ2
MmY4MDIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gKysrIGIvZHJp
dmVycy9uZXQvdmlydGlvX25ldC5jCj4gQEAgLTEzNSw2ICsxMzUsOSBAQCBzdHJ1Y3Qgc2VuZF9x
dWV1ZSB7Cj4gICAJc3RydWN0IHZpcnRuZXRfc3Ffc3RhdHMgc3RhdHM7Cj4gICAKPiAgIAlzdHJ1
Y3QgbmFwaV9zdHJ1Y3QgbmFwaTsKPiArCj4gKwkvKiBSZWNvcmQgd2hldGhlciBzcSBpcyBpbiBy
ZXNldCBzdGF0ZS4gKi8KPiArCWJvb2wgcmVzZXQ7Cj4gICB9Owo+ICAgCj4gICAvKiBJbnRlcm5h
bCByZXByZXNlbnRhdGlvbiBvZiBhIHJlY2VpdmUgdmlydHF1ZXVlICovCj4gQEAgLTI3OSw2ICsy
ODIsNyBAQCBzdHJ1Y3QgcGFkZGVkX3ZuZXRfaGRyIHsKPiAgIH07Cj4gICAKPiAgIHN0YXRpYyB2
b2lkIHZpcnRuZXRfcnFfZnJlZV91bnVzZWRfYnVmKHN0cnVjdCB2aXJ0cXVldWUgKnZxLCB2b2lk
ICpidWYpOwo+ICtzdGF0aWMgdm9pZCB2aXJ0bmV0X3NxX2ZyZWVfdW51c2VkX2J1ZihzdHJ1Y3Qg
dmlydHF1ZXVlICp2cSwgdm9pZCAqYnVmKTsKPiAgIAo+ICAgc3RhdGljIGJvb2wgaXNfeGRwX2Zy
YW1lKHZvaWQgKnB0cikKPiAgIHsKPiBAQCAtMTYwMyw2ICsxNjA3LDExIEBAIHN0YXRpYyB2b2lk
IHZpcnRuZXRfcG9sbF9jbGVhbnR4KHN0cnVjdCByZWNlaXZlX3F1ZXVlICpycSkKPiAgIAkJcmV0
dXJuOwo+ICAgCj4gICAJaWYgKF9fbmV0aWZfdHhfdHJ5bG9jayh0eHEpKSB7Cj4gKwkJaWYgKFJF
QURfT05DRShzcS0+cmVzZXQpKSB7Cj4gKwkJCV9fbmV0aWZfdHhfdW5sb2NrKHR4cSk7Cj4gKwkJ
CXJldHVybjsKPiArCQl9Cj4gKwo+ICAgCQlkbyB7Cj4gICAJCQl2aXJ0cXVldWVfZGlzYWJsZV9j
YihzcS0+dnEpOwo+ICAgCQkJZnJlZV9vbGRfeG1pdF9za2JzKHNxLCB0cnVlKTsKPiBAQCAtMTg2
OCw2ICsxODc3LDQ1IEBAIHN0YXRpYyBpbnQgdmlydG5ldF9yeF9yZXNpemUoc3RydWN0IHZpcnRu
ZXRfaW5mbyAqdmksCj4gICAJcmV0dXJuIGVycjsKPiAgIH0KPiAgIAo+ICtzdGF0aWMgaW50IHZp
cnRuZXRfdHhfcmVzaXplKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+ICsJCQkgICAgIHN0cnVj
dCBzZW5kX3F1ZXVlICpzcSwgdTMyIHJpbmdfbnVtKQo+ICt7Cj4gKwlzdHJ1Y3QgbmV0ZGV2X3F1
ZXVlICp0eHE7Cj4gKwlpbnQgZXJyLCBxaW5kZXg7Cj4gKwo+ICsJcWluZGV4ID0gc3EgLSB2aS0+
c3E7Cj4gKwo+ICsJdmlydG5ldF9uYXBpX3R4X2Rpc2FibGUoJnNxLT5uYXBpKTsKPiArCj4gKwl0
eHEgPSBuZXRkZXZfZ2V0X3R4X3F1ZXVlKHZpLT5kZXYsIHFpbmRleCk7Cj4gKwo+ICsJLyogMS4g
d2FpdCBhbGwgeGltdCBjb21wbGV0ZQo+ICsJICogMi4gZml4IHRoZSByYWNlIG9mIG5ldGlmX3N0
b3Bfc3VicXVldWUoKSB2cyBuZXRpZl9zdGFydF9zdWJxdWV1ZSgpCj4gKwkgKi8KPiArCV9fbmV0
aWZfdHhfbG9ja19iaCh0eHEpOwo+ICsKPiArCS8qIFByZXZlbnQgcnggcG9sbCBmcm9tIGFjY2Vz
c2luZyBzcS4gKi8KPiArCVdSSVRFX09OQ0Uoc3EtPnJlc2V0LCB0cnVlKTsKCgpDYW4gd2Ugc2lt
cGx5IGRpc2FibGUgUlggTkFQSSBoZXJlPwoKVGhhbmtzCgoKPiArCj4gKwkvKiBQcmV2ZW50IHRo
ZSB1cHBlciBsYXllciBmcm9tIHRyeWluZyB0byBzZW5kIHBhY2tldHMuICovCj4gKwluZXRpZl9z
dG9wX3N1YnF1ZXVlKHZpLT5kZXYsIHFpbmRleCk7Cj4gKwo+ICsJX19uZXRpZl90eF91bmxvY2tf
YmgodHhxKTsKPiArCj4gKwllcnIgPSB2aXJ0cXVldWVfcmVzaXplKHNxLT52cSwgcmluZ19udW0s
IHZpcnRuZXRfc3FfZnJlZV91bnVzZWRfYnVmKTsKPiArCWlmIChlcnIpCj4gKwkJbmV0ZGV2X2Vy
cih2aS0+ZGV2LCAicmVzaXplIHR4IGZhaWw6IHR4IHF1ZXVlIGluZGV4OiAlZCBlcnI6ICVkXG4i
LCBxaW5kZXgsIGVycik7Cj4gKwo+ICsJLyogTWVtb3J5IGJhcnJpZXIgYmVmb3JlIHNldCByZXNl
dCBhbmQgc3RhcnQgc3VicXVldWUuICovCj4gKwlzbXBfbWIoKTsKPiArCj4gKwlXUklURV9PTkNF
KHNxLT5yZXNldCwgZmFsc2UpOwo+ICsJbmV0aWZfdHhfd2FrZV9xdWV1ZSh0eHEpOwo+ICsKPiAr
CXZpcnRuZXRfbmFwaV90eF9lbmFibGUodmksIHNxLT52cSwgJnNxLT5uYXBpKTsKPiArCXJldHVy
biBlcnI7Cj4gK30KPiArCj4gICAvKgo+ICAgICogU2VuZCBjb21tYW5kIHZpYSB0aGUgY29udHJv
bCB2aXJ0cXVldWUgYW5kIGNoZWNrIHN0YXR1cy4gIENvbW1hbmRzCj4gICAgKiBzdXBwb3J0ZWQg
YnkgdGhlIGh5cGVydmlzb3IsIGFzIGluZGljYXRlZCBieSBmZWF0dXJlIGJpdHMsIHNob3VsZAoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVt
IG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K


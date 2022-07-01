Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o7CwV-003rTT-MB
	for linux-um@lists.infradead.org; Fri, 01 Jul 2022 09:28:06 +0000
Received: by mail-pg1-f198.google.com with SMTP id f9-20020a636a09000000b00401b6bc63beso1042753pgc.23
        for <linux-um@lists.infradead.org>; Fri, 01 Jul 2022 02:28:01 -0700 (PDT)
Message-ID: <de7cf56d-acbd-1a2b-2226-a9fdd89afb78@redhat.com>
Date: Fri, 1 Jul 2022 17:27:48 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v11 21/40] virtio_ring: packed: introduce
 virtqueue_resize_packed()
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-22-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220629065656.54420-22-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzYvMjkgMTQ6NTYsIFh1YW4gWmh1byDlhpnpgZM6Cj4gdmlydGlvIHJpbmcgcGFj
a2VkIHN1cHBvcnRzIHJlc2l6ZS4KPgo+IE9ubHkgYWZ0ZXIgdGhlIG5ldyB2cmluZyBpcyBzdWNj
ZXNzZnVsbHkgYWxsb2NhdGVkIGJhc2VkIG9uIHRoZSBuZXcgbnVtLAo+IHdlIHdpbGwgcmVsZWFz
ZSB0aGUgb2xkIHZyaW5nLiBJbiBhbnkgY2FzZSwgYW4gZXJyb3IgaXMgcmV0dXJuZWQsCj4gaW5k
aWNhdGluZyB0aGF0IHRoZSB2cmluZyBzdGlsbCBwb2ludHMgdG8gdGhlIG9sZCB2cmluZy4KPgo+
IEluIHRoZSBjYXNlIG9mIGFuIGVycm9yLCByZS1pbml0aWFsaXplKGJ5IHZpcnRxdWV1ZV9yZWlu
aXRfcGFja2VkKCkpIHRoZQo+IHZpcnRxdWV1ZSB0byBlbnN1cmUgdGhhdCB0aGUgdnJpbmcgY2Fu
IGJlIHVzZWQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFs
aWJhYmEuY29tPgo+IC0tLQo+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDI5ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gICAxIGZpbGUgY2hhbmdlZCwgMjkgaW5zZXJ0
aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gaW5kZXggNjUwZjcwMWE1NDgwLi40ODYwNzg3
Mjg2ZGIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ICsrKyBi
L2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBAQCAtMjA0Miw2ICsyMDQyLDM1IEBAIHN0
YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVlX3BhY2tlZCgKPiAg
IAlyZXR1cm4gTlVMTDsKPiAgIH0KPiAgIAo+ICtzdGF0aWMgaW50IHZpcnRxdWV1ZV9yZXNpemVf
cGFja2VkKHN0cnVjdCB2aXJ0cXVldWUgKl92cSwgdTMyIG51bSkKPiArewo+ICsJc3RydWN0IHZy
aW5nX3ZpcnRxdWV1ZV9wYWNrZWQgdnJpbmcgPSB7fTsKPiArCXN0cnVjdCB2cmluZ192aXJ0cXVl
dWUgKnZxID0gdG9fdnZxKF92cSk7Cj4gKwlzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiA9IF92
cS0+dmRldjsKPiArCWludCBlcnI7Cj4gKwo+ICsJaWYgKHZyaW5nX2FsbG9jX3F1ZXVlX3BhY2tl
ZCgmdnJpbmcsIHZkZXYsIG51bSkpCj4gKwkJZ290byBlcnJfcmluZzsKPiArCj4gKwllcnIgPSB2
cmluZ19hbGxvY19zdGF0ZV9leHRyYV9wYWNrZWQoJnZyaW5nKTsKPiArCWlmIChlcnIpCj4gKwkJ
Z290byBlcnJfc3RhdGVfZXh0cmE7Cj4gKwo+ICsJdnJpbmdfZnJlZSgmdnEtPnZxKTsKPiArCj4g
Kwl2aXJ0cXVldWVfaW5pdCh2cSwgdnJpbmcudnJpbmcubnVtKTsKPiArCXZpcnRxdWV1ZV92cmlu
Z19hdHRhY2hfcGFja2VkKHZxLCAmdnJpbmcpOwo+ICsJdmlydHF1ZXVlX3ZyaW5nX2luaXRfcGFj
a2VkKHZxKTsKPiArCj4gKwlyZXR1cm4gMDsKPiArCj4gK2Vycl9zdGF0ZV9leHRyYToKPiArCXZy
aW5nX2ZyZWVfcGFja2VkKCZ2cmluZywgdmRldik7Cj4gK2Vycl9yaW5nOgo+ICsJdmlydHF1ZXVl
X3JlaW5pdF9wYWNrZWQodnEpOwoKClNvIGRlc2Nfc3RhdGUgYW5kIGRlc2NfZXh0cmEgaGFzIGJl
ZW4gZnJlZWQgdnJpbmdfZnJlZV9wYWNrZWQoKSB3aGVuIAp2cmluZ19hbGxvY19zdGF0ZV9leHRy
YV9wYWNrZWQoKSBmYWlscy4gV2UgbWlnaHQgZ2V0IHVzZS1hZnRlci1mcmVlIGhlcmU/CgpBY3R1
YWxseSwgSSB0aGluayBmb3IgcmVzaXplIHdlIG5lZWQKCjEpIGRldGFjaCBvbGQKMikgYWxsb2Nh
dGUgbmV3CjMpIGlmIDIpIHN1Y2NlZWQsIGF0dGFjaCBuZXcgb3RoZXJ3aXNlIGF0dGFjaCBvbGQK
ClRoaXMgc2VlbXMgbW9yZSBjbGVhcmVyIHRoYW4gdGhlIGN1cnJlbnQgbG9naWM/CgpUaGFua3MK
Cgo+ICsJcmV0dXJuIC1FTk9NRU07Cj4gK30KPiArCj4gICAKPiAgIC8qCj4gICAgKiBHZW5lcmlj
IGZ1bmN0aW9ucyBhbmQgZXhwb3J0ZWQgc3ltYm9scy4KCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1A
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LXVtCg==


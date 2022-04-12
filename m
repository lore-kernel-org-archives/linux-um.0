Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ne9Pd-00BnWW-OF
 for linux-um@lists.infradead.org; Tue, 12 Apr 2022 05:50:03 +0000
Received: by mail-pj1-f72.google.com with SMTP id
 l2-20020a17090ad10200b001ca56de815aso881443pju.0
 for <linux-um@lists.infradead.org>; Mon, 11 Apr 2022 22:49:56 -0700 (PDT)
Message-ID: <14ab2942-2141-cb1b-14be-35da1c9ee03d@redhat.com>
Date: Tue, 12 Apr 2022 13:49:40 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v9 10/32] virtio_ring: split: introduce
 virtqueue_reinit_split()
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-11-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-11-xuanzhuo@linux.alibaba.com>
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
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, "Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>, Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Johannes Berg <johannes.berg@intel.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, linux-um@lists.infradead.org, netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org

CuWcqCAyMDIyLzQvNiDkuIrljYgxMTo0MywgWHVhbiBaaHVvIOWGmemBkzoKPiBJbnRyb2R1Y2Ug
YSBmdW5jdGlvbiB0byBpbml0aWFsaXplIHZxIHdpdGhvdXQgYWxsb2NhdGluZyBuZXcgcmluZywK
PiBkZXNjX3N0YXRlLCBkZXNjX2V4dHJhLgo+Cj4gU3Vic2VxdWVudCBwYXRjaGVzIHdpbGwgY2Fs
bCB0aGlzIGZ1bmN0aW9uIGFmdGVyIHJlc2V0IHZxIHRvCj4gcmVpbml0aWFsaXplIHZxLgo+Cj4g
U2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KCgpB
Y2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+ICAgZHJp
dmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDE5ICsrKysrKysrKysrKysrKysrKysKPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92
aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBpbmRl
eCA4NzRmODc4MDg3YTMuLjNkYzZhY2UyYmE3YSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcmluZy5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IEBA
IC05NTMsNiArOTUzLDI1IEBAIHN0YXRpYyB2b2lkIHZyaW5nX3ZpcnRxdWV1ZV9pbml0X3NwbGl0
KHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxLAo+ICAgCXZxLT5mcmVlX2hlYWQgPSAwOwo+ICAg
fQo+ICAgCj4gK3N0YXRpYyB2b2lkIHZpcnRxdWV1ZV9yZWluaXRfc3BsaXQoc3RydWN0IHZyaW5n
X3ZpcnRxdWV1ZSAqdnEpCj4gK3sKPiArCXN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2ID0gdnEt
PnZxLnZkZXY7Cj4gKwlpbnQgc2l6ZSwgaTsKPiArCj4gKwltZW1zZXQodnEtPnNwbGl0LnZyaW5n
LmRlc2MsIDAsIHZxLT5zcGxpdC5xdWV1ZV9zaXplX2luX2J5dGVzKTsKPiArCj4gKwlzaXplID0g
c2l6ZW9mKHN0cnVjdCB2cmluZ19kZXNjX3N0YXRlX3NwbGl0KSAqIHZxLT5zcGxpdC52cmluZy5u
dW07Cj4gKwltZW1zZXQodnEtPnNwbGl0LmRlc2Nfc3RhdGUsIDAsIHNpemUpOwo+ICsKPiArCXNp
emUgPSBzaXplb2Yoc3RydWN0IHZyaW5nX2Rlc2NfZXh0cmEpICogdnEtPnNwbGl0LnZyaW5nLm51
bTsKPiArCW1lbXNldCh2cS0+c3BsaXQuZGVzY19leHRyYSwgMCwgc2l6ZSk7Cj4gKwo+ICsJZm9y
IChpID0gMDsgaSA8IHZxLT5zcGxpdC52cmluZy5udW0gLSAxOyBpKyspCj4gKwkJdnEtPnNwbGl0
LmRlc2NfZXh0cmFbaV0ubmV4dCA9IGkgKyAxOwo+ICsKPiArCXZyaW5nX3ZpcnRxdWV1ZV9pbml0
X3NwbGl0KHZxLCB2ZGV2LCB0cnVlKTsKPiArfQo+ICsKPiAgIHN0YXRpYyB2b2lkIHZyaW5nX3Zp
cnRxdWV1ZV9hdHRhY2hfc3BsaXQoc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEsCj4gICAJCQkJ
CSBzdHJ1Y3QgdnJpbmcgdnJpbmcsCj4gICAJCQkJCSBzdHJ1Y3QgdnJpbmdfZGVzY19zdGF0ZV9z
cGxpdCAqZGVzY19zdGF0ZSwKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVt
Cg==


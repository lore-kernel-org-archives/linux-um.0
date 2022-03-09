Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRsda-007urc-OL
 for linux-um@lists.infradead.org; Wed, 09 Mar 2022 09:29:44 +0000
Received: by mail-pj1-f72.google.com with SMTP id
 g19-20020a17090a579300b001b9d80f3714so1231720pji.7
 for <linux-um@lists.infradead.org>; Wed, 09 Mar 2022 01:29:40 -0800 (PST)
Message-ID: <bd27898f-59bc-215b-bb84-14582b12cb16@redhat.com>
Date: Wed, 9 Mar 2022 17:29:28 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v7 26/26] virtio_net: support set_ringparam
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-27-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220308123518.33800-27-xuanzhuo@linux.alibaba.com>
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
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, "Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>, Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Johannes Berg <johannes.berg@intel.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, linux-um@lists.infradead.org, platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org

CuWcqCAyMDIyLzMvOCDkuIvljYg4OjM1LCBYdWFuIFpodW8g5YaZ6YGTOgo+IFN1cHBvcnQgc2V0
X3JpbmdwYXJhbSBiYXNlZCBvbiB2aXJ0aW8gcXVldWUgcmVzZXQuCj4KPiBUaGUgcngsdHhfcGVu
ZGluZyByZXF1aXJlZCB0byBiZSBwYXNzZWQgbXVzdCBiZSBwb3dlciBvZiAyLgo+Cj4gU2lnbmVk
LW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiAtLS0KPiAg
IGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDQ3ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCA0NyBpbnNlcnRpb25zKCspCj4KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlv
X25ldC5jCj4gaW5kZXggZjFiZGM2Y2UyMWMzLi4xZmEyZDYzMmE5OTQgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5j
Cj4gQEAgLTIyOTAsNiArMjI5MCw1MiBAQCBzdGF0aWMgdm9pZCB2aXJ0bmV0X2dldF9yaW5ncGFy
YW0oc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPiAgIAlyaW5nLT50eF9wZW5kaW5nID0gdmlydHF1
ZXVlX2dldF92cmluZ19zaXplKHZpLT5zcVswXS52cSk7Cj4gICB9Cj4gICAKPiArc3RhdGljIGlu
dCB2aXJ0bmV0X3NldF9yaW5ncGFyYW0oc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPiArCQkJCSBz
dHJ1Y3QgZXRodG9vbF9yaW5ncGFyYW0gKnJpbmcsCj4gKwkJCQkgc3RydWN0IGtlcm5lbF9ldGh0
b29sX3JpbmdwYXJhbSAqa2VybmVsX3JpbmcsCj4gKwkJCQkgc3RydWN0IG5ldGxpbmtfZXh0X2Fj
ayAqZXh0YWNrKQo+ICt7Cj4gKwlzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSA9IG5ldGRldl9wcml2
KGRldik7Cj4gKwl1MzIgcnhfcGVuZGluZywgdHhfcGVuZGluZzsKPiArCXN0cnVjdCByZWNlaXZl
X3F1ZXVlICpycTsKPiArCXN0cnVjdCBzZW5kX3F1ZXVlICpzcTsKPiArCWludCBpLCBlcnI7Cj4g
Kwo+ICsJaWYgKHJpbmctPnJ4X21pbmlfcGVuZGluZyB8fCByaW5nLT5yeF9qdW1ib19wZW5kaW5n
KQo+ICsJCXJldHVybiAtRUlOVkFMOwoKCkFueSBjaGFuY2UgdGhhdCB3ZSBtYXkgaGl0IHRoaXMg
RUlOVkFMPwoKVGhhbmtzCgoKPiArCj4gKwlyeF9wZW5kaW5nID0gdmlydHF1ZXVlX2dldF92cmlu
Z19zaXplKHZpLT5ycVswXS52cSk7Cj4gKwl0eF9wZW5kaW5nID0gdmlydHF1ZXVlX2dldF92cmlu
Z19zaXplKHZpLT5zcVswXS52cSk7Cj4gKwo+ICsJaWYgKHJpbmctPnJ4X3BlbmRpbmcgPT0gcnhf
cGVuZGluZyAmJgo+ICsJICAgIHJpbmctPnR4X3BlbmRpbmcgPT0gdHhfcGVuZGluZykKPiArCQly
ZXR1cm4gMDsKPiArCj4gKwlpZiAocmluZy0+cnhfcGVuZGluZyA+IHZpcnRxdWV1ZV9nZXRfdnJp
bmdfbWF4X3NpemUodmktPnJxWzBdLnZxKSkKPiArCQlyZXR1cm4gLUVJTlZBTDsKPiArCj4gKwlp
ZiAocmluZy0+dHhfcGVuZGluZyA+IHZpcnRxdWV1ZV9nZXRfdnJpbmdfbWF4X3NpemUodmktPnNx
WzBdLnZxKSkKPiArCQlyZXR1cm4gLUVJTlZBTDsKPiArCj4gKwlmb3IgKGkgPSAwOyBpIDwgdmkt
Pm1heF9xdWV1ZV9wYWlyczsgaSsrKSB7Cj4gKwkJcnEgPSB2aS0+cnEgKyBpOwo+ICsJCXNxID0g
dmktPnNxICsgaTsKPiArCj4gKwkJaWYgKHJpbmctPnR4X3BlbmRpbmcgIT0gdHhfcGVuZGluZykg
ewo+ICsJCQllcnIgPSB2aXJ0bmV0X3R4X3ZxX3Jlc2V0KHZpLCBzcSwgcmluZy0+dHhfcGVuZGlu
Zyk7Cj4gKwkJCWlmIChlcnIpCj4gKwkJCQlyZXR1cm4gZXJyOwo+ICsJCX0KPiArCj4gKwkJaWYg
KHJpbmctPnJ4X3BlbmRpbmcgIT0gcnhfcGVuZGluZykgewo+ICsJCQllcnIgPSB2aXJ0bmV0X3J4
X3ZxX3Jlc2V0KHZpLCBycSwgcmluZy0+cnhfcGVuZGluZyk7Cj4gKwkJCWlmIChlcnIpCj4gKwkJ
CQlyZXR1cm4gZXJyOwo+ICsJCX0KPiArCX0KPiArCj4gKwlyZXR1cm4gMDsKPiArfQo+ICAgCj4g
ICBzdGF0aWMgdm9pZCB2aXJ0bmV0X2dldF9kcnZpbmZvKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYs
Cj4gICAJCQkJc3RydWN0IGV0aHRvb2xfZHJ2aW5mbyAqaW5mbykKPiBAQCAtMjUyMyw2ICsyNTY5
LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBldGh0b29sX29wcyB2aXJ0bmV0X2V0aHRvb2xfb3Bz
ID0gewo+ICAgCS5nZXRfZHJ2aW5mbyA9IHZpcnRuZXRfZ2V0X2RydmluZm8sCj4gICAJLmdldF9s
aW5rID0gZXRodG9vbF9vcF9nZXRfbGluaywKPiAgIAkuZ2V0X3JpbmdwYXJhbSA9IHZpcnRuZXRf
Z2V0X3JpbmdwYXJhbSwKPiArCS5zZXRfcmluZ3BhcmFtID0gdmlydG5ldF9zZXRfcmluZ3BhcmFt
LAo+ICAgCS5nZXRfc3RyaW5ncyA9IHZpcnRuZXRfZ2V0X3N0cmluZ3MsCj4gICAJLmdldF9zc2V0
X2NvdW50ID0gdmlydG5ldF9nZXRfc3NldF9jb3VudCwKPiAgIAkuZ2V0X2V0aHRvb2xfc3RhdHMg
PSB2aXJ0bmV0X2dldF9ldGh0b29sX3N0YXRzLAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtdW0K


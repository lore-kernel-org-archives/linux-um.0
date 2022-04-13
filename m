Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1neY1f-00HXja-MQ
 for linux-um@lists.infradead.org; Wed, 13 Apr 2022 08:06:59 +0000
Received: by mail-pg1-f199.google.com with SMTP id
 199-20020a6307d0000000b0039d99823fafso725321pgh.8
 for <linux-um@lists.infradead.org>; Wed, 13 Apr 2022 01:06:50 -0700 (PDT)
Message-ID: <96d1fe97-2e8a-ae8a-a35f-bba2ce0f44b4@redhat.com>
Date: Wed, 13 Apr 2022 16:06:33 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v9 32/32] virtio_net: support set_ringparam
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-33-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-33-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzQvNiDkuIrljYgxMTo0MywgWHVhbiBaaHVvIOWGmemBkzoKPiBTdXBwb3J0IHNl
dF9yaW5ncGFyYW0gYmFzZWQgb24gdmlydGlvIHF1ZXVlIHJlc2V0Lgo+Cj4gVXNlcnMgY2FuIHVz
ZSBldGh0b29sIC1HIGV0aDAgPHJpbmdfbnVtPiB0byBtb2RpZnkgdGhlIHJpbmcgc2l6ZSBvZgo+
IHZpcnRpby1uZXQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPgoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29t
PgoKKE9uZSB0aGluZyB0aGF0IEkgc2VlIGlzIHRoYXQsIHdoZW4gcmVzaXplIGZhaWxzLCB0aGUg
cGFyYW0gcmVwb3J0ZWQgdmlhIApnZXRfcmluZ3BhcmFtIG1pZ2h0IGJlIHdyb25nLCB0aGlzIGlz
IGEgY29ybmVyIGNhc2UgYnV0IG1pZ2h0IHdvcnRoIHRvIApmaXggaW4gdGhlIGZ1dHVyZSkuCgoK
PiAtLS0KPiAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDQ3ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCA0NyBpbnNlcnRpb25z
KCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9u
ZXQvdmlydGlvX25ldC5jCj4gaW5kZXggYmE2ODU5ZjMwNWY3Li4zN2U0ZTI3ZjFlNGUgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gKysrIGIvZHJpdmVycy9uZXQvdmly
dGlvX25ldC5jCj4gQEAgLTIyNjQsNiArMjI2NCw1MiBAQCBzdGF0aWMgdm9pZCB2aXJ0bmV0X2dl
dF9yaW5ncGFyYW0oc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPiAgIAlyaW5nLT50eF9wZW5kaW5n
ID0gdmlydHF1ZXVlX2dldF92cmluZ19zaXplKHZpLT5zcVswXS52cSk7Cj4gICB9Cj4gICAKPiAr
c3RhdGljIGludCB2aXJ0bmV0X3NldF9yaW5ncGFyYW0oc3RydWN0IG5ldF9kZXZpY2UgKmRldiwK
PiArCQkJCSBzdHJ1Y3QgZXRodG9vbF9yaW5ncGFyYW0gKnJpbmcsCj4gKwkJCQkgc3RydWN0IGtl
cm5lbF9ldGh0b29sX3JpbmdwYXJhbSAqa2VybmVsX3JpbmcsCj4gKwkJCQkgc3RydWN0IG5ldGxp
bmtfZXh0X2FjayAqZXh0YWNrKQo+ICt7Cj4gKwlzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSA9IG5l
dGRldl9wcml2KGRldik7Cj4gKwl1MzIgcnhfcGVuZGluZywgdHhfcGVuZGluZzsKPiArCXN0cnVj
dCByZWNlaXZlX3F1ZXVlICpycTsKPiArCXN0cnVjdCBzZW5kX3F1ZXVlICpzcTsKPiArCWludCBp
LCBlcnI7Cj4gKwo+ICsJaWYgKHJpbmctPnJ4X21pbmlfcGVuZGluZyB8fCByaW5nLT5yeF9qdW1i
b19wZW5kaW5nKQo+ICsJCXJldHVybiAtRUlOVkFMOwo+ICsKPiArCXJ4X3BlbmRpbmcgPSB2aXJ0
cXVldWVfZ2V0X3ZyaW5nX3NpemUodmktPnJxWzBdLnZxKTsKPiArCXR4X3BlbmRpbmcgPSB2aXJ0
cXVldWVfZ2V0X3ZyaW5nX3NpemUodmktPnNxWzBdLnZxKTsKPiArCj4gKwlpZiAocmluZy0+cnhf
cGVuZGluZyA9PSByeF9wZW5kaW5nICYmCj4gKwkgICAgcmluZy0+dHhfcGVuZGluZyA9PSB0eF9w
ZW5kaW5nKQo+ICsJCXJldHVybiAwOwo+ICsKPiArCWlmIChyaW5nLT5yeF9wZW5kaW5nID4gdmly
dHF1ZXVlX2dldF92cmluZ19tYXhfc2l6ZSh2aS0+cnFbMF0udnEpKQo+ICsJCXJldHVybiAtRUlO
VkFMOwo+ICsKPiArCWlmIChyaW5nLT50eF9wZW5kaW5nID4gdmlydHF1ZXVlX2dldF92cmluZ19t
YXhfc2l6ZSh2aS0+c3FbMF0udnEpKQo+ICsJCXJldHVybiAtRUlOVkFMOwo+ICsKPiArCWZvciAo
aSA9IDA7IGkgPCB2aS0+bWF4X3F1ZXVlX3BhaXJzOyBpKyspIHsKPiArCQlycSA9IHZpLT5ycSAr
IGk7Cj4gKwkJc3EgPSB2aS0+c3EgKyBpOwo+ICsKPiArCQlpZiAocmluZy0+dHhfcGVuZGluZyAh
PSB0eF9wZW5kaW5nKSB7Cj4gKwkJCWVyciA9IHZpcnRuZXRfdHhfcmVzaXplKHZpLCBzcSwgcmlu
Zy0+dHhfcGVuZGluZyk7Cj4gKwkJCWlmIChlcnIpCj4gKwkJCQlyZXR1cm4gZXJyOwo+ICsJCX0K
PiArCj4gKwkJaWYgKHJpbmctPnJ4X3BlbmRpbmcgIT0gcnhfcGVuZGluZykgewo+ICsJCQllcnIg
PSB2aXJ0bmV0X3J4X3Jlc2l6ZSh2aSwgcnEsIHJpbmctPnJ4X3BlbmRpbmcpOwo+ICsJCQlpZiAo
ZXJyKQo+ICsJCQkJcmV0dXJuIGVycjsKPiArCQl9Cj4gKwl9Cj4gKwo+ICsJcmV0dXJuIDA7Cj4g
K30KPiAgIAo+ICAgc3RhdGljIHZvaWQgdmlydG5ldF9nZXRfZHJ2aW5mbyhzdHJ1Y3QgbmV0X2Rl
dmljZSAqZGV2LAo+ICAgCQkJCXN0cnVjdCBldGh0b29sX2RydmluZm8gKmluZm8pCj4gQEAgLTI0
OTcsNiArMjU0Myw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZXRodG9vbF9vcHMgdmlydG5ldF9l
dGh0b29sX29wcyA9IHsKPiAgIAkuZ2V0X2RydmluZm8gPSB2aXJ0bmV0X2dldF9kcnZpbmZvLAo+
ICAgCS5nZXRfbGluayA9IGV0aHRvb2xfb3BfZ2V0X2xpbmssCj4gICAJLmdldF9yaW5ncGFyYW0g
PSB2aXJ0bmV0X2dldF9yaW5ncGFyYW0sCj4gKwkuc2V0X3JpbmdwYXJhbSA9IHZpcnRuZXRfc2V0
X3JpbmdwYXJhbSwKPiAgIAkuZ2V0X3N0cmluZ3MgPSB2aXJ0bmV0X2dldF9zdHJpbmdzLAo+ICAg
CS5nZXRfc3NldF9jb3VudCA9IHZpcnRuZXRfZ2V0X3NzZXRfY291bnQsCj4gICAJLmdldF9ldGh0
b29sX3N0YXRzID0gdmlydG5ldF9nZXRfZXRodG9vbF9zdGF0cywKCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGlu
dXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==


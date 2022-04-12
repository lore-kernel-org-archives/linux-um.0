Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ne7FT-00BQeX-IR
 for linux-um@lists.infradead.org; Tue, 12 Apr 2022 03:31:24 +0000
Received: by mail-pf1-f199.google.com with SMTP id
 i184-20020a62c1c1000000b0050569a135c1so8138165pfg.3
 for <linux-um@lists.infradead.org>; Mon, 11 Apr 2022 20:31:20 -0700 (PDT)
Message-ID: <28237db0-cf04-aa36-b7b8-de55b11d18db@redhat.com>
Date: Tue, 12 Apr 2022 11:31:08 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v9 08/32] virtio_ring: split: extract the logic of attach
 vring
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-9-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-9-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzQvNiDkuIrljYgxMTo0MywgWHVhbiBaaHVvIOWGmemBkzoKPiBTZXBhcmF0ZSB0
aGUgbG9naWMgb2YgYXR0YWNoIHZyaW5nLCBzdWJzZXF1ZW50IHBhdGNoZXMgd2lsbCBjYWxsIGl0
Cj4gc2VwYXJhdGVseS4KPgo+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwg
MjAgKysrKysrKysrKysrKystLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25z
KCspLCA2IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRp
b19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gaW5kZXggNmRlNjc0Mzlj
YjU3Li4wODNmMjk5MmJhMGQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jp
bmcuYwo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBAQCAtOTE2LDYgKzkx
NiwxOSBAQCBzdGF0aWMgdm9pZCAqdmlydHF1ZXVlX2RldGFjaF91bnVzZWRfYnVmX3NwbGl0KHN0
cnVjdCB2aXJ0cXVldWUgKl92cSkKPiAgIAlyZXR1cm4gTlVMTDsKPiAgIH0KPiAgIAo+ICtzdGF0
aWMgdm9pZCB2cmluZ192aXJ0cXVldWVfYXR0YWNoX3NwbGl0KHN0cnVjdCB2cmluZ192aXJ0cXVl
dWUgKnZxLAo+ICsJCQkJCSBzdHJ1Y3QgdnJpbmcgdnJpbmcsCj4gKwkJCQkJIHN0cnVjdCB2cmlu
Z19kZXNjX3N0YXRlX3NwbGl0ICpkZXNjX3N0YXRlLAo+ICsJCQkJCSBzdHJ1Y3QgdnJpbmdfZGVz
Y19leHRyYSAqZGVzY19leHRyYSkKPiArewo+ICsJdnEtPnNwbGl0LnZyaW5nID0gdnJpbmc7Cj4g
Kwl2cS0+c3BsaXQucXVldWVfZG1hX2FkZHIgPSAwOwo+ICsJdnEtPnNwbGl0LnF1ZXVlX3NpemVf
aW5fYnl0ZXMgPSAwOwoKCkFueSByZWFzb24gdG8gYWRkIHRoZSBhYm92ZSB0d28gYXNzaWdubWVu
dCBpbiBhdHRhY2g/IEl0IHNlZW1zIGJlbG9uZyB0byAKZnJlZSBvciByZXNldC4KClRoYW5rcwoK
Cj4gKwo+ICsJdnEtPnNwbGl0LmRlc2Nfc3RhdGUgPSBkZXNjX3N0YXRlOwo+ICsJdnEtPnNwbGl0
LmRlc2NfZXh0cmEgPSBkZXNjX2V4dHJhOwo+ICt9Cj4gKwo+ICAgc3RhdGljIGludCB2cmluZ19h
bGxvY19zdGF0ZV9leHRyYV9zcGxpdCh1MzIgbnVtLAo+ICAgCQkJCQkgc3RydWN0IHZyaW5nX2Rl
c2Nfc3RhdGVfc3BsaXQgKipkZXNjX3N0YXRlLAo+ICAgCQkJCQkgc3RydWN0IHZyaW5nX2Rlc2Nf
ZXh0cmEgKipkZXNjX2V4dHJhKQo+IEBAIC0yMjYyLDEwICsyMjc1LDYgQEAgc3RydWN0IHZpcnRx
dWV1ZSAqX192cmluZ19uZXdfdmlydHF1ZXVlKHVuc2lnbmVkIGludCBpbmRleCwKPiAgIAlpZiAo
dmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19GX09SREVSX1BMQVRGT1JNKSkKPiAgIAkJ
dnEtPndlYWtfYmFycmllcnMgPSBmYWxzZTsKPiAgIAo+IC0JdnEtPnNwbGl0LnF1ZXVlX2RtYV9h
ZGRyID0gMDsKPiAtCXZxLT5zcGxpdC5xdWV1ZV9zaXplX2luX2J5dGVzID0gMDsKPiAtCj4gLQl2
cS0+c3BsaXQudnJpbmcgPSB2cmluZzsKPiAgIAl2cS0+c3BsaXQuYXZhaWxfZmxhZ3Nfc2hhZG93
ID0gMDsKPiAgIAl2cS0+c3BsaXQuYXZhaWxfaWR4X3NoYWRvdyA9IDA7Cj4gICAKPiBAQCAtMjI4
Myw4ICsyMjkyLDcgQEAgc3RydWN0IHZpcnRxdWV1ZSAqX192cmluZ19uZXdfdmlydHF1ZXVlKHVu
c2lnbmVkIGludCBpbmRleCwKPiAgIAkJcmV0dXJuIE5VTEw7Cj4gICAJfQo+ICAgCj4gLQl2cS0+
c3BsaXQuZGVzY19zdGF0ZSA9IHN0YXRlOwo+IC0JdnEtPnNwbGl0LmRlc2NfZXh0cmEgPSBleHRy
YTsKPiArCXZyaW5nX3ZpcnRxdWV1ZV9hdHRhY2hfc3BsaXQodnEsIHZyaW5nLCBzdGF0ZSwgZXh0
cmEpOwo+ICAgCj4gICAJLyogUHV0IGV2ZXJ5dGhpbmcgaW4gZnJlZSBsaXN0cy4gKi8KPiAgIAl2
cS0+ZnJlZV9oZWFkID0gMDsKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVt
Cg==


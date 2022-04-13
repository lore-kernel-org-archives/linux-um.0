Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1neWmw-00HGrA-HT
 for linux-um@lists.infradead.org; Wed, 13 Apr 2022 06:47:40 +0000
Message-ID: <1649832244.772237-6-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v9 08/32] virtio_ring: split: extract the logic of attach
 vring
Date: Wed, 13 Apr 2022 14:44:04 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-9-xuanzhuo@linux.alibaba.com>
 <28237db0-cf04-aa36-b7b8-de55b11d18db@redhat.com>
In-Reply-To: <28237db0-cf04-aa36-b7b8-de55b11d18db@redhat.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Jason Wang <jasowang@redhat.com>
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, "Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>, Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Johannes Berg <johannes.berg@intel.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, linux-um@lists.infradead.org, netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, virtualization@lists.linux-foundation.org

T24gVHVlLCAxMiBBcHIgMjAyMiAxMTozMTowOCArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiDlnKggMjAyMi80LzYg5LiK5Y2IMTE6NDMsIFh1YW4gWmh1
byDlhpnpgZM6Cj4gPiBTZXBhcmF0ZSB0aGUgbG9naWMgb2YgYXR0YWNoIHZyaW5nLCBzdWJzZXF1
ZW50IHBhdGNoZXMgd2lsbCBjYWxsIGl0Cj4gPiBzZXBhcmF0ZWx5Lgo+ID4KPiA+IFNpZ25lZC1v
ZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gPiAtLS0KPiA+
ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDIwICsrKysrKysrKysrKysrLS0tLS0t
Cj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQo+
ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVy
cy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gaW5kZXggNmRlNjc0MzljYjU3Li4wODNmMjk5MmJh
MGQgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiArKysg
Yi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiBAQCAtOTE2LDYgKzkxNiwxOSBAQCBz
dGF0aWMgdm9pZCAqdmlydHF1ZXVlX2RldGFjaF91bnVzZWRfYnVmX3NwbGl0KHN0cnVjdCB2aXJ0
cXVldWUgKl92cSkKPiA+ICAgCXJldHVybiBOVUxMOwo+ID4gICB9Cj4gPgo+ID4gK3N0YXRpYyB2
b2lkIHZyaW5nX3ZpcnRxdWV1ZV9hdHRhY2hfc3BsaXQoc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAq
dnEsCj4gPiArCQkJCQkgc3RydWN0IHZyaW5nIHZyaW5nLAo+ID4gKwkJCQkJIHN0cnVjdCB2cmlu
Z19kZXNjX3N0YXRlX3NwbGl0ICpkZXNjX3N0YXRlLAo+ID4gKwkJCQkJIHN0cnVjdCB2cmluZ19k
ZXNjX2V4dHJhICpkZXNjX2V4dHJhKQo+ID4gK3sKPiA+ICsJdnEtPnNwbGl0LnZyaW5nID0gdnJp
bmc7Cj4gPiArCXZxLT5zcGxpdC5xdWV1ZV9kbWFfYWRkciA9IDA7Cj4gPiArCXZxLT5zcGxpdC5x
dWV1ZV9zaXplX2luX2J5dGVzID0gMDsKPgo+Cj4gQW55IHJlYXNvbiB0byBhZGQgdGhlIGFib3Zl
IHR3byBhc3NpZ25tZW50IGluIGF0dGFjaD8gSXQgc2VlbXMgYmVsb25nIHRvCj4gZnJlZSBvciBy
ZXNldC4KCkFzIGRpc2N1c3NlZCBpbiBwYXRjaCAxMSwgc2luY2UgdGhlcmUgaXMgbm8gZG1hX2Fk
ZHIgaW4gX192cmluZ19uZXdfdmlydHF1ZXVlKCksCnRoZSBjb3JyZXNwb25kaW5nIHZxLT5zcGxp
dC5xdWV1ZV9kbWFfYWRkciBjYW5ub3QgYmUgc2V0LCBzbyB0aGUgcHVycG9zZSBoZXJlCmlzIGp1
c3QgdG8gaW5pdGlhbGl6ZSBpdC4KCkluIHRoZSBuZXh0IHZlcnNpb24sIHN0cnVjdCB2cmluZ192
aXJ0cXVldWVfc3BsaXQgd2lsbCBiZSBwYXNzZWQgdG8KdnJpbmdfdmlydHF1ZXVlX2F0dGFjaF9z
cGxpdCgpIHRvIG1ha2UgdGhlIGxvZ2ljIGhlcmUgbG9vayBtb3JlIHJlYXNvbmFibGUuCgpUaGFu
a3MuCgoKPgo+IFRoYW5rcwo+Cj4KPiA+ICsKPiA+ICsJdnEtPnNwbGl0LmRlc2Nfc3RhdGUgPSBk
ZXNjX3N0YXRlOwo+ID4gKwl2cS0+c3BsaXQuZGVzY19leHRyYSA9IGRlc2NfZXh0cmE7Cj4gPiAr
fQo+ID4gKwo+ID4gICBzdGF0aWMgaW50IHZyaW5nX2FsbG9jX3N0YXRlX2V4dHJhX3NwbGl0KHUz
MiBudW0sCj4gPiAgIAkJCQkJIHN0cnVjdCB2cmluZ19kZXNjX3N0YXRlX3NwbGl0ICoqZGVzY19z
dGF0ZSwKPiA+ICAgCQkJCQkgc3RydWN0IHZyaW5nX2Rlc2NfZXh0cmEgKipkZXNjX2V4dHJhKQo+
ID4gQEAgLTIyNjIsMTAgKzIyNzUsNiBAQCBzdHJ1Y3QgdmlydHF1ZXVlICpfX3ZyaW5nX25ld192
aXJ0cXVldWUodW5zaWduZWQgaW50IGluZGV4LAo+ID4gICAJaWYgKHZpcnRpb19oYXNfZmVhdHVy
ZSh2ZGV2LCBWSVJUSU9fRl9PUkRFUl9QTEFURk9STSkpCj4gPiAgIAkJdnEtPndlYWtfYmFycmll
cnMgPSBmYWxzZTsKPiA+Cj4gPiAtCXZxLT5zcGxpdC5xdWV1ZV9kbWFfYWRkciA9IDA7Cj4gPiAt
CXZxLT5zcGxpdC5xdWV1ZV9zaXplX2luX2J5dGVzID0gMDsKPiA+IC0KPiA+IC0JdnEtPnNwbGl0
LnZyaW5nID0gdnJpbmc7Cj4gPiAgIAl2cS0+c3BsaXQuYXZhaWxfZmxhZ3Nfc2hhZG93ID0gMDsK
PiA+ICAgCXZxLT5zcGxpdC5hdmFpbF9pZHhfc2hhZG93ID0gMDsKPiA+Cj4gPiBAQCAtMjI4Myw4
ICsyMjkyLDcgQEAgc3RydWN0IHZpcnRxdWV1ZSAqX192cmluZ19uZXdfdmlydHF1ZXVlKHVuc2ln
bmVkIGludCBpbmRleCwKPiA+ICAgCQlyZXR1cm4gTlVMTDsKPiA+ICAgCX0KPiA+Cj4gPiAtCXZx
LT5zcGxpdC5kZXNjX3N0YXRlID0gc3RhdGU7Cj4gPiAtCXZxLT5zcGxpdC5kZXNjX2V4dHJhID0g
ZXh0cmE7Cj4gPiArCXZyaW5nX3ZpcnRxdWV1ZV9hdHRhY2hfc3BsaXQodnEsIHZyaW5nLCBzdGF0
ZSwgZXh0cmEpOwo+ID4KPiA+ICAgCS8qIFB1dCBldmVyeXRoaW5nIGluIGZyZWUgbGlzdHMuICov
Cj4gPiAgIAl2cS0+ZnJlZV9oZWFkID0gMDsKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC11bQo=


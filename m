Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1neAU4-00C1e7-9O
 for linux-um@lists.infradead.org; Tue, 12 Apr 2022 06:58:42 +0000
Received: by mail-pl1-f198.google.com with SMTP id
 s18-20020a170902ea1200b001570031e832so5972809plg.6
 for <linux-um@lists.infradead.org>; Mon, 11 Apr 2022 23:58:32 -0700 (PDT)
Message-ID: <d228a41f-a3a1-029d-f259-d4fbab822e78@redhat.com>
Date: Tue, 12 Apr 2022 14:58:19 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v9 22/32] virtio_pci: queue_reset: extract the logic of
 active vq for modern pci
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-23-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-23-xuanzhuo@linux.alibaba.com>
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
dnBfYWN0aXZlX3ZxKCkgdG8gY29uZmlndXJlIHZyaW5nIHRvIGJhY2tlbmQgYWZ0ZXIgdnEgYXR0
YWNoCj4gdnJpbmcuIEFuZCBjb25maWd1cmUgdnEgdmVjdG9yIGlmIG5lY2Vzc2FyeS4KPgo+IFNp
Z25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gLS0t
Cj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVybi5jIHwgNDYgKysrKysrKysrKysr
KysrKysrLS0tLS0tLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKSwg
MTggZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Bj
aV9tb2Rlcm4uYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuLmMKPiBpbmRleCA4
NmQzMDFmMjcyYjguLjQ5YTQ0OTM3MzJjZiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92
aXJ0aW9fcGNpX21vZGVybi5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rl
cm4uYwo+IEBAIC0xNzYsNiArMTc2LDI5IEBAIHN0YXRpYyB2b2lkIHZwX3Jlc2V0KHN0cnVjdCB2
aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ICAgCXZwX2Rpc2FibGVfY2JzKHZkZXYpOwo+ICAgfQo+ICAg
Cj4gK3N0YXRpYyBpbnQgdnBfYWN0aXZlX3ZxKHN0cnVjdCB2aXJ0cXVldWUgKnZxLCB1MTYgbXNp
eF92ZWMpCj4gK3sKPiArCXN0cnVjdCB2aXJ0aW9fcGNpX2RldmljZSAqdnBfZGV2ID0gdG9fdnBf
ZGV2aWNlKHZxLT52ZGV2KTsKPiArCXN0cnVjdCB2aXJ0aW9fcGNpX21vZGVybl9kZXZpY2UgKm1k
ZXYgPSAmdnBfZGV2LT5tZGV2Owo+ICsJdW5zaWduZWQgbG9uZyBpbmRleDsKPiArCj4gKwlpbmRl
eCA9IHZxLT5pbmRleDsKPiArCj4gKwkvKiBhY3RpdmF0ZSB0aGUgcXVldWUgKi8KPiArCXZwX21v
ZGVybl9zZXRfcXVldWVfc2l6ZShtZGV2LCBpbmRleCwgdmlydHF1ZXVlX2dldF92cmluZ19zaXpl
KHZxKSk7Cj4gKwl2cF9tb2Rlcm5fcXVldWVfYWRkcmVzcyhtZGV2LCBpbmRleCwgdmlydHF1ZXVl
X2dldF9kZXNjX2FkZHIodnEpLAo+ICsJCQkJdmlydHF1ZXVlX2dldF9hdmFpbF9hZGRyKHZxKSwK
PiArCQkJCXZpcnRxdWV1ZV9nZXRfdXNlZF9hZGRyKHZxKSk7Cj4gKwo+ICsJaWYgKG1zaXhfdmVj
ICE9IFZJUlRJT19NU0lfTk9fVkVDVE9SKSB7Cj4gKwkJbXNpeF92ZWMgPSB2cF9tb2Rlcm5fcXVl
dWVfdmVjdG9yKG1kZXYsIGluZGV4LCBtc2l4X3ZlYyk7Cj4gKwkJaWYgKG1zaXhfdmVjID09IFZJ
UlRJT19NU0lfTk9fVkVDVE9SKQo+ICsJCQlyZXR1cm4gLUVCVVNZOwo+ICsJfQo+ICsKPiArCXJl
dHVybiAwOwo+ICt9Cj4gKwo+ICAgc3RhdGljIHUxNiB2cF9jb25maWdfdmVjdG9yKHN0cnVjdCB2
aXJ0aW9fcGNpX2RldmljZSAqdnBfZGV2LCB1MTYgdmVjdG9yKQo+ICAgewo+ICAgCXJldHVybiB2
cF9tb2Rlcm5fY29uZmlnX3ZlY3RvcigmdnBfZGV2LT5tZGV2LCB2ZWN0b3IpOwo+IEBAIC0yMjAs
MzIgKzI0MywxOSBAQCBzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqc2V0dXBfdnEoc3RydWN0IHZp
cnRpb19wY2lfZGV2aWNlICp2cF9kZXYsCj4gICAKPiAgIAl2cS0+bnVtX21heCA9IG51bTsKPiAg
IAo+IC0JLyogYWN0aXZhdGUgdGhlIHF1ZXVlICovCj4gLQl2cF9tb2Rlcm5fc2V0X3F1ZXVlX3Np
emUobWRldiwgaW5kZXgsIHZpcnRxdWV1ZV9nZXRfdnJpbmdfc2l6ZSh2cSkpOwo+IC0JdnBfbW9k
ZXJuX3F1ZXVlX2FkZHJlc3MobWRldiwgaW5kZXgsIHZpcnRxdWV1ZV9nZXRfZGVzY19hZGRyKHZx
KSwKPiAtCQkJCXZpcnRxdWV1ZV9nZXRfYXZhaWxfYWRkcih2cSksCj4gLQkJCQl2aXJ0cXVldWVf
Z2V0X3VzZWRfYWRkcih2cSkpOwo+ICsJZXJyID0gdnBfYWN0aXZlX3ZxKHZxLCBtc2l4X3ZlYyk7
Cj4gKwlpZiAoZXJyKQo+ICsJCWdvdG8gZXJyOwo+ICAgCj4gICAJdnEtPnByaXYgPSAodm9pZCBf
X2ZvcmNlICopdnBfbW9kZXJuX21hcF92cV9ub3RpZnkobWRldiwgaW5kZXgsIE5VTEwpOwo+ICAg
CWlmICghdnEtPnByaXYpIHsKPiAgIAkJZXJyID0gLUVOT01FTTsKPiAtCQlnb3RvIGVycl9tYXBf
bm90aWZ5Owo+IC0JfQo+IC0KPiAtCWlmIChtc2l4X3ZlYyAhPSBWSVJUSU9fTVNJX05PX1ZFQ1RP
Uikgewo+IC0JCW1zaXhfdmVjID0gdnBfbW9kZXJuX3F1ZXVlX3ZlY3RvcihtZGV2LCBpbmRleCwg
bXNpeF92ZWMpOwo+IC0JCWlmIChtc2l4X3ZlYyA9PSBWSVJUSU9fTVNJX05PX1ZFQ1RPUikgewo+
IC0JCQllcnIgPSAtRUJVU1k7Cj4gLQkJCWdvdG8gZXJyX2Fzc2lnbl92ZWN0b3I7Cj4gLQkJfQo+
ICsJCWdvdG8gZXJyOwo+ICAgCX0KPiAgIAo+ICAgCXJldHVybiB2cTsKPiAgIAo+IC1lcnJfYXNz
aWduX3ZlY3RvcjoKPiAtCWlmICghbWRldi0+bm90aWZ5X2Jhc2UpCj4gLQkJcGNpX2lvdW5tYXAo
bWRldi0+cGNpX2RldiwgKHZvaWQgX19pb21lbSBfX2ZvcmNlICopdnEtPnByaXYpOwoKCldlIG5l
ZWQga2VlcCB0aGlzIG9yIGFueXRoaW5nIEkgbWlzc2VkPwoKVGhhbmtzCgoKPiAtZXJyX21hcF9u
b3RpZnk6Cj4gK2VycjoKPiAgIAl2cmluZ19kZWxfdmlydHF1ZXVlKHZxKTsKPiAgIAlyZXR1cm4g
RVJSX1BUUihlcnIpOwo+ICAgfQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
dW0K


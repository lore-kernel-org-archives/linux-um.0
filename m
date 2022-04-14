Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nevvR-004vTB-RI
 for linux-um@lists.infradead.org; Thu, 14 Apr 2022 09:38:07 +0000
Received: by mail-lf1-f72.google.com with SMTP id
 o4-20020a056512230400b0046d0a7f733cso1092040lfu.15
 for <linux-um@lists.infradead.org>; Thu, 14 Apr 2022 02:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-23-xuanzhuo@linux.alibaba.com>
 <d228a41f-a3a1-029d-f259-d4fbab822e78@redhat.com>
 <1649917349.6242197-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1649917349.6242197-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 14 Apr 2022 17:37:50 +0800
Message-ID: <CACGkMEuk24R8Y-H2=cuG4VkQhTNf6CSEMJbxe7jvHFEusa815g@mail.gmail.com>
Subject: Re: [PATCH v9 22/32] virtio_pci: queue_reset: extract the logic of
 active vq for modern pci
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, "Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>, Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Johannes Berg <johannes.berg@intel.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, linux-um@lists.infradead.org, netdev <netdev@vger.kernel.org>, platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, kvm <kvm@vger.kernel.org>, "open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>

T24gVGh1LCBBcHIgMTQsIDIwMjIgYXQgMjoyNSBQTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IE9uIFR1ZSwgMTIgQXByIDIwMjIgMTQ6NTg6MTkgKzA4
MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IOWcqCAy
MDIyLzQvNiDkuIrljYgxMTo0MywgWHVhbiBaaHVvIOWGmemBkzoKPiA+ID4gSW50cm9kdWNlIHZw
X2FjdGl2ZV92cSgpIHRvIGNvbmZpZ3VyZSB2cmluZyB0byBiYWNrZW5kIGFmdGVyIHZxIGF0dGFj
aAo+ID4gPiB2cmluZy4gQW5kIGNvbmZpZ3VyZSB2cSB2ZWN0b3IgaWYgbmVjZXNzYXJ5Lgo+ID4g
Pgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEu
Y29tPgo+ID4gPiAtLS0KPiA+ID4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVybi5j
IHwgNDYgKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tCj4gPiA+ICAgMSBmaWxlIGNoYW5n
ZWQsIDI4IGluc2VydGlvbnMoKyksIDE4IGRlbGV0aW9ucygtKQo+ID4gPgo+ID4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm4uYyBiL2RyaXZlcnMvdmlydGlv
L3ZpcnRpb19wY2lfbW9kZXJuLmMKPiA+ID4gaW5kZXggODZkMzAxZjI3MmI4Li40OWE0NDkzNzMy
Y2YgMTAwNjQ0Cj4gPiA+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuLmMK
PiA+ID4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm4uYwo+ID4gPiBAQCAt
MTc2LDYgKzE3NiwyOSBAQCBzdGF0aWMgdm9pZCB2cF9yZXNldChzdHJ1Y3QgdmlydGlvX2Rldmlj
ZSAqdmRldikKPiA+ID4gICAgIHZwX2Rpc2FibGVfY2JzKHZkZXYpOwo+ID4gPiAgIH0KPiA+ID4K
PiA+ID4gK3N0YXRpYyBpbnQgdnBfYWN0aXZlX3ZxKHN0cnVjdCB2aXJ0cXVldWUgKnZxLCB1MTYg
bXNpeF92ZWMpCj4gPiA+ICt7Cj4gPiA+ICsgICBzdHJ1Y3QgdmlydGlvX3BjaV9kZXZpY2UgKnZw
X2RldiA9IHRvX3ZwX2RldmljZSh2cS0+dmRldik7Cj4gPiA+ICsgICBzdHJ1Y3QgdmlydGlvX3Bj
aV9tb2Rlcm5fZGV2aWNlICptZGV2ID0gJnZwX2Rldi0+bWRldjsKPiA+ID4gKyAgIHVuc2lnbmVk
IGxvbmcgaW5kZXg7Cj4gPiA+ICsKPiA+ID4gKyAgIGluZGV4ID0gdnEtPmluZGV4Owo+ID4gPiAr
Cj4gPiA+ICsgICAvKiBhY3RpdmF0ZSB0aGUgcXVldWUgKi8KPiA+ID4gKyAgIHZwX21vZGVybl9z
ZXRfcXVldWVfc2l6ZShtZGV2LCBpbmRleCwgdmlydHF1ZXVlX2dldF92cmluZ19zaXplKHZxKSk7
Cj4gPiA+ICsgICB2cF9tb2Rlcm5fcXVldWVfYWRkcmVzcyhtZGV2LCBpbmRleCwgdmlydHF1ZXVl
X2dldF9kZXNjX2FkZHIodnEpLAo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgdmly
dHF1ZXVlX2dldF9hdmFpbF9hZGRyKHZxKSwKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHZpcnRxdWV1ZV9nZXRfdXNlZF9hZGRyKHZxKSk7Cj4gPiA+ICsKPiA+ID4gKyAgIGlmICht
c2l4X3ZlYyAhPSBWSVJUSU9fTVNJX05PX1ZFQ1RPUikgewo+ID4gPiArICAgICAgICAgICBtc2l4
X3ZlYyA9IHZwX21vZGVybl9xdWV1ZV92ZWN0b3IobWRldiwgaW5kZXgsIG1zaXhfdmVjKTsKPiA+
ID4gKyAgICAgICAgICAgaWYgKG1zaXhfdmVjID09IFZJUlRJT19NU0lfTk9fVkVDVE9SKQo+ID4g
PiArICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUJVU1k7Cj4gPiA+ICsgICB9Cj4gPiA+ICsK
PiA+ID4gKyAgIHJldHVybiAwOwo+ID4gPiArfQo+ID4gPiArCj4gPiA+ICAgc3RhdGljIHUxNiB2
cF9jb25maWdfdmVjdG9yKHN0cnVjdCB2aXJ0aW9fcGNpX2RldmljZSAqdnBfZGV2LCB1MTYgdmVj
dG9yKQo+ID4gPiAgIHsKPiA+ID4gICAgIHJldHVybiB2cF9tb2Rlcm5fY29uZmlnX3ZlY3Rvcigm
dnBfZGV2LT5tZGV2LCB2ZWN0b3IpOwo+ID4gPiBAQCAtMjIwLDMyICsyNDMsMTkgQEAgc3RhdGlj
IHN0cnVjdCB2aXJ0cXVldWUgKnNldHVwX3ZxKHN0cnVjdCB2aXJ0aW9fcGNpX2RldmljZSAqdnBf
ZGV2LAo+ID4gPgo+ID4gPiAgICAgdnEtPm51bV9tYXggPSBudW07Cj4gPiA+Cj4gPiA+IC0gICAv
KiBhY3RpdmF0ZSB0aGUgcXVldWUgKi8KPiA+ID4gLSAgIHZwX21vZGVybl9zZXRfcXVldWVfc2l6
ZShtZGV2LCBpbmRleCwgdmlydHF1ZXVlX2dldF92cmluZ19zaXplKHZxKSk7Cj4gPiA+IC0gICB2
cF9tb2Rlcm5fcXVldWVfYWRkcmVzcyhtZGV2LCBpbmRleCwgdmlydHF1ZXVlX2dldF9kZXNjX2Fk
ZHIodnEpLAo+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgdmlydHF1ZXVlX2dldF9h
dmFpbF9hZGRyKHZxKSwKPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgIHZpcnRxdWV1
ZV9nZXRfdXNlZF9hZGRyKHZxKSk7Cj4gPiA+ICsgICBlcnIgPSB2cF9hY3RpdmVfdnEodnEsIG1z
aXhfdmVjKTsKPiA+ID4gKyAgIGlmIChlcnIpCj4gPiA+ICsgICAgICAgICAgIGdvdG8gZXJyOwo+
ID4gPgo+ID4gPiAgICAgdnEtPnByaXYgPSAodm9pZCBfX2ZvcmNlICopdnBfbW9kZXJuX21hcF92
cV9ub3RpZnkobWRldiwgaW5kZXgsIE5VTEwpOwo+ID4gPiAgICAgaWYgKCF2cS0+cHJpdikgewo+
ID4gPiAgICAgICAgICAgICBlcnIgPSAtRU5PTUVNOwo+ID4gPiAtICAgICAgICAgICBnb3RvIGVy
cl9tYXBfbm90aWZ5Owo+ID4gPiAtICAgfQo+ID4gPiAtCj4gPiA+IC0gICBpZiAobXNpeF92ZWMg
IT0gVklSVElPX01TSV9OT19WRUNUT1IpIHsKPiA+ID4gLSAgICAgICAgICAgbXNpeF92ZWMgPSB2
cF9tb2Rlcm5fcXVldWVfdmVjdG9yKG1kZXYsIGluZGV4LCBtc2l4X3ZlYyk7Cj4gPiA+IC0gICAg
ICAgICAgIGlmIChtc2l4X3ZlYyA9PSBWSVJUSU9fTVNJX05PX1ZFQ1RPUikgewo+ID4gPiAtICAg
ICAgICAgICAgICAgICAgIGVyciA9IC1FQlVTWTsKPiA+ID4gLSAgICAgICAgICAgICAgICAgICBn
b3RvIGVycl9hc3NpZ25fdmVjdG9yOwo+ID4gPiAtICAgICAgICAgICB9Cj4gPiA+ICsgICAgICAg
ICAgIGdvdG8gZXJyOwo+ID4gPiAgICAgfQo+ID4gPgo+ID4gPiAgICAgcmV0dXJuIHZxOwo+ID4g
Pgo+ID4gPiAtZXJyX2Fzc2lnbl92ZWN0b3I6Cj4gPiA+IC0gICBpZiAoIW1kZXYtPm5vdGlmeV9i
YXNlKQo+ID4gPiAtICAgICAgICAgICBwY2lfaW91bm1hcChtZGV2LT5wY2lfZGV2LCAodm9pZCBf
X2lvbWVtIF9fZm9yY2UgKil2cS0+cHJpdik7Cj4gPgo+ID4KPiA+IFdlIG5lZWQga2VlcCB0aGlz
IG9yIGFueXRoaW5nIEkgbWlzc2VkPwo+Cj4gSSB0aGluayBzbywgYWZ0ZXIgbW9kaWZpY2F0aW9u
LCB2cF9tb2Rlcm5fbWFwX3ZxX25vdGlmeSBpcyB0aGUgbGFzdCBzdGVwIGJlZm9yZQo+IHJldHVy
bmluZyB2cS4gSWYgaXQgZmFpbHMsIHRoZW4gdnEtPnByaXYgaXMgZXF1YWwgdG8gTlVMTCwgc28g
dGhlcmUgaXMgbm8gbmVlZAo+IHRvIGV4ZWN1dGUgcGNpX2lvdW5tYXAuCj4KPiBEaWQgSSBtaXNz
IHNvbWV0aGluZz8KCk5vcGUgSSBtaXNzIHRoYXQgdGhlIHZlY3RvciBpcyBjb25maWd1cmVkIGJl
Zm9yZSB0aGUgbWFwcGluZy4KClNvCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4KClRoYW5rcwoKPgo+IFRoYW5rcy4KPgo+ID4KPiA+IFRoYW5rcwo+ID4KPiA+Cj4g
PiA+IC1lcnJfbWFwX25vdGlmeToKPiA+ID4gK2VycjoKPiA+ID4gICAgIHZyaW5nX2RlbF92aXJ0
cXVldWUodnEpOwo+ID4gPiAgICAgcmV0dXJuIEVSUl9QVFIoZXJyKTsKPiA+ID4gICB9Cj4gPgo+
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
dW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=


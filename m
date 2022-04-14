Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nesua-0044ms-9g
 for linux-um@lists.infradead.org; Thu, 14 Apr 2022 06:25:02 +0000
Message-ID: <1649917349.6242197-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v9 22/32] virtio_pci: queue_reset: extract the logic of
 active vq for modern pci
Date: Thu, 14 Apr 2022 14:22:29 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-23-xuanzhuo@linux.alibaba.com>
 <d228a41f-a3a1-029d-f259-d4fbab822e78@redhat.com>
In-Reply-To: <d228a41f-a3a1-029d-f259-d4fbab822e78@redhat.com>
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

T24gVHVlLCAxMiBBcHIgMjAyMiAxNDo1ODoxOSArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiDlnKggMjAyMi80LzYg5LiK5Y2IMTE6NDMsIFh1YW4gWmh1
byDlhpnpgZM6Cj4gPiBJbnRyb2R1Y2UgdnBfYWN0aXZlX3ZxKCkgdG8gY29uZmlndXJlIHZyaW5n
IHRvIGJhY2tlbmQgYWZ0ZXIgdnEgYXR0YWNoCj4gPiB2cmluZy4gQW5kIGNvbmZpZ3VyZSB2cSB2
ZWN0b3IgaWYgbmVjZXNzYXJ5Lgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVh
bnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gPiAtLS0KPiA+ICAgZHJpdmVycy92aXJ0aW8vdmly
dGlvX3BjaV9tb2Rlcm4uYyB8IDQ2ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQo+ID4g
ICAxIGZpbGUgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pCj4gPgo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuLmMgYi9kcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVybi5jCj4gPiBpbmRleCA4NmQzMDFmMjcyYjguLjQ5
YTQ0OTM3MzJjZiAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9k
ZXJuLmMKPiA+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuLmMKPiA+IEBA
IC0xNzYsNiArMTc2LDI5IEBAIHN0YXRpYyB2b2lkIHZwX3Jlc2V0KHN0cnVjdCB2aXJ0aW9fZGV2
aWNlICp2ZGV2KQo+ID4gICAJdnBfZGlzYWJsZV9jYnModmRldik7Cj4gPiAgIH0KPiA+Cj4gPiAr
c3RhdGljIGludCB2cF9hY3RpdmVfdnEoc3RydWN0IHZpcnRxdWV1ZSAqdnEsIHUxNiBtc2l4X3Zl
YykKPiA+ICt7Cj4gPiArCXN0cnVjdCB2aXJ0aW9fcGNpX2RldmljZSAqdnBfZGV2ID0gdG9fdnBf
ZGV2aWNlKHZxLT52ZGV2KTsKPiA+ICsJc3RydWN0IHZpcnRpb19wY2lfbW9kZXJuX2RldmljZSAq
bWRldiA9ICZ2cF9kZXYtPm1kZXY7Cj4gPiArCXVuc2lnbmVkIGxvbmcgaW5kZXg7Cj4gPiArCj4g
PiArCWluZGV4ID0gdnEtPmluZGV4Owo+ID4gKwo+ID4gKwkvKiBhY3RpdmF0ZSB0aGUgcXVldWUg
Ki8KPiA+ICsJdnBfbW9kZXJuX3NldF9xdWV1ZV9zaXplKG1kZXYsIGluZGV4LCB2aXJ0cXVldWVf
Z2V0X3ZyaW5nX3NpemUodnEpKTsKPiA+ICsJdnBfbW9kZXJuX3F1ZXVlX2FkZHJlc3MobWRldiwg
aW5kZXgsIHZpcnRxdWV1ZV9nZXRfZGVzY19hZGRyKHZxKSwKPiA+ICsJCQkJdmlydHF1ZXVlX2dl
dF9hdmFpbF9hZGRyKHZxKSwKPiA+ICsJCQkJdmlydHF1ZXVlX2dldF91c2VkX2FkZHIodnEpKTsK
PiA+ICsKPiA+ICsJaWYgKG1zaXhfdmVjICE9IFZJUlRJT19NU0lfTk9fVkVDVE9SKSB7Cj4gPiAr
CQltc2l4X3ZlYyA9IHZwX21vZGVybl9xdWV1ZV92ZWN0b3IobWRldiwgaW5kZXgsIG1zaXhfdmVj
KTsKPiA+ICsJCWlmIChtc2l4X3ZlYyA9PSBWSVJUSU9fTVNJX05PX1ZFQ1RPUikKPiA+ICsJCQly
ZXR1cm4gLUVCVVNZOwo+ID4gKwl9Cj4gPiArCj4gPiArCXJldHVybiAwOwo+ID4gK30KPiA+ICsK
PiA+ICAgc3RhdGljIHUxNiB2cF9jb25maWdfdmVjdG9yKHN0cnVjdCB2aXJ0aW9fcGNpX2Rldmlj
ZSAqdnBfZGV2LCB1MTYgdmVjdG9yKQo+ID4gICB7Cj4gPiAgIAlyZXR1cm4gdnBfbW9kZXJuX2Nv
bmZpZ192ZWN0b3IoJnZwX2Rldi0+bWRldiwgdmVjdG9yKTsKPiA+IEBAIC0yMjAsMzIgKzI0Mywx
OSBAQCBzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqc2V0dXBfdnEoc3RydWN0IHZpcnRpb19wY2lf
ZGV2aWNlICp2cF9kZXYsCj4gPgo+ID4gICAJdnEtPm51bV9tYXggPSBudW07Cj4gPgo+ID4gLQkv
KiBhY3RpdmF0ZSB0aGUgcXVldWUgKi8KPiA+IC0JdnBfbW9kZXJuX3NldF9xdWV1ZV9zaXplKG1k
ZXYsIGluZGV4LCB2aXJ0cXVldWVfZ2V0X3ZyaW5nX3NpemUodnEpKTsKPiA+IC0JdnBfbW9kZXJu
X3F1ZXVlX2FkZHJlc3MobWRldiwgaW5kZXgsIHZpcnRxdWV1ZV9nZXRfZGVzY19hZGRyKHZxKSwK
PiA+IC0JCQkJdmlydHF1ZXVlX2dldF9hdmFpbF9hZGRyKHZxKSwKPiA+IC0JCQkJdmlydHF1ZXVl
X2dldF91c2VkX2FkZHIodnEpKTsKPiA+ICsJZXJyID0gdnBfYWN0aXZlX3ZxKHZxLCBtc2l4X3Zl
Yyk7Cj4gPiArCWlmIChlcnIpCj4gPiArCQlnb3RvIGVycjsKPiA+Cj4gPiAgIAl2cS0+cHJpdiA9
ICh2b2lkIF9fZm9yY2UgKil2cF9tb2Rlcm5fbWFwX3ZxX25vdGlmeShtZGV2LCBpbmRleCwgTlVM
TCk7Cj4gPiAgIAlpZiAoIXZxLT5wcml2KSB7Cj4gPiAgIAkJZXJyID0gLUVOT01FTTsKPiA+IC0J
CWdvdG8gZXJyX21hcF9ub3RpZnk7Cj4gPiAtCX0KPiA+IC0KPiA+IC0JaWYgKG1zaXhfdmVjICE9
IFZJUlRJT19NU0lfTk9fVkVDVE9SKSB7Cj4gPiAtCQltc2l4X3ZlYyA9IHZwX21vZGVybl9xdWV1
ZV92ZWN0b3IobWRldiwgaW5kZXgsIG1zaXhfdmVjKTsKPiA+IC0JCWlmIChtc2l4X3ZlYyA9PSBW
SVJUSU9fTVNJX05PX1ZFQ1RPUikgewo+ID4gLQkJCWVyciA9IC1FQlVTWTsKPiA+IC0JCQlnb3Rv
IGVycl9hc3NpZ25fdmVjdG9yOwo+ID4gLQkJfQo+ID4gKwkJZ290byBlcnI7Cj4gPiAgIAl9Cj4g
Pgo+ID4gICAJcmV0dXJuIHZxOwo+ID4KPiA+IC1lcnJfYXNzaWduX3ZlY3RvcjoKPiA+IC0JaWYg
KCFtZGV2LT5ub3RpZnlfYmFzZSkKPiA+IC0JCXBjaV9pb3VubWFwKG1kZXYtPnBjaV9kZXYsICh2
b2lkIF9faW9tZW0gX19mb3JjZSAqKXZxLT5wcml2KTsKPgo+Cj4gV2UgbmVlZCBrZWVwIHRoaXMg
b3IgYW55dGhpbmcgSSBtaXNzZWQ/CgpJIHRoaW5rIHNvLCBhZnRlciBtb2RpZmljYXRpb24sIHZw
X21vZGVybl9tYXBfdnFfbm90aWZ5IGlzIHRoZSBsYXN0IHN0ZXAgYmVmb3JlCnJldHVybmluZyB2
cS4gSWYgaXQgZmFpbHMsIHRoZW4gdnEtPnByaXYgaXMgZXF1YWwgdG8gTlVMTCwgc28gdGhlcmUg
aXMgbm8gbmVlZAp0byBleGVjdXRlIHBjaV9pb3VubWFwLgoKRGlkIEkgbWlzcyBzb21ldGhpbmc/
CgpUaGFua3MuCgo+Cj4gVGhhbmtzCj4KPgo+ID4gLWVycl9tYXBfbm90aWZ5Ogo+ID4gK2VycjoK
PiA+ICAgCXZyaW5nX2RlbF92aXJ0cXVldWUodnEpOwo+ID4gICAJcmV0dXJuIEVSUl9QVFIoZXJy
KTsKPiA+ICAgfQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==


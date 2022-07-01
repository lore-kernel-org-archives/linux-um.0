Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o7D7u-003u8b-KU
	for linux-um@lists.infradead.org; Fri, 01 Jul 2022 09:39:52 +0000
Received: by mail-pj1-f71.google.com with SMTP id gi2-20020a17090b110200b001ecad6feb7cso2820670pjb.5
        for <linux-um@lists.infradead.org>; Fri, 01 Jul 2022 02:39:48 -0700 (PDT)
Message-ID: <494bcf3f-d42c-f05b-cbdb-d4ba834bd118@redhat.com>
Date: Fri, 1 Jul 2022 17:39:35 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v11 28/40] virtio_pci: introduce helper to get/set queue
 reset
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-29-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220629065656.54420-29-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzYvMjkgMTQ6NTYsIFh1YW4gWmh1byDlhpnpgZM6Cj4gSW50cm9kdWNlIG5ldyBo
ZWxwZXJzIHRvIGltcGxlbWVudCBxdWV1ZSByZXNldCBhbmQgZ2V0IHF1ZXVlIHJlc2V0Cj4gc3Rh
dHVzLgo+Cj4gICBodHRwczovL2dpdGh1Yi5jb20vb2FzaXMtdGNzL3ZpcnRpby1zcGVjL2lzc3Vl
cy8xMjQKPiAgIGh0dHBzOi8vZ2l0aHViLmNvbS9vYXNpcy10Y3MvdmlydGlvLXNwZWMvaXNzdWVz
LzEzOQo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJh
LmNvbT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0t
LQo+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm5fZGV2LmMgfCAzNSArKysrKysr
KysrKysrKysrKysrKysrKysrKwo+ICAgaW5jbHVkZS9saW51eC92aXJ0aW9fcGNpX21vZGVybi5o
ICAgICAgfCAgMiArKwo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAzNyBpbnNlcnRpb25zKCspCj4KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm5fZGV2LmMgYi9kcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVybl9kZXYuYwo+IGluZGV4IGZhMmE5NDQ1YmIxOC4u
MDc0MTU2NTQyNDdjIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9k
ZXJuX2Rldi5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm5fZGV2LmMK
PiBAQCAtMyw2ICszLDcgQEAKPiAgICNpbmNsdWRlIDxsaW51eC92aXJ0aW9fcGNpX21vZGVybi5o
Pgo+ICAgI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgo+ICAgI2luY2x1ZGUgPGxpbnV4L3BjaS5o
Pgo+ICsjaW5jbHVkZSA8bGludXgvZGVsYXkuaD4KPiAgIAo+ICAgLyoKPiAgICAqIHZwX21vZGVy
bl9tYXBfY2FwYWJpbGl0eSAtIG1hcCBhIHBhcnQgb2YgdmlydGlvIHBjaSBjYXBhYmlsaXR5Cj4g
QEAgLTQ3NCw2ICs0NzUsNDAgQEAgdm9pZCB2cF9tb2Rlcm5fc2V0X3N0YXR1cyhzdHJ1Y3Qgdmly
dGlvX3BjaV9tb2Rlcm5fZGV2aWNlICptZGV2LAo+ICAgfQo+ICAgRVhQT1JUX1NZTUJPTF9HUEwo
dnBfbW9kZXJuX3NldF9zdGF0dXMpOwo+ICAgCj4gKy8qCj4gKyAqIHZwX21vZGVybl9nZXRfcXVl
dWVfcmVzZXQgLSBnZXQgdGhlIHF1ZXVlIHJlc2V0IHN0YXR1cwo+ICsgKiBAbWRldjogdGhlIG1v
ZGVybiB2aXJ0aW8tcGNpIGRldmljZQo+ICsgKiBAaW5kZXg6IHF1ZXVlIGluZGV4Cj4gKyAqLwo+
ICtpbnQgdnBfbW9kZXJuX2dldF9xdWV1ZV9yZXNldChzdHJ1Y3QgdmlydGlvX3BjaV9tb2Rlcm5f
ZGV2aWNlICptZGV2LCB1MTYgaW5kZXgpCj4gK3sKPiArCXN0cnVjdCB2aXJ0aW9fcGNpX2NvbW1v
bl9jZmcgX19pb21lbSAqY2ZnID0gbWRldi0+Y29tbW9uOwo+ICsKPiArCXZwX2lvd3JpdGUxNihp
bmRleCwgJmNmZy0+cXVldWVfc2VsZWN0KTsKPiArCXJldHVybiB2cF9pb3JlYWQxNigmY2ZnLT5x
dWV1ZV9yZXNldCk7Cj4gK30KPiArRVhQT1JUX1NZTUJPTF9HUEwodnBfbW9kZXJuX2dldF9xdWV1
ZV9yZXNldCk7Cj4gKwo+ICsvKgo+ICsgKiB2cF9tb2Rlcm5fc2V0X3F1ZXVlX3Jlc2V0IC0gcmVz
ZXQgdGhlIHF1ZXVlCj4gKyAqIEBtZGV2OiB0aGUgbW9kZXJuIHZpcnRpby1wY2kgZGV2aWNlCj4g
KyAqIEBpbmRleDogcXVldWUgaW5kZXgKPiArICovCj4gK3ZvaWQgdnBfbW9kZXJuX3NldF9xdWV1
ZV9yZXNldChzdHJ1Y3QgdmlydGlvX3BjaV9tb2Rlcm5fZGV2aWNlICptZGV2LCB1MTYgaW5kZXgp
Cj4gK3sKPiArCXN0cnVjdCB2aXJ0aW9fcGNpX2NvbW1vbl9jZmcgX19pb21lbSAqY2ZnID0gbWRl
di0+Y29tbW9uOwo+ICsKPiArCXZwX2lvd3JpdGUxNihpbmRleCwgJmNmZy0+cXVldWVfc2VsZWN0
KTsKPiArCXZwX2lvd3JpdGUxNigxLCAmY2ZnLT5xdWV1ZV9yZXNldCk7Cj4gKwo+ICsJd2hpbGUg
KHZwX2lvcmVhZDE2KCZjZmctPnF1ZXVlX3Jlc2V0KSkKPiArCQltc2xlZXAoMSk7Cj4gKwo+ICsJ
d2hpbGUgKHZwX2lvcmVhZDE2KCZjZmctPnF1ZXVlX2VuYWJsZSkpCj4gKwkJbXNsZWVwKDEpOwo+
ICt9Cj4gK0VYUE9SVF9TWU1CT0xfR1BMKHZwX21vZGVybl9zZXRfcXVldWVfcmVzZXQpOwo+ICsK
PiAgIC8qCj4gICAgKiB2cF9tb2Rlcm5fcXVldWVfdmVjdG9yIC0gc2V0IHRoZSBNU0lYIHZlY3Rv
ciBmb3IgYSBzcGVjaWZpYyB2aXJ0cXVldWUKPiAgICAqIEBtZGV2OiB0aGUgbW9kZXJuIHZpcnRp
by1wY2kgZGV2aWNlCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmlydGlvX3BjaV9tb2Rl
cm4uaCBiL2luY2x1ZGUvbGludXgvdmlydGlvX3BjaV9tb2Rlcm4uaAo+IGluZGV4IGJlZWJjN2E0
YTMxZC4uZGVkMDExNTdmODY0IDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGludXgvdmlydGlvX3Bj
aV9tb2Rlcm4uaAo+ICsrKyBiL2luY2x1ZGUvbGludXgvdmlydGlvX3BjaV9tb2Rlcm4uaAo+IEBA
IC0xMzQsNCArMTM0LDYgQEAgdm9pZCBfX2lvbWVtICogdnBfbW9kZXJuX21hcF92cV9ub3RpZnko
c3RydWN0IHZpcnRpb19wY2lfbW9kZXJuX2RldmljZSAqbWRldiwKPiAgIAkJCQkgICAgICAgdTE2
IGluZGV4LCByZXNvdXJjZV9zaXplX3QgKnBhKTsKPiAgIGludCB2cF9tb2Rlcm5fcHJvYmUoc3Ry
dWN0IHZpcnRpb19wY2lfbW9kZXJuX2RldmljZSAqbWRldik7Cj4gICB2b2lkIHZwX21vZGVybl9y
ZW1vdmUoc3RydWN0IHZpcnRpb19wY2lfbW9kZXJuX2RldmljZSAqbWRldik7Cj4gK2ludCB2cF9t
b2Rlcm5fZ2V0X3F1ZXVlX3Jlc2V0KHN0cnVjdCB2aXJ0aW9fcGNpX21vZGVybl9kZXZpY2UgKm1k
ZXYsIHUxNiBpbmRleCk7Cj4gK3ZvaWQgdnBfbW9kZXJuX3NldF9xdWV1ZV9yZXNldChzdHJ1Y3Qg
dmlydGlvX3BjaV9tb2Rlcm5fZGV2aWNlICptZGV2LCB1MTYgaW5kZXgpOwo+ICAgI2VuZGlmCgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0g
bWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=


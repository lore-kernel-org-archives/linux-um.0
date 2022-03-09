Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRr6j-007fKs-45
 for linux-um@lists.infradead.org; Wed, 09 Mar 2022 07:51:42 +0000
Received: by mail-pg1-f198.google.com with SMTP id
 bj8-20020a056a02018800b0035ec8c16f0bso877688pgb.11
 for <linux-um@lists.infradead.org>; Tue, 08 Mar 2022 23:51:35 -0800 (PST)
Message-ID: <aa24df8c-787a-0db5-7b16-60adcb86ab0c@redhat.com>
Date: Wed, 9 Mar 2022 15:51:13 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v7 08/26] virtio_ring: extract the logic of freeing vring
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-9-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220308123518.33800-9-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzMvOCDkuIvljYg4OjM1LCBYdWFuIFpodW8g5YaZ6YGTOgo+IEludHJvZHVjZSB2
cmluZ19mcmVlKCkgdG8gZnJlZSB0aGUgdnJpbmcgb2YgdnEuCj4KPiBQcmV2ZW50IGRvdWJsZSBm
cmVlIGJ5IHNldHRpbmcgdnEtPnJlc2V0Lgo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4
dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRp
b19yaW5nLmMgfCAyNSArKysrKysrKysrKysrKysrKysrKy0tLS0tCj4gICBpbmNsdWRlL2xpbnV4
L3ZpcnRpby5oICAgICAgIHwgIDggKysrKysrKysKPiAgIDIgZmlsZXMgY2hhbmdlZCwgMjggaW5z
ZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IGluZGV4IGI1
YTliZjRmNDViMy4uZTA0MjJjMDRjOTAzIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3Zp
cnRpb19yaW5nLmMKPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gQEAgLTI0
NDIsMTQgKzI0NDIsMTAgQEAgc3RydWN0IHZpcnRxdWV1ZSAqdnJpbmdfbmV3X3ZpcnRxdWV1ZSh1
bnNpZ25lZCBpbnQgaW5kZXgsCj4gICB9Cj4gICBFWFBPUlRfU1lNQk9MX0dQTCh2cmluZ19uZXdf
dmlydHF1ZXVlKTsKPiAgIAo+IC12b2lkIHZyaW5nX2RlbF92aXJ0cXVldWUoc3RydWN0IHZpcnRx
dWV1ZSAqX3ZxKQo+ICtzdGF0aWMgdm9pZCBfX3ZyaW5nX2ZyZWUoc3RydWN0IHZpcnRxdWV1ZSAq
X3ZxKQo+ICAgewo+ICAgCXN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxID0gdG9fdnZxKF92cSk7
Cj4gICAKPiAtCXNwaW5fbG9jaygmdnEtPnZxLnZkZXYtPnZxc19saXN0X2xvY2spOwo+IC0JbGlz
dF9kZWwoJl92cS0+bGlzdCk7Cj4gLQlzcGluX3VubG9jaygmdnEtPnZxLnZkZXYtPnZxc19saXN0
X2xvY2spOwo+IC0KPiAgIAlpZiAodnEtPndlX293bl9yaW5nKSB7Cj4gICAJCWlmICh2cS0+cGFj
a2VkX3JpbmcpIHsKPiAgIAkJCXZyaW5nX2ZyZWVfcXVldWUodnEtPnZxLnZkZXYsCj4gQEAgLTI0
ODAsNiArMjQ3NiwyNSBAQCB2b2lkIHZyaW5nX2RlbF92aXJ0cXVldWUoc3RydWN0IHZpcnRxdWV1
ZSAqX3ZxKQo+ICAgCQlrZnJlZSh2cS0+c3BsaXQuZGVzY19zdGF0ZSk7Cj4gICAJCWtmcmVlKHZx
LT5zcGxpdC5kZXNjX2V4dHJhKTsKPiAgIAl9Cj4gK30KPiArCj4gK3N0YXRpYyB2b2lkIHZyaW5n
X2ZyZWUoc3RydWN0IHZpcnRxdWV1ZSAqdnEpCj4gK3sKPiArCV9fdnJpbmdfZnJlZSh2cSk7Cj4g
Kwl2cS0+cmVzZXQgPSBWSVJUSU9fVlFfUkVTRVRfU1RFUF9WUklOR19SRUxFQVNFOwo+ICt9Cj4g
Kwo+ICt2b2lkIHZyaW5nX2RlbF92aXJ0cXVldWUoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxKQo+ICt7
Cj4gKwlzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSA9IHRvX3Z2cShfdnEpOwo+ICsKPiArCXNw
aW5fbG9jaygmdnEtPnZxLnZkZXYtPnZxc19saXN0X2xvY2spOwo+ICsJbGlzdF9kZWwoJl92cS0+
bGlzdCk7Cj4gKwlzcGluX3VubG9jaygmdnEtPnZxLnZkZXYtPnZxc19saXN0X2xvY2spOwo+ICsK
PiArCWlmIChfdnEtPnJlc2V0ICE9IFZJUlRJT19WUV9SRVNFVF9TVEVQX1ZSSU5HX1JFTEVBU0Up
Cj4gKwkJX192cmluZ19mcmVlKF92cSk7Cj4gKwo+ICAgCWtmcmVlKHZxKTsKPiAgIH0KPiAgIEVY
UE9SVF9TWU1CT0xfR1BMKHZyaW5nX2RlbF92aXJ0cXVldWUpOwo+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL2xpbnV4L3ZpcnRpby5oIGIvaW5jbHVkZS9saW51eC92aXJ0aW8uaAo+IGluZGV4IGQ1OWFk
YzRiZTA2OC4uZTM3MTRlNmRiMzMwIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGludXgvdmlydGlv
LmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oCj4gQEAgLTEwLDYgKzEwLDEzIEBACj4g
ICAjaW5jbHVkZSA8bGludXgvbW9kX2RldmljZXRhYmxlLmg+Cj4gICAjaW5jbHVkZSA8bGludXgv
Z2ZwLmg+Cj4gICAKPiArZW51bSB2aXJ0aW9fdnFfcmVzZXRfc3RlcCB7Cj4gKwlWSVJUSU9fVlFf
UkVTRVRfU1RFUF9OT05FLAo+ICsJVklSVElPX1ZRX1JFU0VUX1NURVBfREVWSUNFLAo+ICsJVklS
VElPX1ZRX1JFU0VUX1NURVBfVlJJTkdfUkVMRUFTRSwKPiArCVZJUlRJT19WUV9SRVNFVF9TVEVQ
X1ZSSU5HX0FUVEFDSCwKPiArfTsKCgpUaGlzIHBhcnQgbG9va3Mgbm90IHJlbGF0ZWQgdG8gdGhl
IHN1YmplY3QuCgpBbmQgaXQgbmVlZHMgZGV0YWlsIGRvY3VtZW50YXRpb24gb24gdGhpcy4KCkJ1
dCBJIHdvbmRlciBob3cgdXNlZnVsIGl0IGlzLCBhbnl3YXkgd2UgY2FuIGNoZWNrIHRoZSByZXNl
dCBzdGF0dXMgdmlhIAp0cmFuc3BvcnQgc3BlY2lmaWMgd2F5IGFuZCBpbiB0aGUgZnV0dXJlIHdl
IG1heSB3YW50IHRvIGRvIG1vcmUgdGhhbiAKanVzdCByZXNpemluZyAoZS5nIFBBU0lEKS4KClRo
YW5rcwoKCj4gKwo+ICAgLyoqCj4gICAgKiB2aXJ0cXVldWUgLSBhIHF1ZXVlIHRvIHJlZ2lzdGVy
IGJ1ZmZlcnMgZm9yIHNlbmRpbmcgb3IgcmVjZWl2aW5nLgo+ICAgICogQGxpc3Q6IHRoZSBjaGFp
biBvZiB2aXJ0cXVldWVzIGZvciB0aGlzIGRldmljZQo+IEBAIC0zMyw2ICs0MCw3IEBAIHN0cnVj
dCB2aXJ0cXVldWUgewo+ICAgCXVuc2lnbmVkIGludCBudW1fZnJlZTsKPiAgIAl1bnNpZ25lZCBp
bnQgbnVtX21heDsKPiAgIAl2b2lkICpwcml2Owo+ICsJZW51bSB2aXJ0aW9fdnFfcmVzZXRfc3Rl
cCByZXNldDsKPiAgIH07Cj4gICAKPiAgIGludCB2aXJ0cXVldWVfYWRkX291dGJ1ZihzdHJ1Y3Qg
dmlydHF1ZXVlICp2cSwKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==


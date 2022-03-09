Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRsHN-007qnf-FC
 for linux-um@lists.infradead.org; Wed, 09 Mar 2022 09:06:46 +0000
Received: by mail-pf1-f198.google.com with SMTP id
 n135-20020a628f8d000000b004e16d5bdcdbso1184619pfd.20
 for <linux-um@lists.infradead.org>; Wed, 09 Mar 2022 01:06:43 -0800 (PST)
Message-ID: <9049128d-543e-be7b-a0a1-08e9bf94c282@redhat.com>
Date: Wed, 9 Mar 2022 17:06:22 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v7 23/26] virtio_net: split free_unused_bufs()
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-24-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220308123518.33800-24-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzMvOCDkuIvljYg4OjM1LCBYdWFuIFpodW8g5YaZ6YGTOgo+IFRoaXMgcGF0Y2gg
c2VwYXJhdGVzIHR3byBmdW5jdGlvbnMgZm9yIGZyZWVpbmcgc3EgYnVmIGFuZCBycSBidWYgZnJv
bQo+IGZyZWVfdW51c2VkX2J1ZnMoKS4KPgo+IFdoZW4gc3VwcG9ydGluZyB0aGUgZW5hYmxlL2Rp
c2FibGUgdHgvcnEgcXVldWUgaW4gdGhlIGZ1dHVyZSwgaXQgaXMKPiBuZWNlc3NhcnkgdG8gc3Vw
cG9ydCBzZXBhcmF0ZSByZWNvdmVyeSBvZiBhIHNxIGJ1ZiBvciBhIHJxIGJ1Zi4KPgo+IFNpZ25l
ZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+CgoKQWNrZWQt
Ynk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKPiAtLS0KPiAgIGRyaXZlcnMv
bmV0L3ZpcnRpb19uZXQuYyB8IDUzICsrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0t
LS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspLCAyMiBkZWxldGlvbnMo
LSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25l
dC92aXJ0aW9fbmV0LmMKPiBpbmRleCA1OWIxZWE4MmY1ZjAuLjQwOWE4ZTE4MDkxOCAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiArKysgYi9kcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMKPiBAQCAtMjgwNCwzNiArMjgwNCw0NSBAQCBzdGF0aWMgdm9pZCBmcmVlX3JlY2Vp
dmVfcGFnZV9mcmFncyhzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSkKPiAgIAkJCXB1dF9wYWdlKHZp
LT5ycVtpXS5hbGxvY19mcmFnLnBhZ2UpOwo+ICAgfQo+ICAgCj4gLXN0YXRpYyB2b2lkIGZyZWVf
dW51c2VkX2J1ZnMoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkpCj4gK3N0YXRpYyB2b2lkIHZpcnRu
ZXRfc3FfZnJlZV91bnVzZWRfYnVmcyhzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwKPiArCQkJCQlz
dHJ1Y3Qgc2VuZF9xdWV1ZSAqc3EpCj4gICB7Cj4gICAJdm9pZCAqYnVmOwo+IC0JaW50IGk7Cj4g
ICAKPiAtCWZvciAoaSA9IDA7IGkgPCB2aS0+bWF4X3F1ZXVlX3BhaXJzOyBpKyspIHsKPiAtCQlz
dHJ1Y3QgdmlydHF1ZXVlICp2cSA9IHZpLT5zcVtpXS52cTsKPiAtCQl3aGlsZSAoKGJ1ZiA9IHZp
cnRxdWV1ZV9kZXRhY2hfdW51c2VkX2J1Zih2cSkpICE9IE5VTEwpIHsKPiAtCQkJaWYgKCFpc194
ZHBfZnJhbWUoYnVmKSkKPiAtCQkJCWRldl9rZnJlZV9za2IoYnVmKTsKPiAtCQkJZWxzZQo+IC0J
CQkJeGRwX3JldHVybl9mcmFtZShwdHJfdG9feGRwKGJ1ZikpOwo+IC0JCX0KPiArCXdoaWxlICgo
YnVmID0gdmlydHF1ZXVlX2RldGFjaF91bnVzZWRfYnVmKHNxLT52cSkpICE9IE5VTEwpIHsKPiAr
CQlpZiAoIWlzX3hkcF9mcmFtZShidWYpKQo+ICsJCQlkZXZfa2ZyZWVfc2tiKGJ1Zik7Cj4gKwkJ
ZWxzZQo+ICsJCQl4ZHBfcmV0dXJuX2ZyYW1lKHB0cl90b194ZHAoYnVmKSk7Cj4gICAJfQo+ICt9
Cj4gICAKPiAtCWZvciAoaSA9IDA7IGkgPCB2aS0+bWF4X3F1ZXVlX3BhaXJzOyBpKyspIHsKPiAt
CQlzdHJ1Y3QgdmlydHF1ZXVlICp2cSA9IHZpLT5ycVtpXS52cTsKPiAtCj4gLQkJd2hpbGUgKChi
dWYgPSB2aXJ0cXVldWVfZGV0YWNoX3VudXNlZF9idWYodnEpKSAhPSBOVUxMKSB7Cj4gLQkJCWlm
ICh2aS0+bWVyZ2VhYmxlX3J4X2J1ZnMpIHsKPiAtCQkJCXB1dF9wYWdlKHZpcnRfdG9faGVhZF9w
YWdlKGJ1ZikpOwo+IC0JCQl9IGVsc2UgaWYgKHZpLT5iaWdfcGFja2V0cykgewo+IC0JCQkJZ2l2
ZV9wYWdlcygmdmktPnJxW2ldLCBidWYpOwo+IC0JCQl9IGVsc2Ugewo+IC0JCQkJcHV0X3BhZ2Uo
dmlydF90b19oZWFkX3BhZ2UoYnVmKSk7Cj4gLQkJCX0KPiAtCQl9Cj4gK3N0YXRpYyB2b2lkIHZp
cnRuZXRfcnFfZnJlZV91bnVzZWRfYnVmcyhzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwKPiArCQkJ
CQlzdHJ1Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEpCj4gK3sKPiArCXZvaWQgKmJ1ZjsKPiArCj4gKwl3
aGlsZSAoKGJ1ZiA9IHZpcnRxdWV1ZV9kZXRhY2hfdW51c2VkX2J1ZihycS0+dnEpKSAhPSBOVUxM
KSB7Cj4gKwkJaWYgKHZpLT5tZXJnZWFibGVfcnhfYnVmcykKPiArCQkJcHV0X3BhZ2UodmlydF90
b19oZWFkX3BhZ2UoYnVmKSk7Cj4gKwkJZWxzZSBpZiAodmktPmJpZ19wYWNrZXRzKQo+ICsJCQln
aXZlX3BhZ2VzKHJxLCBidWYpOwo+ICsJCWVsc2UKPiArCQkJcHV0X3BhZ2UodmlydF90b19oZWFk
X3BhZ2UoYnVmKSk7Cj4gICAJfQo+ICAgfQo+ICAgCj4gK3N0YXRpYyB2b2lkIGZyZWVfdW51c2Vk
X2J1ZnMoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkpCj4gK3sKPiArCWludCBpOwo+ICsKPiArCWZv
ciAoaSA9IDA7IGkgPCB2aS0+bWF4X3F1ZXVlX3BhaXJzOyBpKyspCj4gKwkJdmlydG5ldF9zcV9m
cmVlX3VudXNlZF9idWZzKHZpLCB2aS0+c3EgKyBpKTsKPiArCj4gKwlmb3IgKGkgPSAwOyBpIDwg
dmktPm1heF9xdWV1ZV9wYWlyczsgaSsrKQo+ICsJCXZpcnRuZXRfcnFfZnJlZV91bnVzZWRfYnVm
cyh2aSwgdmktPnJxICsgaSk7Cj4gK30KPiArCj4gICBzdGF0aWMgdm9pZCB2aXJ0bmV0X2RlbF92
cXMoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkpCj4gICB7Cj4gICAJc3RydWN0IHZpcnRpb19kZXZp
Y2UgKnZkZXYgPSB2aS0+dmRldjsKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LXVtCg==


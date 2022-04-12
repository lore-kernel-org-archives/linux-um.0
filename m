Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1neAo7-00CAVy-9y
 for linux-um@lists.infradead.org; Tue, 12 Apr 2022 07:19:24 +0000
Received: by mail-pj1-f70.google.com with SMTP id
 e12-20020a17090a7c4c00b001cb1b3274c9so1091760pjl.4
 for <linux-um@lists.infradead.org>; Tue, 12 Apr 2022 00:19:20 -0700 (PDT)
Message-ID: <2776b925-1989-40b2-44ed-6964105e22cb@redhat.com>
Date: Tue, 12 Apr 2022 15:19:08 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v9 29/32] virtio_net: get ringparam by
 virtqueue_get_vring_max_size()
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-30-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-30-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzQvNiDkuIrljYgxMTo0MywgWHVhbiBaaHVvIOWGmemBkzoKPiBVc2UgdmlydHF1
ZXVlX2dldF92cmluZ19tYXhfc2l6ZSgpIGluIHZpcnRuZXRfZ2V0X3JpbmdwYXJhbSgpIHRvIHNl
dAo+IHR4LHJ4X21heF9wZW5kaW5nLgo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFu
emh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiAtLS0KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFz
b3dhbmdAcmVkaGF0LmNvbT4KCgo+ICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgOCArKysr
LS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkK
Pgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMKPiBpbmRleCBkYWQ0OTdhNDdiM2EuLjk2ZDk2YzY2NmM4YyAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9f
bmV0LmMKPiBAQCAtMjE3NywxMCArMjE3NywxMCBAQCBzdGF0aWMgdm9pZCB2aXJ0bmV0X2dldF9y
aW5ncGFyYW0oc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPiAgIHsKPiAgIAlzdHJ1Y3QgdmlydG5l
dF9pbmZvICp2aSA9IG5ldGRldl9wcml2KGRldik7Cj4gICAKPiAtCXJpbmctPnJ4X21heF9wZW5k
aW5nID0gdmlydHF1ZXVlX2dldF92cmluZ19zaXplKHZpLT5ycVswXS52cSk7Cj4gLQlyaW5nLT50
eF9tYXhfcGVuZGluZyA9IHZpcnRxdWV1ZV9nZXRfdnJpbmdfc2l6ZSh2aS0+c3FbMF0udnEpOwo+
IC0JcmluZy0+cnhfcGVuZGluZyA9IHJpbmctPnJ4X21heF9wZW5kaW5nOwo+IC0JcmluZy0+dHhf
cGVuZGluZyA9IHJpbmctPnR4X21heF9wZW5kaW5nOwo+ICsJcmluZy0+cnhfbWF4X3BlbmRpbmcg
PSB2aXJ0cXVldWVfZ2V0X3ZyaW5nX21heF9zaXplKHZpLT5ycVswXS52cSk7Cj4gKwlyaW5nLT50
eF9tYXhfcGVuZGluZyA9IHZpcnRxdWV1ZV9nZXRfdnJpbmdfbWF4X3NpemUodmktPnNxWzBdLnZx
KTsKPiArCXJpbmctPnJ4X3BlbmRpbmcgPSB2aXJ0cXVldWVfZ2V0X3ZyaW5nX3NpemUodmktPnJx
WzBdLnZxKTsKPiArCXJpbmctPnR4X3BlbmRpbmcgPSB2aXJ0cXVldWVfZ2V0X3ZyaW5nX3NpemUo
dmktPnNxWzBdLnZxKTsKPiAgIH0KPiAgIAo+ICAgCgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC11bQo=


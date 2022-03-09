Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRsFE-007pti-7i
 for linux-um@lists.infradead.org; Wed, 09 Mar 2022 09:04:33 +0000
Received: by mail-pj1-f69.google.com with SMTP id
 e7-20020a17090a4a0700b001bc5a8c533eso1207184pjh.4
 for <linux-um@lists.infradead.org>; Wed, 09 Mar 2022 01:04:29 -0800 (PST)
Message-ID: <f1fb522d-74ce-a642-7768-deaad76aeddc@redhat.com>
Date: Wed, 9 Mar 2022 17:04:12 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v7 21/26] virtio: add helper virtio_find_vqs_ctx_size()
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-22-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220308123518.33800-22-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzMvOCDkuIvljYg4OjM1LCBYdWFuIFpodW8g5YaZ6YGTOgo+IEludHJvZHVjZSBo
ZWxwZXIgdmlydGlvX2ZpbmRfdnFzX2N0eF9zaXplKCkgdG8gY2FsbCBmaW5kX3ZxcyBhbmQgc3Bl
Y2lmeQo+IHRoZSBtYXhpbXVtIHNpemUgb2YgZWFjaCB2cSByaW5nLgo+Cj4gU2lnbmVkLW9mZi1i
eTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiAtLS0KPiAgIGluY2x1
ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oIHwgMTIgKysrKysrKysrKysrCj4gICAxIGZpbGUgY2hh
bmdlZCwgMTIgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmly
dGlvX2NvbmZpZy5oIGIvaW5jbHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmgKPiBpbmRleCA1MTU3
NTI0ZDgwMzYuLjkyMWQ4NjEwZGIwYyAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZpcnRp
b19jb25maWcuaAo+ICsrKyBiL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oCj4gQEAgLTIz
Myw2ICsyMzMsMTggQEAgaW50IHZpcnRpb19maW5kX3Zxc19jdHgoc3RydWN0IHZpcnRpb19kZXZp
Y2UgKnZkZXYsIHVuc2lnbmVkIG52cXMsCj4gICAJCQkJICAgICAgZGVzYywgTlVMTCk7Cj4gICB9
Cj4gICAKPiArc3RhdGljIGlubGluZQo+ICtpbnQgdmlydGlvX2ZpbmRfdnFzX2N0eF9zaXplKHN0
cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LCB1MzIgbnZxcywKPiArCQkJCSBzdHJ1Y3QgdmlydHF1
ZXVlICp2cXNbXSwKPiArCQkJCSB2cV9jYWxsYmFja190ICpjYWxsYmFja3NbXSwKPiArCQkJCSBj
b25zdCBjaGFyICogY29uc3QgbmFtZXNbXSwKPiArCQkJCSBjb25zdCBib29sICpjdHgsIHN0cnVj
dCBpcnFfYWZmaW5pdHkgKmRlc2MsCj4gKwkJCQkgdTMyIHNpemVzW10pCj4gK3sKPiArCXJldHVy
biB2ZGV2LT5jb25maWctPmZpbmRfdnFzKHZkZXYsIG52cXMsIHZxcywgY2FsbGJhY2tzLCBuYW1l
cywgY3R4LAo+ICsJCQkJICAgICAgZGVzYywgc2l6ZXMpOwo+ICt9CgoKRG8gd2UgbmVlZCB0byBj
b252ZXJ0IGFsbCB0aGUgb3BlbiBjb2RlZCBkaXJlY3QgY2FsbCB0byBmaW5kX3ZxcygpIG90aGVy
IAp0aGFuIG5ldD8KClRoYW5rcwoKCj4gKwo+ICAgLyoqCj4gICAgKiB2aXJ0aW9fcmVzZXRfdnEg
LSByZXNldCBhIHF1ZXVlIGluZGl2aWR1YWxseQo+ICAgICogQHZxOiB0aGUgdmlydHF1ZXVlCgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0g
bWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=


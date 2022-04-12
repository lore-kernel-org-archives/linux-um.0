Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ne6bO-00BLCq-Rv
 for linux-um@lists.infradead.org; Tue, 12 Apr 2022 02:50:00 +0000
Received: by mail-pg1-f200.google.com with SMTP id
 b18-20020a63d812000000b0037e1aa59c0bso9805292pgh.12
 for <linux-um@lists.infradead.org>; Mon, 11 Apr 2022 19:49:56 -0700 (PDT)
Message-ID: <f57f8da3-38a6-91a5-05bb-9435a21880d7@redhat.com>
Date: Tue, 12 Apr 2022 10:49:44 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v9 03/32] virtio_ring: update the document of the
 virtqueue_detach_unused_buf for queue reset
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-4-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzQvNiDkuIrljYgxMTo0MywgWHVhbiBaaHVvIOWGmemBkzoKPiBBZGRlZCBkb2N1
bWVudGF0aW9uIGZvciB2aXJ0cXVldWVfZGV0YWNoX3VudXNlZF9idWYsIGFsbG93aW5nIGl0IHRv
IGJlCj4gY2FsbGVkIG9uIHF1ZXVlIHJlc2V0Lgo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVv
IDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFz
b3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jpbmcu
YyB8IDQgKystLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJp
dmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IGluZGV4IGI4NzEzMGM4ZjMxMi4uZjE4MDdmNmIw
NmE1IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiArKysgYi9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gQEAgLTIxMjcsOCArMjEyNyw4IEBAIEVYUE9S
VF9TWU1CT0xfR1BMKHZpcnRxdWV1ZV9lbmFibGVfY2JfZGVsYXllZCk7Cj4gICAgKiBAX3ZxOiB0
aGUgc3RydWN0IHZpcnRxdWV1ZSB3ZSdyZSB0YWxraW5nIGFib3V0Lgo+ICAgICoKPiAgICAqIFJl
dHVybnMgTlVMTCBvciB0aGUgImRhdGEiIHRva2VuIGhhbmRlZCB0byB2aXJ0cXVldWVfYWRkXyoo
KS4KPiAtICogVGhpcyBpcyBub3QgdmFsaWQgb24gYW4gYWN0aXZlIHF1ZXVlOyBpdCBpcyB1c2Vm
dWwgb25seSBmb3IgZGV2aWNlCj4gLSAqIHNodXRkb3duLgo+ICsgKiBUaGlzIGlzIG5vdCB2YWxp
ZCBvbiBhbiBhY3RpdmUgcXVldWU7IGl0IGlzIHVzZWZ1bCBmb3IgZGV2aWNlCj4gKyAqIHNodXRk
b3duIG9yIHRoZSByZXNldCBxdWV1ZS4KPiAgICAqLwo+ICAgdm9pZCAqdmlydHF1ZXVlX2RldGFj
aF91bnVzZWRfYnVmKHN0cnVjdCB2aXJ0cXVldWUgKl92cSkKPiAgIHsKCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QK
bGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==


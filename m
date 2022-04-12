Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ne6jl-00BNFj-AD
 for linux-um@lists.infradead.org; Tue, 12 Apr 2022 02:58:38 +0000
Received: by mail-pl1-f198.google.com with SMTP id
 l6-20020a170903120600b0014f43ba55f3so7102198plh.11
 for <linux-um@lists.infradead.org>; Mon, 11 Apr 2022 19:58:26 -0700 (PDT)
Message-ID: <14b0c4ea-038a-8688-7ca0-4ea0ef407aba@redhat.com>
Date: Tue, 12 Apr 2022 10:58:09 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v9 05/32] virtio_ring: extract the logic of freeing vring
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-6-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-6-xuanzhuo@linux.alibaba.com>
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
dnJpbmdfZnJlZSgpIHRvIGZyZWUgdGhlIHZyaW5nIG9mIHZxLgo+Cj4gU3Vic2VxdWVudCBwYXRj
aGVzIHdpbGwgdXNlIHZyaW5nX2ZyZWUoKSBhbG9uZS4KPgo+IFNpZ25lZC1vZmYtYnk6IFh1YW4g
Wmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+CgoKQWNrZWQtYnk6IEphc29uIFdhbmcg
PGphc293YW5nQHJlZGhhdC5jb20+CgoKPiAtLS0KPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19y
aW5nLmMgfCAxOCArKysrKysrKysrKysrLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNl
cnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlv
L3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gaW5kZXggY2I2
MDEwNzUwYTk0Li4zM2ZkZGZiOTA3YTYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmly
dGlvX3JpbmcuYwo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBAQCAtMjMw
MSwxNCArMjMwMSwxMCBAQCBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19uZXdfdmlydHF1ZXVlKHVu
c2lnbmVkIGludCBpbmRleCwKPiAgIH0KPiAgIEVYUE9SVF9TWU1CT0xfR1BMKHZyaW5nX25ld192
aXJ0cXVldWUpOwo+ICAgCj4gLXZvaWQgdnJpbmdfZGVsX3ZpcnRxdWV1ZShzdHJ1Y3QgdmlydHF1
ZXVlICpfdnEpCj4gK3N0YXRpYyB2b2lkIHZyaW5nX2ZyZWUoc3RydWN0IHZpcnRxdWV1ZSAqX3Zx
KQo+ICAgewo+ICAgCXN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxID0gdG9fdnZxKF92cSk7Cj4g
ICAKPiAtCXNwaW5fbG9jaygmdnEtPnZxLnZkZXYtPnZxc19saXN0X2xvY2spOwo+IC0JbGlzdF9k
ZWwoJl92cS0+bGlzdCk7Cj4gLQlzcGluX3VubG9jaygmdnEtPnZxLnZkZXYtPnZxc19saXN0X2xv
Y2spOwo+IC0KPiAgIAlpZiAodnEtPndlX293bl9yaW5nKSB7Cj4gICAJCWlmICh2cS0+cGFja2Vk
X3JpbmcpIHsKPiAgIAkJCXZyaW5nX2ZyZWVfcXVldWUodnEtPnZxLnZkZXYsCj4gQEAgLTIzMzks
NiArMjMzNSwxOCBAQCB2b2lkIHZyaW5nX2RlbF92aXJ0cXVldWUoc3RydWN0IHZpcnRxdWV1ZSAq
X3ZxKQo+ICAgCQlrZnJlZSh2cS0+c3BsaXQuZGVzY19zdGF0ZSk7Cj4gICAJCWtmcmVlKHZxLT5z
cGxpdC5kZXNjX2V4dHJhKTsKPiAgIAl9Cj4gK30KPiArCj4gK3ZvaWQgdnJpbmdfZGVsX3ZpcnRx
dWV1ZShzdHJ1Y3QgdmlydHF1ZXVlICpfdnEpCj4gK3sKPiArCXN0cnVjdCB2cmluZ192aXJ0cXVl
dWUgKnZxID0gdG9fdnZxKF92cSk7Cj4gKwo+ICsJc3Bpbl9sb2NrKCZ2cS0+dnEudmRldi0+dnFz
X2xpc3RfbG9jayk7Cj4gKwlsaXN0X2RlbCgmX3ZxLT5saXN0KTsKPiArCXNwaW5fdW5sb2NrKCZ2
cS0+dnEudmRldi0+dnFzX2xpc3RfbG9jayk7Cj4gKwo+ICsJdnJpbmdfZnJlZShfdnEpOwo+ICsK
PiAgIAlrZnJlZSh2cSk7Cj4gICB9Cj4gICBFWFBPUlRfU1lNQk9MX0dQTCh2cmluZ19kZWxfdmly
dHF1ZXVlKTsKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==


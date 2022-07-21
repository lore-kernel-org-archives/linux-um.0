Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEQIt-001UgJ-2m
	for linux-um@lists.infradead.org; Thu, 21 Jul 2022 07:09:00 +0000
Received: by mail-pl1-f197.google.com with SMTP id b10-20020a170902d50a00b0016c56d1f90fso696595plg.21
        for <linux-um@lists.infradead.org>; Thu, 21 Jul 2022 00:08:56 -0700 (PDT)
Message-ID: <a8a9fd2e-a1e3-ad68-c085-322ec002a4d5@redhat.com>
Date: Thu, 21 Jul 2022 15:08:44 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v12 07/40] virtio_ring: split: introduce
 vring_free_split()
References: <20220720030436.79520-1-xuanzhuo@linux.alibaba.com>
 <20220720030436.79520-8-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220720030436.79520-8-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzcvMjAgMTE6MDQsIFh1YW4gWmh1byDlhpnpgZM6Cj4gRnJlZSB0aGUgc3RydWN0
dXJlIHN0cnVjdCB2cmluZ192cml0cXVldWVfc3BsaXQuCj4KPiBTdWJzZXF1ZW50IHBhdGNoZXMg
cmVxdWlyZSBpdC4KPgo+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXgu
YWxpYmFiYS5jb20+CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+
CgoKPiAtLS0KPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCAxMSArKysrKysrKysr
Kwo+ICAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jpbmcu
Ywo+IGluZGV4IDg3Y2UxNzU2MmIyOS4uYzk0YzU0NjFlNzAyIDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmlu
Zy5jCj4gQEAgLTkzOSw2ICs5MzksMTcgQEAgc3RhdGljIHZvaWQgKnZpcnRxdWV1ZV9kZXRhY2hf
dW51c2VkX2J1Zl9zcGxpdChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEpCj4gICAJcmV0dXJuIE5VTEw7
Cj4gICB9Cj4gICAKPiArc3RhdGljIHZvaWQgdnJpbmdfZnJlZV9zcGxpdChzdHJ1Y3QgdnJpbmdf
dmlydHF1ZXVlX3NwbGl0ICp2cmluZ19zcGxpdCwKPiArCQkJICAgICBzdHJ1Y3QgdmlydGlvX2Rl
dmljZSAqdmRldikKPiArewo+ICsJdnJpbmdfZnJlZV9xdWV1ZSh2ZGV2LCB2cmluZ19zcGxpdC0+
cXVldWVfc2l6ZV9pbl9ieXRlcywKPiArCQkJIHZyaW5nX3NwbGl0LT52cmluZy5kZXNjLAo+ICsJ
CQkgdnJpbmdfc3BsaXQtPnF1ZXVlX2RtYV9hZGRyKTsKPiArCj4gKwlrZnJlZSh2cmluZ19zcGxp
dC0+ZGVzY19zdGF0ZSk7Cj4gKwlrZnJlZSh2cmluZ19zcGxpdC0+ZGVzY19leHRyYSk7Cj4gK30K
PiArCj4gICBzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqdnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZV9z
cGxpdCgKPiAgIAl1bnNpZ25lZCBpbnQgaW5kZXgsCj4gICAJdW5zaWduZWQgaW50IG51bSwKCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBt
YWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==


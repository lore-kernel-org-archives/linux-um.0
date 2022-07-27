Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGYbB-008om6-CM
	for linux-um@lists.infradead.org; Wed, 27 Jul 2022 04:24:42 +0000
Received: by mail-pg1-f200.google.com with SMTP id d66-20020a636845000000b0040a88edd9c1so7313241pgc.13
        for <linux-um@lists.infradead.org>; Tue, 26 Jul 2022 21:24:36 -0700 (PDT)
Message-ID: <113b77e4-ccc5-7a92-60db-26c25c184e20@redhat.com>
Date: Wed, 27 Jul 2022 12:24:21 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v13 17/42] virtio_ring: packed: introduce
 vring_free_packed
References: <20220726072225.19884-1-xuanzhuo@linux.alibaba.com>
 <20220726072225.19884-18-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220726072225.19884-18-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzcvMjYgMTU6MjIsIFh1YW4gWmh1byDlhpnpgZM6Cj4gRnJlZSB0aGUgc3RydWN0
dXJlIHN0cnVjdCB2cmluZ192cml0cXVldWVfcGFja2VkLgo+Cj4gU3Vic2VxdWVudCBwYXRjaGVz
IHJlcXVpcmUgaXQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPgoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29t
PgoKCj4gLS0tCj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgMjIgKysrKysrKysr
KysrKysrKysrKysrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKykKPgo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8v
dmlydGlvX3JpbmcuYwo+IGluZGV4IDU4MzU1ZTFhYzdkNy4uODkxOTAwYjMxYzNkIDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiArKysgYi9kcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcmluZy5jCj4gQEAgLTE4MzUsNiArMTgzNSwyOCBAQCBzdGF0aWMgc3RydWN0IHZy
aW5nX2Rlc2NfZXh0cmEgKnZyaW5nX2FsbG9jX2Rlc2NfZXh0cmEodW5zaWduZWQgaW50IG51bSkK
PiAgIAlyZXR1cm4gZGVzY19leHRyYTsKPiAgIH0KPiAgIAo+ICtzdGF0aWMgdm9pZCB2cmluZ19m
cmVlX3BhY2tlZChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlX3BhY2tlZCAqdnJpbmdfcGFja2VkLAo+
ICsJCQkgICAgICBzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPiArewo+ICsJaWYgKHZyaW5n
X3BhY2tlZC0+dnJpbmcuZGVzYykKPiArCQl2cmluZ19mcmVlX3F1ZXVlKHZkZXYsIHZyaW5nX3Bh
Y2tlZC0+cmluZ19zaXplX2luX2J5dGVzLAo+ICsJCQkJIHZyaW5nX3BhY2tlZC0+dnJpbmcuZGVz
YywKPiArCQkJCSB2cmluZ19wYWNrZWQtPnJpbmdfZG1hX2FkZHIpOwo+ICsKPiArCWlmICh2cmlu
Z19wYWNrZWQtPnZyaW5nLmRyaXZlcikKPiArCQl2cmluZ19mcmVlX3F1ZXVlKHZkZXYsIHZyaW5n
X3BhY2tlZC0+ZXZlbnRfc2l6ZV9pbl9ieXRlcywKPiArCQkJCSB2cmluZ19wYWNrZWQtPnZyaW5n
LmRyaXZlciwKPiArCQkJCSB2cmluZ19wYWNrZWQtPmRyaXZlcl9ldmVudF9kbWFfYWRkcik7Cj4g
Kwo+ICsJaWYgKHZyaW5nX3BhY2tlZC0+dnJpbmcuZGV2aWNlKQo+ICsJCXZyaW5nX2ZyZWVfcXVl
dWUodmRldiwgdnJpbmdfcGFja2VkLT5ldmVudF9zaXplX2luX2J5dGVzLAo+ICsJCQkJIHZyaW5n
X3BhY2tlZC0+dnJpbmcuZGV2aWNlLAo+ICsJCQkJIHZyaW5nX3BhY2tlZC0+ZGV2aWNlX2V2ZW50
X2RtYV9hZGRyKTsKPiArCj4gKwlrZnJlZSh2cmluZ19wYWNrZWQtPmRlc2Nfc3RhdGUpOwo+ICsJ
a2ZyZWUodnJpbmdfcGFja2VkLT5kZXNjX2V4dHJhKTsKPiArfQo+ICsKPiAgIHN0YXRpYyBzdHJ1
Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVlX3BhY2tlZCgKPiAgIAl1bnNpZ25l
ZCBpbnQgaW5kZXgsCj4gICAJdW5zaWduZWQgaW50IG51bSwKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgt
dW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LXVtCg==


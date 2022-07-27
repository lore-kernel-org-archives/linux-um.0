Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGYlg-008uFh-F9
	for linux-um@lists.infradead.org; Wed, 27 Jul 2022 04:35:33 +0000
Received: by mail-pf1-f200.google.com with SMTP id cu3-20020a056a00448300b0052ae559108fso5451780pfb.9
        for <linux-um@lists.infradead.org>; Tue, 26 Jul 2022 21:35:29 -0700 (PDT)
Message-ID: <7b33b166-785f-ef8a-153f-e0b1c3b7e23d@redhat.com>
Date: Wed, 27 Jul 2022 12:35:12 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v13 22/42] virtio_ring: packed: introduce
 virtqueue_reinit_packed()
References: <20220726072225.19884-1-xuanzhuo@linux.alibaba.com>
 <20220726072225.19884-23-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220726072225.19884-23-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzcvMjYgMTU6MjIsIFh1YW4gWmh1byDlhpnpgZM6Cj4gSW50cm9kdWNlIGEgZnVu
Y3Rpb24gdG8gaW5pdGlhbGl6ZSB2cSB3aXRob3V0IGFsbG9jYXRpbmcgbmV3IHJpbmcsCj4gZGVz
Y19zdGF0ZSwgZGVzY19leHRyYS4KPgo+IFN1YnNlcXVlbnQgcGF0Y2hlcyB3aWxsIGNhbGwgdGhp
cyBmdW5jdGlvbiBhZnRlciByZXNldCB2cSB0bwo+IHJlaW5pdGlhbGl6ZSB2cS4KPgo+IFNpZ25l
ZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+CgoKQWNrZWQt
Ynk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKPiAtLS0KPiAgIGRyaXZlcnMv
dmlydGlvL3ZpcnRpb19yaW5nLmMgfCAyMSArKysrKysrKysrKysrKysrKysrKysKPiAgIDEgZmls
ZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0
aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBpbmRleCAw
MGIxOGNmM2I0ZDkuLjdkNGM0NDRiNWE5ZCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92
aXJ0aW9fcmluZy5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IEBAIC0x
OTU3LDYgKzE5NTcsMjcgQEAgc3RhdGljIHZvaWQgdmlydHF1ZXVlX3ZyaW5nX2F0dGFjaF9wYWNr
ZWQoc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEsCj4gICAJdnEtPnBhY2tlZCA9ICp2cmluZ19w
YWNrZWQ7Cj4gICB9Cj4gICAKPiArc3RhdGljIHZvaWQgdmlydHF1ZXVlX3JlaW5pdF9wYWNrZWQo
c3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEpCj4gK3sKPiArCWludCBzaXplLCBpOwo+ICsKPiAr
CW1lbXNldCh2cS0+cGFja2VkLnZyaW5nLmRldmljZSwgMCwgdnEtPnBhY2tlZC5ldmVudF9zaXpl
X2luX2J5dGVzKTsKPiArCW1lbXNldCh2cS0+cGFja2VkLnZyaW5nLmRyaXZlciwgMCwgdnEtPnBh
Y2tlZC5ldmVudF9zaXplX2luX2J5dGVzKTsKPiArCW1lbXNldCh2cS0+cGFja2VkLnZyaW5nLmRl
c2MsIDAsIHZxLT5wYWNrZWQucmluZ19zaXplX2luX2J5dGVzKTsKPiArCj4gKwlzaXplID0gc2l6
ZW9mKHN0cnVjdCB2cmluZ19kZXNjX3N0YXRlX3BhY2tlZCkgKiB2cS0+cGFja2VkLnZyaW5nLm51
bTsKPiArCW1lbXNldCh2cS0+cGFja2VkLmRlc2Nfc3RhdGUsIDAsIHNpemUpOwo+ICsKPiArCXNp
emUgPSBzaXplb2Yoc3RydWN0IHZyaW5nX2Rlc2NfZXh0cmEpICogdnEtPnBhY2tlZC52cmluZy5u
dW07Cj4gKwltZW1zZXQodnEtPnBhY2tlZC5kZXNjX2V4dHJhLCAwLCBzaXplKTsKPiArCj4gKwlm
b3IgKGkgPSAwOyBpIDwgdnEtPnBhY2tlZC52cmluZy5udW0gLSAxOyBpKyspCj4gKwkJdnEtPnBh
Y2tlZC5kZXNjX2V4dHJhW2ldLm5leHQgPSBpICsgMTsKPiArCj4gKwl2aXJ0cXVldWVfaW5pdCh2
cSwgdnEtPnBhY2tlZC52cmluZy5udW0pOwo+ICsJdmlydHF1ZXVlX3ZyaW5nX2luaXRfcGFja2Vk
KCZ2cS0+cGFja2VkLCAhIXZxLT52cS5jYWxsYmFjayk7Cj4gK30KPiArCj4gICBzdGF0aWMgc3Ry
dWN0IHZpcnRxdWV1ZSAqdnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZV9wYWNrZWQoCj4gICAJdW5zaWdu
ZWQgaW50IGluZGV4LAo+ICAgCXVuc2lnbmVkIGludCBudW0sCgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4
LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC11bQo=


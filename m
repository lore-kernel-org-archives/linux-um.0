Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGYjk-008t8j-EL
	for linux-um@lists.infradead.org; Wed, 27 Jul 2022 04:33:33 +0000
Received: by mail-pj1-f70.google.com with SMTP id o6-20020a17090aac0600b001f23d8bfe2bso541168pjq.7
        for <linux-um@lists.infradead.org>; Tue, 26 Jul 2022 21:33:19 -0700 (PDT)
Message-ID: <d290e282-1a9d-b339-73e6-c66740f00b89@redhat.com>
Date: Wed, 27 Jul 2022 12:33:03 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v13 19/42] virtio_ring: packed: extract the logic of alloc
 state and extra
References: <20220726072225.19884-1-xuanzhuo@linux.alibaba.com>
 <20220726072225.19884-20-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220726072225.19884-20-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzcvMjYgMTU6MjIsIFh1YW4gWmh1byDlhpnpgZM6Cj4gU2VwYXJhdGUgdGhlIGxv
Z2ljIGZvciBhbGxvYyBkZXNjX3N0YXRlIGFuZCBkZXNjX2V4dHJhLCB3aGljaCB3aWxsCj4gYmUg
Y2FsbGVkIHNlcGFyYXRlbHkgYnkgc3Vic2VxdWVudCBwYXRjaGVzLgo+Cj4gVXNlIHN0cnVjdCB2
cmluZ19wYWNrZWQgdG8gcGFzcyBkZXNjX3N0YXRlLCBkZXNjX2V4dHJhLgo+Cj4gU2lnbmVkLW9m
Zi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KCgpBY2tlZC1ieTog
SmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+ICAgZHJpdmVycy92aXJ0
aW8vdmlydGlvX3JpbmcuYyB8IDQ4ICsrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0t
LQo+ICAgMSBmaWxlIGNoYW5nZWQsIDM0IGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQo+
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3Zp
cnRpby92aXJ0aW9fcmluZy5jCj4gaW5kZXggMTBjYzJiN2UzNTg4Li4zMjU5MGQ3NjNjM2IgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ICsrKyBiL2RyaXZlcnMv
dmlydGlvL3ZpcnRpb19yaW5nLmMKPiBAQCAtMTkwOCw2ICsxOTA4LDMzIEBAIHN0YXRpYyBpbnQg
dnJpbmdfYWxsb2NfcXVldWVfcGFja2VkKHN0cnVjdCB2cmluZ192aXJ0cXVldWVfcGFja2VkICp2
cmluZ19wYWNrZWQsCj4gICAJcmV0dXJuIC1FTk9NRU07Cj4gICB9Cj4gICAKPiArc3RhdGljIGlu
dCB2cmluZ19hbGxvY19zdGF0ZV9leHRyYV9wYWNrZWQoc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZV9w
YWNrZWQgKnZyaW5nX3BhY2tlZCkKPiArewo+ICsJc3RydWN0IHZyaW5nX2Rlc2Nfc3RhdGVfcGFj
a2VkICpzdGF0ZTsKPiArCXN0cnVjdCB2cmluZ19kZXNjX2V4dHJhICpleHRyYTsKPiArCXUzMiBu
dW0gPSB2cmluZ19wYWNrZWQtPnZyaW5nLm51bTsKPiArCj4gKwlzdGF0ZSA9IGttYWxsb2NfYXJy
YXkobnVtLCBzaXplb2Yoc3RydWN0IHZyaW5nX2Rlc2Nfc3RhdGVfcGFja2VkKSwgR0ZQX0tFUk5F
TCk7Cj4gKwlpZiAoIXN0YXRlKQo+ICsJCWdvdG8gZXJyX2Rlc2Nfc3RhdGU7Cj4gKwo+ICsJbWVt
c2V0KHN0YXRlLCAwLCBudW0gKiBzaXplb2Yoc3RydWN0IHZyaW5nX2Rlc2Nfc3RhdGVfcGFja2Vk
KSk7Cj4gKwo+ICsJZXh0cmEgPSB2cmluZ19hbGxvY19kZXNjX2V4dHJhKG51bSk7Cj4gKwlpZiAo
IWV4dHJhKQo+ICsJCWdvdG8gZXJyX2Rlc2NfZXh0cmE7Cj4gKwo+ICsJdnJpbmdfcGFja2VkLT5k
ZXNjX3N0YXRlID0gc3RhdGU7Cj4gKwl2cmluZ19wYWNrZWQtPmRlc2NfZXh0cmEgPSBleHRyYTsK
PiArCj4gKwlyZXR1cm4gMDsKPiArCj4gK2Vycl9kZXNjX2V4dHJhOgo+ICsJa2ZyZWUoc3RhdGUp
Owo+ICtlcnJfZGVzY19zdGF0ZToKPiArCXJldHVybiAtRU5PTUVNOwo+ICt9Cj4gKwo+ICAgc3Rh
dGljIHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5nX2NyZWF0ZV92aXJ0cXVldWVfcGFja2VkKAo+ICAg
CXVuc2lnbmVkIGludCBpbmRleCwKPiAgIAl1bnNpZ25lZCBpbnQgbnVtLAo+IEBAIC0xOTIyLDYg
KzE5NDksNyBAQCBzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqdnJpbmdfY3JlYXRlX3ZpcnRxdWV1
ZV9wYWNrZWQoCj4gICB7Cj4gICAJc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZV9wYWNrZWQgdnJpbmdf
cGFja2VkID0ge307Cj4gICAJc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnE7Cj4gKwlpbnQgZXJy
Owo+ICAgCj4gICAJaWYgKHZyaW5nX2FsbG9jX3F1ZXVlX3BhY2tlZCgmdnJpbmdfcGFja2VkLCB2
ZGV2LCBudW0pKQo+ICAgCQlnb3RvIGVycl9yaW5nOwo+IEBAIC0xOTYxLDE4ICsxOTg5LDEyIEBA
IHN0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVlX3BhY2tlZCgK
PiAgIAl2cS0+cGFja2VkLmV2ZW50X2ZsYWdzX3NoYWRvdyA9IDA7Cj4gICAJdnEtPnBhY2tlZC5h
dmFpbF91c2VkX2ZsYWdzID0gMSA8PCBWUklOR19QQUNLRURfREVTQ19GX0FWQUlMOwo+ICAgCj4g
LQl2cS0+cGFja2VkLmRlc2Nfc3RhdGUgPSBrbWFsbG9jX2FycmF5KG51bSwKPiAtCQkJc2l6ZW9m
KHN0cnVjdCB2cmluZ19kZXNjX3N0YXRlX3BhY2tlZCksCj4gLQkJCUdGUF9LRVJORUwpOwo+IC0J
aWYgKCF2cS0+cGFja2VkLmRlc2Nfc3RhdGUpCj4gLQkJZ290byBlcnJfZGVzY19zdGF0ZTsKPiAt
Cj4gLQltZW1zZXQodnEtPnBhY2tlZC5kZXNjX3N0YXRlLCAwLAo+IC0JCW51bSAqIHNpemVvZihz
dHJ1Y3QgdnJpbmdfZGVzY19zdGF0ZV9wYWNrZWQpKTsKPiArCWVyciA9IHZyaW5nX2FsbG9jX3N0
YXRlX2V4dHJhX3BhY2tlZCgmdnJpbmdfcGFja2VkKTsKPiArCWlmIChlcnIpCj4gKwkJZ290byBl
cnJfc3RhdGVfZXh0cmE7Cj4gICAKPiAtCXZxLT5wYWNrZWQuZGVzY19leHRyYSA9IHZyaW5nX2Fs
bG9jX2Rlc2NfZXh0cmEobnVtKTsKPiAtCWlmICghdnEtPnBhY2tlZC5kZXNjX2V4dHJhKQo+IC0J
CWdvdG8gZXJyX2Rlc2NfZXh0cmE7Cj4gKwl2cS0+cGFja2VkLmRlc2Nfc3RhdGUgPSB2cmluZ19w
YWNrZWQuZGVzY19zdGF0ZTsKPiArCXZxLT5wYWNrZWQuZGVzY19leHRyYSA9IHZyaW5nX3BhY2tl
ZC5kZXNjX2V4dHJhOwo+ICAgCj4gICAJLyogTm8gY2FsbGJhY2s/ICBUZWxsIG90aGVyIHNpZGUg
bm90IHRvIGJvdGhlciB1cy4gKi8KPiAgIAlpZiAoIWNhbGxiYWNrKSB7Cj4gQEAgLTE5ODgsOSAr
MjAxMCw3IEBAIHN0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVl
X3BhY2tlZCgKPiAgIAlzcGluX3VubG9jaygmdmRldi0+dnFzX2xpc3RfbG9jayk7Cj4gICAJcmV0
dXJuICZ2cS0+dnE7Cj4gICAKPiAtZXJyX2Rlc2NfZXh0cmE6Cj4gLQlrZnJlZSh2cS0+cGFja2Vk
LmRlc2Nfc3RhdGUpOwo+IC1lcnJfZGVzY19zdGF0ZToKPiArZXJyX3N0YXRlX2V4dHJhOgo+ICAg
CWtmcmVlKHZxKTsKPiAgIGVycl92cToKPiAgIAl2cmluZ19mcmVlX3BhY2tlZCgmdnJpbmdfcGFj
a2VkLCB2ZGV2KTsKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==


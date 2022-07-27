Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGYkK-008tX5-9A
	for linux-um@lists.infradead.org; Wed, 27 Jul 2022 04:34:09 +0000
Received: by mail-pg1-f199.google.com with SMTP id u11-20020a654c0b000000b00415ed4acf16so7361279pgq.22
        for <linux-um@lists.infradead.org>; Tue, 26 Jul 2022 21:34:06 -0700 (PDT)
Message-ID: <11a17272-7318-0217-7e45-83a3b237ed7f@redhat.com>
Date: Wed, 27 Jul 2022 12:33:46 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v13 20/42] virtio_ring: packed: extract the logic of vring
 init
References: <20220726072225.19884-1-xuanzhuo@linux.alibaba.com>
 <20220726072225.19884-21-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220726072225.19884-21-xuanzhuo@linux.alibaba.com>
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
Z2ljIG9mIGluaXRpYWxpemluZyB2cmluZywgYW5kIHN1YnNlcXVlbnQgcGF0Y2hlcyB3aWxsCj4g
Y2FsbCBpdCBzZXBhcmF0ZWx5Lgo+Cj4gVGhpcyBmdW5jdGlvbiBjb21wbGV0ZXMgdGhlIHZhcmlh
YmxlIGluaXRpYWxpemF0aW9uIG9mIHBhY2tlZCB2cmluZy4gSXQKPiB0b2dldGhlciB3aXRoIHRo
ZSBsb2dpYyBvZiBhdGF0Y2ggY29uc3RpdHV0ZXMgdGhlIGluaXRpYWxpemF0aW9uIG9mCj4gdnJp
bmcuCj4KPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEu
Y29tPgoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKCj4gLS0t
Cj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgMjggKysrKysrKysrKysrKysrKyst
LS0tLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDExIGRlbGV0
aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gaW5kZXggMzI1OTBkNzYzYzNiLi5mYzRlM2Ri
OWY5M2IgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ICsrKyBi
L2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBAQCAtMTkzNSw2ICsxOTM1LDIyIEBAIHN0
YXRpYyBpbnQgdnJpbmdfYWxsb2Nfc3RhdGVfZXh0cmFfcGFja2VkKHN0cnVjdCB2cmluZ192aXJ0
cXVldWVfcGFja2VkICp2cmluZ19wCj4gICAJcmV0dXJuIC1FTk9NRU07Cj4gICB9Cj4gICAKPiAr
c3RhdGljIHZvaWQgdmlydHF1ZXVlX3ZyaW5nX2luaXRfcGFja2VkKHN0cnVjdCB2cmluZ192aXJ0
cXVldWVfcGFja2VkICp2cmluZ19wYWNrZWQsCj4gKwkJCQkJYm9vbCBjYWxsYmFjaykKPiArewo+
ICsJdnJpbmdfcGFja2VkLT5uZXh0X2F2YWlsX2lkeCA9IDA7Cj4gKwl2cmluZ19wYWNrZWQtPmF2
YWlsX3dyYXBfY291bnRlciA9IDE7Cj4gKwl2cmluZ19wYWNrZWQtPmV2ZW50X2ZsYWdzX3NoYWRv
dyA9IDA7Cj4gKwl2cmluZ19wYWNrZWQtPmF2YWlsX3VzZWRfZmxhZ3MgPSAxIDw8IFZSSU5HX1BB
Q0tFRF9ERVNDX0ZfQVZBSUw7Cj4gKwo+ICsJLyogTm8gY2FsbGJhY2s/ICBUZWxsIG90aGVyIHNp
ZGUgbm90IHRvIGJvdGhlciB1cy4gKi8KPiArCWlmICghY2FsbGJhY2spIHsKPiArCQl2cmluZ19w
YWNrZWQtPmV2ZW50X2ZsYWdzX3NoYWRvdyA9IFZSSU5HX1BBQ0tFRF9FVkVOVF9GTEFHX0RJU0FC
TEU7Cj4gKwkJdnJpbmdfcGFja2VkLT52cmluZy5kcml2ZXItPmZsYWdzID0KPiArCQkJY3B1X3Rv
X2xlMTYodnJpbmdfcGFja2VkLT5ldmVudF9mbGFnc19zaGFkb3cpOwo+ICsJfQo+ICt9Cj4gKwo+
ICAgc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5nX2NyZWF0ZV92aXJ0cXVldWVfcGFja2Vk
KAo+ICAgCXVuc2lnbmVkIGludCBpbmRleCwKPiAgIAl1bnNpZ25lZCBpbnQgbnVtLAo+IEBAIC0x
OTg0LDExICsyMDAwLDYgQEAgc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5nX2NyZWF0ZV92
aXJ0cXVldWVfcGFja2VkKAo+ICAgCj4gICAJdnEtPnBhY2tlZC52cmluZyA9IHZyaW5nX3BhY2tl
ZC52cmluZzsKPiAgIAo+IC0JdnEtPnBhY2tlZC5uZXh0X2F2YWlsX2lkeCA9IDA7Cj4gLQl2cS0+
cGFja2VkLmF2YWlsX3dyYXBfY291bnRlciA9IDE7Cj4gLQl2cS0+cGFja2VkLmV2ZW50X2ZsYWdz
X3NoYWRvdyA9IDA7Cj4gLQl2cS0+cGFja2VkLmF2YWlsX3VzZWRfZmxhZ3MgPSAxIDw8IFZSSU5H
X1BBQ0tFRF9ERVNDX0ZfQVZBSUw7Cj4gLQo+ICAgCWVyciA9IHZyaW5nX2FsbG9jX3N0YXRlX2V4
dHJhX3BhY2tlZCgmdnJpbmdfcGFja2VkKTsKPiAgIAlpZiAoZXJyKQo+ICAgCQlnb3RvIGVycl9z
dGF0ZV9leHRyYTsKPiBAQCAtMTk5NiwxMiArMjAwNyw3IEBAIHN0YXRpYyBzdHJ1Y3QgdmlydHF1
ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVlX3BhY2tlZCgKPiAgIAl2cS0+cGFja2VkLmRlc2Nf
c3RhdGUgPSB2cmluZ19wYWNrZWQuZGVzY19zdGF0ZTsKPiAgIAl2cS0+cGFja2VkLmRlc2NfZXh0
cmEgPSB2cmluZ19wYWNrZWQuZGVzY19leHRyYTsKPiAgIAo+IC0JLyogTm8gY2FsbGJhY2s/ICBU
ZWxsIG90aGVyIHNpZGUgbm90IHRvIGJvdGhlciB1cy4gKi8KPiAtCWlmICghY2FsbGJhY2spIHsK
PiAtCQl2cS0+cGFja2VkLmV2ZW50X2ZsYWdzX3NoYWRvdyA9IFZSSU5HX1BBQ0tFRF9FVkVOVF9G
TEFHX0RJU0FCTEU7Cj4gLQkJdnEtPnBhY2tlZC52cmluZy5kcml2ZXItPmZsYWdzID0KPiAtCQkJ
Y3B1X3RvX2xlMTYodnEtPnBhY2tlZC5ldmVudF9mbGFnc19zaGFkb3cpOwo+IC0JfQo+ICsJdmly
dHF1ZXVlX3ZyaW5nX2luaXRfcGFja2VkKCZ2cmluZ19wYWNrZWQsICEhY2FsbGJhY2spOwo+ICAg
Cj4gICAJdmlydHF1ZXVlX2luaXQodnEsIG51bSk7Cj4gICAKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgt
dW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LXVtCg==


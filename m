Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGbiB-00AgIc-87
	for linux-um@lists.infradead.org; Wed, 27 Jul 2022 07:44:08 +0000
Message-ID: <1658907413.1860468-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v13 16/42] virtio_ring: split: introduce virtqueue_resize_split()
Date: Wed, 27 Jul 2022 15:36:53 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220726072225.19884-1-xuanzhuo@linux.alibaba.com>
 <20220726072225.19884-17-xuanzhuo@linux.alibaba.com>
 <15aa26f2-f8af-5dbd-f2b2-9270ad873412@redhat.com>
In-Reply-To: <15aa26f2-f8af-5dbd-f2b2-9270ad873412@redhat.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Jason Wang <jasowang@redhat.com>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, "Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>, Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, linux-um@lists.infradead.org, netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, kangjie.xu@linux.alibaba.com, virtualization@lists.linux-foundation.org

T24gV2VkLCAyNyBKdWwgMjAyMiAxMToxMjoxOSArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiDlnKggMjAyMi83LzI2IDE1OjIxLCBYdWFuIFpodW8g5YaZ
6YGTOgo+ID4gdmlydGlvIHJpbmcgc3BsaXQgc3VwcG9ydHMgcmVzaXplLgo+ID4KPiA+IE9ubHkg
YWZ0ZXIgdGhlIG5ldyB2cmluZyBpcyBzdWNjZXNzZnVsbHkgYWxsb2NhdGVkIGJhc2VkIG9uIHRo
ZSBuZXcgbnVtLAo+ID4gd2Ugd2lsbCByZWxlYXNlIHRoZSBvbGQgdnJpbmcuIEluIGFueSBjYXNl
LCBhbiBlcnJvciBpcyByZXR1cm5lZCwKPiA+IGluZGljYXRpbmcgdGhhdCB0aGUgdnJpbmcgc3Rp
bGwgcG9pbnRzIHRvIHRoZSBvbGQgdnJpbmcuCj4gPgo+ID4gSW4gdGhlIGNhc2Ugb2YgYW4gZXJy
b3IsIHJlLWluaXRpYWxpemUodmlydHF1ZXVlX3JlaW5pdF9zcGxpdCgpKSB0aGUKPiA+IHZpcnRx
dWV1ZSB0byBlbnN1cmUgdGhhdCB0aGUgdnJpbmcgY2FuIGJlIHVzZWQuCj4gPgo+ID4gU2lnbmVk
LW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiA+IEFja2Vk
LWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gLS0tCj4gPiAgIGRyaXZl
cnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCAzNCArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAzNCBpbnNlcnRpb25zKCspCj4gPgo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92
aXJ0aW9fcmluZy5jCj4gPiBpbmRleCBiNmZkYTkxYzgwNTkuLjU4MzU1ZTFhYzdkNyAxMDA2NDQK
PiA+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+ICsrKyBiL2RyaXZlcnMv
dmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+IEBAIC0yMjAsNiArMjIwLDcgQEAgc3RhdGljIHN0cnVj
dCB2aXJ0cXVldWUgKl9fdnJpbmdfbmV3X3ZpcnRxdWV1ZSh1bnNpZ25lZCBpbnQgaW5kZXgsCj4g
PiAgIAkJCQkJICAgICAgIHZvaWQgKCpjYWxsYmFjaykoc3RydWN0IHZpcnRxdWV1ZSAqKSwKPiA+
ICAgCQkJCQkgICAgICAgY29uc3QgY2hhciAqbmFtZSk7Cj4gPiAgIHN0YXRpYyBzdHJ1Y3QgdnJp
bmdfZGVzY19leHRyYSAqdnJpbmdfYWxsb2NfZGVzY19leHRyYSh1bnNpZ25lZCBpbnQgbnVtKTsK
PiA+ICtzdGF0aWMgdm9pZCB2cmluZ19mcmVlKHN0cnVjdCB2aXJ0cXVldWUgKl92cSk7Cj4gPgo+
ID4gICAvKgo+ID4gICAgKiBIZWxwZXJzLgo+ID4gQEAgLTExMTcsNiArMTExOCwzOSBAQCBzdGF0
aWMgc3RydWN0IHZpcnRxdWV1ZSAqdnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZV9zcGxpdCgKPiA+ICAg
CXJldHVybiB2cTsKPiA+ICAgfQo+ID4KPiA+ICtzdGF0aWMgaW50IHZpcnRxdWV1ZV9yZXNpemVf
c3BsaXQoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxLCB1MzIgbnVtKQo+ID4gK3sKPiA+ICsJc3RydWN0
IHZyaW5nX3ZpcnRxdWV1ZV9zcGxpdCB2cmluZ19zcGxpdCA9IHt9Owo+ID4gKwlzdHJ1Y3QgdnJp
bmdfdmlydHF1ZXVlICp2cSA9IHRvX3Z2cShfdnEpOwo+ID4gKwlzdHJ1Y3QgdmlydGlvX2Rldmlj
ZSAqdmRldiA9IF92cS0+dmRldjsKPiA+ICsJaW50IGVycjsKPiA+ICsKPiA+ICsJZXJyID0gdnJp
bmdfYWxsb2NfcXVldWVfc3BsaXQoJnZyaW5nX3NwbGl0LCB2ZGV2LCBudW0sCj4gPiArCQkJCSAg
ICAgIHZxLT5zcGxpdC52cmluZ19hbGlnbiwKPiA+ICsJCQkJICAgICAgdnEtPnNwbGl0Lm1heV9y
ZWR1Y2VfbnVtKTsKPiA+ICsJaWYgKGVycikKPiA+ICsJCWdvdG8gZXJyOwo+Cj4KPiBJIHRoaW5r
IHdlIGRvbid0IG5lZWQgdG8gZG8gYW55dGhpbmcgaGVyZT8KCkFtIEkgbWlzc2luZyBzb21ldGhp
bmc/Cgo+Cj4KPiA+ICsKPiA+ICsJZXJyID0gdnJpbmdfYWxsb2Nfc3RhdGVfZXh0cmFfc3BsaXQo
JnZyaW5nX3NwbGl0KTsKPiA+ICsJaWYgKGVycikgewo+ID4gKwkJdnJpbmdfZnJlZV9zcGxpdCgm
dnJpbmdfc3BsaXQsIHZkZXYpOwo+ID4gKwkJZ290byBlcnI7Cj4KPgo+IEkgc3VnZ2VzdCB0byBt
b3ZlIHZyaW5nX2ZyZWVfc3BsaXQoKSBpbnRvIGEgZGVkaWNhdGVkIGVycm9yIGxhYmVsLgoKV2ls
bCBjaGFuZ2UuCgpUaGFua3MuCgoKPgo+IFRoYW5rcwo+Cj4KPiA+ICsJfQo+ID4gKwo+ID4gKwl2
cmluZ19mcmVlKCZ2cS0+dnEpOwo+ID4gKwo+ID4gKwl2aXJ0cXVldWVfdnJpbmdfaW5pdF9zcGxp
dCgmdnJpbmdfc3BsaXQsIHZxKTsKPiA+ICsKPiA+ICsJdmlydHF1ZXVlX2luaXQodnEsIHZyaW5n
X3NwbGl0LnZyaW5nLm51bSk7Cj4gPiArCXZpcnRxdWV1ZV92cmluZ19hdHRhY2hfc3BsaXQodnEs
ICZ2cmluZ19zcGxpdCk7Cj4gPiArCj4gPiArCXJldHVybiAwOwo+ID4gKwo+ID4gK2VycjoKPiA+
ICsJdmlydHF1ZXVlX3JlaW5pdF9zcGxpdCh2cSk7Cj4gPiArCXJldHVybiAtRU5PTUVNOwo+ID4g
K30KPiA+ICsKPiA+Cj4gPiAgIC8qCj4gPiAgICAqIFBhY2tlZCByaW5nIHNwZWNpZmljIGZ1bmN0
aW9ucyAtICpfcGFja2VkKCkuCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
dW0K


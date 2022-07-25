Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFro9-005cG2-KS
	for linux-um@lists.infradead.org; Mon, 25 Jul 2022 06:43:15 +0000
Message-ID: <1658731116.1695666-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v12 38/40] virtio_net: support rx queue resize
Date: Mon, 25 Jul 2022 14:38:36 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220720030436.79520-1-xuanzhuo@linux.alibaba.com>
 <20220720030436.79520-39-xuanzhuo@linux.alibaba.com>
 <726a5056-789a-b445-a2c6-879008ad270a@redhat.com>
In-Reply-To: <726a5056-789a-b445-a2c6-879008ad270a@redhat.com>
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

T24gVGh1LCAyMSBKdWwgMjAyMiAxNzoyNTo1OSArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiDlnKggMjAyMi83LzIwIDExOjA0LCBYdWFuIFpodW8g5YaZ
6YGTOgo+ID4gVGhpcyBwYXRjaCBpbXBsZW1lbnRzIHRoZSByZXNpemUgZnVuY3Rpb24gb2YgdGhl
IHJ4IHF1ZXVlcy4KPiA+IEJhc2VkIG9uIHRoaXMgZnVuY3Rpb24sIGl0IGlzIHBvc3NpYmxlIHRv
IG1vZGlmeSB0aGUgcmluZyBudW0gb2YgdGhlCj4gPiBxdWV1ZS4KPiA+Cj4gPiBTaWduZWQtb2Zm
LWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+ID4gLS0tCj4gPiAg
IGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDIyICsrKysrKysrKysrKysrKysrKysrKysKPiA+
ICAgMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKykKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiBp
bmRleCBmZTRkYzQzYzA1YTEuLjExMTVhOGI1OWEwOCAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMv
bmV0L3ZpcnRpb19uZXQuYwo+ID4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiBA
QCAtMjc4LDYgKzI3OCw4IEBAIHN0cnVjdCBwYWRkZWRfdm5ldF9oZHIgewo+ID4gICAJY2hhciBw
YWRkaW5nWzEyXTsKPiA+ICAgfTsKPiA+Cj4gPiArc3RhdGljIHZvaWQgdmlydG5ldF9ycV9mcmVl
X3VudXNlZF9idWYoc3RydWN0IHZpcnRxdWV1ZSAqdnEsIHZvaWQgKmJ1Zik7Cj4gPiArCj4gPiAg
IHN0YXRpYyBib29sIGlzX3hkcF9mcmFtZSh2b2lkICpwdHIpCj4gPiAgIHsKPiA+ICAgCXJldHVy
biAodW5zaWduZWQgbG9uZylwdHIgJiBWSVJUSU9fWERQX0ZMQUc7Cj4gPiBAQCAtMTg0Niw2ICsx
ODQ4LDI2IEBAIHN0YXRpYyBuZXRkZXZfdHhfdCBzdGFydF94bWl0KHN0cnVjdCBza19idWZmICpz
a2IsIHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpCj4gPiAgIAlyZXR1cm4gTkVUREVWX1RYX09LOwo+
ID4gICB9Cj4gPgo+ID4gK3N0YXRpYyBpbnQgdmlydG5ldF9yeF9yZXNpemUoc3RydWN0IHZpcnRu
ZXRfaW5mbyAqdmksCj4gPiArCQkJICAgICBzdHJ1Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEsIHUzMiBy
aW5nX251bSkKPiA+ICt7Cj4gPiArCWludCBlcnIsIHFpbmRleDsKPiA+ICsKPiA+ICsJcWluZGV4
ID0gcnEgLSB2aS0+cnE7Cj4gPiArCj4gPiArCW5hcGlfZGlzYWJsZSgmcnEtPm5hcGkpOwo+Cj4K
PiBXZSBuZWVkIHRvIGRpc2FibGUgcmVmaWxsIHdvcmsgYXMgd2VsbC4gU28gdGhpcyBzZXJpZXMg
bWlnaHQgbmVlZAo+IHJlYmFzaW5nIG9uIHRvcCBvZgo+Cj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbmV0ZGV2LzIwMjIwNzA0MDc0ODU5LjE2OTEyLTEtamFzb3dhbmdAcmVkaGF0LmNvbS8KCkkg
dW5kZXJzdGFuZCB0aGF0IHlvdXIgcGF0Y2ggaXMgdXNlZCB0byBzb2x2ZSB0aGUgc2l0dWF0aW9u
IHdoZXJlIGRldiBpcwpkZXN0b3J5ZWQgYnV0IHJlZmlsbCB3b3JrIGlzIHJ1bm5pbmcuCgpBbmQg
aXMgdGhlcmUgc3VjaCBhIHBvc3NpYmlsaXR5IGhlcmU/IE9yIGlzIHRoZXJlIGFueSBvdGhlciBz
Y2VuYXJpbyB0aGF0IEknbQpub3QgZXhwZWN0aW5nPwoKVGhhbmtzLgoKCj4KPiBJIHdpbGwgc2Vu
ZCBhIG5ldyB2ZXJzaW9uIChwcm9iYWJseSB0b21vcnJvdykuCj4KPiBUaGFua3MKPgo+Cj4gPiAr
Cj4gPiArCWVyciA9IHZpcnRxdWV1ZV9yZXNpemUocnEtPnZxLCByaW5nX251bSwgdmlydG5ldF9y
cV9mcmVlX3VudXNlZF9idWYpOwo+ID4gKwlpZiAoZXJyKQo+ID4gKwkJbmV0ZGV2X2Vycih2aS0+
ZGV2LCAicmVzaXplIHJ4IGZhaWw6IHJ4IHF1ZXVlIGluZGV4OiAlZCBlcnI6ICVkXG4iLCBxaW5k
ZXgsIGVycik7Cj4gPiArCj4gPiArCWlmICghdHJ5X2ZpbGxfcmVjdih2aSwgcnEsIEdGUF9LRVJO
RUwpKQo+ID4gKwkJc2NoZWR1bGVfZGVsYXllZF93b3JrKCZ2aS0+cmVmaWxsLCAwKTsKPiA+ICsK
PiA+ICsJdmlydG5ldF9uYXBpX2VuYWJsZShycS0+dnEsICZycS0+bmFwaSk7Cj4gPiArCXJldHVy
biBlcnI7Cj4gPiArfQo+ID4gKwo+ID4gICAvKgo+ID4gICAgKiBTZW5kIGNvbW1hbmQgdmlhIHRo
ZSBjb250cm9sIHZpcnRxdWV1ZSBhbmQgY2hlY2sgc3RhdHVzLiAgQ29tbWFuZHMKPiA+ICAgICog
c3VwcG9ydGVkIGJ5IHRoZSBoeXBlcnZpc29yLCBhcyBpbmRpY2F0ZWQgYnkgZmVhdHVyZSBiaXRz
LCBzaG91bGQKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=


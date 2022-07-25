Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFsWe-0067AU-T2
	for linux-um@lists.infradead.org; Mon, 25 Jul 2022 07:29:14 +0000
Received: by mail-lf1-f72.google.com with SMTP id dt17-20020a0565122a9100b0048a878a2a56so480616lfb.6
        for <linux-um@lists.infradead.org>; Mon, 25 Jul 2022 00:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220720030436.79520-1-xuanzhuo@linux.alibaba.com>
 <20220720030436.79520-39-xuanzhuo@linux.alibaba.com> <726a5056-789a-b445-a2c6-879008ad270a@redhat.com>
 <1658731116.1695666-1-xuanzhuo@linux.alibaba.com> <CACGkMEvsAyR5uRprobv-bQYPOKKOM4sZzQ-Vw5ZiETMjiCkdRQ@mail.gmail.com>
 <1658733700.3892667-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1658733700.3892667-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 25 Jul 2022 15:28:55 +0800
Message-ID: <CACGkMEvsS_QVbq3iCG8hvHuKrp9ObTy3jPUn75zPk-bSHd7tzA@mail.gmail.com>
Subject: Re: [PATCH v12 38/40] virtio_net: support rx queue resize
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, "Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>, Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, linux-um@lists.infradead.org, netdev <netdev@vger.kernel.org>, platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, kvm <kvm@vger.kernel.org>, "open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>, Kangjie Xu <kangjie.xu@linux.alibaba.com>, virtualization <virtualization@lists.linux-foundation.org>

T24gTW9uLCBKdWwgMjUsIDIwMjIgYXQgMzoyMyBQTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IE9uIE1vbiwgMjUgSnVsIDIwMjIgMTQ6NTc6MTEgKzA4
MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gT24gTW9uLCBK
dWwgMjUsIDIwMjIgYXQgMjo0MyBQTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEu
Y29tPiB3cm90ZToKPiA+ID4KPiA+ID4gT24gVGh1LCAyMSBKdWwgMjAyMiAxNzoyNTo1OSArMDgw
MCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4KPiA+ID4g
PiDlnKggMjAyMi83LzIwIDExOjA0LCBYdWFuIFpodW8g5YaZ6YGTOgo+ID4gPiA+ID4gVGhpcyBw
YXRjaCBpbXBsZW1lbnRzIHRoZSByZXNpemUgZnVuY3Rpb24gb2YgdGhlIHJ4IHF1ZXVlcy4KPiA+
ID4gPiA+IEJhc2VkIG9uIHRoaXMgZnVuY3Rpb24sIGl0IGlzIHBvc3NpYmxlIHRvIG1vZGlmeSB0
aGUgcmluZyBudW0gb2YgdGhlCj4gPiA+ID4gPiBxdWV1ZS4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+ID4g
PiA+ID4gLS0tCj4gPiA+ID4gPiAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDIyICsrKysr
KysrKysrKysrKysrKysrKysKPiA+ID4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlv
bnMoKykKPiA+ID4gPiA+Cj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlv
X25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+ID4gPiBpbmRleCBmZTRkYzQz
YzA1YTEuLjExMTVhOGI1OWEwOCAxMDA2NDQKPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3Zp
cnRpb19uZXQuYwo+ID4gPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+
ID4gPiBAQCAtMjc4LDYgKzI3OCw4IEBAIHN0cnVjdCBwYWRkZWRfdm5ldF9oZHIgewo+ID4gPiA+
ID4gICAgIGNoYXIgcGFkZGluZ1sxMl07Cj4gPiA+ID4gPiAgIH07Cj4gPiA+ID4gPgo+ID4gPiA+
ID4gK3N0YXRpYyB2b2lkIHZpcnRuZXRfcnFfZnJlZV91bnVzZWRfYnVmKHN0cnVjdCB2aXJ0cXVl
dWUgKnZxLCB2b2lkICpidWYpOwo+ID4gPiA+ID4gKwo+ID4gPiA+ID4gICBzdGF0aWMgYm9vbCBp
c194ZHBfZnJhbWUodm9pZCAqcHRyKQo+ID4gPiA+ID4gICB7Cj4gPiA+ID4gPiAgICAgcmV0dXJu
ICh1bnNpZ25lZCBsb25nKXB0ciAmIFZJUlRJT19YRFBfRkxBRzsKPiA+ID4gPiA+IEBAIC0xODQ2
LDYgKzE4NDgsMjYgQEAgc3RhdGljIG5ldGRldl90eF90IHN0YXJ0X3htaXQoc3RydWN0IHNrX2J1
ZmYgKnNrYiwgc3RydWN0IG5ldF9kZXZpY2UgKmRldikKPiA+ID4gPiA+ICAgICByZXR1cm4gTkVU
REVWX1RYX09LOwo+ID4gPiA+ID4gICB9Cj4gPiA+ID4gPgo+ID4gPiA+ID4gK3N0YXRpYyBpbnQg
dmlydG5ldF9yeF9yZXNpemUoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksCj4gPiA+ID4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHJlY2VpdmVfcXVldWUgKnJxLCB1MzIgcmluZ19u
dW0pCj4gPiA+ID4gPiArewo+ID4gPiA+ID4gKyAgIGludCBlcnIsIHFpbmRleDsKPiA+ID4gPiA+
ICsKPiA+ID4gPiA+ICsgICBxaW5kZXggPSBycSAtIHZpLT5ycTsKPiA+ID4gPiA+ICsKPiA+ID4g
PiA+ICsgICBuYXBpX2Rpc2FibGUoJnJxLT5uYXBpKTsKPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4g
V2UgbmVlZCB0byBkaXNhYmxlIHJlZmlsbCB3b3JrIGFzIHdlbGwuIFNvIHRoaXMgc2VyaWVzIG1p
Z2h0IG5lZWQKPiA+ID4gPiByZWJhc2luZyBvbiB0b3Agb2YKPiA+ID4gPgo+ID4gPiA+IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi8yMDIyMDcwNDA3NDg1OS4xNjkxMi0xLWphc293YW5n
QHJlZGhhdC5jb20vCj4gPiA+Cj4gPiA+IEkgdW5kZXJzdGFuZCB0aGF0IHlvdXIgcGF0Y2ggaXMg
dXNlZCB0byBzb2x2ZSB0aGUgc2l0dWF0aW9uIHdoZXJlIGRldiBpcwo+ID4gPiBkZXN0b3J5ZWQg
YnV0IHJlZmlsbCB3b3JrIGlzIHJ1bm5pbmcuCj4gPiA+Cj4gPiA+IEFuZCBpcyB0aGVyZSBzdWNo
IGEgcG9zc2liaWxpdHkgaGVyZT8KPiA+Cj4gPiBFLmcgdGhlIHJlZmlsbCB3b3JrIHJ1bnMgaW4g
cGFyYWxsZWwgd2l0aCB0aGlzIGZ1bmN0aW9uPwo+Cj4gbmFwaV9kaXNhYmxlIGVuYWJsZXMgbG9j
ay1saWtlIGZ1bmN0aW9uYWxpdHkuIFNvIEkgdGhpbmsgaXQncyBzYWZlLgo+CgpPaywgcmlnaHQs
IHNpbmNlIHRoZXJlIHdpbGwgYmUgYSBuYXBpX2VuYWJsZSgpIHNvb24gYWZ0ZXJ3YXJkcy4KClNv
CgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KClRoYW5rcwoKPiBU
aGFua3MuCj4KPiA+Cj4gPiBUaGFua3MKPiA+Cj4gPiA+IE9yIGlzIHRoZXJlIGFueSBvdGhlciBz
Y2VuYXJpbyB0aGF0IEknbQo+ID4gPiBub3QgZXhwZWN0aW5nPwo+ID4gPgo+ID4gPiBUaGFua3Mu
Cj4gPiA+Cj4gPiA+Cj4gPiA+ID4KPiA+ID4gPiBJIHdpbGwgc2VuZCBhIG5ldyB2ZXJzaW9uIChw
cm9iYWJseSB0b21vcnJvdykuCj4gPiA+ID4KPiA+ID4gPiBUaGFua3MKPiA+ID4gPgo+ID4gPiA+
Cj4gPiA+ID4gPiArCj4gPiA+ID4gPiArICAgZXJyID0gdmlydHF1ZXVlX3Jlc2l6ZShycS0+dnEs
IHJpbmdfbnVtLCB2aXJ0bmV0X3JxX2ZyZWVfdW51c2VkX2J1Zik7Cj4gPiA+ID4gPiArICAgaWYg
KGVycikKPiA+ID4gPiA+ICsgICAgICAgICAgIG5ldGRldl9lcnIodmktPmRldiwgInJlc2l6ZSBy
eCBmYWlsOiByeCBxdWV1ZSBpbmRleDogJWQgZXJyOiAlZFxuIiwgcWluZGV4LCBlcnIpOwo+ID4g
PiA+ID4gKwo+ID4gPiA+ID4gKyAgIGlmICghdHJ5X2ZpbGxfcmVjdih2aSwgcnEsIEdGUF9LRVJO
RUwpKQo+ID4gPiA+ID4gKyAgICAgICAgICAgc2NoZWR1bGVfZGVsYXllZF93b3JrKCZ2aS0+cmVm
aWxsLCAwKTsKPiA+ID4gPiA+ICsKPiA+ID4gPiA+ICsgICB2aXJ0bmV0X25hcGlfZW5hYmxlKHJx
LT52cSwgJnJxLT5uYXBpKTsKPiA+ID4gPiA+ICsgICByZXR1cm4gZXJyOwo+ID4gPiA+ID4gK30K
PiA+ID4gPiA+ICsKPiA+ID4gPiA+ICAgLyoKPiA+ID4gPiA+ICAgICogU2VuZCBjb21tYW5kIHZp
YSB0aGUgY29udHJvbCB2aXJ0cXVldWUgYW5kIGNoZWNrIHN0YXR1cy4gIENvbW1hbmRzCj4gPiA+
ID4gPiAgICAqIHN1cHBvcnRlZCBieSB0aGUgaHlwZXJ2aXNvciwgYXMgaW5kaWNhdGVkIGJ5IGZl
YXR1cmUgYml0cywgc2hvdWxkCj4gPiA+ID4KPiA+ID4KPiA+Cj4KCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGlu
dXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==


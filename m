Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFsRC-0063hg-4n
	for linux-um@lists.infradead.org; Mon, 25 Jul 2022 07:23:37 +0000
Message-ID: <1658733700.3892667-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v12 38/40] virtio_net: support rx queue resize
Date: Mon, 25 Jul 2022 15:21:40 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220720030436.79520-1-xuanzhuo@linux.alibaba.com>
 <20220720030436.79520-39-xuanzhuo@linux.alibaba.com>
 <726a5056-789a-b445-a2c6-879008ad270a@redhat.com>
 <1658731116.1695666-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEvsAyR5uRprobv-bQYPOKKOM4sZzQ-Vw5ZiETMjiCkdRQ@mail.gmail.com>
In-Reply-To: <CACGkMEvsAyR5uRprobv-bQYPOKKOM4sZzQ-Vw5ZiETMjiCkdRQ@mail.gmail.com>
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
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, "Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>, Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, linux-um@lists.infradead.org, netdev <netdev@vger.kernel.org>, platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, kvm <kvm@vger.kernel.org>, "open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>, Kangjie Xu <kangjie.xu@linux.alibaba.com>, virtualization <virtualization@lists.linux-foundation.org>

T24gTW9uLCAyNSBKdWwgMjAyMiAxNDo1NzoxMSArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gTW9uLCBKdWwgMjUsIDIwMjIgYXQgMjo0MyBQTSBYdWFu
IFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBUaHUs
IDIxIEp1bCAyMDIyIDE3OjI1OjU5ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKPiA+ID4KPiA+ID4g5ZyoIDIwMjIvNy8yMCAxMTowNCwgWHVhbiBaaHVvIOWG
memBkzoKPiA+ID4gPiBUaGlzIHBhdGNoIGltcGxlbWVudHMgdGhlIHJlc2l6ZSBmdW5jdGlvbiBv
ZiB0aGUgcnggcXVldWVzLgo+ID4gPiA+IEJhc2VkIG9uIHRoaXMgZnVuY3Rpb24sIGl0IGlzIHBv
c3NpYmxlIHRvIG1vZGlmeSB0aGUgcmluZyBudW0gb2YgdGhlCj4gPiA+ID4gcXVldWUuCj4gPiA+
ID4KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJh
YmEuY29tPgo+ID4gPiA+IC0tLQo+ID4gPiA+ICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwg
MjIgKysrKysrKysrKysrKysrKysrKysrKwo+ID4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDIyIGlu
c2VydGlvbnMoKykKPiA+ID4gPgo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gPiBpbmRleCBmZTRkYzQz
YzA1YTEuLjExMTVhOGI1OWEwOCAxMDA2NDQKPiA+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMKPiA+ID4gPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gPiBA
QCAtMjc4LDYgKzI3OCw4IEBAIHN0cnVjdCBwYWRkZWRfdm5ldF9oZHIgewo+ID4gPiA+ICAgICBj
aGFyIHBhZGRpbmdbMTJdOwo+ID4gPiA+ICAgfTsKPiA+ID4gPgo+ID4gPiA+ICtzdGF0aWMgdm9p
ZCB2aXJ0bmV0X3JxX2ZyZWVfdW51c2VkX2J1ZihzdHJ1Y3QgdmlydHF1ZXVlICp2cSwgdm9pZCAq
YnVmKTsKPiA+ID4gPiArCj4gPiA+ID4gICBzdGF0aWMgYm9vbCBpc194ZHBfZnJhbWUodm9pZCAq
cHRyKQo+ID4gPiA+ICAgewo+ID4gPiA+ICAgICByZXR1cm4gKHVuc2lnbmVkIGxvbmcpcHRyICYg
VklSVElPX1hEUF9GTEFHOwo+ID4gPiA+IEBAIC0xODQ2LDYgKzE4NDgsMjYgQEAgc3RhdGljIG5l
dGRldl90eF90IHN0YXJ0X3htaXQoc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IG5ldF9kZXZp
Y2UgKmRldikKPiA+ID4gPiAgICAgcmV0dXJuIE5FVERFVl9UWF9PSzsKPiA+ID4gPiAgIH0KPiA+
ID4gPgo+ID4gPiA+ICtzdGF0aWMgaW50IHZpcnRuZXRfcnhfcmVzaXplKHN0cnVjdCB2aXJ0bmV0
X2luZm8gKnZpLAo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgcmVjZWl2
ZV9xdWV1ZSAqcnEsIHUzMiByaW5nX251bSkKPiA+ID4gPiArewo+ID4gPiA+ICsgICBpbnQgZXJy
LCBxaW5kZXg7Cj4gPiA+ID4gKwo+ID4gPiA+ICsgICBxaW5kZXggPSBycSAtIHZpLT5ycTsKPiA+
ID4gPiArCj4gPiA+ID4gKyAgIG5hcGlfZGlzYWJsZSgmcnEtPm5hcGkpOwo+ID4gPgo+ID4gPgo+
ID4gPiBXZSBuZWVkIHRvIGRpc2FibGUgcmVmaWxsIHdvcmsgYXMgd2VsbC4gU28gdGhpcyBzZXJp
ZXMgbWlnaHQgbmVlZAo+ID4gPiByZWJhc2luZyBvbiB0b3Agb2YKPiA+ID4KPiA+ID4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2LzIwMjIwNzA0MDc0ODU5LjE2OTEyLTEtamFzb3dhbmdA
cmVkaGF0LmNvbS8KPiA+Cj4gPiBJIHVuZGVyc3RhbmQgdGhhdCB5b3VyIHBhdGNoIGlzIHVzZWQg
dG8gc29sdmUgdGhlIHNpdHVhdGlvbiB3aGVyZSBkZXYgaXMKPiA+IGRlc3RvcnllZCBidXQgcmVm
aWxsIHdvcmsgaXMgcnVubmluZy4KPiA+Cj4gPiBBbmQgaXMgdGhlcmUgc3VjaCBhIHBvc3NpYmls
aXR5IGhlcmU/Cj4KPiBFLmcgdGhlIHJlZmlsbCB3b3JrIHJ1bnMgaW4gcGFyYWxsZWwgd2l0aCB0
aGlzIGZ1bmN0aW9uPwoKbmFwaV9kaXNhYmxlIGVuYWJsZXMgbG9jay1saWtlIGZ1bmN0aW9uYWxp
dHkuIFNvIEkgdGhpbmsgaXQncyBzYWZlLgoKVGhhbmtzLgoKPgo+IFRoYW5rcwo+Cj4gPiBPciBp
cyB0aGVyZSBhbnkgb3RoZXIgc2NlbmFyaW8gdGhhdCBJJ20KPiA+IG5vdCBleHBlY3Rpbmc/Cj4g
Pgo+ID4gVGhhbmtzLgo+ID4KPiA+Cj4gPiA+Cj4gPiA+IEkgd2lsbCBzZW5kIGEgbmV3IHZlcnNp
b24gKHByb2JhYmx5IHRvbW9ycm93KS4KPiA+ID4KPiA+ID4gVGhhbmtzCj4gPiA+Cj4gPiA+Cj4g
PiA+ID4gKwo+ID4gPiA+ICsgICBlcnIgPSB2aXJ0cXVldWVfcmVzaXplKHJxLT52cSwgcmluZ19u
dW0sIHZpcnRuZXRfcnFfZnJlZV91bnVzZWRfYnVmKTsKPiA+ID4gPiArICAgaWYgKGVycikKPiA+
ID4gPiArICAgICAgICAgICBuZXRkZXZfZXJyKHZpLT5kZXYsICJyZXNpemUgcnggZmFpbDogcngg
cXVldWUgaW5kZXg6ICVkIGVycjogJWRcbiIsIHFpbmRleCwgZXJyKTsKPiA+ID4gPiArCj4gPiA+
ID4gKyAgIGlmICghdHJ5X2ZpbGxfcmVjdih2aSwgcnEsIEdGUF9LRVJORUwpKQo+ID4gPiA+ICsg
ICAgICAgICAgIHNjaGVkdWxlX2RlbGF5ZWRfd29yaygmdmktPnJlZmlsbCwgMCk7Cj4gPiA+ID4g
Kwo+ID4gPiA+ICsgICB2aXJ0bmV0X25hcGlfZW5hYmxlKHJxLT52cSwgJnJxLT5uYXBpKTsKPiA+
ID4gPiArICAgcmV0dXJuIGVycjsKPiA+ID4gPiArfQo+ID4gPiA+ICsKPiA+ID4gPiAgIC8qCj4g
PiA+ID4gICAgKiBTZW5kIGNvbW1hbmQgdmlhIHRoZSBjb250cm9sIHZpcnRxdWV1ZSBhbmQgY2hl
Y2sgc3RhdHVzLiAgQ29tbWFuZHMKPiA+ID4gPiAgICAqIHN1cHBvcnRlZCBieSB0aGUgaHlwZXJ2
aXNvciwgYXMgaW5kaWNhdGVkIGJ5IGZlYXR1cmUgYml0cywgc2hvdWxkCj4gPiA+Cj4gPgo+Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBt
YWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==


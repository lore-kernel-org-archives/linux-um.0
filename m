Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGtQZ-002za2-0F
	for linux-um@lists.infradead.org; Thu, 28 Jul 2022 02:39:08 +0000
Received: by mail-lf1-f69.google.com with SMTP id 25-20020ac24859000000b0048a8a367582so221033lfy.18
        for <linux-um@lists.infradead.org>; Wed, 27 Jul 2022 19:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220726072225.19884-1-xuanzhuo@linux.alibaba.com>
 <20220726072225.19884-17-xuanzhuo@linux.alibaba.com> <15aa26f2-f8af-5dbd-f2b2-9270ad873412@redhat.com>
 <1658907413.1860468-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1658907413.1860468-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Jul 2022 10:38:51 +0800
Message-ID: <CACGkMEvxsOfiiaWWAR8P68GY1yfwgTvaAbHk1JF7pTw-o2k25w@mail.gmail.com>
Subject: Re: [PATCH v13 16/42] virtio_ring: split: introduce virtqueue_resize_split()
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

T24gV2VkLCBKdWwgMjcsIDIwMjIgYXQgMzo0NCBQTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IE9uIFdlZCwgMjcgSnVsIDIwMjIgMTE6MTI6MTkgKzA4
MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IOWcqCAy
MDIyLzcvMjYgMTU6MjEsIFh1YW4gWmh1byDlhpnpgZM6Cj4gPiA+IHZpcnRpbyByaW5nIHNwbGl0
IHN1cHBvcnRzIHJlc2l6ZS4KPiA+ID4KPiA+ID4gT25seSBhZnRlciB0aGUgbmV3IHZyaW5nIGlz
IHN1Y2Nlc3NmdWxseSBhbGxvY2F0ZWQgYmFzZWQgb24gdGhlIG5ldyBudW0sCj4gPiA+IHdlIHdp
bGwgcmVsZWFzZSB0aGUgb2xkIHZyaW5nLiBJbiBhbnkgY2FzZSwgYW4gZXJyb3IgaXMgcmV0dXJu
ZWQsCj4gPiA+IGluZGljYXRpbmcgdGhhdCB0aGUgdnJpbmcgc3RpbGwgcG9pbnRzIHRvIHRoZSBv
bGQgdnJpbmcuCj4gPiA+Cj4gPiA+IEluIHRoZSBjYXNlIG9mIGFuIGVycm9yLCByZS1pbml0aWFs
aXplKHZpcnRxdWV1ZV9yZWluaXRfc3BsaXQoKSkgdGhlCj4gPiA+IHZpcnRxdWV1ZSB0byBlbnN1
cmUgdGhhdCB0aGUgdnJpbmcgY2FuIGJlIHVzZWQuCj4gPiA+Cj4gPiA+IFNpZ25lZC1vZmYtYnk6
IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gPiA+IEFja2VkLWJ5OiBK
YXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gPiAtLS0KPiA+ID4gICBkcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgMzQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKwo+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAzNCBpbnNlcnRpb25zKCspCj4gPiA+Cj4gPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0
aW8vdmlydGlvX3JpbmcuYwo+ID4gPiBpbmRleCBiNmZkYTkxYzgwNTkuLjU4MzU1ZTFhYzdkNyAx
MDA2NDQKPiA+ID4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gPiArKysg
Yi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiA+IEBAIC0yMjAsNiArMjIwLDcgQEAg
c3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKl9fdnJpbmdfbmV3X3ZpcnRxdWV1ZSh1bnNpZ25lZCBp
bnQgaW5kZXgsCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB2b2lkICgqY2FsbGJhY2spKHN0cnVjdCB2aXJ0cXVldWUgKiksCj4gPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICpuYW1lKTsKPiA+ID4g
ICBzdGF0aWMgc3RydWN0IHZyaW5nX2Rlc2NfZXh0cmEgKnZyaW5nX2FsbG9jX2Rlc2NfZXh0cmEo
dW5zaWduZWQgaW50IG51bSk7Cj4gPiA+ICtzdGF0aWMgdm9pZCB2cmluZ19mcmVlKHN0cnVjdCB2
aXJ0cXVldWUgKl92cSk7Cj4gPiA+Cj4gPiA+ICAgLyoKPiA+ID4gICAgKiBIZWxwZXJzLgo+ID4g
PiBAQCAtMTExNyw2ICsxMTE4LDM5IEBAIHN0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19j
cmVhdGVfdmlydHF1ZXVlX3NwbGl0KAo+ID4gPiAgICAgcmV0dXJuIHZxOwo+ID4gPiAgIH0KPiA+
ID4KPiA+ID4gK3N0YXRpYyBpbnQgdmlydHF1ZXVlX3Jlc2l6ZV9zcGxpdChzdHJ1Y3QgdmlydHF1
ZXVlICpfdnEsIHUzMiBudW0pCj4gPiA+ICt7Cj4gPiA+ICsgICBzdHJ1Y3QgdnJpbmdfdmlydHF1
ZXVlX3NwbGl0IHZyaW5nX3NwbGl0ID0ge307Cj4gPiA+ICsgICBzdHJ1Y3QgdnJpbmdfdmlydHF1
ZXVlICp2cSA9IHRvX3Z2cShfdnEpOwo+ID4gPiArICAgc3RydWN0IHZpcnRpb19kZXZpY2UgKnZk
ZXYgPSBfdnEtPnZkZXY7Cj4gPiA+ICsgICBpbnQgZXJyOwo+ID4gPiArCj4gPiA+ICsgICBlcnIg
PSB2cmluZ19hbGxvY19xdWV1ZV9zcGxpdCgmdnJpbmdfc3BsaXQsIHZkZXYsIG51bSwKPiA+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZxLT5zcGxpdC52cmluZ19hbGlnbiwK
PiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZxLT5zcGxpdC5tYXlfcmVk
dWNlX251bSk7Cj4gPiA+ICsgICBpZiAoZXJyKQo+ID4gPiArICAgICAgICAgICBnb3RvIGVycjsK
PiA+Cj4gPgo+ID4gSSB0aGluayB3ZSBkb24ndCBuZWVkIHRvIGRvIGFueXRoaW5nIGhlcmU/Cj4K
PiBBbSBJIG1pc3Npbmcgc29tZXRoaW5nPwoKSSBtZWFudCBpdCBsb29rcyB0byBtZSBtb3N0IG9m
IHRoZSB2aXJ0cXVldWVfcmVpbml0KCkgaXMgdW5uZWNlc3NhcnkuCldlIHByb2JhYmx5IG9ubHkg
bmVlZCB0byByZWluaXQgYXZhaWwvdXNlZCBpZHggdGhlcmUuCgpUaGFua3MKCj4KPiA+Cj4gPgo+
ID4gPiArCj4gPiA+ICsgICBlcnIgPSB2cmluZ19hbGxvY19zdGF0ZV9leHRyYV9zcGxpdCgmdnJp
bmdfc3BsaXQpOwo+ID4gPiArICAgaWYgKGVycikgewo+ID4gPiArICAgICAgICAgICB2cmluZ19m
cmVlX3NwbGl0KCZ2cmluZ19zcGxpdCwgdmRldik7Cj4gPiA+ICsgICAgICAgICAgIGdvdG8gZXJy
Owo+ID4KPiA+Cj4gPiBJIHN1Z2dlc3QgdG8gbW92ZSB2cmluZ19mcmVlX3NwbGl0KCkgaW50byBh
IGRlZGljYXRlZCBlcnJvciBsYWJlbC4KPgo+IFdpbGwgY2hhbmdlLgo+Cj4gVGhhbmtzLgo+Cj4K
PiA+Cj4gPiBUaGFua3MKPiA+Cj4gPgo+ID4gPiArICAgfQo+ID4gPiArCj4gPiA+ICsgICB2cmlu
Z19mcmVlKCZ2cS0+dnEpOwo+ID4gPiArCj4gPiA+ICsgICB2aXJ0cXVldWVfdnJpbmdfaW5pdF9z
cGxpdCgmdnJpbmdfc3BsaXQsIHZxKTsKPiA+ID4gKwo+ID4gPiArICAgdmlydHF1ZXVlX2luaXQo
dnEsIHZyaW5nX3NwbGl0LnZyaW5nLm51bSk7Cj4gPiA+ICsgICB2aXJ0cXVldWVfdnJpbmdfYXR0
YWNoX3NwbGl0KHZxLCAmdnJpbmdfc3BsaXQpOwo+ID4gPiArCj4gPiA+ICsgICByZXR1cm4gMDsK
PiA+ID4gKwo+ID4gPiArZXJyOgo+ID4gPiArICAgdmlydHF1ZXVlX3JlaW5pdF9zcGxpdCh2cSk7
Cj4gPiA+ICsgICByZXR1cm4gLUVOT01FTTsKPiA+ID4gK30KPiA+ID4gKwo+ID4gPgo+ID4gPiAg
IC8qCj4gPiA+ICAgICogUGFja2VkIHJpbmcgc3BlY2lmaWMgZnVuY3Rpb25zIC0gKl9wYWNrZWQo
KS4KPiA+Cj4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==


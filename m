Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDMZs-00BwH7-T0
	for linux-um@lists.infradead.org; Mon, 18 Jul 2022 08:58:10 +0000
Received: by mail-lf1-f70.google.com with SMTP id k25-20020a195619000000b00489e6a6527eso3970800lfb.8
        for <linux-um@lists.infradead.org>; Mon, 18 Jul 2022 01:58:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-40-xuanzhuo@linux.alibaba.com> <102d3b83-1ae9-a59a-16ce-251c22b7afb0@redhat.com>
 <1656986432.1164997-2-xuanzhuo@linux.alibaba.com> <CACGkMEt8MSS=tcn=Hd6WF9+btT0ccocxEd1ighRgK-V1uiWmCQ@mail.gmail.com>
 <1657873703.9301925-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1657873703.9301925-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 18 Jul 2022 16:57:53 +0800
Message-ID: <CACGkMEvgjX+67NxwrUym7CnbNFU2-=CbAXPN_UmtvDOTS1LrHA@mail.gmail.com>
Subject: Re: [PATCH v11 39/40] virtio_net: support tx queue resize
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
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, "Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>, Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, linux-um@lists.infradead.org, netdev <netdev@vger.kernel.org>, platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, kvm <kvm@vger.kernel.org>, "open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>, kangjie.xu@linux.alibaba.com, virtualization <virtualization@lists.linux-foundation.org>

T24gRnJpLCBKdWwgMTUsIDIwMjIgYXQgNDozMiBQTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IE9uIEZyaSwgOCBKdWwgMjAyMiAxNDoyMzo1NyArMDgw
MCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiBPbiBUdWUsIEp1
bCA1LCAyMDIyIGF0IDEwOjAxIEFNIFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5j
b20+IHdyb3RlOgo+ID4gPgo+ID4gPiBPbiBNb24sIDQgSnVsIDIwMjIgMTE6NDU6NTIgKzA4MDAs
IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+Cj4gPiA+ID4g
5ZyoIDIwMjIvNi8yOSAxNDo1NiwgWHVhbiBaaHVvIOWGmemBkzoKPiA+ID4gPiA+IFRoaXMgcGF0
Y2ggaW1wbGVtZW50cyB0aGUgcmVzaXplIGZ1bmN0aW9uIG9mIHRoZSB0eCBxdWV1ZXMuCj4gPiA+
ID4gPiBCYXNlZCBvbiB0aGlzIGZ1bmN0aW9uLCBpdCBpcyBwb3NzaWJsZSB0byBtb2RpZnkgdGhl
IHJpbmcgbnVtIG9mIHRoZQo+ID4gPiA+ID4gcXVldWUuCj4gPiA+ID4gPgo+ID4gPiA+ID4gU2ln
bmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiA+ID4g
PiA+IC0tLQo+ID4gPiA+ID4gICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCA0OCArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gPiA+ID4gPiAgIDEgZmlsZSBjaGFu
Z2VkLCA0OCBpbnNlcnRpb25zKCspCj4gPiA+ID4gPgo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gPiA+
ID4gaW5kZXggNmFiMTZmZDE5M2U1Li5mZDM1ODQ2MmY4MDIgMTAwNjQ0Cj4gPiA+ID4gPiAtLS0g
YS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3Zp
cnRpb19uZXQuYwo+ID4gPiA+ID4gQEAgLTEzNSw2ICsxMzUsOSBAQCBzdHJ1Y3Qgc2VuZF9xdWV1
ZSB7Cj4gPiA+ID4gPiAgICAgc3RydWN0IHZpcnRuZXRfc3Ffc3RhdHMgc3RhdHM7Cj4gPiA+ID4g
Pgo+ID4gPiA+ID4gICAgIHN0cnVjdCBuYXBpX3N0cnVjdCBuYXBpOwo+ID4gPiA+ID4gKwo+ID4g
PiA+ID4gKyAgIC8qIFJlY29yZCB3aGV0aGVyIHNxIGlzIGluIHJlc2V0IHN0YXRlLiAqLwo+ID4g
PiA+ID4gKyAgIGJvb2wgcmVzZXQ7Cj4gPiA+ID4gPiAgIH07Cj4gPiA+ID4gPgo+ID4gPiA+ID4g
ICAvKiBJbnRlcm5hbCByZXByZXNlbnRhdGlvbiBvZiBhIHJlY2VpdmUgdmlydHF1ZXVlICovCj4g
PiA+ID4gPiBAQCAtMjc5LDYgKzI4Miw3IEBAIHN0cnVjdCBwYWRkZWRfdm5ldF9oZHIgewo+ID4g
PiA+ID4gICB9Owo+ID4gPiA+ID4KPiA+ID4gPiA+ICAgc3RhdGljIHZvaWQgdmlydG5ldF9ycV9m
cmVlX3VudXNlZF9idWYoc3RydWN0IHZpcnRxdWV1ZSAqdnEsIHZvaWQgKmJ1Zik7Cj4gPiA+ID4g
PiArc3RhdGljIHZvaWQgdmlydG5ldF9zcV9mcmVlX3VudXNlZF9idWYoc3RydWN0IHZpcnRxdWV1
ZSAqdnEsIHZvaWQgKmJ1Zik7Cj4gPiA+ID4gPgo+ID4gPiA+ID4gICBzdGF0aWMgYm9vbCBpc194
ZHBfZnJhbWUodm9pZCAqcHRyKQo+ID4gPiA+ID4gICB7Cj4gPiA+ID4gPiBAQCAtMTYwMyw2ICsx
NjA3LDExIEBAIHN0YXRpYyB2b2lkIHZpcnRuZXRfcG9sbF9jbGVhbnR4KHN0cnVjdCByZWNlaXZl
X3F1ZXVlICpycSkKPiA+ID4gPiA+ICAgICAgICAgICAgIHJldHVybjsKPiA+ID4gPiA+Cj4gPiA+
ID4gPiAgICAgaWYgKF9fbmV0aWZfdHhfdHJ5bG9jayh0eHEpKSB7Cj4gPiA+ID4gPiArICAgICAg
ICAgICBpZiAoUkVBRF9PTkNFKHNxLT5yZXNldCkpIHsKPiA+ID4gPiA+ICsgICAgICAgICAgICAg
ICAgICAgX19uZXRpZl90eF91bmxvY2sodHhxKTsKPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAg
ICAgcmV0dXJuOwo+ID4gPiA+ID4gKyAgICAgICAgICAgfQo+ID4gPiA+ID4gKwo+ID4gPiA+ID4g
ICAgICAgICAgICAgZG8gewo+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICB2aXJ0cXVldWVf
ZGlzYWJsZV9jYihzcS0+dnEpOwo+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICBmcmVlX29s
ZF94bWl0X3NrYnMoc3EsIHRydWUpOwo+ID4gPiA+ID4gQEAgLTE4NjgsNiArMTg3Nyw0NSBAQCBz
dGF0aWMgaW50IHZpcnRuZXRfcnhfcmVzaXplKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+ID4g
PiA+ID4gICAgIHJldHVybiBlcnI7Cj4gPiA+ID4gPiAgIH0KPiA+ID4gPiA+Cj4gPiA+ID4gPiAr
c3RhdGljIGludCB2aXJ0bmV0X3R4X3Jlc2l6ZShzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwKPiA+
ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgc2VuZF9xdWV1ZSAqc3EsIHUz
MiByaW5nX251bSkKPiA+ID4gPiA+ICt7Cj4gPiA+ID4gPiArICAgc3RydWN0IG5ldGRldl9xdWV1
ZSAqdHhxOwo+ID4gPiA+ID4gKyAgIGludCBlcnIsIHFpbmRleDsKPiA+ID4gPiA+ICsKPiA+ID4g
PiA+ICsgICBxaW5kZXggPSBzcSAtIHZpLT5zcTsKPiA+ID4gPiA+ICsKPiA+ID4gPiA+ICsgICB2
aXJ0bmV0X25hcGlfdHhfZGlzYWJsZSgmc3EtPm5hcGkpOwo+ID4gPiA+ID4gKwo+ID4gPiA+ID4g
KyAgIHR4cSA9IG5ldGRldl9nZXRfdHhfcXVldWUodmktPmRldiwgcWluZGV4KTsKPiA+ID4gPiA+
ICsKPiA+ID4gPiA+ICsgICAvKiAxLiB3YWl0IGFsbCB4aW10IGNvbXBsZXRlCj4gPiA+ID4gPiAr
ICAgICogMi4gZml4IHRoZSByYWNlIG9mIG5ldGlmX3N0b3Bfc3VicXVldWUoKSB2cyBuZXRpZl9z
dGFydF9zdWJxdWV1ZSgpCj4gPiA+ID4gPiArICAgICovCj4gPiA+ID4gPiArICAgX19uZXRpZl90
eF9sb2NrX2JoKHR4cSk7Cj4gPiA+ID4gPiArCj4gPiA+ID4gPiArICAgLyogUHJldmVudCByeCBw
b2xsIGZyb20gYWNjZXNzaW5nIHNxLiAqLwo+ID4gPiA+ID4gKyAgIFdSSVRFX09OQ0Uoc3EtPnJl
c2V0LCB0cnVlKTsKPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gQ2FuIHdlIHNpbXBseSBkaXNhYmxl
IFJYIE5BUEkgaGVyZT8KPiA+ID4KPiA+ID4gRGlzYWJsZSByeCBuYXBpIGlzIGluZGVlZCBhIHNp
bXBsZSBzb2x1dGlvbi4gQnV0IEkgaG9wZSB0aGF0IHdoZW4gZGVhbGluZyB3aXRoCj4gPiA+IHR4
LCBpdCB3aWxsIG5vdCBhZmZlY3QgcnguCj4gPgo+ID4gT2ssIGJ1dCBJIHRoaW5rIHdlJ3ZlIGFs
cmVhZHkgc3luY2hyb25pemVkIHdpdGggdHggbG9jayBoZXJlLCBpc24ndCBpdD8KPgo+IFllcywg
ZG8geW91IGhhdmUgYW55IHF1ZXN0aW9ucyBhYm91dCBXUklURV9PTkNFKCk/IFRoZXJlIGlzIGEg
c2V0IGZhbHNlIG9wZXJhdGlvbgo+IGxhdGVyLCBJIGRpZCBub3QgdXNlIGxvY2sgdGhlcmUsIHNv
IEkgdXNlZCBXUklURS9SRUFEX09OQ0UKPiB1bmlmb3JtbHkuCgpJIG1lYW4sIHNpbmNlIHdlJ3Zl
IGFscmVhZHkgdXNlZCB0eCBsb2NrcyBzb21ld2hlcmUsIHdlJ2QgYmV0dGVyIHVzZQp0aGVtIGhl
cmUgYXMgd2VsbCBhdCBsZWFzdCBhcyBhIHN0YXJ0LgoKVGhhbmtzCgo+Cj4gVGhhbmtzLgo+Cj4g
Pgo+ID4gVGhhbmtzCj4gPgo+ID4gPgo+ID4gPiBUaGFua3MuCj4gPiA+Cj4gPiA+Cj4gPiA+ID4K
PiA+ID4gPiBUaGFua3MKPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiArCj4gPiA+ID4gPiArICAg
LyogUHJldmVudCB0aGUgdXBwZXIgbGF5ZXIgZnJvbSB0cnlpbmcgdG8gc2VuZCBwYWNrZXRzLiAq
Lwo+ID4gPiA+ID4gKyAgIG5ldGlmX3N0b3Bfc3VicXVldWUodmktPmRldiwgcWluZGV4KTsKPiA+
ID4gPiA+ICsKPiA+ID4gPiA+ICsgICBfX25ldGlmX3R4X3VubG9ja19iaCh0eHEpOwo+ID4gPiA+
ID4gKwo+ID4gPiA+ID4gKyAgIGVyciA9IHZpcnRxdWV1ZV9yZXNpemUoc3EtPnZxLCByaW5nX251
bSwgdmlydG5ldF9zcV9mcmVlX3VudXNlZF9idWYpOwo+ID4gPiA+ID4gKyAgIGlmIChlcnIpCj4g
PiA+ID4gPiArICAgICAgICAgICBuZXRkZXZfZXJyKHZpLT5kZXYsICJyZXNpemUgdHggZmFpbDog
dHggcXVldWUgaW5kZXg6ICVkIGVycjogJWRcbiIsIHFpbmRleCwgZXJyKTsKPiA+ID4gPiA+ICsK
PiA+ID4gPiA+ICsgICAvKiBNZW1vcnkgYmFycmllciBiZWZvcmUgc2V0IHJlc2V0IGFuZCBzdGFy
dCBzdWJxdWV1ZS4gKi8KPiA+ID4gPiA+ICsgICBzbXBfbWIoKTsKPiA+ID4gPiA+ICsKPiA+ID4g
PiA+ICsgICBXUklURV9PTkNFKHNxLT5yZXNldCwgZmFsc2UpOwo+ID4gPiA+ID4gKyAgIG5ldGlm
X3R4X3dha2VfcXVldWUodHhxKTsKPiA+ID4gPiA+ICsKPiA+ID4gPiA+ICsgICB2aXJ0bmV0X25h
cGlfdHhfZW5hYmxlKHZpLCBzcS0+dnEsICZzcS0+bmFwaSk7Cj4gPiA+ID4gPiArICAgcmV0dXJu
IGVycjsKPiA+ID4gPiA+ICt9Cj4gPiA+ID4gPiArCj4gPiA+ID4gPiAgIC8qCj4gPiA+ID4gPiAg
ICAqIFNlbmQgY29tbWFuZCB2aWEgdGhlIGNvbnRyb2wgdmlydHF1ZXVlIGFuZCBjaGVjayBzdGF0
dXMuICBDb21tYW5kcwo+ID4gPiA+ID4gICAgKiBzdXBwb3J0ZWQgYnkgdGhlIGh5cGVydmlzb3Is
IGFzIGluZGljYXRlZCBieSBmZWF0dXJlIGJpdHMsIHNob3VsZAo+ID4gPiA+Cj4gPiA+Cj4gPgo+
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
dW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=


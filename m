Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9hPV-001zyy-Bk
	for linux-um@lists.infradead.org; Fri, 08 Jul 2022 06:24:18 +0000
Received: by mail-lf1-f72.google.com with SMTP id f29-20020a19dc5d000000b004811c8d1918so7303211lfj.2
        for <linux-um@lists.infradead.org>; Thu, 07 Jul 2022 23:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-40-xuanzhuo@linux.alibaba.com> <102d3b83-1ae9-a59a-16ce-251c22b7afb0@redhat.com>
 <1656986432.1164997-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1656986432.1164997-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 8 Jul 2022 14:23:57 +0800
Message-ID: <CACGkMEt8MSS=tcn=Hd6WF9+btT0ccocxEd1ighRgK-V1uiWmCQ@mail.gmail.com>
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

T24gVHVlLCBKdWwgNSwgMjAyMiBhdCAxMDowMSBBTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IE9uIE1vbiwgNCBKdWwgMjAyMiAxMTo0NTo1MiArMDgw
MCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4g5ZyoIDIw
MjIvNi8yOSAxNDo1NiwgWHVhbiBaaHVvIOWGmemBkzoKPiA+ID4gVGhpcyBwYXRjaCBpbXBsZW1l
bnRzIHRoZSByZXNpemUgZnVuY3Rpb24gb2YgdGhlIHR4IHF1ZXVlcy4KPiA+ID4gQmFzZWQgb24g
dGhpcyBmdW5jdGlvbiwgaXQgaXMgcG9zc2libGUgdG8gbW9kaWZ5IHRoZSByaW5nIG51bSBvZiB0
aGUKPiA+ID4gcXVldWUuCj4gPiA+Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVh
bnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gPiA+IC0tLQo+ID4gPiAgIGRyaXZlcnMvbmV0L3Zp
cnRpb19uZXQuYyB8IDQ4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysK
PiA+ID4gICAxIGZpbGUgY2hhbmdlZCwgNDggaW5zZXJ0aW9ucygrKQo+ID4gPgo+ID4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25l
dC5jCj4gPiA+IGluZGV4IDZhYjE2ZmQxOTNlNS4uZmQzNTg0NjJmODAyIDEwMDY0NAo+ID4gPiAt
LS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvdmly
dGlvX25ldC5jCj4gPiA+IEBAIC0xMzUsNiArMTM1LDkgQEAgc3RydWN0IHNlbmRfcXVldWUgewo+
ID4gPiAgICAgc3RydWN0IHZpcnRuZXRfc3Ffc3RhdHMgc3RhdHM7Cj4gPiA+Cj4gPiA+ICAgICBz
dHJ1Y3QgbmFwaV9zdHJ1Y3QgbmFwaTsKPiA+ID4gKwo+ID4gPiArICAgLyogUmVjb3JkIHdoZXRo
ZXIgc3EgaXMgaW4gcmVzZXQgc3RhdGUuICovCj4gPiA+ICsgICBib29sIHJlc2V0Owo+ID4gPiAg
IH07Cj4gPiA+Cj4gPiA+ICAgLyogSW50ZXJuYWwgcmVwcmVzZW50YXRpb24gb2YgYSByZWNlaXZl
IHZpcnRxdWV1ZSAqLwo+ID4gPiBAQCAtMjc5LDYgKzI4Miw3IEBAIHN0cnVjdCBwYWRkZWRfdm5l
dF9oZHIgewo+ID4gPiAgIH07Cj4gPiA+Cj4gPiA+ICAgc3RhdGljIHZvaWQgdmlydG5ldF9ycV9m
cmVlX3VudXNlZF9idWYoc3RydWN0IHZpcnRxdWV1ZSAqdnEsIHZvaWQgKmJ1Zik7Cj4gPiA+ICtz
dGF0aWMgdm9pZCB2aXJ0bmV0X3NxX2ZyZWVfdW51c2VkX2J1ZihzdHJ1Y3QgdmlydHF1ZXVlICp2
cSwgdm9pZCAqYnVmKTsKPiA+ID4KPiA+ID4gICBzdGF0aWMgYm9vbCBpc194ZHBfZnJhbWUodm9p
ZCAqcHRyKQo+ID4gPiAgIHsKPiA+ID4gQEAgLTE2MDMsNiArMTYwNywxMSBAQCBzdGF0aWMgdm9p
ZCB2aXJ0bmV0X3BvbGxfY2xlYW50eChzdHJ1Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEpCj4gPiA+ICAg
ICAgICAgICAgIHJldHVybjsKPiA+ID4KPiA+ID4gICAgIGlmIChfX25ldGlmX3R4X3RyeWxvY2so
dHhxKSkgewo+ID4gPiArICAgICAgICAgICBpZiAoUkVBRF9PTkNFKHNxLT5yZXNldCkpIHsKPiA+
ID4gKyAgICAgICAgICAgICAgICAgICBfX25ldGlmX3R4X3VubG9jayh0eHEpOwo+ID4gPiArICAg
ICAgICAgICAgICAgICAgIHJldHVybjsKPiA+ID4gKyAgICAgICAgICAgfQo+ID4gPiArCj4gPiA+
ICAgICAgICAgICAgIGRvIHsKPiA+ID4gICAgICAgICAgICAgICAgICAgICB2aXJ0cXVldWVfZGlz
YWJsZV9jYihzcS0+dnEpOwo+ID4gPiAgICAgICAgICAgICAgICAgICAgIGZyZWVfb2xkX3htaXRf
c2ticyhzcSwgdHJ1ZSk7Cj4gPiA+IEBAIC0xODY4LDYgKzE4NzcsNDUgQEAgc3RhdGljIGludCB2
aXJ0bmV0X3J4X3Jlc2l6ZShzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwKPiA+ID4gICAgIHJldHVy
biBlcnI7Cj4gPiA+ICAgfQo+ID4gPgo+ID4gPiArc3RhdGljIGludCB2aXJ0bmV0X3R4X3Jlc2l6
ZShzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
IHN0cnVjdCBzZW5kX3F1ZXVlICpzcSwgdTMyIHJpbmdfbnVtKQo+ID4gPiArewo+ID4gPiArICAg
c3RydWN0IG5ldGRldl9xdWV1ZSAqdHhxOwo+ID4gPiArICAgaW50IGVyciwgcWluZGV4Owo+ID4g
PiArCj4gPiA+ICsgICBxaW5kZXggPSBzcSAtIHZpLT5zcTsKPiA+ID4gKwo+ID4gPiArICAgdmly
dG5ldF9uYXBpX3R4X2Rpc2FibGUoJnNxLT5uYXBpKTsKPiA+ID4gKwo+ID4gPiArICAgdHhxID0g
bmV0ZGV2X2dldF90eF9xdWV1ZSh2aS0+ZGV2LCBxaW5kZXgpOwo+ID4gPiArCj4gPiA+ICsgICAv
KiAxLiB3YWl0IGFsbCB4aW10IGNvbXBsZXRlCj4gPiA+ICsgICAgKiAyLiBmaXggdGhlIHJhY2Ug
b2YgbmV0aWZfc3RvcF9zdWJxdWV1ZSgpIHZzIG5ldGlmX3N0YXJ0X3N1YnF1ZXVlKCkKPiA+ID4g
KyAgICAqLwo+ID4gPiArICAgX19uZXRpZl90eF9sb2NrX2JoKHR4cSk7Cj4gPiA+ICsKPiA+ID4g
KyAgIC8qIFByZXZlbnQgcnggcG9sbCBmcm9tIGFjY2Vzc2luZyBzcS4gKi8KPiA+ID4gKyAgIFdS
SVRFX09OQ0Uoc3EtPnJlc2V0LCB0cnVlKTsKPiA+Cj4gPgo+ID4gQ2FuIHdlIHNpbXBseSBkaXNh
YmxlIFJYIE5BUEkgaGVyZT8KPgo+IERpc2FibGUgcnggbmFwaSBpcyBpbmRlZWQgYSBzaW1wbGUg
c29sdXRpb24uIEJ1dCBJIGhvcGUgdGhhdCB3aGVuIGRlYWxpbmcgd2l0aAo+IHR4LCBpdCB3aWxs
IG5vdCBhZmZlY3QgcnguCgpPaywgYnV0IEkgdGhpbmsgd2UndmUgYWxyZWFkeSBzeW5jaHJvbml6
ZWQgd2l0aCB0eCBsb2NrIGhlcmUsIGlzbid0IGl0PwoKVGhhbmtzCgo+Cj4gVGhhbmtzLgo+Cj4K
PiA+Cj4gPiBUaGFua3MKPiA+Cj4gPgo+ID4gPiArCj4gPiA+ICsgICAvKiBQcmV2ZW50IHRoZSB1
cHBlciBsYXllciBmcm9tIHRyeWluZyB0byBzZW5kIHBhY2tldHMuICovCj4gPiA+ICsgICBuZXRp
Zl9zdG9wX3N1YnF1ZXVlKHZpLT5kZXYsIHFpbmRleCk7Cj4gPiA+ICsKPiA+ID4gKyAgIF9fbmV0
aWZfdHhfdW5sb2NrX2JoKHR4cSk7Cj4gPiA+ICsKPiA+ID4gKyAgIGVyciA9IHZpcnRxdWV1ZV9y
ZXNpemUoc3EtPnZxLCByaW5nX251bSwgdmlydG5ldF9zcV9mcmVlX3VudXNlZF9idWYpOwo+ID4g
PiArICAgaWYgKGVycikKPiA+ID4gKyAgICAgICAgICAgbmV0ZGV2X2Vycih2aS0+ZGV2LCAicmVz
aXplIHR4IGZhaWw6IHR4IHF1ZXVlIGluZGV4OiAlZCBlcnI6ICVkXG4iLCBxaW5kZXgsIGVycik7
Cj4gPiA+ICsKPiA+ID4gKyAgIC8qIE1lbW9yeSBiYXJyaWVyIGJlZm9yZSBzZXQgcmVzZXQgYW5k
IHN0YXJ0IHN1YnF1ZXVlLiAqLwo+ID4gPiArICAgc21wX21iKCk7Cj4gPiA+ICsKPiA+ID4gKyAg
IFdSSVRFX09OQ0Uoc3EtPnJlc2V0LCBmYWxzZSk7Cj4gPiA+ICsgICBuZXRpZl90eF93YWtlX3F1
ZXVlKHR4cSk7Cj4gPiA+ICsKPiA+ID4gKyAgIHZpcnRuZXRfbmFwaV90eF9lbmFibGUodmksIHNx
LT52cSwgJnNxLT5uYXBpKTsKPiA+ID4gKyAgIHJldHVybiBlcnI7Cj4gPiA+ICt9Cj4gPiA+ICsK
PiA+ID4gICAvKgo+ID4gPiAgICAqIFNlbmQgY29tbWFuZCB2aWEgdGhlIGNvbnRyb2wgdmlydHF1
ZXVlIGFuZCBjaGVjayBzdGF0dXMuICBDb21tYW5kcwo+ID4gPiAgICAqIHN1cHBvcnRlZCBieSB0
aGUgaHlwZXJ2aXNvciwgYXMgaW5kaWNhdGVkIGJ5IGZlYXR1cmUgYml0cywgc2hvdWxkCj4gPgo+
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
dW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=


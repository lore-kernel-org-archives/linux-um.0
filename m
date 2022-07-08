Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9hMW-001yw9-Sp
	for linux-um@lists.infradead.org; Fri, 08 Jul 2022 06:21:14 +0000
Received: by mail-lf1-f71.google.com with SMTP id p36-20020a05651213a400b004779d806c13so7342333lfa.10
        for <linux-um@lists.infradead.org>; Thu, 07 Jul 2022 23:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-39-xuanzhuo@linux.alibaba.com> <c0747cbc-685b-85a9-1931-0124124755f2@redhat.com>
 <1656986375.3420787-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1656986375.3420787-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 8 Jul 2022 14:20:52 +0800
Message-ID: <CACGkMEu80KP-ULz_CBvauRk_3XsCubMkkWv0uLnbt-wib5KOnA@mail.gmail.com>
Subject: Re: [PATCH v11 38/40] virtio_net: support rx queue resize
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

T24gVHVlLCBKdWwgNSwgMjAyMiBhdCAxMDowMCBBTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IE9uIE1vbiwgNCBKdWwgMjAyMiAxMTo0NDoxMiArMDgw
MCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4g5ZyoIDIw
MjIvNi8yOSAxNDo1NiwgWHVhbiBaaHVvIOWGmemBkzoKPiA+ID4gVGhpcyBwYXRjaCBpbXBsZW1l
bnRzIHRoZSByZXNpemUgZnVuY3Rpb24gb2YgdGhlIHJ4IHF1ZXVlcy4KPiA+ID4gQmFzZWQgb24g
dGhpcyBmdW5jdGlvbiwgaXQgaXMgcG9zc2libGUgdG8gbW9kaWZ5IHRoZSByaW5nIG51bSBvZiB0
aGUKPiA+ID4gcXVldWUuCj4gPiA+Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVh
bnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gPiA+IC0tLQo+ID4gPiAgIGRyaXZlcnMvbmV0L3Zp
cnRpb19uZXQuYyB8IDIyICsrKysrKysrKysrKysrKysrKysrKysKPiA+ID4gICAxIGZpbGUgY2hh
bmdlZCwgMjIgaW5zZXJ0aW9ucygrKQo+ID4gPgo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
ZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+IGluZGV4IDlm
ZTIyMmEzNjYzYS4uNmFiMTZmZDE5M2U1IDEwMDY0NAo+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMKPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+IEBA
IC0yNzgsNiArMjc4LDggQEAgc3RydWN0IHBhZGRlZF92bmV0X2hkciB7Cj4gPiA+ICAgICBjaGFy
IHBhZGRpbmdbMTJdOwo+ID4gPiAgIH07Cj4gPiA+Cj4gPiA+ICtzdGF0aWMgdm9pZCB2aXJ0bmV0
X3JxX2ZyZWVfdW51c2VkX2J1ZihzdHJ1Y3QgdmlydHF1ZXVlICp2cSwgdm9pZCAqYnVmKTsKPiA+
ID4gKwo+ID4gPiAgIHN0YXRpYyBib29sIGlzX3hkcF9mcmFtZSh2b2lkICpwdHIpCj4gPiA+ICAg
ewo+ID4gPiAgICAgcmV0dXJuICh1bnNpZ25lZCBsb25nKXB0ciAmIFZJUlRJT19YRFBfRkxBRzsK
PiA+ID4gQEAgLTE4NDYsNiArMTg0OCwyNiBAQCBzdGF0aWMgbmV0ZGV2X3R4X3Qgc3RhcnRfeG1p
dChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQo+ID4gPiAgICAg
cmV0dXJuIE5FVERFVl9UWF9PSzsKPiA+ID4gICB9Cj4gPiA+Cj4gPiA+ICtzdGF0aWMgaW50IHZp
cnRuZXRfcnhfcmVzaXplKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+ID4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgc3RydWN0IHJlY2VpdmVfcXVldWUgKnJxLCB1MzIgcmluZ19udW0pCj4g
PiA+ICt7Cj4gPiA+ICsgICBpbnQgZXJyLCBxaW5kZXg7Cj4gPiA+ICsKPiA+ID4gKyAgIHFpbmRl
eCA9IHJxIC0gdmktPnJxOwo+ID4gPiArCj4gPiA+ICsgICBuYXBpX2Rpc2FibGUoJnJxLT5uYXBp
KTsKPiA+Cj4gPgo+ID4gRG8gd2UgbmVlZCB0byBjYW5jZWwgdGhlIHJlZmlsbCB3b3JrIGhlcmU/
Cj4KPgo+IEkgdGhpbmsgbm8sIG5hcGlfZGlzYWJsZSBpcyBtdXR1YWxseSBleGNsdXNpdmUsIHdo
aWNoIGVuc3VyZXMgdGhhdCB0aGVyZSB3aWxsIGJlCj4gbm8gY29uZmxpY3RzIGJldHdlZW4gdGhl
bS4KClNvIHRoaXMgc291bmRzIHNpbWlsYXIgdG8gd2hhdCBJJ3ZlIGZpeGVkIHJlY2VudGx5LgoK
MSkgTkFQSSBzY2hlZHVsZSBkZWxheWVkIHdvcmsuCjIpIHdlIGRpc2FibGUgTkFQSSBoZXJlCjMp
IGRlbGF5ZWQgd29yayBnZXQgc2NoZWR1bGUgYW5kIGNhbGwgTkFQSSBhZ2FpbgoKPwoKVGhhbmtz
Cgo+Cj4gVGhhbmtzLgo+Cj4gPgo+ID4gVGhhbmtzCj4gPgo+ID4KPiA+ID4gKwo+ID4gPiArICAg
ZXJyID0gdmlydHF1ZXVlX3Jlc2l6ZShycS0+dnEsIHJpbmdfbnVtLCB2aXJ0bmV0X3JxX2ZyZWVf
dW51c2VkX2J1Zik7Cj4gPiA+ICsgICBpZiAoZXJyKQo+ID4gPiArICAgICAgICAgICBuZXRkZXZf
ZXJyKHZpLT5kZXYsICJyZXNpemUgcnggZmFpbDogcnggcXVldWUgaW5kZXg6ICVkIGVycjogJWRc
biIsIHFpbmRleCwgZXJyKTsKPiA+ID4gKwo+ID4gPiArICAgaWYgKCF0cnlfZmlsbF9yZWN2KHZp
LCBycSwgR0ZQX0tFUk5FTCkpCj4gPiA+ICsgICAgICAgICAgIHNjaGVkdWxlX2RlbGF5ZWRfd29y
aygmdmktPnJlZmlsbCwgMCk7Cj4gPiA+ICsKPiA+ID4gKyAgIHZpcnRuZXRfbmFwaV9lbmFibGUo
cnEtPnZxLCAmcnEtPm5hcGkpOwo+ID4gPiArICAgcmV0dXJuIGVycjsKPiA+ID4gK30KPiA+ID4g
Kwo+ID4gPiAgIC8qCj4gPiA+ICAgICogU2VuZCBjb21tYW5kIHZpYSB0aGUgY29udHJvbCB2aXJ0
cXVldWUgYW5kIGNoZWNrIHN0YXR1cy4gIENvbW1hbmRzCj4gPiA+ICAgICogc3VwcG9ydGVkIGJ5
IHRoZSBoeXBlcnZpc29yLCBhcyBpbmRpY2F0ZWQgYnkgZmVhdHVyZSBiaXRzLCBzaG91bGQKPiA+
Cj4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==


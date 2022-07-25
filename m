Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFs1z-005lP6-3m
	for linux-um@lists.infradead.org; Mon, 25 Jul 2022 06:57:32 +0000
Received: by mail-lj1-f198.google.com with SMTP id w16-20020a2e9bd0000000b0025dffcab96eso778511ljj.16
        for <linux-um@lists.infradead.org>; Sun, 24 Jul 2022 23:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220720030436.79520-1-xuanzhuo@linux.alibaba.com>
 <20220720030436.79520-39-xuanzhuo@linux.alibaba.com> <726a5056-789a-b445-a2c6-879008ad270a@redhat.com>
 <1658731116.1695666-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1658731116.1695666-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 25 Jul 2022 14:57:11 +0800
Message-ID: <CACGkMEvsAyR5uRprobv-bQYPOKKOM4sZzQ-Vw5ZiETMjiCkdRQ@mail.gmail.com>
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

T24gTW9uLCBKdWwgMjUsIDIwMjIgYXQgMjo0MyBQTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IE9uIFRodSwgMjEgSnVsIDIwMjIgMTc6MjU6NTkgKzA4
MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IOWcqCAy
MDIyLzcvMjAgMTE6MDQsIFh1YW4gWmh1byDlhpnpgZM6Cj4gPiA+IFRoaXMgcGF0Y2ggaW1wbGVt
ZW50cyB0aGUgcmVzaXplIGZ1bmN0aW9uIG9mIHRoZSByeCBxdWV1ZXMuCj4gPiA+IEJhc2VkIG9u
IHRoaXMgZnVuY3Rpb24sIGl0IGlzIHBvc3NpYmxlIHRvIG1vZGlmeSB0aGUgcmluZyBudW0gb2Yg
dGhlCj4gPiA+IHF1ZXVlLgo+ID4gPgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1
YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+ID4gPiAtLS0KPiA+ID4gICBkcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMgfCAyMiArKysrKysrKysrKysrKysrKysrKysrCj4gPiA+ICAgMSBmaWxlIGNo
YW5nZWQsIDIyIGluc2VydGlvbnMoKykKPiA+ID4KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gPiBpbmRleCBm
ZTRkYzQzYzA1YTEuLjExMTVhOGI1OWEwOCAxMDA2NDQKPiA+ID4gLS0tIGEvZHJpdmVycy9uZXQv
dmlydGlvX25ldC5jCj4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gPiBA
QCAtMjc4LDYgKzI3OCw4IEBAIHN0cnVjdCBwYWRkZWRfdm5ldF9oZHIgewo+ID4gPiAgICAgY2hh
ciBwYWRkaW5nWzEyXTsKPiA+ID4gICB9Owo+ID4gPgo+ID4gPiArc3RhdGljIHZvaWQgdmlydG5l
dF9ycV9mcmVlX3VudXNlZF9idWYoc3RydWN0IHZpcnRxdWV1ZSAqdnEsIHZvaWQgKmJ1Zik7Cj4g
PiA+ICsKPiA+ID4gICBzdGF0aWMgYm9vbCBpc194ZHBfZnJhbWUodm9pZCAqcHRyKQo+ID4gPiAg
IHsKPiA+ID4gICAgIHJldHVybiAodW5zaWduZWQgbG9uZylwdHIgJiBWSVJUSU9fWERQX0ZMQUc7
Cj4gPiA+IEBAIC0xODQ2LDYgKzE4NDgsMjYgQEAgc3RhdGljIG5ldGRldl90eF90IHN0YXJ0X3ht
aXQoc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IG5ldF9kZXZpY2UgKmRldikKPiA+ID4gICAg
IHJldHVybiBORVRERVZfVFhfT0s7Cj4gPiA+ICAgfQo+ID4gPgo+ID4gPiArc3RhdGljIGludCB2
aXJ0bmV0X3J4X3Jlc2l6ZShzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwKPiA+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgIHN0cnVjdCByZWNlaXZlX3F1ZXVlICpycSwgdTMyIHJpbmdfbnVtKQo+
ID4gPiArewo+ID4gPiArICAgaW50IGVyciwgcWluZGV4Owo+ID4gPiArCj4gPiA+ICsgICBxaW5k
ZXggPSBycSAtIHZpLT5ycTsKPiA+ID4gKwo+ID4gPiArICAgbmFwaV9kaXNhYmxlKCZycS0+bmFw
aSk7Cj4gPgo+ID4KPiA+IFdlIG5lZWQgdG8gZGlzYWJsZSByZWZpbGwgd29yayBhcyB3ZWxsLiBT
byB0aGlzIHNlcmllcyBtaWdodCBuZWVkCj4gPiByZWJhc2luZyBvbiB0b3Agb2YKPiA+Cj4gPiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvMjAyMjA3MDQwNzQ4NTkuMTY5MTItMS1qYXNv
d2FuZ0ByZWRoYXQuY29tLwo+Cj4gSSB1bmRlcnN0YW5kIHRoYXQgeW91ciBwYXRjaCBpcyB1c2Vk
IHRvIHNvbHZlIHRoZSBzaXR1YXRpb24gd2hlcmUgZGV2IGlzCj4gZGVzdG9yeWVkIGJ1dCByZWZp
bGwgd29yayBpcyBydW5uaW5nLgo+Cj4gQW5kIGlzIHRoZXJlIHN1Y2ggYSBwb3NzaWJpbGl0eSBo
ZXJlPwoKRS5nIHRoZSByZWZpbGwgd29yayBydW5zIGluIHBhcmFsbGVsIHdpdGggdGhpcyBmdW5j
dGlvbj8KClRoYW5rcwoKPiBPciBpcyB0aGVyZSBhbnkgb3RoZXIgc2NlbmFyaW8gdGhhdCBJJ20K
PiBub3QgZXhwZWN0aW5nPwo+Cj4gVGhhbmtzLgo+Cj4KPiA+Cj4gPiBJIHdpbGwgc2VuZCBhIG5l
dyB2ZXJzaW9uIChwcm9iYWJseSB0b21vcnJvdykuCj4gPgo+ID4gVGhhbmtzCj4gPgo+ID4KPiA+
ID4gKwo+ID4gPiArICAgZXJyID0gdmlydHF1ZXVlX3Jlc2l6ZShycS0+dnEsIHJpbmdfbnVtLCB2
aXJ0bmV0X3JxX2ZyZWVfdW51c2VkX2J1Zik7Cj4gPiA+ICsgICBpZiAoZXJyKQo+ID4gPiArICAg
ICAgICAgICBuZXRkZXZfZXJyKHZpLT5kZXYsICJyZXNpemUgcnggZmFpbDogcnggcXVldWUgaW5k
ZXg6ICVkIGVycjogJWRcbiIsIHFpbmRleCwgZXJyKTsKPiA+ID4gKwo+ID4gPiArICAgaWYgKCF0
cnlfZmlsbF9yZWN2KHZpLCBycSwgR0ZQX0tFUk5FTCkpCj4gPiA+ICsgICAgICAgICAgIHNjaGVk
dWxlX2RlbGF5ZWRfd29yaygmdmktPnJlZmlsbCwgMCk7Cj4gPiA+ICsKPiA+ID4gKyAgIHZpcnRu
ZXRfbmFwaV9lbmFibGUocnEtPnZxLCAmcnEtPm5hcGkpOwo+ID4gPiArICAgcmV0dXJuIGVycjsK
PiA+ID4gK30KPiA+ID4gKwo+ID4gPiAgIC8qCj4gPiA+ICAgICogU2VuZCBjb21tYW5kIHZpYSB0
aGUgY29udHJvbCB2aXJ0cXVldWUgYW5kIGNoZWNrIHN0YXR1cy4gIENvbW1hbmRzCj4gPiA+ICAg
ICogc3VwcG9ydGVkIGJ5IHRoZSBoeXBlcnZpc29yLCBhcyBpbmRpY2F0ZWQgYnkgZmVhdHVyZSBi
aXRzLCBzaG91bGQKPiA+Cj4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVt
Cg==


Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCGjp-005mvM-4S
	for linux-um@lists.infradead.org; Fri, 15 Jul 2022 08:31:55 +0000
Message-ID: <1657873703.9301925-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v11 39/40] virtio_net: support tx queue resize
Date: Fri, 15 Jul 2022 16:28:23 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-40-xuanzhuo@linux.alibaba.com>
 <102d3b83-1ae9-a59a-16ce-251c22b7afb0@redhat.com>
 <1656986432.1164997-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEt8MSS=tcn=Hd6WF9+btT0ccocxEd1ighRgK-V1uiWmCQ@mail.gmail.com>
In-Reply-To: <CACGkMEt8MSS=tcn=Hd6WF9+btT0ccocxEd1ighRgK-V1uiWmCQ@mail.gmail.com>
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
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, "Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>, Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, linux-um@lists.infradead.org, netdev <netdev@vger.kernel.org>, platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, kvm <kvm@vger.kernel.org>, "open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>, kangjie.xu@linux.alibaba.com, virtualization <virtualization@lists.linux-foundation.org>

T24gRnJpLCA4IEp1bCAyMDIyIDE0OjIzOjU3ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPiBPbiBUdWUsIEp1bCA1LCAyMDIyIGF0IDEwOjAxIEFNIFh1YW4g
Wmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIE1vbiwg
NCBKdWwgMjAyMiAxMTo0NTo1MiArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNv
bT4gd3JvdGU6Cj4gPiA+Cj4gPiA+IOWcqCAyMDIyLzYvMjkgMTQ6NTYsIFh1YW4gWmh1byDlhpnp
gZM6Cj4gPiA+ID4gVGhpcyBwYXRjaCBpbXBsZW1lbnRzIHRoZSByZXNpemUgZnVuY3Rpb24gb2Yg
dGhlIHR4IHF1ZXVlcy4KPiA+ID4gPiBCYXNlZCBvbiB0aGlzIGZ1bmN0aW9uLCBpdCBpcyBwb3Nz
aWJsZSB0byBtb2RpZnkgdGhlIHJpbmcgbnVtIG9mIHRoZQo+ID4gPiA+IHF1ZXVlLgo+ID4gPiA+
Cj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJh
LmNvbT4KPiA+ID4gPiAtLS0KPiA+ID4gPiAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDQ4
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiA+ID4gPiAgIDEgZmls
ZSBjaGFuZ2VkLCA0OCBpbnNlcnRpb25zKCspCj4gPiA+ID4KPiA+ID4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+
ID4gaW5kZXggNmFiMTZmZDE5M2U1Li5mZDM1ODQ2MmY4MDIgMTAwNjQ0Cj4gPiA+ID4gLS0tIGEv
ZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlv
X25ldC5jCj4gPiA+ID4gQEAgLTEzNSw2ICsxMzUsOSBAQCBzdHJ1Y3Qgc2VuZF9xdWV1ZSB7Cj4g
PiA+ID4gICAgIHN0cnVjdCB2aXJ0bmV0X3NxX3N0YXRzIHN0YXRzOwo+ID4gPiA+Cj4gPiA+ID4g
ICAgIHN0cnVjdCBuYXBpX3N0cnVjdCBuYXBpOwo+ID4gPiA+ICsKPiA+ID4gPiArICAgLyogUmVj
b3JkIHdoZXRoZXIgc3EgaXMgaW4gcmVzZXQgc3RhdGUuICovCj4gPiA+ID4gKyAgIGJvb2wgcmVz
ZXQ7Cj4gPiA+ID4gICB9Owo+ID4gPiA+Cj4gPiA+ID4gICAvKiBJbnRlcm5hbCByZXByZXNlbnRh
dGlvbiBvZiBhIHJlY2VpdmUgdmlydHF1ZXVlICovCj4gPiA+ID4gQEAgLTI3OSw2ICsyODIsNyBA
QCBzdHJ1Y3QgcGFkZGVkX3ZuZXRfaGRyIHsKPiA+ID4gPiAgIH07Cj4gPiA+ID4KPiA+ID4gPiAg
IHN0YXRpYyB2b2lkIHZpcnRuZXRfcnFfZnJlZV91bnVzZWRfYnVmKHN0cnVjdCB2aXJ0cXVldWUg
KnZxLCB2b2lkICpidWYpOwo+ID4gPiA+ICtzdGF0aWMgdm9pZCB2aXJ0bmV0X3NxX2ZyZWVfdW51
c2VkX2J1ZihzdHJ1Y3QgdmlydHF1ZXVlICp2cSwgdm9pZCAqYnVmKTsKPiA+ID4gPgo+ID4gPiA+
ICAgc3RhdGljIGJvb2wgaXNfeGRwX2ZyYW1lKHZvaWQgKnB0cikKPiA+ID4gPiAgIHsKPiA+ID4g
PiBAQCAtMTYwMyw2ICsxNjA3LDExIEBAIHN0YXRpYyB2b2lkIHZpcnRuZXRfcG9sbF9jbGVhbnR4
KHN0cnVjdCByZWNlaXZlX3F1ZXVlICpycSkKPiA+ID4gPiAgICAgICAgICAgICByZXR1cm47Cj4g
PiA+ID4KPiA+ID4gPiAgICAgaWYgKF9fbmV0aWZfdHhfdHJ5bG9jayh0eHEpKSB7Cj4gPiA+ID4g
KyAgICAgICAgICAgaWYgKFJFQURfT05DRShzcS0+cmVzZXQpKSB7Cj4gPiA+ID4gKyAgICAgICAg
ICAgICAgICAgICBfX25ldGlmX3R4X3VubG9jayh0eHEpOwo+ID4gPiA+ICsgICAgICAgICAgICAg
ICAgICAgcmV0dXJuOwo+ID4gPiA+ICsgICAgICAgICAgIH0KPiA+ID4gPiArCj4gPiA+ID4gICAg
ICAgICAgICAgZG8gewo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgdmlydHF1ZXVlX2Rpc2Fi
bGVfY2Ioc3EtPnZxKTsKPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgIGZyZWVfb2xkX3htaXRf
c2ticyhzcSwgdHJ1ZSk7Cj4gPiA+ID4gQEAgLTE4NjgsNiArMTg3Nyw0NSBAQCBzdGF0aWMgaW50
IHZpcnRuZXRfcnhfcmVzaXplKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+ID4gPiA+ICAgICBy
ZXR1cm4gZXJyOwo+ID4gPiA+ICAgfQo+ID4gPiA+Cj4gPiA+ID4gK3N0YXRpYyBpbnQgdmlydG5l
dF90eF9yZXNpemUoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksCj4gPiA+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgIHN0cnVjdCBzZW5kX3F1ZXVlICpzcSwgdTMyIHJpbmdfbnVtKQo+ID4gPiA+
ICt7Cj4gPiA+ID4gKyAgIHN0cnVjdCBuZXRkZXZfcXVldWUgKnR4cTsKPiA+ID4gPiArICAgaW50
IGVyciwgcWluZGV4Owo+ID4gPiA+ICsKPiA+ID4gPiArICAgcWluZGV4ID0gc3EgLSB2aS0+c3E7
Cj4gPiA+ID4gKwo+ID4gPiA+ICsgICB2aXJ0bmV0X25hcGlfdHhfZGlzYWJsZSgmc3EtPm5hcGkp
Owo+ID4gPiA+ICsKPiA+ID4gPiArICAgdHhxID0gbmV0ZGV2X2dldF90eF9xdWV1ZSh2aS0+ZGV2
LCBxaW5kZXgpOwo+ID4gPiA+ICsKPiA+ID4gPiArICAgLyogMS4gd2FpdCBhbGwgeGltdCBjb21w
bGV0ZQo+ID4gPiA+ICsgICAgKiAyLiBmaXggdGhlIHJhY2Ugb2YgbmV0aWZfc3RvcF9zdWJxdWV1
ZSgpIHZzIG5ldGlmX3N0YXJ0X3N1YnF1ZXVlKCkKPiA+ID4gPiArICAgICovCj4gPiA+ID4gKyAg
IF9fbmV0aWZfdHhfbG9ja19iaCh0eHEpOwo+ID4gPiA+ICsKPiA+ID4gPiArICAgLyogUHJldmVu
dCByeCBwb2xsIGZyb20gYWNjZXNzaW5nIHNxLiAqLwo+ID4gPiA+ICsgICBXUklURV9PTkNFKHNx
LT5yZXNldCwgdHJ1ZSk7Cj4gPiA+Cj4gPiA+Cj4gPiA+IENhbiB3ZSBzaW1wbHkgZGlzYWJsZSBS
WCBOQVBJIGhlcmU/Cj4gPgo+ID4gRGlzYWJsZSByeCBuYXBpIGlzIGluZGVlZCBhIHNpbXBsZSBz
b2x1dGlvbi4gQnV0IEkgaG9wZSB0aGF0IHdoZW4gZGVhbGluZyB3aXRoCj4gPiB0eCwgaXQgd2ls
bCBub3QgYWZmZWN0IHJ4Lgo+Cj4gT2ssIGJ1dCBJIHRoaW5rIHdlJ3ZlIGFscmVhZHkgc3luY2hy
b25pemVkIHdpdGggdHggbG9jayBoZXJlLCBpc24ndCBpdD8KClllcywgZG8geW91IGhhdmUgYW55
IHF1ZXN0aW9ucyBhYm91dCBXUklURV9PTkNFKCk/IFRoZXJlIGlzIGEgc2V0IGZhbHNlIG9wZXJh
dGlvbgpsYXRlciwgSSBkaWQgbm90IHVzZSBsb2NrIHRoZXJlLCBzbyBJIHVzZWQgV1JJVEUvUkVB
RF9PTkNFCnVuaWZvcm1seS4KClRoYW5rcy4KCj4KPiBUaGFua3MKPgo+ID4KPiA+IFRoYW5rcy4K
PiA+Cj4gPgo+ID4gPgo+ID4gPiBUaGFua3MKPiA+ID4KPiA+ID4KPiA+ID4gPiArCj4gPiA+ID4g
KyAgIC8qIFByZXZlbnQgdGhlIHVwcGVyIGxheWVyIGZyb20gdHJ5aW5nIHRvIHNlbmQgcGFja2V0
cy4gKi8KPiA+ID4gPiArICAgbmV0aWZfc3RvcF9zdWJxdWV1ZSh2aS0+ZGV2LCBxaW5kZXgpOwo+
ID4gPiA+ICsKPiA+ID4gPiArICAgX19uZXRpZl90eF91bmxvY2tfYmgodHhxKTsKPiA+ID4gPiAr
Cj4gPiA+ID4gKyAgIGVyciA9IHZpcnRxdWV1ZV9yZXNpemUoc3EtPnZxLCByaW5nX251bSwgdmly
dG5ldF9zcV9mcmVlX3VudXNlZF9idWYpOwo+ID4gPiA+ICsgICBpZiAoZXJyKQo+ID4gPiA+ICsg
ICAgICAgICAgIG5ldGRldl9lcnIodmktPmRldiwgInJlc2l6ZSB0eCBmYWlsOiB0eCBxdWV1ZSBp
bmRleDogJWQgZXJyOiAlZFxuIiwgcWluZGV4LCBlcnIpOwo+ID4gPiA+ICsKPiA+ID4gPiArICAg
LyogTWVtb3J5IGJhcnJpZXIgYmVmb3JlIHNldCByZXNldCBhbmQgc3RhcnQgc3VicXVldWUuICov
Cj4gPiA+ID4gKyAgIHNtcF9tYigpOwo+ID4gPiA+ICsKPiA+ID4gPiArICAgV1JJVEVfT05DRShz
cS0+cmVzZXQsIGZhbHNlKTsKPiA+ID4gPiArICAgbmV0aWZfdHhfd2FrZV9xdWV1ZSh0eHEpOwo+
ID4gPiA+ICsKPiA+ID4gPiArICAgdmlydG5ldF9uYXBpX3R4X2VuYWJsZSh2aSwgc3EtPnZxLCAm
c3EtPm5hcGkpOwo+ID4gPiA+ICsgICByZXR1cm4gZXJyOwo+ID4gPiA+ICt9Cj4gPiA+ID4gKwo+
ID4gPiA+ICAgLyoKPiA+ID4gPiAgICAqIFNlbmQgY29tbWFuZCB2aWEgdGhlIGNvbnRyb2wgdmly
dHF1ZXVlIGFuZCBjaGVjayBzdGF0dXMuICBDb21tYW5kcwo+ID4gPiA+ICAgICogc3VwcG9ydGVk
IGJ5IHRoZSBoeXBlcnZpc29yLCBhcyBpbmRpY2F0ZWQgYnkgZmVhdHVyZSBiaXRzLCBzaG91bGQK
PiA+ID4KPiA+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K


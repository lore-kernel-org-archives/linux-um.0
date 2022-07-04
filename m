Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8D3q-004FIB-Ak
	for linux-um@lists.infradead.org; Mon, 04 Jul 2022 03:47:47 +0000
Received: by mail-pl1-f197.google.com with SMTP id l16-20020a170903121000b0016a64bbe81cso4468176plh.11
        for <linux-um@lists.infradead.org>; Sun, 03 Jul 2022 20:47:42 -0700 (PDT)
Message-ID: <2fdff856-cddf-1235-8078-312de94600c7@redhat.com>
Date: Mon, 4 Jul 2022 11:47:28 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v11 25/40] virtio: allow to unbreak/break virtqueue
 individually
From: Jason Wang <jasowang@redhat.com>
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-26-xuanzhuo@linux.alibaba.com>
 <20220701022950-mutt-send-email-mst@kernel.org>
 <79e519ec-0129-6a21-11da-44eaff1429fa@redhat.com>
In-Reply-To: <79e519ec-0129-6a21-11da-44eaff1429fa@redhat.com>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>, Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, linux-um@lists.infradead.org, netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, kangjie.xu@linux.alibaba.com

CuWcqCAyMDIyLzcvMSAxNzozNiwgSmFzb24gV2FuZyDlhpnpgZM6Cj4KPiDlnKggMjAyMi83LzEg
MTQ6MzEsIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6Cj4+IE9uIFdlZCwgSnVuIDI5LCAyMDIy
IGF0IDAyOjU2OjQxUE0gKzA4MDAsIFh1YW4gWmh1byB3cm90ZToKPj4+IFRoaXMgcGF0Y2ggYWxs
b3dzIHRoZSBuZXcgaW50cm9kdWNlZAo+Pj4gX192aXJ0cXVldWVfYnJlYWsoKS9fX3ZpcnRxdWV1
ZV91bmJyZWFrKCkgdG8gYnJlYWsvdW5icmVhayB0aGUKPj4+IHZpcnRxdWV1ZS4KPj4+Cj4+PiBT
aWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+PiBJ
IHdvbmRlciBob3cgdGhpcyBpbnRlcmFjdHMgd2l0aCB0aGUgaGFyZGVuaW5nIHBhdGNoZXMuCj4+
IEphc29uPwo+Cj4KPiBDb25zaWRlciB3ZSd2ZSBtYXJrZWQgaXQgYXMgYnJva2VuLCBJIHRoaW5r
IHdlIGRvbid0IG5lZWQgdG8gY2FyZSAKPiBhYm91dCB0aGUgaGFyZGVuaW5nIGluIHRoaXMgc2Vy
aWVzLiBKdXN0IG1ha2UgaXQgd29yayB3aXRob3V0IGhhcmRlbmluZy4KPgo+IEFuZCBJIHdpbGwg
aGFuZGxlIHZxIHJlc2V0IHdoZW4gcmV3b3JrIHRoZSBJUlEgaGFyZGVuaW5nLgo+Cj4gVGhhbmtz
CgoKUmV0aGluayBvZiB0aGlzLCBJIHRoaW5rIFh1YW4ncyBjb2RlIHNob3VsZCBiZSBmaW5lLiBX
ZSBrbm93IHdlIHdpbGwgCmhhdmUgYW5vdGhlciByZXdvcmsuCgpUaGFua3MKCgo+Cj4KPj4KPj4+
IC0tLQo+Pj4gwqAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDI0ICsrKysrKysrKysr
KysrKysrKysrKysrKwo+Pj4gwqAgaW5jbHVkZS9saW51eC92aXJ0aW8uaMKgwqDCoMKgwqDCoCB8
wqAgMyArKysKPj4+IMKgIDIgZmlsZXMgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKQo+Pj4KPj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIAo+Pj4gYi9kcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcmluZy5jCj4+PiBpbmRleCA1ZWM0MzYwN2NjMTUuLjdiMDJiZTdmY2U2
NyAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPj4+ICsrKyBi
L2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPj4+IEBAIC0yNzQ0LDYgKzI3NDQsMzAgQEAg
dW5zaWduZWQgaW50IHZpcnRxdWV1ZV9nZXRfdnJpbmdfc2l6ZShzdHJ1Y3QgCj4+PiB2aXJ0cXVl
dWUgKl92cSkKPj4+IMKgIH0KPj4+IMKgIEVYUE9SVF9TWU1CT0xfR1BMKHZpcnRxdWV1ZV9nZXRf
dnJpbmdfc2l6ZSk7Cj4+PiDCoCArLyoKPj4+ICsgKiBUaGlzIGZ1bmN0aW9uIHNob3VsZCBvbmx5
IGJlIGNhbGxlZCBieSB0aGUgY29yZSwgbm90IGRpcmVjdGx5IGJ5IAo+Pj4gdGhlIGRyaXZlci4K
Pj4+ICsgKi8KPj4+ICt2b2lkIF9fdmlydHF1ZXVlX2JyZWFrKHN0cnVjdCB2aXJ0cXVldWUgKl92
cSkKPj4+ICt7Cj4+PiArwqDCoMKgIHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxID0gdG9fdnZx
KF92cSk7Cj4+PiArCj4+PiArwqDCoMKgIC8qIFBhaXJzIHdpdGggUkVBRF9PTkNFKCkgaW4gdmly
dHF1ZXVlX2lzX2Jyb2tlbigpLiAqLwo+Pj4gK8KgwqDCoCBXUklURV9PTkNFKHZxLT5icm9rZW4s
IHRydWUpOwo+Pj4gK30KPj4+ICtFWFBPUlRfU1lNQk9MX0dQTChfX3ZpcnRxdWV1ZV9icmVhayk7
Cj4+PiArCj4+PiArLyoKPj4+ICsgKiBUaGlzIGZ1bmN0aW9uIHNob3VsZCBvbmx5IGJlIGNhbGxl
ZCBieSB0aGUgY29yZSwgbm90IGRpcmVjdGx5IGJ5IAo+Pj4gdGhlIGRyaXZlci4KPj4+ICsgKi8K
Pj4+ICt2b2lkIF9fdmlydHF1ZXVlX3VuYnJlYWsoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxKQo+Pj4g
K3sKPj4+ICvCoMKgwqAgc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEgPSB0b192dnEoX3ZxKTsK
Pj4+ICsKPj4+ICvCoMKgwqAgLyogUGFpcnMgd2l0aCBSRUFEX09OQ0UoKSBpbiB2aXJ0cXVldWVf
aXNfYnJva2VuKCkuICovCj4+PiArwqDCoMKgIFdSSVRFX09OQ0UodnEtPmJyb2tlbiwgZmFsc2Up
Owo+Pj4gK30KPj4gSSBkb24ndCB0aGluayB0aGVzZSAiUGFpcnMiIGNvbW1lbnRzIGhhdmUgYW55
IHZhbHVlLgo+Pgo+Pgo+Pj4gK0VYUE9SVF9TWU1CT0xfR1BMKF9fdmlydHF1ZXVlX3VuYnJlYWsp
Owo+Pj4gKwo+Pj4gwqAgYm9vbCB2aXJ0cXVldWVfaXNfYnJva2VuKHN0cnVjdCB2aXJ0cXVldWUg
Kl92cSkKPj4+IMKgIHsKPj4+IMKgwqDCoMKgwqAgc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEg
PSB0b192dnEoX3ZxKTsKPj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oIGIv
aW5jbHVkZS9saW51eC92aXJ0aW8uaAo+Pj4gaW5kZXggMTI3MjU2NmFkZWM2Li5kYzQ3NGEwZDQ4
ZDEgMTAwNjQ0Cj4+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oCj4+PiArKysgYi9pbmNs
dWRlL2xpbnV4L3ZpcnRpby5oCj4+PiBAQCAtMTM4LDYgKzEzOCw5IEBAIGJvb2wgaXNfdmlydGlv
X2RldmljZShzdHJ1Y3QgZGV2aWNlICpkZXYpOwo+Pj4gwqAgdm9pZCB2aXJ0aW9fYnJlYWtfZGV2
aWNlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICpkZXYpOwo+Pj4gwqAgdm9pZCBfX3ZpcnRpb191bmJy
ZWFrX2RldmljZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqZGV2KTsKPj4+IMKgICt2b2lkIF9fdmly
dHF1ZXVlX2JyZWFrKHN0cnVjdCB2aXJ0cXVldWUgKl92cSk7Cj4+PiArdm9pZCBfX3ZpcnRxdWV1
ZV91bmJyZWFrKHN0cnVjdCB2aXJ0cXVldWUgKl92cSk7Cj4+PiArCj4+PiDCoCB2b2lkIHZpcnRp
b19jb25maWdfY2hhbmdlZChzdHJ1Y3QgdmlydGlvX2RldmljZSAqZGV2KTsKPj4+IMKgICNpZmRl
ZiBDT05GSUdfUE1fU0xFRVAKPj4+IMKgIGludCB2aXJ0aW9fZGV2aWNlX2ZyZWV6ZShzdHJ1Y3Qg
dmlydGlvX2RldmljZSAqZGV2KTsKPj4+IC0tIAo+Pj4gMi4zMS4wCgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0Cmxp
bnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC11bQo=


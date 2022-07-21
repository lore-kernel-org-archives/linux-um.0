Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oESGH-0035bI-Qr
	for linux-um@lists.infradead.org; Thu, 21 Jul 2022 09:14:27 +0000
Received: by mail-pj1-f70.google.com with SMTP id mi13-20020a17090b4b4d00b001ef9759d26aso3010396pjb.0
        for <linux-um@lists.infradead.org>; Thu, 21 Jul 2022 02:14:23 -0700 (PDT)
Message-ID: <da5ddf3b-3db7-7f25-a0f6-63a39e6af2a2@redhat.com>
Date: Thu, 21 Jul 2022 17:14:10 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v12 24/40] virtio: allow to unbreak/break virtqueue
 individually
References: <20220720030436.79520-1-xuanzhuo@linux.alibaba.com>
 <20220720030436.79520-25-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220720030436.79520-25-xuanzhuo@linux.alibaba.com>
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
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux-foundation.org
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, "Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>, Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, linux-um@lists.infradead.org, netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, kangjie.xu@linux.alibaba.com

CuWcqCAyMDIyLzcvMjAgMTE6MDQsIFh1YW4gWmh1byDlhpnpgZM6Cj4gVGhpcyBwYXRjaCBhbGxv
d3MgdGhlIG5ldyBpbnRyb2R1Y2VkCj4gX192aXJ0cXVldWVfYnJlYWsoKS9fX3ZpcnRxdWV1ZV91
bmJyZWFrKCkgdG8gYnJlYWsvdW5icmVhayB0aGUKPiB2aXJ0cXVldWUuCj4KPiBTaWduZWQtb2Zm
LWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgoKCkFja2VkLWJ5OiBK
YXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKCj4gLS0tCj4gICBkcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcmluZy5jIHwgMjQgKysrKysrKysrKysrKysrKysrKysrKysrCj4gICBpbmNsdWRl
L2xpbnV4L3ZpcnRpby5oICAgICAgIHwgIDMgKysrCj4gICAyIGZpbGVzIGNoYW5nZWQsIDI3IGlu
c2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5j
IGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IGluZGV4IGNmNDM3OTE3NTE2My4uYmY2
NjZkYWQ5OTA0IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiAr
KysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gQEAgLTI3MzAsNiArMjczMCwzMCBA
QCB1bnNpZ25lZCBpbnQgdmlydHF1ZXVlX2dldF92cmluZ19zaXplKHN0cnVjdCB2aXJ0cXVldWUg
Kl92cSkKPiAgIH0KPiAgIEVYUE9SVF9TWU1CT0xfR1BMKHZpcnRxdWV1ZV9nZXRfdnJpbmdfc2l6
ZSk7Cj4gICAKPiArLyoKPiArICogVGhpcyBmdW5jdGlvbiBzaG91bGQgb25seSBiZSBjYWxsZWQg
YnkgdGhlIGNvcmUsIG5vdCBkaXJlY3RseSBieSB0aGUgZHJpdmVyLgo+ICsgKi8KPiArdm9pZCBf
X3ZpcnRxdWV1ZV9icmVhayhzdHJ1Y3QgdmlydHF1ZXVlICpfdnEpCj4gK3sKPiArCXN0cnVjdCB2
cmluZ192aXJ0cXVldWUgKnZxID0gdG9fdnZxKF92cSk7Cj4gKwo+ICsJLyogUGFpcnMgd2l0aCBS
RUFEX09OQ0UoKSBpbiB2aXJ0cXVldWVfaXNfYnJva2VuKCkuICovCj4gKwlXUklURV9PTkNFKHZx
LT5icm9rZW4sIHRydWUpOwo+ICt9Cj4gK0VYUE9SVF9TWU1CT0xfR1BMKF9fdmlydHF1ZXVlX2Jy
ZWFrKTsKPiArCj4gKy8qCj4gKyAqIFRoaXMgZnVuY3Rpb24gc2hvdWxkIG9ubHkgYmUgY2FsbGVk
IGJ5IHRoZSBjb3JlLCBub3QgZGlyZWN0bHkgYnkgdGhlIGRyaXZlci4KPiArICovCj4gK3ZvaWQg
X192aXJ0cXVldWVfdW5icmVhayhzdHJ1Y3QgdmlydHF1ZXVlICpfdnEpCj4gK3sKPiArCXN0cnVj
dCB2cmluZ192aXJ0cXVldWUgKnZxID0gdG9fdnZxKF92cSk7Cj4gKwo+ICsJLyogUGFpcnMgd2l0
aCBSRUFEX09OQ0UoKSBpbiB2aXJ0cXVldWVfaXNfYnJva2VuKCkuICovCj4gKwlXUklURV9PTkNF
KHZxLT5icm9rZW4sIGZhbHNlKTsKPiArfQo+ICtFWFBPUlRfU1lNQk9MX0dQTChfX3ZpcnRxdWV1
ZV91bmJyZWFrKTsKPiArCj4gICBib29sIHZpcnRxdWV1ZV9pc19icm9rZW4oc3RydWN0IHZpcnRx
dWV1ZSAqX3ZxKQo+ICAgewo+ICAgCXN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxID0gdG9fdnZx
KF92cSk7Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmlydGlvLmggYi9pbmNsdWRlL2xp
bnV4L3ZpcnRpby5oCj4gaW5kZXggNjJlMzFiY2E1NjAyLi5kNDVlZTgyYTQ0NzAgMTAwNjQ0Cj4g
LS0tIGEvaW5jbHVkZS9saW51eC92aXJ0aW8uaAo+ICsrKyBiL2luY2x1ZGUvbGludXgvdmlydGlv
LmgKPiBAQCAtMTM4LDYgKzEzOCw5IEBAIGJvb2wgaXNfdmlydGlvX2RldmljZShzdHJ1Y3QgZGV2
aWNlICpkZXYpOwo+ICAgdm9pZCB2aXJ0aW9fYnJlYWtfZGV2aWNlKHN0cnVjdCB2aXJ0aW9fZGV2
aWNlICpkZXYpOwo+ICAgdm9pZCBfX3ZpcnRpb191bmJyZWFrX2RldmljZShzdHJ1Y3QgdmlydGlv
X2RldmljZSAqZGV2KTsKPiAgIAo+ICt2b2lkIF9fdmlydHF1ZXVlX2JyZWFrKHN0cnVjdCB2aXJ0
cXVldWUgKl92cSk7Cj4gK3ZvaWQgX192aXJ0cXVldWVfdW5icmVhayhzdHJ1Y3QgdmlydHF1ZXVl
ICpfdnEpOwo+ICsKPiAgIHZvaWQgdmlydGlvX2NvbmZpZ19jaGFuZ2VkKHN0cnVjdCB2aXJ0aW9f
ZGV2aWNlICpkZXYpOwo+ICAgI2lmZGVmIENPTkZJR19QTV9TTEVFUAo+ICAgaW50IHZpcnRpb19k
ZXZpY2VfZnJlZXplKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICpkZXYpOwoKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdAps
aW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtdW0K


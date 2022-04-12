Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1neAj2-00C7oL-DN
 for linux-um@lists.infradead.org; Tue, 12 Apr 2022 07:14:09 +0000
Received: by mail-pj1-f72.google.com with SMTP id
 38-20020a17090a09a900b001cb95d9ea46so2829112pjo.7
 for <linux-um@lists.infradead.org>; Tue, 12 Apr 2022 00:14:06 -0700 (PDT)
Message-ID: <e8298f3d-dd58-8031-606f-f0fb061a7c95@redhat.com>
Date: Tue, 12 Apr 2022 15:13:53 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v9 26/32] virtio_mmio: support the arg sizes of find_vqs()
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-27-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-27-xuanzhuo@linux.alibaba.com>
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
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, "Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>, Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Johannes Berg <johannes.berg@intel.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, linux-um@lists.infradead.org, netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org

CuWcqCAyMDIyLzQvNiDkuIrljYgxMTo0MywgWHVhbiBaaHVvIOWGmemBkzoKPiBWaXJ0aW8gTU1J
TyBzdXBwb3J0IHRoZSBuZXcgcGFyYW1ldGVyIHNpemVzIG9mIGZpbmRfdnFzKCkuCj4KPiBTaWdu
ZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+IC0tLQoK
CkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKCj4gICBkcml2ZXJz
L3ZpcnRpby92aXJ0aW9fbW1pby5jIHwgOCArKysrKystLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDYg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zp
cnRpby92aXJ0aW9fbW1pby5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX21taW8uYwo+IGluZGV4
IDlkNWE2NzRiZGVlYy4uNTFjZjUxNzY0YTkyIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlv
L3ZpcnRpb19tbWlvLmMKPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fbW1pby5jCj4gQEAg
LTM0Nyw3ICszNDcsNyBAQCBzdGF0aWMgdm9pZCB2bV9kZWxfdnFzKHN0cnVjdCB2aXJ0aW9fZGV2
aWNlICp2ZGV2KQo+ICAgCj4gICBzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqdm1fc2V0dXBfdnEo
c3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsIHVuc2lnbmVkIGluZGV4LAo+ICAgCQkJCSAgdm9p
ZCAoKmNhbGxiYWNrKShzdHJ1Y3QgdmlydHF1ZXVlICp2cSksCj4gLQkJCQkgIGNvbnN0IGNoYXIg
Km5hbWUsIGJvb2wgY3R4KQo+ICsJCQkJICBjb25zdCBjaGFyICpuYW1lLCB1MzIgc2l6ZSwgYm9v
bCBjdHgpCj4gICB7Cj4gICAJc3RydWN0IHZpcnRpb19tbWlvX2RldmljZSAqdm1fZGV2ID0gdG9f
dmlydGlvX21taW9fZGV2aWNlKHZkZXYpOwo+ICAgCXN0cnVjdCB2aXJ0aW9fbW1pb192cV9pbmZv
ICppbmZvOwo+IEBAIC0zODIsOCArMzgyLDExIEBAIHN0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICp2
bV9zZXR1cF92cShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwgdW5zaWduZWQgaW5kZXgsCj4g
ICAJCWdvdG8gZXJyb3JfbmV3X3ZpcnRxdWV1ZTsKPiAgIAl9Cj4gICAKPiArCWlmICghc2l6ZSB8
fCBzaXplID4gbnVtKQo+ICsJCXNpemUgPSBudW07Cj4gKwo+ICAgCS8qIENyZWF0ZSB0aGUgdnJp
bmcgKi8KPiAtCXZxID0gdnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZShpbmRleCwgbnVtLCBWSVJUSU9f
TU1JT19WUklOR19BTElHTiwgdmRldiwKPiArCXZxID0gdnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZShp
bmRleCwgc2l6ZSwgVklSVElPX01NSU9fVlJJTkdfQUxJR04sIHZkZXYsCj4gICAJCQkJIHRydWUs
IHRydWUsIGN0eCwgdm1fbm90aWZ5LCBjYWxsYmFjaywgbmFtZSk7Cj4gICAJaWYgKCF2cSkgewo+
ICAgCQllcnIgPSAtRU5PTUVNOwo+IEBAIC00ODQsNiArNDg3LDcgQEAgc3RhdGljIGludCB2bV9m
aW5kX3ZxcyhzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwgdW5zaWduZWQgbnZxcywKPiAgIAkJ
fQo+ICAgCj4gICAJCXZxc1tpXSA9IHZtX3NldHVwX3ZxKHZkZXYsIHF1ZXVlX2lkeCsrLCBjYWxs
YmFja3NbaV0sIG5hbWVzW2ldLAo+ICsJCQkJICAgICBzaXplcyA/IHNpemVzW2ldIDogMCwKPiAg
IAkJCQkgICAgIGN0eCA/IGN0eFtpXSA6IGZhbHNlKTsKPiAgIAkJaWYgKElTX0VSUih2cXNbaV0p
KSB7Cj4gICAJCQl2bV9kZWxfdnFzKHZkZXYpOwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtdW0K


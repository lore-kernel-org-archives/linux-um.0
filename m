Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRsc5-007ue4-CB
 for linux-um@lists.infradead.org; Wed, 09 Mar 2022 09:28:10 +0000
Message-ID: <1646818039.8335996-8-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v7 14/26] virtio: add helper for queue reset
Date: Wed, 9 Mar 2022 17:27:19 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-15-xuanzhuo@linux.alibaba.com>
 <fda406d7-3ed9-7c62-0f26-4058a63e73a9@redhat.com>
In-Reply-To: <fda406d7-3ed9-7c62-0f26-4058a63e73a9@redhat.com>
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
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, "Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>, Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Johannes Berg <johannes.berg@intel.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, linux-um@lists.infradead.org, platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org

T24gV2VkLCA5IE1hciAyMDIyIDE2OjQ4OjI4ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+IOWcqCAyMDIyLzMvOCDkuIvljYg4OjM1LCBYdWFuIFpodW8g
5YaZ6YGTOgo+ID4gQWRkIGhlbHBlciBmb3IgdmlydGlvIHF1ZXVlIHJlc2V0Lgo+ID4KPiA+ICog
dmlydGlvX3Jlc2V0X3ZxKCk6IHJlc2V0IGEgcXVldWUgaW5kaXZpZHVhbGx5Cj4gPiAqIHZpcnRp
b19lbmFibGVfcmVzZXRxKCk6IGVuYWJsZSBhIHJlc2V0IHF1ZXVlCj4gPgo+ID4gU2lnbmVkLW9m
Zi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiA+IC0tLQo+ID4g
ICBpbmNsdWRlL2xpbnV4L3ZpcnRpb19jb25maWcuaCB8IDQwICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA0MCBpbnNlcnRpb25zKCspCj4g
Pgo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oIGIvaW5jbHVk
ZS9saW51eC92aXJ0aW9fY29uZmlnLmgKPiA+IGluZGV4IGQ1MTkwNmIxMzg5Zi4uMGI4MWZiZTE3
Yzg1IDEwMDY0NAo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmgKPiA+ICsr
KyBiL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oCj4gPiBAQCAtMjMwLDYgKzIzMCw0NiBA
QCBpbnQgdmlydGlvX2ZpbmRfdnFzX2N0eChzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwgdW5z
aWduZWQgbnZxcywKPiA+ICAgCQkJCSAgICAgIGRlc2MpOwo+ID4gICB9Cj4gPgo+ID4gKy8qKgo+
ID4gKyAqIHZpcnRpb19yZXNldF92cSAtIHJlc2V0IGEgcXVldWUgaW5kaXZpZHVhbGx5Cj4gPiAr
ICogQHZxOiB0aGUgdmlydHF1ZXVlCj4gPiArICoKPiA+ICsgKiByZXR1cm5zIDAgb24gc3VjY2Vz
cyBvciBlcnJvciBzdGF0dXMKPiA+ICsgKgo+ID4gKyAqIFRoZSBhcGkgcHJvY2VzcyBvZiByZXNl
dCB1bmRlciBub3JtYWwgY2lyY3Vtc3RhbmNlczoKPiA+ICsgKgkxLiB2aXJ0aW9fcmVzZXRfdnEo
KSAgICAgICAgICAgICAgLSBub3RpZnkgdGhlIGRldmljZSB0byByZXNldCB0aGUgcXVldWUKPiA+
ICsgKgkyLiB2aXJ0cXVldWVfZGV0YWNoX3VudXNlZF9idWYoKSAgLSByZWN5Y2xlIHRoZSBidWZm
ZXIgc3VibWl0dGVkCj4gPiArICoJMy4gdmlydHF1ZXVlX3Jlc2V0X3ZyaW5nKCkgICAgICAgIC0g
cmVzZXQgdGhlIHZyaW5nIChtYXkgcmUtYWxsb2MpCj4gPiArICoJNC4gdmlydGlvX2VuYWJsZV9y
ZXNldHEoKSAgICAgICAgIC0gbW1hcCB2cmluZyB0byBkZXZpY2UsIGFuZCBlbmFibGUgdGhlIHF1
ZXVlCj4gPiArICoKPiA+ICsgKiBDYWxsZXIgc2hvdWxkIGd1YXJhbnRlZSB0aGF0IHRoZSB2cmlu
ZyBpcyBub3QgYWNjZXNzZWQgYnkgYW55IGZ1bmN0aW9ucwo+ID4gKyAqIG9mIHZpcnRxdWV1ZS4K
PiA+ICsgKi8KPiA+ICtzdGF0aWMgaW5saW5lCj4gPiAraW50IHZpcnRpb19yZXNldF92cShzdHJ1
Y3QgdmlydHF1ZXVlICp2cSkKPiA+ICt7Cj4KPgo+IEl0IGxvb2tzIHRvIG1lIHRoZSBwcmVmaXgg
InZpcnRpbyIgaXMgdXNlZCBmb3IgdGhlIGRldmljZSBzcGVjaWZpYwo+IG9wZXJhdGlvbnMuCj4K
PiBJIHdvbmRlciBpZiBpdCdzIGJldHRlciB0byByZW5hbWUgdGhpcyBhcyB2aXJ0cXVldWVfcmVz
dGUoKSBhbmQgbW92ZSBpdAo+IHRvIHZpcnRpb19yaW5nLmM/CgpDYWxsIHZxLT52ZGV2LT5jb25m
aWctPnJlc2V0X3ZxIGluIHZpcnRpb19yaW5nLmM/CgpJZiBpdCBmaXRzLCBJIHRoaW5rIGl0J3Mg
ZmluZS4KClRoYW5rcy4KCj4KPiBUaGFua3MKPgo+Cj4gPiArCWlmICghdnEtPnZkZXYtPmNvbmZp
Zy0+cmVzZXRfdnEpCj4gPiArCQlyZXR1cm4gLUVOT0VOVDsKPiA+ICsKPiA+ICsJcmV0dXJuIHZx
LT52ZGV2LT5jb25maWctPnJlc2V0X3ZxKHZxKTsKPiA+ICt9Cj4gPiArCj4gPiArLyoqCj4gPiAr
ICogdmlydGlvX2VuYWJsZV9yZXNldHEgLSBlbmFibGUgYSByZXNldCBxdWV1ZQo+ID4gKyAqIEB2
cTogdGhlIHZpcnRxdWV1ZQo+ID4gKyAqCj4gPiArICogcmV0dXJucyAwIG9uIHN1Y2Nlc3Mgb3Ig
ZXJyb3Igc3RhdHVzCj4gPiArICoKPiA+ICsgKi8KPiA+ICtzdGF0aWMgaW5saW5lCj4gPiAraW50
IHZpcnRpb19lbmFibGVfcmVzZXRxKHN0cnVjdCB2aXJ0cXVldWUgKnZxKQo+ID4gK3sKPiA+ICsJ
aWYgKCF2cS0+dmRldi0+Y29uZmlnLT5lbmFibGVfcmVzZXRfdnEpCj4gPiArCQlyZXR1cm4gLUVO
T0VOVDsKPiA+ICsKPiA+ICsJcmV0dXJuIHZxLT52ZGV2LT5jb25maWctPmVuYWJsZV9yZXNldF92
cSh2cSk7Cj4gPiArfQo+ID4gKwo+ID4gICAvKioKPiA+ICAgICogdmlydGlvX2RldmljZV9yZWFk
eSAtIGVuYWJsZSB2cSB1c2UgaW4gcHJvYmUgZnVuY3Rpb24KPiA+ICAgICogQHZkZXY6IHRoZSBk
ZXZpY2UKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=


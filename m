Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRrzz-007n07-Fy
 for linux-um@lists.infradead.org; Wed, 09 Mar 2022 08:48:49 +0000
Received: by mail-pf1-f200.google.com with SMTP id
 k130-20020a628488000000b004f362b45f28so1180666pfd.9
 for <linux-um@lists.infradead.org>; Wed, 09 Mar 2022 00:48:43 -0800 (PST)
Message-ID: <fda406d7-3ed9-7c62-0f26-4058a63e73a9@redhat.com>
Date: Wed, 9 Mar 2022 16:48:28 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v7 14/26] virtio: add helper for queue reset
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-15-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220308123518.33800-15-xuanzhuo@linux.alibaba.com>
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
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, "Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>, Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Johannes Berg <johannes.berg@intel.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, linux-um@lists.infradead.org, platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org

CuWcqCAyMDIyLzMvOCDkuIvljYg4OjM1LCBYdWFuIFpodW8g5YaZ6YGTOgo+IEFkZCBoZWxwZXIg
Zm9yIHZpcnRpbyBxdWV1ZSByZXNldC4KPgo+ICogdmlydGlvX3Jlc2V0X3ZxKCk6IHJlc2V0IGEg
cXVldWUgaW5kaXZpZHVhbGx5Cj4gKiB2aXJ0aW9fZW5hYmxlX3Jlc2V0cSgpOiBlbmFibGUgYSBy
ZXNldCBxdWV1ZQo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5h
bGliYWJhLmNvbT4KPiAtLS0KPiAgIGluY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oIHwgNDAg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCA0
MCBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92aXJ0aW9fY29u
ZmlnLmggYi9pbmNsdWRlL2xpbnV4L3ZpcnRpb19jb25maWcuaAo+IGluZGV4IGQ1MTkwNmIxMzg5
Zi4uMGI4MWZiZTE3Yzg1IDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZp
Zy5oCj4gKysrIGIvaW5jbHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmgKPiBAQCAtMjMwLDYgKzIz
MCw0NiBAQCBpbnQgdmlydGlvX2ZpbmRfdnFzX2N0eChzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRl
diwgdW5zaWduZWQgbnZxcywKPiAgIAkJCQkgICAgICBkZXNjKTsKPiAgIH0KPiAgIAo+ICsvKioK
PiArICogdmlydGlvX3Jlc2V0X3ZxIC0gcmVzZXQgYSBxdWV1ZSBpbmRpdmlkdWFsbHkKPiArICog
QHZxOiB0aGUgdmlydHF1ZXVlCj4gKyAqCj4gKyAqIHJldHVybnMgMCBvbiBzdWNjZXNzIG9yIGVy
cm9yIHN0YXR1cwo+ICsgKgo+ICsgKiBUaGUgYXBpIHByb2Nlc3Mgb2YgcmVzZXQgdW5kZXIgbm9y
bWFsIGNpcmN1bXN0YW5jZXM6Cj4gKyAqCTEuIHZpcnRpb19yZXNldF92cSgpICAgICAgICAgICAg
ICAtIG5vdGlmeSB0aGUgZGV2aWNlIHRvIHJlc2V0IHRoZSBxdWV1ZQo+ICsgKgkyLiB2aXJ0cXVl
dWVfZGV0YWNoX3VudXNlZF9idWYoKSAgLSByZWN5Y2xlIHRoZSBidWZmZXIgc3VibWl0dGVkCj4g
KyAqCTMuIHZpcnRxdWV1ZV9yZXNldF92cmluZygpICAgICAgICAtIHJlc2V0IHRoZSB2cmluZyAo
bWF5IHJlLWFsbG9jKQo+ICsgKgk0LiB2aXJ0aW9fZW5hYmxlX3Jlc2V0cSgpICAgICAgICAgLSBt
bWFwIHZyaW5nIHRvIGRldmljZSwgYW5kIGVuYWJsZSB0aGUgcXVldWUKPiArICoKPiArICogQ2Fs
bGVyIHNob3VsZCBndWFyYW50ZWUgdGhhdCB0aGUgdnJpbmcgaXMgbm90IGFjY2Vzc2VkIGJ5IGFu
eSBmdW5jdGlvbnMKPiArICogb2YgdmlydHF1ZXVlLgo+ICsgKi8KPiArc3RhdGljIGlubGluZQo+
ICtpbnQgdmlydGlvX3Jlc2V0X3ZxKHN0cnVjdCB2aXJ0cXVldWUgKnZxKQo+ICt7CgoKSXQgbG9v
a3MgdG8gbWUgdGhlIHByZWZpeCAidmlydGlvIiBpcyB1c2VkIGZvciB0aGUgZGV2aWNlIHNwZWNp
ZmljIApvcGVyYXRpb25zLgoKSSB3b25kZXIgaWYgaXQncyBiZXR0ZXIgdG8gcmVuYW1lIHRoaXMg
YXMgdmlydHF1ZXVlX3Jlc3RlKCkgYW5kIG1vdmUgaXQgCnRvIHZpcnRpb19yaW5nLmM/CgpUaGFu
a3MKCgo+ICsJaWYgKCF2cS0+dmRldi0+Y29uZmlnLT5yZXNldF92cSkKPiArCQlyZXR1cm4gLUVO
T0VOVDsKPiArCj4gKwlyZXR1cm4gdnEtPnZkZXYtPmNvbmZpZy0+cmVzZXRfdnEodnEpOwo+ICt9
Cj4gKwo+ICsvKioKPiArICogdmlydGlvX2VuYWJsZV9yZXNldHEgLSBlbmFibGUgYSByZXNldCBx
dWV1ZQo+ICsgKiBAdnE6IHRoZSB2aXJ0cXVldWUKPiArICoKPiArICogcmV0dXJucyAwIG9uIHN1
Y2Nlc3Mgb3IgZXJyb3Igc3RhdHVzCj4gKyAqCj4gKyAqLwo+ICtzdGF0aWMgaW5saW5lCj4gK2lu
dCB2aXJ0aW9fZW5hYmxlX3Jlc2V0cShzdHJ1Y3QgdmlydHF1ZXVlICp2cSkKPiArewo+ICsJaWYg
KCF2cS0+dmRldi0+Y29uZmlnLT5lbmFibGVfcmVzZXRfdnEpCj4gKwkJcmV0dXJuIC1FTk9FTlQ7
Cj4gKwo+ICsJcmV0dXJuIHZxLT52ZGV2LT5jb25maWctPmVuYWJsZV9yZXNldF92cSh2cSk7Cj4g
K30KPiArCj4gICAvKioKPiAgICAqIHZpcnRpb19kZXZpY2VfcmVhZHkgLSBlbmFibGUgdnEgdXNl
IGluIHByb2JlIGZ1bmN0aW9uCj4gICAgKiBAdmRldjogdGhlIGRldmljZQoKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlz
dApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K


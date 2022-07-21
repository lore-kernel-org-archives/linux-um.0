Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oESGa-0035se-VP
	for linux-um@lists.infradead.org; Thu, 21 Jul 2022 09:14:46 +0000
Received: by mail-pj1-f71.google.com with SMTP id o13-20020a17090ab88d00b001f1ef2109aaso2565048pjr.2
        for <linux-um@lists.infradead.org>; Thu, 21 Jul 2022 02:14:42 -0700 (PDT)
Message-ID: <e760bce5-2ead-8be4-6a86-0f453b30dcc3@redhat.com>
Date: Thu, 21 Jul 2022 17:14:29 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v12 26/40] virtio_ring: struct virtqueue introduce reset
References: <20220720030436.79520-1-xuanzhuo@linux.alibaba.com>
 <20220720030436.79520-27-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220720030436.79520-27-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzcvMjAgMTE6MDQsIFh1YW4gWmh1byDlhpnpgZM6Cj4gSW50cm9kdWNlIGEgbmV3
IG1lbWJlciByZXNldCB0byB0aGUgc3RydWN0dXJlIHZpcnRxdWV1ZSB0byBkZXRlcm1pbmUKPiB3
aGV0aGVyIHRoZSBjdXJyZW50IHZxIGlzIGluIHRoZSByZXNldCBzdGF0ZS4gU3Vic2VxdWVudCBw
YXRjaGVzIHdpbGwKPiB1c2UgaXQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56
aHVvQGxpbnV4LmFsaWJhYmEuY29tPgoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPgoKCj4gLS0tCj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgMiAr
Kwo+ICAgaW5jbHVkZS9saW51eC92aXJ0aW8uaCAgICAgICB8IDIgKysKPiAgIDIgZmlsZXMgY2hh
bmdlZCwgNCBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmly
dGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBpbmRleCBiZjY2NmRh
ZDk5MDQuLjgyNzhiOTE3YWQ2NCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9f
cmluZy5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IEBAIC0yMDExLDYg
KzIwMTEsNyBAQCBzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqdnJpbmdfY3JlYXRlX3ZpcnRxdWV1
ZV9wYWNrZWQoCj4gICAJdnEtPnZxLnZkZXYgPSB2ZGV2Owo+ICAgCXZxLT52cS5uYW1lID0gbmFt
ZTsKPiAgIAl2cS0+dnEuaW5kZXggPSBpbmRleDsKPiArCXZxLT52cS5yZXNldCA9IGZhbHNlOwo+
ICAgCXZxLT53ZV9vd25fcmluZyA9IHRydWU7Cj4gICAJdnEtPm5vdGlmeSA9IG5vdGlmeTsKPiAg
IAl2cS0+d2Vha19iYXJyaWVycyA9IHdlYWtfYmFycmllcnM7Cj4gQEAgLTI0OTAsNiArMjQ5MSw3
IEBAIHN0cnVjdCB2aXJ0cXVldWUgKl9fdnJpbmdfbmV3X3ZpcnRxdWV1ZSh1bnNpZ25lZCBpbnQg
aW5kZXgsCj4gICAJdnEtPnZxLnZkZXYgPSB2ZGV2Owo+ICAgCXZxLT52cS5uYW1lID0gbmFtZTsK
PiAgIAl2cS0+dnEuaW5kZXggPSBpbmRleDsKPiArCXZxLT52cS5yZXNldCA9IGZhbHNlOwo+ICAg
CXZxLT53ZV9vd25fcmluZyA9IGZhbHNlOwo+ICAgCXZxLT5ub3RpZnkgPSBub3RpZnk7Cj4gICAJ
dnEtPndlYWtfYmFycmllcnMgPSB3ZWFrX2JhcnJpZXJzOwo+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L3ZpcnRpby5oIGIvaW5jbHVkZS9saW51eC92aXJ0aW8uaAo+IGluZGV4IGQ0NWVlODJh
NDQ3MC4uYTNmNzNiYjY3MzNlIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGludXgvdmlydGlvLmgK
PiArKysgYi9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oCj4gQEAgLTIwLDYgKzIwLDcgQEAKPiAgICAq
IEBpbmRleDogdGhlIHplcm8tYmFzZWQgb3JkaW5hbCBudW1iZXIgZm9yIHRoaXMgcXVldWUuCj4g
ICAgKiBAbnVtX2ZyZWU6IG51bWJlciBvZiBlbGVtZW50cyB3ZSBleHBlY3QgdG8gYmUgYWJsZSB0
byBmaXQuCj4gICAgKiBAbnVtX21heDogdGhlIG1heGltdW0gbnVtYmVyIG9mIGVsZW1lbnRzIHN1
cHBvcnRlZCBieSB0aGUgZGV2aWNlLgo+ICsgKiBAcmVzZXQ6IHZxIGlzIGluIHJlc2V0IHN0YXRl
IG9yIG5vdC4KPiAgICAqCj4gICAgKiBBIG5vdGUgb24gQG51bV9mcmVlOiB3aXRoIGluZGlyZWN0
IGJ1ZmZlcnMsIGVhY2ggYnVmZmVyIG5lZWRzIG9uZQo+ICAgICogZWxlbWVudCBpbiB0aGUgcXVl
dWUsIG90aGVyd2lzZSBhIGJ1ZmZlciB3aWxsIG5lZWQgb25lIGVsZW1lbnQgcGVyCj4gQEAgLTM0
LDYgKzM1LDcgQEAgc3RydWN0IHZpcnRxdWV1ZSB7Cj4gICAJdW5zaWduZWQgaW50IG51bV9mcmVl
Owo+ICAgCXVuc2lnbmVkIGludCBudW1fbWF4Owo+ICAgCXZvaWQgKnByaXY7Cj4gKwlib29sIHJl
c2V0Owo+ICAgfTsKPiAgIAo+ICAgaW50IHZpcnRxdWV1ZV9hZGRfb3V0YnVmKHN0cnVjdCB2aXJ0
cXVldWUgKnZxLAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K


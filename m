Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEN2E-00Fp3I-Aa
	for linux-um@lists.infradead.org; Thu, 21 Jul 2022 03:39:35 +0000
Received: by mail-pj1-f70.google.com with SMTP id r13-20020a17090a454d00b001f04dfc6195so195913pjm.2
        for <linux-um@lists.infradead.org>; Wed, 20 Jul 2022 20:39:31 -0700 (PDT)
Message-ID: <226ab2d4-0b3f-3a18-bed4-be5d278d2069@redhat.com>
Date: Thu, 21 Jul 2022 11:39:17 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v12 02/40] virtio: struct virtio_config_ops add callbacks
 for queue_reset
References: <20220720030436.79520-1-xuanzhuo@linux.alibaba.com>
 <20220720030436.79520-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220720030436.79520-3-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzcvMjAgMTE6MDMsIFh1YW4gWmh1byDlhpnpgZM6Cj4gcmVzZXQgY2FuIGJlIGRp
dmlkZWQgaW50byB0aGUgZm9sbG93aW5nIGZvdXIgc3RlcHMgKGV4YW1wbGUpOgo+ICAgMS4gdHJh
bnNwb3J0OiBub3RpZnkgdGhlIGRldmljZSB0byByZXNldCB0aGUgcXVldWUKPiAgIDIuIHZyaW5n
OiAgICAgcmVjeWNsZSB0aGUgYnVmZmVyIHN1Ym1pdHRlZAo+ICAgMy4gdnJpbmc6ICAgICByZXNl
dC9yZXNpemUgdGhlIHZyaW5nIChtYXkgcmUtYWxsb2MpCj4gICA0LiB0cmFuc3BvcnQ6IG1tYXAg
dnJpbmcgdG8gZGV2aWNlLCBhbmQgZW5hYmxlIHRoZSBxdWV1ZQo+Cj4gSW4gb3JkZXIgdG8gc3Vw
cG9ydCBxdWV1ZSByZXNldCwgYWRkIHR3byBjYWxsYmFja3MgaW4gc3RydWN0Cj4gdmlydGlvX2Nv
bmZpZ19vcHMgdG8gaW1wbGVtZW50IHN0ZXBzIDEgYW5kIDQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBY
dWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgoKCkFja2VkLWJ5OiBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKCj4gLS0tCj4gICBpbmNsdWRlL2xpbnV4L3ZpcnRp
b19jb25maWcuaCB8IDE0ICsrKysrKysrKysrKysrCj4gICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5z
ZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5o
IGIvaW5jbHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmgKPiBpbmRleCBiNDdjMmU3ZWQwZWUuLjM2
ZWM3YmUxZjQ4MCAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZpcnRpb19jb25maWcuaAo+
ICsrKyBiL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oCj4gQEAgLTc4LDYgKzc4LDE4IEBA
IHN0cnVjdCB2aXJ0aW9fc2htX3JlZ2lvbiB7Cj4gICAgKiBAc2V0X3ZxX2FmZmluaXR5OiBzZXQg
dGhlIGFmZmluaXR5IGZvciBhIHZpcnRxdWV1ZSAob3B0aW9uYWwpLgo+ICAgICogQGdldF92cV9h
ZmZpbml0eTogZ2V0IHRoZSBhZmZpbml0eSBmb3IgYSB2aXJ0cXVldWUgKG9wdGlvbmFsKS4KPiAg
ICAqIEBnZXRfc2htX3JlZ2lvbjogZ2V0IGEgc2hhcmVkIG1lbW9yeSByZWdpb24gYmFzZWQgb24g
dGhlIGluZGV4Lgo+ICsgKiBAZGlzYWJsZV92cV9hbmRfcmVzZXQ6IHJlc2V0IGEgcXVldWUgaW5k
aXZpZHVhbGx5IChvcHRpb25hbCkuCj4gKyAqCXZxOiB0aGUgdmlydHF1ZXVlCj4gKyAqCVJldHVy
bnMgMCBvbiBzdWNjZXNzIG9yIGVycm9yIHN0YXR1cwo+ICsgKglkaXNhYmxlX3ZxX2FuZF9yZXNl
dCB3aWxsIGd1YXJhbnRlZSB0aGF0IHRoZSBjYWxsYmFja3MgYXJlIGRpc2FibGVkIGFuZAo+ICsg
KglzeW5jaHJvbml6ZWQuCj4gKyAqCUV4Y2VwdCBmb3IgdGhlIGNhbGxiYWNrLCB0aGUgY2FsbGVy
IHNob3VsZCBndWFyYW50ZWUgdGhhdCB0aGUgdnJpbmcgaXMKPiArICoJbm90IGFjY2Vzc2VkIGJ5
IGFueSBmdW5jdGlvbnMgb2YgdmlydHF1ZXVlLgo+ICsgKiBAZW5hYmxlX3ZxX2FmdGVyX3Jlc2V0
OiBlbmFibGUgYSByZXNldCBxdWV1ZQo+ICsgKgl2cTogdGhlIHZpcnRxdWV1ZQo+ICsgKglSZXR1
cm5zIDAgb24gc3VjY2VzcyBvciBlcnJvciBzdGF0dXMKPiArICoJSWYgZGlzYWJsZV92cV9hbmRf
cmVzZXQgaXMgc2V0LCB0aGVuIGVuYWJsZV92cV9hZnRlcl9yZXNldCBtdXN0IGFsc28gYmUKPiAr
ICoJc2V0Lgo+ICAgICovCj4gICB0eXBlZGVmIHZvaWQgdnFfY2FsbGJhY2tfdChzdHJ1Y3Qgdmly
dHF1ZXVlICopOwo+ICAgc3RydWN0IHZpcnRpb19jb25maWdfb3BzIHsKPiBAQCAtMTA0LDYgKzEx
Niw4IEBAIHN0cnVjdCB2aXJ0aW9fY29uZmlnX29wcyB7Cj4gICAJCQlpbnQgaW5kZXgpOwo+ICAg
CWJvb2wgKCpnZXRfc2htX3JlZ2lvbikoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsCj4gICAJ
CQkgICAgICAgc3RydWN0IHZpcnRpb19zaG1fcmVnaW9uICpyZWdpb24sIHU4IGlkKTsKPiArCWlu
dCAoKmRpc2FibGVfdnFfYW5kX3Jlc2V0KShzdHJ1Y3QgdmlydHF1ZXVlICp2cSk7Cj4gKwlpbnQg
KCplbmFibGVfdnFfYWZ0ZXJfcmVzZXQpKHN0cnVjdCB2aXJ0cXVldWUgKnZxKTsKPiAgIH07Cj4g
ICAKPiAgIC8qIElmIGRyaXZlciBkaWRuJ3QgYWR2ZXJ0aXNlIHRoZSBmZWF0dXJlLCBpdCB3aWxs
IG5ldmVyIGFwcGVhci4gKi8KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVt
Cg==


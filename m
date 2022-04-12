Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ne6b2-00BL8x-2e
 for linux-um@lists.infradead.org; Tue, 12 Apr 2022 02:49:37 +0000
Received: by mail-lj1-f200.google.com with SMTP id
 b9-20020a05651c098900b0024b4e65e7edso4088320ljq.3
 for <linux-um@lists.infradead.org>; Mon, 11 Apr 2022 19:49:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-3-xuanzhuo@linux.alibaba.com>
 <9868de23-c171-2492-a43f-78f51df84640@redhat.com>
In-Reply-To: <9868de23-c171-2492-a43f-78f51df84640@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 12 Apr 2022 10:49:20 +0800
Message-ID: <CACGkMEvgO=QsBjHZLhW72gsnWUp6JWOZkSrVZYHBmPoP+KhTZg@mail.gmail.com>
Subject: Re: [PATCH v9 02/32] virtio: struct virtio_config_ops add callbacks
 for queue_reset
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
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization <virtualization@lists.linux-foundation.org>
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, "Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>, Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Johannes Berg <johannes.berg@intel.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, linux-um@lists.infradead.org, netdev <netdev@vger.kernel.org>, platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, kvm <kvm@vger.kernel.org>, "open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>

T24gVHVlLCBBcHIgMTIsIDIwMjIgYXQgMTA6NDcgQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4KPgo+IOWcqCAyMDIyLzQvNiDkuIrljYgxMTo0MywgWHVhbiBaaHVv
IOWGmemBkzoKPiA+IFBlcmZvcm1pbmcgcmVzZXQgb24gYSBxdWV1ZSBpcyBkaXZpZGVkIGludG8g
Zm91ciBzdGVwczoKPiA+Cj4gPiAgIDEuIHRyYW5zcG9ydDogbm90aWZ5IHRoZSBkZXZpY2UgdG8g
cmVzZXQgdGhlIHF1ZXVlCj4gPiAgIDIuIHZyaW5nOiAgICAgcmVjeWNsZSB0aGUgYnVmZmVyIHN1
Ym1pdHRlZAo+ID4gICAzLiB2cmluZzogICAgIHJlc2V0L3Jlc2l6ZSB0aGUgdnJpbmcgKG1heSBy
ZS1hbGxvYykKPiA+ICAgNC4gdHJhbnNwb3J0OiBtbWFwIHZyaW5nIHRvIGRldmljZSwgYW5kIGVu
YWJsZSB0aGUgcXVldWUKPgo+Cj4gTml0OiBpdCBsb29rcyB0byBtZSB3ZSdkIGJldHRlciBzYXkg
aXQncyBhbiBleGFtcGxlIChzaW5jZSBzdGVwIDMgb3IKPiBldmVuIDIgaXMgbm90IGEgbXVzdCku
Cj4KPgo+ID4KPiA+IEluIG9yZGVyIHRvIHN1cHBvcnQgcXVldWUgcmVzZXQsIGFkZCB0d28gY2Fs
bGJhY2tzKHJlc2V0X3ZxLAo+ID4gZW5hYmxlX3Jlc2V0X3ZxKSBpbiBzdHJ1Y3QgdmlydGlvX2Nv
bmZpZ19vcHMgdG8gaW1wbGVtZW50IHN0ZXBzIDEgYW5kIDQuCj4gPgo+ID4gU2lnbmVkLW9mZi1i
eTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiA+IC0tLQo+ID4gICBp
bmNsdWRlL2xpbnV4L3ZpcnRpb19jb25maWcuaCB8IDEyICsrKysrKysrKysrKwo+ID4gICAxIGZp
bGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L3ZpcnRpb19jb25maWcuaCBiL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oCj4g
PiBpbmRleCA0ZDEwN2FkMzExNDkuLmQ0YWRjZDBlMWM1NyAxMDA2NDQKPiA+IC0tLSBhL2luY2x1
ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3ZpcnRpb19j
b25maWcuaAo+ID4gQEAgLTc0LDYgKzc0LDE2IEBAIHN0cnVjdCB2aXJ0aW9fc2htX3JlZ2lvbiB7
Cj4gPiAgICAqIEBzZXRfdnFfYWZmaW5pdHk6IHNldCB0aGUgYWZmaW5pdHkgZm9yIGEgdmlydHF1
ZXVlIChvcHRpb25hbCkuCj4gPiAgICAqIEBnZXRfdnFfYWZmaW5pdHk6IGdldCB0aGUgYWZmaW5p
dHkgZm9yIGEgdmlydHF1ZXVlIChvcHRpb25hbCkuCj4gPiAgICAqIEBnZXRfc2htX3JlZ2lvbjog
Z2V0IGEgc2hhcmVkIG1lbW9yeSByZWdpb24gYmFzZWQgb24gdGhlIGluZGV4Lgo+ID4gKyAqIEBy
ZXNldF92cTogcmVzZXQgYSBxdWV1ZSBpbmRpdmlkdWFsbHkgKG9wdGlvbmFsKS4KPiA+ICsgKiAg
IHZxOiB0aGUgdmlydHF1ZXVlCj4gPiArICogICBSZXR1cm5zIDAgb24gc3VjY2VzcyBvciBlcnJv
ciBzdGF0dXMKPiA+ICsgKiAgIHJlc2V0X3ZxIHdpbGwgZ3VhcmFudGVlIHRoYXQgdGhlIGNhbGxi
YWNrcyBhcmUgZGlzYWJsZWQgYW5kIHN5bmNocm9uaXplZC4KPiA+ICsgKiAgIEV4Y2VwdCBmb3Ig
dGhlIGNhbGxiYWNrLCB0aGUgY2FsbGVyIHNob3VsZCBndWFyYW50ZWUgdGhhdCB0aGUgdnJpbmcg
aXMKPgo+Cj4gSSB3b25kZXIgd2hhdCdzIHRoZSBpbXBsaWNhdGlvbnMgZm9yIHZpcnRpbyBoYXJk
ZW5pbmdbMV0uIEluIHRoYXQKCkZvciBbMV0gSSBtZWFudApodHRwczovL2xvcmUua2VybmVsLm9y
Zy9sa21sLzIwMjIwNDA2MDgzNTM4LjE2Mjc0LTEtamFzb3dhbmdAcmVkaGF0LmNvbS8KClRoYW5r
cwoKCj4gc2VyaWVzLCB3ZSBhZ3JlZSB0byBoYXZlIGEgc3luY2hyb25pemVfdnFzKCkgY29uZmln
IG9wcyB0byBtYWtlIHN1cmUKPiBjYWxsYmFja3MgYXJlIHN5bmNocm9uaXplZC4KPgo+IEl0IHVz
ZXMgYSBnbG9iYWwgZmxhZyBhbmQgYSBkZXZpY2Ugd2lzZSBzeW5jaHJvbml6YXRpb24gbWVjaGFu
aXNtLiBJdAo+IGxvb2tzIHRvIG1lIHdlIG5lZWQgdG8gc3dpdGNoIHRvCj4KPiAxKSBwZXIgdmly
dHF1ZXVlIGZsYWcKPiAyKSBwZXIgdmlydHF1ZXVlIHN5bmNocm9uaXphdGlvbgo+Cj4gVGhhbmtz
Cj4KPgo+ID4gKyAqICAgbm90IGFjY2Vzc2VkIGJ5IGFueSBmdW5jdGlvbnMgb2YgdmlydHF1ZXVl
Lgo+ID4gKyAqIEBlbmFibGVfcmVzZXRfdnE6IGVuYWJsZSBhIHJlc2V0IHF1ZXVlCj4gPiArICog
ICB2cTogdGhlIHZpcnRxdWV1ZQo+ID4gKyAqICAgUmV0dXJucyAwIG9uIHN1Y2Nlc3Mgb3IgZXJy
b3Igc3RhdHVzCj4gPiArICogICBJZiByZXNldF92cSBpcyBzZXQsIHRoZW4gZW5hYmxlX3Jlc2V0
X3ZxIG11c3QgYWxzbyBiZSBzZXQuCj4gPiAgICAqLwo+ID4gICB0eXBlZGVmIHZvaWQgdnFfY2Fs
bGJhY2tfdChzdHJ1Y3QgdmlydHF1ZXVlICopOwo+ID4gICBzdHJ1Y3QgdmlydGlvX2NvbmZpZ19v
cHMgewo+ID4gQEAgLTEwMCw2ICsxMTAsOCBAQCBzdHJ1Y3QgdmlydGlvX2NvbmZpZ19vcHMgewo+
ID4gICAgICAgICAgICAgICAgICAgICAgIGludCBpbmRleCk7Cj4gPiAgICAgICBib29sICgqZ2V0
X3NobV9yZWdpb24pKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LAo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBzdHJ1Y3QgdmlydGlvX3NobV9yZWdpb24gKnJlZ2lvbiwgdTggaWQp
Owo+ID4gKyAgICAgaW50ICgqcmVzZXRfdnEpKHN0cnVjdCB2aXJ0cXVldWUgKnZxKTsKPiA+ICsg
ICAgIGludCAoKmVuYWJsZV9yZXNldF92cSkoc3RydWN0IHZpcnRxdWV1ZSAqdnEpOwo+ID4gICB9
Owo+ID4KPiA+ICAgLyogSWYgZHJpdmVyIGRpZG4ndCBhZHZlcnRpc2UgdGhlIGZlYXR1cmUsIGl0
IHdpbGwgbmV2ZXIgYXBwZWFyLiAqLwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtdW0K


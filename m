Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o7CYr-003l2e-Sd
	for linux-um@lists.infradead.org; Fri, 01 Jul 2022 09:03:39 +0000
Received: by mail-pg1-f198.google.com with SMTP id h13-20020a63e14d000000b0040df75eaa2eso1017111pgk.21
        for <linux-um@lists.infradead.org>; Fri, 01 Jul 2022 02:03:33 -0700 (PDT)
Message-ID: <e27e4f98-5f3f-6ad5-b612-163cb967fa8a@redhat.com>
Date: Fri, 1 Jul 2022 17:03:19 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v11 13/40] virtio_ring: split: reserve vring_align,
 may_reduce_num
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-14-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220629065656.54420-14-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzYvMjkgMTQ6NTYsIFh1YW4gWmh1byDlhpnpgZM6Cj4gSW4gdnJpbmdfY3JlYXRl
X3ZpcnRxdWV1ZV9zcGxpdCgpIHNhdmUgdnJpbmdfYWxpZ24sIG1heV9yZWR1Y2VfbnVtIHRvCj4g
c3RydWN0dXJlIHZyaW5nX3ZpcnRxdWV1ZV9zcGxpdC4gVXNlZCB0byBjcmVhdGUgYSBuZXcgdnJp
bmcgd2hlbgo+IGltcGxlbWVudGluZyByZXNpemUgLgo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBa
aHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8
amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jp
bmcuYyB8IDkgKysrKysrKysrCj4gICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspCj4K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmly
dGlvL3ZpcnRpb19yaW5nLmMKPiBpbmRleCA0Yzg5NzJkYTU0MjMuLjljODNjNWU2ZDVhOSAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gKysrIGIvZHJpdmVycy92
aXJ0aW8vdmlydGlvX3JpbmcuYwo+IEBAIC0xMDUsNiArMTA1LDEzIEBAIHN0cnVjdCB2cmluZ192
aXJ0cXVldWVfc3BsaXQgewo+ICAgCS8qIERNQSBhZGRyZXNzIGFuZCBzaXplIGluZm9ybWF0aW9u
ICovCj4gICAJZG1hX2FkZHJfdCBxdWV1ZV9kbWFfYWRkcjsKPiAgIAlzaXplX3QgcXVldWVfc2l6
ZV9pbl9ieXRlczsKPiArCj4gKwkvKgo+ICsJICogVGhlIHBhcmFtZXRlcnMgZm9yIGNyZWF0aW5n
IHZyaW5ncyBhcmUgcmVzZXJ2ZWQgZm9yIGNyZWF0aW5nIG5ldwo+ICsJICogdnJpbmcuCj4gKwkg
Ki8KPiArCXUzMiB2cmluZ19hbGlnbjsKPiArCWJvb2wgbWF5X3JlZHVjZV9udW07Cj4gICB9Owo+
ICAgCj4gICBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlX3BhY2tlZCB7Cj4gQEAgLTEwOTgsNiArMTEw
NSw4IEBAIHN0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVlX3Nw
bGl0KAo+ICAgCQlyZXR1cm4gTlVMTDsKPiAgIAl9Cj4gICAKPiArCXRvX3Z2cSh2cSktPnNwbGl0
LnZyaW5nX2FsaWduID0gdnJpbmdfYWxpZ247Cj4gKwl0b192dnEodnEpLT5zcGxpdC5tYXlfcmVk
dWNlX251bSA9IG1heV9yZWR1Y2VfbnVtOwo+ICAgCXRvX3Z2cSh2cSktPnNwbGl0LnF1ZXVlX2Rt
YV9hZGRyID0gdnJpbmcucXVldWVfZG1hX2FkZHI7Cj4gICAJdG9fdnZxKHZxKS0+c3BsaXQucXVl
dWVfc2l6ZV9pbl9ieXRlcyA9IHZyaW5nLnF1ZXVlX3NpemVfaW5fYnl0ZXM7Cj4gICAJdG9fdnZx
KHZxKS0+d2Vfb3duX3JpbmcgPSB0cnVlOwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtdW0K


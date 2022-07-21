Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oESGy-0036Ei-N6
	for linux-um@lists.infradead.org; Thu, 21 Jul 2022 09:15:10 +0000
Received: by mail-pg1-f200.google.com with SMTP id 134-20020a63018c000000b0040cf04213a1so661349pgb.6
        for <linux-um@lists.infradead.org>; Thu, 21 Jul 2022 02:15:04 -0700 (PDT)
Message-ID: <74fb1fe4-87ce-eb24-e4a0-d81164c80f3c@redhat.com>
Date: Thu, 21 Jul 2022 17:14:50 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v12 27/40] virtio_pci: struct virtio_pci_common_cfg add
 queue_reset
References: <20220720030436.79520-1-xuanzhuo@linux.alibaba.com>
 <20220720030436.79520-28-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220720030436.79520-28-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzcvMjAgMTE6MDQsIFh1YW4gWmh1byDlhpnpgZM6Cj4gQWRkIHF1ZXVlX3Jlc2V0
IGluIHZpcnRpb19wY2lfY29tbW9uX2NmZy4KPgo+ICAgaHR0cHM6Ly9naXRodWIuY29tL29hc2lz
LXRjcy92aXJ0aW8tc3BlYy9pc3N1ZXMvMTI0Cj4gICBodHRwczovL2dpdGh1Yi5jb20vb2FzaXMt
dGNzL3ZpcnRpby1zcGVjL2lzc3Vlcy8xMzkKPgo+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8
eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+CgoKPiAtLS0KPiAgIGluY2x1ZGUvbGludXgvdmlydGlvX3BjaV9tb2Rl
cm4uaCB8IDIgKy0KPiAgIGluY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fcGNpLmggICB8IDEgKwo+
ICAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZpcnRpb19wY2lfbW9kZXJuLmggYi9pbmNsdWRlL2xp
bnV4L3ZpcnRpb19wY2lfbW9kZXJuLmgKPiBpbmRleCA0MWY1YTAxOGJkOTQuLjA1MTIzYjlhNjA2
ZiAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZpcnRpb19wY2lfbW9kZXJuLmgKPiArKysg
Yi9pbmNsdWRlL2xpbnV4L3ZpcnRpb19wY2lfbW9kZXJuLmgKPiBAQCAtOSw3ICs5LDcgQEAgc3Ry
dWN0IHZpcnRpb19wY2lfbW9kZXJuX2NvbW1vbl9jZmcgewo+ICAgCXN0cnVjdCB2aXJ0aW9fcGNp
X2NvbW1vbl9jZmcgY2ZnOwo+ICAgCj4gICAJX19sZTE2IHF1ZXVlX25vdGlmeV9kYXRhOwkvKiBy
ZWFkLXdyaXRlICovCj4gLQlfX2xlMTYgcGFkZGluZzsKPiArCV9fbGUxNiBxdWV1ZV9yZXNldDsJ
CS8qIHJlYWQtd3JpdGUgKi8KPiAgIH07Cj4gICAKPiAgIHN0cnVjdCB2aXJ0aW9fcGNpX21vZGVy
bl9kZXZpY2Ugewo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX3BjaS5o
IGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19wY2kuaAo+IGluZGV4IGY1OTgxYTg3NDQ4MS4u
ZjcwM2FmYzdhZDMxIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fcGNp
LmgKPiArKysgYi9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX3BjaS5oCj4gQEAgLTIwMyw2ICsy
MDMsNyBAQCBzdHJ1Y3QgdmlydGlvX3BjaV9jZmdfY2FwIHsKPiAgICNkZWZpbmUgVklSVElPX1BD
SV9DT01NT05fUV9VU0VETE8JNDgKPiAgICNkZWZpbmUgVklSVElPX1BDSV9DT01NT05fUV9VU0VE
SEkJNTIKPiAgICNkZWZpbmUgVklSVElPX1BDSV9DT01NT05fUV9OREFUQQk1Ngo+ICsjZGVmaW5l
IFZJUlRJT19QQ0lfQ09NTU9OX1FfUkVTRVQJNTgKPiAgIAo+ICAgI2VuZGlmIC8qIFZJUlRJT19Q
Q0lfTk9fTU9ERVJOICovCj4gICAKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LXVtCg==


Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGYl2-008tuA-JA
	for linux-um@lists.infradead.org; Wed, 27 Jul 2022 04:34:53 +0000
Received: by mail-pl1-f199.google.com with SMTP id z15-20020a170903018f00b0016d6e7a043dso4855300plg.12
        for <linux-um@lists.infradead.org>; Tue, 26 Jul 2022 21:34:48 -0700 (PDT)
Message-ID: <055a1aa0-756a-778d-3039-6eb452ccd390@redhat.com>
Date: Wed, 27 Jul 2022 12:34:30 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v13 21/42] virtio_ring: packed: extract the logic of
 attach vring
References: <20220726072225.19884-1-xuanzhuo@linux.alibaba.com>
 <20220726072225.19884-22-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220726072225.19884-22-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzcvMjYgMTU6MjIsIFh1YW4gWmh1byDlhpnpgZM6Cj4gU2VwYXJhdGUgdGhlIGxv
Z2ljIG9mIGF0dGFjaCB2cmluZywgdGhlIHN1YnNlcXVlbnQgcGF0Y2ggd2lsbCBjYWxsIGl0Cj4g
c2VwYXJhdGVseS4KPgo+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXgu
YWxpYmFiYS5jb20+CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+
CgoKPiAtLS0KPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCAxOSArKysrKysrLS0t
LS0tLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlv
bnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJp
dmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IGluZGV4IGZjNGUzZGI5ZjkzYi4uMDBiMThjZjNi
NGQ5IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiArKysgYi9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gQEAgLTE5NTEsNiArMTk1MSwxMiBAQCBzdGF0
aWMgdm9pZCB2aXJ0cXVldWVfdnJpbmdfaW5pdF9wYWNrZWQoc3RydWN0IHZyaW5nX3ZpcnRxdWV1
ZV9wYWNrZWQgKnZyaW5nX3BhYwo+ICAgCX0KPiAgIH0KPiAgIAo+ICtzdGF0aWMgdm9pZCB2aXJ0
cXVldWVfdnJpbmdfYXR0YWNoX3BhY2tlZChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwKPiAr
CQkJCQkgIHN0cnVjdCB2cmluZ192aXJ0cXVldWVfcGFja2VkICp2cmluZ19wYWNrZWQpCj4gK3sK
PiArCXZxLT5wYWNrZWQgPSAqdnJpbmdfcGFja2VkOwo+ICt9Cj4gKwo+ICAgc3RhdGljIHN0cnVj
dCB2aXJ0cXVldWUgKnZyaW5nX2NyZWF0ZV92aXJ0cXVldWVfcGFja2VkKAo+ICAgCXVuc2lnbmVk
IGludCBpbmRleCwKPiAgIAl1bnNpZ25lZCBpbnQgbnVtLAo+IEBAIC0xOTkxLDI1ICsxOTk3LDE0
IEBAIHN0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVlX3BhY2tl
ZCgKPiAgIAl2cS0+aW5kaXJlY3QgPSB2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX1JJ
TkdfRl9JTkRJUkVDVF9ERVNDKSAmJgo+ICAgCQkhY29udGV4dDsKPiAgIAo+IC0JdnEtPnBhY2tl
ZC5yaW5nX2RtYV9hZGRyID0gdnJpbmdfcGFja2VkLnJpbmdfZG1hX2FkZHI7Cj4gLQl2cS0+cGFj
a2VkLmRyaXZlcl9ldmVudF9kbWFfYWRkciA9IHZyaW5nX3BhY2tlZC5kcml2ZXJfZXZlbnRfZG1h
X2FkZHI7Cj4gLQl2cS0+cGFja2VkLmRldmljZV9ldmVudF9kbWFfYWRkciA9IHZyaW5nX3BhY2tl
ZC5kZXZpY2VfZXZlbnRfZG1hX2FkZHI7Cj4gLQo+IC0JdnEtPnBhY2tlZC5yaW5nX3NpemVfaW5f
Ynl0ZXMgPSB2cmluZ19wYWNrZWQucmluZ19zaXplX2luX2J5dGVzOwo+IC0JdnEtPnBhY2tlZC5l
dmVudF9zaXplX2luX2J5dGVzID0gdnJpbmdfcGFja2VkLmV2ZW50X3NpemVfaW5fYnl0ZXM7Cj4g
LQo+IC0JdnEtPnBhY2tlZC52cmluZyA9IHZyaW5nX3BhY2tlZC52cmluZzsKPiAtCj4gICAJZXJy
ID0gdnJpbmdfYWxsb2Nfc3RhdGVfZXh0cmFfcGFja2VkKCZ2cmluZ19wYWNrZWQpOwo+ICAgCWlm
IChlcnIpCj4gICAJCWdvdG8gZXJyX3N0YXRlX2V4dHJhOwo+ICAgCj4gLQl2cS0+cGFja2VkLmRl
c2Nfc3RhdGUgPSB2cmluZ19wYWNrZWQuZGVzY19zdGF0ZTsKPiAtCXZxLT5wYWNrZWQuZGVzY19l
eHRyYSA9IHZyaW5nX3BhY2tlZC5kZXNjX2V4dHJhOwo+IC0KPiAgIAl2aXJ0cXVldWVfdnJpbmdf
aW5pdF9wYWNrZWQoJnZyaW5nX3BhY2tlZCwgISFjYWxsYmFjayk7Cj4gICAKPiAgIAl2aXJ0cXVl
dWVfaW5pdCh2cSwgbnVtKTsKPiArCXZpcnRxdWV1ZV92cmluZ19hdHRhY2hfcGFja2VkKHZxLCAm
dnJpbmdfcGFja2VkKTsKPiAgIAo+ICAgCXNwaW5fbG9jaygmdmRldi0+dnFzX2xpc3RfbG9jayk7
Cj4gICAJbGlzdF9hZGRfdGFpbCgmdnEtPnZxLmxpc3QsICZ2ZGV2LT52cXMpOwoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcg
bGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K


Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o7CVd-003kIh-Mm
	for linux-um@lists.infradead.org; Fri, 01 Jul 2022 09:00:19 +0000
Received: by mail-pj1-f72.google.com with SMTP id j23-20020a17090a061700b001e89529d397so1134621pjj.6
        for <linux-um@lists.infradead.org>; Fri, 01 Jul 2022 02:00:14 -0700 (PDT)
Message-ID: <e24fec52-72a4-caaf-e31f-0adc5a6593d7@redhat.com>
Date: Fri, 1 Jul 2022 17:00:00 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v11 10/40] virtio_ring: split: extract the logic of attach
 vring
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-11-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220629065656.54420-11-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzYvMjkgMTQ6NTYsIFh1YW4gWmh1byDlhpnpgZM6Cj4gU2VwYXJhdGUgdGhlIGxv
Z2ljIG9mIGF0dGFjaCB2cmluZywgc3Vic2VxdWVudCBwYXRjaGVzIHdpbGwgY2FsbCBpdAo+IHNl
cGFyYXRlbHkuCj4KPiBTaW5jZSB0aGUgInN0cnVjdCB2cmluZ192aXJ0cXVldWVfc3BsaXQgc3Bs
aXQiIGlzIGNyZWF0ZWQgb24gdGhlCj4gc3RhY2sgYW5kIGhhcyBiZWVuIGluaXRpYWxpemVkIHRv
IDAuIFNvIHVzaW5nCj4gc3BsaXQtPnF1ZXVlX2RtYV9hZGRyL3NwbGl0LT5xdWV1ZV9zaXplX2lu
X2J5dGVzIGFzc2lnbm1lbnQgZm9yCj4gcXVldWVfZG1hX2FkZHIvcXVldWVfc2l6ZV9pbl9ieXRl
cyBjYW4ga2VlcCB0aGUgc2FtZSBhcyB0aGUgb3JpZ2luYWwKPiBjb2RlLgo+Cj4gT24gdGhlIG90
aGVyIGhhbmQsIHN1YnNlcXVlbnQgcGF0Y2hlcyBjYW4gdXNlIHRoZSAic3RydWN0Cj4gdnJpbmdf
dmlydHF1ZXVlX3NwbGl0IHNwbGl0IiBvYnRhaW5lZCBieSB2cmluZ19hbGxvY19xdWV1ZV9zcGxp
dCgpIHRvCj4gZGlyZWN0bHkgY29tcGxldGUgdGhlIGF0dGFjaCBvcGVyYXRpb24uCj4KPiBTaWdu
ZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgoKCkFja2Vk
LWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKCj4gLS0tCj4gICBkcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgMjAgKysrKysrKysrKysrKy0tLS0tLS0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9f
cmluZy5jCj4gaW5kZXggY2VkZDM0MGQ2ZGI3Li45MDI1YmQzNzNkM2IgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRp
b19yaW5nLmMKPiBAQCAtOTQwLDYgKzk0MCwxOCBAQCBzdGF0aWMgdm9pZCAqdmlydHF1ZXVlX2Rl
dGFjaF91bnVzZWRfYnVmX3NwbGl0KHN0cnVjdCB2aXJ0cXVldWUgKl92cSkKPiAgIAlyZXR1cm4g
TlVMTDsKPiAgIH0KPiAgIAo+ICtzdGF0aWMgdm9pZCB2aXJ0cXVldWVfdnJpbmdfYXR0YWNoX3Nw
bGl0KHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxLAo+ICsJCQkJCSBzdHJ1Y3QgdnJpbmdfdmly
dHF1ZXVlX3NwbGl0ICp2cmluZykKPiArewo+ICsJdnEtPnNwbGl0LnF1ZXVlX2RtYV9hZGRyID0g
dnJpbmctPnF1ZXVlX2RtYV9hZGRyOwo+ICsJdnEtPnNwbGl0LnF1ZXVlX3NpemVfaW5fYnl0ZXMg
PSB2cmluZy0+cXVldWVfc2l6ZV9pbl9ieXRlczsKPiArCj4gKwl2cS0+c3BsaXQudnJpbmcgPSB2
cmluZy0+dnJpbmc7Cj4gKwo+ICsJdnEtPnNwbGl0LmRlc2Nfc3RhdGUgPSB2cmluZy0+ZGVzY19z
dGF0ZTsKPiArCXZxLT5zcGxpdC5kZXNjX2V4dHJhID0gdnJpbmctPmRlc2NfZXh0cmE7Cj4gK30K
PiArCj4gICBzdGF0aWMgaW50IHZyaW5nX2FsbG9jX3N0YXRlX2V4dHJhX3NwbGl0KHN0cnVjdCB2
cmluZ192aXJ0cXVldWVfc3BsaXQgKnZyaW5nKQo+ICAgewo+ICAgCXN0cnVjdCB2cmluZ19kZXNj
X3N0YXRlX3NwbGl0ICpzdGF0ZTsKPiBAQCAtMjI4NywxMCArMjI5OSw2IEBAIHN0cnVjdCB2aXJ0
cXVldWUgKl9fdnJpbmdfbmV3X3ZpcnRxdWV1ZSh1bnNpZ25lZCBpbnQgaW5kZXgsCj4gICAJdnEt
PmluZGlyZWN0ID0gdmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19SSU5HX0ZfSU5ESVJF
Q1RfREVTQykgJiYKPiAgIAkJIWNvbnRleHQ7Cj4gICAKPiAtCXZxLT5zcGxpdC5xdWV1ZV9kbWFf
YWRkciA9IDA7Cj4gLQl2cS0+c3BsaXQucXVldWVfc2l6ZV9pbl9ieXRlcyA9IDA7Cj4gLQo+IC0J
dnEtPnNwbGl0LnZyaW5nID0gX3ZyaW5nOwo+ICAgCXZxLT5zcGxpdC5hdmFpbF9mbGFnc19zaGFk
b3cgPSAwOwo+ICAgCXZxLT5zcGxpdC5hdmFpbF9pZHhfc2hhZG93ID0gMDsKPiAgIAo+IEBAIC0y
MzEwLDEwICsyMzE4LDggQEAgc3RydWN0IHZpcnRxdWV1ZSAqX192cmluZ19uZXdfdmlydHF1ZXVl
KHVuc2lnbmVkIGludCBpbmRleCwKPiAgIAkJcmV0dXJuIE5VTEw7Cj4gICAJfQo+ICAgCj4gLQl2
cS0+c3BsaXQuZGVzY19zdGF0ZSA9IHZyaW5nLmRlc2Nfc3RhdGU7Cj4gLQl2cS0+c3BsaXQuZGVz
Y19leHRyYSA9IHZyaW5nLmRlc2NfZXh0cmE7Cj4gLQo+ICAgCXZpcnRxdWV1ZV9pbml0KHZxLCB2
cmluZy52cmluZy5udW0pOwo+ICsJdmlydHF1ZXVlX3ZyaW5nX2F0dGFjaF9zcGxpdCh2cSwgJnZy
aW5nKTsKPiAgIAo+ICAgCXNwaW5fbG9jaygmdmRldi0+dnFzX2xpc3RfbG9jayk7Cj4gICAJbGlz
dF9hZGRfdGFpbCgmdnEtPnZxLmxpc3QsICZ2ZGV2LT52cXMpOwoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51
eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtdW0K


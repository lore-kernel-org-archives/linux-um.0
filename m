Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o7D2h-003syp-HQ
	for linux-um@lists.infradead.org; Fri, 01 Jul 2022 09:34:30 +0000
Received: by mail-pl1-f197.google.com with SMTP id h18-20020a170902f55200b0016a4a78bd71so1207586plf.9
        for <linux-um@lists.infradead.org>; Fri, 01 Jul 2022 02:34:25 -0700 (PDT)
Message-ID: <10281add-4d72-efe6-e94d-1f19ced9cb27@redhat.com>
Date: Fri, 1 Jul 2022 17:34:12 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v11 24/40] virtio_pci: struct virtio_pci_common_cfg add
 queue_notify_data
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-25-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220629065656.54420-25-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzYvMjkgMTQ6NTYsIFh1YW4gWmh1byDlhpnpgZM6Cj4gQWRkIHF1ZXVlX25vdGlm
eV9kYXRhIGluIHN0cnVjdCB2aXJ0aW9fcGNpX2NvbW1vbl9jZmcsIHdoaWNoIGNvbWVzIGZyb20K
PiBoZXJlIGh0dHBzOi8vZ2l0aHViLmNvbS9vYXNpcy10Y3MvdmlydGlvLXNwZWMvaXNzdWVzLzg5
Cj4KPiBTaW5jZSBJIHdhbnQgdG8gYWRkIHF1ZXVlX3Jlc2V0IGFmdGVyIHF1ZXVlX25vdGlmeV9k
YXRhLCBJIHN1Ym1pdHRlZAo+IHRoaXMgcGF0Y2ggZmlyc3QuCj4KPiBTaWduZWQtb2ZmLWJ5OiBY
dWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+IEFja2VkLWJ5OiBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+IC0tLQo+ICAgaW5jbHVkZS9saW51eC92aXJ0aW9f
cGNpX21vZGVybi5oIHwgMiArKwo+ICAgaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19wY2kuaCAg
IHwgMSArCj4gICAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvdmlydGlvX3BjaV9tb2Rlcm4uaCBiL2luY2x1ZGUvbGludXgvdmly
dGlvX3BjaV9tb2Rlcm4uaAo+IGluZGV4IGM0ZjdmZmJhY2I0ZS4uOWYzMWRkZTQ2ZjU3IDEwMDY0
NAo+IC0tLSBhL2luY2x1ZGUvbGludXgvdmlydGlvX3BjaV9tb2Rlcm4uaAo+ICsrKyBiL2luY2x1
ZGUvbGludXgvdmlydGlvX3BjaV9tb2Rlcm4uaAo+IEBAIC0yOSw2ICsyOSw4IEBAIHN0cnVjdCB2
aXJ0aW9fcGNpX2NvbW1vbl9jZmcgewo+ICAgCV9fbGUzMiBxdWV1ZV9hdmFpbF9oaTsJCS8qIHJl
YWQtd3JpdGUgKi8KPiAgIAlfX2xlMzIgcXVldWVfdXNlZF9sbzsJCS8qIHJlYWQtd3JpdGUgKi8K
PiAgIAlfX2xlMzIgcXVldWVfdXNlZF9oaTsJCS8qIHJlYWQtd3JpdGUgKi8KPiArCV9fbGUxNiBx
dWV1ZV9ub3RpZnlfZGF0YTsJLyogcmVhZC13cml0ZSAqLwo+ICsJX19sZTE2IHBhZGRpbmc7Cj4g
ICB9OwoKCkFzIHByZXZpb3VzIHBhdGNoLCBJIHRoaW5rIGl0J3MgYmV0dGVyIHRvIHNpbXBsZSBl
bWJlZCB0aGUgdUFQSSAKc3RydWN0dXJlIGhlcmUuCgpUaGFua3MKCgo+ICAgCj4gICBzdHJ1Y3Qg
dmlydGlvX3BjaV9tb2Rlcm5fZGV2aWNlIHsKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xp
bnV4L3ZpcnRpb19wY2kuaCBiL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fcGNpLmgKPiBpbmRl
eCAyNDdlYzQyYWYyYzguLjc0OGIzZWI2MmQyZiAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL3VhcGkv
bGludXgvdmlydGlvX3BjaS5oCj4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19wY2ku
aAo+IEBAIC0xNzYsNiArMTc2LDcgQEAgc3RydWN0IHZpcnRpb19wY2lfY2ZnX2NhcCB7Cj4gICAj
ZGVmaW5lIFZJUlRJT19QQ0lfQ09NTU9OX1FfQVZBSUxISQk0NAo+ICAgI2RlZmluZSBWSVJUSU9f
UENJX0NPTU1PTl9RX1VTRURMTwk0OAo+ICAgI2RlZmluZSBWSVJUSU9fUENJX0NPTU1PTl9RX1VT
RURISQk1Mgo+ICsjZGVmaW5lIFZJUlRJT19QQ0lfQ09NTU9OX1FfTkRBVEEJNTYKPiAgIAo+ICAg
I2VuZGlmIC8qIFZJUlRJT19QQ0lfTk9fTU9ERVJOICovCj4gICAKCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGlu
dXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==


Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oESRp-003GcU-L6
	for linux-um@lists.infradead.org; Thu, 21 Jul 2022 09:26:23 +0000
Received: by mail-pg1-f200.google.com with SMTP id bd7-20020a656e07000000b00412a946da8eso667346pgb.20
        for <linux-um@lists.infradead.org>; Thu, 21 Jul 2022 02:26:19 -0700 (PDT)
Message-ID: <726a5056-789a-b445-a2c6-879008ad270a@redhat.com>
Date: Thu, 21 Jul 2022 17:25:59 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v12 38/40] virtio_net: support rx queue resize
References: <20220720030436.79520-1-xuanzhuo@linux.alibaba.com>
 <20220720030436.79520-39-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220720030436.79520-39-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzcvMjAgMTE6MDQsIFh1YW4gWmh1byDlhpnpgZM6Cj4gVGhpcyBwYXRjaCBpbXBs
ZW1lbnRzIHRoZSByZXNpemUgZnVuY3Rpb24gb2YgdGhlIHJ4IHF1ZXVlcy4KPiBCYXNlZCBvbiB0
aGlzIGZ1bmN0aW9uLCBpdCBpcyBwb3NzaWJsZSB0byBtb2RpZnkgdGhlIHJpbmcgbnVtIG9mIHRo
ZQo+IHF1ZXVlLgo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5h
bGliYWJhLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDIyICsrKysr
KysrKysrKysrKysrKysrKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspCj4K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmly
dGlvX25ldC5jCj4gaW5kZXggZmU0ZGM0M2MwNWExLi4xMTE1YThiNTlhMDggMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25l
dC5jCj4gQEAgLTI3OCw2ICsyNzgsOCBAQCBzdHJ1Y3QgcGFkZGVkX3ZuZXRfaGRyIHsKPiAgIAlj
aGFyIHBhZGRpbmdbMTJdOwo+ICAgfTsKPiAgIAo+ICtzdGF0aWMgdm9pZCB2aXJ0bmV0X3JxX2Zy
ZWVfdW51c2VkX2J1ZihzdHJ1Y3QgdmlydHF1ZXVlICp2cSwgdm9pZCAqYnVmKTsKPiArCj4gICBz
dGF0aWMgYm9vbCBpc194ZHBfZnJhbWUodm9pZCAqcHRyKQo+ICAgewo+ICAgCXJldHVybiAodW5z
aWduZWQgbG9uZylwdHIgJiBWSVJUSU9fWERQX0ZMQUc7Cj4gQEAgLTE4NDYsNiArMTg0OCwyNiBA
QCBzdGF0aWMgbmV0ZGV2X3R4X3Qgc3RhcnRfeG1pdChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1
Y3QgbmV0X2RldmljZSAqZGV2KQo+ICAgCXJldHVybiBORVRERVZfVFhfT0s7Cj4gICB9Cj4gICAK
PiArc3RhdGljIGludCB2aXJ0bmV0X3J4X3Jlc2l6ZShzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwK
PiArCQkJICAgICBzdHJ1Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEsIHUzMiByaW5nX251bSkKPiArewo+
ICsJaW50IGVyciwgcWluZGV4Owo+ICsKPiArCXFpbmRleCA9IHJxIC0gdmktPnJxOwo+ICsKPiAr
CW5hcGlfZGlzYWJsZSgmcnEtPm5hcGkpOwoKCldlIG5lZWQgdG8gZGlzYWJsZSByZWZpbGwgd29y
ayBhcyB3ZWxsLiBTbyB0aGlzIHNlcmllcyBtaWdodCBuZWVkIApyZWJhc2luZyBvbiB0b3Agb2YK
Cmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi8yMDIyMDcwNDA3NDg1OS4xNjkxMi0xLWph
c293YW5nQHJlZGhhdC5jb20vCgpJIHdpbGwgc2VuZCBhIG5ldyB2ZXJzaW9uIChwcm9iYWJseSB0
b21vcnJvdykuCgpUaGFua3MKCgo+ICsKPiArCWVyciA9IHZpcnRxdWV1ZV9yZXNpemUocnEtPnZx
LCByaW5nX251bSwgdmlydG5ldF9ycV9mcmVlX3VudXNlZF9idWYpOwo+ICsJaWYgKGVycikKPiAr
CQluZXRkZXZfZXJyKHZpLT5kZXYsICJyZXNpemUgcnggZmFpbDogcnggcXVldWUgaW5kZXg6ICVk
IGVycjogJWRcbiIsIHFpbmRleCwgZXJyKTsKPiArCj4gKwlpZiAoIXRyeV9maWxsX3JlY3Yodmks
IHJxLCBHRlBfS0VSTkVMKSkKPiArCQlzY2hlZHVsZV9kZWxheWVkX3dvcmsoJnZpLT5yZWZpbGws
IDApOwo+ICsKPiArCXZpcnRuZXRfbmFwaV9lbmFibGUocnEtPnZxLCAmcnEtPm5hcGkpOwo+ICsJ
cmV0dXJuIGVycjsKPiArfQo+ICsKPiAgIC8qCj4gICAgKiBTZW5kIGNvbW1hbmQgdmlhIHRoZSBj
b250cm9sIHZpcnRxdWV1ZSBhbmQgY2hlY2sgc3RhdHVzLiAgQ29tbWFuZHMKPiAgICAqIHN1cHBv
cnRlZCBieSB0aGUgaHlwZXJ2aXNvciwgYXMgaW5kaWNhdGVkIGJ5IGZlYXR1cmUgYml0cywgc2hv
dWxkCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGlu
dXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=


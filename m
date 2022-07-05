Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8Xst-00DwlY-Q7
	for linux-um@lists.infradead.org; Tue, 05 Jul 2022 02:01:53 +0000
Message-ID: <1656986432.1164997-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v11 39/40] virtio_net: support tx queue resize
Date: Tue, 5 Jul 2022 10:00:32 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-40-xuanzhuo@linux.alibaba.com>
 <102d3b83-1ae9-a59a-16ce-251c22b7afb0@redhat.com>
In-Reply-To: <102d3b83-1ae9-a59a-16ce-251c22b7afb0@redhat.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Jason Wang <jasowang@redhat.com>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, "Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>, Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, linux-um@lists.infradead.org, netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, kangjie.xu@linux.alibaba.com, virtualization@lists.linux-foundation.org

T24gTW9uLCA0IEp1bCAyMDIyIDExOjQ1OjUyICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+IOWcqCAyMDIyLzYvMjkgMTQ6NTYsIFh1YW4gWmh1byDlhpnp
gZM6Cj4gPiBUaGlzIHBhdGNoIGltcGxlbWVudHMgdGhlIHJlc2l6ZSBmdW5jdGlvbiBvZiB0aGUg
dHggcXVldWVzLgo+ID4gQmFzZWQgb24gdGhpcyBmdW5jdGlvbiwgaXQgaXMgcG9zc2libGUgdG8g
bW9kaWZ5IHRoZSByaW5nIG51bSBvZiB0aGUKPiA+IHF1ZXVlLgo+ID4KPiA+IFNpZ25lZC1vZmYt
Ynk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gPiAtLS0KPiA+ICAg
ZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgNDggKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKwo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNDggaW5zZXJ0aW9ucygrKQo+ID4K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMKPiA+IGluZGV4IDZhYjE2ZmQxOTNlNS4uZmQzNTg0NjJmODAyIDEwMDY0NAo+
ID4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiArKysgYi9kcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMKPiA+IEBAIC0xMzUsNiArMTM1LDkgQEAgc3RydWN0IHNlbmRfcXVldWUgewo+
ID4gICAJc3RydWN0IHZpcnRuZXRfc3Ffc3RhdHMgc3RhdHM7Cj4gPgo+ID4gICAJc3RydWN0IG5h
cGlfc3RydWN0IG5hcGk7Cj4gPiArCj4gPiArCS8qIFJlY29yZCB3aGV0aGVyIHNxIGlzIGluIHJl
c2V0IHN0YXRlLiAqLwo+ID4gKwlib29sIHJlc2V0Owo+ID4gICB9Owo+ID4KPiA+ICAgLyogSW50
ZXJuYWwgcmVwcmVzZW50YXRpb24gb2YgYSByZWNlaXZlIHZpcnRxdWV1ZSAqLwo+ID4gQEAgLTI3
OSw2ICsyODIsNyBAQCBzdHJ1Y3QgcGFkZGVkX3ZuZXRfaGRyIHsKPiA+ICAgfTsKPiA+Cj4gPiAg
IHN0YXRpYyB2b2lkIHZpcnRuZXRfcnFfZnJlZV91bnVzZWRfYnVmKHN0cnVjdCB2aXJ0cXVldWUg
KnZxLCB2b2lkICpidWYpOwo+ID4gK3N0YXRpYyB2b2lkIHZpcnRuZXRfc3FfZnJlZV91bnVzZWRf
YnVmKHN0cnVjdCB2aXJ0cXVldWUgKnZxLCB2b2lkICpidWYpOwo+ID4KPiA+ICAgc3RhdGljIGJv
b2wgaXNfeGRwX2ZyYW1lKHZvaWQgKnB0cikKPiA+ICAgewo+ID4gQEAgLTE2MDMsNiArMTYwNywx
MSBAQCBzdGF0aWMgdm9pZCB2aXJ0bmV0X3BvbGxfY2xlYW50eChzdHJ1Y3QgcmVjZWl2ZV9xdWV1
ZSAqcnEpCj4gPiAgIAkJcmV0dXJuOwo+ID4KPiA+ICAgCWlmIChfX25ldGlmX3R4X3RyeWxvY2so
dHhxKSkgewo+ID4gKwkJaWYgKFJFQURfT05DRShzcS0+cmVzZXQpKSB7Cj4gPiArCQkJX19uZXRp
Zl90eF91bmxvY2sodHhxKTsKPiA+ICsJCQlyZXR1cm47Cj4gPiArCQl9Cj4gPiArCj4gPiAgIAkJ
ZG8gewo+ID4gICAJCQl2aXJ0cXVldWVfZGlzYWJsZV9jYihzcS0+dnEpOwo+ID4gICAJCQlmcmVl
X29sZF94bWl0X3NrYnMoc3EsIHRydWUpOwo+ID4gQEAgLTE4NjgsNiArMTg3Nyw0NSBAQCBzdGF0
aWMgaW50IHZpcnRuZXRfcnhfcmVzaXplKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+ID4gICAJ
cmV0dXJuIGVycjsKPiA+ICAgfQo+ID4KPiA+ICtzdGF0aWMgaW50IHZpcnRuZXRfdHhfcmVzaXpl
KHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+ID4gKwkJCSAgICAgc3RydWN0IHNlbmRfcXVldWUg
KnNxLCB1MzIgcmluZ19udW0pCj4gPiArewo+ID4gKwlzdHJ1Y3QgbmV0ZGV2X3F1ZXVlICp0eHE7
Cj4gPiArCWludCBlcnIsIHFpbmRleDsKPiA+ICsKPiA+ICsJcWluZGV4ID0gc3EgLSB2aS0+c3E7
Cj4gPiArCj4gPiArCXZpcnRuZXRfbmFwaV90eF9kaXNhYmxlKCZzcS0+bmFwaSk7Cj4gPiArCj4g
PiArCXR4cSA9IG5ldGRldl9nZXRfdHhfcXVldWUodmktPmRldiwgcWluZGV4KTsKPiA+ICsKPiA+
ICsJLyogMS4gd2FpdCBhbGwgeGltdCBjb21wbGV0ZQo+ID4gKwkgKiAyLiBmaXggdGhlIHJhY2Ug
b2YgbmV0aWZfc3RvcF9zdWJxdWV1ZSgpIHZzIG5ldGlmX3N0YXJ0X3N1YnF1ZXVlKCkKPiA+ICsJ
ICovCj4gPiArCV9fbmV0aWZfdHhfbG9ja19iaCh0eHEpOwo+ID4gKwo+ID4gKwkvKiBQcmV2ZW50
IHJ4IHBvbGwgZnJvbSBhY2Nlc3Npbmcgc3EuICovCj4gPiArCVdSSVRFX09OQ0Uoc3EtPnJlc2V0
LCB0cnVlKTsKPgo+Cj4gQ2FuIHdlIHNpbXBseSBkaXNhYmxlIFJYIE5BUEkgaGVyZT8KCkRpc2Fi
bGUgcnggbmFwaSBpcyBpbmRlZWQgYSBzaW1wbGUgc29sdXRpb24uIEJ1dCBJIGhvcGUgdGhhdCB3
aGVuIGRlYWxpbmcgd2l0aAp0eCwgaXQgd2lsbCBub3QgYWZmZWN0IHJ4LgoKVGhhbmtzLgoKCj4K
PiBUaGFua3MKPgo+Cj4gPiArCj4gPiArCS8qIFByZXZlbnQgdGhlIHVwcGVyIGxheWVyIGZyb20g
dHJ5aW5nIHRvIHNlbmQgcGFja2V0cy4gKi8KPiA+ICsJbmV0aWZfc3RvcF9zdWJxdWV1ZSh2aS0+
ZGV2LCBxaW5kZXgpOwo+ID4gKwo+ID4gKwlfX25ldGlmX3R4X3VubG9ja19iaCh0eHEpOwo+ID4g
Kwo+ID4gKwllcnIgPSB2aXJ0cXVldWVfcmVzaXplKHNxLT52cSwgcmluZ19udW0sIHZpcnRuZXRf
c3FfZnJlZV91bnVzZWRfYnVmKTsKPiA+ICsJaWYgKGVycikKPiA+ICsJCW5ldGRldl9lcnIodmkt
PmRldiwgInJlc2l6ZSB0eCBmYWlsOiB0eCBxdWV1ZSBpbmRleDogJWQgZXJyOiAlZFxuIiwgcWlu
ZGV4LCBlcnIpOwo+ID4gKwo+ID4gKwkvKiBNZW1vcnkgYmFycmllciBiZWZvcmUgc2V0IHJlc2V0
IGFuZCBzdGFydCBzdWJxdWV1ZS4gKi8KPiA+ICsJc21wX21iKCk7Cj4gPiArCj4gPiArCVdSSVRF
X09OQ0Uoc3EtPnJlc2V0LCBmYWxzZSk7Cj4gPiArCW5ldGlmX3R4X3dha2VfcXVldWUodHhxKTsK
PiA+ICsKPiA+ICsJdmlydG5ldF9uYXBpX3R4X2VuYWJsZSh2aSwgc3EtPnZxLCAmc3EtPm5hcGkp
Owo+ID4gKwlyZXR1cm4gZXJyOwo+ID4gK30KPiA+ICsKPiA+ICAgLyoKPiA+ICAgICogU2VuZCBj
b21tYW5kIHZpYSB0aGUgY29udHJvbCB2aXJ0cXVldWUgYW5kIGNoZWNrIHN0YXR1cy4gIENvbW1h
bmRzCj4gPiAgICAqIHN1cHBvcnRlZCBieSB0aGUgaHlwZXJ2aXNvciwgYXMgaW5kaWNhdGVkIGJ5
IGZlYXR1cmUgYml0cywgc2hvdWxkCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtdW0K


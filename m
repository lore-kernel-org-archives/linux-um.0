Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Message-ID: <1f26f6b4-4d33-6291-31c2-5cb68a5be829@linux.ibm.com>
Date: Fri, 6 May 2022 14:56:58 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 07/11] dasd: don't set the discard_alignment queue limit
Content-Language: en-US
References: <20220418045314.360785-1-hch@lst.de>
 <20220418045314.360785-8-hch@lst.de>
From: =?UTF-8?Q?Jan_H=c3=b6ppner?= <hoeppner@linux.ibm.com>
In-Reply-To: <20220418045314.360785-8-hch@lst.de>
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
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Richard Weinberger <richard@nod.at>, Johannes Berg <johannes@sipsolutions.net>, Josef Bacik <josef@toxicpanda.com>, "Md. Haris Iqbal" <haris.iqbal@ionos.com>, Jack Wang <jinpu.wang@ionos.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>, Mike Snitzer <snitzer@kernel.org>, Song Liu <song@kernel.org>, Stefan Haberland <sth@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-um@lists.infradead.org, linux-block@vger.kernel.org, nbd@other.debian.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org, dm-devel@redhat.com

T24gMTgvMDQvMjAyMiAwNjo1MywgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gVGhlIGRpc2Nh
cmRfYWxpZ25tZW50IHF1ZXVlIGxpbWl0IGlzIG5hbWVkIGEgYml0IG1pc2xlYWRpbmcgbWVhbnMg
dGhlCj4gb2Zmc2V0IGludG8gdGhlIGJsb2NrIGRldmljZSBhdCB3aGljaCB0aGUgZGlzY2FyZCBn
cmFudWxhcml0eSBzdGFydHMuCj4gU2V0dGluZyBpdCB0byBQQUdFX1NJWkUgd2hpbGUgdGhlIGRp
c2NhcmQgZ3JhbnVsYXJpdHkgaXMgdGhlIGJsb2NrIHNpemUKPiB0aGF0IGlzIHNtYWxsZXIgb3Ig
dGhlIHNhbWUgYXMgUEFHRV9TSVpFIGFzIGRvbmUgYnkgZGFzZCBpcyBtb3N0bHkKPiBoYXJtbGVz
cyBidXQgYWxzbyB1c2VsZXNzLgo+IAo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2ln
IDxoY2hAbHN0LmRlPgoKQWNrZWQtYnk6IEphbiBIw7ZwcG5lciA8aG9lcHBuZXJAbGludXguaWJt
LmNvbT4KClNvcnJ5IGZvciBhIHJhdGhlciBsYXRlIGFuc3dlci4gSSBzYXcgdGhhdCBKZW5zIGFs
cmVhZHkgYXBwbGllZAp0aGUgcGF0Y2hlcyBzbyBpdCdzIGZpbmUgd2hlbiB0aGUgQWNrIGlzbid0
IGFkZGVkIGFueW1vcmUuCldhbnRlZCB0byBzZW5kIGl0IGFueXdheSBzbyB0aGF0IHlvdSBrbm93
IHdlJ3JlIGF3YXJlIG9mIGl0LgoKPiAtLS0KPiAgZHJpdmVycy9zMzkwL2Jsb2NrL2Rhc2RfZmJh
LmMgfCAxIC0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9zMzkwL2Jsb2NrL2Rhc2RfZmJhLmMgYi9kcml2ZXJzL3MzOTAvYmxvY2svZGFz
ZF9mYmEuYwo+IGluZGV4IDhiZDU2NjVkYjkxOTguLjYwYmU3ZjdiZjJkMTYgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy9zMzkwL2Jsb2NrL2Rhc2RfZmJhLmMKPiArKysgYi9kcml2ZXJzL3MzOTAvYmxv
Y2svZGFzZF9mYmEuYwo+IEBAIC03ODIsNyArNzgyLDYgQEAgc3RhdGljIHZvaWQgZGFzZF9mYmFf
c2V0dXBfYmxrX3F1ZXVlKHN0cnVjdCBkYXNkX2Jsb2NrICpibG9jaykKPiAgCWJsa19xdWV1ZV9z
ZWdtZW50X2JvdW5kYXJ5KHEsIFBBR0VfU0laRSAtIDEpOwo+ICAKPiAgCXEtPmxpbWl0cy5kaXNj
YXJkX2dyYW51bGFyaXR5ID0gbG9naWNhbF9ibG9ja19zaXplOwo+IC0JcS0+bGltaXRzLmRpc2Nh
cmRfYWxpZ25tZW50ID0gUEFHRV9TSVpFOwo+ICAKPiAgCS8qIENhbGN1bGF0ZSBtYXhfZGlzY2Fy
ZF9zZWN0b3JzIGFuZCBtYWtlIGl0IFBBR0UgYWxpZ25lZCAqLwo+ICAJbWF4X2J5dGVzID0gVVNI
UlRfTUFYICogbG9naWNhbF9ibG9ja19zaXplOwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtdW0K


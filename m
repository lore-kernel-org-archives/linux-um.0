Return-Path: <linux-mtd-bounces+geert=linux-m68k.org@lists.infradead.org>
Message-ID: <e971095e-1015-c348-3c24-114193ee5ff0@linux.ibm.com>
Date: Mon, 11 Apr 2022 14:03:50 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 24/27] block: remove QUEUE_FLAG_DISCARD
Content-Language: en-US
References: <20220409045043.23593-1-hch@lst.de>
 <20220409045043.23593-25-hch@lst.de>
From: =?UTF-8?Q?Jan_H=c3=b6ppner?= <hoeppner@linux.ibm.com>
In-Reply-To: <20220409045043.23593-25-hch@lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+geert=linux-m68k.org@lists.infradead.org
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-um@lists.infradead.org, linux-block@vger.kernel.org, drbd-dev@lists.linbit.com, nbd@other.debian.org, ceph-devel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev, ocfs2-devel@oss.oracle.com, linux-mm@kvack.org, "Martin K . Petersen" <martin.petersen@oracle.com>, =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>, Coly Li <colyli@suse.de>
List-ID: <linux-um.lists.infradead.org>

T24gMDkvMDQvMjAyMiAwNjo1MCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gSnVzdCB1c2Ug
YSBub24temVybyBtYXhfZGlzY2FyZF9zZWN0b3JzIGFzIGFuIGluZGljYXRvciBmb3IgZGlzY2Fy
ZAo+IHN1cHBvcnQsIHNpbWlsYXIgdG8gd2hhdCBpcyBkb25lIGZvciB3cml0ZSB6ZXJvZXMuCj4g
Cj4gVGhlIG9ubHkgcGxhY2VzIHdoZXJlIG5lZWRzIHNwZWNpYWwgYXR0ZW50aW9uIGlzIHRoZSBS
QUlENSBkcml2ZXIsCj4gd2hpY2ggbXVzdCBjbGVhciBkaXNjYXJkIHN1cHBvcnQgZm9yIHNlY3Vy
aXR5IHJlYXNvbnMgYnkgZGVmYXVsdCwKPiBldmVuIGlmIHRoZSBkZWZhdWx0IHN0YWNraW5nIHJ1
bGVzIHdvdWxkIGFsbG93IGZvciBpdC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVs
bHdpZyA8aGNoQGxzdC5kZT4KPiBSZXZpZXdlZC1ieTogTWFydGluIEsuIFBldGVyc2VuIDxtYXJ0
aW4ucGV0ZXJzZW5Ab3JhY2xlLmNvbT4KPiBBY2tlZC1ieTogQ2hyaXN0b3BoIELDtmhtd2FsZGVy
IDxjaHJpc3RvcGguYm9laG13YWxkZXJAbGluYml0LmNvbT4gW2J0cmZzXQo+IEFja2VkLWJ5OiBD
b2x5IExpIDxjb2x5bGlAc3VzZS5kZT4gW2JjYWNoZV0KPiAtLS0KCkZvciAKCj4gIGRyaXZlcnMv
czM5MC9ibG9jay9kYXNkX2ZiYS5jICAgICAgIHwgIDEgLQoKQWNrZWQtYnk6IEphbiBIw7ZwcG5l
ciA8aG9lcHBuZXJAbGludXguaWJtLmNvbT4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eCBNVEQgZGlzY3Vzc2lvbiBtYWlsaW5nIGxp
c3QKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1tdGQv
Cg==


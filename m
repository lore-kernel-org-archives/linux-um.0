Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH 23/27] block: add a bdev_max_discard_sectors helper
Date: Fri, 15 Apr 2022 05:47:13 +0000
Message-ID: <3583727e-1260-0907-1b18-cad774750ed0@nvidia.com>
References: <20220415045258.199825-1-hch@lst.de>
 <20220415045258.199825-24-hch@lst.de>
In-Reply-To: <20220415045258.199825-24-hch@lst.de>
Content-Language: en-US
Content-ID: <198DA0096D964E4496BC8D9005BDA9B4@namprd12.prod.outlook.com>
MIME-Version: 1.0
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
Cc: "dm-devel@redhat.com" <dm-devel@redhat.com>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>, "nbd@other.debian.org" <nbd@other.debian.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>, "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>, "cluster-devel@redhat.com" <cluster-devel@redhat.com>, "jfs-discussion@lists.sourceforge.net" <jfs-discussion@lists.sourceforge.net>, "linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>, "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>, "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "Martin K . Petersen" <martin.petersen@oracle.com>, =?utf-8?B?Q2hyaXN0b3BoIELDtmhtd2FsZGVy?= <christoph.boehmwalder@linbit.com>, Coly Li <colyli@suse.de>, David Sterba <dsterba@suse.com>

T24gNC8xNC8yMiAyMTo1MiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEFkZCBhIGhlbHBl
ciB0byBxdWVyeSB0aGUgbnVtYmVyIG9mIHNlY3RvcnMgc3VwcG9ydCBwZXIgZWFjaCBkaXNjYXJk
IGJpbw0KPiBiYXNlZCBvbiB0aGUgYmxvY2sgZGV2aWNlIGFuZCB1c2UgdGhpcyBoZWxwZXIgdG8g
c3RvcCB2YXJpb3VzIHBsYWNlcyBmcm9tDQo+IHBva2luZyBpbnRvIHRoZSByZXF1ZXN0X3F1ZXVl
IHRvIHNlZSBpZiBkaXNjYXJkIGlzIHN1cHBvcnRlZCBhbmQgaWYgc28gaG93DQo+IG11Y2guICBU
aGlzIG1pcnJvcnMgd2hhdCBpcyBkb25lIGUuZy4gZm9yIHdyaXRlIHplcm9lcyBhcyB3ZWxsLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IFJl
dmlld2VkLWJ5OiBNYXJ0aW4gSy4gUGV0ZXJzZW4gPG1hcnRpbi5wZXRlcnNlbkBvcmFjbGUuY29t
Pg0KPiBBY2tlZC1ieTogQ2hyaXN0b3BoIELDtmhtd2FsZGVyIDxjaHJpc3RvcGguYm9laG13YWxk
ZXJAbGluYml0LmNvbT4gW2RyYmRdDQo+IEFja2VkLWJ5OiBDb2x5IExpIDxjb2x5bGlAc3VzZS5k
ZT4gW2JjYWNoZV0NCj4gQWNrZWQtYnk6IERhdmlkIFN0ZXJiYSA8ZHN0ZXJiYUBzdXNlLmNvbT4g
W2J0cmZzXQ0KPiAtLS0NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBL
dWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11
bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtdW0K


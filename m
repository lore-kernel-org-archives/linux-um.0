Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Message-ID: <ffa14a07-b8f9-828e-97bc-cf7a2099bab5@kernel.org>
Date: Sat, 16 Apr 2022 10:28:49 +0800
MIME-Version: 1.0
Subject: Re: [f2fs-dev] [PATCH 26/27] block: decouple REQ_OP_SECURE_ERASE from
 REQ_OP_DISCARD
Content-Language: en-US
References: <20220415045258.199825-1-hch@lst.de>
 <20220415045258.199825-27-hch@lst.de>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220415045258.199825-27-hch@lst.de>
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
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: jfs-discussion@lists.sourceforge.net, linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, dm-devel@redhat.com, target-devel@vger.kernel.org, linux-mtd@lists.infradead.org, drbd-dev@lists.linbit.com, linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org, linux-scsi@vger.kernel.org, cluster-devel@redhat.com, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, linux-um@lists.infradead.org, nbd@other.debian.org, linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org, Coly Li <colyli@suse.de>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, linux-raid@vger.kernel.org, "Martin K . Petersen" <martin.petersen@oracle.com>, linux-mmc@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>, ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org, ntfs3@lists.linux.dev, linux-btrfs@vger.kernel.org

T24gMjAyMi80LzE1IDEyOjUyLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBTZWN1cmUgZXJh
c2UgaXMgYSB2ZXJ5IGRpZmZlcmVudCBvcGVyYXRpb24gZnJvbSBkaXNjYXJkIGluIHRoYXQgaXQg
aXMKPiBhIGRhdGEgaW50ZWdyaXR5IG9wZXJhdGlvbiB2cyBoaW50LiAgRnVsbHkgc3BsaXQgdGhl
IGxpbWl0cyBhbmQgaGVscGVyCj4gaW5mcmFzdHJ1Y3R1cmUgdG8gbWFrZSB0aGUgc2VwYXJhdGlv
biBtb3JlIGNsZWFyLgo+IAo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hA
bHN0LmRlPgo+IFJldmlld2VkLWJ5OiBNYXJ0aW4gSy4gUGV0ZXJzZW4gPG1hcnRpbi5wZXRlcnNl
bkBvcmFjbGUuY29tPgo+IEFja2VkLWJ5OiBDaHJpc3RvcGggQsO2aG13YWxkZXIgPGNocmlzdG9w
aC5ib2VobXdhbGRlckBsaW5iaXQuY29tPiBbZHJiZF0KPiBBY2tlZC1ieTogUnl1c3VrZSBLb25p
c2hpIDxrb25pc2hpLnJ5dXN1a2VAZ21haWwuY29tPiBbbmlmczJdCj4gQWNrZWQtYnk6IEphZWdl
dWsgS2ltIDxqYWVnZXVrQGtlcm5lbC5vcmc+IFtmMmZzXQo+IEFja2VkLWJ5OiBDb2x5IExpIDxj
b2x5bGlAc3VzZS5kZT4gW2JjYWNoZV0KPiBBY2tlZC1ieTogRGF2aWQgU3RlcmJhIDxkc3RlcmJh
QHN1c2UuY29tPiBbYnRyZnNdCgpGb3IgZjJmcyBwYXJ0LAoKQWNrZWQtYnk6IENoYW8gWXUgPGNo
YW9Aa2VybmVsLm9yZz4KClRoYW5rcywKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtdW0K


Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 03/27] target: fix discard alignment on partitions
Date: Wed,  6 Apr 2022 08:04:52 +0200
Message-Id: <20220406060516.409838-4-hch@lst.de>
In-Reply-To: <20220406060516.409838-1-hch@lst.de>
References: <20220406060516.409838-1-hch@lst.de>
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
To: Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-um@lists.infradead.org, linux-block@vger.kernel.org, drbd-dev@lists.linbit.com, nbd@other.debian.org, ceph-devel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev, ocfs2-devel@oss.oracle.com, linux-mm@kvack.org

VXNlIHRoZSBwcm9wZXIgYmRldl9kaXNjYXJkX2FsaWdubWVudCBoZWxwZXIgdGhhdCBhY2NvdW50
cyBmb3IgcGFydGl0aW9uCm9mZnNldHMuCgpG0ZZ4ZXM6IGM2NmFjOWRiOGQ0YSAoIltTQ1NJXSB0
YXJnZXQ6IEFkZCBMSU8gdGFyZ2V0IGNvcmUgdjQuMC4wLXJjNiIpClNpZ25lZC1vZmYtYnk6IENo
cmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPgotLS0KIGRyaXZlcnMvdGFyZ2V0L3RhcmdldF9j
b3JlX2RldmljZS5jIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGFyZ2V0L3RhcmdldF9jb3JlX2Rl
dmljZS5jIGIvZHJpdmVycy90YXJnZXQvdGFyZ2V0X2NvcmVfZGV2aWNlLmMKaW5kZXggM2ExZWM3
MDVjZDgwYi4uMTZlNzc1YmNmNGE3YyAxMDA2NDQKLS0tIGEvZHJpdmVycy90YXJnZXQvdGFyZ2V0
X2NvcmVfZGV2aWNlLmMKKysrIGIvZHJpdmVycy90YXJnZXQvdGFyZ2V0X2NvcmVfZGV2aWNlLmMK
QEAgLTg0OSw4ICs4NDksOCBAQCBib29sIHRhcmdldF9jb25maWd1cmVfdW5tYXBfZnJvbV9xdWV1
ZShzdHJ1Y3Qgc2VfZGV2X2F0dHJpYiAqYXR0cmliLAogCSAqLwogCWF0dHJpYi0+bWF4X3VubWFw
X2Jsb2NrX2Rlc2NfY291bnQgPSAxOwogCWF0dHJpYi0+dW5tYXBfZ3JhbnVsYXJpdHkgPSBxLT5s
aW1pdHMuZGlzY2FyZF9ncmFudWxhcml0eSAvIGJsb2NrX3NpemU7Ci0JYXR0cmliLT51bm1hcF9n
cmFudWxhcml0eV9hbGlnbm1lbnQgPSBxLT5saW1pdHMuZGlzY2FyZF9hbGlnbm1lbnQgLwotCQkJ
CQkJCQlibG9ja19zaXplOworCWF0dHJpYi0+dW5tYXBfZ3JhbnVsYXJpdHlfYWxpZ25tZW50ID0K
KwkJYmRldl9kaXNjYXJkX2FsaWdubWVudChiZGV2KSAvIGJsb2NrX3NpemU7CiAJcmV0dXJuIHRy
dWU7CiB9CiBFWFBPUlRfU1lNQk9MKHRhcmdldF9jb25maWd1cmVfdW5tYXBfZnJvbV9xdWV1ZSk7
Ci0tIAoyLjMwLjIKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==


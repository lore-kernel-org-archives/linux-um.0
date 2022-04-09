Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nd6Fx-002ZOI-HP
 for linux-um@lists.infradead.org; Sat, 09 Apr 2022 08:15:45 +0000
Received: by mail-wr1-x433.google.com with SMTP id m30so16080132wrb.1
 for <linux-um@lists.infradead.org>; Sat, 09 Apr 2022 01:15:38 -0700 (PDT)
Message-ID: <72e9bd34-3380-e305-65f0-a17306f5bd08@linbit.com>
Date: Sat, 9 Apr 2022 10:15:33 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 24/27] block: remove QUEUE_FLAG_DISCARD
Content-Language: en-US
References: <20220409045043.23593-1-hch@lst.de>
 <20220409045043.23593-25-hch@lst.de>
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20220409045043.23593-25-hch@lst.de>
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
To: Christoph Hellwig <hch@lst.de>
Cc: dm-devel@redhat.com, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-um@lists.infradead.org, linux-block@vger.kernel.org, drbd-dev@lists.linbit.com, nbd@other.debian.org, ceph-devel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, Jens Axboe <axboe@kernel.dk>, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev, ocfs2-devel@oss.oracle.com, linux-mm@kvack.org, "Martin K . Petersen" <martin.petersen@oracle.com>, Coly Li <colyli@suse.de>

T24gMDkuMDQuMjIgMDY6NTAsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+IEp1c3QgdXNlIGEg
bm9uLXplcm8gbWF4X2Rpc2NhcmRfc2VjdG9ycyBhcyBhbiBpbmRpY2F0b3IgZm9yIGRpc2NhcmQK
PiBzdXBwb3J0LCBzaW1pbGFyIHRvIHdoYXQgaXMgZG9uZSBmb3Igd3JpdGUgemVyb2VzLgo+IAo+
IFRoZSBvbmx5IHBsYWNlcyB3aGVyZSBuZWVkcyBzcGVjaWFsIGF0dGVudGlvbiBpcyB0aGUgUkFJ
RDUgZHJpdmVyLAo+IHdoaWNoIG11c3QgY2xlYXIgZGlzY2FyZCBzdXBwb3J0IGZvciBzZWN1cml0
eSByZWFzb25zIGJ5IGRlZmF1bHQsCj4gZXZlbiBpZiB0aGUgZGVmYXVsdCBzdGFja2luZyBydWxl
cyB3b3VsZCBhbGxvdyBmb3IgaXQuCj4gCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3
aWcgPGhjaEBsc3QuZGU+Cj4gUmV2aWV3ZWQtYnk6IE1hcnRpbiBLLiBQZXRlcnNlbiA8bWFydGlu
LnBldGVyc2VuQG9yYWNsZS5jb20+Cj4gQWNrZWQtYnk6IENocmlzdG9waCBCw7ZobXdhbGRlciA8
Y2hyaXN0b3BoLmJvZWhtd2FsZGVyQGxpbmJpdC5jb20+IFtidHJmc10KCkkgdGhpbmsgeW91IG1h
eSBoYXZlIGEgdHlwbyB0aGVyZTogbXkgQUNLIHdhcyBmb3IgZHJiZCwgbm90IGJ0cmZzLgoKPiBB
Y2tlZC1ieTogQ29seSBMaSA8Y29seWxpQHN1c2UuZGU+IFtiY2FjaGVdCj4gLS0tCj4gICBhcmNo
L3VtL2RyaXZlcnMvdWJkX2tlcm4uYyAgICAgICAgICB8ICAyIC0tCj4gICBibG9jay9ibGstY29y
ZS5jICAgICAgICAgICAgICAgICAgICB8ICAyICstCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LXVtCg==


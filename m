Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH 03/11] null_blk: don't set the discard_alignment queue
 limit
Date: Mon, 18 Apr 2022 21:22:25 +0000
Message-ID: <89b62032-297a-1201-3a35-fa1731a0d620@nvidia.com>
References: <20220418045314.360785-1-hch@lst.de>
 <20220418045314.360785-4-hch@lst.de>
In-Reply-To: <20220418045314.360785-4-hch@lst.de>
Content-Language: en-US
Content-ID: <ED7EE68D9ECC2E45BB1E6AA4E02C1AC7@namprd12.prod.outlook.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Richard Weinberger <richard@nod.at>, Johannes Berg <johannes@sipsolutions.net>, Josef Bacik <josef@toxicpanda.com>, "Md. Haris Iqbal  <haris.iqbal@ionos.com>, Jack Wang <jinpu.wang@ionos.com>,  Michael S. Tsirkin  <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, =?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?=" <roger.pau@citrix.com>, Mike Snitzer <snitzer@kernel.org>, Song Liu <song@kernel.org>, Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, "Martin K." Petersen" <martin.petersen@oracle.com>, "linux-um@lists.infradead.org, linux-um@lists.infradead.org, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "nbd@other.debian.org" <nbd@other.debian.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>, "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "dm-devel@redhat.com" <dm-devel@redhat.com>

On 4/17/22 21:53, Christoph Hellwig wrote:
> The discard_alignment queue limit is named a bit misleading means the
> offset into the block device at which the discard granularity starts.
> Setting it to the discard granularity as done by null_blk is mostly
> harmless but also useless.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

-ck



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


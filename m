Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Subject: Re: [dm-devel] [PATCH 10/15] sd: use bvec_virt
References: <20210804095634.460779-1-hch@lst.de>
 <20210804095634.460779-11-hch@lst.de>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <8b487c0f-71be-19d6-249c-9cd1ba228548@acm.org>
Date: Thu, 5 Aug 2021 09:31:08 -0700
MIME-Version: 1.0
In-Reply-To: <20210804095634.460779-11-hch@lst.de>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>, Mike Snitzer <snitzer@redhat.com>, linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org, Song Liu <song@kernel.org>, dm-devel@redhat.com, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, Richard Weinberger <richard@nod.at>, Ilya Dryomov <idryomov@gmail.com>, linux-um@lists.infradead.org, Coly Li <colyli@suse.de>, linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org, Stefan Haberland <sth@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, ceph-devel@vger.kernel.org, linux-block@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>, Geoff Levand <geoff@infradead.org>, Phillip Lougher <phillip@squashfs.org.uk>

On 8/4/21 2:56 AM, Christoph Hellwig wrote:
> Use bvec_virt instead of open coding it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/scsi/sd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index b8d55af763f9..5b5b8266e142 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -886,7 +886,7 @@ static blk_status_t sd_setup_unmap_cmnd(struct scsi_cmnd *cmd)
>   	cmd->cmnd[0] = UNMAP;
>   	cmd->cmnd[8] = 24;
>   
> -	buf = page_address(rq->special_vec.bv_page);
> +	buf = bvec_virt(&rq->special_vec);
>   	put_unaligned_be16(6 + 16, &buf[0]);
>   	put_unaligned_be16(16, &buf[2]);
>   	put_unaligned_be64(lba, &buf[8]);

The patch description is not correct. The above patch involves a 
functional change while the patch description suggests that no 
functionality has been changed.

Although the above patch looks fine to me, why has page_address() been 
changed into bvec_virt() in the sd driver? My understanding is that the 
sd driver always sets bv_offset to zero.

Thanks,

Bart.



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


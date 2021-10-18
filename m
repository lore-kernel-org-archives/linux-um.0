Return-Path: <mcgrof@infradead.org>
Date: Mon, 18 Oct 2021 13:31:53 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 1/9] scsi/sd: add error handling support for add_disk()
Message-ID: <YW3ZuQv1qpIXkd5b@bombadil.infradead.org>
References: <20211015233028.2167651-1-mcgrof@kernel.org>
 <20211015233028.2167651-2-mcgrof@kernel.org>
 <yq1bl3ofjo5.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1bl3ofjo5.fsf@ca-mkp.ca.oracle.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>, axboe@kernel.dk
Cc: jejb@linux.ibm.com, agk@redhat.com, snitzer@redhat.com, colyli@suse.de, kent.overstreet@gmail.com, boris.ostrovsky@oracle.com, jgross@suse.com, sstabellini@kernel.org, roger.pau@citrix.com, geert@linux-m68k.org, ulf.hansson@linaro.org, tj@kernel.org, hare@suse.de, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, johannes.berg@intel.com, krisman@collabora.com, chris.obbard@collabora.com, thehajime@gmail.com, zhuyifei1999@gmail.com, haris.iqbal@ionos.com, jinpu.wang@ionos.com, miquel.raynal@bootlin.com, vigneshr@ti.com, linux-mtd@lists.infradead.org, linux-scsi@vger.kernel.org, dm-devel@redhat.com, linux-bcache@vger.kernel.org, xen-devel@lists.xenproject.org, linux-m68k@lists.linux-m68k.org, linux-um@lists.infradead.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
List-ID: <linux-um.lists.infradead.org>

On Sat, Oct 16, 2021 at 10:51:48PM -0400, Martin K. Petersen wrote:
> 
> Luis,
> 
> > We never checked for errors on add_disk() as this function returned
> > void. Now that this is fixed, use the shiny new error handling.
> >
> > As with the error handling for device_add() we follow the same logic
> > and just put the device so that cleanup is done via the
> > scsi_disk_release().
> 
> Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

Thanks, would you like Jens to pick this up and the other scsi/sr patch
or are you taking it through your tree?

  Luis


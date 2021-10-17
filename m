Return-Path: <martin.petersen@oracle.com>
Subject: Re: [PATCH 1/9] scsi/sd: add error handling support for add_disk()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Message-ID: <yq1bl3ofjo5.fsf@ca-mkp.ca.oracle.com>
References: <20211015233028.2167651-1-mcgrof@kernel.org>
	<20211015233028.2167651-2-mcgrof@kernel.org>
Date: Sat, 16 Oct 2021 22:51:48 -0400
In-Reply-To: <20211015233028.2167651-2-mcgrof@kernel.org> (Luis Chamberlain's
	message of "Fri, 15 Oct 2021 16:30:20 -0700")
Content-Type: text/plain
MIME-Version: 1.0
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com, agk@redhat.com, snitzer@redhat.com, colyli@suse.de, kent.overstreet@gmail.com, boris.ostrovsky@oracle.com, jgross@suse.com, sstabellini@kernel.org, roger.pau@citrix.com, geert@linux-m68k.org, ulf.hansson@linaro.org, tj@kernel.org, hare@suse.de, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, johannes.berg@intel.com, krisman@collabora.com, chris.obbard@collabora.com, thehajime@gmail.com, zhuyifei1999@gmail.com, haris.iqbal@ionos.com, jinpu.wang@ionos.com, miquel.raynal@bootlin.com, vigneshr@ti.com, linux-mtd@lists.infradead.org, linux-scsi@vger.kernel.org, dm-devel@redhat.com, linux-bcache@vger.kernel.org, xen-devel@lists.xenproject.org, linux-m68k@lists.linux-m68k.org, linux-um@lists.infradead.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
List-ID: <linux-um.lists.infradead.org>


Luis,

> We never checked for errors on add_disk() as this function returned
> void. Now that this is fixed, use the shiny new error handling.
>
> As with the error handling for device_add() we follow the same logic
> and just put the device so that cleanup is done via the
> scsi_disk_release().

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering


Return-Path: <martin.petersen@oracle.com>
Subject: Re: [PATCH 1/9] scsi/sd: add error handling support for add_disk()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Message-ID: <yq1pms1d8w4.fsf@ca-mkp.ca.oracle.com>
References: <20211015233028.2167651-1-mcgrof@kernel.org>
	<20211015233028.2167651-2-mcgrof@kernel.org>
	<yq1bl3ofjo5.fsf@ca-mkp.ca.oracle.com>
	<YW3ZuQv1qpIXkd5b@bombadil.infradead.org>
Date: Mon, 18 Oct 2021 22:52:44 -0400
In-Reply-To: <YW3ZuQv1qpIXkd5b@bombadil.infradead.org> (Luis Chamberlain's
	message of "Mon, 18 Oct 2021 13:31:53 -0700")
Content-Type: text/plain
MIME-Version: 1.0
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, axboe@kernel.dk, jejb@linux.ibm.com, agk@redhat.com, snitzer@redhat.com, colyli@suse.de, kent.overstreet@gmail.com, boris.ostrovsky@oracle.com, jgross@suse.com, sstabellini@kernel.org, roger.pau@citrix.com, geert@linux-m68k.org, ulf.hansson@linaro.org, tj@kernel.org, hare@suse.de, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, johannes.berg@intel.com, krisman@collabora.com, chris.obbard@collabora.com, thehajime@gmail.com, zhuyifei1999@gmail.com, haris.iqbal@ionos.com, jinpu.wang@ionos.com, miquel.raynal@bootlin.com, vigneshr@ti.com, linux-mtd@lists.infradead.org, linux-scsi@vger.kernel.org, dm-devel@redhat.com, linux-bcache@vger.kernel.org, xen-devel@lists.xenproject.org, linux-m68k@lists.linux-m68k.org, linux-um@lists.infradead.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
List-ID: <linux-um.lists.infradead.org>


Luis,

> Thanks, would you like Jens to pick this up and the other scsi/sr patch
> or are you taking it through your tree?

Didn't think I had the relevant add_disk() patch in my baseline tree but
it turns out I do. So I queued them up.

Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering


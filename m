Return-Path: <martin.petersen@oracle.com>
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 0/9] block: reviewed add_disk() error handling set
Date: Wed, 20 Oct 2021 23:42:44 -0400
Message-Id: <163478764105.7011.9400354892813636458.b4-ty@oracle.com>
In-Reply-To: <20211015233028.2167651-1-mcgrof@kernel.org>
References: <20211015233028.2167651-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: zhuyifei1999@gmail.com, thehajime@gmail.com, hare@suse.de, jinpu.wang@ionos.com, jgross@suse.com, johannes.berg@intel.com, geert@linux-m68k.org, linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com, axboe@kernel.dk, Luis Chamberlain <mcgrof@kernel.org>, jdike@addtoit.com, kent.overstreet@gmail.com, richard@nod.at, colyli@suse.de, agk@redhat.com, haris.iqbal@ionos.com, krisman@collabora.com, roger.pau@citrix.com, anton.ivanov@cambridgegreys.com, sstabellini@kernel.org, ulf.hansson@linaro.org, vigneshr@ti.com, chris.obbard@collabora.com, jejb@linux.ibm.com, boris.ostrovsky@oracle.com, tj@kernel.org, snitzer@redhat.com
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, linux-um@lists.infradead.org, linux-block@vger.kernel.org, xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, dm-devel@redhat.com, linux-bcache@vger.kernel.org
List-ID: <linux-um.lists.infradead.org>

On Fri, 15 Oct 2021 16:30:19 -0700, Luis Chamberlain wrote:

> Jens,
> 
> I had last split up patches into 7 groups, but at this point now
> most changes are merged except a few more drivers. Instead of creating
> a new patch set for each of the 7 groups I'm creating 3 new groups of
> patches now:
> 
> [...]

Applied to 5.16/scsi-queue, thanks!

[1/9] scsi/sd: add error handling support for add_disk()
      https://git.kernel.org/mkp/scsi/c/2a7a891f4c40
[2/9] scsi/sr: add error handling support for add_disk()
      https://git.kernel.org/mkp/scsi/c/e9d658c2175b

-- 
Martin K. Petersen	Oracle Linux Engineering


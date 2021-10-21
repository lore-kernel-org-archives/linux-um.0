Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20211015233028.2167651-1-mcgrof@kernel.org>
References: <20211015233028.2167651-1-mcgrof@kernel.org>
Subject: Re: (subset) [PATCH 0/9] block: reviewed add_disk() error handling set
Message-Id: <163482846658.50565.12530170761457767964.b4-ty@kernel.dk>
Date: Thu, 21 Oct 2021 09:01:06 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: thehajime@gmail.com, zhuyifei1999@gmail.com, haris.iqbal@ionos.com, johannes.berg@intel.com, roger.pau@citrix.com, miquel.raynal@bootlin.com, jdike@addtoit.com, anton.ivanov@cambridgegreys.com, geert@linux-m68k.org, krisman@collabora.com, vigneshr@ti.com, richard@nod.at, hare@suse.de, jinpu.wang@ionos.com, jgross@suse.com, sstabellini@kernel.org, ulf.hansson@linaro.org, agk@redhat.com, linux-mtd@lists.infradead.org, Luis Chamberlain <mcgrof@kernel.org>, tj@kernel.org, colyli@suse.de, jejb@linux.ibm.com, chris.obbard@collabora.com, snitzer@redhat.com, boris.ostrovsky@oracle.com, kent.overstreet@gmail.com, martin.petersen@oracle.com
Cc: linux-block@vger.kernel.org, dm-devel@redhat.com, xen-devel@lists.xenproject.org, linux-um@lists.infradead.org, linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-scsi@vger.kernel.org
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

Applied, thanks!

[3/9] dm: add add_disk() error handling
      commit: e7089f65dd51afeda5eb760506b5950d95f9ec29
[4/9] bcache: add error handling support for add_disk()
      commit: 2961c3bbcaec0ed7fb7b9a465b3796f37f2294e5
[5/9] xen-blkfront: add error handling support for add_disk()
      commit: 293a7c528803321479593d42d0898bb5a9769db1
[6/9] m68k/emu/nfblock: add error handling support for add_disk()
      commit: 21fd880d3da7564bab68979417cab7408e4f9642
[7/9] um/drivers/ubd_kern: add error handling support for add_disk()
      commit: 66638f163a2b5c5b462ca38525129b14a20117eb
[8/9] rnbd: add error handling support for add_disk()
      commit: 2e9e31bea01997450397d64da43b6675e0adb9e3
[9/9] mtd: add add_disk() error handling
      commit: 83b863f4a3f0de4ece7802d9121fed0c3e64145f

Best regards,
-- 
Jens Axboe




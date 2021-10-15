Return-Path: <mcgrof@infradead.org>
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 0/9] block: reviewed add_disk() error handling set
Date: Fri, 15 Oct 2021 16:30:19 -0700
Message-Id: <20211015233028.2167651-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
To: axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com, agk@redhat.com, snitzer@redhat.com, colyli@suse.de, kent.overstreet@gmail.com, boris.ostrovsky@oracle.com, jgross@suse.com, sstabellini@kernel.org, roger.pau@citrix.com, geert@linux-m68k.org, ulf.hansson@linaro.org, tj@kernel.org, hare@suse.de, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, johannes.berg@intel.com, krisman@collabora.com, chris.obbard@collabora.com, thehajime@gmail.com, zhuyifei1999@gmail.com, haris.iqbal@ionos.com, jinpu.wang@ionos.com, miquel.raynal@bootlin.com, vigneshr@ti.com, linux-mtd@lists.infradead.org
Cc: linux-scsi@vger.kernel.org, dm-devel@redhat.com, linux-bcache@vger.kernel.org, xen-devel@lists.xenproject.org, linux-m68k@lists.linux-m68k.org, linux-um@lists.infradead.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
List-ID: <linux-um.lists.infradead.org>

Jens,

I had last split up patches into 7 groups, but at this point now
most changes are merged except a few more drivers. Instead of creating
a new patch set for each of the 7 groups I'm creating 3 new groups of
patches now:

  * This set, for which we already have an Acked-by or Reviewed-by tag,
    it would be nice to get clarification of driver maintainers want
    these to go through you or if a the maintainers want to pick these
    changes up themselves.

  * A second set will deal with patches which have no reviews done for
    them yet 

  * The last set deals with the __register_blkdev() change and the
    __must_check change which ensures we don't let in new drivers
    which don't deal with error handling.

If you're a maintainer of any of the below patches and wish for them to
go through Jens' tree directly now would be a good time to say so or
you can just pick the patch up yourself.

Luis Chamberlain (9):
  scsi/sd: add error handling support for add_disk()
  scsi/sr: add error handling support for add_disk()
  dm: add add_disk() error handling
  bcache: add error handling support for add_disk()
  xen-blkfront: add error handling support for add_disk()
  m68k/emu/nfblock: add error handling support for add_disk()
  um/drivers/ubd_kern: add error handling support for add_disk()
  rnbd: add error handling support for add_disk()
  mtd: add add_disk() error handling

 arch/m68k/emu/nfblock.c       |  9 +++++++--
 arch/um/drivers/ubd_kern.c    | 13 +++++++++----
 drivers/block/rnbd/rnbd-clt.c | 13 +++++++++----
 drivers/block/xen-blkfront.c  |  8 +++++++-
 drivers/md/bcache/super.c     | 17 ++++++++++++-----
 drivers/md/dm.c               |  4 +++-
 drivers/mtd/mtd_blkdevs.c     |  6 +++++-
 drivers/scsi/sd.c             |  8 +++++++-
 drivers/scsi/sr.c             |  7 ++++++-
 9 files changed, 65 insertions(+), 20 deletions(-)

-- 
2.30.2



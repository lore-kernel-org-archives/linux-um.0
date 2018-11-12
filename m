Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gMGE6-0000TY-Uk
 for linux-um@lists.infradead.org; Mon, 12 Nov 2018 17:42:20 +0000
From: anton.ivanov@cambridgegreys.com
Subject: New Patch series for the UBD Driver
Date: Mon, 12 Nov 2018 17:41:58 +0000
Message-Id: <20181112174201.12290-1-anton.ivanov@cambridgegreys.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: axboe@kernel.dk, richard@nod.at, hch@lst.de

This is the revised patchset for the ubd driver. Known issues:

1. If an error is returned to an operation different from READ/WRITE/SYNC
the block subsystem goes south finishing with a crash. I have tried everything
I can think of and whatever I could lift out of the loop and nbd driver. I do
not think that the problem is in the ubd driver. I am lost here, Jens can you
please give me a hand in handling the case when ubd_handler() gets an error in
reply to a discard.

2. The QEMU discard/fallocate test is not run-time and is rather flaky as it
tries to operate on stdin, not on a filesystem. Copying it to UML does not bring
a lot of value. There is an added complication that fallocate with
a length of zero is an EINVAL, so you actually have to wipe some data in the
target file for real for the test for fallocate availability to be robust. So
if there is the need for a runtime test it has to read/fallocate/write back
data. As the most common ubd format is a plain ext2/3/4 fs with no boot record
the offset zero and length of sizeof(int) are as safe as it can get. 
Unfortunately, less safe for other fs types, but there is little I can do there.

3. This, I think is somehow related to 1. Very heavy IO like for example
dd if=/dev/zero of=/testfile bs=1M count=16M will block memory allocations and
things will start dying on OOM. That started with 4.20-rc1+fixes, it did not
exist in 4.19.

[PATCH 1/3] um: Switch to block-mq constants in the UML UBD driver
[PATCH 2/3] um: Clean-up command processing in UML UBD driver
[PATCH 3/3] um: Add support for DISCARD in the UBD Driver

Best Regards,

A.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


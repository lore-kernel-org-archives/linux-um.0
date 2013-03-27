Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fengguang.wu@intel.com>) id 1UKq1b-0006c5-AB
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Mar 2013 13:04:19 +0000
Received: from mga01.intel.com ([192.55.52.88])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UKq1Z-0005B7-Jj for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Mar 2013 13:04:19 +0000
Date: Wed, 27 Mar 2013 21:04:06 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
Message-ID: <20130327130406.GB20519@localhost>
References: <5152db35.FfTcFL4aC1dSAQ8P%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5152db35.FfTcFL4aC1dSAQ8P%fengguang.wu@intel.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] drivers/net/ethernet/marvell/mvmdio.c:191:3: error:
 implicit declaration of function 'iounmap'
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: user-mode-linux-devel@lists.sourceforge.net


Hi Thomas,

FYI, kernel build failed on

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux master
head:   de55eb1d60d2ed0f1ba5e13226d91b3bfbe1c108
commit: fc8f5aded1cf9f5505c55694b36174621c7ac88c net: mvmdio: new Marvell MDIO driver
date:   4 months ago
config: make ARCH=um allyesconfig

All error/warnings:

   drivers/net/ethernet/marvell/mvmdio.c: In function 'orion_mdio_probe':
>> drivers/net/ethernet/marvell/mvmdio.c:191:3: error: implicit declaration of function 'iounmap' [-Werror=implicit-function-declaration]
   cc1: some warnings being treated as errors

vim +/iounmap +191 drivers/net/ethernet/marvell/mvmdio.c

fc8f5ade Thomas Petazzoni 2012-11-12  185  
fc8f5ade Thomas Petazzoni 2012-11-12  186  	mutex_init(&dev->lock);
fc8f5ade Thomas Petazzoni 2012-11-12  187  
fc8f5ade Thomas Petazzoni 2012-11-12  188  	ret = of_mdiobus_register(bus, np);
fc8f5ade Thomas Petazzoni 2012-11-12  189  	if (ret < 0) {
fc8f5ade Thomas Petazzoni 2012-11-12  190  		dev_err(&pdev->dev, "Cannot register MDIO bus (%d)\n", ret);
fc8f5ade Thomas Petazzoni 2012-11-12 @191  		iounmap(dev->smireg);
fc8f5ade Thomas Petazzoni 2012-11-12  192  		kfree(bus->irq);
fc8f5ade Thomas Petazzoni 2012-11-12  193  		mdiobus_free(bus);
fc8f5ade Thomas Petazzoni 2012-11-12  194  		return ret;

---
0-DAY kernel build testing backend              Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation

------------------------------------------------------------------------------
Own the Future-Intel&reg; Level Up Game Demo Contest 2013
Rise to greatness in Intel's independent game demo contest.
Compete for recognition, cash, and the chance to get your game 
on Steam. $5K grand prize plus 10 genre and skill prizes. 
Submit your demo by 6/6/13. http://p.sf.net/sfu/intel_levelupd2d
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5nU1-00CavW-GR
 for linux-um@lists.infradead.org; Tue, 20 Jul 2021 11:00:19 +0000
From: Roberto Sassu <roberto.sassu@huawei.com>
Subject: linux process killed after poweroff
Date: Tue, 20 Jul 2021 11:00:09 +0000
Message-ID: <18247e831eac439fa066a56efa3e96e6@huawei.com>
Content-Language: en-US
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
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>, "anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>, "richard@nod.at" <richard@nod.at>
Cc: "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>

Hi everyone

I found a change of behavior after:

commit ccf1236ecac476d9d2704866d9a476c86e387971
Author: Zhen Lei <thunder.leizhen@huawei.com>
Date:   Sat May 8 11:22:39 2021 +0800

    um: fix error return code in winch_tramp()

When linux (UML) is executed inside a script, the following
error message appears:


root@(none):/# poweroff -f
Powering off.
reboot: System halted
./test.sh: line 3: 1474370 Killed                  ./linux rootfstype=hostfs mem=256M init=/bin/bash
                                                                                                    137

Before this patch:

root@(none):/# poweroff -f
Powering off.
reboot: System halted

0

The script I used for the test is:

#! /bin/bash

./linux rootfstype=hostfs mem=256M init=/bin/bash
echo $?

I'm using the exit code of linux to determine whether or not
a test executed inside UML was successful. Is the new behavior
intended?

Thanks

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


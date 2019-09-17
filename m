Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iADYv-0003CY-FQ
 for linux-um@lists.infradead.org; Tue, 17 Sep 2019 13:30:36 +0000
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <johannes@sipsolutions.net>) id 1iADYr-0005GC-MV
 for linux-um@lists.infradead.org; Tue, 17 Sep 2019 15:30:29 +0200
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [RFC v3 0/2] um: synchronized time-travel
Date: Tue, 17 Sep 2019 15:29:42 +0200
Message-Id: <20190917132943.20102-1-johannes@sipsolutions.net>
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
To: linux-um@lists.infradead.org

This seems to work now. On top of qemu, I have the following patches:
https://lore.kernel.org/qemu-devel/20190903192505.10686-1-johannes@sipsolutions.net/
https://lore.kernel.org/qemu-devel/20190827124909.16824-1-johannes@sipsolutions.net/
https://lore.kernel.org/qemu-devel/20190917122512.15320-1-johannes@sipsolutions.net/
https://lore.kernel.org/qemu-devel/20190917122559.15555-1-johannes@sipsolutions.net/
https://lore.kernel.org/qemu-devel/20190917122625.15614-1-johannes@sipsolutions.net/
https://lore.kernel.org/qemu-devel/20190917122625.15614-2-johannes@sipsolutions.net/
https://lore.kernel.org/qemu-devel/20190917122644.15736-1-johannes@sipsolutions.net/

And 'make vhost-user-sim' builds a program there that speaks the UML
simulation time protocol and implements a virtual ethernet network.

With all the patches I sent to UML, I have a start script like this:

-------------
#!/bin/sh

~/hwsim/qemu/vhost-user-sim -s /tmp/clock -n /tmp/net 2>&1 | tee /tmp/sim.log &
(sleep 0.5 ; /path/to/linux mem=128M init=$(pwd)/test.sh root=none \
                            hostfs=/ rootfstype=hostfs rootflags=/ \
                            time-travel=ext:/tmp/clock \
                            virtio_uml.device=/tmp/net:1 >/tmp/log1) &
(sleep 1.5 ; /path/to/linux mem=128M init=$(pwd)/test2.sh root=none \
                            hostfs=/ rootfstype=hostfs rootflags=/ \
                            time-travel=ext:/tmp/clock \
                            virtio_uml.device=/tmp/net:1 >/tmp/log1) &
wait
wait
wait
-------------


where test.sh contains
-------------
#!/bin/bash

start=$(date +%s)
ip link set eth0 up
ip addr add 10.0.0.1/24 dev eth0
ping -D -n -i 10 -c 61 10.0.0.2
end=$(date +%s)
duration=$(($end - $start))
min=$(($duration / 60))
sec=$(($duration % 60))
echo "================= runtime observed inside VM ${min}m ${sec}s ================="
poweroff -f
-------------

and test2.sh contains
-------------
#!/bin/sh

ip link set eth0 up
ip addr add 10.0.0.2/24 dev eth0
tcpdump -n -e -i eth0 &
sleep 660
poweroff -f
-------------

This then results in a network of two machines where one pings the other,
and the virtual network currently implements exactly 50ms delay.


There are some bugs in the userspace side, it doesn't handle nested requests
correctly and can lock up, that's why I have the different sleeps in there.
However, I'll need to pivot a bit and write integration to the simulation
that I really need this to work with, so I still wanted to get this out. I
may not fix those userspace bugs, but it's still a sample program for this.

johannes





_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


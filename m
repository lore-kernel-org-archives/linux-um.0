Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C09FM-0002oi-Uu for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Aug 2004 18:40:12 -0700
Received: from almesberger.net ([63.105.73.238] helo=host.almesberger.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C09FJ-0006lH-Ba for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Aug 2004 18:40:10 -0700
Received: from almesberger.net (vpnwa-home [10.200.0.2])
	by host.almesberger.net (8.11.6/8.9.3) with ESMTP id i7Q1e9R15879
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 25 Aug 2004 18:40:09 -0700
Received: (from werner@localhost)
	by almesberger.net (8.11.6/8.11.6) id i7Q1e0A14665
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Aug 2004 22:40:00 -0300
From: Werner Almesberger <wa@almesberger.net>
Message-ID: <20040825224000.A13578@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] linuxenv.bash (for <= uml-2.6.7-1)
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 25 Aug 2004 22:40:00 -0300
To: user-mode-linux-devel@lists.sourceforge.net

Here's a little script that I wrote for running experiments in a
UML kernel. The idea is that I want to get into the UML system
quickly, share my original environment, and run things from a
script (which may or may not eventually fire up a shell).

http://www.almesberger.net/misc/uml/linuxenv.bash

The script propagates the following things into the UML system:

 - the host's file system, through hostfs
 - all variables (including local ones) defined when invoking
   linuxenv.bash
 - the current directory in the host file system

An example script that just starts a shell would look like this:

#!/bin/sh
. linuxenv.bash "$@"
export PS1='\w\$ '
exec /bin/sh

http://www.almesberger.net/misc/uml/linuxsh

Note that linuxenv.bash may not work with kernels before 2.6.4,
and - due to the hostfs changes - doesn't work yet with
uml-2.6.7-2, or above.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cf8Se-00011A-NS for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Dec 2004 19:07:20 -0800
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Cf8Se-0004il-63 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Dec 2004 19:07:20 -0800
Message-ID: <000d01c4e3e5$a2ccc040$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
References: <000601c4e3cc$119a1280$0201a8c0@hawk>
	<200412170115.15731.blaisorblade_personal@yahoo.it>
	<001e01c4e3ce$c873fff0$0201a8c0@hawk>
	<200412170130.13717.blaisorblade_personal@yahoo.it>
Subject: Re: [uml-devel] unable to unmount tmpfs problem lives on
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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
Date: Thu, 16 Dec 2004 21:08:07 -0600
To: uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: Paolo Giarrusso <blaisorblade_personal@yahoo.it>

A little more info...

My method for causing the problem every time (example works under 2.6.9-ck3 and
2.6.10-rc2-bk7)

# mount tmpfs tmp/ -t tmpfs
# TMPDIR=./tmp/ /kernels/non-fix-kill-patched-kernel rootfs=debian.fs
# uml_mconsole .uml/xxx/mconsole cad
# kill -KILL <pid1> <pid2>
# umount tmp/
umount: /root/tmp: device is busy

(cad is set to shutdown in the UML's inittab.  After sending CAD, it hangs, which
requires kill)

Under 2.6.10-rc3-bk10 this works fine --the tmpfs mount is unmounted without
problems.  Perhaps it's fixed in recent patches. :)

-Chris



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

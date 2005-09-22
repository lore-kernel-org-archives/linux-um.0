Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EIO1J-0007D9-H4	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Sep 2005 03:09:37 -0700
Received: from mxfep02.bredband.com ([195.54.107.73])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EIO1H-000339-Sz
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Sep 2005 03:09:37 -0700
Received: from [192.168.0.206] ([85.226.145.207] [85.226.145.207])
          by mxfep02.bredband.com with ESMTP
          id <20050922100927.AFW11792.mxfep02.bredband.com@[192.168.0.206]>
          for <user-mode-linux-devel@lists.sourceforge.net>;
          Thu, 22 Sep 2005 12:09:27 +0200
From: Rickard =?ISO-8859-1?Q?Vikstr=F6m?= <rickard@azalea.se>
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <1127390899.7679.36.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [uml-devel] hangup
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
Date: Thu, 22 Sep 2005 14:08:19 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Hi uml-people

I have problem with hostkernel 2.6.12-skas3-v8.2 to start a guest.
This is the output:

./2.4.29  eth0=3Dtuntap,tap_bf,00:11:2F:87:09:02 ubd0=3Ddebian20gigg.iso
mem=3D512M

and the hangup is here:
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev

(I get nothing after "mounted...")

And in top I get 100% cpuusage for that guest-pid.

Can someone point me in the right direction.

And I also have problem with jdk 1.{4,5} on 2.4.X-guestkernels Is there
a known problem with 2.4.X + jdk 1.{4,5} ?

Best Regards
Rickard Vikstr=F6m







-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPoQJ-0004kl-38 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 May 2004 13:09:19 -0700
Received: from mail.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BPoQH-0001f6-Qe for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 May 2004 13:09:17 -0700
Message-ID: <030101c43c4b$cf6bd1a0$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] /dev/fd/62: No such file or directory
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
Date: Mon, 17 May 2004 22:16:16 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Hi !
I`m getting the following errors with uml 2.6.6 (2.6.4 had that, too) and suse9 rootfs during boot (see below).
can anybody give me a hint, what`s the problem, and how to (probably) fix this ?
networking basically works - but i have to setup the defaultroute manually afterwards and soooo many errors during boot really don`t
give a good "feeling" :)

regards
roland


Master Resource Control: previous runlevel: N, switching to runlevel: 3
Setting up network interfaces:
    lo        /sbin/ifup: line 119: /dev/fd/62: No such file or directory
/sbin/ifup: line 540: /dev/fd/62: No such file or directory
/sbin/ifup: line 1: /dev/fd/62: No such file or directory
/sbin/ifup: line 1: /dev/fd/61: No such file or directory
/sbin/ifup: line 171: /dev/fd/62: No such file or directory
/etc/sysconfig/network/scripts/ifup-route: line 1: /dev/fd/62: No such file or directory
/etc/sysconfig/network/scripts/ifup-route: line 433: /dev/fd/62: No such file or directory
done
    eth0      /etc/sysconfig/network/scripts/ifup-route: line 1: /dev/fd/61: No such file or directory
/sbin/ifup: line 119: /dev/fd/62: No such file or directory
/sbin/ifup: line 540: /dev/fd/62: No such file or directory
/sbin/ifup: line 171: /dev/fd/62: No such file or directory
/sbin/ifup: line 1: /dev/fd/62: No such file or directory
/sbin/ifup: line 1: /dev/fd/61: No such file or directory
IP/Netmask: 100.1.7.247 / 255.255.252.0
/etc/sysconfig/network/scripts/ifup-route: line 1: /dev/fd/62: No such file or directory
/etc/sysconfig/network/scripts/ifup-route: line 433: /dev/fd/62: No such file or directory
done
/etc/sysconfig/network/scripts/ifup-route: line 1: /dev/fd/61: No such file or directory
/etc/sysconfig/network/scripts/ifup-route: line 433: /dev/fd/62: No such file or directory
/etc/sysconfig/network/scripts/ifup-route: line 1: /dev/fd/61: No such file or directory
/etc/sysconfig/network/scripts/ifup-route: line 1: /dev/fd/62: No such file or directory



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

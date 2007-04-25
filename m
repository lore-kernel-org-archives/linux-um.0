Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HgooH-0000JN-G4 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 14:13:57 -0700
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HgooH-0004ZX-2g
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 14:13:57 -0700
Message-ID: <462FC142.1010907@nagafix.co.uk>
Date: Wed, 25 Apr 2007 21:59:46 +0100
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
References: <462BACC9.7010303@nagafix.co.uk>
	<20070425204849.GA9505@c2.user-mode-linux.org>
In-Reply-To: <20070425204849.GA9505@c2.user-mode-linux.org>
Subject: Re: [uml-devel] regression: pcap broken in 2.6.20.x
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Jeff Dike wrote:
> On Sun, Apr 22, 2007 at 07:43:21PM +0100, Antoine Martin wrote:
>> Using the exact same kernel config with 2.6.19.x works but not with 2.6.20.x
>>
>> # ifconfig eth1 0.0.0.0 promisc up
>> SIOCSIFADDR: No such device
>> eth1: unknown interface: No such device
>> eth1: unknown interface: No such device
>> eth1: unknown interface: No such device
> 
> Works here - what do ifconfig -a and dmesg say?
Ah, DOH!
Could it be that the randomization of the mac address made it appear as
eth4 and not eth1... (why eth4 and not eth3 or eth2, beats me)
Until now all kernels made it appear as eth1.

Is there any chance of adding the ability to set the mac address of the
interface as is currently the case for tuntap?
ie: eth1=pcap,00:00:00:01:02:03,eth0[,filters]

Thanks
Antoine
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGL8FCGK2zHPGK1rsRCgNaAJ4gS5hW4Fg3+cd9L17TkooKKD9N4QCfS+Fs
P0uU130bSLX81MjbNAL/RdI=
=jOcH
-----END PGP SIGNATURE-----

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

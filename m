Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C459C-000410-Ht for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 05 Sep 2004 15:06:06 -0700
Received: from tharec.debianbase.de ([212.79.163.254] helo=mail2.debianbase.de)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C459B-0004C5-Rs for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 05 Sep 2004 15:06:06 -0700
Received: from mail.debianbase.de (tha.vpn.local [192.168.100.1])
	by mail2.debianbase.de (Postfix) with ESMTP id AFC6C9BB9
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon,  6 Sep 2004 00:05:55 +0200 (CEST)
Received: from vaiobook.tha.local (vaiobook.tha.local [10.0.0.9])
	by mail.tha.local (Postfix) with ESMTP id 3E088162CCB
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon,  6 Sep 2004 00:06:05 +0200 (CEST)
From: Ralph =?iso-8859-1?q?Pa=DFgang?= <ralph@debianbase.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409060005.54577.ralph@debianbase.de>
Subject: [uml-devel] uml modules broken in 2.6.8 (has something to do with
	memmove)
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
Date: Mon, 6 Sep 2004 00:05:54 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Hi all,

I am using user-mode-linux 2.6.6 and 2.6.7 for some time without any big 
problems. I now tried to build a 2.6.8 debian package for my (and some other) 
systems and I got problems with some modules now... I used the same script 
for packaging the uml kernel and changed only the new option in the ".config" 
file. So that should not be the problem, I guess.

First some version details:
host system: 2.6.8 (debian source) with skas3, sysemu and reiser4 patch
uml guest system: 2.6.8 (debian source) with 2.6.8.1-1 patch, sysemu patch and 
reiser4 patch

The problems I see while booting my uml are:

...
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (464 buckets, 3712 max) - 296 bytes per conntrack
iptable_nat: Unknown symbol memmove
...

If I then use: depmod -a to fix the problem it actually gets worse...

after a reboot I get this error for even more modules, because of the unknown 
symbol memmove:

...
iptable_nat: Unknown symbol memmove
ipt_MASQUERADE: Unknown symbol ip_nat_setup_info
iptable_nat: Unknown symbol memmove
slhc: Unknown symbol memmove
...

I also noticed that 2.6.6 (for example, I guess 2.6.7 is equal to 2.6.6) 
hasn't got the word "memmove" anywhere in the modules. But in the 2.6.8 
modules the string "memmove" appears quite often:

#:/lib/modules# ls ; grep memmove * -R
total 1
drwxr-xr-x  3 root root 496 Sep  5 14:20 2.6.6-1um
drwxr-xr-x  3 root root 496 Sep  5 23:51 2.6.8-1um

Binary file 2.6.8-1um/kernel/fs/udf/udf.ko matches
Binary file 2.6.8-1um/kernel/fs/hpfs/hpfs.ko matches
Binary file 2.6.8-1um/kernel/fs/nfsd/nfsd.ko matches
Binary file 2.6.8-1um/kernel/fs/ncpfs/ncpfs.ko matches
Binary file 2.6.8-1um/kernel/fs/hostfs/humfs.ko matches
Binary file 2.6.8-1um/kernel/fs/hostfs/externfs.ko matches
Binary file 2.6.8-1um/kernel/fs/hfsplus/hfsplus.ko matches
Binary file 2.6.8-1um/kernel/net/ipv4/ipvs/ip_vs.ko matches
Binary file 2.6.8-1um/kernel/net/ipv4/netfilter/ipfwadm.ko matches
Binary file 2.6.8-1um/kernel/net/ipv4/netfilter/ipchains.ko matches
Binary file 2.6.8-1um/kernel/net/ipv4/netfilter/ipt_TCPMSS.ko matches
Binary file 2.6.8-1um/kernel/net/ipv4/netfilter/iptable_nat.ko matches
Binary file 2.6.8-1um/kernel/net/ipv6/ah6.ko matches
Binary file 2.6.8-1um/kernel/net/8021q/8021q.ko matches
Binary file 2.6.8-1um/kernel/drivers/net/slhc.ko matches
Binary file 2.6.8-1um/kernel/drivers/net/bonding/bonding.ko matches
Binary file 2.6.8-1um/kernel/drivers/scsi/st.ko matches

Is it possible that the i386 and the um code is out-of-sync?

I am not a kernel hacker, but I found with google that something changed with 
memmove in 2.6.8, but I don't know enough of the kernel stuff to know what it 
means:

http://kerneltrap.org/node/view/3443 -> search for memmove and you find: 
"i386: uninline memmove"

Has nobody besides me this problem? I can't use my uml without nat, so I 
downgraded again to 2.6.6...

--Ralph


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

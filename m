Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hh0BC-0000Oj-Ve for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Apr 2007 02:22:23 -0700
Received: from mx03.lb01.inode.at ([62.99.145.3] helo=mx.inode.at)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Hh0BC-0008Mj-2J
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Apr 2007 02:22:22 -0700
Received: from [85.124.82.131] (port=16148 helo=austrobit.com)
	by smartmx-03.inode.at with esmtps (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50) id 1Hh0B2-0003qc-HI
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Apr 2007 11:22:12 +0200
Received: from xaustrobit (xaustrobit [192.168.1.102])
	by austrobit.com (Postfix) with ESMTP id 2786411423
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 26 Apr 2007 11:22:09 +0200 (CEST)
From: Herbert Volkmann <sysadmin@austrobit.com>
Date: Thu, 26 Apr 2007 11:22:08 +0200
Message-Id: <1177579328.5349.10.camel@xaustrobit>
Mime-Version: 1.0
Subject: [uml-devel] uml crashes when producing large files
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
To: user-mode-linux-devel@lists.sourceforge.net

Hi List,

i ran in the following problem:
when i produce files (with dd) or copy files to or from the uml machine,
i can see (with top), that the used memory and the cached things
increases, while the unused memory will go down. shortly before memory
will come to zero, the uml stops working completely without any messages
in the /var/log/* files on uml or host system.

if i do in between a "echo 3 > /proc/sys/vm/drop_caches"

it cleans caches, frees memory and works fine! but i have to do this all
10 seconds when i use dd for producing large files ;-(

these are the components i use:
- debian etch on host with debian kernel patched with skas3 from debian 
- 1024 MB RAM on host
- RAID5 System with 3ware Controller (5x2G) almost 1 TB
- on uml i use debian etch, with bridged networking, 512MB RAM for uml
- 6G root_fs for uml and 256M swap

here is the command with which i start the uml:
sudo -u uml /usr/bin/linux.uml umid=uml mem=512M eth0=tuntap,tap1
ubd0=/usr/media/uml-linux/root_fs_2007_04_23
ubd1=/usr/media/uml-linux/swap_fs con=null root=/dev/ubda uml_dir=/tmp/

I would be really happy if someone could tell me what i can test more to
find out why this system is instable with i/o operations and caches.

thanx for any reply,
Herbert


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IPedN-0001nr-Pj for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 27 Aug 2007 06:28:10 -0700
Received: from mail.gmx.net ([213.165.64.20])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1IPedK-0007Rl-JH
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 27 Aug 2007 06:28:01 -0700
Message-ID: <46D2D0E2.9060408@gmx.net>
Date: Mon, 27 Aug 2007 15:25:54 +0200
From: Michael Kerrisk <mtk-manpages@gmx.net>
MIME-Version: 1.0
References: <20070814092942.GA14324@clipper.ens.fr>
In-Reply-To: <20070814092942.GA14324@clipper.ens.fr>
Subject: Re: [uml-devel] UML/man: BLKGETSIZE takes a long, not an int
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Nicolas George <nicolas.george@ens.fr>
Cc: jdike@linux.intel.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Hello Nicolas,

> I fear that my bug-report yesterday was very badly written, with me writing
> to the wrong mailing-list and all.
> 
> I was saying:
> 
>> I found a type mismatch in UML that makes host block devices unusable as ubd
>> devices on x86_64 and other 64 bits systems (segfault of the mm subsystem):
>>
>> In block/ioctl.c, the following lines show that the BLKGETSIZE ioctl expects
>> a pointer to a long:
>>
>> 	case BLKGETSIZE:
>> 		if ((bdev->bd_inode->i_size >> 9) > ~0UL)
>> 			return -EFBIG;
>> 		return put_ulong(arg, bdev->bd_inode->i_size >> 9);
>>
>> In arch/um/os-Linux/file.c, os_file_size calls it with an int.
>>
>> The ioctl_list man page should be fixed as well.

manual page changed for 2.65:

--- ioctl_list.2
+++ ioctl_list.2        (working copy)
@@ -243,7 +243,7 @@
 0x0000125D  BLKROSET                   const int *
 0x0000125E  BLKROGET                   int *
 0x0000125F  BLKRRPART                  void
-0x00001260  BLKGETSIZE                 int *
+0x00001260  BLKGETSIZE                 unsigned long *
 0x00001261  BLKFLSBUF                  void
 0x00001262  BLKRASET                   int
 0x00001263  BLKRAGET                   int *

Thanks,

Michael

-- 
Michael Kerrisk
maintainer of Linux man pages Sections 2, 3, 4, 5, and 7

Want to help with man page maintenance?  Grab the latest tarball at
http://www.kernel.org/pub/linux/docs/manpages/
read the HOWTOHELP file and grep the source files for 'FIXME'.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

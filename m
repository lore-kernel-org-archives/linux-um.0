Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HCBba-0003Gg-DL for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 31 Jan 2007 01:18:14 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HCBbX-0007Y6-VT
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 31 Jan 2007 01:18:14 -0800
Message-ID: <45C05ECB.9010209@nagafix.co.uk>
Date: Wed, 31 Jan 2007 09:18:03 +0000
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
References: <45BF901F.40206@nagafix.co.uk>
	<20070130214252.GA7947@ccure.user-mode-linux.org>
In-Reply-To: <20070130214252.GA7947@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] do_syscall_stub: syscall 9 failed
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
Cc: user-mode-linux-devel@lists.sourceforge.net

Jeff Dike wrote:
> On Tue, Jan 30, 2007 at 06:36:15PM +0000, Antoine Martin wrote:
>> Just caught this in `dmesg`
>>
>> [42977596.520000] Adding 131064k swap on /dev/ubdb.  Priority:-1 
>> extents:1 across:131064k
>> [42980169.290000] do_syscall_stub : ret = -12, offset = 548682067984, 
>> data = 0000000060b16010
>> [42980169.290000] do_syscall_stub: syscall 9 failed, return value = 
>> 0xfffffffffffffff4, expected return value = 0x477a000
>> [42980169.290000]     syscall parameters: 0x477a000 0x1000 0x7 0x11 0x3 
>> 0xad0c000
>> [42980169.290000] fix_range_common: failed, killing current process
>>
>> Whilst trying to compile gcc (big beast) on a 64-bit UML instance.
>> Earlier it had failed and triggered OOM, which is why I added the swap, 
>> now it may still not have enough (compilation crashed in a similar 
>> manner) but this time there is no OOM message.
>>
>> Any ideas what this is?
> 
> Sounds like it might be the host /proc/sys/vm/max_map_count being
> exceeded, which will happen with a UML process with 256M RSS.
Indeed it was (never heard of it before)

Thanks!
Antoine

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

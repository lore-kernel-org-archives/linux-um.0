Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CRtgr-0001Mk-Jn for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Nov 2004 06:43:17 -0800
Received: from mailgate2.uni-paderborn.de ([131.234.22.35])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CRtgq-00040L-QU
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Nov 2004 06:43:17 -0800
Message-ID: <41922945.2090805@upb.de>
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
MIME-Version: 1.0
Subject: Re: [uml-devel] Re: Stop at startup on 2.6 NPTL hosts
References: <20041029092641.8558.qmail@web26102.mail.ukl.yahoo.com>
	<200411021952.09095.blaisorblade_spam@yahoo.it>
	<4190F385.1000802@fujitsu-siemens.com>
	<200411092012.05383.blaisorblade_spam@yahoo.it>
	<34658.80.203.1.124.1100075791.squirrel@80.203.1.124>
	<Pine.GSO.4.61.0411101005310.17015@waterleaf.sonytel.be>
	<41920646.3090802@fujitsu-siemens.com>
In-Reply-To: <41920646.3090802@fujitsu-siemens.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Wed, 10 Nov 2004 15:44:21 +0100
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, stian@nixia.no, Blaisorblade <blaisorblade_spam@yahoo.it>, User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>, Jeff Dike <jdike@addtoit.com>, Roland Kaeser <roli8200@yahoo.de>, Nuno Silva <nuno.silva@vgertech.com>, Antoine Martin <antoine@nagafix.co.uk>, Dennis Muhlestein <devel@muhlesteins.com>

>> If you want to be 100% sure you use a syscall, why not call the syscall
>> directly?
> 
> OK. It's an API call. But what's this API call defined to return? Isn't 
> it the
> pid of the process calling? If it is, the behavior of the lib is a bug. 
> If it
> isn't, the descriptions are wrong. Do you agree?

This glibc-Bug has been discussed on the LKML already. Linus was 
somewhat angry about it, since glibc should not cache. He said that this 
caching-stuff may be, because somewhat wanted to tune glibc for some 
synthetic benchmark that uses getpid() as a speed measurement. He also 
recommed to get rid of that cache - at least as far as i read the 
discussion.

So the conclusion is: override getpid() with something that does not 
cache anything since there are buggy glibc's out there, or use our own 
cache for the PID if syscalls cause to much overhead.

Thx
  Sven


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

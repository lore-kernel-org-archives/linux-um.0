Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5d07-0004wJ-Gc for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Sep 2004 21:27:07 -0700
Received: from mailgate.uni-paderborn.de ([131.234.22.32])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1C5d05-0005f4-Ax
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Sep 2004 21:27:06 -0700
Message-ID: <41411B7B.5060300@upb.de>
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
MIME-Version: 1.0
Subject: Re: [uml-devel] UML hanging while deactivating swap
References: <chao0q$ajs$1@sea.gmane.org>
	<200409100356.i8A3uQg1005723@ccure.user-mode-linux.org>
In-Reply-To: <200409100356.i8A3uQg1005723@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Fri, 10 Sep 2004 05:11:55 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

>>ubd1 of my UML is a swapfs, and when halting or rebooting it, it hangs
>> while the swap is deactivated (i guess swapoff -a is executed). 
> 
> Can you narrow it down within the shutdown process?  Adding -x to the #!
> lines of the relevant scripts is a good way to do this.

the relevant lines of the init script are

if [ -n "`swapon -s 2>/dev/null`" ]
then
         ebegin "Deactivating swap"
         swapoff -a &>/dev/null
         eend $?
fi

so it _must_ be the "swapoff -a" since i see the "Deactivating swap" 
message, but not the "OK" that eend would generate.

> Also, can you get a stack trace from UML?

I don't know how to do that, sorry :-(. I have never worked with gdb and 
suchlike, but i'd really like to help to track the error down somehow.

The UML seems to be still running, since it takes CPU-time on the host, 
but the swapoff seems to never return.

It also hard for me to reproduce this, but i think it only happens when 
swap is used. If i try to reproduce it by running some programs that use 
much memory and therefor things get swapped, the UML halts without 
problems. Other UMLs that ran for months and have about 1MB swap used 
hang while the swap gets deactivated.




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

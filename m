Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I9dqi-0007Gb-Ig for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 14 Jul 2007 02:23:36 -0700
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I9dqh-0004G3-56
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 14 Jul 2007 02:23:36 -0700
Message-ID: <4698960D.8070100@nagafix.co.uk>
Date: Sat, 14 Jul 2007 10:23:25 +0100
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
References: <46975CD0.5020709@nagafix.co.uk> <46976A09.9070906@nagafix.co.uk>
	<20070713155723.GA7468@c2.user-mode-linux.org>
	<4697B944.6030203@nagafix.co.uk>
	<20070713184441.GB9472@c2.user-mode-linux.org>
In-Reply-To: <20070713184441.GB9472@c2.user-mode-linux.org>
Subject: Re: [uml-devel] ARCH=um SUBARCH=i386 breakage?
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
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net


>> My kernel headers are also missing elf.h, so this doesn't work either...
>>     
>
> elf.h is supposedly exported in 2.6.22, although I guess someone took the
> comment seriously:
>
> 	# These probably shouldn't be exported
> 	unifdef-y += shmparam.h
> 	unifdef-y += elf.h
> 	unifdef-y += page.h
>
> So, I have no idea how userspace is supposed to figure out how big a
> buffer to pass to PTRACE_GETFPREGS and PTRACE_GETFPXREGS.  I think the
> headers are broken here.
>
>   
>> It is included in page.h:
>>
>>  CC      arch/um/sys-i386/user-offsets.s
>> In file included from /usr/include/asm/user.h:5,
>>                 from arch/um/sys-i386/user-offsets.c:7:
>> /usr/include/asm/page.h:4:25: error: linux/const.h: No such file or 
>> directory
>>     
>
> This is just broken, then.  The headers should at least have no
> dangling includes.
>   
page.h wasn't there to start with, I added it by hand - so it isn't as 
bad, but building without page.h looks hard...
>   
>> I get the same error as above because user.h includes  asm/page.h
>>     
>
> Hummm, I guess the header tidying people need to fix a bunch of
> things.  I'll make whatever changes needed in UML to not use illicit
> headers, but I do need complete interface definitions, as with the FP
> stuff.
>   
I don't mind bugging people to get to the bottom of this, do you know 
where to knock?
I can't find anything in MAINTAINERS.

Antoine

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

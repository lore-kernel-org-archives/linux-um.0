Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IBc4z-0000IA-Ub for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 19 Jul 2007 12:54:30 -0700
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IBc4y-0000lb-Gl
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 19 Jul 2007 12:54:29 -0700
Message-ID: <469FC166.6050209@nagafix.co.uk>
Date: Thu, 19 Jul 2007 20:54:14 +0100
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
References: <46975CD0.5020709@nagafix.co.uk>	 <46976A09.9070906@nagafix.co.uk>	
	<20070713155723.GA7468@c2.user-mode-linux.org>	
	<4697B944.6030203@nagafix.co.uk>	
	<20070713184441.GB9472@c2.user-mode-linux.org>	
	<4698960D.8070100@nagafix.co.uk>	
	<20070714120029.GA4421@c2.user-mode-linux.org>	
	<469A54A5.2010102@nagafix.co.uk>
	<1184807588.7782.1.camel@athena.fprintf.net>
In-Reply-To: <1184807588.7782.1.camel@athena.fprintf.net>
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
To: Daniel Gryniewicz <dang@gentoo.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

Daniel Gryniewicz wrote:
> On Sun, 2007-07-15 at 18:08 +0100, Antoine Martin wrote:
>   
>> Jeff Dike wrote:
>>     
>>> On Sat, Jul 14, 2007 at 10:23:25AM +0100, Antoine Martin wrote:
>>>   
>>>       
>>>> I don't mind bugging people to get to the bottom of this, do you know 
>>>> where to knock?
>>>> I can't find anything in MAINTAINERS.
>>>>     
>>>>         
>>> Did you install the headers directly from a kernel tree, or is this
>>> the result of a distro upgrade?
>>>   
>>>       
>> These are the Gentoo packages which are very close to mainline and I 
>> can't find the upstream location for the headers so I guess I will be 
>> filing a bug with Gentoo... We'll see where that leads.
>>
>>     
>
> Actually, the Gentoo headers are not particularly close to the kernel
> headers. 
My mistake.
>  They are heavily "sanitized", meaning that all kinds of things
> that userspace is "not supposed to use" are removed. 
So in a sense, Gentoo kernel headers are ahead of the game. Which means 
that these changes are likely to become an issue not just for Gentoo 
users in the future.

>  This makes it very
> hard for things like UML, that are heavily tied to the kernel, to build.
>   
As Jeff pointed out, this is part of the userspace api:
"the elimination of user.h makes it impossible to use 
PTRACE_SETFP[X]REGS, as there is no way to tell what size buffer should 
be passed in."

Can you suggest a way to code around this issue or is this going to require an update to the Gentoo kernel headers?
Let me know if I can help.

Thanks
Antoine


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

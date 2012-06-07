Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <bharrosh@panasas.com>) id 1ScZkF-0004p6-BP
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jun 2012 10:15:11 +0000
Received: from natasha.panasas.com ([67.152.220.90])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ScZk9-0004oM-U4 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jun 2012 10:15:11 +0000
Message-ID: <4FD07F14.50902@panasas.com>
Date: Thu, 7 Jun 2012 13:14:44 +0300
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
References: <1338841657-30358-1-git-send-email-richard@nod.at>
	<4FCF6748.6020005@panasas.com> <4FD059AC.8050808@panasas.com>
	<4FD06A22.6040002@nod.at>
In-Reply-To: <4FD06A22.6040002@nod.at>
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] um: TTY fixes (?)
To: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, jslaby@suse.cz, alan@linux.intel.com

On 06/07/2012 12:22 PM, Alan Cox wrote:
> On 06/07/2012 11:45 AM, Richard Weinberger wrote:

>> 
>> We cannot push this patch to Linus or -stable.
>> The problem is that will break other things.
>> E.g. login on non-tty0 terminals will break if the distro uses
>> util-linux's login.
>> 


I don't understand. Current code does not work at all even for
tty0. as well as ttyX. Since 3-4 Kernels ago. I've been running with
your patch for a long time.

I really don't get it. You have not broken anything new. Only
not fixed all of the problems. Current code does not work for "non-tty0
terminals" as well right?

<>
>> Breaking existing applications is a no-go, sorry.

> Being insecure should also be a no-no.

> 
> Not sure what Jiri thinks but for the moment I think we need to push it
> with a module option as to whether hangup on console is enabled or not.
> 
> I don't want to just break the existing user space, but leaving other
> vendors systems insecure just to cover Fedora's backside is also not
> entirely fair either.

I don't see Alan's comment at all. This is not a regression it was always
like that. Ever since Fedora was working on UML, But these fixes are real
live regression crashes.

And I don't see the all "leaving other vendors systems insecure". It just
a freaking UML tty. You need to be root 5 times before you have access
to all these, and it's only the UML that's compromised not the "all system"
And surely the current plain tty0 crash is much less secure then this thing.

> Thanks,
> //richard
> 


Please let us work, I don't see the point of leaving something terminally
broken, ever.

Thanks
Boaz

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


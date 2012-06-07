Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <bharrosh@panasas.com>) id 1Sca44-0005UP-O9
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jun 2012 10:35:40 +0000
Received: from natasha.panasas.com ([67.152.220.90])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Sca3z-0005So-Gb for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jun 2012 10:35:40 +0000
Message-ID: <4FD083E3.5080900@panasas.com>
Date: Thu, 7 Jun 2012 13:35:15 +0300
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
References: <1338841657-30358-1-git-send-email-richard@nod.at>
	<4FCF6748.6020005@panasas.com> <4FD059AC.8050808@panasas.com>
	<4FD06A22.6040002@nod.at> <4FD07F14.50902@panasas.com>
	<4FD0802A.1020203@nod.at>
In-Reply-To: <4FD0802A.1020203@nod.at>
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

On 06/07/2012 01:19 PM, Richard Weinberger wrote:

> 
> No, it works fine.
> 


OK Sorry I missed that part. So you are saying that these patches
fix Fedora, but completely break other systems which now work?

I saw in your cover letter that Debian was fine with or without
->hangup() so I assumed all other system are more like Debian.

>> I don't see Alan's comment at all. This is not a regression it was always
>> like that. Ever since Fedora was working on UML, But these fixes are real
>> live regression crashes.
>>
>> And I don't see the all "leaving other vendors systems insecure". It just
>> a freaking UML tty. You need to be root 5 times before you have access
>> to all these, and it's only the UML that's compromised not the "all system"
>> And surely the current plain tty0 crash is much less secure then this thing.
> 
> The "TTY problem" is not UML specific.
> 


Exactly my point, so it is not anything your UM-only patches can do anything
about it. right?

> Thanks,
> //richard
> 


I guess I will have to carry these longer. Can I fix my FC12 and FC15 so they
don't crash with mainline?

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


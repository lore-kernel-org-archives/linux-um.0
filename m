Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <bharrosh@panasas.com>) id 1ScXFk-00033B-8M
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jun 2012 07:35:32 +0000
Received: from natasha.panasas.com ([67.152.220.90])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ScXFj-00023H-FQ for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jun 2012 07:35:32 +0000
Message-ID: <4FD059AC.8050808@panasas.com>
Date: Thu, 7 Jun 2012 10:35:08 +0300
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
References: <1338841657-30358-1-git-send-email-richard@nod.at>
	<4FCF6748.6020005@panasas.com>
In-Reply-To: <4FCF6748.6020005@panasas.com>
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

On 06/06/2012 05:20 PM, Boaz Harrosh wrote:

> On 06/04/2012 11:27 PM, Richard Weinberger wrote:
> 
<>

> 

> 
> Horray I'm back to my old self. Thanks I'll give it a run
> and report of any new problems
> 
> Thanks a million Richard
> Boaz
> 


OK I've run with these for a few days and they are doing
the Job perfectly. Not a single problem.

You may add tested-by: Boaz Harrosh <bharrosh@panasas.com>
on all patches if you'd like.

Please push them ASAP to Linus. They fix a real life breakage
that's there since v3.3. At least now we are back to
the problems that where there for a long time.

Please also CC: Stable Tree <stable@kernel.org> for 3.4
as clearly 3.4 is unusable at all right now.

I wish they would be sent to older stables as well, but
they won't patch, so it's not worth the effort.

>> 	mingetty is unable to start on anything else than tty0.
>> 	It exits after a few seconds.


I suspect this was always so since forever. I don't even know
how to configure such a thing. I know that the console I run
vmlinux from becomes tty0, until I halt (or crash). How do
you open more tty(s) and attach them to console windows?
I just use ssh for that.

(The setup of tty(s) for UML on Fedora is always such a pain
 and it changed 4 times since FC10, I always have to mount
 the image, figure out how to make tty1 a tty0, and delete
 all the other tty(s). perhaps I'm just clueless. Is there an
 easier way? Is there a way to tell UML to make tty0 be a tty1?
 Because in fedora tty0 is not defined.)

But please do not delay these patches because of old problems.
These can be solved later.

Thanks very much for fixing this, it's a life saver
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


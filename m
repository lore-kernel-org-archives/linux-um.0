Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CXK8t-0001hv-ND for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 25 Nov 2004 05:58:39 -0800
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CXK8s-0003O9-PZ for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 25 Nov 2004 05:58:39 -0800
Message-ID: <41A5E50A.1080804@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
References: <200411250456.33779.blaisorblade_spam@yahoo.it>
	<41A5C5A9.7040902@fujitsu-siemens.com>
	<200411251349.54865.blaisorblade_spam@yahoo.it>
In-Reply-To: <200411251349.54865.blaisorblade_spam@yahoo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: Fwd: [PATCH] UML - close host file descriptors
	properly
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
Date: Thu, 25 Nov 2004 14:58:34 +0100
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

Blaisorblade wrote:
> On Thursday 25 November 2004 12:44, Bodo Stroesser wrote:
> 
>>Blaisorblade wrote:
>>
>>>This patch was sent by Jeff for merging in mainline - since you
>>>complained on an earlier version, have you still something to correct in
>>>it?
> 
> 
>>AFAICS, it's the same patch as you have in bb3 with the name
>>"uml-close-all-fds". So, it's OK. To have reboot on SKAS working,
>>fix-reboot-skas is required also.
> 
> Yes, that is in -bb3.
> 
>>>Btw, the reboot problem is not fixed for me - even in -bb3, with your
>>>last patch tarball excluding SYSEMU_SINGLESTEP, rebooting does not always
>>>work.
> 
> 
>>That's bad. On my system, since the patches are applied, I never saw a
>>reboot failing.
> 
> I got the same randomical failure before. And what's more, with the use-va_end 
> cleanup, it *always* crashed (not retested, but going to do this now).
> 
> Without va_end, sometimes (1 on 3 on average, I'd say) I get:
> 
> "Remounting root filesystem read-only.
> Rebooting.
> Restarting system.
> 
> deactivate_all_fds failed, errno = 9
> Segmentation fault"
OK. Let's read the code: if deactivate_all_fds fails, the handler for SIGIO isn't
set to SIG_IGN, since it does return(err) without calling set_handler() (maybe
you call this a bug, but *normally* deactivate_all_fds must not fail). Thus, if
there is a SIGIO in the queue, UML *must* segfault when calling unblock_signals().

The question here is, which fd is in the list active_fds and is invalid?
Could you please change the error output to contain the fd-number?
And before doing the reboot, please get a list of the open fds. This could help to
find out, which driver is having a bug.
> 
> 
>>I have an idea to find out, what happens on your machine.
> 
> Ok, going to test ASAP.
> 
>>First let me 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

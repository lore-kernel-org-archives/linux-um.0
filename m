Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CL26p-0002YF-4M for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Oct 2004 09:17:43 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CL26o-000774-Ad for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Oct 2004 09:17:43 -0700
Message-ID: <41793409.70001@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Re: [patch 1/1] SYSEMU: avoid intercepting syscall
	on return when using SYSCALL again.
References: <20041021231834.9D3833F37@zion.localdomain>
	<4178D172.7020406@fujitsu-siemens.com>
	<200410221814.45917.blaisorblade_spam@yahoo.it>
In-Reply-To: <200410221814.45917.blaisorblade_spam@yahoo.it>
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
Date: Fri, 22 Oct 2004 18:23:37 +0200
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, jdike@addtoit.com

BlaisorBlade wrote:
> On Friday 22 October 2004 11:22, Bodo Stroesser wrote:
> 
>>blaisorblade_spam@yahoo.it wrote:
>>
>>>From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
>>>
>>>A guest process switching from using PTRACE_SYSEMU to PTRACE_SYSCALL
>>>crashes.
>>>
>>>The problem is in arch/i386/kernel/entry.S. The current SYSEMU patch
>>>inhibits the syscall-handler to be called, but does not prevent
>>>do_syscall_trace to be called after this for syscall completion
>>>interception.
>>>
>>>The appended patch fixes this. It reuses the flag TIF_SYSCALL_EMU to
>>>remember "we come from PTRACE_SYSEMU and now are in PTRACE_SYSCALL",
>>>since the flag is unused in the depicted situation.
>>>
>>>The patch is tested, AFAICS, it works fine, i.e. sysemu can be switched
>>>on and off dynamically without crash.
>>>
>>>Bodo
>>>
>>>Signed-off-by: Paolo 'Blaisorblade' Giarrusso
>>><blaisorblade_spam@yahoo.it> ---
>>
>>Fine idea to move one part of the patch to sys_ptrace()!
>>But maybe you missed to reset TIF_SYSCALL_EMU while resuming with
>>PTRACE_CONT? Here is a revised patch.
> 
> Yes - I forgot it. Does the revised version work? My version did not - it 
> failed the startup test. In fact, PTRACE_CONT is called in the startup test 
> (which fails). I'm recompiling and testing.
Yes. My system works very fine with it.

Regards
> 
> Thanks again.



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

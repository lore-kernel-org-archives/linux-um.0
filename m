Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNJpS-0006Sv-Ap for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Oct 2004 16:37:14 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CNJpP-000524-Ka for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Oct 2004 16:37:14 -0700
Message-ID: <41818295.5000209@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Re: [patch 1/1] SYSEMU: avoid intercepting syscall
	on return when using SYSCALL again.
References: <20041021231834.9D3833F37@zion.localdomain>
	<41793409.70001@fujitsu-siemens.com>
	<417FAEFD.8070805@fujitsu-siemens.com>
	<200410290104.22725.blaisorblade_spam@yahoo.it>
In-Reply-To: <200410290104.22725.blaisorblade_spam@yahoo.it>
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
Date: Fri, 29 Oct 2004 01:36:53 +0200
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, jdike@addtoit.com

Blaisorblade wrote:
> On Wednesday 27 October 2004 16:21, Bodo Stroesser wrote:
> 
>>Bodo Stroesser wrote:
>>
>>>BlaisorBlade wrote:
>>>
>>>>Yes - I forgot it. Does the revised version work? My version did not -
>>>>it failed the startup test. In fact, PTRACE_CONT is called in the
>>>>startup test (which fails). I'm recompiling and testing.
> 
> 
>>>Yes. My system works very fine with it.
> No, simply UML should use PTRACE_KILL rather than sending SIGKILL itself. It 
> always just *happened* to work.
But why can't the host's filesystem be unmounted ("Is in use"), even if
the UML-Processes were killed?

> 
> I was just about to release -v7 - I'll hold on it a bit more to include your 
> fix. Then I'll do releases for 2.6.7 and 2.6.9.
Year. But in November we hhave to talk again! Sysemu is still dangerous.
If SKAS will support SMP, no one can guarantee, that the code of a UML-process
isn't modified between "is_syscall()" and ptrace(PTRACE_SINGLESTEP, ...).
What we really need is an option for PTRACE_SYSEMU, that lets it stop
for Singlestep AND syscall-trace. Example:
	ptrace( PTRACE_SYSEMU, pid, (void *)PTRACE_SINGLESTEP, 0)
Then no more opcode-reading / checking will be needed.
> 
> I have idea we need something more robust, i.e. a return path avoiding 
> altogether the 2nd do_syscall_trace call, like it happened in 2.4.
Think, the current solution is robust. But let me know, if you find a
way to knock it out.
> 
> Now, My Mighty Bodo, after cleaning up the issues about collecting your 
> patches, could you try to understand also why strace does not work with 
> SYSEMU on? Even switching SYSEMU off through /proc/sysemu avoids that. It 
> seems to be a guest-only problem, since the UML debugger code seems totally 
> unrelated to the syscall interception on the host.
> 
> Also, something strange is that when not enabling network support, strace 
> printed out some network syscalls, with bogus return values, even with SYSEMU 
> active.
Do you talk about strace'ing the kernel?
Or do you talk about the debugger problem, Lorenzo has?

For his problem, I have an idea: writing my tests for Jeff, I saw SIGCHLD being
masked by default! No SIGCHLD, no debugging ?!

Regards
Bodo


-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CTmA1-0004P8-B6 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Nov 2004 11:05:09 -0800
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CTm9x-0000RK-Nm for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Nov 2004 11:05:09 -0800
Message-ID: <4198FDD7.4090804@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] [Patch 1/1] uml: fix uml-use-sysemu-for-tt.patch
References: <4194C43D.6030107@fujitsu-siemens.com>
	<200411130854.51896.blaisorblade_spam@yahoo.it>
In-Reply-To: <200411130854.51896.blaisorblade_spam@yahoo.it>
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
Date: Mon, 15 Nov 2004 20:04:55 +0100
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

Blaisorblade wrote:
> On Friday 12 November 2004 15:10, Bodo Stroesser wrote:
> 
>>From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
>>
>>The patch needs some small corrections:
>>1) local_using_sysemu must be sampled *before* the next
>>    ptrace(PTRACE_SYSEMU/SYSCALL) and must stay the same until do_syscall()
>>    has been done. Currently it is sampled before do_syscall() and is used
>>    after this for ptrace(PTRACE_SYSEMU/SYSCALL). Even if no problem is
>>    visible to the UML user, a single syscall could be executed on the host
>>    when switching on sysemu. The result of this then is overwritten by the
>>    syscall execution in UML.
> 
> 
>>    Since the first event the tracer has to handle is not a syscall, it's
>>    enough to initialize local_using_sysemu to 0;
> 
> 
> Sorry, what happens if the first signal it gets is a SIGTRAP, and so 
> local_using_sysemu is not yet set? If this is impossible, please add a 
> comment in the code for this. However, it seems that it can get to the 
> SIGTRAP case with tracing == 1. When beginning the procedure, it is 0, but it 
> can be changed with the value from is_tracing(task). I've not checked if that 
> is zeroed on process creation (i.e. by do_fork() calling copy_thread()), but 
> just note that in the code.
OK: Let's summarize:
1) tracer() is started exactly once.
2) The first this it does, is starting the first ptraced-process via clone().
3) Then it waits until the new process stops.
4) Since the process will run start_kernel() in kernel space, it is resumed
    with PTRACE_CONT.
Thus, before having any syscall interception, the process has to stop itself
with a SIGUSR1, giving the tracer an OP_TRACE_OP request. After this
local_using_sysemu will be set and the process will be resumed with
PTRACE_SYSCALL or PTRACE_SYSEMU.
> 
> 
>>2) Even if the host never *does* a syscall in SYSEMU, we have to write the
>>    syscall number with -1, to not have the host doing syscall restarting.
>>    This would happen only with an invalid syscall number equal to one of
>>    the -ERESTART values.
> 
> 
>>    But to be perfect ... 
> 
> 
> Yes, but shouldn't this be handled on the host? Restarting a syscall which has 
> never been done does not seem something that SYSEMU should allow... I don't 
> want anybody to need going through the code and checking that this is safe.
Yes. It should. So I exactly added this to the "advanced sysemu". But despite this
UML should work on an older sysemu host, too. So I add this now, and with the
SYSEMU_SINGLESTEP-patches a skip of writing -1 is inserted, if the new sysemu is
in use.


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

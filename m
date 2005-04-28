Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DRAXe-00070O-NL for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 08:03:02 -0700
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DRAXd-0006U3-7n for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 08:03:02 -0700
Message-ID: <4270FB20.50202@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Re: Again: UML on s390 (31Bit)
References: <OF7DA21BA7.6A0D6C67-ONC1256FF1.003C86C5-C1256FF1.0047B648@de.ibm.com>
	<4270E813.50706@fujitsu-siemens.com>
In-Reply-To: <4270E813.50706@fujitsu-siemens.com>
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
Date: Thu, 28 Apr 2005 17:02:56 +0200
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux devel <user-mode-linux-devel@lists.sourceforge.net>

Bodo Stroesser wrote:
> Martin Schwidefsky wrote:
> 
>> So (!entryexit & regs->gprs[2] < 0) translates to the debugger changed 
>> the
>> guest
>> system call to something illegal on the first of the two ptrace calls. So
>> the
>> patch doesn't hurt for normal, non-ptraced operation but it might hurt
>> other
>> users of ptrace.
> 
> I don't think, it hurts. If a debugger willingly sets the syscall number
> to -1, what would happen without the patch?
> The kernel will set the result -ENOSYS into grps[2]. So, even if trap
> still indicates a syscall and a signal is pending, no syscall restarting
> will be done.
> With the patch, a debugger would observe changed behavior of the kernel
> *only*, if it writes the syscall number to -1 on the first syscall
> interception and then writes the result to ERESTARTXXXXX on the second,
> while at the same time a signal is pending for the debugged process.
> 
> I assumed, that non of the current users of ptrace exactly does this.
> If I'm wrong here, the patch *really* is bad.
Addendum:
To avoid any conflicts as far as possible, the -1 written and checked
as the syscall number to reset trap could be replaced by some magic
value, which then should defined in asm/ptrace.h
In terms of performance, any method, that allows to reset trap
without an additional ptrace call, is fine.

	Bodo


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

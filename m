Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] Re: [uml-user] keyring syscalls
In-Reply-To: <20050125215416.GA2912@halcrow.us>
Message-ID: <Pine.LNX.4.61.0501252301330.3289@filer.marasystems.com>
References: <20041118160909.GA7630@halcrow.us>
	<200411181839.26596.blaisorblade_spam@yahoo.it>
	<20050125215416.GA2912@halcrow.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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
Date: Tue, 25 Jan 2005 23:21:33 +0100 (CET)
To: Michael Halcrow <uml@halcrow.us>
Cc: Blaisorblade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

On Tue, 25 Jan 2005, Michael Halcrow wrote:

> I am not entirely clear on the function that ``[ 222 ] =
> sys_ni_syscall,'' at the end of the table in syscalls.h is supposed to
> serve.

This says that syscall number 222 is not implemented, which it isn't on 
i386 (not defined).

>  Syscalls in UML contstitutes new territory for me.

Mostly the same as syscalls in any other architecture. A big table with 
function pointers to each syscall, indexed by the syscall number.

As each architecture has it's own syscall table but UML sharing the 
syscall numbers with the host architecture things get a little confusing 
sometimes. And in addition the UML syscall table often lags behind a 
little, missing the newer syscalls.

Note that the main syscall table is defined in 
arch/um/kernel/sys_call_table.c, the define in the 
include/asm/sysdep/syscalls.h is just the part of the syscall table which 
is specific to a certain host architecture.

To add a new generic syscall you should

   1. Add it to asm-xxx/unistd.h of each architecture, except for um which 
picks it up from the host architecture.
   2. Add it to the syscall table of earch architecture, um included.

To add a new i386 only syscall you should

   1. Add it to asm-i386/unistd.h
   2. Add it to the i386 syscall table
   3. Add it to um i386 specific syscall table in 
asm-um/sysdep-i386/syscall.h

> I would assume that the __NR_* assignments in the UML environment are 
> identical to those of the host system.

They are. UML directly includes unistd.h from the host architecture.

> That means that request_key,
> for example, maps to identifier 288 on the i386 architecture, right?

Which should have their appropriate _NR_xxx identifiers defined. For 
maintenance reasons the syscall table should be built using _NR_xxx 
identifiers, not the absolute numbers.

Regards
Henrik


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CEAcO-0002la-HJ for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 03 Oct 2004 10:57:56 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CEAaS-0008Gz-Th for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 03 Oct 2004 10:57:56 -0700
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] T-mode processes 
In-Reply-To: <29392.1096824373@marajade.sandelman.ottawa.on.ca>
Message-ID: <Pine.LNX.4.61.0410031940080.16875@filer.marasystems.com>
References: <29246.1096763190@marajade.sandelman.ottawa.on.ca> 
	<Pine.LNX.4.61.0410031239090.13697@filer.marasystems.com> 
	<29392.1096824373@marajade.sandelman.ottawa.on.ca>
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
Date: Sun, 3 Oct 2004 19:55:30 +0200 (CEST)
To: Michael Richardson <mcr@sandelman.ottawa.on.ca>
Cc: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

On Sun, 3 Oct 2004, Michael Richardson wrote:

> It may well be, but it isn't acceptable.
> What would break if kill-9 got rid of processes being PTRACE'ed?

This discussion probably is more related to lkml than uml..

For one thing the SIGKILL needs to be notified to and acted upon by the 
tracing parent process before it is delivered to the killed process. It is 
possible (and certainly so in case of UML) that the tracing parent wants 
to do something entirely different when a traced whild receives SIGKILL or 
other terminal action.

The actual question is why a process can be left in traced state without 
any parent tracing it.. You'll see the same symptoms if you strace a 
process and then kills strace. My guess is that this is from the basic 
question on how to determine what to do with the traced process when the 
tracing parent disappears without telling what the future fate of this 
process should be.. neither killing or untracing the process is safe 
options.

Any way, sending a SIGCONT to the stopped process gets it going again, or 
killed in case a SIGKILL or other terminal action is pending.

Regards
Henrik


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

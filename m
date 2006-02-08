Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F6vLl-00085M-Pc for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Feb 2006 11:51:37 -0800
Received: from smtp08.web.de ([217.72.192.226])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1F6vLj-000171-So
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Feb 2006 11:51:38 -0800
Message-ID: <001101c62ce9$8173f460$0200000a@aldipc>
From: "roland" <devzero@web.de>
References: <979918309@web.de>
	<20060208182803.GC6625@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] AoE with UML?   have a strange problem with AoE root
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
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
Date: Wed, 8 Feb 2006 20:54:42 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: blaisorblade@yahoo.it, user-mode-linux-devel@lists.sourceforge.net

> BTW, is this x86_64 or i386?  Yesterday, I rediscovered how to make this 

"unfortunately" it's just i386

thanks
roland




----- Original Message ----- 
From: "Jeff Dike" <jdike@addtoit.com>
To: <devzero@web.de>
Cc: <blaisorblade@yahoo.it>; <user-mode-linux-devel@lists.sourceforge.net>
Sent: Wednesday, February 08, 2006 7:28 PM
Subject: Re: [uml-devel] AoE with UML? have a strange problem with AoE root


> On Sat, Feb 04, 2006 at 11:17:13AM +0100, devzero@web.de wrote:
>> > On Sat, Feb 04, 2006 at 03:07:23AM +0100, roland wrote:
>> > > Checking that ptrace can change system call numbers...OK
>> > > Checking syscall emulation patch for ptrace...missing
>> > > Checking PROT_EXEC mmap in /tmp...OK
>> > > Checking for the skas3 patch in the host:
>> > >   - /proc/mm...found
>> > >   - PTRACE_FAULTINFO...found
>> > >   - PTRACE_LDT...found
>> > > UML running in SKAS3 mode
>> > > ---- hangs here forever. err - why that early ? -----
> 
> BTW, is this x86_64 or i386?  Yesterday, I rediscovered how to make this 
> happen on x86_64.  There's a timer loop in a driver that you get when you
> enable SERIO_I8042 that never finishes on x86_64, and it causes the hang
> right there.
> 
> Jeff


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

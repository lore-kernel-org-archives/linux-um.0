Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C7fak-00018C-Jw for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 15 Sep 2004 12:37:22 -0700
Received: from zrtps0kn.nortelnetworks.com ([47.140.192.55])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C7faj-0003rV-OQ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 15 Sep 2004 12:37:22 -0700
Message-ID: <41489967.1090307@nortelnetworks.com>
From: Joe Marzot <gmarzot@nortelnetworks.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] handle_trap - failed to wait at end of syscall
References: <200408120541.i7C5faJd010923@ccure.user-mode-linux.org>
	<200409132139.33256.blaisorblade_spam@yahoo.it>
	<200409132214.i8DMEwL7003829@ccure.user-mode-linux.org>
	<200409141241.21480.blaisorblade_spam@yahoo.it>
	<414717A4.7070605@nortelnetworks.com>
	<200409142123.i8ELN34W004063@ccure.user-mode-linux.org>
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
Date: Wed, 15 Sep 2004 15:35:03 -0400
To: Jeff Dike <jdike@addtoit.com>
Cc: Joe Marzot <gmarzot@nortelnetworks.com>, BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, "Smith, Paul [BL60:NP52:EXCH]" <pausmith@americasm01.nt.com>

Jeff Dike wrote:
> gmarzot@nortelnetworks.com said:
> 
>>In our case the UML is launched like this:
>>perl script
>>   my $pid = fork();
>>   if ($pid == 0) {
>>      setpgrp(); # give all UMLs the same group id so I can renice them
>>      exec($cmd); 
> 
> 
> I think I understand what's happening.  You are (unwittingly) sending UML
> (and every process that belongs to it) a HUP when you, in effect, detach it
> from its parent terminal.

where am I detaching from the parent terminal?

I just did a little test and instead of invoking UML I start a little 
perl script in exactly the same way as above to catch SIGHUP...but no 
SIGHUP arrives.

> 
> My first thought was that SIGHUP isn't disabled in the userspace process,
> and it should be, but it is, so I don't know why it's even being seen by
> the ptracer.  It should only see signals which are enabled in the child.

more oddness.

> 
> In the meantime, while we figure this out, you might try just adding "nohup"
> to the beginning of your $cmd.

originally tried this but something bad happened...forget which I could 
go back and see ... and try setsid as the other poster suggested.

regards, GSM

> 
> 				Jeff
> 
> 
> 





-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

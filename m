Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EbesU-0002vM-PW for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Nov 2005 06:00:10 -0800
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user12940)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EbesT-00065k-Bl
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Nov 2005 06:00:11 -0800
Subject: Re: [uml-devel] Making UML Single Threader
References: <200511061723.32848.rob@landley.net>
	<91A93A3A-FE83-4002-A004-E8FD4AFBAA3C@stanford.edu>
	<200511080109.06999.rob@landley.net>
	<20051108154618.GB4131@ccure.user-mode-linux.org>
From: Nix <nix@esperi.org.uk>
In-Reply-To: <20051108154618.GB4131@ccure.user-mode-linux.org> (Jeff Dike's
	message of "Tue, 8 Nov 2005 10:46:18 -0500")
Message-ID: <87lkzrwcs3.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Mon, 14 Nov 2005 13:59:40 +0000
To: Jeff Dike <jdike@addtoit.com>
Cc: Rob Landley <rob@landley.net>, user-mode-linux-devel@lists.sourceforge.net, Can Sar <csar@stanford.edu>

On Tue, 8 Nov 2005, Jeff Dike prattled cheerily:
> On Tue, Nov 08, 2005 at 01:09:06AM -0600, Rob Landley wrote:
>> > So I don't care about systemcall interception or anything like that,
>> 
>> *blink*  *blink*
>> 
>> Ok, you want user mode linux, but you don't want it to actually run user 
>> processes, nor do want it to be able to intercept system calls.
>> 
>> Um...  What's left?
> 
> Only all of Linux.  It so happens that I want exactly the same thing for 
> libUML, except I haven't had time to do anything about it.

I've long wanted to do the same sort of thing, to do with a UML the same
sort of thing you can do with a real Linux box: that is, set up
networking and a bridging firewall, then halt it: the kernel keeps
processing network packets and firewalling and bridging them perfectly
well, but attackers now have *real* trouble changing the configuration.
You stop it with kill() on the host, or mconsole; as it's halted and all
fsen are unmounted and so on, you're safe from filesystem corruption.

When combined with CONFIG_NETCONSOLE, you can even keep an eye on it. :)

The necessary hack looks quite simple: I just haven't got around to it.

-- 
`Holy Google, pray for us sinners now and in the hour of our job interview.'


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

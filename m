Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Ady7V-0007sK-Ov for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jan 2004 12:48:09 -0800
Received: from [195.159.42.3] (helo=pluto.nixia.no)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1Ady7U-0003sL-Ug for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jan 2004 12:48:09 -0800
Message-ID: <33261.193.212.97.12.1073406789.squirrel@pluto.nixia.no>
In-Reply-To: <a0602040bbc20b325acfd@[192.168.1.10]>
References: <Pine.LNX.4.58.0312300027110.24938@silk.corp.fedex.com><200401061718.i
	06HILtd002620@ccure.user-mode-linux.org><a0602040abc20a9f6862e@[192.16
	8.1.10]><200401061918.31447.blaisorblade_spam@yahoo.it> 
	<a0602040bbc20b325acfd@[192.168.1.10]>
Subject: Re: [uml-devel] Kernel mode fault at addr 0x48965000, ip0x400e51a4
From: stian@nixia.no
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
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
Date: Tue, 6 Jan 2004 17:33:09 +0100 (CET)
To: Johannes Formann <johannes@formann.de>
Cc: BlaisorBlade  <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

> At 19:18 Uhr +0100 06.01.2004, BlaisorBlade wrote:
>
>>you need to type this before starting:
>>
>>(host gdb) handle SIGSEGV pass nostop noprint
>>(host gdb) handle SIGUSR1 pass nostop noprint
>
> When I type that, It hit no breakpoint, so I cant get any backtarce
>
> ..
>
> Starting system log daemon: syslogd.
> Starting kernel log daemon: klogd.
> Kernel panic: Kernel mode fault at addr 0x8814000, ip 0x400d93c4
>
> (no debugging symbols found)...(no debugging symbols found)...(no
> debugging symbols found)...
> Program exited normally.
> (gdb) bt
>
> Can you give am a step by sped advice /'m new in (kernel)debuging),
> the simple run with all brakpoints doesn't seem to help.
>
> regards
>
> Johannes

First it would be nice to have debug information, so you just don't get a
stack backtrace just with addresses and no names (make sure that gcc has
the -g when compiling and linking all parts of the kernel), and if you
can't set a working breakpoint on panic, make a dummy function panic
calls, and set breakpoint on that function.


Stian


This mail has been scanned for known viruses on an open, Linux-based mailsystem
developed by http://Knowledge-Network.no and http://Nixia.no.


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

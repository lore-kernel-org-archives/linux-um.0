Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AdwXm-0002Io-Uh for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jan 2004 11:07:10 -0800
Received: from 62-241-36-148.kunde.vdserver.de ([62.241.36.148] ident=mail)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AdwXm-0002Rn-I6 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jan 2004 11:07:10 -0800
Mime-Version: 1.0
Message-Id: <a0602040cbc20b788b425@[192.168.1.10]>
In-Reply-To: <33261.193.212.97.12.1073406789.squirrel@pluto.nixia.no>
References: <Pine.LNX.4.58.0312300027110.24938@silk.corp.fedex.com><200401061718.i 
	06HILtd002620@ccure.user-mode-linux.org><a0602040abc20a9f6862e@[192.16 
	8.1.10]><200401061918.31447.blaisorblade_spam@yahoo.it>     
	<a0602040bbc20b325acfd@[192.168.1.10]>
	<33261.193.212.97.12.1073406789.squirrel@pluto.nixia.no>
From: Johannes Formann <johannes@formann.de>
Subject: Re: [uml-devel] Kernel mode fault at addr 0x48965000, ip0x400e51a4
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
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
Date: Tue, 6 Jan 2004 20:06:20 +0100
To: stian@nixia.no
Cc: BlaisorBlade  <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

At 17:33 Uhr +0100 06.01.2004, stian@nixia.no wrote:

>First it would be nice to have debug information, so you just don't get a
>stack backtrace just with addresses and no names (make sure that gcc has
>the -g when compiling and linking all parts of the kernel)

ok, then I'll go an compile the uml-kernel new.

Johannes


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

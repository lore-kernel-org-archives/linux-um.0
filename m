Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQLoD-0001yv-CK for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 May 2004 00:48:13 -0700
Received: from mail.thermeoneurope.com ([212.159.53.157]
	helo=dogbert.thermeoneurope.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1BQLoC-0003RO-2m
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 May 2004 00:48:12 -0700
Message-ID: <40AB10FF.6080901@thermeoneurope.com>
From: Mark Olliver <mpo@thermeoneurope.com>
MIME-Version: 1.0
References: <40AA0BD9.7070403@thermeoneurope.com>
	<093601c43d25$42633a20$2000000a@schlepptopp>
In-Reply-To: <093601c43d25$42633a20$2000000a@schlepptopp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: poll: uml bug management - was: Re: [uml-user] 2.6.6
	Kernel mconsole & mem
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
Date: Wed, 19 May 2004 08:47:11 +0100
To: roland <for_spam@gmx.de>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, blaisorblade_spam@yahoo.it

Hi,

The host OS is 2.6.6 with skas and drbd patches, the guest is 2.6.6 with 
uml and skas. It only seams to take some of the command line options ie 
it doesnt respond to mem= or umid= . It also doesnt cleanly shut down.

Mark

roland wrote:

>have seen the same problem with a uml 2.6.6 guest compiled and running on a suse 9.1 host.
>(mkstemp failed and left processes after shutdown)
>
>what`s your host OS ? 
>what`s your guest rootfs?
>do you use skas or tt ?
>
>btw: should we file a bug-report at:
>http://sourceforge.net/tracker/?group_id=429&atid=100429
>or shouldn`t that bugtracker not being used anymore - in general ?
>if not, IMHO that bugtracker should be marked "obsolete"(like the SF cvs repository) - otherwise
>newbies will file reports there and get pissed , because nobody cares about.
>on that page there still are bugs "open" for years now - and nobody knows, if they still exist, or 
>not.
>
>i think it`s very difficult, to track bugs on the mailinglist, only.
>we know, that jeff is collecting the bug reports:
>  
>
>>The bug tracker is the UML mailing lists.  I stick bug reports and patches in 
>>a todo folder and delete them from there when I fix (or merge) them.  I pay
>>almost no attention to the SF patch and bug report thingies.  So if you want
>>your bug to get attention, send it to one of the lists.
>>    
>>
>
>imho, if uml users/developers probably hit a bug, they should be able to browse the list of 
>known uml bugs and add comments. this adds transparency and encourages people to try to reproduce. 
>furthermore, this could encourage people to "debug" some uml code, because they see: ohhh 
>- that bug has priority 9 for 6 months now - let`s have a look....i`m soo geeky - probably 
>i get this fixed :)
>currently, there isn`t much transparency - users need to dig into the whole "noise" of the 
>mailinglist - and if a bug is reported on the mailinglist a while ago, jeff is the only person 
>to know, that this bug exists and still needs to be fixed.
>
>i would like to give an example for a really nice "bug page":
>http://rockbox.haxx.se/bugs.shtml
>
>that page is created by a script, which extracts the information from SF and puts it into a 
>nicely formatted page:
>http://cvs.sourceforge.net/viewcvs.py/rockbox/www/getbugs.pl
>
>why not using it, too ?
>i vote for it!
>:)
>comments ?
>
>regards
>roland
>
>ps:
>since such bug page needs maintenance - i offer doing that job (as good as i can).
>
>
>
>
>----- Original Message ----- 
>From: "Mark Olliver" <mpo@thermeoneurope.com>
>To: <user-mode-linux-user@lists.sourceforge.net>
>Sent: Tuesday, May 18, 2004 3:12 PM
>Subject: [uml-user] 2.6.6 Kernel mconsole & mem
>
>
>  
>
>>Hi
>>
>>I am using a host and guest 2.6.6 kernel with uml and skas patches 
>>applied. I can get a uml instance to startup ok and can talk to it via 
>>the network.
>>
>>However, I can not communicate with it via mconsole, when it boots it 
>>gives me the error:
>>    make_umid - mkstemp failed, errno = 2
>>
>>also when I shut the uml instance down with a shutdown -h 0 is shuts 
>>down the instance but leaves a few processes running on the host system.
>>
>>I have been starting the instances using
>>./linux umid=uml127 ubd0=root_fs_cp127 udb1=swapfile-uml127 
>>eth0=tuntap,,,192.168.xxx.250
>>
>>Any ideas or suggestions of where I may have gone wrong are welcome.
>>
>>Thanks
>>
>>Mark
>>
>>-- 
>>Mark Olliver
>>
>>Thermeon Europe Ltd.
>>
>>e-Card: http://www.thermeoneurope.com/e-Card/mpo
>>
>>Email mpo@thermeoneurope.com
>>Web www.thermeoneurope.com
>>
>>Support 0906 515 0908
>>Int. Support +44 1293 864 341
>>Support Email support@thermeoneurope.com
>>
>>Sales +44 1293 864 334
>>Sales Email sales@thermeoneurope.com
>>
>>
>>
>>-------------------------------------------------------
>>This SF.Net email is sponsored by: SourceForge.net Broadband
>>Sign-up now for SourceForge Broadband and get the fastest
>>6.0/768 connection for only $19.95/mo for the first 3 months!
>>http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
>>_______________________________________________
>>User-mode-linux-user mailing list
>>User-mode-linux-user@lists.sourceforge.net
>>https://lists.sourceforge.net/lists/listinfo/user-mode-linux-user
>>
>>    
>>

-- 
Mark Olliver

Thermeon Europe Ltd.

e-Card: http://www.thermeoneurope.com/e-Card/mpo

Email mpo@thermeoneurope.com
Web www.thermeoneurope.com

Support 0906 515 0908
Int. Support +44 1293 864 341
Support Email support@thermeoneurope.com

Sales +44 1293 864 334
Sales Email sales@thermeoneurope.com



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

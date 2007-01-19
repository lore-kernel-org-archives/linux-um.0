Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H7wOD-0002P5-1n for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 19 Jan 2007 08:14:53 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1H7wOA-0004sQ-7p
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 19 Jan 2007 08:14:52 -0800
Message-ID: <45B0EE71.5040908@nagafix.co.uk>
Date: Fri, 19 Jan 2007 16:14:41 +0000
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
References: <200701171715.35504.blaisorblade@yahoo.it>	
	<45AE684D.7070802@theshore.net> <45AE67C0.5080003@nagafix.co.uk>	
	<45AE7DFC.9050704@nagafix.co.uk> <45B0A4B7.7050702@nagafix.co.uk>
	<1169222858.11134.52.camel@athena.fprintf.net>
In-Reply-To: <1169222858.11134.52.camel@athena.fprintf.net>
Subject: Re: [uml-devel] buggy UML AMD64?
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Daniel Gryniewicz <dang@gentoo.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

Daniel Gryniewicz wrote:
> On Fri, 2007-01-19 at 11:00 +0000, Antoine Martin wrote:
>> Is anyone else having stability problems on AMD64? Or am I the only one 
>> using it?
>> Not only is x86 UML broken on AMD64, I am also getting (seemingly) 
>> random crashes running 64-bit UML.
>> The Gentoo guests in particular randomly fail to compile code - failing 
>> in completely random places. When you try again, it might work or just 
>> fail later when you run the binary...
>> These used to work reliably before so I am not just doing it wrong (as 
>> is often the case ;)
>> To summarize, that leaves us with:
>> * x86 unable to run kernels 2.6 due to a bug in host >2.6.16
>> (and most x86 guests require 2.6 to use latest glibc)
>> * amd64 unable to run x86 guests
>> * amd64 unable to run amd64 guests reliably
>> ...
>>
> 
> I'm the gentoo usermode-sources maintainer, and I run UML almost
> exclusively on amd64.  I have, at any given time, from 4 to 20 UMLs
> running on my main dev box, most of them 32-bit, and I haven't had any
> stability problems.
Can you send me more details of your setup as I am quite experienced 
with UML and now completely stuck with AMD64.

> Is your RAM OK?
Oh yes, this has nothing to do with the hardware.

> Which kernels do you have inside and outside?
Host (outside):
2.6.19.2-skas3-v8.2

Inside: pick any of those (none of them work with >=2.6.16):
http://uml.nagafix.co.uk/

>  How are
> you trying to build the 32-bit UMLs?
These are the same as on the site above (which I maintain) and these 
have worked flawlessly for a long long time.

I have downgraded the x86 boxes to 2.6.15.7 and these are up and running 
again. But I can't do that for all of them, and this is just not an 
option for some of the amd64 boxes.

Thanks
Antoine

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

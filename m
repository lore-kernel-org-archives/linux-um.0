Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H7xcv-000382-Ff for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 19 Jan 2007 09:34:09 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1H7xct-000290-Cb
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 19 Jan 2007 09:34:09 -0800
Message-ID: <45B10106.6060107@nagafix.co.uk>
Date: Fri, 19 Jan 2007 17:33:58 +0000
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
References: <200701171715.35504.blaisorblade@yahoo.it>	
	<45AE684D.7070802@theshore.net> <45AE67C0.5080003@nagafix.co.uk>	
	<45AE7DFC.9050704@nagafix.co.uk> <45B0A4B7.7050702@nagafix.co.uk>	
	<1169222858.11134.52.camel@athena.fprintf.net>	
	<45B0EE71.5040908@nagafix.co.uk>
	<1169224702.11134.71.camel@athena.fprintf.net>
	<45B0F512.6020308@nagafix.co.uk>
In-Reply-To: <45B0F512.6020308@nagafix.co.uk>
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
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

>>> I have downgraded the x86 boxes to 2.6.15.7 and these are up and 
>>> running again. But I can't do that for all of them, and this is just 
>>> not an option for some of the amd64 boxes.
>>
>> My setup is:
> Thanks for that. That is very similar to mine.
> I don't think this has anything to do with the guest... So I'll try to 
> remove the skas3 patch from the host and see how it goes.
> 
I did, and no improvement... x86 guests still hang.
Could you post a binary guest kernel somewhere so I can try that?
(even if it isn't static - glibc should be similar since we're using 
Gentoo amd64)
If that still does not work then I can be certain that it is something 
to do with the host.

Thanks
Antoine

BTW, anyone know if UML guests are compatible with exec-shield?

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FPG78-00017C-DO for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 31 Mar 2006 01:40:18 -0800
Received: from bay101-f30.bay101.hotmail.com ([64.4.56.40] helo=hotmail.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FPG76-0002yd-59
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 31 Mar 2006 01:40:18 -0800
Message-ID: <BAY101-F30593AD27C598206A10CAFE2D60@phx.gbl>
From: "James McMechan" <james_mcmechan@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Subject: [uml-devel] RE: UML-hcd driver for 2.6.x
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
Date: Fri, 31 Mar 2006 09:39:26 +0000
To: wilhelm.golz@secunet.com
Cc: user-mode-linux-devel@lists.sourceforge.net

Hello Mr. Golz,

There has only been minor interest in using USB from within UML and the host 
controller
architecture changed ~2.4.19/2.5.59 breaking the usb-hcd.

Enthusiasm for fixing it has been lacking I only seem to get one or two 
emails each year about USB on UML.

Encouragement is welcome, it has been a lack of interest that has allowed it 
to fall to bit rot.

It was working fairly well before the architecture change and could be made 
to work again without very much more work.

I have a thought that USB/IP http://usbip.naist.jp/ may provide a more 
active approach with its virtual host controller over IP as a example of a 
current virtual host controller, or even direct use over UMLs networking.

Sorry for the extra long delay in replying, your message arrived while I was 
out of town for two weeks and now my cat is sick...

James McMechan

>From: Wilhelm Golz <wilhelm.golz@secunet.com>
>Reply-To: wilhelm.golz@secunet.com
>To: James_McMechan@hotmail.com
>Subject: UML-hcd driver for 2.6.x
>Date: Wed, 15 Mar 2006 13:38:59 +0100
>
>Hello James,
>
>we (secunet) are currently strongly interested in using USB-devices
>from within a 2.6.12-UML. As far as I have seen You are the
>only one, who had significant success with this under Linux 2.4.
>I tried to get Your uml-hcd-driver (2.5.59) work with a 2.6.12.1 UML
>running on a 2.6.8-host, but up to now without progress.
>
>My questions: Do You plan to develop on this topic in the next time,
>is there maybe a new driver on Your plan?
>Or should it basically work already and am I just not on the right path?
>Maybe there is a way to encourage You in further development of this 
>driver?
>
>With kind regards   Wilhelm Golz
>
>
>
>--
>Wilhelm Golz
>
>secunet Security Networks AG  	Telefon: +49.30.399782-11
>Niederlassung Berlin		Telefax: +49.30.399782-20
>Alt-Moabit 91c        		mailto:golz@secunet.com
>D-10559 Berlin        		http://www.secunet.com
>




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

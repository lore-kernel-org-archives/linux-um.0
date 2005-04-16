Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DMptO-0003hF-8J for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 16 Apr 2005 09:11:34 -0700
Received: from mail.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DMptM-0003gR-67 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 16 Apr 2005 09:11:34 -0700
Message-ID: <000801c5429f$b58babb0$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <007a01c5426c$ee241350$2000000a@schlepptopp>
	<20050416134809.GA3711@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] CowLoop
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
Date: Sat, 16 Apr 2005 18:16:55 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

Hello Jeff ,
indeed it would be great if cowloop would support UML cowfiles.
Since i didn`t find a reference from uml mailinglist to cowloop, i thought it would be good to announce it here.

Did anyone try it yet ?
I had some problem with cowloop when using reiserfs - and the current maintainer seems quite busy.

regards
roland


----- Original Message ----- 
From: "Jeff Dike" <jdike@addtoit.com>
To: "roland" <for_spam@gmx.de>
Cc: <user-mode-linux-user@lists.sourceforge.net>; <user-mode-linux-devel@lists.sourceforge.net>
Sent: Saturday, April 16, 2005 3:48 PM
Subject: Re: [uml-devel] CowLoop


> On Sat, Apr 16, 2005 at 12:13:26PM +0200, roland wrote:
> > Hi !
> > I think this is interesting for UserModeLinux:
> >
> > http://www.atconsultancy.nl/cowloop
> >
> > CowLoop is a kernel level driver and gives CopyOnWrite devices.
> >
> > There was some discussion a long time ago, about the annoyance not being able to mount a UML-Cowfile outside UML because of
missing
> > kernel support.
>
> I have it on my todo list to see how hard it would be to make it understand
> UML COW files.  Haven't really done anything with that yet, though.
>
> Jeff
>



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

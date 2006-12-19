Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GwjWx-00021t-Hz for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Dec 2006 10:17:35 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GwjWu-0004Vi-KC
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Dec 2006 10:17:35 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Tue, 19 Dec 2006 19:17:08 +0100
References: <45846DC1.80009@theshore.net>
In-Reply-To: <45846DC1.80009@theshore.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200612191917.09250.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] SKAS v8.2 for 2.6.19 and beyond?
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: "Christopher S. Aker" <caker@theshore.net>

On Saturday 16 December 2006 23:05, Christopher S. Aker wrote:
> Blaisorblade,
>
> Any chance you'll be creating a skas v8.2 patch for 2.6.19/20 any time
> soon?  I'm still weary of this issue with skas-v9pre:
>
> http://marc.theaimsgroup.com/?l=user-mode-linux-devel&m=116008558424368&w=2
>
> Would it be as simple as taking the broken-out skas-v9 patch for 2.6.19
> and only patching up to a certain point in the series?
Yes. The right point should also be self-evident from where 
skas-extraversion-v8_2 *more or less) is placed. Also note that a fix 
(removing the config.h inclusion) is needed.

For the time being (which should be until at least this whole week) I won't be 
able to handle these tasks, and I'm very sorry for that, because I'm too 
busy - but that should change soon (I'm completing a part my nice C++, 
Boost::Spirit based and time constrained project for university - 
maintainance is required but I hope it will require less time).
-- 
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

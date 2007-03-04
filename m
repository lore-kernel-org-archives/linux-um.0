Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HNwA7-0001PZ-0U for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 04 Mar 2007 11:14:27 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HNwA2-0002Ro-1O
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 04 Mar 2007 11:14:26 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sun, 4 Mar 2007 19:50:36 +0100
References: <20070301230442.GA469@localhost.localdomain>
	<200703031932.46323.blaisorblade@yahoo.it>
	<20070304165030.GB6516@localhost.localdomain>
In-Reply-To: <20070304165030.GB6516@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200703041950.36776.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [uml-user] [PATCH] uml hostfs: fix interaction
	between hostfs=path1 and -o path2 at mount time (was: Re:
	hostfs kernel parameter fail?)
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
To: Sylvain Beucler <beuc@beuc.net>, Antoine Martin <antoine@nagafix.co.uk>, Christopher Aker <caker@theshore.net>, user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

On Sunday 04 March 2007 17:50, Sylvain Beucler wrote:
> On Sat, Mar 03, 2007 at 07:32:46PM +0100, Blaisorblade wrote:
> Hi,
>
> I tested and it works.
>
> Thanks,

You'll probably also see that -o .. allows bypassing the 'hostfs jail', and 
I've just implemented a fix to that. The question is whether this should be 
merged.

Indeed, the root user inside UML can bypass that anyway, if he modifies the 
hostfs module, compiles and loads it. So the host admin really needs to run 
UML in a chroot if he needs real security.

What do you all think?
-- 
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade

Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

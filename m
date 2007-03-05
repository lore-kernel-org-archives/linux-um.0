Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HOHwN-000083-Ns for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 10:29:43 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HOHwL-0005sx-RH
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 10:29:43 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Mon, 5 Mar 2007 19:29:08 +0100
References: <20070301230442.GA469@localhost.localdomain>
	<200703041950.36776.blaisorblade@yahoo.it>
	<45EB4DE7.50608@nagafix.co.uk>
In-Reply-To: <45EB4DE7.50608@nagafix.co.uk>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200703051929.08916.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [uml-user] [PATCH] uml hostfs: fix interaction
	between hostfs=path1 and -o path2 at mount time
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
Cc: Jeff Dike <jdike@addtoit.com>, Sylvain Beucler <beuc@beuc.net>, user-mode-linux-devel@lists.sourceforge.net, Christopher Aker <caker@theshore.net>

On Sunday 04 March 2007 23:53, Antoine Martin wrote:
> Blaisorblade wrote:
> > On Sunday 04 March 2007 17:50, Sylvain Beucler wrote:
> >> On Sat, Mar 03, 2007 at 07:32:46PM +0100, Blaisorblade wrote:
> >> Hi,
> >>
> >> I tested and it works.
> >>
> >> Thanks,
> >
> > You'll probably also see that -o .. allows bypassing the 'hostfs jail',
> > and I've just implemented a fix to that. The question is whether this
> > should be merged.
> >
> > Indeed, the root user inside UML can bypass that anyway, if he modifies
> > the hostfs module, compiles and loads it.
>
> If security is at stake then the host admin should use non-modular
> kernels to prevent such tampering.

I know /dev/kmem allows bypassing that, but I don't know of any kmem-insmod 
out there (and that would make the issue quite practical).
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

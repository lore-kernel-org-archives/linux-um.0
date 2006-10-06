Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GVxjG-0002QV-Oh for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 Oct 2006 14:59:38 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GVxjF-0002WT-0R
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 Oct 2006 14:59:38 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Fri, 6 Oct 2006 23:54:25 +0200
References: <4525802F.1080900@theshore.net>
In-Reply-To: <4525802F.1080900@theshore.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200610062354.25444.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] 2.6.18-skas-v9-pre9 broken
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
To: "Christopher S. Aker" <caker@theshore.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thursday 05 October 2006 23:59, Christopher S. Aker wrote:
> Blaisorblade,
>
> I recently deployed a 2.6.18-skas3-v9-pre9 host, and some users weren't
> able to boot UML beyond "VFS: Mounted root (ext3 filesystem) readonly".
>   As it turns out, only 2.6-um kernels were affected, 2.4-um worked fine.
>
> This happened both in skas3 and skas0 modes.  Jeff graciously took a
> look at some straces, and his comment was that "something broke page
> fault handling generically".
>
> The traces are here:
>
> http://www.theshore.net/~caker/uml/skas2.6.18-uml_trace.txt (skas3)
> http://www.theshore.net/~caker/uml/skas2.6.18-uml_trace_skas0.txt
>
> Reverting back to a skas3-v8.2 kernel fixed it.
An important question: did the patch contain fremap code (the one for 
2.6.18-rc4 did)? That code does do heavy changes to page fault handling.
I'm also guessing this is a 32bit host.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

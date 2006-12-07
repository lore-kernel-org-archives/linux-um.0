Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GsIZM-000155-9m for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Dec 2006 04:41:44 -0800
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GsIZL-0003mM-OQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Dec 2006 04:41:44 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Thu, 7 Dec 2006 13:41:32 +0100
References: <87wt5h9azl.fsf@hades.wkstn.nix> <873b7zy7ce.fsf@hades.wkstn.nix>
	<87zma7ffin.fsf@hades.wkstn.nix>
In-Reply-To: <87zma7ffin.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200612071341.33101.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] PATCH [02/03]: eliminate skas_ptrace.h
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
To: Nix <nix@esperi.org.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Friday 01 December 2006 22:54, Nix wrote:
> On 1 Dec 2006, nix@esperi.org.uk uttered the following:
> > On 29 Nov 2006, blaisorblade@yahoo.it uttered the following:
> >> arch/um/os-Linux/start_up.o is in USER_OBJS, so it is compiled against
> >> host headers.
> >> You cannot _depend_ on them including the SKAS patch, as I said. And
> >> that header is in arch/um/include to be includable by both kernelspace
> >> and userspace files...
> >
> > Oh, hell, true. The problem is that we'll have to cater for people who
> > *have* included the skas headers, including the old ones...
>
> No we won't: kernel building includes things from the Linux source
> tree's includes directory, not /usr/include/asm, so what people have in
> /usr/include/asm/ptrace.h should be irrelevant.
For userspace files there's anyway a problem, since they _do_ 
use /usr/include/asm/ptrace.h .

> (I have now reproduced this failure both with and without the skas patch
> in the headers installed via `make headers_install'.)
>
> Or is it that userspace stuff includes /usr/include/asm/*, kernelspace
> stuff includes include/asm-{whatever} from the kernel tree, but nothing
> includes both, so we need *some* things in some third location where
> both can see them?
Exactly, the third location is arch/um/include for UML (it must be used for 
things needed only by userspace files, but is also used for some things which 
would be in include/asm-um).
> (If that's so, I don't see how my patch built at all. Hm.)
Bad dependency tracking ? I doubt that however...
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

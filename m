Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H9GFF-0006F3-EB for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Jan 2007 23:39:05 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1H9GFD-0000ff-JI
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Jan 2007 23:39:05 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Tue, 23 Jan 2007 08:37:47 +0100
References: <200701171724.51671.blaisorblade@yahoo.it>
	<9d1b82480701170915o38df718bp94896f1b0921e302@mail.gmail.com>
In-Reply-To: <9d1b82480701170915o38df718bp94896f1b0921e302@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200701230837.47338.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Configuration problem with UML in kernel 2.6.19.1
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
To: Pravin <shindepravin@gmail.com>, user-mode-linux-devel@lists.sourceforge.net

On Wednesday 17 January 2007 18:15, Pravin wrote:
> Thanx  :-)
> Its working now.... :-)
>
> One more thing that I would like to tell here.
> I did used same compiled kernel on other machine which was having
> 2.6.17-1.2187_FC5.
> And that kernel 2.6.19 without your patch did worked fine....
>
> but same kernel 2.6.19 was not working on my machine which is Debian 
> 2.6.18. After applying your patch and changing the configuration to
> HOST_2G_2G its working fine now on my Debian machine 2.6.18.
>
> Can I know what excatly was the problem... ?

Usually the host kernel "gives"* a certain space (3G) to userspace apps. Some 
host kernels give less memory (say 2,75G, 2G, or even 1G) to userspace apps 
(these days, it depends on the CONFIG_VMSPLIT_* settings, before it could be 
tuned via external patches like -ck patchset or probably others).

Most application use the available memory, but UML, for now, needs to know 
that it can use a given amount - say 2G. It will run fine when more memory is 
available, but not when less memory is available.

At last, why different splits? While 3G is usual (normally named 3G/1G), on a 
host with 1G of RAM you either use HIGHMEM (with a little slowdown) or use a 
2,75G/1,25G split.

* This is "virtual address space", not a statical split assigning physical RAM 
to different purposes - but I won't go in the details here.

> My main objective is to run SELinux on UML kernel and test it.

Probably Antoine Martin is the one having more experience on UML+SELinux. This 
is his page on the argument:

http://uml.nagafix.co.uk/SELinux/

> Let me know if there is anything I can do to help here.
>
> On 1/17/07, Blaisorblade <blaisorblade@yahoo.it> wrote:
> > You mentioned trying to use CONFIG_HOST_VMSPLIT to solve a problem, that
> > is of little use without this applied, if you run UML in SKAS0 mode.
> >
> > ----------  Forwarded Message  ----------

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

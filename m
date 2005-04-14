Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DMBFe-0004Ag-5C for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Apr 2005 13:47:50 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DMBFa-0003Au-H8 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Apr 2005 13:47:49 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] My personal -devel tree snapshotted out on my
	homepage!
References: <200504082020.18943.blaisorblade@yahoo.it>
	<200504121923.34999.blaisorblade@yahoo.it>
	<cbec11ac05041220314fa52041@mail.gmail.com>
In-Reply-To: <cbec11ac05041220314fa52041@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504142300.14321.blaisorblade@yahoo.it>
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
Date: Thu, 14 Apr 2005 23:00:14 +0200
To: Ian McDonald <imcdnzl@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wednesday 13 April 2005 05:31, Ian McDonald wrote:
> Comments below:
>
> On 13/04/05, Blaisorblade <blaisorblade@yahoo.it> wrote:
> > On Monday 11 April 2005 01:19, Ian McDonald wrote:
> > > With this patch applied to 2.6.11.7 it is my first kernel that
> > > compiles straight off :-)
> >
> > Ok, that's the -bs tree, not the one I announced here (the -devel one)
> > but it's ok anyway.
> >
> > > It does not apply one patch because it is already applied which is
> > > fine.
> >
> > Yes, I merged that, it's the va_copy fix.
>
> Sorry about that...
>
> > > I did a quick test against 2.6.12-rc2 and it didn't like that at all
> > > (many rejected patches). That is to be expected though as that is not
> > > the target but it does mean a reasonable amount of work ahead for
> > > Paolo :-(
> >
> > No; luckily, I'm mainly working on -rc2 and I've backported the needed
> > stuff to 2.6.11.
>
> Found the development snapshot and found the following problems:
> One patch did not apply. Documented in patch.out which is attached.
>
> Problem with arch/um/include/mode_kern.h as below
> In file included from arch/um/kernel/exec_kern.c:23:
> arch/um/include/mode_kern.h:12: unterminated string or character constant
> It doesn't like the #error on gcc 2.95.4 - if I do a remove of this
> line it compiles... will need a better fix than this though....
>
> Problem with arch/um/kernel/init_task.c as below
> arch/um/kernel/init_task.c:30: duplicate initializer
> arch/um/kernel/init_task.c:30: (near initialization for
> `init_task.thread.arch.debugregs')
> This is probably a duplication in initialisation of struct just like
> the problem we had with enum in syscalls and again due to gcc 2.95.4.
> I haven't tracked this one down fully yet but can if needed buy may
> take a while...
>
> I then hacked half that line out and got further compile errors in
> arch/um/kernel/process_kern.c as per attached file err.out. I then
> stopped as this looked a little more complicated...
>
> If you need any further information please tell me... I have also
> checked that 2.6.12-rc2 without the patch does compile and it does
> with the addition of the sed patch.
>
> If you want me to help I can apply the patches one by one but this
> will take some time...
Don't worry for now, that's the development tree and for now I'm not going to 
merge it all of a sudden...
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

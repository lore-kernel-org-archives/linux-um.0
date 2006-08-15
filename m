Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GD31T-0000Ym-Sc for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Aug 2006 10:48:15 -0700
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GD31R-0002HL-4X
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Aug 2006 10:48:15 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Tue, 15 Aug 2006 19:47:54 +0200
References: <39134b110608100842p5acdf798o807b48801ea9a706@mail.gmail.com>
	<200608122022.42389.blaisorblade@yahoo.it>
	<39134b110608140407n718d0cf5rfed71f8295ea43e0@mail.gmail.com>
In-Reply-To: <39134b110608140407n718d0cf5rfed71f8295ea43e0@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608151947.54925.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] UML hostfs bugs
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
To: wang lianwei <lianwei.wang@gmail.com>, Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Monday 14 August 2006 13:07, wang lianwei wrote:
> Answers:
>
> 1. I test it on ext3 filesystem.
>
> 2. You are right. Sometimes the pos telldir returned is not the next entry
> offset. just as your point out:
>       position 0 -> readdir "." -> you call telldir -> it _again_ says
> you're at 0.
>
> 3. I also try to resolve it by remove the seekdir(only use the
> sequence readdir call), It is also worked.

I can guess what the patch does but please generate with the additional -p 
option so it's easier to read (otherwise the recipient _has_ to read the 
source). Compliments for the solution, it's really simpler and better than my 
proposal.

Also, you have to regenerate it anyway for another (tiny) reason: it is not 
always safe to use "seekdir" in kernelspace code, you need (sadly) a new 
wrapper in hostfs_user.c and to call it instead of seekdir in hostfs_kern.c; 
almost surely you'll get an "undeclared function" warning but miscompilations 
in some rare cases are also possible, say for stat(): it is defined almost 
only as a static inline function, or for some structures having different 
definitions in userspace and kernelspace.

> --- linux-2.6.x/fs/hostfs/hostfs_kern.c 2006-04-12 15:12:51.000000000 +0800
> +++ linux-2.6.10-src/fs/hostfs/hostfs_kern.c      2006-08-14 18:25:
> 13.772237744 +0800
> @@ -338,6 +338,7 @@
>         kfree(name);
>         if(dir == NULL) return(-error);
>         next = file->f_pos;
> +       seekdir(dir,next);
>         while((name = read_dir(dir, &next, &ino, &len)) != NULL){
>                 error = (*filldir)(ent, name, len, file->f_pos,
>                                    ino, DT_UNKNOWN);
>
>
> --- linux-2.6.x/fs/hostfs/hostfs_user.c 2006-04-12 15:12:52.000000000 +0800
> +++ linux-2.6.10-src/fs/hostfs/hostfs_user.c      2006-08-14 18:36:
> 24.276305632 +0800
> @@ -122,7 +122,6 @@
>         DIR *dir = stream;
>         struct dirent *ent;
>
> -       seekdir(dir, *pos);
>         ent = readdir(dir);
>         if(ent == NULL) return(NULL);
>         *len_out = strlen(ent->d_name);

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

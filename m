Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GBy8F-0000tQ-9b for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Aug 2006 11:22:47 -0700
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GBy8C-0005zd-AR
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Aug 2006 11:22:47 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sat, 12 Aug 2006 20:22:42 +0200
References: <39134b110608100842p5acdf798o807b48801ea9a706@mail.gmail.com>
In-Reply-To: <39134b110608100842p5acdf798o807b48801ea9a706@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608122022.42389.blaisorblade@yahoo.it>
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: wang lianwei <lianwei.wang@gmail.com>

On Thursday 10 August 2006 17:42, wang lianwei wrote:
> Hi all,
>
> There is a bug with UML kernel, some host directory can not be read, for
> example "ls /mnt/host/usr/lib", this command is dead until you press
> CTRL+c. I test it with Redhat Enterprise Linux 4.

Yes, this has been reported various times but difficult to reproduce, so we're 
very happy somebody diagnosed it, and I'd be interested in understanding it 
better.

On which filesystem (ext3, reiserfs, what else) lays /usr/lib on the host?

> This is because the UML read host directory through opendir, seekdir,
> readdir and telldir. When get the dir stream offset through telldir, it
> always return 0 on some directory, for example".",

Can you elaborate on this? (And if possible post some details, like a strace)

What I've understood is:

position 0 -> you read "." -> you call telldir -> it _again_ says you're at 0?

I can maybe understand why it could happen. I'd be more interested in checking 
if a simple sequence of readdir() calls (without seekdir()) would work 
(probably write a standalone test program, it will be easier to use and 
debug) and why read_dir needs to do seekdir (I think it's done to handle 
calls to seekdir by the underlying process, but there should be different 
ways to do it).

> I don't know why? But 
> we can fix it as follows although the next dir entry offset is not exact:

> Modify the fs/hostfs/hostfs_user.c file, update the read_dir function,
>
> char *read_dir(void *stream, unsigned long long *pos,
>                unsigned long long *ino_out, int *len_out)
> {
>         DIR *dir = stream;
>         struct dirent *ent;
>         unsigned long long oldpos;
>
>         oldpos = *pos;
>
>         seekdir(dir, *pos);
>         ent = readdir(dir);
>         if(ent == NULL)
>         {
>                 return(NULL);
>         }
>         *len_out = strlen(ent->d_name);
>         *ino_out = ent->d_ino;
>         *pos = telldir(dir);
>
>         /* Fix the telldir return 0 error */
>         if (*pos == 0)
>                 *pos = oldpos + *len_out;
>
>         return(ent->d_name);
> }
>
> although the next offset is not exact, but the readdir can get the next
> entry correct.

This probably depends heavily on the underlying filesystem...

> Can anyone give a better solution?

I can't yet, but maybe with your help we'll be able.
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
